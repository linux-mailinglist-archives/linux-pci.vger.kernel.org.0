Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5C2409863
	for <lists+linux-pci@lfdr.de>; Mon, 13 Sep 2021 18:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbhIMQJC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Sep 2021 12:09:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245040AbhIMQJC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Sep 2021 12:09:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 401E960698;
        Mon, 13 Sep 2021 16:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631549266;
        bh=Imgjy5EVXp0y5KoFiKrB9qqq1NS7R3Eo1LX6lgCUqYc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LsiXPQHYqOG1wxQsURnZvEzGGM+g37M62Fq4t9otdX3n6LaDwDrLbIdAO5EHBk0sX
         k55IW7r6KZ8ILD37d+DakQ0oQKKHoRoQwAWne7iU8P6tyMnLEG8IJjMG3M2sOORl/G
         dbfEPRpCdIM83KZeW8K4138Ow192VN36RcwCIyfZs7gBKLf1cfbK7Yh2FKfrxs1nGa
         /aNMlawb9xVRK0+S4gO75Bp+h9XLGNQVLfxl6UScc0MNc6os1gif4DRZqtBnQ+Q72o
         iJTx35+uKU7gh0OpnR31qePv7ifq3OIBJL96zEJ9GvtcVz326NgcuiGNBHNiFMLben
         fDKZG6JvGnzjw==
Date:   Mon, 13 Sep 2021 11:07:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Ashok Raj <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4 3/3] PCI: Add CRS handling to pci_dev_wait()
Message-ID: <20210913160745.GA1329939@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307172044.29645-4-stanspas@amazon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 07, 2020 at 06:20:44PM +0100, Stanislav Spassov wrote:
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
> If CRS SV is disabled or a different register (not Vendor ID) is being
> read, the request is retried autonomously by the Root Port.
> Platform-specific configuration registers may exist to limit the number
> of or time taken by such retries.
> 
> If CRS is not supported, or a device is responding with CA/UR
> Completions (rather than CRS), the behavior is platform-dependent, but
> generally the Root Port synthesizes ~0 to complete the software read.
> 
> Previously, pci_dev_wait() avoided taking advantage of CRS. However,
> on platforms where no retry limit/timeout can be configured, a device
> responding with CRS for too long (e.g. because it is stuck and cannot
> complete its reset) may trigger more severe error conditions (e.g. TOR
> timeout, 3-strike CPU CATERR), because the Root Port never reports back
> to the lower-level component requesting the transaction.
> 
> This patch introduces special handling when CRS is available, and
> otherwise falls back to the previous behavior of polling COMMAND.

There's a lot to figure out here.

1) It sounds like this *might* be a workaround for a device defect?
   Should we infer that there's a device where:

    - We reset the device
    - We read PCI_COMMAND until it is not ~0, for up to 60 seconds
    - The device returns CRS status for each read, until ...
    - The platform hardware times out before 60 seconds and fails the
      transaction, causing a system crash?

   But reading PCI_VENDOR_ID instead of PCI_COMMAND somehow avoids the
   platform timeout?

2) I think this should somehow be integrated with pci_bus_wait_crs(),
   which also loops looking for CRS status.

3) pci_bus_wait_crs() is used in the enumeration path, and we do a
   32-bit read there, which reads both the Vendor ID and the Device
   ID.  Maybe that's some sort of micro-optimization, but apparently
   there are devices that don't implement CRS SV correctly (see
   89665a6a7140 ("PCI: Check only the Vendor ID to identify
   Configuration Request Retry"), and doing a 16-bit read would avoid
   that issue.

   For pci_dev_wait(), I don't think there's any point in doing a
   32-bit read, so maybe we should just do a 16-bit read.

> Signed-off-by: Stanislav Spassov <stanspas@amazon.de>
> ---
>  drivers/pci/pci.c | 55 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 47 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 44f5d4907db6..a028147f4471 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1073,17 +1073,56 @@ static inline int pci_dev_poll_until_not_equal(struct pci_dev *dev, int where,
>  
>  static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
>  {
> +	int waited = 0;
> +	int rc = 0;
> +
> +
>  	/*
>  	 * After reset, the device should not silently discard config
>  	 * requests, but it may still indicate that it needs more time by
> -	 * responding to them with CRS completions.  The Root Port will
> -	 * generally synthesize ~0 data to complete the read (except when
> -	 * CRS SV is enabled and the read was for the Vendor ID; in that
> -	 * case it synthesizes 0x0001 data).
> -	 *
> -	 * Wait for the device to return a non-CRS completion.  Read the
> -	 * Command register instead of Vendor ID so we don't have to
> -	 * contend with the CRS SV value.
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
> +	 *   (ultimately resulting in non-PCI-specific platform errors, such as
> +	 *   a TOR timeout).
> +	 */
> +	if (dev->crssv_enabled) {
> +		u32 id;
> +
> +		rc = pci_dev_poll_until_not_equal(dev, PCI_VENDOR_ID, 0xffff,
> +						  0x0001, reset_type, timeout,
> +						  &waited, &id);
> +		if (rc)
> +			return rc;
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
>  	 */
>  	return pci_dev_poll_until_not_equal(dev, PCI_COMMAND, ~0, ~0,
>  					    reset_type, timeout, NULL,
> -- 
> 2.25.1
> 
> 
> 
> 
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
> 
> 
> 
