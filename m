Return-Path: <linux-pci+bounces-21751-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47599A3A267
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 17:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945B53A7F2B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 16:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B43126B2BB;
	Tue, 18 Feb 2025 16:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SElPE48f"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76BB26E63D;
	Tue, 18 Feb 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739895437; cv=fail; b=dNbrNbP/es871KRgyfD2HppmLHp1psKRY5VJ4hsqzUBQ7Qooz1g8hAqQhKssZXLiEd0e+Z6ihzGx0qsDEGZ0uCbYv0AAso7j8vV6BBP4TP3qb/Q5KcI6feLCbuL1qo916vjdCmtIJuOcYE1N7Gbkw113GVgxY8LYuRbU7m9Cl60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739895437; c=relaxed/simple;
	bh=R6X22SsNIXD4ANRdj7NCLNnMKxsE81qG6kfBYIdbrY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cX6IApUtkVcf8NJ/RdPNfYkThHLhp1ebIqOE2okye9DBjbsujOK702XwQUtBf4sDwWfntkotNTfjZKYCCiytdUpO/h/EfP+IOBK6b5tDSbdNcnUAkz6ZkYd/INBDXm5lsUiveINO7AKRWzDEJRdn38TRYdgx6htBn19wAFJCzio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SElPE48f; arc=fail smtp.client-ip=40.107.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YzOyxgPbmkKbX7W1rAD1ivIaesg1OH8K1ZaYeC2mqxAqjXXSWwSrp94ru3rKROIBt18EIMH3XFRjXMKbGCDvwsKE2mTFvrbGXbgRShgI5clmA8yfWuoJt86s3PzLwCD8BtqWdepxhi8Q98t0l9XIYRl+cBU2GEMnKfGTq2Abco8EvTrU2QwQ8VGA5zPV0V8EoDAiUVfjcN3ygH9Vaw1eXzmn6DqdAgoWLHSW6oAo+lLlX139E7SAec8sF2AtcjTWsSqUH6hmgdq0p3SNp6IKNf36ryphYRxAXPkOiSQykfJS12ybo93vxcj+dCyH3zmbk7Myrp/wT2xbY42GXM44yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1vThkdBPgcHHuEQmu6EhAbhAfs7hFVsFJCal9gjR/E=;
 b=SNw9I006F0hn2RP6qFGwar2I9nT7xgL18mZG+JIGkusrB8Ot55GxRswUcquU4voa6stwv2Q99jdnbBcDkSHAqueZIBE8kBXZ00Cu4uHnah/NgKtrM8c+tUY4v1DFreT9zN4z5bV34ZiTscI0vC2jesQ2tONnoH9L+g+BYeybbxQR7pT9d1pRbe11Hpg5wH/W9H5dmI63LHZwR3/2zsOJLKvufVPxtMEULKjqXTQTndVp8UqQ91f79U2GCJc58TtqeJ/O1Mtxxn7hTrgEf9798t2DsVMRGzYSZLfmF4Fo1KTHkyx5ma4/3g5qTBY9gGcmCrzNkUTQS7BH+Ybkp35heQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1vThkdBPgcHHuEQmu6EhAbhAfs7hFVsFJCal9gjR/E=;
 b=SElPE48f42nkjbv9uwdFcloXXJsoMlLytKGGPS9Gtgolo1IIUkwgcga6rkQCQL7tkmLSu+uCrP0VR0HeLHhfcYisnLulrWifAdOTsps5tT+fwscce1ELdfF+Rq1+dCgTj8iAMYjR99Xcg6Ltns2msgjxO/q/XIcy9dPJDBn5uc2tTe3+eSRxySLHUNJ/OTiczrPaPAXnjso4970UWM5cANMP1xKoh4zgRCI3YOdKTUiPtgxp1NE5pOK8MFlGeZDAWVpv3hLqrj0lhrodh2xnyE+P4RI5rfMJRDX1J4Q6ZQ1d43P+AToYYtPu9U+tf5Ij9jqOmLCgw4UrkR+w7FsHpg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 16:17:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 16:17:12 +0000
