Return-Path: <linux-pci+bounces-828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 288CA81067E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 01:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8537D282338
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 00:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE69375;
	Wed, 13 Dec 2023 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="aFng+CfZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2122.outbound.protection.outlook.com [40.107.244.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAD392;
	Tue, 12 Dec 2023 16:33:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=maS1mDJF5rgFihSk6pFjFRV0x6iqEaWE66KQq7FcCjFsfzCjBzZ71JKY18suKgrXgxJryLOM7jzhs7X88K1CUKj8IMyUSXGDd5uiUa3HGoLfxbTjwsT9dx6j+n56KlPOehzFrztAK3y9ZQLDunLI/WbyH8ITWPaZDB3+IU0zQxJngPHM/xumti3XlzYey0FGh/eeHN9iJZM6tl2mZAovsw/K+rEMIaoCgMrPZnVSk5nzl+yK03Pu6VAWkfcGkH5thGMOTMMq6lx6GccP/dgierILFOv4nEWhEK8e2LQ9meP9cYpzibvgM14o3aWrvv0W+odoWd0DnXImga0DtIDtWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdN9LXS/iNHY43+T1i0wM1BCMGidQ+Q1M6HpqQjXJ6U=;
 b=PkIJ2ar06VeMyQiD/Ix5UA//lGClSJReiKnGZMM1JZ058dFf6AUdfA/dByyEUaICXHWfeLxfLXhrBm2cqrA4GR288KLyr1U64AkeIzB5fAq7CcXl0B/ZnbZ1OjtqCaeRmKpONo19HZ+Pi3LuaNa/biEBeB9vWNTX31zSSAEyKvLNsrZ/nC5sDEa1vSz43uCDfKM7zhpN8Q0sD5qozfGVhfxT0Qv98wsN6nDQhbbsNir3sL4tpxOf2YcjB6R8ZurQDUPtsujcV2edP7SopjRyJ0BuK4cNJSfPFzN7BFXW99BLC2GjNCi1WFnMZLpHQbQ3kWh6H4sIdLyw1xdHldbBcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdN9LXS/iNHY43+T1i0wM1BCMGidQ+Q1M6HpqQjXJ6U=;
 b=aFng+CfZpuJ52xYSlVtzLqZYiwQPq7yIfFfgwKd9NskGyMJ3ZTx1+4bypa6e0/uvjbjp9U08JDT38RyHc2nMYtAqKOn2G7kDUYa3vVcwpTzlnuV/ci+ADl8TSKRShirixN9CNcXFMQ3TsikiKdjidbErn2kUGlAOrCOUa8i2KH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 SJ0PR01MB7446.prod.exchangelabs.com (2603:10b6:a03:3d8::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33; Wed, 13 Dec 2023 00:33:12 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::49fa:8dc0:6fd1:72e6%4]) with mapi id 15.20.7068.033; Wed, 13 Dec 2023
 00:33:11 +0000
Date: Tue, 12 Dec 2023 16:32:56 -0800 (PST)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
cc: ilkka@os.amperecomputing.com, kaishen@linux.alibaba.com, 
    helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org, 
    Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com, 
    robin.murphy@arm.com, chengyou@linux.alibaba.com, 
    linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-pci@vger.kernel.org, rdunlap@infradead.org, mark.rutland@arm.com, 
    zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v12 4/5] drivers/perf: add DesignWare PCIe PMU driver
