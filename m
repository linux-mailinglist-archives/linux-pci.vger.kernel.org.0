Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877E67EDA77
	for <lists+linux-pci@lfdr.de>; Thu, 16 Nov 2023 04:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjKPDuT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 22:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjKPDuT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 22:50:19 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A96189;
        Wed, 15 Nov 2023 19:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mybGHOTEp0DkLvoagcASWt0GY2PkceWpQpv/H+s7ZvgJ0fIruXJ9x74RPQsM1PskDozL1rgIuHtLgZu4ksHbb20HvvhsHLbSnbnAN/0Cb3mmR7IGOM7AbVAn3obWbpn2sqhxnpN0ZNAIb4S+O71CrfP1xUK5VjVBSnOhoKnOD53iqsEeReLlB+ve6/RhK+aoJhXHAphXptT1Asx8dQxH+h/daFLd1P6Yd2totZq/PhpbAQOQfx4vNsH3Fv/TJDdqSCqEyTFdk7Tb4HEyNATqWh9cYVuzKWLp2l80hu8iCWAH3Weln3YvtjJiY2vmN4R8Bt6S9Jhf69Og20ZVjtoR0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cd/6GRqOuLmcsm37ziA+eCuksC94oar8VCmwB2CzliQ=;
 b=V1ZCuxYZzAc9vReHF6Q1JObmj6kqV6aEsadvyFlz/Xc1cvfE6Cq7eDsl4FUtJSREIbio1slLgiQO5gnH1H2AQIgZ9IqTspaZkBqJv2lPBWUr8/I4iyP5VPHsxVME9rbrlJpmJPvKJtgkXNvYtxs0gBDOaFFR2Xw90JxfWAtbq5I8SH7Ji4hbOfe4YMSvl4QOq9ziDI/Og6KYw8zGj325dx+whUdJZ+nB6rSeuBhU7IiAntbmmzoTKsV9kN6hvh/I+JWkQx7A3g5TyTmza3W4SX7tBfhEKzYotmWZUa80+f5Vk6EGQQ5CCjyh9WvdhCfq5f6azSYMbZ+hujyXCqFmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cd/6GRqOuLmcsm37ziA+eCuksC94oar8VCmwB2CzliQ=;
 b=VNEQ6nFqJ2r4ORzHz6RAICSR5rMxGQt+Z0blZ6ip1YqwxKN6ljoZV2iUzvWImXaQz4ndjYjZzgE5hWRv91ESBl7EJW++I/jbnUUoFY1JUVIhMKw7o43SyINJn0Y+qLAzaE++onKQ0zMCN+nRJM+JNUUicTo6wK0S/QFknuhaEq4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SA1PR01MB6784.prod.exchangelabs.com (2603:10b6:806:1a1::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Thu, 16 Nov 2023 03:50:10 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.6977.018; Thu, 16 Nov 2023
 03:50:09 +0000
Date:   Wed, 15 Nov 2023 19:50:04 -0800 (PST)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
cc:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, chengyou@linux.alibaba.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v10 4/5] drivers/perf: add DesignWare PCIe PMU driver
In-Reply-To: <20231104133216.42056-5-xueshuai@linux.alibaba.com>
Message-ID: <32626689-c8b1-9bd-b00-5285c633bfbc@os.amperecomputing.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com> <20231104133216.42056-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-ClientProxiedBy: CH2PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:610:59::37) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SA1PR01MB6784:EE_
X-MS-Office365-Filtering-Correlation-Id: 55653fde-c2b1-497e-6729-08dbe6572116
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3SRzOHaun3bvSom3wYSyTUxo/y0IJz3sen6TpHP/U9FU38eVncZIQ/fmeHn3OoIFb0VLa0C/784k64nfafWwjGn2kfofBvN/GubKGQEfhrUv6eE6F+qUONuhDpmTm0yCWGzjc/9n2DaueYOpKIbyLEvWGY+cAwgnGxfgP3ARfwm0aJiZJZOkFK0gTOSuYBHH9xJil2Xm4jz+cwK8Ms4PhVDEzGNy3GZsxgC92jyAmAWj6pgF84s+Qu6GS592WnLmBSbUr7EPplQzkZbsT38mDmb27Tpq5yklle0ImSDtFz3LtFk3GFG25KzMCshg8Nw24lrlZjvNPKmWGkc0sHAhsohx1sS5TQdDiUNd/aoO9n9kGi7NxEa38t+bkUDRnDsJ6hImA+YIoGSjBHEk58PI1l4xoVDDgMpv76ILNtwZci0cZnzQs50JpnStan9c8jWTNRFZsVDmsEB7PnYDDOXojUw1Zl2443DRWNmSAsIA4ZcELVHFlRYgiacEZj+Y4flRCZj4L936NC7brqReRjAvrxAJhLs8OE5ZR0vJ5mt2e8WA0LLTBkE/NRtQlSqm4Jk1MX4VZZyjJUwXMIIG+IkvYvNktfQN4t8C+rKpWYgSbk9B3SNCZ/382Zrr1IVdCHZo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39850400004)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38350700005)(86362001)(2906002)(2616005)(7416002)(41300700001)(5660300002)(8936002)(19627235002)(8676002)(4326008)(83380400001)(6916009)(26005)(478600001)(6506007)(316002)(6512007)(66556008)(52116002)(6666004)(6486002)(66476007)(38100700002)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WDbtf3XHAvw3RPsYNVoRruXn/W+k9hQHisR6ceqzYnx23OMesTbBKv1Lj1Y2?=
 =?us-ascii?Q?wwtfSN/Vm9usEGAYNwRTIxMG3TrL6JxCEUb1Soa/rl5cUzoa1pOTNzcFelIl?=
 =?us-ascii?Q?bCDnDFKOWpP3b+t0QA+XW/6Hbzqfl2lEpYBfYI3eF3b4q9LA5NknQtkI3NTG?=
 =?us-ascii?Q?q2MVbZwS9Wa9P909vsMdKbKry0e1QxS7g38IshlSWeAl8mZEZnzv2OdwH9wR?=
 =?us-ascii?Q?iMoAXG5jn50qcSDZRz+pGocG5R+urR78vANdL2+V48rDRznQ20eamxqyDj7j?=
 =?us-ascii?Q?aL4J+b5ZcrV/cnnT70YDsJx4JeJRYgAqprwlOQIq7+UUUruxbSvwkU46w/Pr?=
 =?us-ascii?Q?lZGEJaDfMZyh/91sHXqWf/OaRGRX5zFGhXfbovGcFaNlqmx9XHOKHwLYC1Q/?=
 =?us-ascii?Q?h1/2snRWWiTSg27iTgla04zYs/LUQenhjO9jziLWvg8xa/W3ZljCMGA2iTi1?=
 =?us-ascii?Q?i0DWWVp/ewK/USFhBrl4FhLHLVzfiamOgdgXIYDV8Rnqnc/7lQFVwH5jjhKV?=
 =?us-ascii?Q?K7pLqcemtwVtFR/kMwnMojUHte2vtOB+9y1vU+JzvyI3xYWFAFfotmUKWSy2?=
 =?us-ascii?Q?Jsuu0u1C4Lt8QJkixeNIesYuynCeEXjs4ii6Mrr80QabTBj4m8wcn4rZJVim?=
 =?us-ascii?Q?TiGdaw4GCrPcvAk5mcUIeoY3YiUbUVf6VkM39HU3g8qHEItCMjhX3YD3IsHU?=
 =?us-ascii?Q?v2EHbci4CdEHpbI+wiHKsxcMKQo+FdrDUkfC1tkzJFLX3zahQYmeBaIc18//?=
 =?us-ascii?Q?FiroKn6yKDTrIRPSjLxM4HNB8Fdnu1uY2JK3EimgZafStrjdiRgFJ502lMlY?=
 =?us-ascii?Q?67rTGzbv3dS8dHWzGVi1C2dhY7Gz+SJXQySc5vNdDVo4lpIfMEASfWQXyDhH?=
 =?us-ascii?Q?z8GbaecinLESRUi2UWPmp6IDtElCZAOI8vFn9w1u6uwFvRB8myiDe0qEp7Mf?=
 =?us-ascii?Q?MtujpjbxZ0LVCZUmh5j4NBBeMcsGtRMRuXsX1hIxybFmhT/ZL+6ddjv6lrzo?=
 =?us-ascii?Q?xHuoOR7DA7dYhf1aPOqgXvVF/HeupwU8FTTkBPEgG21tF+uMb4XO6BSn9V6h?=
 =?us-ascii?Q?eTxPBadbuwRHV6XlIfBgs0lBx04EG70WSPbjco6fprKccUkYB/rxpIAR6KV7?=
 =?us-ascii?Q?z11xKW0PjrQSBUvPiXzFaU91b/UI9BiA8GK/QlYmO4QTPRHT/oZt0Jk8gN1W?=
 =?us-ascii?Q?Z/YbTq7siXs7mJX3E+sGtvIv3YOdxG6mlcBLlQo2nhoFWUPtj4i+nh9AQdp9?=
 =?us-ascii?Q?ZrM7bIQf85o9DeYPFiaFdjzqKL8EbyOdJNOd9swY1XDGCzW5XIEZqse3ey4z?=
 =?us-ascii?Q?tose1UR8e3f8+Dd9L/n0ufqWbflHznUx8RPRVD7+lFHU3rSO0yZ9XdTmjmDE?=
 =?us-ascii?Q?0oR15ETFjWIZKcu5xilosaGHIYyu9AbDpAM5W8Eu2gQY2YcwCfOdicjE0WjI?=
 =?us-ascii?Q?ZzvB2CusU5d/NF95jb/cXS8/2559gD2cUtLK4CjHw1S0NIoE2g5vjH69g9xF?=
 =?us-ascii?Q?nf8waJszhnTK3REdLuKeBD48rIc/SoZ5DG080ubpx45+M4aV6e19Ngo/b+3D?=
 =?us-ascii?Q?sA9TI6sRpoltwCqY7sXHhYwQGWXVgb/wl4ucJXYotXublokhC0/BhXVYW03I?=
 =?us-ascii?Q?7v5LkTfc7YmpBKJLae7wVes=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55653fde-c2b1-497e-6729-08dbe6572116
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 03:50:09.7327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIncSNFS7YEUZFnxevscXoN+OaoGpYC64/cxwnrJTLBmv1lHnk5LijS4BLHtc3kTZk1hkYuH5N2K4zjKD8Ay9uuEKq4qBT0Y/hIkF2aCzKRQ8yvfwuRTWgSF4oZmC/QK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6784
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Hi Shuai,