Date: Tue, 18 Feb 2025 11:17:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: manivannan.sadhasivam@linaro.org
Cc: Shuai Xue <xueshuai@linux.alibaba.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Shradha Todi <shradha.t@samsung.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: dwc: Add PTM sysfs support
Message-ID: <Z7Syf2LXEuKFToV4@lizhi-Precision-Tower-5810>
References: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218-pcie-qcom-ptm-v1-0-16d7e480d73e@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6995882b-2c30-4efa-52bb-08dd5037b344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zyaWrR2VI6VUrlT1luu0oUBMAOVua5caOztYxf+aGGne+eaW81QG5Uv2X1kI?=
 =?us-ascii?Q?ZBpUj/stT/DxSOVmbJwrbXTojLabdVL3zscq1pAesYT6hpUaVM+bbSLlal/9?=
 =?us-ascii?Q?v/4wz0vvLqDZ4PhpwXD/L7jkukeSqHDJMxiZaTTon4mv5Ujg39PH35Fm8nY0?=
 =?us-ascii?Q?nPQdWtpMNjf4Qf7dWFgofnnZBh/QYbEbzP0jTfOK1QrRUaQMsqTO/HmTGtWY?=
 =?us-ascii?Q?3FXLaR57m+x8Gfe5SUgc/Kj/BDoDIXdXj7dvvPZrPetMHqk5UY/isxEUPCQy?=
 =?us-ascii?Q?5nqsmNTbyQogPWqwQpGk7ahmhjLHWu5WMRCG0H54ejSpa5ZggjCVxZluoklM?=
 =?us-ascii?Q?egfRzOm1L4r9KaIPJipCEUXSSYZd2wsXrf1x+44FG4bCRCHFR3HY4zHF3b6L?=
 =?us-ascii?Q?oRY7I4/wtSxlp/eVZDxEhuTY5YJ/c9uDavrpKsNUait4zTiN9SSOpmkUaRoF?=
 =?us-ascii?Q?NtmP6ixPVqD8EEeHOoi4wLgVqqSCfTn+H2XEW1vqchHlflUWtddMCna0kSSZ?=
 =?us-ascii?Q?vZibdNEQWEFfsrAsR9YIlXpjDYaDytGZa5SLX9vIzmw59fA8ycVdro1cz9NQ?=
 =?us-ascii?Q?OWr5yjdzSdzTE2pFObkHCa9qn6GS+7CPKftAs8rXutYIL2jgmXysp5Hpj3EM?=
 =?us-ascii?Q?/fBYp3gz3ZR8HVkKUgrfJE6F7drpK0UnL3Bh2/5/dq3NucYcB3jdraQXXCOZ?=
 =?us-ascii?Q?xI8mC5h2WMB2G1LPZwYufqsI3LoY2BmO5bvivDJijqhF/6LwQFHueIn+FE83?=
 =?us-ascii?Q?rAWsiNtQrIM2ghZor9kMiTWNV5yYtMliQ3tfuDFSGgdkY5aXxbKXmBxtackp?=
 =?us-ascii?Q?NrK7lhhx/Yvmbyy6Wuq/IsR46EjWM2qvniFheTqwXnp9NsExoCLufGp4N8CD?=
 =?us-ascii?Q?ea1t0ONZSt7uDNEDsGoy9qgYcOTzc7bPcFpd7F9BdSjeDsQ1byYQY8Z2reUE?=
 =?us-ascii?Q?7Rb0iznkbwBKMuDPliJGYj9u9piwRsH8Q/wYDFXUVeBKdGH8IaKTvGJxmqSc?=
 =?us-ascii?Q?4jPExN52Vq9iWa4sX67XqDGVySi1/6eZJT93UgEljWY9mI5FnCDbJdle+Tik?=
 =?us-ascii?Q?wILoAqtBabus3pLV5cl0ultT31Wmygt+XSgp9F7iOyYttA53mzZi7uOybEse?=
 =?us-ascii?Q?rosykq2LoPt4bBu1h/oCp4/Ybu0GmxMDg5Iq7tttWGc7BhaTkJWdRQO468gI?=
 =?us-ascii?Q?lD2oC74eddp620/jpnlJi/8xKUbeOdJXeEbl7fI0BK7H5rkWJEVW/t6quK8R?=
 =?us-ascii?Q?xxKWNlepMuLe8vJ+ohodn4FQ/E8ftEanf5g0LobeRNmorHwMXLdk9uz6bHHr?=
 =?us-ascii?Q?7cY4zd6HTyoI6gK8QD+rXVDacXQpzadGJReaETABUqAdDHbo8O6nnFGrF/zU?=
 =?us-ascii?Q?YYWlq84Kb8dG+NmJnnpRbsgh7nLTavwJIllVJkzQOcyPxKxrh2YHxdCKvH2H?=
 =?us-ascii?Q?jfN1mjtXZ9/1V+qN3X+osNle4pVglYgX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sl1vjzay/g1jru8sJAL0PRvL3do1tcOT5ZR4GSW6zFVJ8qsx4Sa5b131fonz?=
 =?us-ascii?Q?Vbu4KuYzef5s2tPTXNfUtO8+phZCgNDKOQ+QvkCLGtaCnwp/I2kbJ0zbmkk3?=
 =?us-ascii?Q?KRrSV7QosvKVmbmd9wUVE8xyotNM9L4QyI5lpnI6Lxa6vHQKlkqacW2YhiHF?=
 =?us-ascii?Q?CD2l1s7BXsETZVmB5W+hIypqkACRwASnoTyFGk5zaCUZiWr8zNudwd2J/vkS?=
 =?us-ascii?Q?Lp72t8Gz0M4sidSdLTkr8W1+hX/d5OBnc8NyZSwWTNNqr9olyVKg7oaxiym6?=
 =?us-ascii?Q?k++vK3EZGuoKsYw+a0IBOAl/FnZAoVfxSlIvW6BRnwK6KFrdDGr+jUsJ7TPU?=
 =?us-ascii?Q?3o1FBbdXyYouka1DT0VvhjSkKCZ4xogOyc1OTdyXDf5YSsvLjUGA6KUZW5UU?=
 =?us-ascii?Q?gNg92YTsEsjeoGbDJ6U/gpc+Uu4WQ4+mB0o9dqREB7d/5Zb11fRceHeMXNSa?=
 =?us-ascii?Q?jE689Jk420pm+bzsRPTosqCCHO6HmLTvIfUFc/KBF3cYfTUJ8ykuk8WgEfZX?=
 =?us-ascii?Q?b4DLcf31uJ5YgTM4zQvjtdIZYdBqs5b+gJa31ZxpZxroZtvbQ+mzuuH1DuEN?=
 =?us-ascii?Q?TLKhBua+LFFOF/TX7ed9Cq6xLxEglIvH7CKRvDYQJB41u5rhxHEzdv0LbB9X?=
 =?us-ascii?Q?oERvWebjE2bVbapoQ1qSsWZ3s372qDRniTCjQLM4dDGvSzML2s9NEzN/Q4Th?=
 =?us-ascii?Q?j8w8/IC9WSo2JSTSWqoQjE49/bEW6Deg3EFg1RKTXWAHlqE9w5fyRMlC2Spi?=
 =?us-ascii?Q?ved5COFucfwUs4X9SEyaHI4TREqTCsr9XCzjpIXfcZ05z406mZYNSrPotC+c?=
 =?us-ascii?Q?p9zGc1ufpihmOSwF9SSJBq4dk50ULf3Wut0LrsSgbpVBA7deUj2oTVw7hV6U?=
 =?us-ascii?Q?nLs0H/S1DDiJaplIbKN1gsGx2S2ib60PC2+jhYOgX7y9hp84jqWh10cUAKy+?=
 =?us-ascii?Q?peyvmcWx94nZGMb6vcpSiMyLX2chZdEfgbO/J9tUKRAhUwJq5fdDGsKPTJlN?=
 =?us-ascii?Q?fPZDn8vLfxPKfb8QePb3ZZst3gauI1dswXQ7ge1Ku36JqhTk2dTCladKnyqx?=
 =?us-ascii?Q?h5q/S1t9cC91YoFFpfalHcBkXOSpdd6w/le1zHL1xDKkv63+h6F93siYR5R2?=
 =?us-ascii?Q?xkJv9ysC59MF2TmwRiw3x/8i1rljc0XYuk2ryeW1Z6LdW85RKcxzLZNte3zw?=
 =?us-ascii?Q?PVC6PfFurfvLtscJdshuz5krgD/X2ud8AfwXwQqsop+krC8hmVuWOcVZ5Ea6?=
 =?us-ascii?Q?/Jy9QTR9mPa+U9fncQ2w8hz+xvi4SnJy5PUtqGZV9305uRt2aPyba16pvgfL?=
 =?us-ascii?Q?yy1l73GfQf9ShTIQArhNDvSo6IuEjfAxWqC0XnuPe6zlBMo5maJaPoyGs74A?=
 =?us-ascii?Q?ter3Ql9gTJoG4JILv0eveaxgAMOFJzA/ANtaBGekfF7ZhQ6d8lH6FFUZNEkF?=
 =?us-ascii?Q?0UEEZfhm5lrWn7AI/Tx0p0zWVRGCWUTCMda0Can82BYDkWtq25cLPOUR48O6?=
 =?us-ascii?Q?Wqbo9gkbRD0uzDPuEFvaphlgb668mhcYng6Bmdpppuy5QhbtS7AjasykhU2s?=
 =?us-ascii?Q?NlUU/oHi/1Um5cdgvnmOFGX84EjAF+bGAiy6ipl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6995882b-2c30-4efa-52bb-08dd5037b344
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 16:17:11.9280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtC2DkRdyG3tSUP4V59H7V0wtxEh4wh2ulVxE7JB35/+iVn7DlFSgmaqn2Meub8sF5d7DAnJ4WHb+Jklzrq4kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