In-Reply-To: <20231208025652.87192-5-xueshuai@linux.alibaba.com>
Message-ID: <2bbd5a57-b2ce-6e52-ebf-5935335c148@os.amperecomputing.com>
References: <20231208025652.87192-1-xueshuai@linux.alibaba.com> <20231208025652.87192-5-xueshuai@linux.alibaba.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11c::12) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|SJ0PR01MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 4902cb90-d794-4640-aecd-08dbfb7315b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	84t8rbqCih4hYMUpJiA6PIiFmv7YEWYtI5yv/s2am6zsgO2Dzc8Hnc9vZMQl4maATv8EEI5wnLfRQ1eSDCtRYb/+fJ87fuamaywBK7VmWMYlQQs/M3Z8U7CSDFZTRyki+mvNmxT3ZY1wo2KESHDPVv2VfBDdWonlYFz+iTFm8g7vcgxNfKcphmFYfb43xk7+RGBHHC3Bt8rcWOsHzQoHoEm1TFm98ftD3AzTwNdpgzcZLVNoAWirokZd3j9rohODCZaOunDBDwX9wyl4NZ0uORGC0k73IHb7iFl4PByg6iVoziKieGunYm0Pmm43c5qPR04nHXVr7QpUk2wOegtxw94r4UY1Zjouw5N3XhcveJD2943L2UwBcup9zL+FH4hEp3aWE2ADVk13FVxzY4DGNT6yY2T349tlK6RPnFJWsrPZF7oP1Qj6DaZA2be05+qgmt7+2uOAywdGHbd6yzSLt6s8RabVZ/qGUAShgssF5PmBOKRci39G9MMqu0rdBROXF5YaM0rOQY+OY5Xx8iDlAeIFkhE5m15wWGdT8ywj8fM6d1T6YUkv6//aMBt9V0nOEzIA2B8+N3OIEU9wt9oK2VokYx8bMg2FWKcy4UeTKkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39850400004)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(38100700002)(316002)(8936002)(66556008)(6916009)(66946007)(478600001)(7416002)(66476007)(86362001)(26005)(6486002)(6506007)(5660300002)(8676002)(6512007)(2616005)(52116002)(6666004)(2906002)(83380400001)(4326008)(38350700005)(19627235002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gUg6JZVXBC+YE2BG+lG9+QTQAoUzB3cfct0G1fsVvCwt1sc0+I+Y1datH/pz?=
 =?us-ascii?Q?4MQnTib5HpqI8rW7VuH1st5Fq1uyzNOuZj7YGQ1Lna1+PeWDinCRhLEDECIZ?=
 =?us-ascii?Q?mYtGjXHqWO6LK98V9Zi8cNfvyQ3zBwd3GqvfmS7t/kJ0Y69mBCZ9geCodZfG?=
 =?us-ascii?Q?qyMp+3jNJddDMeUr/xaaXL6I5xhvlwI+uVMIovl4iKdAAu2pHG4hu1kXSbSW?=
 =?us-ascii?Q?McL4jbMTfRqnzCgBwm8wThlSehk4b57Zqi7Ao6F2oHv8NR5qV3etmozJBZnZ?=
 =?us-ascii?Q?GUjcht0J2a1IKqTuAMExdHbKq2GpQEVJjf2nAyChFxKbuHiL5ug5DPKdz3cR?=
 =?us-ascii?Q?oQJ3QcRkBiUTrxRVIR8P6JsZgkSKxVfcI9lp4IkjxK6gfA0KGr9OMbnGbO+0?=
 =?us-ascii?Q?VvmoeBrcMmZfVDd+lNMFmL9vHR16xaqQR8tIUk/IChcIRUtH2aEgtLKMwa+v?=
 =?us-ascii?Q?5pMiCVASynbmGgeltWnoi9QBrqGR2uZWkmPVz2ttW7XprEKhLcH33OJ89Zt1?=
 =?us-ascii?Q?Cc2A1fGu7DJwZ9U93boME0+lcTP1Wg3bQ8/NsvXCprnm+Q5PoRZvyyKm3oDs?=
 =?us-ascii?Q?u7mxEmPGnIexmQYY2V4GfJOcrIUjeQV9nWFT7Ptm82wFtynGV4mUaW5zsXUX?=
 =?us-ascii?Q?N+Uh7U2Kr7xMRi2qwdabAwnryqjlizt1FYlHss5QjGMpa03CLd5iUBTIe4LI?=
 =?us-ascii?Q?zCkTAZxTkqaCULVNwvBdd+0t2JwonZYaiOColPQ2StZNVbn/kVoxOaT9uF1L?=
 =?us-ascii?Q?yy14cqM6Artfruc2ILQ3/DS6PUvYHYlyFY5la6n8uP/O0qr9qjj8yQn3krq6?=
 =?us-ascii?Q?SyZKkRlBlq0uHy9ijgKxtJ2RDZntO4Rv8Yxh9s3XJ/E2jH/Im2/5WhVmf7RN?=
 =?us-ascii?Q?tlbowA1n4RpUnrkIJASdFBmUaHXa+clKpJ362ja6rGV8awIXgKKqRhAac77k?=
 =?us-ascii?Q?O6iq3kPIQun006Zd/JMbikK10gqV4I8p2wt844uFiuKD3lg39pFgIoHHtTPm?=
 =?us-ascii?Q?ucGOGOgPltbvue8IZW7N3dsKlIiPF+/2JQK5NlJJrJb4LN0RObOZggyhMu5D?=
 =?us-ascii?Q?Rp1usUhuIKSMkZ0vOkZDKCx/oUG0IdzPx/OzvKldG58ojzeWsNd63rJiG9LL?=
 =?us-ascii?Q?kyYuE8dI9H7gLMAuufI1bJv++Q0uI3HZDdfCldp7q3JBGMq3aUSdQE2PKWNl?=
 =?us-ascii?Q?1WV94e2zSUli38oxIhz94O4R3DD5ZuQwTINHlcQJo6ybZ7HcKSgpxX6AsZtU?=
 =?us-ascii?Q?TjHxCzSf7rw/fkxJ8jmtjHbkDxQjBIXonmoszHi5vphuikMSB2PJUXrWxgiX?=
 =?us-ascii?Q?BIIdHj59xJDrwt20A9WkA6O1vpvRnSV23En66hmyXqWUH7Xp1CQ9h7V+Cf1r?=
 =?us-ascii?Q?lqN6lCUlZAOENjBtom/D0R08XyoUNg4WYKL/53fQMApkLTNPL2KHbUgvQ88Z?=
 =?us-ascii?Q?q2P99im3UtHdqNYCH+9zwB7rt9yR4oyjxj8XPT1yoFoe8WDRzCWrNIEqnbBU?=
 =?us-ascii?Q?5gk8gv6SHfb1QG1fAuGe7rpH6ovZLqHB+1n37Vj8kqkn7Bze1u+m3IGa852a?=
 =?us-ascii?Q?Lgw6lN5zc36srKlP3tZG5EsWV7QYhbvV5XmlJm+EY4MtTK3eOjyAttC5wR2x?=
 =?us-ascii?Q?E+JLs3HN2woq/64Caa5avgM=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4902cb90-d794-4640-aecd-08dbfb7315b1
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 00:33:11.3437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G1PQNn5e3BdRCPDp3zmYFc4sR9EuxFtf/DtIHbsWBr5JJvYCCZVLtpIPH8kdD9soifUZZ29elYVLy+emVpXnU814lO67tUs8JhqWDovQBH2RWI8Jpu9hYil6uF/a+KVM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR01MB7446