I have a few comments below


On Sat, 4 Nov 2023, Shuai Xue wrote:
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
>  time spent in each low-power LTSSM state) and
> - one 32-bit counter for Event Counting (error and non-error events for
>  a specified lane)
>
> Note: There is no interrupt for counter overflow.
>
> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
> named based the BDF of Root Port. For example,
>
>    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>
> the PMU device name for this Root Port is dwc_rootport_3018.
>
> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>
>    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>
> average RX bandwidth can be calculated like this:
>
>    PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> drivers/perf/Kconfig        |   7 +
> drivers/perf/Makefile       |   1 +
> drivers/perf/dwc_pcie_pmu.c | 798 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 806 insertions(+)
> create mode 100644 drivers/perf/dwc_pcie_pmu.c

...

> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> new file mode 100644
> index 000000000000..9485c41de322
> --- /dev/null
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -0,0 +1,798 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe PMU driver
> + *
> + * Copyright (C) 2021-2023 Alibaba Inc.
> + */
> +

...

> +static void dwc_pcie_pmu_time_based_event_enable(struct dwc_pcie_pmu *pcie_pmu,
> +					  bool enable)
> +{
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +
> +	if (enable)
> +		pci_clear_and_set_dword(pdev,
> +			ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			DWC_PCIE_TIME_BASED_TIMER_START, 0x1);
> +	else
> +		pci_clear_and_set_dword(pdev,
> +			ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
> +			DWC_PCIE_TIME_BASED_TIMER_START, 0x0);

It's a matter of taste, but you could simply do:

     pci_clear_and_set_dword(pdev,
                  ras_des_offset + DWC_PCIE_TIME_BASED_ANAL_CTL,
                  DWC_PCIE_TIME_BASED_TIMER_START, enable);


However, I'm fine with either way.

> +static u64 dwc_pcie_pmu_read_lane_event_counter(struct perf_event *event)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	struct pci_dev *pdev = pcie_pmu->pdev;
> +	u16 ras_des_offset = pcie_pmu->ras_des_offset;
> +	u32 val;
> +
> +	pci_read_config_dword(pdev, ras_des_offset + DWC_PCIE_EVENT_CNT_DATA, &val);
> +
> +	return val;
> +}

