Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2B16B10E
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 21:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgBXUlN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 15:41:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbgBXUlN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 15:41:13 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C586420732;
        Mon, 24 Feb 2020 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582576872;
        bh=9HpRz3wCkRAprkBgLrClkpEQiYCiTzH9sD2PMAJ8WxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Rzo+8zckFzvOwrWod5XkHBeTIcS/EycjK0Sh6SNwWDIe2V65nVByac/Vl/zDzqQAZ
         P2pZIeuEuMK2Z3RL1QLDcJbqxhFGY3SjGcT+3tDKgplO8GVa/cisvOwmMLJFIVJ4Xx
         fq+b1UqEki1Wrz3ZqRC7nONoSJlo8Wn2WiMfCvFQ=
Date:   Mon, 24 Feb 2020 14:41:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Wei Wang <wawei@amazon.de>, Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH 3/3] PCI: Add CRS handling to pci_dev_wait()
Message-ID: <20200224204109.GA221513@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223122057.6504-4-stanspas@amazon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Ashok, Alex, Sinan, Rajat]

On Sun, Feb 23, 2020 at 01:20:57PM +0100, Stanislav Spassov wrote:
> From: Stanislav Spassov <stanspas@amazon.de>
> 
> The PCI Express specification dictates minimal amounts of time that the
> host needs to wait after triggering different kinds of resets before it
> is allowed to attempt accessing the device. After this waiting period,
> devices are required to be responsive to Configuration Space reads.
> However, if a device needs more time to actually complete the reset
> operation internally, it may respond to the read with a Completion
> Request Retry Status (CRS), and keep doing so on subsequent reads
> for as long as necessary. If the device is broken, it may even keep
> responding with CRS indefinitely.
> 
> The specification also mandates that any Root Port that supports CRS
> and has CRS Software Visibility (CRS SV) enabled will synthesize the
> special value 0x0001 for the Vendor ID and set any other bits to 1
> upon receiving a CRS Completion for a Configuration Read Request that
> includes both bytes of the Vendor ID (offset 0).
> 
> IF CRS is supported by Root Port but CRS SV is not enabled, the request
> is retried autonomosly by the Root Port. Platform-specific configuration
> registers may exist to limit the number of or time taken by such retries.

s/autonomosly/autonomously/

> If CRS is not supported, or a different register (not Vendor ID) is
> polled, or the device is responding with CA/UR Completions (rather than
> CRS), the behavior is platform-dependent, but generally the Root Port
> synthesizes ~0 to complete the software read.
> 
> Previously, pci_dev_wait() avoided taking advantage of CRS. However,
> on platforms where no limit/timeout can be configured as explained
> above, a device responding with CRS for too long (e.g. because it is
> stuck and cannot complete its reset) may trigger more severe error
> conditions (e.g. TOR timeout, 3-strike CPU CATERR), because the Root
> Port never reports back to the lower-level component requesting the
> transaction.
> 
> This patch introduces special handling when CRS is available, and
> otherwise falls back to the previous behavior of polling COMMAND.
> 
> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  drivers/pci/pci.c | 128 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 105 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a554818968ed..e8bce8da9402 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1041,44 +1041,126 @@ static int pci_dev_get_reset_ready_poll_ms(struct pci_dev *dev)
>  	return pcie_reset_ready_poll_ms;
>  }
>  
> -static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
> +static bool pci_crs_sv_enabled(struct pci_dev *dev)
> +{
> +	struct pci_dev *root_port = pcie_find_root_port(dev);
> +	u16 root_control;
> +
> +	if (!root_port)
> +		return false;
> +
> +	if (pcie_capability_read_word(root_port, PCI_EXP_RTCTL, &root_control))
> +		return false;
> +
> +	return root_control & PCI_EXP_RTCTL_CRSSVE;

Can we just cache this bit somewhere when we enable CRS SV?

> +}
> +
> +static int pci_dev_poll_until_ready(struct pci_dev *dev,
> +				    int where,
> +				    u32 mask,
> +				    u32 bad_value,
> +				    char *event,
> +				    int timeout, int *waited,
> +				    u32 *final_value)

Follow formatting conventions (fill lines instead of each arg on a
separate line).