On Tue, Feb 18, 2025 at 08:06:39PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
>
> This series adds sysfs support for PCIe PTM in Synopsys Designware IPs.
>
> First patch moves the common DWC struct definitions (dwc_pcie_vsec_id) to
> include/pci/pcie-dwc.h from dwc-pcie-pmu driver. This allows reusing the same
> definitions in pcie-designware-sysfs driver introduced in this series and also
> in the debugfs series by Shradha [1].
>
> Second patch adds support for searching the Vendor Specific Extended Capability
> (VSEC) in the pcie-designware driver. This patch was originally based on
> Shradha's patch [2], but modified to accept 'struct dwc_pcie_vsec_id' to avoid
> iterating through the vsec_ids in the driver.
>
> Third patch adds the actual sysfs support for PTM in a new file
> pcie-designware-sysfs.c built along with pcie-designware.c.
>
> Finally, fourth patch masks the PTM_UPDATING interrupt in the pcie-qcom-ep
> driver to avoid processing the interrupt for each PTM context update.
>
> Testing
> =======
>
> This series is tested on Qcom SA8775p Ride Mx platform where one SA8775p acts as
> RC and another as EP with following instructions:
>
> RC
> --
>
> $ echo 1 > /sys/devices/platform/1c10000.pcie/dwc/ptm/ptm_context_valid
>
> EP
> --
>
> $ echo auto > /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_context_update
>
> $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_local_clock
> 159612570424
>
> $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_master_clock
> 159609466232
>
> $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_t1
> 159609466112
>
> $ cat /sys/devices/platform/1c10000.pcie-ep/dwc/ptm/ptm_t4
> 159609466518