...

> +static int dwc_pcie_register_dev(struct pci_dev *pdev)
> +{
> +	struct platform_device *plat_dev;
> +	struct dwc_pcie_dev_info *dev_info;
> +	int ret;
> +	u32 bdf;
> +
> +	bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", bdf,
> +						 pdev, sizeof(*pdev));
> +	ret = PTR_ERR_OR_ZERO(plat_dev);
> +	if (ret)
> +             return ret;

platform_device_register_data() doesn't return a null pointer and you 
don't really need 'ret'. You could do something like instead:

    if (IS_ERR(plat_dev))
           return PTR_ERR(plat_dev);

> +	dev_info = kzalloc(sizeof(*dev_info), GFP_KERNEL);
> +	if (!dev_info)
> +		return -ENOMEM;
> +
> +	/* Cache platform device to handle pci device hotplug */
> +	dev_info->plat_dev = plat_dev;
> +	dev_info->pdev = pdev;
> +	list_add(&dev_info->dev_node, &dwc_pcie_dev_info_head);
> +
> +	return 0;
> +}
> +
> +static int dwc_pcie_pmu_notifier(struct notifier_block *nb,
> +				     unsigned long action, void *data)
> +{
> +	struct device *dev = data;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct dwc_pcie_dev_info *dev_info;
> +
> +	switch (action) {
> +	case BUS_NOTIFY_ADD_DEVICE:
> +		if (!dwc_pcie_match_des_cap(pdev))
> +			return NOTIFY_DONE;
> +		if (dwc_pcie_register_dev(pdev))
> +			return NOTIFY_BAD;
> +		break;
> +	case BUS_NOTIFY_DEL_DEVICE:
> +		dev_info = dwc_pcie_find_dev_info(pdev);
> +		if (!dev_info)
> +			return NOTIFY_DONE;
> +		dwc_pcie_unregister_dev(dev_info);
> +		break;
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block dwc_pcie_pmu_nb = {
> +	.notifier_call = dwc_pcie_pmu_notifier,
> +};
> +
> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
> +{
> +	struct pci_dev *pdev = plat_dev->dev.platform_data;
> +	struct dwc_pcie_pmu *pcie_pmu;
> +	char *name;
> +	u32 bdf, val;
> +	u16 vsec;
> +	int ret;
> +
> +	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
> +					DWC_PCIE_VSEC_RAS_DES_ID);

You nicely changed to use vendor list in this version but here the driver 
still tries to find Alibaba specific capability. I guess, you could search 
again using the vendor list. The other option would be to make 
dwc_pcie_match_des_cap() to return the vendor id, pass it to 
dwc_pcie_register_dev(), which would add it to device's platform data with
the pointer to the pci device.

Cheers, Ilkka


> +	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
> +	bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
> +	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", bdf);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +	if (!pcie_pmu)
> +		return -ENOMEM;
> +
> +	pcie_pmu->pdev = pdev;
> +	pcie_pmu->ras_des_offset = vsec;
> +	pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
> +	pcie_pmu->on_cpu = -1;
> +	pcie_pmu->pmu = (struct pmu){
> +		.name		= name,
> +		.parent		= &pdev->dev,
> +		.module		= THIS_MODULE,
> +		.attr_groups	= dwc_pcie_attr_groups,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr	= perf_invalid_context,
> +		.event_init	= dwc_pcie_pmu_event_init,
> +		.add		= dwc_pcie_pmu_event_add,
> +		.del		= dwc_pcie_pmu_event_del,
> +		.start		= dwc_pcie_pmu_event_start,
> +		.stop		= dwc_pcie_pmu_event_stop,
> +		.read		= dwc_pcie_pmu_event_update,
> +	};
> +
> +	/* Add this instance to the list used by the offline callback */
> +	ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
> +				       &pcie_pmu->cpuhp_node);
> +	if (ret) {
> +		pci_err(pdev, "Error %d registering hotplug @%x\n", ret, bdf);
> +		return ret;
> +	}
> +
> +	/* Unwind when platform driver removes */
> +	ret = devm_add_action_or_reset(&plat_dev->dev,
> +				       dwc_pcie_pmu_remove_cpuhp_instance,
> +				       &pcie_pmu->cpuhp_node);
> +	if (ret)
> +		return ret;
> +
> +	ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> +	if (ret) {
> +		pci_err(pdev, "Error %d registering PMU @%x\n", ret, bdf);
> +		return ret;
> +	}
> +	ret = devm_add_action_or_reset(&plat_dev->dev, dwc_pcie_unregister_pmu,
> +				       pcie_pmu);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}

