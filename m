Return-Path: <linux-pci+bounces-45154-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 566E0D3A1EB
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 09:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4BB0304DE25
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 08:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FF346AC9;
	Mon, 19 Jan 2026 08:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ACGZVvgU"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020132.outbound.protection.outlook.com [52.101.229.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610A346761;
	Mon, 19 Jan 2026 08:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768812189; cv=fail; b=KIbQJ4DyYq5iU1CFpWpsUKEsKhPfwC0TupY39+HWNzUoyKF1E5NJkWqfwcusNrPDV+6CoQgu7697phDGHdhxph7KOHK8mDb9vpwdmHL4qPU6XcG/aXdEBe+et5Kzj3uAGvKZgSS58s8a+gq0JVlJBrxOAWalN8DQjDvzw/STstk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768812189; c=relaxed/simple;
	bh=Qv69qJzujDiamtj7XLKuCIFXSFEHtKgk46T9qXoIlTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XgCe4FnH1GCFoG1xI8NJZWEYM6E+epqN1t2uRqzUUOheY2jFnN9ttW/E1WLWaQa5f15e7OYaXtFB9KcXdVDWjAnx966DWGrDtBeWQFHAa9OxZOj9yYUWvV8HF1Op6P8LtZo2MMCqBLeVA8MQdm2NGXoUOP8YcYydnm3AyDD8jQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ACGZVvgU; arc=fail smtp.client-ip=52.101.229.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1awrpf8iyx/4AaHiW5P1y63988WDmz2g5DOpLrnxkbHjmwAl6Gqu5KT9Rab0tuhmQ8CqKsGex+P3cC2zPTBoWG8laMqxxJ6DTYM7/PGMkkzZTckiBcUDApF9UVinxO4fAB7fkr60HbaBIjke62zgi0ckaDI7QprbIp5Mlynadedang8HzV/p0zKee+KCRpGpw9VBDLtAhkD5FdDwi2Tau7ywq0bfCut4/KF1Eol7quXWTlGLdmPusZkWE5LQZE7if3EV6/f2exO8cCodhKNrmW9wTRZnPdi5ux5k3qB/fmhIcaWgcq+UxIoC4k72Wpy4nNHVTFmms9E4NC204digA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lV+w7eZBFX7ePrPvea7+3BPjYWCupo8uSBcuZffwZ0=;
 b=eNPHe9tcaoetLZO/7Zx+qAl7mJ2Y9E9e131SZEECu4cOTmugBZEs/vnPB5v1Hk6K5pF0FFE3lmklh/Z4KyZLkNknPbmErP15s0ldsrkn2ZPF8NWUGsO1ost9X1UII5Woq77pAn1jUfdg+6hQSfo2IvGthHY+tMZUEaYduPDaP7TcE+m2X1pAowlmkqTE8IIqJ/gdIHIwfL7nr2qOQ2ZKXntOoh/lMLu/n9By1ReYzYL14VPU7yrlvUmu03OE624Wr7b9jujcM/wO3TwnvKTYCBwtYD7+KaS3wnE1WaJFhAI3AzCfAXUAnP2j36XSw8rEQ+iRy01rt0FgWgFskPzXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lV+w7eZBFX7ePrPvea7+3BPjYWCupo8uSBcuZffwZ0=;
 b=ACGZVvgUZIW4ichtWO7FKPEvS5+zlk4tPWARa4+xZOkwz0U7w+IICwcdty3wkYKFjPxvFASjDDrp8xTPrrO9HOKH8qQ34dP1aa6KzV1PmGwO8aH3/TC/JnsFvgC2jo2rVHgY1qlB8boxn9N4+HVACcbMdx0GWhQDGL9VZHgN4D8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5100.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:347::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 08:43:00 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9520.009; Mon, 19 Jan 2026
 08:43:00 +0000
