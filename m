Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150F27C7271
	for <lists+linux-pci@lfdr.de>; Thu, 12 Oct 2023 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379512AbjJLQZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 12:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344015AbjJLQZQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 12:25:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357BC6;
        Thu, 12 Oct 2023 09:25:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A62C433C8;
        Thu, 12 Oct 2023 16:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697127914;
        bh=jhs8ocEdk0H8R7hydf3+ylgi+ceFyylN7MYk7og3q2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Oiq8SU7bWFp3/+Zz1L2IIfOEgEFdISzkAr1MLzwI+DHW3lv3JkNOn+lfHrrUngOR0
         ZtWDjzLSDlrdOJeR5/qXXJIfMeWClcsQ9EPWVURatNa3/jfpXh63hJRIKEihZlP0Zc
         B5YFjX5wHduKITGsFrkoYE6WykCp5SJrJWWn86njNQGVRGUd8j/xEuHrGzYfOidIuD
         CrUPBejr3vcLbixFKzn0eVW+hycNmO//7j2mWzsaRLgRaPmwlNlPOoc1UScTqxPTJW
         fPXWLuk8Obn60f6KtR/VfH+Ef+hGyhwV+ydjLsFwQEsZIGlo7UUJZrDkC31NPpIcUE
         upgmAkgDUyPmQ==
Date:   Thu, 12 Oct 2023 11:25:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v7 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231012162512.GA1069387@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012032856.2640-4-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 12, 2023 at 11:28:55AM +0800, Shuai Xue wrote:
> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is not a PCIe
> Root Complex integrated End Point(RCiEP) device but only register counters
> provided by each PCIe Root Port.
> 
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
> 
> - Time Based Analysis (RX/TX data throughput and time spent in each
>   low-power LTSSM state)
> - Event counters (Error and Non-Error for lanes)
> 
> Note, only one counter for each type and does not overflow interrupt.

Not sure what "does not overflow interrupt" means.  Does it mean
there's no interrupt generated when the counter overflows?

> +config DWC_PCIE_PMU
> +	tristate "Enable Synopsys DesignWare PCIe PMU Support"

The DWC_PCIE_PMU symbol and the "Synopsys DesignWare PCIe PMU" text
suggest that this is generic and should work on any designs based on
DesignWare IP, not just the Alibaba devices.

It appears that the current driver only supports Alibaba devices
because it only looks at Root Ports with PCI_VENDOR_ID_ALIBABA, but I
assume support for non-Alibaba devices is likely to be added in the
future?

If it is really generic for DesignWare-based devices the config symbol
and menu entry seem fine.

Maybe mention the vendor (Synopsys or Alibaba) first in the menu
entry, though, since that's what most other drivers do, e.g.,

  tristate "Synopsys DesignWare PCIe PMU"

> +	depends on (ARM64 && PCI)

I don't see any actual ARM64 dependency in the code, so maybe omit
ARM64 (as PCIE_DW_PLAT_HOST does) or add "|| COMPILE_TEST"?

> +	help
> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
> +	  monitoring event on platform including the Yitian 710.

Should this mention Alibaba or T-Head?  I don't know how
Alibaba/T-Head/Yitian are all related.

> + * Put them togother as TRM used.

s/togother/together/

Maybe "Put them together as in TRM."?

> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)				\
> +	(&((struct dwc_pcie_format_attr[]) {{					\
> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),	\
> +		.config = _cfg,							\
> +		.field = _fld,							\
> +	}})[0].attr.attr)

Seems weird to put the \ characters in column 81 where they make
everything wrap unnecessarily on a 80-column terminal.  I guess it
just happens to be where a tab after the longest line ends up.

> +static void dwc_pcie_pmu_unregister_pmu(void *data)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = data;
> +
> +	if (!pcie_pmu->registered)
> +		return;
> +
> +	perf_pmu_unregister(&pcie_pmu->pmu);
> +	pcie_pmu->registered = false;
> +}
> +
> +/*
> + * Find the PMU of a PCI device.
> + * @pdev: The PCI device.
> + */
> +static struct dwc_pcie_pmu *dwc_pcie_find_dev_pmu(struct pci_dev *pdev)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu, *tmp;
> +
> +	list_for_each_entry_safe(pcie_pmu, tmp, &dwc_pcie_pmu_head, pmu_node) {
> +		if (pcie_pmu->pdev == pdev) {
> +			list_del(&pcie_pmu->pmu_node);

Seems sort of weird to have a "find_dev" function actually *remove*
the entry.  The entry was added to the list near the
perf_pmu_register(), so maybe consider removing it in the caller or
near the perf_pmu_unregister().  Maybe also reorder the functions as:

  dwc_pcie_find_dev_pmu
  dwc_pcie_pmu_unregister_pmu
  dwc_pcie_pmu_notifier

since dwc_pcie_find_dev_pmu() is a less interesting helper function.

> +			return pcie_pmu;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct dwc_pcie_pmu *pcie_pmu;
> +
> +	/* Unregister the PMU when the device is going to be deleted. */
> +	if (action != BUS_NOTIFY_DEL_DEVICE)
> +		return NOTIFY_DONE;
> +
> +	pcie_pmu = dwc_pcie_find_dev_pmu(pdev);
> +	if (!pcie_pmu)
> +		return NOTIFY_DONE;
> +
> +	dwc_pcie_pmu_unregister_pmu(pcie_pmu);
> +
> +	return NOTIFY_OK;
> +}

> +	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
> +	for_each_pci_dev(pdev) {
> +		u16 vsec;
> +		u32 val;
> +
> +		if (!(pci_is_pcie(pdev) &&
> +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
> +			continue;
> +
> +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
> +						DWC_PCIE_VSEC_RAS_DES_ID);
> +		if (!vsec)
> +			continue;
> +
> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +		if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
> +		    PCI_VNDR_HEADER_LEN(val) != 0x100)
> +			continue;
> +		pci_dbg(pdev,
> +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
> +
> +		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +		name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x",
> +				      bdf);
> +		if (!name) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		/* All checks passed, go go go */
> +		pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +		if (!pcie_pmu) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +
> +		pcie_pmu->pdev = pdev;
> +		pcie_pmu->ras_des = vsec;

Looks like "ras_des" is the offset of a RAS DES Capability, and we
only use the Vendor-specific DWC_PCIE_VSEC_RAS_DES_ID Capability to
learn the RAS DES offset?

That seems a little convoluted and unnecessarily Alibaba-specific.  A
more generic way to do this would be for the RAS DES registers to be
in a Designated Vendor-Specific Capability with DVSEC Vendor ID of
PCI_VENDOR_ID_SYNOPSYS and a Synopsys-defined DVSEC ID that identifies
RAS DES.

Then we could use pci_find_dvsec_capability() to find the RAS DES
Capability directly without the Alibaba dependency.  Obviously this
would only work if the hardware/firmware design supports it, and I
assume the Synopsis IP wasn't designed that way.

Bjorn
