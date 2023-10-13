Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EA97C7C48
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 05:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjJMDqw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Oct 2023 23:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJMDqv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Oct 2023 23:46:51 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42F6BB;
        Thu, 12 Oct 2023 20:46:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vu0gIP._1697168804;
Received: from 30.240.114.194(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vu0gIP._1697168804)
          by smtp.aliyun-inc.com;
          Fri, 13 Oct 2023 11:46:46 +0800
Message-ID: <a2265967-5088-7f17-35e5-29bf1c85c15f@linux.alibaba.com>
Date:   Fri, 13 Oct 2023 11:46:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v7 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231012162512.GA1069387@bhelgaas>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231012162512.GA1069387@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/13 00:25, Bjorn Helgaas wrote:
> On Thu, Oct 12, 2023 at 11:28:55AM +0800, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is not a PCIe
>> Root Complex integrated End Point(RCiEP) device but only register counters
>> provided by each PCIe Root Port.
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - Time Based Analysis (RX/TX data throughput and time spent in each
>>   low-power LTSSM state)
>> - Event counters (Error and Non-Error for lanes)
>>
>> Note, only one counter for each type and does not overflow interrupt.
> 
> Not sure what "does not overflow interrupt" means.  Does it mean
> there's no interrupt generated when the counter overflows?

Yes, exactly. The rootport does NOT generate interrupt when the couter overflows.
I think the assumption hidden in this design is 64-bit counter will not overflow
within observable time.

PCIe 5.0 slots can now reach anywhere between ~4GB/sec for a x1 slot up to ~64GB/sec
for a x16 slot. The unit of counter is 16 byte.

	2^64/(64/16*10^9)/60/60/24/365=146 years

so, the counter will not overflow within 146 years.
	

> 
>> +config DWC_PCIE_PMU 
>> +	tristate "Enable Synopsys DesignWare PCIe PMU Support"
> 
> The DWC_PCIE_PMU symbol and the "Synopsys DesignWare PCIe PMU" text
> suggest that this is generic and should work on any designs based on
> DesignWare IP, not just the Alibaba devices.>
> 
> It appears that the current driver only supports Alibaba devices
> because it only looks at Root Ports with PCI_VENDOR_ID_ALIBABA, but I
> assume support for non-Alibaba devices is likely to be added in the
> future?

Yes. The rootport is based on DesignWare IP and this PMU driver is expected
to work for any device based on the same IP.

Unfortunately, due to the limition of current IP design, we have to follow
the databook and only support Alibaba device now. If a non-Alibaba device is
added, this driver can support it with minimal modifications.

> 
> If it is really generic for DesignWare-based devices the config symbol
> and menu entry seem fine.
> 
> Maybe mention the vendor (Synopsys or Alibaba) first in the menu
> entry, though, since that's what most other drivers do, e.g.,
> 
>   tristate "Synopsys DesignWare PCIe PMU"

Fine, I will change it.

> 
>> +	depends on (ARM64 && PCI)
> 
> I don't see any actual ARM64 dependency in the code, so maybe omit
> ARM64 (as PCIE_DW_PLAT_HOST does) or add "|| COMPILE_TEST"?

I will remove the ARM64 dependency and add COMPILE_TEST.

> 
>> +	help
>> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
>> +	  monitoring event on platform including the Yitian 710.
> 
> Should this mention Alibaba or T-Head?  I don't know how
> Alibaba/T-Head/Yitian are all related.

The server chips, named Yitian 710, are custom-built by Alibaba Group's chip
development business, T-Head.

	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
	  monitoring event on platform including the Alibaba Yitian 710.

Is this okay?

> 
>> + * Put them togother as TRM used.
> 
> s/togother/together/
> 
> Maybe "Put them together as in TRM."?

My topo. Will fix it.

> 
>> +#define _dwc_pcie_format_attr(_name, _cfg, _fld)				\
>> +	(&((struct dwc_pcie_format_attr[]) {{					\
>> +		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),	\
>> +		.config = _cfg,							\
>> +		.field = _fld,							\
>> +	}})[0].attr.attr)
> 
> Seems weird to put the \ characters in column 81 where they make
> everything wrap unnecessarily on a 80-column terminal.  I guess it
> just happens to be where a tab after the longest line ends up.

I see, will replace the last tab with some space to avoid across 80 column.