>  {
> -	int timeout = pci_dev_get_reset_ready_poll_ms(dev);
>  	int delay = 1;
> -	u32 id;
> +	u32 value;
>  
> -	/*
> -	 * After reset, the device should not silently discard config
> -	 * requests, but it may still indicate that it needs more time by
> -	 * responding to them with CRS completions.  The Root Port will
> -	 * generally synthesize ~0 data to complete the read (except when
> -	 * CRS SV is enabled and the read was for the Vendor ID; in that
> -	 * case it synthesizes 0x0001 data).
> -	 *
> -	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
> -	 */
> -	pci_read_config_dword(dev, PCI_COMMAND, &id);
> -	while (id == ~0) {
> +	if (!event)
> +		event = "<unknown event>";
> +
> +	if (pci_read_config_dword(dev, where, &value))
> +		return -ENOTTY;
> +
> +	while ((value & mask) == bad_value) {
>  		if (delay > timeout) {
>  			pci_warn(dev, "not ready %dms after %s; giving up\n",
> -				 delay - 1, reset_type);
> -			return -ENOTTY;
> +				 delay - 1, event);
> +			return -ETIMEDOUT;
>  		}
>  
>  		if (delay > 1000)
>  			pci_info(dev, "not ready %dms after %s; waiting\n",
> -				 delay - 1, reset_type);
> +				 delay - 1, event);
>  
>  		msleep(delay);
>  		delay *= 2;
> -		pci_read_config_dword(dev, PCI_COMMAND, &id);
> +
> +		if (pci_read_config_dword(dev, where, &value))
> +			return -ENOTTY;
>  	}
>  
>  	if (delay > 1000)
> -		pci_info(dev, "ready %dms after %s\n", delay - 1,
> -			 reset_type);
> +		pci_info(dev, "ready %dms after %s\n", delay - 1, event);
> +
> +	if (waited)
> +		*waited = delay - 1;
> +
> +	if (final_value)
> +		*final_value = value;
> +
> +	return 0;
> +}
> +
> +static int pci_dev_wait_crs(struct pci_dev *dev, char *reset_type,
> +			    int timeout, int *waited, u32 *id)
> +{
> +	return pci_dev_poll_until_ready(dev, PCI_VENDOR_ID, 0xffff, 0x0001,
> +					reset_type, timeout, waited, id);
> +}
> +
> +static int pci_dev_wait(struct pci_dev *dev, char *reset_type)
> +{
> +	int timeout = pci_dev_get_reset_ready_poll_ms(dev);
> +	int waited = 0;
> +
> +	/*
> +	 * After reset, the device should not silently discard config
> +	 * requests, but it may still indicate that it needs more time by
> +	 * responding to them with CRS completions. For such completions:
> +	 * - If CRS SV is enabled on the Root Port, and the read request
> +	 *   covers both bytes of the Vendor ID register, the Root Port
> +	 *   will synthesize the value 0x0001 (and set any extra requested
> +	 *   bytes to 0xff)
> +	 * - If CRS SV is not enabled on the Root Port, the Root Port must
> +	 *   re-issue the Configuration Request as a new Request.
> +	 *   Depending on platform-specific Root Complex configurations,
> +	 *   the Root Port may stop retrying after a set number of attempts,
> +	 *   or a configured timeout is hit, or continue indefinitely
> +	 *   (ultimately resulting in non-PCI-specific errors, such as a
> +	 *   TOR timeout).
> +	 */
> +	if (pci_crs_sv_enabled(dev)) {
> +		u32 id;
> +
> +		if (pci_dev_wait_crs(dev, reset_type, timeout, &waited, &id))
> +			return -ENOTTY;
> +
> +		timeout -= waited;
> +
> +		/*
> +		 * If Vendor/Device ID is valid, the device must be ready.
> +		 * Note: SR-IOV VFs return ~0 for reads to Vendor/Device
> +		 * ID and will not be recognized as ready by this check.
> +		 */
> +		if (id != 0x0000ffff && id != 0xffff0000 &&
> +		    id != 0x00000000 && id != 0xffffffff)
> +			return 0;
> +	}
> +
> +	/*
> +	 * Root Ports will generally indicate error scenarios (e.g.
> +	 * internal timeouts, or received Completion with CA/UR) by
> +	 * synthesizing an 'all bits set' value (~0).
> +	 * In case CRS is not supported/enabled, as well as for SR-IOV VFs,
> +	 * fall back to polling a different register that cannot validly
> +	 * contain ~0. As of PCIe 5.0, bits 11-15 of COMMAND are still RsvdP
> +	 * and must return 0 when read.
> +	 * XXX: These bits might become meaningful in the future
> +	 */
> +	if (pci_dev_poll_until_ready(dev, PCI_COMMAND, ~0, ~0,
> +				     reset_type, timeout, NULL, NULL))

I think the use of PCI_COMMAND in the existing pci_dev_wait() is a
little questionable.  I *think* it's there because we assumed that VFs
did not have to respond with CRS, but I don't think that assumption
was correct -- VFs *should* respond with CRS if they're not ready.

This use of PCI_COMMAND was added by 5adecf817dd6 ("PCI: Wait for up
to 1000ms after FLR reset") [1], and I'd like to resolve this question
before further complicating this path.  5adecf817dd6 refers to an
Intel integrated graphics device.  If that device doesn't handle CRS
correctly, maybe we need some sort of device-specific quirk for it?

[1] https://git.kernel.org/linus/5adecf817dd6

> +		return -ENOTTY;
>  
>  	return 0;
>  }
