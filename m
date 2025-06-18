Return-Path: <linux-pci+bounces-30122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4302AADF5E4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A6A189865A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 18:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE52F546E;
	Wed, 18 Jun 2025 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oAR6OMGK"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011014.outbound.protection.outlook.com [40.107.130.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCE92F4A05;
	Wed, 18 Jun 2025 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271549; cv=fail; b=KNrlQw0WIdiRvnX9GG6I1EdWUI4PWbcdUaZw+QtzYnr/DWMFmFXj26/4bNZ2aVeB3ITYwXreeTbcgpyZvVu21taNV+sGlFisyEzad33s5+QQFbo4bX5bm4Kb2Wg7AeLjUXlYamnmBEmSPdq4vZkB5DzXrQ6dNTtJqnP5loOOeOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271549; c=relaxed/simple;
	bh=w/PAD4qDSX818tyw7EDU9+lvMxacI14ek/gEAhOiNAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Tf+ma1RLRAGrRhgrIdhtBG8IJGRI3prgOlX4cEnQ9OxGToar8sd3+/tTXmBbExUtvREQz0sIY8LbyX0UAOHTkptzVMG0YOsRPzvgtQ4lbrmQ2mmzx2AKBLcBrrbQwMwq2xmW2MbZp2gRkPgYql8H2cm8khswaO5FJyj12wZ9FVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oAR6OMGK; arc=fail smtp.client-ip=40.107.130.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syLuNYMUS7z0aZSP5/NAc1bhxpqeOWjIjtn4Hdg6SsYdiP50uy5DUfe/nizaK5V7gf2marqGews5dWZPznWzmJMBsIcPI9AbVNim38BSFHMp4kU+4b3lESHi2eqNJrwCRIsile1uO8DFHrNtDI8oAWhKNKFnp+1By4ElE2CQjz70RVvbzdGC07FujUp4210/CwkW6W37F7pNqDaxmQh9o06xZBXsFuC/S9e0tUB+yZK6rebD8JLiNXia4gTPviLuhkst1tKZOyAfgqWSBh4NSDupGHbkl77q37R3x0CtF0JH2aW8/Iv5Nu1Hsfr54I8UEnivppaxrjo6fhIyJoLMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKBx1mcArlB7aOeVPagEgqfLAetQ5e565Gsm+/6dIX4=;
 b=hkvF8oQvnYT7jHasDSezg596Ciyye5S6xa9u4Yv5zS/3s96Q4lzThfvONrBRNHpC4nlESNzAk/F2waHa13kJ7bRbhJJFXUSVdEV9Z0zeYAPKh9vTh/eIdcCjfzVS+UFO5o23sj/9gbemm1/fg2Bdc72votYRNXDC7sKlVkRgm+7oB8o7RS3dCpXSdHrW0Yyd8l44lKAb9yAujTSuNDBuJ2k4JGNVz1nj2wNJWJMT6rJAK3dJSCaikxWVg8oVXHrQ2IbSD5tuCgwTWExn6VVsXRH21MFfiwaNO/c7DXqAUDEH2qVaFcpWsY1zq9H/PqQpRdMwDG0/M2Kfr8U/8AnVBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKBx1mcArlB7aOeVPagEgqfLAetQ5e565Gsm+/6dIX4=;
 b=oAR6OMGKRlY7a0AhXZdlxpapvMVwVISfGFEcrrdWmxjpJ277LWWuhI4G6edbtuiLqZW770S70s8DNs+T/3/b8ygruwv4tYsEVEdrB66f5YcfZeWPBa7fW1iskjI+nlmphGT4dqoD6eyzjMjSuDHyC1Uyxo1zUHeeG3DWnYSdAE25RwSIaFq5+S7nK4TvXdO8V8cjsyBMKlRDdFefkKl+O3zX2kbpg0bFd9ZGNMCzI7RtXbVsMTsZ8hjahH6J1Nqcxe4DNm2nfLjST1JwVKvnXqoW/iNAb5JzvxLS5iQQ8P+niSSYDk3LuGmFHDAsm4VbDGSx744zAHF6Mc3jZ60bbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.35; Wed, 18 Jun
 2025 18:32:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 18:32:24 +0000
