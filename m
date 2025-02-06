Return-Path: <linux-pci+bounces-20816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5AEA2AE8D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 18:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5C43A0681
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 17:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABC8239580;
	Thu,  6 Feb 2025 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gKfWUuG8"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8BA239571;
	Thu,  6 Feb 2025 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861891; cv=fail; b=g+2keLpV2+QCZm5kyPskbAfmTNmaloI5WXu34QhaYmWDI4x4CYUrVNTXM9AKxOPOXsvXMJQ75z/Ur4rBitTXZBpJvOro+WoPfXAQpqITy2/U2tuwGc3OnDCUaUVCiJHY20OljOSc+5rto3JVRab4Kupr8cRXYDMRwdUWNxdi0IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861891; c=relaxed/simple;
	bh=T2msmQgt8rmN2Y9r1JInjWfplqhpcYKCbINmjA2c/RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K0LNmF20Njn8+Aw7ED3Q/nBwQ6lFQD3fvduJ1MEDrBM0J8D/41heP7LeSX/NBZOBTOpqHW06euFniwBvx7IN8NbIw8AyA/9m1iEKB/FMJKw/i6FKvxZDv1s3bnQjg6ZdVgOk9buAGxOMS3nZO0le/u9GDeHXRJ+0qDh1u7AWHSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gKfWUuG8; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hv8uQoCObxhhi0ityT1gdMtR6hDXZvZxXUI/d8jD16087NLDUFujRhRHEjC7k6vsBSsUgcati4wejT+2QBr3py6LvIHUbRj4JVXyYmN5WnUMVJWffYlYqQhH6Fjk5gK6le6sUOUEKO89hHdHBcWmNSOJMnRKmid2Mmf8YgM6Gyimf3PWuYLPBk0N1PsiUCid5aCHDpM8TZvpf99hNFqAPkMQm/IZfFyo4QNWdAyxfa7ge2RPP2oYx5Db8rpRka0fH/RmeI+4lx+PrwvRnptnzjIQsMpVS7XG/FDW16rwNp3+GMv1EjaXOUpNS4dfmwpppP7fe8MWitC3JjE7istNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5L0PfUavdPDVaods/zk9DyFg8uiVTZINnGiOLT9pW0s=;
 b=GeYks2eEJbceF+FE7NaS1RF5tjdp8QwQ2bUzMaY+nz8DpH9Hf8id2REcOlkHYkcJ97m+LTZ6Vl/Mk7JJjo8WyDXywWA6XqLnnmir5U+NyjDqdrP6jeBEYv4jLviMogA7l8BCgaQdRRKc3cc6RLXZpoXE8P69IJJ23P1oYjwa4tjP7BwHWj/UYZq5ldUxCYRqce87ZiormDrRwL2hbPBqgSPm+IOGKOxOPdsAS2bqbVYFwZhfJaskobRIZDJk18stz4ZK4+c+WS+TOHIm6IfFjmsIDcKEmOxZxfePhpXU0fmuRdUULgXZ1gGKHHzIMd6n0OLitQBKjbOoa4mOrYqGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5L0PfUavdPDVaods/zk9DyFg8uiVTZINnGiOLT9pW0s=;
 b=gKfWUuG8mLAtb9Eyytn6be7C2Y0jONDM0VYITc+BHSGDBvhbCSK+hpBXvuElT6sAd5ErOcEeJFWedJvd74u2GH9p7HuQ13C3tGKAYu44VKz5aJ25c3mLC/0n+8YD0MVT2WuH6pTvWr/QfyxcJTEBS3KDNubh/OiraNl/k5IO3o7vz6SY774M4V9KbidikbZqZLAzoZxiY3Y9IqMGP2u2oQGStHZD0EFZ3HH50U/Bg1ZlaVEk2BxT4lMTi1GjnjSpvIEK7SdlzfmEFPRx/T8MQvLVroNrmXDQKKMfMgrIDGkOUFpNt1J+f1Wia+GXaQqZoTB6UW6lp7551FOXLJVhsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GV1PR04MB10869.eurprd04.prod.outlook.com (2603:10a6:150:213::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 17:11:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 17:11:24 +0000
Date: Thu, 6 Feb 2025 12:11:15 -0500
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v9 3/7] PCI: Add parent_bus_offset to resource_entry
Message-ID: <Z6TtMyik/gv1VqGg@lizhi-Precision-Tower-5810>
References: <20250128-pci_fixup_addr-v9-0-3c4bb506f665@nxp.com>
 <20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128-pci_fixup_addr-v9-3-3c4bb506f665@nxp.com>