Date: Mon, 19 Jan 2026 17:42:58 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, cassel@kernel.org, 
	vigneshr@ti.com, s-vadapalli@ti.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, 
	jesper.nilsson@axis.com, heiko@sntech.de, srikanth.thokala@intel.com, 
	marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com, geert+renesas@glider.be, 
	magnus.damm@gmail.com, christian.bruel@foss.st.com, mcoquelin.stm32@gmail.com, 
	alexandre.torgue@foss.st.com, thierry.reding@gmail.com, jonathanh@nvidia.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, kishon@kernel.org, jirislaby@kernel.org, 
	rongqianfeng@vivo.com, 18255117159@163.com, shawn.lin@rock-chips.com, 
	nicolas.frattaroli@collabora.com, linux.amoon@gmail.com, vidyas@nvidia.com, 
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-arm-kernel@axis.com, linux-rockchip@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v8 2/5] PCI: endpoint: Add BAR subrange mapping support
Message-ID: <q7ekxsclf63eyj4fcpweu5pj3mgzpj3jhqqqoglcdbg3mg2y5w@j6s6rujwtz3h>
References: <20260115084928.55701-1-den@valinux.co.jp>
 <20260115084928.55701-3-den@valinux.co.jp>
 <aWj/Sr63+hl7CBe/@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWj/Sr63+hl7CBe/@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0018.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7598be33-7f66-46a9-3ec5-08de5736c075
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KtF+ZAhHRSKBFkHf1Nap5qeGHxHingRgHwuSpGhn5k1774DEm0W2IwdrrR3k?=
 =?us-ascii?Q?SxviAEvpYd+XS06tx+fgopumsQtUvhkZFU3wDEqIV/H56eyVyf4QaKwsdXGZ?=
 =?us-ascii?Q?giaKfykSEvu6ZIa4sPDXJf02xL+U/GSzb1iiAg0l9gKVZAPFGdTVSO7pXkRU?=
 =?us-ascii?Q?DSoJLsTE8rB6sA9MNyd02vu91M+Z3TTc02UMUNiw5MmPpvoXcaarkkkgCq6P?=
 =?us-ascii?Q?fvC1Tcy9Gf+pYGiYIzzoH3fctPKkN1oGujeKmo6z6P25+qEL2ix/zdDS2Z/n?=
 =?us-ascii?Q?ksqxnhfzrMhteHYEj/RhaW7a/rJuOy99BA7DN5cytXp+76MWFuXKcZabINEE?=
 =?us-ascii?Q?06zG5J2LZZYRicYLpkfdccZyL1a+fH7zTgMBa7ITBilQn5Dfki68L/602IcP?=
 =?us-ascii?Q?wun2uTJGU5CIrVqB6UEQBdEjVRRqiM2aIjFUHRQ95hcbvo4D1uUCpt2RJpvz?=
 =?us-ascii?Q?fsAuFakrhIh2DrCTSKpzsMku2m7jPeMirVGq6CdTOyEk9/yKKk53gV/rVEsF?=
 =?us-ascii?Q?0SpqXp8hhQ0FfgkkEM7n5peyxbUlUxI0QtFVp9tMofudGfLAJQpD4T9Ix81C?=
 =?us-ascii?Q?twmOZtYC9k0traXQBOn4QY++jIWsCuA95zHEgRHSGSsMowglpRIFjF5OIcYB?=
 =?us-ascii?Q?m9JDXHFPaGH5FFZzWybI7Og/7ATl6OQH/BesK45AQaobqRwWzlKwUCjybYNJ?=
 =?us-ascii?Q?5lIr6x+0YHgSUHrnIP+eCG2PXsMma0B+XLskih7KMM9kDYWxVnBeAnk+C7Rb?=
 =?us-ascii?Q?SsfZHU3ZippoaEQvXJJfjE3QvPQAGXiXjqYZfOA96djpuWTFZb3MQodeAict?=
 =?us-ascii?Q?txe/Knr5iTh9hhsq1LTfxwiwa5qJzv3mPEjpVCeVJ13xzTMwCElN+sQOXpgY?=
 =?us-ascii?Q?0Xpl01tb/JEJh0SaJ7vvoG5RmE/+UniIMpKwmEtDmXSM/4DrKOcjx4BA591B?=
 =?us-ascii?Q?Bpc/WmaNSm7H1sajLp4WHJrRbXOk3a5Wnj5wbQgvKcnq1Z2sF2w+IGc+uIWC?=
 =?us-ascii?Q?0tUht0VwDc2UwI8WLUcM4GY9CiSOY6aYMQDiNDmaH9uAeGe3vv/sjCR2lgqb?=
 =?us-ascii?Q?Dz83gsddVXFVeZ6IlAQ/Ef7J3LPDK6twzL3nqHvmxIIaXofHnwfAkjWV5zQl?=
 =?us-ascii?Q?le4E/l4DZbHz1ep4vwZX3vq6BBzOK78KSrfUQSj547NZGyVSE4HFoO5a/nXe?=
 =?us-ascii?Q?cqiswrHQnkceVozJSXWNRdwKzJdFSpDNwoc6r8UYembRscDUUfdRnW6YK92o?=
 =?us-ascii?Q?1q2HR5HUHQLH5pmu+YQawOANOZJ9x/jryMfut7EV8L5UvR+RCBdvkOPRYeWE?=
 =?us-ascii?Q?++phcv2nwYhxNFZMaZ1NsGssBk8CGxyWUk9UbDUYRZn01daFojv+10YBXe6i?=
 =?us-ascii?Q?6TIV3RBwVCsweHMHy+IritxObQt4MjuzIEwCkLjJgq5ArlnTmFXJB6X3sH9c?=
 =?us-ascii?Q?Zh0d3IjAO2ZooFSRXC7aGdfbi9b6N9FVfzm94Skj+yIa6rjX8zxwSIcAbJAw?=
 =?us-ascii?Q?NfTMNxbbnk7i7R7rdVcvsGk/qn4GoWFicGTRC1crmr5oA5YYdwJfTJp1XvJr?=
 =?us-ascii?Q?dYiCwWtFDrWW3mMv09k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qxy3IX+1ECURuFb0HLQNoEdZ9ZdihxBosZtyNLNDtFSHpcb2dkZdLZQl/A8N?=
 =?us-ascii?Q?rXYEv1VWYstxAh8eh/yYiMd5rcKF+QaZcPym90vZBoOgdPCMDhCBAHW+ivfd?=
 =?us-ascii?Q?MOIh/7aIKPv+Fy3xruIqIC4BLeCAhZrfdqbNSYHwVH4SMK5CILD6ogBKISPx?=
 =?us-ascii?Q?0UlK3hUpjjS+TbkNU0vJ8tz7IMViHarOQAhiJwt9ggIhdRgUjl5tf3VgR0+d?=
 =?us-ascii?Q?ZpfpJxlSbBzF2jEe3h7nW4nDxqNlsYPDLsP7rlG9mTB0O8StrLOHxaj0qZNJ?=
 =?us-ascii?Q?s2+1/NYH8Fjg7zLDfIM6XRFkkxPR9MJmZCnKehV2cXzd+PL/Y639iZnqFkdK?=
 =?us-ascii?Q?NofBWRzb0h8OYNvaNlXUEmal+oENvn+U/inFnYgnAf+t1iVvldYEUXTaQHCY?=
 =?us-ascii?Q?FWKxGR0w/jlxwCxGlhvgSQbCvhks/YbGm1wi03MOx+YAF+TjaaaH7nMiDuks?=
 =?us-ascii?Q?UzmG9w/97rZGp0xJWnKEIJhc/EBm0CDvbeOu59iZDL5Xf8QBS8Zc6r5czGsb?=
 =?us-ascii?Q?6/nrBSkyMQ8sScG+PBw6UQPUHUXjrdv4udxmSVUC3moqO3SZK+FKnZL5aWVZ?=
 =?us-ascii?Q?KSF6M1t9pgNWbVD4GmikLrZYSDBlzSy3oyaCRLLmeDetqFwM+iutUoNNdFla?=
 =?us-ascii?Q?UHQPDfjSJUuq1zXGESXObXvvTDpc0POkgejze+rmLZN+x3tu63trJjFm6wPG?=
 =?us-ascii?Q?kfAl2E8XUrmT/20saTFvLO3mzgWdomric3afCMNVJyA08TaFMKvpOx5ufKX6?=
 =?us-ascii?Q?BX16LRCnPerQ9HXa7+mT29PMfWzIv/73nK0aJTdDoVElScKZBwxh8Lq6VjhL?=
 =?us-ascii?Q?bs68auRLqPgaeF2k5694ecMUHJ782k5JIow8sgrCoX0mTI6mY6AHx6CMClrF?=
 =?us-ascii?Q?3JT5cUm0kY0TSuvHdswQ1s533fzQFWWa/8O4tR32IThLVKw1nG3/4V7lNbhV?=
 =?us-ascii?Q?3CO7wZiAG8pLJrAQHtdM1VjYZPKl6MQUX2OJQ6gfODFY+Tpndl97s7H5rkTd?=
 =?us-ascii?Q?HmiQ7Bu5VH+CdXXXGIHjqvjBQUIqxsIS+6dtMfcriwtLlylE35RwyKC/CVdo?=
 =?us-ascii?Q?cDABrZIvnjugWqWAU7lTTM6/A8vm4gcWOkYCfzc0e17PGmoevPEWEGPggD/i?=
 =?us-ascii?Q?2QgwFRLGgXcI/5DMCp8IfkBCudwMO4DNoZ78SwTzIuvs42meJDc4Ap7H2Rbm?=
 =?us-ascii?Q?ggoVoEWymNy8a1pZoVtu96gDLt+jkO7H1EDFCYw5L4jHM4uawGPY+PtLtL/A?=
 =?us-ascii?Q?ztKvNqfaViwgABiub5LKC0rgs1kizpkiEkM+pP8qdcIdcimaTZBHC/b2qtKj?=
 =?us-ascii?Q?+Xde2epeElUR1VZpXF0wjG6/vQCu3W0CYS7baJ07jniIAJj7ZK362ZXQxkPr?=
 =?us-ascii?Q?ehDgDWfDiHIvUQgihhjeB3bgaXjByi8JGUcUDT+m95O9ILw2TbxK3cyQNQNP?=
 =?us-ascii?Q?JyrhndJ6Pn89sAWFGU9g7xiWUqkUNYKV30fjw+YnOW63RfJXkXUVHwAN5Y7e?=
 =?us-ascii?Q?PNgO1S9dAYUo0xc14hFcdn6hSkqkEWSMaVMKXPSdqkUSBfsVQFNw3EuM7asI?=
 =?us-ascii?Q?vgzN9DBPeX3r+2YxGijcujsa6DFJTAjdVA5iR8AFips+0y8jnNuElNnAPi3Y?=
 =?us-ascii?Q?PFME0D5YeASaKdyWbUbX/lmUIOjISs/T/UGwk+TZj+Uj4wEUa27USbu4OaMD?=
 =?us-ascii?Q?1P0JV5RDGpWXbPGYGijCT0/skXvwVd+MThO1ESm3qh97eyBeTRTWjwRoiZGX?=
 =?us-ascii?Q?p5qIbcUrUH+1xLubtoNY1wCu0WYCXuCJ6Cux8SMXfgidX7tY5gGl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7598be33-7f66-46a9-3ec5-08de5736c075
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 08:43:00.3266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/JfPrvfM0oOkUfdsDS8sbWxotC7jHacNuDvsFGDsHRqIBaxfM9rGHZPV6m07Hp9+aSnrRKBuZvtWm+28shd2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5100

