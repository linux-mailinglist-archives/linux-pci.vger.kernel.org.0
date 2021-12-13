Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC7D4733F9
	for <lists+linux-pci@lfdr.de>; Mon, 13 Dec 2021 19:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhLMS2y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Dec 2021 13:28:54 -0500
Received: from mga03.intel.com ([134.134.136.65]:61668 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241855AbhLMS2x (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Dec 2021 13:28:53 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="238742969"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="238742969"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:28:52 -0800
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="463477445"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 10:28:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1mwq3E-005ink-4L;
        Mon, 13 Dec 2021 20:27:52 +0200
Date:   Mon, 13 Dec 2021 20:27:51 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH V3 3/6] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
Message-ID: <YbeQpyIijHbPHktN@smile.fi.intel.com>
References: <20211213175921.1897860-1-david.e.box@linux.intel.com>
 <20211213175921.1897860-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213175921.1897860-4-david.e.box@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 13, 2021 at 09:59:18AM -0800, David E. Box wrote:
> Intel Platform Monitoring Technology (PMT) support is indicated by presence
> of an Intel defined PCIe Designated Vendor Specific Extended Capabilities
> (DVSEC) structure with a PMT specific ID. The current MFD implementation
> creates child devices for each PMT feature, currently telemetry, watcher,
> and crashlog. However DVSEC structures may also be used by Intel to
> indicate support for other features. The Out Of Band Management Services
> Module (OOBMSM) uses DVSEC to enumerate several features, including PMT.
> In order to support them it is necessary to modify the intel_pmt driver to
> handle the creation of the child devices more generically. To that end,
> modify the driver to create child devices for any VSEC/DVSEC features on
> supported devices (indicated by PCI ID).  Additionally, move the
> implementation from MFD to the Auxiliary bus.  VSEC/DVSEC features are
> really multifunctional PCI devices, not platform devices as MFD was
> designed for. Auxiliary bus gives more flexibility by allowing the
> definition of custom structures that can be shared between associated
> auxiliary devices and the parent device. Also, rename the driver from
> intel_pmt to intel_vsec to better reflect the purpose.
> 
> This series also removes the current runtime pm support which was not
> complete to begin with. None of the current devices require runtime pm.
> However the support will be replaced when a device is added that requires
> it.

...

> +static bool intel_vsec_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
> +{
> +	bool have_devices = false;
> +	int pos = 0;
> +
> +	do {
> +		struct intel_vsec_header header;
> +		u32 table, hdr;
> +		u16 vid;
> +		int ret;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> +		if (!pos)
> +			break;
> +
> +		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER1, &hdr);
> +		vid = PCI_DVSEC_HEADER1_VID(hdr);
> +		if (vid != PCI_VENDOR_ID_INTEL)
> +			continue;
> +
> +		/* Support only revision 1 */
> +		header.rev = PCI_DVSEC_HEADER1_REV(hdr);
> +		if (header.rev != 1) {
> +			dev_info(&pdev->dev, "Unsupported DVSEC revision %d\n", header.rev);
> +			continue;
> +		}
> +
> +		header.length = PCI_DVSEC_HEADER1_LEN(hdr);
> +
> +		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES, &header.num_entries);
> +		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE, &header.entry_size);
> +		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE, &table);
> +
> +		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
> +		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
> +
> +		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
> +		header.id = PCI_DVSEC_HEADER2_ID(hdr);
> +
> +		ret = intel_vsec_add_dev(pdev, &header, quirks);
> +		if (ret)
> +			continue;
> +
> +		have_devices = true;
> +	} while (true);
> +
> +	return have_devices;
> +}
> +
> +static bool intel_vsec_walk_vsec(struct pci_dev *pdev, unsigned long quirks)
> +{
> +	bool have_devices = false;
> +	int pos = 0;
> +
> +	do {
> +		struct intel_vsec_header header;
> +		u32 table, hdr;
> +		int ret;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_VNDR);
> +		if (!pos)
> +			break;
> +
> +		pci_read_config_dword(pdev, pos + PCI_VNDR_HEADER, &hdr);
> +
> +		/* Support only revision 1 */
> +		header.rev = PCI_VNDR_HEADER_REV(hdr);
> +		if (header.rev != 1) {
> +			dev_info(&pdev->dev, "Unsupported VSEC revision %d\n", header.rev);
> +			continue;
> +		}
> +
> +		header.id = PCI_VNDR_HEADER_ID(hdr);
> +		header.length = PCI_VNDR_HEADER_LEN(hdr);
> +
> +		/* entry, size, and table offset are the same as DVSEC */
> +		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES, &header.num_entries);
> +		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE, &header.entry_size);
> +		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE, &table);
> +
> +		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
> +		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
> +
> +		ret = intel_vsec_add_dev(pdev, &header, quirks);
> +		if (ret)
> +			continue;
> +
> +		have_devices = true;
> +	} while (true);
> +
> +	return have_devices;
> +}


I'm wondering if it makes sense to refactor each of the above to something like

int intel_vsec_extract_vsec(...)
{
	...
}

static bool intel_vsec_walk_dvsec(struct pci_dev *pdev, unsigned long quirks)
{
	bool have_devices = false;
	int pos;

	while ((pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC))) {
		if (intel_vsec_extract_vsec())
			continue;

		have_devices = true;
	}

	return have_devices;
}

Either way, it may be worth to convert infinite loops to ones with the clear
exit condition.

...

> +	/*
> +	 * Driver cleanup handled by intel_vsec_remove_aux() which is added
> +	 * to the pci device as a devm action

PCI

Grammatical period at the end.

> +	 */

-- 
With Best Regards,
Andy Shevchenko


