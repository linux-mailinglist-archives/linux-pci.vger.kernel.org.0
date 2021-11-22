Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651A1459848
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 00:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhKVXMy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 18:12:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:49624 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229619AbhKVXMx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 18:12:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="234851984"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="234851984"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 15:09:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="497053520"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2021 15:09:46 -0800
Received: from xwu17-mobl1.amr.corp.intel.com (xwu17-mobl1.amr.corp.intel.com [10.212.223.69])
        by linux.intel.com (Postfix) with ESMTP id E7488580418;
        Mon, 22 Nov 2021 15:09:45 -0800 (PST)
Message-ID: <3b9935baf114dac8426e33f116e43e7fb19e607f.camel@linux.intel.com>
Subject: Re: [PATCH 3/4] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Date:   Mon, 22 Nov 2021 15:09:45 -0800
In-Reply-To: <20211122184351.GA2160551@bhelgaas>
References: <20211122184351.GA2160551@bhelgaas>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 2021-11-22 at 12:43 -0600, Bjorn Helgaas wrote:
> On Sat, Nov 20, 2021 at 03:17:04PM -0800, David E. Box wrote:
> > Intel Platform Monitoring Technology (PMT) support is indicated by
> > presence of an Intel defined PCIe Designated Vendor Specific Extended
> > Capabilities (DVSEC) structure with a PMT specific ID. The current MFD
> > implementation creates child devices for each PMT feature, currently
> > telemetry and crashlog. 
> 
> Apparently "watcher," too?

Yes.

> 
> > However DVSEC structures may also be used by Intel to indicate
> > support for other features. The Out Of Band Management Services
> > Module (OOBMSM) 
> 
> OOBMSM refers to something outside this series?  Oh, I see ... looks
> like that's a specific device (PCI_DEVICE_ID_INTEL_VSEC_OOBMSM).

Yes

> 
> > uses DVSEC to enumerate several features,
> > including PMT.  In order to support them it is necessary to modify the
> > intel_pmt driver to handle the creation of the child devices more
> > generically.  Additionally, since these are not platform devices (which
> > is what MFD is really intended for) move the implementation to the more
> > appropriate Auxiliary bus and host in platform/x86/intel.
> 
> It'd be useful to mention *why* the auxiliary bus is more appropriate.
> It's not obvious to me.

Sure I'll add this.

> 
> > Also, rename
> > the driver from intel_pmt to intel_vsec to better reflect the purpose.
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > Reviewed-by: Mark Gross <markgross@kernel.org>
> > -static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id
> > *id)
> > -{
> > - ...
> > -
> > -	pm_runtime_put(&pdev->dev);
> > -	pm_runtime_allow(&pdev->dev);
> 
> What happened to this runtime PM functionality?  Is it no longer
> needed when using the auxiliary bus?  I don't see corresponding
> functionality there.

I need to add a comment for this. Support will be added back when a device is
added that needs it. Current devices do not.

> 
> > -	return 0;
> > -}
> > -
> > -static void pmt_pci_remove(struct pci_dev *pdev)
> > -{
> > -	pm_runtime_forbid(&pdev->dev);
> > -	pm_runtime_get_sync(&pdev->dev);
> > -}
> > +static int intel_vsec_add_dev(struct pci_dev *pdev, struct
> > intel_vsec_header *header,
> > +			   unsigned long quirks)
> > +{
> > + ...
> > +	res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
> > +	if (!res) {
> > +		kfree(intel_vsec_dev);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
> > +		header->offset >>= TABLE_OFFSET_SHIFT;
> > +
> > +	/*
> > +	 * The DVSEC/VSEC contains the starting offset and count for a block of
> > +	 * discovery tables. Create a resource list of these tables to the
> > +	 * auxiliary device driver.
> 
> "res" looks like an array of resources, not a list, i.e., I don't see
> any ->next pointers here.

Yes. Sorry I used "list" loosely.

> 
> > +	 */
> > +	for (i = 0, tmp = res; i < header->num_entries; i++, tmp++) {
> > +		tmp->start = pdev->resource[header->tbir].start +
> > +			     header->offset + i * (header->entry_size *
> > sizeof(u32));
> > +		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
> > +		tmp->flags = IORESOURCE_MEM;
> > +	}
> > +
> > +	intel_vsec_dev->pcidev = pdev;
> > +	intel_vsec_dev->resource = res;
> > +	intel_vsec_dev->num_resources = header->num_entries;
> > +	intel_vsec_dev->quirks = quirks;
> > +	intel_vsec_dev->ida = &intel_vsec_ida;
> > +
> > +	return intel_vsec_add_aux(pdev, intel_vsec_dev, intel_vsec_name(header-
> > >id));
> > +}
> > +/* TGL info */
> > +static const struct intel_vsec_platform_info tgl_info = {
> > +	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG |
> > VSEC_QUIRK_TABLE_SHIFT,
> > +};
> 
> I guess these are essentially device defects, i.e., TGL advertises
> watcher and crashlog via VSEC, but doesn't actually support them?

That's correct. There were several deviations in implementation between the
first devices and this is how they were resolved. The OOBMSM device doesn't
require any of these workarounds, hence why it provides no info. Though we may
use this structure in the future for actual platform data.

> 
> > +#define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
> > +#define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
> > +#define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
> > +#define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
> > +static const struct pci_device_id intel_vsec_pci_ids[] = {
> > +	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
> > +	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
> > +	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, NULL) },
> > +	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
> 
> IIUC, you're implicitly saying that only these listed Device IDs can
> have these VSEC capabilities, or at least, that these VSEC-described
> features are only supported on these Device IDs.

Yes and yes.

> 
> That's not the way PCI capabilities work in general, so this doesn't
> feel like a perfect fit to me, but I guess it's probably the only way
> to identify the devices you care about.

Understood.

David

> 
> Bjorn

