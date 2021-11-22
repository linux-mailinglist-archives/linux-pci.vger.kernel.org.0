Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598124594E1
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbhKVSrA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:47:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhKVSrA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 13:47:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD2516052B;
        Mon, 22 Nov 2021 18:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637606633;
        bh=iQ+8WwXuGwrBc62nrAsZJ2L8766olCwodMARbelPUP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hztoRRD7PHIDbZE5E6fQmmU5TdNMMsu4BnknxInGKEaqL8tdSjWxtFLIa7GXM8D1b
         yO8ba3qT4P6uF3HoAvff/D1pUkIBGeqPIfTurbE/aBVCYRgBiTpsz2T9rYI0BtZ4wT
         nnuAv2eDb8cAixErUfHzhGG+gPq7hpaChvpkcB/+KUOjC8Tj6lH4mkc3bAczzSEkjb
         J3SffRcJKUSsedzvhDFbnxmLL7J78jpMRPFpAZmzvWdFJ114wE6xVUndhL8I7zt9Q8
         8yZEsVc05U3HAki96xEcHfbAek+MVVyLgBuJWyINDSE0a3dxJWKGSjTrARBKDispEf
         vF1Ld3t3weg+Q==
Date:   Mon, 22 Nov 2021 12:43:51 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, mgross@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] platform/x86/intel: Move intel_pmt from MFD to
 Auxiliary Bus
Message-ID: <20211122184351.GA2160551@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211120231705.189969-4-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Nov 20, 2021 at 03:17:04PM -0800, David E. Box wrote:
> Intel Platform Monitoring Technology (PMT) support is indicated by
> presence of an Intel defined PCIe Designated Vendor Specific Extended
> Capabilities (DVSEC) structure with a PMT specific ID. The current MFD
> implementation creates child devices for each PMT feature, currently
> telemetry and crashlog. 

Apparently "watcher," too?

> However DVSEC structures may also be used by Intel to indicate
> support for other features. The Out Of Band Management Services
> Module (OOBMSM) 

OOBMSM refers to something outside this series?  Oh, I see ... looks
like that's a specific device (PCI_DEVICE_ID_INTEL_VSEC_OOBMSM).

> uses DVSEC to enumerate several features,
> including PMT.  In order to support them it is necessary to modify the
> intel_pmt driver to handle the creation of the child devices more
> generically.  Additionally, since these are not platform devices (which
> is what MFD is really intended for) move the implementation to the more
> appropriate Auxiliary bus and host in platform/x86/intel.

It'd be useful to mention *why* the auxiliary bus is more appropriate.
It's not obvious to me.

> Also, rename
> the driver from intel_pmt to intel_vsec to better reflect the purpose.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>

> -static int pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> -{
> - ...
> -
> -	pm_runtime_put(&pdev->dev);
> -	pm_runtime_allow(&pdev->dev);

What happened to this runtime PM functionality?  Is it no longer
needed when using the auxiliary bus?  I don't see corresponding
functionality there.

> -	return 0;
> -}
> -
> -static void pmt_pci_remove(struct pci_dev *pdev)
> -{
> -	pm_runtime_forbid(&pdev->dev);
> -	pm_runtime_get_sync(&pdev->dev);
> -}

> +static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
> +			   unsigned long quirks)
> +{
> + ...
> +	res = kcalloc(header->num_entries, sizeof(*res), GFP_KERNEL);
> +	if (!res) {
> +		kfree(intel_vsec_dev);
> +		return -ENOMEM;
> +	}
> +
> +	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
> +		header->offset >>= TABLE_OFFSET_SHIFT;
> +
> +	/*
> +	 * The DVSEC/VSEC contains the starting offset and count for a block of
> +	 * discovery tables. Create a resource list of these tables to the
> +	 * auxiliary device driver.

"res" looks like an array of resources, not a list, i.e., I don't see
any ->next pointers here.

> +	 */
> +	for (i = 0, tmp = res; i < header->num_entries; i++, tmp++) {
> +		tmp->start = pdev->resource[header->tbir].start +
> +			     header->offset + i * (header->entry_size * sizeof(u32));
> +		tmp->end = tmp->start + (header->entry_size * sizeof(u32)) - 1;
> +		tmp->flags = IORESOURCE_MEM;
> +	}
> +
> +	intel_vsec_dev->pcidev = pdev;
> +	intel_vsec_dev->resource = res;
> +	intel_vsec_dev->num_resources = header->num_entries;
> +	intel_vsec_dev->quirks = quirks;
> +	intel_vsec_dev->ida = &intel_vsec_ida;
> +
> +	return intel_vsec_add_aux(pdev, intel_vsec_dev, intel_vsec_name(header->id));
> +}

> +/* TGL info */
> +static const struct intel_vsec_platform_info tgl_info = {
> +	.quirks = VSEC_QUIRK_NO_WATCHER | VSEC_QUIRK_NO_CRASHLOG | VSEC_QUIRK_TABLE_SHIFT,
> +};

I guess these are essentially device defects, i.e., TGL advertises
watcher and crashlog via VSEC, but doesn't actually support them?

> +#define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
> +#define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
> +#define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
> +#define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
> +static const struct pci_device_id intel_vsec_pci_ids[] = {
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, NULL) },
> +	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },

IIUC, you're implicitly saying that only these listed Device IDs can
have these VSEC capabilities, or at least, that these VSEC-described
features are only supported on these Device IDs.

That's not the way PCI capabilities work in general, so this doesn't
feel like a perfect fit to me, but I guess it's probably the only way
to identify the devices you care about.

Bjorn
