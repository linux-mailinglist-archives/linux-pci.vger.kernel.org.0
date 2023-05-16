Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5D9705174
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 17:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234092AbjEPPDT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 16 May 2023 11:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234095AbjEPPDQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 11:03:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B7D76B2;
        Tue, 16 May 2023 08:03:09 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QLKFC4Vf1z67mgD;
        Tue, 16 May 2023 23:01:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 16 May
 2023 16:03:05 +0100
Date:   Tue, 16 May 2023 16:03:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     Robin Murphy <robin.murphy@arm.com>, <helgaas@kernel.org>,
        <yangyicong@huawei.com>, <will@kernel.org>,
        <baolin.wang@linux.alibaba.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <rdunlap@infradead.org>, <mark.rutland@arm.com>,
        <zhuo.song@linux.alibaba.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20230516160304.00000544@Huawei.com>
In-Reply-To: <7aec4dbd-91d5-2a14-8779-f239a58cbbae@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
        <20230417061729.84422-3-xueshuai@linux.alibaba.com>
        <b1d9509c-8e8c-b05b-cbaf-576a7b2f99e7@arm.com>
        <7aec4dbd-91d5-2a14-8779-f239a58cbbae@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


PCI folks, Question below directed at you. Please take a look.
+CC linux-cxl because a similar question is going to bite us shortly
if we want CXL PMUs to work well on RP or Switch ports.

> >> +static int dwc_pcie_ras_des_discover(struct dwc_pcie_pmu_priv *priv)
> >> +{
> >> +    int index = 0;
> >> +    struct pci_dev *pdev = NULL;
> >> +    struct dwc_pcie_rp_info *rp_info;
> >> +
> >> +    INIT_LIST_HEAD(&priv->rp_infos);
> >> +
> >> +    /* Match the rootport with VSEC_RAS_DES_ID */
> >> +    for_each_pci_dev(pdev) {  
> > 
> > Does the PCI layer not offer a more robust mechanism for this? (PCI fixups come to mind, but I don't actually know whether that would be a viable approach or not.)   
> 
> I am afraid not yet. Jonathan try to add a PMU service but it is not merged into mainline.
I wouldn't read much into that 'failure'.  We never persisted with that driver because it was for an old
generation of hardware.  Mostly the aim with that was to explore the area of PCIe PMU in general
rather than to get the support upstream. Some of the counters on that hardware were too small to
be of much use anyway :)

Grabbing just relevant functions..

Bjorn, we need to figure out a way forwards for this sort of case and I'd
appreciate your input on the broad brush question of 'how should it be done'?

This is a case where a PCIe port (RP here) correctly has the PCIe class code
so binds to the pcie_port driver, but has a VSEC (others examples use DOE, or DVSEC)
that provides extended functionality.  The referred to PCIe PMU from our older Hisilicon
platforms did it by adding another service driver - that probably doesn't extend well.

The approach used here is to separately walk the PCI topology and register the devices.
It can 'maybe' get away with that because no interrupts and I assume resets have no
nasty impacts on it because the device is fairly simple.  In general that's not going
to work.  CXL does a similar trick (which I don't much like, but too late now),
but we've also run into the problem of how to get interrupts if not the main driver.

So what approach should we look at to solve this in general?

Jonathan

> +static int dwc_pcie_ras_des_discover(struct dwc_pcie_pmu_priv *priv)
> +{
> +	int index = 0;
> +	struct pci_dev *pdev = NULL;
> +	struct dwc_pcie_rp_info *rp_info;
> +
> +	INIT_LIST_HEAD(&priv->rp_infos);
> +
> +	/* Match the rootport with VSEC_RAS_DES_ID */
> +	for_each_pci_dev(pdev) {
> +		u16 vsec;
> +		u32 val;
> +
> +		if (!pci_dev_is_rootport(pdev))
> +			continue;
> +
> +		rp_info = devm_kzalloc(&pdev->dev, sizeof(*rp_info), GFP_KERNEL);
> +		if (!rp_info)
> +			return -ENOMEM;
> +
> +		rp_info->bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +		rp_info->pdev = pdev;
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
> +		rp_info->ras_des = vsec;
> +		rp_info->num_lanes = pcie_get_width_cap(pdev);
> +
> +		list_add(&rp_info->rp_node, &priv->rp_infos);
> +		index++;
> +	}
> +
> +	if (!index)
> +		return -ENODEV;
> +
> +	priv->pcie_ctrl_num = index;
> +
> +	return 0;
> +}


> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
> +{
> +	int ret;
> +	struct dwc_pcie_pmu_priv *priv;
> +	struct dwc_pcie_rp_info *rp_info;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, priv);
> +
> +	/* If RAS_DES PMU is not supported on current platform, keep silent */
> +	ret = dwc_pcie_ras_des_discover(priv);
> +	if (ret)
> +		return ret;
> +
> +	list_for_each_entry(rp_info, &priv->rp_infos, rp_node) {
> +		struct pci_dev *rp = rp_info->pdev;
> +
> +		ret = __dwc_pcie_pmu_probe(priv, rp_info);
> +		if (ret) {
> +			dev_err(&rp->dev, "PCIe PMU probe fail\n");
> +			goto pmu_unregister;
> +		}
> +	}
> +
> +	return 0;
> +
> +pmu_unregister:
> +	dwc_pcie_pmu_remove(pdev);
> +
> +	return ret;
> +}