I am not sure what real means by only show these number. It is quite
similar to network 1588, ptp. There were already linux-ptp
https://www.kernel.org/doc/html/v5.5/driver-api/ptp.html

Can we use similar method to sync local timer to master? I think it is real
purpuse of PTM.

Frank

>
> NOTE: To make use of the PTM feature, the host PCIe client driver has to call
> 'pci_enable_ptm()' API during probe. This series was tested with enabling PTM in
> the MHI host driver with a local change (which will be upstreamed later).
> Technically, PTM could also be enabled in the pci_endpoint_test driver, but I
> didn't add the change as I'm not sure we'd want to add random PCIe features in
> the test driver without corresponding code in pci-epf-test driver.
>
> Merging Strategy
> ================
>
> I'd like to have an ACK from the perf maintainers to take the whole series
> through PCI tree.
>
> [1] https://lore.kernel.org/linux-pci/20250214105007.97582-1-shradha.t@samsung.com
> [2] https://lore.kernel.org/linux-pci/20250214105007.97582-2-shradha.t@samsung.com
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> Manivannan Sadhasivam (4):
>       perf/dwc_pcie: Move common DWC struct definitions to 'pcie-dwc.h'
>       PCI: dwc: Add helper to find the Vendor Specific Extended Capability (VSEC)
>       PCI: dwc: Add sysfs support for PTM
>       PCI: qcom-ep: Mask PTM_UPDATING interrupt
>
>  Documentation/ABI/testing/sysfs-platform-dwc-pcie  |  70 ++++++
>  MAINTAINERS                                        |   2 +
>  drivers/pci/controller/dwc/Makefile                |   2 +-
>  drivers/pci/controller/dwc/pcie-designware-ep.c    |   3 +
>  drivers/pci/controller/dwc/pcie-designware-host.c  |   4 +
>  drivers/pci/controller/dwc/pcie-designware-sysfs.c | 278 +++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.c       |  46 ++++
>  drivers/pci/controller/dwc/pcie-designware.h       |  22 ++
>  drivers/pci/controller/dwc/pcie-qcom-ep.c          |   8 +
>  drivers/perf/dwc_pcie_pmu.c                        |  23 +-
>  include/linux/pcie-dwc.h                           |  42 ++++
>  11 files changed, 478 insertions(+), 22 deletions(-)
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250218-pcie-qcom-ptm-bf6952f5c4e5
>
> Best regards,
> --
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
>