On Fri, 8 Dec 2023, Shuai Xue wrote:
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
> Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
> drivers/perf/Kconfig        |   7 +
> drivers/perf/Makefile       |   1 +
> drivers/perf/dwc_pcie_pmu.c | 792 ++++++++++++++++++++++++++++++++++++
> 3 files changed, 800 insertions(+)
> create mode 100644 drivers/perf/dwc_pcie_pmu.c
>
> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> new file mode 100644
> index 000000000000..6ee66c4b44bf
> --- /dev/null
> +++ b/drivers/perf/dwc_pcie_pmu.c
> @@ -0,0 +1,792 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Synopsys DesignWare PCIe PMU driver
> + *
> + * Copyright (C) 2021-2023 Alibaba Inc.
> + */
> +

...

> +static int dwc_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
> +	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
> +	struct perf_event *sibling;
> +	u32 lane;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* We don't support sampling */
> +	if (is_sampling_event(event))
> +		return -EINVAL;
> +
> +	/* We cannot support task bound events */
> +	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
> +		return -EINVAL;
> +
> +	if (event->group_leader != event &&
> +	    !is_software_event(event->group_leader))
> +		return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (sibling->pmu != event->pmu && !is_software_event(sibling))
> +			return -EINVAL;
> +	}
> +
> +	if (type < 0 || type >= DWC_PCIE_EVENT_TYPE_MAX)
> +		return -EINVAL;
> +
> +	if (type == DWC_PCIE_LANE_EVENT) {
> +		lane = DWC_PCIE_EVENT_LANE(event);
> +		if (lane < 0 || lane >= pcie_pmu->nr_lanes)

Just a minor thing that doesn't really matter: 'lane' is unsigned and, 
therefore, cannot be negative.

Otherwise, everything looks good and seems to work fine still.

Cheers, Ilkka

