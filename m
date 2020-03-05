Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD1017ADAD
	for <lists+linux-pci@lfdr.de>; Thu,  5 Mar 2020 18:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCER4W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Mar 2020 12:56:22 -0500
Received: from mga04.intel.com ([192.55.52.120]:52321 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgCER4W (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Mar 2020 12:56:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Mar 2020 09:56:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; 
   d="scan'208";a="352405217"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.25])
  by fmsmga001.fm.intel.com with ESMTP; 05 Mar 2020 09:56:21 -0800
Date:   Thu, 5 Mar 2020 09:56:20 -0800
From:   "Raj, Ashok" <ashok.raj@intel.com>
To:     Stanislav Spassov <stanspas@amazon.com>
Cc:     linux-pci@vger.kernel.org, Stanislav Spassov <stanspas@amazon.de>,
        linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sinan Kaya <okaya@kernel.org>, Rajat Jain <rajatja@google.com>,
        kbuild test robot <lkp@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v3 16/17] PCI: Add CRS handling to pci_dev_wait()
Message-ID: <20200305175620.GA94051@otc-nc-03>
References: <20200303132852.13184-1-stanspas@amazon.com>
 <20200303132852.13184-17-stanspas@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303132852.13184-17-stanspas@amazon.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Stanislav,

Thanks for doing this!


On Tue, Mar 03, 2020 at 02:28:51PM +0100, Stanislav Spassov wrote:
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
> is retried autonomously by the Root Port. Platform-specific configuration
> registers may exist to limit the number of or time taken by such retries.

Also when CRSV is enabled, config read that doesn't cover VENDOR is 
also retried automatically. 

> 
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
>  drivers/pci/pci.c | 52 +++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f1ba931b0ead..1a504419e0de 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1081,18 +1081,54 @@ static int pci_dev_wait(struct pci_dev *dev, enum pci_init_event event)
>  {
>  	const char *event_name = pci_init_event_name(event);
>  	int timeout = dev->reset_ready_poll_ms;
> +	int waited = 0;
> +	int rc = 0;
> +
>  
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

I like this check to read VENDOR_ID when crssv is enabled. But your patches
seems to define in patch13 and used in patch16?

can we keep them simple? and if possible just this would be a 
needed fix. We have some systems that we have found can cause
timeouts if CRSV is enabled, but you read any other register
other than the PCI_VENDOR.

Would prefer to see this fix before the other cleanups can stabilize :-)

I would also mark that for stable.

> +
> +		rc = pci_dev_poll_until_not_equal(dev, PCI_VENDOR_ID, 0xffff,
> +						  0x0001, event_name, timeout,
> +						  &waited, &id);
> +		if (rc)
> +			return rc;
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
