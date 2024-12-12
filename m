Return-Path: <linux-pci+bounces-18325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E149EFA4F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 19:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B84C16C51D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 004F0223316;
	Thu, 12 Dec 2024 18:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OrmQmPfj"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFA205517;
	Thu, 12 Dec 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026597; cv=fail; b=e66kkBSSY+7cE7DJ1e29J4/66UdVY3BLp0SqAIEufCfBXnmD217kKWjIHWb5+Jr30/6D86xql8FgLuTaMted7cLBcbZvs5esSVWn1s4pFy085ybu+P0suiyAUEVNtmDygEGsrCPmExv6u8tVQm5Xko9Kgest5tzdYugzhVt7Kyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026597; c=relaxed/simple;
	bh=UcqkRfiM0lHBQfaf7y6teiozoDqdprHi2DabnW66NcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GtMalsV7Q+YZ5+yZgh5hVSyhZwnXE2K1PNDzKNSqmU9RObFp1nVmcqPiP1MEqabvrfkN1TW/WPOWsQqVtFuqOZjBNQ2yUGyPXV/WT/J1v0D0HwLzygRoH7rWT9Z+J4OKpedYtXT09wufecRn0zBK2Xd3FjkO5Z3oYJAyx6rFv4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OrmQmPfj; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryN2Fxv6bbSahVzc1Ut6ArqkCzrv20aWPCg1laur2IG8BSMWZBYCoX16qIdNdiAJXWGbrkWcwupHcJhrHe5J9TR9wct26adguefdT4r6uDKTUzv1DiCZRvLn8OAF3pHaV4a7W2ncBFSnsCXtPtfbOjWR+S1NNTIAqPIkV8Fz0G937pkR5xbDz6t+0Hd/RyRApQD5mRquLw2rNIkmF+pp7/uiIo4z4zAjj3hDgDHOYOy8B6uKPA/sVBm1cEdU5CBcMlb+9zcFo2tpFnuiPzp4WDzKMqsafCqtZpiDRW/TjZqrEunStD0RcY8CRGsjSPsuKRdbcIYf6bwmOJQ0uWcGkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x52Vp1/3Ri81u51cNkeaGGjrXAv20vSqFTgr+Nf3WLU=;
 b=q70KSAWhqWKwGZeMjk0JPrNrOEP37FNbYMUO1JkxGK51HUGTLxqyVWbja4sOUVWjED+m7ALIwlIqyf0nteyZBk+hp+cWn+b+0DGM7ZXMm+qGUYEp36fOJgD3GJw04t24ppr3cSjK/pD4xCbueXP/AV9Af7uu7EzvhQiRba+1LVAG7lHPQpp0WuQqL58aYDHmbswhSRpNXy4rDtg6u+2JjM3Cz/hBok33xq9GcQtmusoj4XvlYW3LLgWafyh8oy06MGxLbpTTD5fyUQILeGuOBupc8ayUNFQRU171durzaeo9lsxynIDVdT5CZeb2s1YYqvJqa6hud8YZWKBRLFT97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x52Vp1/3Ri81u51cNkeaGGjrXAv20vSqFTgr+Nf3WLU=;
 b=OrmQmPfjEa2X2Eai7RTxBWL6Qit0yn/akGFiH+omALsHo2GxpbG7dJjwOnVlMo2yBXr7izxSfcK470i/T7llyJ0H9S59cO9tGQaNwjs1kp16t+04LZb2+BDyE+0ndypC3coYt1+/1KJJ9h0LKOlYLEi+QiHyb3XRuvZJNh+8/Ds/HABskBCHYJGjRoUP1qE6qIjcWB+OMSNkbDUca789/Aj/bg50VKQWkciNn2jz/kl4NFR4VpAJZ65F3Jo2s/drEcEOczUIjALoLRn4dzhEzqs08XoVdL5CU4taaHczoYS/toOCanNwefEYpPIw8YXRTOGWU/6POzSHvdcnSwgh8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7865.eurprd04.prod.outlook.com (2603:10a6:10:1e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 18:03:13 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8230.010; Thu, 12 Dec 2024
 18:03:12 +0000
Date: Thu, 12 Dec 2024 13:03:05 -0500
From: Frank Li <Frank.li@nxp.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joao Pinto <jpinto@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] PCI: endpoint: Fix API pci_epf_add_vepf()
 returning -EBUSY error
