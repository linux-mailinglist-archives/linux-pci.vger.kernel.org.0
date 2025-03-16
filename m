Return-Path: <linux-pci+bounces-23873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B057A63323
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 02:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AA73B20BF
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7528418027;
	Sun, 16 Mar 2025 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BGJlwp+w"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012057.outbound.protection.outlook.com [52.101.71.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9F43596D;
	Sun, 16 Mar 2025 01:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742088201; cv=fail; b=IZEThBl/Qd2Lc7255TQZwlPzoWTuy8XpHleicDB5vmHG0hBRpU10JADEcc/45XeuR1SAmSuis32NOMWv/ZIzBBAEjkXQwA2F2tO39T2EqppxNdDd7GcEgXG/lEOlaE9VYwPgQ9ijYn60QmucQRBHvm5SW8xwEmTydxuztpgeMAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742088201; c=relaxed/simple;
	bh=OAlMwFDkFgnhQUxwIInW5la3Fv45NO9zoIAyMUmnwTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5w2Nh+x9hKszKKHDsdDQmK7Mr2WDYmVWDe4E/b93ukUb/F1duA9bEWhH7mkEi0Hlwa9j+PSkbljdFPfs7rjB8JjBObbWCCHJ+yR6Hvqa0qPSojGOXFDzpRvmYX8MScH9E7/7SPnqLLPn1q62QmXfYvCZ2RRYcwnvm452PEI/EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BGJlwp+w; arc=fail smtp.client-ip=52.101.71.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eP6oueMfly4Q9mBS41mUex+PF5BmAmBAnsSNuOCtxyd5yQQi+22CcRPksDfIXGwLLZqEmn8Ql9t663wScA7ReGFe+t+ljJdNdMhBV0ZS7vrFgF/B9cPUn77j6qXCVxKrbSnEH+vU2lt7K0O2fYIdWx5UukcAJ1Ls5UQC/y7X1JDB9iqVilnDzuMrxj7S5rx/SO45myS6+cSb5i73J7jWRVfE9E9ktY4Zlf6hRTsD9Mt/rvlTXcl9iRLb+b+We9P8XlzIGSPeElNf9TR41HztsIrsghUNGqUNicxHx5AmJqpCpLFLY1BjCu1c0SDyZPEM4rCJSHvP6nToD/m3F8B5rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTRqyGy0dR9terAJ/ifdjGlAGpvpT88XJT4ARjHypd8=;
 b=MkDfAsCb2OY637caH/mjtDkvS/Q0klNr1Axzw8q6WlgqmY1NeGy4gGG4fcLGLgEW0aFjbVtV27thvU+5mVwmwcoUPVCJiN9+YOcUol5bym2FGQYRtwbn0v62wMWXkgkQ1tvdvt6eslKJiPhmTEHAcHEqFK9yIeLFD1AFF8wrKwmiOrJte6z/QcpOq0MPsr+nGt1AysXyyC4R7nkQNnYGR5Psfn9uW6R5aU2qyUsbwKemH2LMSUiRgdkQzLC90u/lQx8eGQjiDnKSMQ4rxYHz1u2I0gFYw6AJEdkmXRHnDUr/B2/Wd4gqhxy2GwzC3dBHGdx8Av0yBFqJ1QS+bqi+FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTRqyGy0dR9terAJ/ifdjGlAGpvpT88XJT4ARjHypd8=;
 b=BGJlwp+wueIIERYXfan5SYWKFNloLAtWTv/zZM2/mIdtLsmJsnj53mNP/Fr7J+pdFTwdnxEYt0GMyKBfb2qej3SBgQEcO05f/6szm4CsaiLNe6ObLAuHLiEjYCXegoX/IZvxc5n+UzW0lP46eQvW2LTwQqtwJksUY88fHs0Jr0Ob4CHygLzrTGvKp/qdgQ46mPGqq3R5WoW54d1TdmhitytEFQ5Oehc94Lo3WWiHWt073aaisgoUu3O5+Dwreo/v5c6Jcw6rMl0x7/8+GAwoR9/dsEGdHqgzsym6GTgVbbQkA2FFplUNO1aksDvl2QEg8VK28N506L39JIXMtV+KAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Sun, 16 Mar
 2025 01:23:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.8511.026; Sun, 16 Mar 2025
 01:23:16 +0000
Date: Sat, 15 Mar 2025 21:23:06 -0400
From: Frank Li <Frank.li@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Niklas Cassel <cassel@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v12 06/13] PCI: dwc: Add dw_pcie_parent_bus_offset()
 checking and debug
