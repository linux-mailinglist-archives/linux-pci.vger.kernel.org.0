Return-Path: <linux-pci+bounces-37118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F95BA4DA3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 20:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B14AF7BCF39
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7B242D9A;
	Fri, 26 Sep 2025 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="B4X653Qs"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013050.outbound.protection.outlook.com [40.107.159.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B18223705;
	Fri, 26 Sep 2025 18:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910345; cv=fail; b=n9Da1T/ZL1nMCaJmdHDd/leL9DfWcV9ZbNG3xeaom9l4SqxmCCUbpZWnNu5ejlGwIq3165E1dh4eCywj+8MLC5S1LJFtWeBP9Wfa3w4mhIFboRKUimwcqZQmsMKS7dagAOmCOqm+e97/XQvJsnNZ05/sNFzKZfl505Wp6TpezE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910345; c=relaxed/simple;
	bh=AChC5EzBTKC48XnSdgDvNbJR+jOmj1qyGSiLroI8G8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ARQDf4y9ZVSYV3n9Ums4bXabCRTW8MUGiv4Dyiqc9ou/y+998vWwdmi522UBuc0Y/RBDB/0tNRmWw8giUmaramFsyf832nIlSwqiFMJka1jnepITLO4Zx5wdk3We9DuP2XnmFulsLaRCg6MLgjKKPm6SC3Z2JRR2yDopoA8BrWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=B4X653Qs; arc=fail smtp.client-ip=40.107.159.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKFNVonMNByUFLvcw241xR9gZOOldhKWmn57dOZ5K2XZi2MxNDMequ1g2Lrh6Fsd5vRPGUAA7TcBzQkOvVzMlGlakcmdHtW0KbxOy5i6yBQ7viwYevBfy3Z3anp4bJCNVxie16ol2jmhKceLYZVQZXKiYPHT8yGRsBe8vs+aNAr9ThTCk83+X06bPscegty1eOEeKbLfYbdZ0KI56+RZvvx4rNK4wfYRLjWc0Rznzmom3YsIpVL7DQKi10Im+5YjSDIh27AHyd/lTMCk9otXDzrnJa2WxITqzagwlXL1VHWoL1jeqrVKWy748mnCohQJahpkru47Hm6yrZ9U5F8eBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vtt67kG1geaGqCSHT87qrfkxm9TxMKyp888OMKq4qkk=;
 b=arsK/0XLS5aYXRftGkccHjSy63lBo5gmDDdOKNiyUzQkz2wnhE8jXdLU2DRDZh2KX5ZrXEOiESgb2toXOC+CZdV76e9fc54EEMAU4JckKuVdDlhM+561zQvRO2+qFk8fM8y9hv5oIyIwq5eDQvD++Lnlb2LQ7F3hmV3RiJFXr9tyzJCDPDaRqeoLJXCt/z/dnSd0rZ9fjHz6YrtqcspZPIEyOw6rgc+a07zw3ljCSnBKb9FjDXNxHB5sZSY3eR91dJ0OAWxoET3HxwUdsvhoEw0xEEZI17wSQtuJori9NB2sdF4f4y5G04mP62x6dHFeVY9UIlOaTayALprXTPKNwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vtt67kG1geaGqCSHT87qrfkxm9TxMKyp888OMKq4qkk=;
 b=B4X653QskcrPv11eRtBSYnUCI2zFBkBXULhHlO14gGJirXsPmKymPOfPdFTSZeK8I4y5B8tl7K31Nct08hjvj4vLjNYUaKkokb4JeBE4mGPVuBrJMOHUMpoi+KK3O/mQ3wAtFne0D0sWiDkEtpvf5jbZgUU0pb/H+zrfUBOv/cC22IVJ3lXUfbM4mVYulDGUgSRt7/+oeh8vnUpnFzj98UPakKxTMOmem4haGKnMkK8sjOPNpLs2N85jSt/Qz4wrpx1k8u3867Qxdk+zSxY6tC/SGWRvC9YWP+44JeJ5UAm5sSU3t2LUI0me6B8yJUT8VKNj8A6c5UMliryMzoriXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AM9PR04MB8257.eurprd04.prod.outlook.com (2603:10a6:20b:3b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 18:12:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 18:12:19 +0000
Date: Fri, 26 Sep 2025 14:12:04 -0400
From: Frank Li <Frank.li@nxp.com>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/5] PCI: tegra: Simplify clock handling by using
 clk_bulk*() functions
Message-ID: <aNbXdFPrDr8V2a+1@lizhi-Precision-Tower-5810>
References: <20250926072905.126737-1-linux.amoon@gmail.com>
 <20250926072905.126737-3-linux.amoon@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926072905.126737-3-linux.amoon@gmail.com>
X-ClientProxiedBy: PH7P220CA0062.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::28) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AM9PR04MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: c2344175-d80a-42c7-e216-08ddfd283b3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dmHpbsZ0oPELCar7JynEVT28LayOLUyBe6kzZVxWp80L7/KkTY6fzjvHY3KY?=
 =?us-ascii?Q?FiQeXGQ6P9Wgrh+LmKhyLIB09mFZfN00P+8HdFuv8pbLELhGDLz7Z9tv8hdL?=
 =?us-ascii?Q?zT0cDObMRhBSIHS4MomqZaq/csLzjlN74ZEpHjrvVufdstjy/Ka2REyUfLv6?=
 =?us-ascii?Q?1fYhy68LwDAPtnrmPMyGlLdlqb2NQJWM4UtD07NG+0rdLo2rCGbzq82P5Qhe?=
 =?us-ascii?Q?cmMXclzZL3fEsPpZ9t0fLG+TWlhpUK7caNO/FT0W1sqqkI2MkfOc04Js+Hag?=
 =?us-ascii?Q?U53KXDZPdcFnfHHI5Er64u8788AWEzrkWk+cOWbI2yseBCm7bH+HVdKGS4HN?=
 =?us-ascii?Q?CX8+cMR8Qp6hL+xofjXFV5uiF74BjuZpZfwucImpKPkbjMXCCyx6L0W8+0+T?=
 =?us-ascii?Q?kJqS4f//YhVJfgXZvUYkOazEcifL2BHlWaEtNhqcembwih4RqSSJKI2BW1Bt?=
 =?us-ascii?Q?Ky5ySU0D3teVr+LiVbGztjBm4zsvDjg1JPysqwvWapJ0/UHZ9RE+QfXdcXBs?=
 =?us-ascii?Q?VOxfwvSbjR/APfG//UlIezaxLwBXuF6BlB7HE4YAGd2nk+wVXv+pRZNdvlpa?=
 =?us-ascii?Q?P2uGycHWFLBPOxUnrwA8steCJysG7jp+4Yf4TT7W3DhIRDgHI8ja0JIiEIxH?=
 =?us-ascii?Q?X8NtK3yBgzRR/ki811XrelitaPA6ORTf0azL52fPNCU7LN5RUK2SGSZCfP0H?=
 =?us-ascii?Q?qn58cC3Ga+2beK6BgxXOvCoE2sRD/4GC8W0vL2Eyxhy3cR6mqEXypyZjCDrm?=
 =?us-ascii?Q?uP25xNyaskRsSdLEgH6Q0uFnx8niogsIujkUFb2Vq0g5HXeVIT3/D8cpkGi2?=
 =?us-ascii?Q?+cMuARqlnO3cuZJzMmdqQz6xEutL0YnOHpCnKiXc3NjzQJbVqW7RvckVStxd?=
 =?us-ascii?Q?TOlEjb8AnoxYoA65/QDg+iSsGKW+uiiRwf6YitUkJ6wohe/MinnWhnPwPwHT?=
 =?us-ascii?Q?1RXh8Si+bhx2ZQOK6OvU3w2Qoq+2RaAe/VXZl4HJY0LxKn0AgoTzzwzb30Ha?=
 =?us-ascii?Q?mjZaBYSlNQdgSG3w0z5ZWJVQb9uObPTnjBAt+wXN5xyx0hWuUtJGfwDYEIve?=
 =?us-ascii?Q?Kr0fLrUwHouCZnEkYYLfqmaiYuaopdqaPlmRx9uqzHCeh6lwag//NFIR78Fk?=
 =?us-ascii?Q?sGYEw5xBVg8JDSn6eXVp5BkfNGOjRFtxfAuDONmfnZswIujy7smWEf+RR/5h?=
 =?us-ascii?Q?Y04t+p2RBcvv/7IjCvqQ5zVoQfVg9h1gBc8th2KmRU+Qw0RTk4QjeutJ7j1e?=
 =?us-ascii?Q?H+1zC6ADx+OOgqPyV73nbMVpyRzARx7jF3TnZq9uuppR5t9TKletvZof3oqg?=
 =?us-ascii?Q?2yAJJnqh363a5GbKgWxWEOIi1vQ19KePEp9BLxhqU/mPHo+x7NC51HYo9qr2?=
 =?us-ascii?Q?Dd4Qn/M3us8WWlUgZdr6PdbE0eHkAIaqfli+hBT6f3cAEVvY0maiULnwQcrC?=
 =?us-ascii?Q?WnXX/vmGlOsSG1wT+jsawf1SBSfedzzGh4tKpwMymtWGGo+H++Lqatc448x3?=
 =?us-ascii?Q?Oceyik3LY06e7r4I+SLVeO0ab1MJQls+cG3n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9sql8JG0Sm3sPGsOOiz+tLzupedIaOqxbdN8wygg9mkKuR+mH0w4Ap0j9Pwg?=
 =?us-ascii?Q?nvxj/LZH9xOWRcwqOLRh+ZBRaEIYfwYvv4TrHcqpBFH8aEwGAo7WEP1/q7ld?=
 =?us-ascii?Q?MBkygmLHgEPBaxyd1VZ5e31NHxS4WMw65hxbNxTZKxPks2ihggniLDpFHwEC?=
 =?us-ascii?Q?bqcMpu2ikoEwunHQa9y69sjclV3GwUFckO3uEZ/He9yGdDn6f6Ib3XkYxcOV?=
 =?us-ascii?Q?yXk/FCeBCT4pIXo0oJK2z7XF9dfwhhRMl5lOaK8enLzkuhg33+ufZ+z/TL17?=
 =?us-ascii?Q?oW2TH03j4YwC611dsT2J3yRl1AN6iFa+urW5twE2M3ycp3LI8bsBQPPNw+iq?=
 =?us-ascii?Q?uWqemZbRwECJy5RvgB+o2a7UIC9AuJ9PVt3VY9Oyl+UAXfeNKNgjs8oXpWxk?=
 =?us-ascii?Q?PfWUvDgStY3UT7QcKhZ03YUktMydjXp6EqGPaTCH59dbvLVPtpb3XVvz9Q3L?=
 =?us-ascii?Q?oeVePYG/usxuoRA2sYiUrhMkN2luVPZd/CNaOFbS3fUPduk2Kk/LLg/Iiu7M?=
 =?us-ascii?Q?Zzzcf7tmuoFLMnKeTEuZ/lw0OW3MNhmv4lH/q7EV3x30gJKJ5xx3dAOqWjtr?=
 =?us-ascii?Q?2hYoaYiV49i4ymm4rdsFHG1Z8zKG4Gu9ZgxZ4w1fgn9qR81PzIRM+TuEyvYA?=
 =?us-ascii?Q?K3bwto3o1HuM4RyJ69iDlDoKKMiGhOcdl+au3vtZregpkw0t79NdBsE7obtW?=
 =?us-ascii?Q?vzsGu49hdFuG4YaNlEUXFJZn4mZLNRjx/SZV8Em/YdpXNqMZ2fWn+DNzB5kQ?=
 =?us-ascii?Q?Wtlo8sAldVH1I5IKe+cd8TwgmNIMQ8Tvlf/amEqXRznCd9k20vtHJ+bAjdyW?=
 =?us-ascii?Q?pmo7m2vkj2xe1NPzkwMZwOKAlX6GUB2coxp1PNkvI0B0JEzfB54SIODdYb1C?=
 =?us-ascii?Q?6hAwdY5Tg0sMmowAoE25r/Z+srjZKdJtYlPuw988mvYRNyoMuCxbgEZzA68n?=
 =?us-ascii?Q?hxyLJAtMB/Etfd9lu3IFUMLYeLT7h0QnZ1oRHSCdODyJncMv3jDyboQJVFQb?=
 =?us-ascii?Q?kA7aG8ls2HzlCErLzogWtqsLpEco2LjhBZ6YApHWhaBaV0hNSaprkc7nWS9W?=
 =?us-ascii?Q?QATFd0RGhcIU/ebvImaxk4QzQHq2KFNjoXluwkboDFKFkU32TESdjs4g4HAM?=
 =?us-ascii?Q?30NPXLqDkJoR9LndgqZPVkCMPftYqAT7ZUW+ZsRqpjDLpzH0vdfwa+lauvY9?=
 =?us-ascii?Q?yZp/NZ1j/rlHCabNxK8Qq9wF/SWVP826oOOliFUQIwM8QA0xobkwX8Xm3nVI?=
 =?us-ascii?Q?Pbb8X+pFF/BZ7rMKrlg43btPXJ83hNZsCL0MhUAhXiuevNJfz6KQ4RxKr65Y?=
 =?us-ascii?Q?jznKhro9ACkyKdx+eQy7p+eWGIVeIfwS6lrrg6RNS/1VlKjfJHpzcqkuTQMF?=
 =?us-ascii?Q?6lu67dgqk+a+xT5wLid8KFFWofmEGdbemEZpjGCFJyvsD0N9efBmHRde0hY7?=
 =?us-ascii?Q?TOG84+I+wWftiEXcMRK5ET5IupxgqUvaiS069G5NULdsMwe1UIwzglUMdaVK?=
 =?us-ascii?Q?8NGqhFAPor9sCWRwMjeGcikSunh8QuJp90MKbZ4siNNEXvCqIjRGEfl1rdqE?=
 =?us-ascii?Q?CJQu8JSl9DjT5V8PHwg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2344175-d80a-42c7-e216-08ddfd283b3b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 18:12:19.2645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCngIUy7vwzawVggdlV3mJR0YINfptcJ0ZblYl8ymmlPlomMaBjhwYggos3QJO3mlSZg2j99Yi2XSxxtl3aGOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8257