Message-ID: <Z1slWQ2xkP80HscH@lizhi-Precision-Tower-5810>
References: <20241210-pci-epc-core_fix-v3-0-4d86dd573e4b@quicinc.com>
 <20241210-pci-epc-core_fix-v3-3-4d86dd573e4b@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-pci-epc-core_fix-v3-3-4d86dd573e4b@quicinc.com>
X-ClientProxiedBy: BYAPR06CA0022.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: 4980f063-105e-46f0-c06c-08dd1ad73e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMy0iAwm3kfWK1nX72f9gillZMwBp2+lx1eLG1QTgwurm1YVne7YFyKvEBmq?=
 =?us-ascii?Q?QcEf7TZQwEZtyNfYs4sxqn9vPLCV6r+Q+y8x9uHPkZ2LwR68L483SKvzoUGw?=
 =?us-ascii?Q?PQQkn1nLP7SPkxfQvQBjRqKV7ODXElHRUsDw2rwQnnDBuEBiOycDjZe+yBP9?=
 =?us-ascii?Q?xhqEg/suY1yN/DQFk4nkpK86HrKnGTllb1jC31rjZiMOB4ogl7hSoftdEat/?=
 =?us-ascii?Q?G0DBb8jgWqRpVw5OEwCa6rE1x6oOPA2AVZESlGuB9mN5y/dEnRJIFXlXQ44B?=
 =?us-ascii?Q?Vt7dsMyLHWuHQnF4YVfElf1MpOlgKy8vn8NYbSUK1LrRcuehxm29gm+kK6lk?=
 =?us-ascii?Q?ycg4HC6aE54OJeShBTfxJNdwcRddX1dN5TC58NDrH8SA/Lf5cmeUR4XNzD6P?=
 =?us-ascii?Q?VqnWwoNEgEAdA85K0WchEdabyTBsYBQIBeu3rwIbL/wblV/+kF3vgsy8VZT7?=
 =?us-ascii?Q?ttBQx664kfdqvx2k1ZrEVJrNeFysUFz64aOg6sugLCut2YRg9WL84jrgOPko?=
 =?us-ascii?Q?5k01ghJ8pGGx107YKs04gXjp9No8B9xj6YZYL1bpKPJhitd46pVq1MfeZNII?=
 =?us-ascii?Q?mCNYayiEyiCzeq/sStg97S/K9vLaTIP797eQQeapCJYaIcf3qBRlIxCFTpKn?=
 =?us-ascii?Q?AFvZUAgVmk4FsrOzeGx4wIwBDoLQPX+hb+wkU0fWuNXnuTYQXiB34h3EbnKV?=
 =?us-ascii?Q?U0SWuDTDxFb/5u3bYHcrr96il0iO+8tPX08j8d8PnSu0YPrSdGDBF4ZVy1J9?=
 =?us-ascii?Q?U2ELk86rXUlAkhYWGlmT/EZHLspR7Ev6U18tJlirlMArzcDiQrdMA/7BxVJX?=
 =?us-ascii?Q?vXDSZJelVXThNMY3SHajxpbHEP7Wktr3TCuatlZQedlZu4As3pUiUCYMutod?=
 =?us-ascii?Q?B11/QlcqYLliUDFUyknl7RWHoQ7ZfaJ/nYWE0ApY4k3ZQpKHcY3ub+auDXV7?=
 =?us-ascii?Q?cl/er8I1Nii6BH75Ns29N1AT0Qbtwqi3LWfvOTOrmCJhhklmmFMXPiLoljAQ?=
 =?us-ascii?Q?kMpmSYNJp+MgX4jdnUGLovsuqlQewgjtmMvHmXtd3lPVIthQuqSYdckGVH+Z?=
 =?us-ascii?Q?fXORm5vZLpWiocREP8zZKLRuoXs5Hdf+AqCYcyT0Ntq0VV+nuvrXyb3YyvSw?=
 =?us-ascii?Q?bI8jiIDX862Fq/V5hlmxvJmCGq8iKm7IpHPoN0uXsMt+vk66YUlnpLI7ard7?=
 =?us-ascii?Q?wvnzKDaXfvi35SnAYvRbCoBPMJmhvQ1uqXFzhHExLbc1ZPZAGivgKz1NWlnu?=
 =?us-ascii?Q?jx2N3lW2UvgrMBN5jGQS1BtxSi/IHXVnLrqQMClY8gN5Aujd/VPgWmC4+hDM?=
 =?us-ascii?Q?K7q8jsMVr9wdk8GNMnldocHU+eovbY7q/gKjRFkUPJhmgcYfdIhv6TqtG96d?=
 =?us-ascii?Q?EztZNHfr1YntTcx9xZUK0fJXG3z1CNDadgwY8Z9T7sFUmukjvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nOjPGMMCShHRJcZkcp2tDKpVptt1lvwBP9GXlStDZGAYEGhmecFP3fANwils?=
 =?us-ascii?Q?bvWxqhhiFPb9X8DNLqNawwIVMDsCPzrF/KbSViB426D4D9wbp5hRs7vxZEyt?=
 =?us-ascii?Q?wXLz6HO5h0IHrrbDB0nCg8WPyAmj26vB8mdsSUefiNyIc5e1+3tvso9rvkET?=
 =?us-ascii?Q?lgqLLzFTDwGRHdpBvc/R5PR8spPqQq0a0IgSSkQF0FzKzI00l5IGors5jVZd?=
 =?us-ascii?Q?jVpS+YJ6A+SzAomfenGVLooVWAV7KOYD8/iBjWVSOf/AOSzfLQ/6ZrkqukXJ?=
 =?us-ascii?Q?y7L2GXd1wu8I5HGR+x/yTvJZ5plTtKsE7ChA20oVcuUmRf8+1Am1loR+fCBe?=
 =?us-ascii?Q?n2GKRU7TGmVPuaQ/wI7nKqYAgbe3M3TUrWJYg6pUvUqp1eHZRLi9T1Gd7hTb?=
 =?us-ascii?Q?lDzNhzFd5i4zXEzGRpLH4dbt+aEtLSUT2daJwBqNXdLNUwqimYk240OIJWlt?=
 =?us-ascii?Q?4rs7tO54wasw/aJ+FPciGccSJfq9y4q5xVdcKU5o9U/VQumqHnUO+IRG1qdS?=
 =?us-ascii?Q?S31BPe1tZmLGu/VOeS5Pknie3p0OlcUHMGVVtly54Ggajy3m1q7W07jyOBjH?=
 =?us-ascii?Q?Lpq1QmRb4giVxz6AC+dqNejDiT4kY7XiLaCtxC7r7QV4ZaTvEIa/ryKrtKLX?=
 =?us-ascii?Q?p981gDXJiRXmDvDpd+h6emT6DTjtRTTaFU4WnkskH7m8NZeUp0yUF7Evrzdr?=
 =?us-ascii?Q?UvKjY4pETAmJm5B8ocnx49qhlJtWZk6/i3ZjCO9oGJ4nXDP5ix4ghbzt60bX?=
 =?us-ascii?Q?bFhx6ZQVevo3iffJ4siRfRSAb7BsB7woYfnmYRQw4xpQipLm7E7c+ZEsweEc?=
 =?us-ascii?Q?CiXKffSCAivbz0VYhJ0A9sqdMk7Up/jO3jsX/jd71rxSg8kSgLYjsh0HLSaA?=
 =?us-ascii?Q?IiRjCqS/mNLv8gGl7bo/VacGpfolPOYHWwLPIwHHLbvQN3Ptuylz95u6xIow?=
 =?us-ascii?Q?8RkW/Y6mH4hDJpRgx5YNjlNxf9PXMv/Fsr+2rdW4Ak2b01+AVPMB3Opc5WBh?=
 =?us-ascii?Q?ltYj+vgj0pw6s4b4T+Unjvbx4j8BIL6XrgqhPDom9KFwA/yuG4JD4p7VED4s?=
 =?us-ascii?Q?J7iVGBOf8W0XwYSuy14faqQUO00xHJv0R2TRY2/ExRck9hyMnh3UseyRL0qJ?=
 =?us-ascii?Q?DnqikkGcJkkYMQd3BkKrOj1V55r1RiD75t8FMXfc5tUHqekaPCaFNMmV/LIx?=
 =?us-ascii?Q?KZnWJKJ+jdbgw2fIUN32TIm/3sLkiFEf3ljVoZeRCgky7OIvPl4ZAxPJEfjq?=
 =?us-ascii?Q?aWhbbjjekL2AzOxwXsFn4k5I+aMDSqeviliB2gJy3yLpaFC8lPfefgIYStJ0?=
 =?us-ascii?Q?fO+5aTYElhMqufbJ2M/dzrhQ+Bzy6jDiGxQsgHed26nY6S5owrnCVjOWvA3w?=
 =?us-ascii?Q?mwPrSV9bwko87EZ4Jc5hEsPsOnfeM5idsR5lcQgpJEEDdvD6XJuq72rrRqfm?=
 =?us-ascii?Q?jf8ZgLewmBIstuB5SKIDTlVGJxP68BfnfAVDhhR7gs6p2V44cbVn3NEp1UNj?=
 =?us-ascii?Q?/cAWf4OBEzTgSczZr9AlKcgRP3txSq/Cy9va8zPSkc2W1/Wb4TGuTCyf+5gI?=
 =?us-ascii?Q?q4LKnI2VceuMHOk+Va9HEkCIkYY4kLfAeaskxXKA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4980f063-105e-46f0-c06c-08dd1ad73e95
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 18:03:12.7982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5hUK9UvfAsUhvpd60yTn8wJMZHrQMuW3USvyApQa7mE0hnV1k5PYnSO/xLujVzLSP28y4SOqnd5P44EjlNawtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7865