Message-ID: <Z9Yn+uY63X3Qm8ZZ@lizhi-Precision-Tower-5810>
References: <20250315201548.858189-1-helgaas@kernel.org>
 <20250315201548.858189-7-helgaas@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315201548.858189-7-helgaas@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0059.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: deb9e592-16cb-45c2-1292-08dd642920d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iLIcPqd8QfEQjvHYfLc0Ve8M/c1fibdgYUpIb3C5YRPPJojGo+sdei95oKzL?=
 =?us-ascii?Q?DVo8nE2XGXVmBaATzxIEqMhFGC/4lwWUl8Xt7qZYKktHKoWP2/mmTS5ttQvR?=
 =?us-ascii?Q?ZQGK4f0GuRsV7mkOcAAWtL9aNOO62aRVRXXf5WktFK9nNaLOK9oL+BTTLZzB?=
 =?us-ascii?Q?MOH7wKqPsHRIi57AbCnaXK8JytEKp5x3YUNNhmBVEZbRLI2bHo5kIpMVGd7W?=
 =?us-ascii?Q?VFzYwV5dAxERnpuLEpb06nibG3prhTPT9Yvhc3UWcQ8J0AvFKDGg6WvGm1fo?=
 =?us-ascii?Q?R10ONCAY2yLWlfHm5gSifdP50u/kCGQLgMuv/Q7zIbzwgsiLuS86epZqUUdS?=
 =?us-ascii?Q?lvCoheLr2bnjDsSpCkX1/w8HuA6LTvdbKnqqxXziFy0AVbXEjzSW/MuvGk52?=
 =?us-ascii?Q?tlQn3VEpOh99GLXTYgmIE28vm1tdm9zhthBbhEsWiynusHxCmQuTlSCzChsq?=
 =?us-ascii?Q?MxHDrAXtZy5TecMJzT7GgJXW+tliW7PFYp5U5SV1OnGMhoqfDqpOkFqc1oSS?=
 =?us-ascii?Q?sxCRmwTyDvcHcDQoVRANotgFOb69U42SotOtrsEjhHxXxaLmYB/3yo8aXXrD?=
 =?us-ascii?Q?TkcuUJU0j3iQcFRkk7QmzBkGidgJR5F7MHndUD5up8myHIvMjKmwv2PwCMAF?=
 =?us-ascii?Q?1fu69ohlTa5I4/gzQ9TBGh5Rw5PReVabm7WHeS9l24D40N2oes/8+90I/Vv6?=
 =?us-ascii?Q?+P+jndnYvSBOp/HrmWqsyZzt6jek/7X+7SpAxsVtq5zFeOUtsH76AdJBu/F/?=
 =?us-ascii?Q?5Zy8XEMP0Yez30Yfr/Uv8iPZoTTNW8yD6JcogiEhOcJ7QNLbCq43x3es6zBf?=
 =?us-ascii?Q?NY/O1oL+oLBoPG5MskDJ+dG1XvS6801IeionwZWpgTWqExaWKWQxKMuRP+sE?=
 =?us-ascii?Q?KhoJNwLtVBkR2iafN3Tu1OZEzclIAMT3YT8pxbvDFxeN95unJCAshB+87wrX?=
 =?us-ascii?Q?KfPCgfwAaYr9GDGtR8CfCICQv5j+bQmR3KAqu6i8qd+eoaX6ksf6f3TyROdc?=
 =?us-ascii?Q?6kTfx7bOWDa1bodj8C0FAHEG5nmgorXIEhZPYKizSCQARfhhNm5XDSo/ShCN?=
 =?us-ascii?Q?nJYcU8QshIoUkvni/myCsDTY07Z3ErchbVrayod8oE0MLshE9zFm4nMLY5mk?=
 =?us-ascii?Q?bxs6u3e1JtGt6sdlbelcu72d/5Rzhz3aaEx5PjZrdHVKZN+uqRS2MpWINY5E?=
 =?us-ascii?Q?SYbCUNc+VpFBBv4D05yGd3tyjrfWi+HTs+P0yjYc0DJdiu11VSZeQEugs/sm?=
 =?us-ascii?Q?toiJRu/KipE5/ndteCeS99FZ4A44IMwr4qS2VsWUO1FUCcO2cVPYlyOkIv95?=
 =?us-ascii?Q?FffVpzECbgLorSzAxugroiU1rQpfA0wqfS3kjQ8wYc1nHT2jtOkmQdfP0YmX?=
 =?us-ascii?Q?wwHBzKZJlNnLweTZtPAJJ+PJ/QHqjRjQX52NviOIDTpfIVWeb8LuvDLYuTlp?=
 =?us-ascii?Q?ZKY7F7coJ4EbMuo1YFyO6lZ4REugna9j?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XV/3D2/1fU8z0z79xoHb1fGcAj5B4QnOFuhaFS4mdG7tnKoCbKM/8Be2NxFs?=
 =?us-ascii?Q?hLDh/LhacR6HGxUYZn2eeeGaDhJHrt/4fimvbkEu0t2nN+6P0Lz6Bh9V7URZ?=
 =?us-ascii?Q?6DwUFcYXnVt5xAYzCI6nno+uMZr0TtHaSRRYTbN33YEzd3WKbUo0VS9WIJrJ?=
 =?us-ascii?Q?BJshPLWHO9CI5hXxqQH0QlZmSq/i+664+7QwHZB0m6X17No/9DRKFUXesgTL?=
 =?us-ascii?Q?4aSf/dE+GFdH8IPQ+GzuRV7euIg9a1nbN6DAIgebz80CFFIaJwahp0FiJbDL?=
 =?us-ascii?Q?GCIlns7XAy02QX05aWQ1wXWbx1rzk2XQnkcFgvNVGUNg9tQFvtReAGM7WEsO?=
 =?us-ascii?Q?8cG4RO//CotWmsHb14rlDJ6ipnfMxecjojMPZOYFqNaC1CPlw6pVTVR8tq/v?=
 =?us-ascii?Q?tRyX0/Y5DiNWvkh+klif4dQVTCOBy0LxhW4Rvf5J6i7kY1ALAIJsfeAQHIAP?=
 =?us-ascii?Q?ia+1CxUbXSET24YRnpm77DlPCpfUzXcR/baWbi1wKo7vDeAIfKlkIzFkOBwY?=
 =?us-ascii?Q?mbZHWZ70vFkSc3u77YCfbEJ2CBJ4xOhhowT512EXs/h5RNzAk8pRTL7NMVIf?=
 =?us-ascii?Q?Aot0/5Ywe5GffhAP+C2yo53emQs1b4ReVs+z4C8dwzOEqdnr3RVOEkB0GpMA?=
 =?us-ascii?Q?jnn1U/gSmpMLcnJz6/Yrs0hHMDTBYS9WjNuudqYSuFuRCy+pSfb/zK+tlMXG?=
 =?us-ascii?Q?Grm2XEtkNmWoaGKe/MrTDx3LEO+9arESDN2jgNsBEzEuYVNSuljGVbef56IU?=
 =?us-ascii?Q?ap/nojGEiIruE+tUPOnEnRzHw9a/QzwHV4Zyx6U+fR2AAbcZ1aqhGULjmetA?=
 =?us-ascii?Q?4dDYgJhnL/FMu3vjql5pxw6cTcAFKr+iMUYE1gPNLuNeovnB7YuwuDOTqZRD?=
 =?us-ascii?Q?WT7us9b3qJQAziDYvYYHRbYPZRwnVDBWy+K0lDM9AwS0d59bD0Sx7RU72JYv?=
 =?us-ascii?Q?yK2e0MZBdS4YairHtom5PiZtRScPH76o/z6aJyWa+7VF6XqFiXAL3bwvPfO+?=
 =?us-ascii?Q?c+Z+bSay1D2UlUG8EYQkeXMNZMkSkBfuaA8vZS8nZHIuJZabULD3sKlSCc7T?=
 =?us-ascii?Q?FJAm49F/5Wgx+p7i3X7mxw30ygoHUgIDHzsLanGWWAuugnDysr1Tv1nE2HzZ?=
 =?us-ascii?Q?1I3i5kpIH9rJIqwsKQmCZoGeg3P0v4sdaMFN3kSjX06pk1Mj/koNhQpT0ypS?=
 =?us-ascii?Q?tlOKqz0+eSDsVLpRK/TYAy/t+LKIxSXXfnFMdVXiByXapbDIV8k3YKwo3uGo?=
 =?us-ascii?Q?YIoUCMaeE7IfFOxBgKQwccJvz9m7i5ttyf9IWl2e7HJA4BnH63rJkHA4jtcr?=
 =?us-ascii?Q?bHfNy77LFlvc4FcIoUCqfemahmb03/Gu5AWZu13DSlqs/TxfmOr0UJlbGW36?=
 =?us-ascii?Q?jnHvj0zlHTmU8ZhCEu6+4s1LK4JG11f0zcT+E+zO9AHpUw0yzaZzAdp64LY9?=
 =?us-ascii?Q?8RbNEikJIC9ZJW7GeYz4BP7UsKz/I7wu3DbiGcIEQGIA5mpv6bhSHYd/x5Tp?=
 =?us-ascii?Q?GaNyydLY2mVnXCr7cU8I3dmZ1hd1UMavpzNw5TZ6/8cbsxHQW/ZywlaY5n/w?=
 =?us-ascii?Q?Jns6UmS+13/7D3IP6Ng=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb9e592-16cb-45c2-1292-08dd642920d4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 01:23:16.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEXLEucQHczK/omyKN3E/+J2sQODda/ipQvJFBomq1nm2s/qOSs02hkIkVfn7taIhnOIZ/eDmOTgJj/MYaElpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