X-ClientProxiedBy: SJ0P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GV1PR04MB10869:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fc22a2-c092-4122-b9a7-08dd46d1488b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gjOIqWCm0ZhjKVG+VvYDWp7RMlRZLL+xGB3LywpAesZ5WQRz5A6gioQGEq0P?=
 =?us-ascii?Q?wT38Pxd7/Fm26AiWQc/mS9phpjkBKVj69QWgR4LrrWL77ohaRdYCSaCqfQvu?=
 =?us-ascii?Q?XIX0O+QgObuwpV/1fPhkYcS1FLRltL+0X2GklQ/Ocez1P+VOZdNmdglwQ6LO?=
 =?us-ascii?Q?Uyg/bBjrnBUX8Qq5g1aWdQspN45uzTtGMeOf3aiHUOhxgeoQTfInH9A0w+eN?=
 =?us-ascii?Q?B36NllOHfIzfETd8kehOF+qmFnBlFUfKdtu9US5Y2Zcb/kJ6z9nd5wYnFS2L?=
 =?us-ascii?Q?k7RLhaJpwLXTLy3JzXa6GhU+Ar7LXI7qIyIl3Pbwh5Yjlb3vWSaGRdniqruw?=
 =?us-ascii?Q?bRf1G6rbg7ODz1PZuD66QF6I0h/NcbXg6KNRneE53CQf53QqmCokx7NwCC/F?=
 =?us-ascii?Q?GOg0cEqhnWMqNyN6gHgeYv2ikwJN429cAEqWwZRhPLerqACz2yBNvYWQiNEP?=
 =?us-ascii?Q?IsiBadteLElFEi9qoKniG+mnQFfZNHgbtjLWLv24KHzLI1+EJ2GP660aeS7q?=
 =?us-ascii?Q?HvQqLDmi437yTTqAhfeV+3fn5WGeglzoBLPDQmcbAtpNa0/Axk6N9ekLD6DI?=
 =?us-ascii?Q?/pOfdcsR89FmDsDD0AdPK9LcK4Nv+LUcFXz6VxANmYImiLA2HZV3qO1EfBC/?=
 =?us-ascii?Q?Esbumg7K9yZH1LDbvNATVZDocjiCHlq7YMo0XhAM7d0lml6hJc/dzRVU+eej?=
 =?us-ascii?Q?ZgaPQgq7FtTgWhWFwbVtxJvCgfgF/KwQrx0WzgVrOScbENanGcYbJzKR2sXZ?=
 =?us-ascii?Q?7O9jO2r1FDFu78FTeextu58JuDg6zTHlmrGz8xYORAehu3UZA4wN3gjI5vNA?=
 =?us-ascii?Q?46bjmPXjHrUrasRaCZ1gzRK5ErX5OxYmvesdLZbowKNrosSjfb9VEB9xXLBn?=
 =?us-ascii?Q?GEVgb+qQP+SLaAg/OOKTfouV3aHZYBkUHkeqMAJsmuHTGewvH+1XgRErsrHa?=
 =?us-ascii?Q?NhxsYYdcOWChiWbfBg70gQmXS/C/PxXU36ZNCffNf31OGeEq5L+FSe8+0OhB?=
 =?us-ascii?Q?JA5AzEFLxE3kHGQwkbeD/4wF1P+yri1S/dKAKBUmHrywO9PCTMgqAsnrIyTj?=
 =?us-ascii?Q?yN6HFnSSyub6hx+KLXHkY31nXpr1Vg621/ou+l8K2rlUNPhyUjVf7k8YWshQ?=
 =?us-ascii?Q?hMAoXhOx6gKJbY8ZOT8zUy0pmyhq4esip3rsorTRTpD9cR8ngw9JdnE/hbFh?=
 =?us-ascii?Q?PDpyHVStFvC/6ehZdojw//+6pK/9uHV2L6TlLR4tSTcPmt2QDoWW8SYVFmQh?=
 =?us-ascii?Q?kyChnQyW9iXzfzhlcQyVMM6ynpvwUO1FxjAKvYw/FDZhcevaSzYZYIsex5LX?=
 =?us-ascii?Q?P6xeUEOG4urTnAlMsaDWuNZMCPwXiZFaeCqh7NXFDtlO3FioZv4ctjtrOMKY?=
 =?us-ascii?Q?k+fhSSPgZAG7++mqLlAA5Zf6VPoejUf9Ttdg9pH4ZlzuI5+BdrtNH7rkb+9u?=
 =?us-ascii?Q?aZdWrfOb62Z6QfMMDGnG5SQDiR4JliydX21XJA3+bGuqoPodjdXYzQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofGlvcvT1xpxYPg1t/acru+kvvrxMuABqgOw48a4Mpy29V6mbA0CuqnlHWKc?=
 =?us-ascii?Q?M+Bw2RicvEkVJTlJ8Lc7Lb4Kc6Q2UA2hF+lRSDRTHa8opwopVEViHO6iXpqY?=
 =?us-ascii?Q?lu/+BqeqO4z2GL6KcYjH3ByJWQm0wmzh4QEwN+VDeamnOx+UWIjBli84pgz+?=
 =?us-ascii?Q?p1Tnx/i4UvLhE+wnejhZ1eKFIRJMiFuek5nXTA/9UVnzrmVoX4Im8w6k1WbD?=
 =?us-ascii?Q?jO79bCS+NTo1hBQKedyZa1Ew8vh+DF24wslA1qhdBnw9dko9e3y6kOnLI7Ed?=
 =?us-ascii?Q?dNX01n5bbvOvSVzIAp6mGC4uhOwi9zPqp+EVyj8vA8CgjdTklw1IdEzBfHpR?=
 =?us-ascii?Q?66JQsP5aN/I+jbEZ7M6fJzRLuoWhQAGPhOaIcpmxBPEfzkMPhgrJY6g5aoh0?=
 =?us-ascii?Q?1fjG5jkFp4t/uWkd1rkxBk9KhfOX9MyEEclr1UWfText4WaNUjOe87yoK47Z?=
 =?us-ascii?Q?4bk5zVhgovtClDcmnEPuVCsMKGZXQ/GDWm7T3YIEertyTYQg7xY/bOFbdzRs?=
 =?us-ascii?Q?pD8IOTswhlXOHCtd+5QOcMYnzEgNETsRXSYGfEbyHSWAFI9zEZuhU2qUL9OF?=
 =?us-ascii?Q?4Se72lQ8N/wzfZsCZVOCGHE1UWV1lUn7ET+Z7MrcsUfd9YQi5xTmL1JFDVNh?=
 =?us-ascii?Q?X0R5J0IKxiNddWtxxVPVmGX2D88gHbqU6zw2+VTsEB2UKYBRWS5Yp6afuHEN?=
 =?us-ascii?Q?HSKE56WfzAvxRG44zzPPooF84oy1l29eprvQiEr8M37A72baQTc/C8x+RlUY?=
 =?us-ascii?Q?z5a1MUu6jW5ktMdgHxKtg/qPcAtt+YfY7WFXxBr+zv2o6+dc70CuCDlki5Tu?=
 =?us-ascii?Q?ZELjJywLcDEpoZj+3pLihYx/jzXk43KkFeCrHPtxNtVkcFMuNHiVNswJoLAt?=
 =?us-ascii?Q?sp21knpmf1omK8nefiTQVsbHXJrL8NvqJTKp6JWFb6pDlgnKfZMEL5/gjr0b?=
 =?us-ascii?Q?ooNFnx7mQ2lvRMSi8VhnhDMWzgUe7kjcwo6caV81NRA9fP7LfaJTqyRCchrx?=
 =?us-ascii?Q?vLuFfY8ct4y4yKf5QXuVltkQ+dp+Cuhpp8hYGT16XGJc0WUYIMgx+akJiCu0?=
 =?us-ascii?Q?50Vwu9lUtdA8ayrZaENY3wglvDRJ5kIydtib3XfG0sVMvAoNPuHmXm+xQSDE?=
 =?us-ascii?Q?yhKMBYE8de2bjcKtsFJAPNHrwWqguLhob8J1GKxve6Rigi5XsqvYfd1PEppv?=
 =?us-ascii?Q?Cdd4qR35JdByXBPGK9vTxOJWLrpiP4573gUIHyG1TGIddaL4JX86Io09QUOh?=
 =?us-ascii?Q?lePSBalGxoWMqw48dHcnd6L0/QLNpZX10ZidauY8CuCsjv4/9l1NL0x4xXp+?=
 =?us-ascii?Q?HeTI7T2oPos36uoALbRKL23iii6wrYsRJ1JUAXcRSRcmM1TKM4HYUA0eWJUM?=
 =?us-ascii?Q?kF6vxVcQq8+jCqfEcVX72EDmajFfT7J1UkKQl2+fLZhGqZjweIZuMPPiOYGI?=
 =?us-ascii?Q?Ji0KLl35sXhs9AuDopeD9A3ySaqr8DhSpujsUNXlvkT0T5cmULyezzgGNbKt?=
 =?us-ascii?Q?0++7k2pW4SDlj4ItLZX9Cmsup9TirTSg0nD9TKCHJHTLLsrKdTTcF/Melggr?=
 =?us-ascii?Q?e2u1xdNdFRlHsSSHjig2I4sfR3qeQzXQ1D8A4LQW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fc22a2-c092-4122-b9a7-08dd46d1488b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:11:23.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PR8lGUHsrVcd+ybEUm7OYSM5KN13lKCeaUzep8pxFA+SIzFed/q4MCbSV57kXcZIBz8w558kxpekCG9rpI7Izw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10869