On Tue, Dec 10, 2024 at 10:00:20PM +0800, Zijun Hu wrote:
> From: Zijun Hu <quic_zijuhu@quicinc.com>
>
> pci_epf_add_vepf() will suffer -EBUSY error by steps below:
>
> pci_epf_add_vepf(@epf_pf, @epf_vf)       // add
> pci_epf_remove_vepf(@epf_pf, @epf_vf)   // remove
> pci_epf_add_vepf(@epf_pf, @epf_vf)     // add again, -EBUSY error.

nit: can you align comments to the same column?

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Fix by clearing @epf_vf->epf_pf in pci_epf_remove_vepf().
>
> Fixes: 1cf362e907f3 ("PCI: endpoint: Add support to add virtual function in endpoint core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>  drivers/pci/endpoint/pci-epf-core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 8fa2797d4169a9f21136bbf73daa818da6c4ac49..50bc2892a36c54aa82c819ac5a9c99e9155d92c1 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -202,6 +202,7 @@ void pci_epf_remove_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf)
>
>  	mutex_lock(&epf_pf->lock);
>  	clear_bit(epf_vf->vfunc_no, &epf_pf->vfunction_num_map);
> +	epf_vf->epf_pf = NULL;
>  	list_del(&epf_vf->list);
>  	mutex_unlock(&epf_pf->lock);
>  }
>
> --
> 2.34.1
>