> 
>> +static void dwc_pcie_pmu_unregister_pmu(void *data)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = data;
>> +
>> +	if (!pcie_pmu->registered)
>> +		return;
>> +
>> +	perf_pmu_unregister(&pcie_pmu->pmu);
>> +	pcie_pmu->registered = false;
>> +}
>> +
>> +/*
>> + * Find the PMU of a PCI device.
>> + * @pdev: The PCI device.
>> + */
>> +static struct dwc_pcie_pmu *dwc_pcie_find_dev_pmu(struct pci_dev *pdev)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu, *tmp;
>> +
>> +	list_for_each_entry_safe(pcie_pmu, tmp, &dwc_pcie_pmu_head, pmu_node) {
>> +		if (pcie_pmu->pdev == pdev) {
>> +			list_del(&pcie_pmu->pmu_node);
> 
> Seems sort of weird to have a "find_dev" function actually *remove*
> the entry.  The entry was added to the list near the
> perf_pmu_register(), so maybe consider removing it in the caller or
> near the perf_pmu_unregister().  

Agreed, will move list_del() after perf_pmu_unregister().


> Maybe also reorder the functions as:
> 
>   dwc_pcie_find_dev_pmu
>   dwc_pcie_pmu_unregister_pmu
>   dwc_pcie_pmu_notifier
> 
> since dwc_pcie_find_dev_pmu() is a less interesting helper function.

Will reorder the funtions.


> 
>> +			return pcie_pmu;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
>> +				     unsigned long action, void *data)
>> +{
>> +	struct device *dev = data;
>> +	struct pci_dev *pdev = to_pci_dev(dev);
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +
>> +	/* Unregister the PMU when the device is going to be deleted. */
>> +	if (action != BUS_NOTIFY_DEL_DEVICE)
>> +		return NOTIFY_DONE;
>> +
>> +	pcie_pmu = dwc_pcie_find_dev_pmu(pdev);
>> +	if (!pcie_pmu)
>> +		return NOTIFY_DONE;
>> +
>> +	dwc_pcie_pmu_unregister_pmu(pcie_pmu);
>> +
>> +	return NOTIFY_OK;
>> +}
> 
>> +	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
>> +	for_each_pci_dev(pdev) {
>> +		u16 vsec;
>> +		u32 val;
>> +
>> +		if (!(pci_is_pcie(pdev) &&
>> +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>> +			continue;
>> +
>> +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>> +						DWC_PCIE_VSEC_RAS_DES_ID);
>> +		if (!vsec)
>> +			continue;
>> +
>> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
>> +		if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
>> +		    PCI_VNDR_HEADER_LEN(val) != 0x100)
>> +			continue;
>> +		pci_dbg(pdev,
>> +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
>> +
>> +		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +		name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x",
>> +				      bdf);
>> +		if (!name) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		/* All checks passed, go go go */
>> +		pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
>> +		if (!pcie_pmu) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		pcie_pmu->pdev = pdev;
>> +		pcie_pmu->ras_des = vsec;
> 
> Looks like "ras_des" is the offset of a RAS DES Capability, and we
> only use the Vendor-specific DWC_PCIE_VSEC_RAS_DES_ID Capability to
> learn the RAS DES offset?

Yes, RAS DES Capability is defined in Vendor-Specific Extended Capability.

> 
> That seems a little convoluted and unnecessarily Alibaba-specific.  A
> more generic way to do this would be for the RAS DES registers to be
> in a Designated Vendor-Specific Capability with DVSEC Vendor ID of
> PCI_VENDOR_ID_SYNOPSYS and a Synopsys-defined DVSEC ID that identifies
> RAS DES.
> 
> Then we could use pci_find_dvsec_capability() to find the RAS DES
> Capability directly without the Alibaba dependency.  Obviously this
> would only work if the hardware/firmware design supports it, and I
> assume the Synopsis IP wasn't designed that way.

Quite agree.

A more general approach would be to define the RAS DES capability in the
Designated Vendor-Specific Capability. This way, all devices based on the
same IP could identify DES by using pci_find_dvsec_capability() with
PCI_VENDOR_ID_SYNOPSYS, independent of the vendor ID of a given device.
By implementing this approach, the PMU driver will be able to support the
devices without any modifications needed.


Thank you for valuable comments.

Best Regards.
Shuai