On Tue, Jan 28, 2025 at 05:07:36PM -0500, Frank Li wrote:
> Introduce `parent_bus_offset` in `resource_entry` and a new API,
> `pci_add_resource_parent_bus_offset()`, to provide necessary information
> for PCI controllers with address translation units.
>
> Typical PCI data flow involves:
>   CPU (CPU address) -> Bus Fabric (Intermediate address) ->
>   PCI Controller (PCI bus address) -> PCI Bus.
>
> While most bus fabrics preserve address consistency, some modify addresses
> to intermediate values. The `parent_bus_offset` enables PCI controllers to
> translate these intermediate addresses correctly to PCI bus addresses.
>
> Pave the road to remove hardcoded cpu_addr_fixup() and similar patterns in
> PCI controller drivers.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---


Bjorn:

	How do you think this method to handle parent_bus_offset? so other
pci host rc driver should be easy to use it.

Frank

> change from v9 to v10
> - new patch
> ---
>  drivers/pci/bus.c            | 11 +++++++++--
>  drivers/pci/of.c             | 12 +++++++++++-
>  include/linux/pci.h          |  2 ++
>  include/linux/resource_ext.h |  1 +
>  4 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 98910bc0fcc4e..52e88c391e256 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -31,8 +31,8 @@ struct pci_bus_resource {
>  	struct resource		*res;
>  };
>
> -void pci_add_resource_offset(struct list_head *resources, struct resource *res,
> -			     resource_size_t offset)
> +void pci_add_resource_parent_bus_offset(struct list_head *resources, struct resource *res,
> +					resource_size_t offset, resource_size_t parent_bus_offset)
>  {
>  	struct resource_entry *entry;
>
> @@ -43,8 +43,15 @@ void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  	}
>
>  	entry->offset = offset;
> +	entry->parent_bus_offset = parent_bus_offset;
>  	resource_list_add_tail(entry, resources);
>  }
> +
> +void pci_add_resource_offset(struct list_head *resources, struct resource *res,
> +			     resource_size_t offset)
> +{
> +	pci_add_resource_parent_bus_offset(resources, res, offset, 0);
> +}
>  EXPORT_SYMBOL(pci_add_resource_offset);
>
>  void pci_add_resource(struct list_head *resources, struct resource *res)
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 7a806f5c0d201..aa4a2e266c55e 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -402,7 +402,17 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  			res->flags &= ~IORESOURCE_MEM_64;
>  		}
>
> -		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
> +		/*
> +		 * IORESOURCE_IO res->start is io space start address.
> +		 * IORESOURCE_MEM res->start is cpu start address, which is the
> +		 * same as range.cpu_addr.
> +		 *
> +		 * Use (range.cpu_addr - range.parent_bus_addr) to align both
> +		 * IO and MEM's parent_bus_offset always offset to cpu address.
> +		 */
> +
> +		pci_add_resource_parent_bus_offset(resources, res, res->start - range.pci_addr,
> +						   range.cpu_addr - range.parent_bus_addr);
>  	}
>
>  	/* Check for dma-ranges property */
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa5..0d7e67b47be47 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1510,6 +1510,8 @@ static inline void pci_release_config_region(struct pci_dev *pdev,
>  void pci_add_resource(struct list_head *resources, struct resource *res);
>  void pci_add_resource_offset(struct list_head *resources, struct resource *res,
>  			     resource_size_t offset);
> +void pci_add_resource_parent_bus_offset(struct list_head *resources, struct resource *res,
> +					resource_size_t offset, resource_size_t parent_bus_offset);
>  void pci_free_resource_list(struct list_head *resources);
>  void pci_bus_add_resource(struct pci_bus *bus, struct resource *res);
>  struct resource *pci_bus_resource_n(const struct pci_bus *bus, int n);
> diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
> index ff0339df56afc..b6ec6cc318203 100644
> --- a/include/linux/resource_ext.h
> +++ b/include/linux/resource_ext.h
> @@ -24,6 +24,7 @@ struct resource_entry {
>  	struct list_head	node;
>  	struct resource		*res;	/* In master (CPU) address space */
>  	resource_size_t		offset;	/* Translation offset for bridge */
> +	resource_size_t		parent_bus_offset; /* Parent bus address offset for bridge */
>  	struct resource		__res;	/* Default storage for res */
>  };
>
>
> --
> 2.34.1
>