On Fri, Sep 26, 2025 at 12:57:43PM +0530, Anand Moon wrote:
> Currently, the driver acquires clocks and prepare/enable/disable/unprepare
> the clocks individually thereby making the driver complex to read.
>
> The driver can be simplified by using the clk_bulk*() APIs.
>
> Use:
>   - devm_clk_bulk_get() API to acquire all the clocks
>   - clk_bulk_prepare_enable() to prepare/enable clocks
>   - clk_bulk_disable_unprepare() APIs to disable/unprepare them in bulk
>
> Following change also removes the legacy has_cml_clk flag and its associated
> conditional logic. Instead, the driver now relies on the clock definitions from
> the device tree to determine the correct clock sequencing.
> This reduces hardcoded dependencies and improves the driver's maintainability.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v1: Switch from devm_clk_bulk_get_all() -> devm_clk_bulk_get() with
> 	fix clks array.

why not use devm_clk_bulk_get_all()?

Frank
>
> nvidia,tegra20-pcie and nvidia,tegra186-pcie uses three clocks
>         pex, afi, pll_e
> where as nvidia,tegra30-pcie, nvidia,tegra124-pcie, nvidia,tegra210-pcie
> uses four clks
>         pex, afi, pll_e, cml
> ---
> ---
>  drivers/pci/controller/pci-tegra.c | 100 +++++++++++++----------------
>  1 file changed, 45 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index 467ddc701adc..07a61d902eae 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -287,6 +287,8 @@ struct tegra_pcie_port_soc {
>  struct tegra_pcie_soc {
>  	unsigned int num_ports;
>  	const struct tegra_pcie_port_soc *ports;
> +	const char * const *clk_names;
> +	unsigned int num_clks;
>  	unsigned int msi_base_shift;
>  	unsigned long afi_pex2_ctrl;
>  	u32 pads_pll_ctl;
> @@ -297,7 +299,6 @@ struct tegra_pcie_soc {
>  	bool has_pex_clkreq_en;
>  	bool has_pex_bias_ctrl;
>  	bool has_intr_prsnt_sense;
> -	bool has_cml_clk;
>  	bool has_gen2;
>  	bool force_pca_enable;
>  	bool program_uphy;
> @@ -330,10 +331,7 @@ struct tegra_pcie {
>
>  	struct resource cs;
>
> -	struct clk *pex_clk;
> -	struct clk *afi_clk;
> -	struct clk *pll_e;
> -	struct clk *cml_clk;
> +	struct clk_bulk_data *clks;
>
>  	struct reset_control *pex_rst;
>  	struct reset_control *afi_rst;
> @@ -1158,10 +1156,7 @@ static void tegra_pcie_power_off(struct tegra_pcie *pcie)
>
>  	reset_control_assert(pcie->afi_rst);
>
> -	clk_disable_unprepare(pcie->pll_e);
> -	if (soc->has_cml_clk)
> -		clk_disable_unprepare(pcie->cml_clk);
> -	clk_disable_unprepare(pcie->afi_clk);
> +	clk_bulk_disable_unprepare(soc->num_clks, pcie->clks);
>
>  	if (!dev->pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> @@ -1202,35 +1197,16 @@ static int tegra_pcie_power_on(struct tegra_pcie *pcie)
>  		}
>  	}
>
> -	err = clk_prepare_enable(pcie->afi_clk);
> +	err = clk_bulk_prepare_enable(soc->num_clks, pcie->clks);
>  	if (err < 0) {
> -		dev_err(dev, "failed to enable AFI clock: %d\n", err);
> +		dev_err(dev, "filed to enable clocks: %d\n", err);
>  		goto powergate;
>  	}
>
> -	if (soc->has_cml_clk) {
> -		err = clk_prepare_enable(pcie->cml_clk);
> -		if (err < 0) {
> -			dev_err(dev, "failed to enable CML clock: %d\n", err);
> -			goto disable_afi_clk;
> -		}
> -	}
> -
> -	err = clk_prepare_enable(pcie->pll_e);
> -	if (err < 0) {
> -		dev_err(dev, "failed to enable PLLE clock: %d\n", err);
> -		goto disable_cml_clk;
> -	}
> -
>  	reset_control_deassert(pcie->afi_rst);
>
>  	return 0;
>
> -disable_cml_clk:
> -	if (soc->has_cml_clk)
> -		clk_disable_unprepare(pcie->cml_clk);
> -disable_afi_clk:
> -	clk_disable_unprepare(pcie->afi_clk);
>  powergate:
>  	if (!dev->pm_domain)
>  		tegra_powergate_power_off(TEGRA_POWERGATE_PCIE);
> @@ -1255,26 +1231,21 @@ static int tegra_pcie_clocks_get(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	const struct tegra_pcie_soc *soc = pcie->soc;
> +	int ret, i;
>
> -	pcie->pex_clk = devm_clk_get(dev, "pex");
> -	if (IS_ERR(pcie->pex_clk))
> -		return PTR_ERR(pcie->pex_clk);
> -
> -	pcie->afi_clk = devm_clk_get(dev, "afi");
> -	if (IS_ERR(pcie->afi_clk))
> -		return PTR_ERR(pcie->afi_clk);
> +	pcie->clks = devm_kcalloc(dev, soc->num_clks, sizeof(*pcie->clks),
> +				  GFP_KERNEL);
> +	if (!pcie->clks)
> +		return -ENOMEM;
>
> -	pcie->pll_e = devm_clk_get(dev, "pll_e");
> -	if (IS_ERR(pcie->pll_e))
> -		return PTR_ERR(pcie->pll_e);
> +	for (i = 0; i < soc->num_clks; i++)
> +		pcie->clks[i].id = soc->clk_names[i];
>
> -	if (soc->has_cml_clk) {
> -		pcie->cml_clk = devm_clk_get(dev, "cml");
> -		if (IS_ERR(pcie->cml_clk))
> -			return PTR_ERR(pcie->cml_clk);
> -	}
> +	ret = devm_clk_bulk_get(dev, soc->num_clks, pcie->clks);
> +	if (ret)
> +		dev_err(dev, "failed to get PCIe clocks: %d\n", ret);
>
> -	return 0;
> +	return ret;
>  }
>
>  static int tegra_pcie_resets_get(struct tegra_pcie *pcie)
> @@ -2335,9 +2306,17 @@ static const struct tegra_pcie_port_soc tegra20_pcie_ports[] = {
>  	{ .pme.turnoff_bit = 8, .pme.ack_bit = 10 },
>  };
>
> +static const char * const tegra20_pcie_clks[] = {
> +	"pex",
> +	"afi",
> +	"pll_e",
> +};
> +
>  static const struct tegra_pcie_soc tegra20_pcie = {
>  	.num_ports = 2,
>  	.ports = tegra20_pcie_ports,
> +	.clk_names = tegra20_pcie_clks,
> +	.num_clks = ARRAY_SIZE(tegra20_pcie_clks),
>  	.msi_base_shift = 0,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA20,
>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_DIV10,
> @@ -2345,7 +2324,6 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.has_pex_clkreq_en = false,
>  	.has_pex_bias_ctrl = false,
>  	.has_intr_prsnt_sense = false,
> -	.has_cml_clk = false,
>  	.has_gen2 = false,
>  	.force_pca_enable = false,
>  	.program_uphy = true,
> @@ -2356,6 +2334,13 @@ static const struct tegra_pcie_soc tegra20_pcie = {
>  	.ectl.enable = false,
>  };
>
> +static const char * const tegra30_pcie_clks[] = {
> +	"pex",
> +	"afi",
> +	"pll_e",
> +	"cml",
> +};
> +
>  static const struct tegra_pcie_port_soc tegra30_pcie_ports[] = {
>  	{ .pme.turnoff_bit =  0, .pme.ack_bit =  5 },
>  	{ .pme.turnoff_bit =  8, .pme.ack_bit = 10 },
> @@ -2365,6 +2350,8 @@ static const struct tegra_pcie_port_soc tegra30_pcie_ports[] = {
>  static const struct tegra_pcie_soc tegra30_pcie = {
>  	.num_ports = 3,
>  	.ports = tegra30_pcie_ports,
> +	.clk_names = tegra30_pcie_clks,
> +	.num_clks = ARRAY_SIZE(tegra30_pcie_clks),
>  	.msi_base_shift = 8,
>  	.afi_pex2_ctrl = 0x128,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> @@ -2374,7 +2361,6 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  	.has_pex_clkreq_en = true,
>  	.has_pex_bias_ctrl = true,
>  	.has_intr_prsnt_sense = true,
> -	.has_cml_clk = true,
>  	.has_gen2 = false,
>  	.force_pca_enable = false,
>  	.program_uphy = true,
> @@ -2388,6 +2374,8 @@ static const struct tegra_pcie_soc tegra30_pcie = {
>  static const struct tegra_pcie_soc tegra124_pcie = {
>  	.num_ports = 2,
>  	.ports = tegra20_pcie_ports,
> +	.clk_names = tegra30_pcie_clks,
> +	.num_clks = ARRAY_SIZE(tegra30_pcie_clks),
>  	.msi_base_shift = 8,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
> @@ -2395,7 +2383,6 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>  	.has_pex_clkreq_en = true,
>  	.has_pex_bias_ctrl = true,
>  	.has_intr_prsnt_sense = true,
> -	.has_cml_clk = true,
>  	.has_gen2 = true,
>  	.force_pca_enable = false,
>  	.program_uphy = true,
> @@ -2409,6 +2396,8 @@ static const struct tegra_pcie_soc tegra124_pcie = {
>  static const struct tegra_pcie_soc tegra210_pcie = {
>  	.num_ports = 2,
>  	.ports = tegra20_pcie_ports,
> +	.clk_names = tegra30_pcie_clks,
> +	.num_clks = ARRAY_SIZE(tegra30_pcie_clks),
>  	.msi_base_shift = 8,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
>  	.tx_ref_sel = PADS_PLL_CTL_TXCLKREF_BUF_EN,
> @@ -2418,7 +2407,6 @@ static const struct tegra_pcie_soc tegra210_pcie = {
>  	.has_pex_clkreq_en = true,
>  	.has_pex_bias_ctrl = true,
>  	.has_intr_prsnt_sense = true,
> -	.has_cml_clk = true,
>  	.has_gen2 = true,
>  	.force_pca_enable = true,
>  	.program_uphy = true,
> @@ -2450,6 +2438,8 @@ static const struct tegra_pcie_port_soc tegra186_pcie_ports[] = {
>  static const struct tegra_pcie_soc tegra186_pcie = {
>  	.num_ports = 3,
>  	.ports = tegra186_pcie_ports,
> +	.clk_names = tegra20_pcie_clks,
> +	.num_clks = ARRAY_SIZE(tegra20_pcie_clks),
>  	.msi_base_shift = 8,
>  	.afi_pex2_ctrl = 0x19c,
>  	.pads_pll_ctl = PADS_PLL_CTL_TEGRA30,
> @@ -2459,7 +2449,6 @@ static const struct tegra_pcie_soc tegra186_pcie = {
>  	.has_pex_clkreq_en = true,
>  	.has_pex_bias_ctrl = true,
>  	.has_intr_prsnt_sense = true,
> -	.has_cml_clk = false,
>  	.has_gen2 = true,
>  	.force_pca_enable = false,
>  	.program_uphy = false,
> @@ -2651,6 +2640,7 @@ static void tegra_pcie_remove(struct platform_device *pdev)
>  static int tegra_pcie_pm_suspend(struct device *dev)
>  {
>  	struct tegra_pcie *pcie = dev_get_drvdata(dev);
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	struct tegra_pcie_port *port;
>  	int err;
>
> @@ -2672,7 +2662,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
>  	}
>
>  	reset_control_assert(pcie->pex_rst);
> -	clk_disable_unprepare(pcie->pex_clk);
> +	clk_bulk_disable_unprepare(soc->num_clks, pcie->clks);
>
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_disable_msi(pcie);
> @@ -2686,6 +2676,7 @@ static int tegra_pcie_pm_suspend(struct device *dev)
>  static int tegra_pcie_pm_resume(struct device *dev)
>  {
>  	struct tegra_pcie *pcie = dev_get_drvdata(dev);
> +	const struct tegra_pcie_soc *soc = pcie->soc;
>  	int err;
>
>  	err = tegra_pcie_power_on(pcie);
> @@ -2706,9 +2697,9 @@ static int tegra_pcie_pm_resume(struct device *dev)
>  	if (IS_ENABLED(CONFIG_PCI_MSI))
>  		tegra_pcie_enable_msi(pcie);
>
> -	err = clk_prepare_enable(pcie->pex_clk);
> +	err = clk_bulk_prepare_enable(soc->num_clks, pcie->clks);
>  	if (err) {
> -		dev_err(dev, "failed to enable PEX clock: %d\n", err);
> +		dev_err(dev, "failed to enable clock: %d\n", err);
>  		goto pex_dpd_enable;
>  	}
>
> @@ -2729,7 +2720,6 @@ static int tegra_pcie_pm_resume(struct device *dev)
>
>  disable_pex_clk:
>  	reset_control_assert(pcie->pex_rst);
> -	clk_disable_unprepare(pcie->pex_clk);
>  pex_dpd_enable:
>  	pinctrl_pm_select_idle_state(dev);
>  poweroff:
> --
> 2.50.1
>

