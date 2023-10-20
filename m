Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709E17D145E
	for <lists+linux-pci@lfdr.de>; Fri, 20 Oct 2023 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjJTQtr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Oct 2023 12:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjJTQtr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Oct 2023 12:49:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABEB197;
        Fri, 20 Oct 2023 09:49:44 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SBr7n3bsHz6J9dR;
        Sat, 21 Oct 2023 00:46:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 20 Oct
 2023 17:49:41 +0100
Date:   Fri, 20 Oct 2023 17:49:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <helgaas@kernel.org>, <yangyicong@huawei.com>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>, <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>,
        <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231020174940.0000429e@Huawei.com>
In-Reply-To: <20231020134230.53342-4-xueshuai@linux.alibaba.com>
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
        <20231020134230.53342-4-xueshuai@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Oct 2023 21:42:29 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> Core controller IP which provides statistics feature. The PMU is a PCIe
> configuration space register block provided by each PCIe Root Port in a
> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
> injection, and Statistics).
> 
> To facilitate collection of statistics the controller provides the
> following two features for each Root Port:
> 
> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>   time spent in each low-power LTSSM state) and
> - one 32-bit counter for Event Counting (error and non-error events for
>   a specified lane)
> 
> Note: There is no interrupt for counter overflow.
> 
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
> 
>     30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
> 
> the PMU device name for this Root Port is dwc_rootport_3018.
> 
> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
> 
>     $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
> 
> average RX bandwidth can be calculated like this:
> 
>     PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
> 
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
LGTM other than some really trivial stuff inline if you are doing a v10

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> +{
> +	struct pci_dev *pdev = NULL;
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	bool notify = false;
> +	char *name;
> +	u32 bdf;
> +	int ret;
> +
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
> +		if (PCI_VNDR_HEADER_REV(val) != 0x04)
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
> +		pcie_pmu->ras_des_offset = vsec;
> +		pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
> +		pcie_pmu->on_cpu = -1;
> +		pcie_pmu->pmu = (struct pmu){
> +			.module		= THIS_MODULE,
> +			.attr_groups	= dwc_pcie_attr_groups,
> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			.task_ctx_nr	= perf_invalid_context,
> +			.event_init	= dwc_pcie_pmu_event_init,
> +			.add		= dwc_pcie_pmu_event_add,
> +			.del		= dwc_pcie_pmu_event_del,
> +			.start		= dwc_pcie_pmu_event_start,
> +			.stop		= dwc_pcie_pmu_event_stop,
> +			.read		= dwc_pcie_pmu_event_update,
> +		};
> +
> +		/* Add this instance to the list used by the offline callback */
> +		ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
> +					       &pcie_pmu->cpuhp_node);
> +		if (ret) {
> +			pci_err(pdev,
> +				"Error %d registering hotplug @%x\n", ret, bdf);
> +			goto out;
> +		}
> +
> +		/* Unwind when platform driver removes */
> +		ret = devm_add_action_or_reset(
> +			&plat_dev->dev, dwc_pcie_pmu_remove_cpuhp_instance,
> +			&pcie_pmu->cpuhp_node);
> +		if (ret)
> +			goto out;
> +
> +		ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> +		if (ret) {
> +			pci_err(pdev,
> +				"Error %d registering PMU @%x\n", ret, bdf);
> +			goto out;
> +		}
> +
> +		/* Cache PMU to handle pci device hotplug */
> +		list_add(&pcie_pmu->pmu_node, &dwc_pcie_pmu_head);
> +		pcie_pmu->registered = true;
> +		notify = true;
> +
> +		ret = devm_add_action_or_reset(
> +			&plat_dev->dev, dwc_pcie_pmu_unregister_pmu, pcie_pmu);

line wrapping is a bit ugly - I would move the &plat_dev->dev to previous line.
and I think you can get away with aligning the rest just after the (


> +		if (ret)
> +			goto out;
> +	}
> +
> +	if (notify && !bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb))
> +		return devm_add_action_or_reset(
> +			&plat_dev->dev, dwc_pcie_pmu_unregister_nb, NULL);
> +
> +	return 0;
> +
> +out:
> +	pci_dev_put(pdev);
> +
> +	return ret;
> +}



> +static int __init dwc_pcie_pmu_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> +				      "perf/dwc_pcie_pmu:online",
> +				      dwc_pcie_pmu_online_cpu,
> +				      dwc_pcie_pmu_offline_cpu);
> +	if (ret < 0)
> +		return ret;
> +
> +	dwc_pcie_pmu_hp_state = ret;
> +
> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
> +	if (ret)
> +		goto platform_driver_register_err;
> +
> +	dwc_pcie_pmu_dev = platform_device_register_simple(
> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
> +		ret = PTR_ERR(dwc_pcie_pmu_dev);
> +		goto platform_device_register_error;
> +	}
> +
> +	return 0;
> +
> +platform_device_register_error:

Trivial but I'd standardize on err or error, not mix them.

> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
> +platform_driver_register_err:
> +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> +
> +	return ret;
> +}