On Thu, Jan 15, 2026 at 09:52:58AM -0500, Frank Li wrote:
> On Thu, Jan 15, 2026 at 05:49:25PM +0900, Koichiro Den wrote:
> > Extend the PCI endpoint core to support mapping subranges within a BAR.
> > Add an optional 'submap' field in struct pci_epf_bar so an endpoint
> > function driver can request inbound mappings that fully cover the BAR.
> >
> > Introduce a new EPC feature bit, subrange_mapping, and reject submap
> > requests from pci_epc_set_bar() unless the controller advertises both
> > subrange_mapping and dynamic_inbound_mapping features.
> >
> > The submap array describes the complete BAR layout (no overlaps and no
> > gaps are allowed to avoid exposing untranslated address ranges). This
> > provides the generic infrastructure needed to map multiple logical
> > regions into a single BAR at different offsets, without assuming a
> > controller-specific inbound address translation mechanism.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c |  8 ++++++++
> >  include/linux/pci-epc.h             |  4 ++++
> >  include/linux/pci-epf.h             | 27 +++++++++++++++++++++++++++
> >  3 files changed, 39 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index ca7f19cc973a..068155819c57 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -596,6 +596,14 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  	if (!epc_features)
> >  		return -EINVAL;
> >
> > +	if (epf_bar->num_submap && !epf_bar->submap)
> > +		return -EINVAL;
> > +
> > +	if (epf_bar->num_submap &&
> > +	    !(epc_features->dynamic_inbound_mapping &&
> > +	      epc_features->subrange_mapping))
> > +		return -EINVAL;
> > +
> >  	if (epc_features->bar[bar].type == BAR_RESIZABLE &&
> >  	    (epf_bar->size < SZ_1M || (u64)epf_bar->size > (SZ_128G * 1024)))
> >  		return -EINVAL;
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 4c8516756c56..c021c7af175f 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -227,6 +227,9 @@ struct pci_epc_bar_desc {
> >   *                           inbound mappings for an already configured BAR
> >   *                           (i.e. allow calling pci_epc_set_bar() again
> >   *                           without first calling pci_epc_clear_bar())
> > + * @subrange_mapping: indicate if the EPC device can map inbound subranges for a
> > + *                    BAR. This feature depends on @dynamic_inbound_mapping
> > + *                    feature.
> >   * @msi_capable: indicate if the endpoint function has MSI capability
> >   * @msix_capable: indicate if the endpoint function has MSI-X capability
> >   * @intx_capable: indicate if the endpoint can raise INTx interrupts
> > @@ -236,6 +239,7 @@ struct pci_epc_bar_desc {
> >  struct pci_epc_features {
> >  	unsigned int	linkup_notifier : 1;
> >  	unsigned int	dynamic_inbound_mapping : 1;
> > +	unsigned int	subrange_mapping : 1;
> >  	unsigned int	msi_capable : 1;
> >  	unsigned int	msix_capable : 1;
> >  	unsigned int	intx_capable : 1;
> > diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> > index 48f68c4dcfa5..46f817da6e24 100644
> > --- a/include/linux/pci-epf.h
> > +++ b/include/linux/pci-epf.h
> > @@ -110,6 +110,26 @@ struct pci_epf_driver {
> >
> >  #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
> >
> > +/**
> > + * struct pci_epf_bar_submap - BAR subrange for inbound mapping
> > + * @phys_addr: target physical/DMA address for this subrange
> > + * @size: the size of the subrange to be mapped
> > + *
> > + * When pci_epf_bar.num_submap is >0, pci_epf_bar.submap describes the
> > + * complete BAR layout. This allows an EPC driver to program multiple
> > + * inbound translation windows for a single BAR when supported by the
> > + * controller. The array order defines the BAR layout (submap[0] at offset
> > + * 0, and each immediately follows the previous one).
> > + *
> > + * Note that the subranges:
> > + * - must be non-overlapping
> > + * - must exactly cover the BAR (i.e. no holes)
> 
> It is impossible after use 'size'. It can be removed.

Agreed, those notes (ie non-overlapping/no holes) are redundant now.
Thanks for pointing it out. I'll drop them.

Koichiro

> 
> > + */
> > +struct pci_epf_bar_submap {
> > +	dma_addr_t	phys_addr;
> > +	size_t		size;
> > +};
> > +
> >  /**
> >   * struct pci_epf_bar - represents the BAR of EPF device
> >   * @phys_addr: physical address that should be mapped to the BAR
> > @@ -119,6 +139,9 @@ struct pci_epf_driver {
> >   *            requirement
> >   * @barno: BAR number
> >   * @flags: flags that are set for the BAR
> > + * @num_submap: number of entries in @submap
> > + * @submap: array of subrange descriptors allocated by the caller. See
> > + *          struct pci_epf_bar_submap for the restrictions in detail.
> >   */
> >  struct pci_epf_bar {
> >  	dma_addr_t	phys_addr;
> > @@ -127,6 +150,10 @@ struct pci_epf_bar {
> >  	size_t		mem_size;
> >  	enum pci_barno	barno;
> >  	int		flags;
> > +
> > +	/* Optional sub-range mapping */
> > +	unsigned int	num_submap;
> > +	struct pci_epf_bar_submap	*submap;
> 
> struct pci_epf_bar_submap submap[] __counted_by(num_submap);
> 
> Not sure if use this simplify alloc/free.
> 
> Frank
> >  };
> >
> >  /**
> > --
> > 2.51.0
> >

