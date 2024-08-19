Return-Path: <linux-pci+bounces-11809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE7F956D52
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471CF1F23F0A
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 14:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE2B171E40;
	Mon, 19 Aug 2024 14:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e1SWBOGr"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013055.outbound.protection.outlook.com [52.101.67.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3189A16C685;
	Mon, 19 Aug 2024 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077852; cv=fail; b=pMAy8jmZQBI6l8icp8XrDnZ+JMIY/gCQP9Ke+HhWazxvTz9ztvsPqoXLC00ns4Dq4qFCLCmveydo0WL7M9nkxWN8jtAYJ3dkDYv9PBlqIROtb7dJhz8ftw/3ieHWjanipbvEE5ZJ9+hPYtT43FGO+4GUbbKwSDiG2aD3zxbmF7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077852; c=relaxed/simple;
	bh=Lk7Ib4KCszrraq7Geo4DyERBvCd8uLGMdXZkntb6plQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pJXV7IUfe73o1E1ZKOtcYuvp0pKsq/fXoecl485Yb6RocYRgt0iFLgVzOINM+wEomyblDhpoXhb8bqhv2HXZYtz7BRQQcd9A1nGOqpgkmGQRP++YWIrl6XqgS6hCu8apv8wXbvx/UmEIy05y8Or1eB323dJlKTLJpRnviZBy6SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e1SWBOGr; arc=fail smtp.client-ip=52.101.67.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrhK+G6q8zxvD8wLd8Xf9HQb877L9zNrXGMJppeA2/dYInWyMM8B5DVGIEijQKWD6BYoBhM76ivd6G81xqzWZKG3YIem/PEHkAbOierr6EezNwaAfz/pNEHMjq4xCNSoTasxcILpnpCaGznVOhgyP6eCQmMZ9w8cCXbAZWZtuht6wtPq7bsLUNA5ONrR0pZWbR2akwjAVUCyInTln9V74GOJ067VEhVj7QJ67dBtcpUPTgpf7usgaqaUE5KFgVTsfoAOjGUgc9Dod+7AxPZ5mQEMQ0azi6zAgj6DBHhO2LqquxuUI87D0byg8MlvyK4xETRPQLUxdhk2B38fz274pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tqc20FACZpfX7CH1PiGT9qIyh33ZOJgoRdfafC4/Ry4=;
 b=A+Uls+BvKgYoAaAWFH4AGdt9CXKuqsznkU6bo1j9VekBoFR8lqbWatFVW7LmmR5jvv2c9t4gNUuPUQ9DoNoVRGWq22VlIUrzWzsMI5GcN1R3ivMOx0YAjPyY8NR33DYpE/eAKcx+AOjjHKK0uQGg+zzjXvz1vgKgbsfUDCtuxuxqVJkLPDzsTAtqxcSU1YgycrHT5PnH77FZmDRft1zXR65fj4wa+VQ37VjZ+ztlpc0QXzdkFJ2wyFL8Fmlp5vCAWXwZKCYX27aTCvx7WVYZ/mLZnN2Ll9LZHDAT/MhyMwxnYK/KEe2bjdba/7wqPxlOMOKR6MZwINYlpSBPuMmzow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqc20FACZpfX7CH1PiGT9qIyh33ZOJgoRdfafC4/Ry4=;
 b=e1SWBOGr7VDpqSh078ZNVq7mJI5ZhVZHmpHVCfqMkOchaY3ETExbvBLx5+y5Tlefc9ZRnJvFIjuxYoaaniP5x3O5LK4OcCe5gUkTR8h5zmL4yTUd766zs7j9RO1qoHr54PNtKOKa5KZKXxPhZO1hqhat23ON5G5dmSLsPb9Qq3TECWzHmJV0daurw2L/MIDHQgSne4cZN89BL7RkwAYrwOytAdPsPoFF26/l4dnbJqwTZG4t6jrnwUgiWT27z4kDN93G0oa0XfTcazjERPmMlNotldaFyhF+ScSFgix+bqwCNkKkE8CIkKRrSywq8WsYdBTnA/aEX15Rb6xZVzPfdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8278.eurprd04.prod.outlook.com (2603:10a6:20b:3ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 14:30:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 14:30:47 +0000
Date: Mon, 19 Aug 2024 10:30:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, francesco.dolcini@toradex.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] PCI: imx6: reset link after suspend/resume
Message-ID: <ZsNXDq/kidZdyhvD@lizhi-Precision-Tower-5810>
References: <20240819090428.17349-1-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819090428.17349-1-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: c6836684-8097-40cb-6206-08dcc05b841d
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?aEtX/2ioCdsR7q0ITDOmljZhcRO7XkteCQ4xnXf8yB9ZqjmkqAcEPAdxWvgj?=
 =?us-ascii?Q?6aVKWYc3zfOScJT6+ZnbI/AKjekai8wPaByY3pfCtYV3NJ6phqAh63PtYwog?=
 =?us-ascii?Q?FjS0E60OtC9dvsEMwEzpVjYTyruEIZZnY61Of9dpJ7Ua97ApqiK2IvaldfpN?=
 =?us-ascii?Q?bTfEFa84NxIml0l3xAJWTeMeGOx053KVN4rWxmvZfF0WGf1jsL8CCsAJrsVc?=
 =?us-ascii?Q?tR0ub5uL5xNMP3iDtlUGkzpBgIleeVd7RR1BvaS4FfHt86S9pCE/WC9wwpBH?=
 =?us-ascii?Q?6Au9NmrF6YBk8LfkvCuR+Ek0iR/7K5v/hnsOmhLKfkZqF9nh2S1KT9y9YEL3?=
 =?us-ascii?Q?NVTg2H1SoFphafrGH3X/+YcT6N/xgAecnVtGn+EkVPkmrB5O4jI9abUWWuc0?=
 =?us-ascii?Q?m/sF4V1iUFBqWS8eBRcpodRBimffh27R1iEL1RYAz6UyNJjfmZ9UK4zu+KtN?=
 =?us-ascii?Q?z8REYaEjHkJRYo3ECJquNo/CA+6rh1UpK4uI/tL0AeUZXEANaiA0ZpWTRB6C?=
 =?us-ascii?Q?JtAxqvmw/Ao1sUl82U4NaAq3c8hlrXKCGy/T/V3yBv1Yte+P3Dit7bhxiO/E?=
 =?us-ascii?Q?xsScBvA33UwABqO/e17cHuYmkXNX1oa3wioDufjXPsRUlDSGbo9IUjFkgv/R?=
 =?us-ascii?Q?Q8wc7HZNBUMGoVmsDQjfwTQ+5uDFmVOQPbnvWFYjJ+LoM9FjqgZFo2wcZzh6?=
 =?us-ascii?Q?T2CqsmPxHyMizs8Xz+uNIM4If7du0u7MQKxPJkMqVtl8fXYK1bjYaGiUbx+O?=
 =?us-ascii?Q?6z+yLa1WohBHvaLwpJFPc7d/TzBksqyFjUrkcXmNTK9j34HOvDetpMrg84Nl?=
 =?us-ascii?Q?R8v623C8YlfwQZIwREgXLQAd5LReort0WX1wUgDpKHoNMvUsShuJwCNUTdUl?=
 =?us-ascii?Q?EILJXYpOPfCRtbhrwzSRqdaj5jf7ZevfpptSewhOSvu/hO0w0PcFIkV8Fc9S?=
 =?us-ascii?Q?Ffe2nxkwROWte/W0ch4js7WIQWuvIenW29rzE8HXuPC+hjQhWMJ+h98diF5k?=
 =?us-ascii?Q?TA/Dw9gFgQwsTOgCjjqDHeE1xDr+/aYtG5os6KTYvxW4/3d3KyZmyPSvE3GP?=
 =?us-ascii?Q?EeMPyiKuRHbk/aNDnY+LeaEzm8TsbGJOzeh/0w94lSZDOBeEke/Z6RYQTxHn?=
 =?us-ascii?Q?JG1PNMml3ZTWQZOLrdTWTqihWvFtfNxzD04R0oOy3uyGpcH3WvHEmVcfcitY?=
 =?us-ascii?Q?zvE+7ymg3eQ3GC/8x/2zgGulUGKC3qgdmR31hCRcTkfZquKdh2/XG1oqaUg4?=
 =?us-ascii?Q?naQx/P+FXevbZFJ1Q4TXT9YAgcKZBJOJ1H1OxfbXo2JzpndtZIwt0h/TinkD?=
 =?us-ascii?Q?I1R8gEfRx3t5jHCgoCEq0eeXEiBdaTZMmj1btqgWOR9jqFrJaI0aTugKa8t1?=
 =?us-ascii?Q?eCHiM5Y=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Cu8bWrgH3Iyg2uTC7qdo+YNn3IOgZ5jtZEs6svxi/uVG/ntqbSw/l87ZtuS5?=
 =?us-ascii?Q?dMTrTzaNzUmYu1xaiDi86zmqma1Y3YNMdG4oPKgi0usFZusxjWGSJOLZPYMB?=
 =?us-ascii?Q?e9CjJqH9v0q0GNgTP2GstdpVH/DfwQH+/dy/afHGQjbSXWdLHjMpwDLKP00I?=
 =?us-ascii?Q?l75NY7U/AtaYGS3Xkl7l5wWKq6yf0iLnnnfiYyu44nrvNgSWt38PRAMf9dxR?=
 =?us-ascii?Q?3opooz1C2PWWhDIwtSIRxpIJKyP1CGZpc8ovo4ZpqR5/4zAItzsR41/0Haxy?=
 =?us-ascii?Q?9/R4aDD7kHB+4ayu/qP0EXvEPnih8Ke7Bnr9AxjjQwlT3W5RCR7YQjnQyBNK?=
 =?us-ascii?Q?RPdZ0rmqoQsPqUkes/9L5u257va7q7eQLl/XdvHm2jV3YA9TrT72TdhW3Rb7?=
 =?us-ascii?Q?uIh5pLQZt2RAdBgVov/AT9G82VYio/uvSxxabMoG4FJNPVE1527ayZ5OoZTD?=
 =?us-ascii?Q?DB3faVyuMt9+24MJbpkA88J2viFDXHGq1k146XR5aiH5ncUmQWxMVsRjVuVA?=
 =?us-ascii?Q?7ZEQI5QSDfNT/lYkM8tPB5w4zXxolPiPqPBQiAF15hBByph6HGbomZtOqtHI?=
 =?us-ascii?Q?fwXuZk3pnOd+WpTnAak9AGlpZhQhjqGvjZVhCs2+iW25li8j5UXVFOWnYF8i?=
 =?us-ascii?Q?Qht4B4F5X9+IK0eIIu5nloZo3KdGV4Diklmps+dbbxwosQMl5eFi9hdQ0kcu?=
 =?us-ascii?Q?s1OwwQCMbt7y9/eC9LyCnnG4JhQDQqyHp1myevnC7T1wzKx1EyH4qVA20rPU?=
 =?us-ascii?Q?yuzR28os2bXZg+FKIBlNfjrgw4S4xovDghPhc/unCAz3h8VIu1EJdzXBIzK4?=
 =?us-ascii?Q?ydCj/7+igD4RiLa07B5sXWXOIIti3c7RWjWJt9EG2RG2JkjeKY4eNSjXGFr3?=
 =?us-ascii?Q?Nz6/lAeV/pNi4YFGQNU2BGSI+fM0fQmiKQQLekz7Uh2XXVbIG7Pt/pSmxewu?=
 =?us-ascii?Q?T8780K2JjZWRVBQ7l2/2+7o6dMF+bm6FgTcmIdsCBwdNVrjuLYgIAng91xZ5?=
 =?us-ascii?Q?PNJcLbG8AzwySZR01uqvOs15HGTAciSuTA5WgCIIOWyeqEU0Y+rrfPVYniPB?=
 =?us-ascii?Q?MraRE66rfolJkI8fpSXi95SfWLa5p/+X3oRMqZf8HKzs9ob7tZNIR8jKsH2D?=
 =?us-ascii?Q?VFHyh5i+wShv3Zb2G6Eo3MrR80Dc6EetjCYST4//iU0kbpuRmkG+rLDQhdUh?=
 =?us-ascii?Q?xMKCJkpujDcEfBP20nKRJ3xxLH1numt6fkPqZbH0eX+Wg/Sxf01vlNua7hC6?=
 =?us-ascii?Q?0tlW8QRFgm4SwhErXslxpx55qhYyjZq+K/B2Z8jjgPpZxaAaQx1nYQ8jnSAc?=
 =?us-ascii?Q?OlLZhKRs79cY1FIAOg/u65EaVnDywEOVUDxWExN9fvH4AKGgeMzZEjSwk4oR?=
 =?us-ascii?Q?rnz2v7xnW272RYiJb/bZMmnTDRWY9R8nX5gjW4KuZKPmp40Shy0x/xKmNpDk?=
 =?us-ascii?Q?PqhBIwY9ND49UdKBR3Bw76pNaQ0eiKq/kvoZm6fb7O6uhr5UNwlNjZykM9si?=
 =?us-ascii?Q?emlxSuC2A9xHj3eht8j7pNgEZswcs5eE2UqNK/aMaUBinZYSukJPUQnqNb75?=
 =?us-ascii?Q?TAMzbCUDsAkP6VKSc9Mmk2oXUeQJr3kBJCAOcU+O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6836684-8097-40cb-6206-08dcc05b841d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 14:30:47.1789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Js1sfrZrJJtOoFS+r8wEApJRXnNg8EUEFPgSkbHT8KjI/OqbA/yeM3Y3Py2/ZrQSU4NtluZkvnuq1Px3oAOiQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8278