On Sat, Mar 15, 2025 at 03:15:41PM -0500, Bjorn Helgaas wrote:
> From: Frank Li <Frank.Li@nxp.com>
>
> dw_pcie_parent_bus_offset() looks up the parent bus address of a PCI
> controller 'reg' property in devicetree.  If implemented, .cpu_addr_fixup()
> is a hard-coded way to get the parent bus address corresponding to a CPU
> physical address.
>
> Add debug code to compare the address from .cpu_addr_fixup() with the
> address from devicetree.  If they match, warn that .cpu_addr_fixup() is
> redundant and should be removed; if they differ, warn that something is
> wrong with the devicetree.
>
> If .cpu_addr_fixup() is not implemented, the parent bus address should be
> identical to the CPU physical address because we previously ignored the
> parent bus address from devicetree.  If the devicetree has a different
> parent bus address, warn about it being broken.
>
> [bhelgaas: split debug to separate patch for easier future revert, commit
> log]
> Link: https://lore.kernel.org/r/20250313-pci_fixup_addr-v11-5-01d2313502ab@nxp.com
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 26 +++++++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h | 13 ++++++++++
>  2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 0a35e36da703..985264c88b92 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -1114,7 +1114,8 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>  	struct device *dev = pci->dev;
>  	struct device_node *np = dev->of_node;
>  	int index;
> -	u64 reg_addr;
> +	u64 reg_addr, fixup_addr;
> +	u64 (*fixup)(struct dw_pcie *pcie, u64 cpu_addr);
>
>  	/* Look up reg_name address on parent bus */
>  	index = of_property_match_string(np, "reg-names", reg_name);
> @@ -1126,5 +1127,28 @@ resource_size_t dw_pcie_parent_bus_offset(struct dw_pcie *pci,
>
>  	of_property_read_reg(np, index, &reg_addr, NULL);
>
> +	fixup = pci->ops->cpu_addr_fixup;
> +	if (fixup) {
> +		fixup_addr = fixup(pci, cpu_phy_addr);
> +		if (reg_addr == fixup_addr) {
> +			dev_warn(dev, "%#010llx %s reg[%d] == %#010llx; %ps is redundant\n",
> +				 cpu_phy_addr, reg_name, index,
> +				 fixup_addr, fixup);
> +		} else {
> +			dev_warn(dev, "%#010llx %s reg[%d] != %#010llx fixed up addr; devicetree is broken\n",
> +				 cpu_phy_addr, reg_name,
> +				 index, fixup_addr);
> +			reg_addr = fixup_addr;
> +		}
> +	} else if (!pci->use_parent_dt_ranges) {
> +		if (reg_addr != cpu_phy_addr) {
> +			dev_warn(dev, "devicetree has incorrect translation; please check parent \"ranges\" property. CPU physical addr %#010llx, parent bus addr %#010llx\n",
> +				 cpu_phy_addr, reg_addr);
> +			return 0;
> +		}
> +	}
> +
> +	dev_info(dev, "%s parent bus offset is %#010llx\n",
> +		 reg_name, cpu_phy_addr - reg_addr);
>  	return cpu_phy_addr - reg_addr;
>  }
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 16548b01347d..f08d2852cfd5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -465,6 +465,19 @@ struct dw_pcie {
>  	struct reset_control_bulk_data	core_rsts[DW_PCIE_NUM_CORE_RSTS];
>  	struct gpio_desc		*pe_rst;
>  	bool			suspended;
> +
> +	/*
> +	 * If iATU input addresses are offset from CPU physical addresses,
> +	 * we previously required .cpu_addr_fixup() to convert them.  We
> +	 * now rely on the devicetree instead.  If .cpu_addr_fixup()
> +	 * exists, we compare its results with devicetree.
> +	 *
> +	 * If .cpu_addr_fixup() does not exist, we assume the offset is
> +	 * zero and warn if devicetree claims otherwise.  If we know all
> +	 * devicetrees correctly describe the offset, set
> +	 * use_parent_dt_ranges to true to avoid this warning.
> +	 */
> +	bool			use_parent_dt_ranges;

Look good.

Frank

>  };
>
>  #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> --
> 2.34.1
>