Date: Wed, 18 Jun 2025 14:32:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: l.stach@pengutronix.de, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Message-ID: <aFMGMajYTT9F6Htb@lizhi-Precision-Tower-5810>
References: <20250618024116.3704579-1-hongxing.zhu@nxp.com>
 <20250618024116.3704579-4-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618024116.3704579-4-hongxing.zhu@nxp.com>
X-ClientProxiedBy: PH8PR02CA0028.namprd02.prod.outlook.com
 (2603:10b6:510:2da::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d15c4a-2c96-4ec9-2f95-08ddae96783f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pzq7MmFOvWIc4Qk03eBDDZgatV1FFxg5OsyTYXRhghpf8GHcRpTIv92Cf2eM?=
 =?us-ascii?Q?QEuHfx9UKtmx/9yg63tC9vwZSBrj5Kq/r8Q9hgnMBAHtvxVaRf3Xe98zN3FV?=
 =?us-ascii?Q?6wxQVj+9VuXIEFpB+N0J/mvlQ9OyLqGY27ujlM8UUeFHY2Bqxk5ewqE/PndY?=
 =?us-ascii?Q?8t+IJryVAVH7teOSDp7AioSZ1ivsD2GrOCDsQ3Yk3lZL28RCDfNrl0vtwmaA?=
 =?us-ascii?Q?nDH4BIGOLAFziTsvV8wYgOTxsq6PE6GER/+pqwZe3bmF6VUNQhB0YRCcbPd7?=
 =?us-ascii?Q?/23O+b5C7vqKEtSEbeZgXxEpt5ZSeGtB/DBXBZKzjQooGewDkyNwcj01ToFp?=
 =?us-ascii?Q?3bLqnZOXFr1luKDKzPwmMQIgnOulRW55G/FeS+naO/TtibZjoUZdcvVKEwRI?=
 =?us-ascii?Q?d8FkNMz42nk+rHX5IyFWbXBZ6BVa6O1lpsYTCLnzqzy9hhebOBI2Tozpclhb?=
 =?us-ascii?Q?ubYppckKpk1J26Y5GVLoelOyaQdPYJnQDTkK7UvG+uYU2QvfHiUENdI8Eam7?=
 =?us-ascii?Q?b02M5v7VQu10eSscKkqeWnd4qUTWA3SAlFP2/pY4skX/UKaBKDtnrf/tRc9B?=
 =?us-ascii?Q?/mOvOfyleSrD+THfZHZqECTPEADDVnGWr0qbCPuO/9dHZ7OgqlbFYgMisVz5?=
 =?us-ascii?Q?cjY+5yr2jFE3KtK2xXxf9lyzr6Cbo6nDZj1H/9jwuGqhJ0GA0FsKoB2Q/e86?=
 =?us-ascii?Q?nCWxfm8Sh30w3p2KwZ+2kLsqeXAxkAxBiYfQveBUikmu0UJIQN70aRsZXFK6?=
 =?us-ascii?Q?WCbRYm+VMVdY0RP4pJ4yOWQJzDfaWAwrjy3Bkx1jdZEazdyRqjHRQ6SvOgFQ?=
 =?us-ascii?Q?LuJ/1Ty452yO4jzfr9IRBJqwTTzflSCFJgldz+ppH8aMtGZDnuT5+ruX/mO5?=
 =?us-ascii?Q?76pxCkVH+IchSujPB/OGMbZQKOu3yBvANwq11++0e/E87Q4c28/mdC4Y1m+4?=
 =?us-ascii?Q?yrZM0d55nNYlmIJw2RQGcFWNWz9g2gEI+NcbDW4M+F9PxTkluNDGIwLPvUD+?=
 =?us-ascii?Q?KXY4E6qCGpNsLMdl+kLNrUoixxtVN+dqCsQCKhliTX/V6+zFqurBg8YPLArK?=
 =?us-ascii?Q?YlTf4TrzxBx2uEc8fAhdgWYIw2X6ggCtDNOLV5h29GWXBS6gqhiCm06xw/PJ?=
 =?us-ascii?Q?REszQwjq9pRDBVCtWP4GGWk0/jT0fO5d/iQxWjyJ6g+5hp73DcqrokRIKj64?=
 =?us-ascii?Q?Up1LLKNemumNRxT1ZehSpfsJk5w4fDP0rZPJedIX5rmmURWerN1xHGcLDuZO?=
 =?us-ascii?Q?xMiSNHiCjlgTtiM5e62RkkPH7bKY+HI0uAw1GL4eOl7p+xht05xIu26kEG7u?=
 =?us-ascii?Q?FPcN4zv6HC/QX2Jb8zXfK27FzrYJCuBOxW83wdTj9kd1qNlvZVjEH58TQHxl?=
 =?us-ascii?Q?nExEsDRVz/0D95t8JjiYUAIGvOPTwpG8se4Uwam43xax8iDgxGptaRUxsaTk?=
 =?us-ascii?Q?X81P1uE0+qDcCw31hHdl82vs/s57HY/gqW26oI9Ct8cYXB5ercYHMw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KJXZ2IQDtEpCvob+d/cUq8dIn7yYmTIyr57fv4tUXMfmiZxWdHv3t8R3CEyI?=
 =?us-ascii?Q?i/2AI46cjyVgOP8zOwFWzQ3tGVpuJcxmnvCx/l8nn7naHYw4RRucXZNra0xm?=
 =?us-ascii?Q?lVzEJqd0E3mfA/ApmUZI2LMoWkjCLbxYPZpSvoiatV+d3aX0xVgvhLPSNZNi?=
 =?us-ascii?Q?YW2vmuox+J5XkyxpiGcE3AvFTFcv5lXG75ZdgQoLkrJoQV8tjguvokD9Nxgk?=
 =?us-ascii?Q?trZLOCCoBzuTwb31ZbnT2wikEL7KRIbBvW3ZkPxqTxeJj5W1Ez7Qa8S+Jowj?=
 =?us-ascii?Q?bBPcG6Lzux8j9u/LcZiSC5U3+9boR9pSKMsZW9VDJJLKkSTyPZ0fwyKAlP2E?=
 =?us-ascii?Q?vYJ6WiNDAN6s9xrAqDh7s79jp48OGZ3L7p06pxh9Oud8HwhpF00aQLxCr15A?=
 =?us-ascii?Q?6kgPiGCfhfLtHbbky2w0PGvVxcAqnvRL9/1gygsPHKlzGVyrSM0kmFCGsc/J?=
 =?us-ascii?Q?rnNapxrCPbT0D+dl4xQzrLElm8y1mREC8BydmCnFx+kG3QjWvhbvF1DcZvh3?=
 =?us-ascii?Q?mi4JYP9HbVSansKaoBZwH8mAD2fu6+it4H3cD7PANhn7BHUCyxkjpEblm33i?=
 =?us-ascii?Q?G3jph67OxwVAjjoueldxYwhJDJtN81DuoZNhzRIz3K+ESRTQYIKulZmghIi9?=
 =?us-ascii?Q?lTjycKghg8UihiIMD7F9EYksxdtq4uYKsV9OrFTyXfJRgKY8mGV0wzXismWY?=
 =?us-ascii?Q?rVnUB+/AZLOxM3OvekfhcygmrxIUB/Gd/srkm/nHJfWXxuyVq7EQZE6n9iBM?=
 =?us-ascii?Q?EM4OaIhYsklmdpF+wdLaCLnX37Mo/hZPm/AcuUv8ISfh/Pw1ortL9tpfhdyd?=
 =?us-ascii?Q?ctnyv94Z2x/0i7tCJM/E8l3wclZyndUy0DEhxwt46Pc5A/vaspeLOjNDksv3?=
 =?us-ascii?Q?nh/8Ga69AzNmJmPpLN5o/0SalS5Za5pCmvZ5XSzRPZKNZjX1hgVni26Hnlno?=
 =?us-ascii?Q?NuP6ev3mukqfA16YSU4lDgQkOVsYaU2R52KFVumTopFqNI06XeP0ebdS6fDm?=
 =?us-ascii?Q?fhSrr4d0x7ND352f0TzxrqLN5oINr0fXR3a4i/m+x4kpiD8YtFp38GmRPm2H?=
 =?us-ascii?Q?NdZHqhLJE0zfftgpeOQPWea4Y5waIyJHrC734tV22BODpBCRIOPgAL0FMFE7?=
 =?us-ascii?Q?QP4mfxayutagsGkKdPQS6A7M8OZNo9kqUSansbt+m40Xxbk4ZJBZUxOoq4YH?=
 =?us-ascii?Q?fYrErVjLxeq5ALhrvsdpkX0DjmYmT0tVcH7pbkwhI9/MaXbzqZBpv5E+T6TH?=
 =?us-ascii?Q?S4Xv2Nk134wgmpD/iSmkuSzBrG4HCK8gXijmEI7jvjy24NXH28Rb29w6p0a8?=
 =?us-ascii?Q?1rzt138Rldn1wRuHj5Qh+mEHl7F8pgK/lTihKsy/1AJipLKii2KiNL2dd2le?=
 =?us-ascii?Q?YOMcYaXXrKDICYRgkGtFUbiSnud9nnBfVqieLAG8xkSvpV0JvQk1CMo1GxV6?=
 =?us-ascii?Q?ri4nE4L1BEWaGuk1znXst/ad6vn9WWcAd6OL26lZvzmI2SokCTecxbG8BDGh?=
 =?us-ascii?Q?8I6itgc5PR4f5y8NUZrEePklieBBTNGtfdlDTF11PvbB3Dnc9uZE3UIIjShg?=
 =?us-ascii?Q?b3YHhC03hvE7+/wNYMY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d15c4a-2c96-4ec9-2f95-08ddae96783f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 18:32:24.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cQ7cFJqhSantSM9uffSPhLWTBuLSjhLNr/0ED9j4MGOI8R/++4nTRInDxcA1d5TGYLXeSyV6pKfLvPq3uU15A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342

On Wed, Jun 18, 2025 at 10:41:14AM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
>
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
>
> The LTSSM states are inaccessible on i.MX6QP, and i.MX7D after the
                                              ^ needn't ,
> PME_Turn_Off is sent out.
>
> To handle this case, don't poll L2 state and add one max 10ms delay if
> QUIRK_NOL2POLL_IN_PM flag is existing in suspend.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set in
suspend.

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 31 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
>  2 files changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 906277f9ffaf..2d58a3eb94a1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1026,7 +1026,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  {
>  	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	u32 val;
> -	int ret;
> +	int ret = 0;
>
>  	/*
>  	 * If L1SS is supported, then do not put the link into L2 as some
> @@ -1043,15 +1043,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  			return ret;
>  	}
>
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> -				val == DW_PCIE_LTSSM_L2_IDLE ||
> -				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		/* Only log message when LTSSM isn't in DETECT or POLL */
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> +		/*
> +		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
> +		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
> +		 * transferred to LDn directly. On the LTSSM states poll broken
> +		 * platforms, add a max 10ms delay refer to PCIe r6.0,
> +		 * sec 5.3.3.2.1 PME Synchronization.
> +		 */
> +		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +	} else {
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +					val == DW_PCIE_LTSSM_L2_IDLE ||
> +					val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			/* Only log message when LTSSM isn't in DETECT or POLL */
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>
>  	/*
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index ce9e18554e42..e35b19cbd8bf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -299,6 +299,9 @@
>  /* Default eDMA LLP memory size */
>  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
>
> +#define QUIRK_NOL2POLL_IN_PM		BIT(0)
> +#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
> +
>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -509,6 +512,7 @@ struct dw_pcie {
>  	const struct dw_pcie_ops *ops;
>  	u32			version;
>  	u32			type;
> +	u32			quirk_flag;
>  	unsigned long		caps;
>  	int			num_lanes;
>  	int			max_link_speed;
> --
> 2.37.1
>