On Mon, Aug 19, 2024 at 11:03:16AM +0200, Stefan Eichenberger wrote:
> On the i.MX6Quad (not QuadPlus), the PCIe link does not work after a
> suspend/resume cycle. Worse, the PCIe memory mapped I/O isn't accessible
> at all, so the system freezes when a PCIe driver tries to access its I/O
> space. The only way to get resume working again is to reset the PCIe
> link, similar to what is done on devices that support suspend/resume.
> Through trial and error, we found that something about the PCIe
> reference clock does not work as expected after a resume. We could not
> figure out if it is disabled (even though the registers still say it is
> enabled), or if it is somehow unstable or has some hiccups. With the
> workaround introduced in this patch series, we were able to fully resume
> a Compex WLE900VX (ath10k) miniPCIe Wifi module and an Intel AX200 M.2
> Wifi module. If there is a better way or other ideas on how to fix this
> problem, please let us know. We are aware that resetting the link should
> not be necessary, but we could not find a better solution. More
> interestingly, even the SoCs that support suspend/resume according to
> the i.MX erratas seem to reset the link on resume in
> imx6_pcie_host_init, so we hope this might be a valid workaround.
>
> Stefan Eichenberger (3):
>   PCI: imx6: Add a function to deassert the reset gpio
>   PCI: imx6: move the wait for clock stabilization to enable ref clk
>   PCI: imx6: reset link on resume

Thanks you for your patch, but it may have conflict with
https://lore.kernel.org/linux-pci/Zr4XG6r+HnbIlu8S@lizhi-Precision-Tower-5810/T/#t


>
>  drivers/pci/controller/dwc/pci-imx6.c | 69 +++++++++++++++++++++++----
>  1 file changed, 59 insertions(+), 10 deletions(-)
>
> --
> 2.43.0
>

