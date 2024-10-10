Return-Path: <linux-pci+bounces-14231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 195FC999346
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 22:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCE1F23759
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 20:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E61B5325;
	Thu, 10 Oct 2024 20:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q8vKwtdw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC9A19D880;
	Thu, 10 Oct 2024 20:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728590495; cv=fail; b=RasdI5xMyXJdcynytiOA+tOxf4wD87Be6vKI6uCkIsOb7qt/4ibED/0o0vESb8kfCGYwwkg99aQFq33dbjGffwm3t90Zsl6iwsrA6JNzoLZ6+aQ+Oyans6EyXq+oEuLY5j7+4rnyYZ3ATm6QjbP7+FbpNl53i9Ofp//88qQKQDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728590495; c=relaxed/simple;
	bh=VHwgUN1t9fhTqf38P8Gpji2rg5ds8E3MxQy7fhElzQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oLRmSLZnDJbKMzoVcnPO6BlNZ/+BDd2+TeClXi6fjucQnTq1k7E0BWQb7yzKEYtWoLSm3HTqTMjphQo2GWfZzcQtBOn5Ri0IGc8otCCSbte0jaenC56Wj+bJjodudZsmi34y6+jPpaUd9/qPOqVKhN7lpRml4E/KiZrQuU4scLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q8vKwtdw; arc=fail smtp.client-ip=40.107.20.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UhOETJh18bu6PgSAkzC4OgLW/hM6pHzE0zwDKuvB3Hrvk9NZXqWjCWtrcPWSsj+bpVxIXn7qGMkcibMmZj2xkEyeIL3YX2+Z6hIBJ+zbW3nZfww3DkZ+AM3dvxRwRaEhSD1nOk+m1e/8uDLFBdivOmdQDfJntYU0zV+Rqx2/nd2wRV90AYiTv8jrP/63XVhGbxWp5Q8IhTMCB+6HcaLR1QsGeeF0NuYtk/X8UcEw/UrXgMmfvUhu8zAgfVWId4AjlCtXEi7CjiaGM5qLj+BqXHSQgE73Y5dKRW4A4bhnkCXYWsUUqrxKgc+RjCgQ83CKFbYRA2lLbB3kLV75KSkSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByGn6DVAexnRDSIzpsCCnvvVPG2MFKR3YOswijiQz58=;
 b=EDqPOTy5tFKbWJwpq9OOAOlLXEHMSR+IBZizTX6dtTNo64LFPgJQzQ3toetd/5Ke9enx5JXyyDtEJZyHKILHaJT1RNps63XOQsXZfidlDsNaQWiQQHO9r+n3TipEgGig0sF6ORu07RgJx/88kiVUpHaxBetMZ+TrCv/MPkhqe0teYiCd7QGp+xC0UZfX3HRHqJZN1YWAEO3kxwNud566Tr9h22QkefEGpg+XodV57mXOJz5YJIFquRfmVxv/87Czm9f+9SL/7TPw/TKrsrbwdK+w8uq3w0ZgIgt45omxmOmub/8QqsCGVExPxJ9Q36y24jmDkSZvaarLpfzgFfw4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByGn6DVAexnRDSIzpsCCnvvVPG2MFKR3YOswijiQz58=;
 b=Q8vKwtdw2kslcvasHUY7CdUZxzTZc2lSa4E4M1BINOJ9G9hy1G50x4oCctPAff6Zd8qasZjmP8k0xCDoadYF2ArZMGNGQqJAHCC5u/r7j6P5/zk3AA1YirUhMmCSMqa/Ol8kS3KeOIxQ8vvAgAZx8kimfq+Hq4H2vPyCoOa5RG+amQB03SCzswO0xCu04aDhhfTf6nSRdvKtwg1IfIjG4ZCWz6CH3C0bOipqMKSjjCV+YAlZFFW52W8KX1cdfy2ea/zn9nnglO9nAzC7q2sDe2kHWoQvJecDp+oqG91rLJE5oVD7u3AoiJAjlyAkqxoQJH1XTGU1qJhbQkbR2irYJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7227.eurprd04.prod.outlook.com (2603:10a6:102:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 20:01:30 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 20:01:30 +0000
Date: Thu, 10 Oct 2024 16:01:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v2] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <ZwgykRyE+jDU0CiU@lizhi-Precision-Tower-5810>
References: <20241009131659.29616-1-eichest@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009131659.29616-1-eichest@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7227:EE_
X-MS-Office365-Filtering-Correlation-Id: 002d3360-f0ac-4c50-a7e5-08dce96654da
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|52116014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?ymeY68D5uevxHsufON735djRvT1Y5RS/g+CwG4F+0gS64F2FgTNzfmAz3KxZ?=
 =?us-ascii?Q?fw/UPtdgxQgFEkkmhjRBYP3+iT1iSHk0LxBJdJH8SYUA3G900Abg/VFCk6XZ?=
 =?us-ascii?Q?U9/IaH/Ab3fsJTnYCnLYXngFBUD1C1F4WefYQrvys9PAccGiEFf0GKpmDH8H?=
 =?us-ascii?Q?POAWWtdMMLGi9K5cNRVBPI9YeJYHQIHF1BWMhIzbrlTlvwINnX/oyCCMd65a?=
 =?us-ascii?Q?ziNNW/I6LV/LXQEBlg0FrnzFsZMzExSkGmTqP4NRpHFP2i0eaakMZONlNO54?=
 =?us-ascii?Q?KbLE/WLNZb+EGx3OTvcUA1AgeGzV3gpk5qcd8vweg3Z2rOO6e9Lf936feK2t?=
 =?us-ascii?Q?9Yw2z3Qd1ILbwOG48rtKjEj3oU8SuBoES3dE1AYShVvhtC5GQiHfTPqgMzd2?=
 =?us-ascii?Q?BtCjleZm+sYKUGg0R9YwqjJzPmtaSa5lWnzTQBIlAYpBG5kJTlB5lqEXRXDB?=
 =?us-ascii?Q?JqqRIFeiK+L1QeCD0fZ7RBQhgunAhjeTKMhl5N8NV29BmRD5ilhPN/9HaL1F?=
 =?us-ascii?Q?WU6vR1BEAeWvw3y5WMFAoHW9qbqdJnbCdEXbcMXLH3RAf8Fj+IDQHae+67Pm?=
 =?us-ascii?Q?5wbpBQV2qO9GR6EBcXU4sFHP9+2+QBB5xMY9mAbd1weqJsL1q8UgCFiz8x7f?=
 =?us-ascii?Q?qUairS2FUuArdfyK8INiI54A0DqBftPs1Vp92uJutQAAhgfttiGGwFO5Qfxa?=
 =?us-ascii?Q?+ClOtwlP60f0LRi9zckmJfy3P4Wf2PiLjcH10LC7Jv5TDkE92hvzvYMJOoZO?=
 =?us-ascii?Q?C0ZaLOuXHeBv9g/WZ9rgxPjQwGfdNYSgg2gkGlzw/61HecNWmvjBVXIdWjOW?=
 =?us-ascii?Q?E5eSw/Q0q1n2sh0y2nABDjxkDa3StD5gZJ84DxeG0ficyofV4XQtaUfTl+bg?=
 =?us-ascii?Q?jurJsObi27I/GlI3t51EvCW870Q4qUIolGqGsMZvfi/D1fcmIYMHoY8ntOXJ?=
 =?us-ascii?Q?+xvSUAw//28jK6Zh4qt5qn4b4BJrvd7BdbrfeBM52tUZhPLnKI5vEFBHbpmK?=
 =?us-ascii?Q?HkQkNu1OLryCa+R+D353odsjcZ2d7c6evCr0YYcM9+E3zDYMOKMCwfF0RHkh?=
 =?us-ascii?Q?UG8zOHkBbN3GY5t28Qi74Y0ygOdzM69+oPc3LtsW00az7KM3OOETb3iNV6G1?=
 =?us-ascii?Q?lOwMAbsHmA7y9mTf+B3pmLZnhvCXqms6jRHZrQ2WXeY9G2ucGRb/LlNyP01v?=
 =?us-ascii?Q?Svj4E0CtrrCq8sDmB4Xyp5r3RQ531v65WMnNuDZjXcTv1XyH/PrPNOdfC2XA?=
 =?us-ascii?Q?OWrBCiiYM6Ab3V8XdXvZyT6CZIRtHJZgPORZqySY8QzMEv8P/D83RS7QccXB?=
 =?us-ascii?Q?h/0NB9HXa/2sTkNyy3ay400Csz6yb+8R9JmfjaewNWFnug=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?+PPFPOEtxfnkbY9F16LFa6rq41tjD68adyXGqcrqHLgHwvSq88upvHljCrV4?=
 =?us-ascii?Q?6cMG8E54AnSxd446PFiTV2xPg2+0pR97mYoEORn3Jwrg3fgo4A9PlrumR4Hb?=
 =?us-ascii?Q?iAbENtuxxb+p9V4zHSd6iNc2H/dqjzdhwqnrs3pBSfCiSG0Yoc17/7RPlez/?=
 =?us-ascii?Q?GFLgNOQVEy9jLZUddurH6DJpMfmqtTEgmhG1Kc3OTln8/cSbapPFvUZ32/YW?=
 =?us-ascii?Q?aNnqSHSN+aTyPAxNhwinhEiB6qyGlt8MpbbOJhm/awoAQhFsAkuiO594YrjS?=
 =?us-ascii?Q?8VZkgDSynXMWJUXsSUalV3Fcdj7sAuqF3GugSoZhy1UU8spbfIBg0jwOdylc?=
 =?us-ascii?Q?eqij3dEFZKO2/riy87JUou7n/IpDlpR/BMk8oTvhn/ueCdgKac76Uig7Rj9U?=
 =?us-ascii?Q?LmxQnR4cfiIFZW1eGZ/UU49mKcaNlBG5Wv1nz99QRjIIvY2mk4yx6E11KcQl?=
 =?us-ascii?Q?cFWToEoJIHKmWV4BLMnnWvROe0VRIdoNvPIpf7s8OAAo6h4tT18uQ53fG82F?=
 =?us-ascii?Q?eFIw2DpTZ8ga2G6kTT/b8krkJFvu4SJdlsANQ5GCufKrRxjg3tfVoyeQtUQW?=
 =?us-ascii?Q?kw6i9Gk/4wNIIRkomx5RICcuXchu9srUi3/opKUrr9aY1TMoCPZXT9lJM8d1?=
 =?us-ascii?Q?jAGKERqTxcxOBR6DJLLVQJgYxJG4JWGcqx5iB1yGTGjCmuL9ndXbs5JMWEff?=
 =?us-ascii?Q?ST0TcUu9UXWqKVpXU7+bHQg9msJ1S7C2PrUcvd+fKFkfeua4R+V7/4eI9Qg1?=
 =?us-ascii?Q?F0yW9y+QmyfifcUM0EDKAEJpueJ25cMk07C3921zCacvpNSMbHXao32TzTr4?=
 =?us-ascii?Q?gcY/ir3uhJW0zt+8EtfIdsmnIFh/ih8qbK74TF2AZp8nFPK/k7gdEptv2CgG?=
 =?us-ascii?Q?rSUewXu9Q558taiOs0A8bMNvKOgBcC1jDsBbDQuKuAnThgMDZKGI5C4qYgvy?=
 =?us-ascii?Q?H/HPeWtwdQLLOnXhZSEhtyvrvJLsD82HL05qQNM/lLjQ/dADdyNIODATGyne?=
 =?us-ascii?Q?sSpy5Z/faDgWthv9NAx9uYl8n8jlIEIy/QBGgrseV4tvuKv0bhlLjY7C9lap?=
 =?us-ascii?Q?MaHraWLWIVPCM8ZmA7c50sKBYXDQ4+5MTi+jtFdFf5ke1DYKPKavy8YZE9n+?=
 =?us-ascii?Q?STEgxuFvH3YRFifnTSmt2RpB+04GLCh8lUPdghJ7qW19U0GTEE8jpls+N2FC?=
 =?us-ascii?Q?DbBqVuCLuF/h4oSBOpIQaCNgi2uxvXu+lKectyLx/gtZL2gJiulHurUBe4E6?=
 =?us-ascii?Q?kXLLHwZSYTLvWDjJ3mKAKRymjDKECwLXub5wvQd51M9doWmrgj3NKLkhiy0V?=
 =?us-ascii?Q?pJQCp4GDcHLpNUUsa9yba7NeyW90PDcuMfSTd9YQ+CjkDxN6AqJlhdHH+k6+?=
 =?us-ascii?Q?ANBmtT1h2GmZD3GTxlkMJcZaJmlgmx8tiGkTB1oQ+UoK9o1T+ImlQNwM3+6W?=
 =?us-ascii?Q?Ra16lIlsdUclCQK5V/KlFnqMlc6AG0T07nsUcTHEWNSzHtW/nEvG5iKQv4lJ?=
 =?us-ascii?Q?5WXIqIQew7qsBr54neKyZ+2y61zsufhdkZcUTYS2knl3EFcMc7LYMPyZ8y/P?=
 =?us-ascii?Q?mx3pbXbAHBKo/DRfzKU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 002d3360-f0ac-4c50-a7e5-08dce96654da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 20:01:30.1996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoZetnyiRg4aonk02B3E6zKQzM3on4f2WkcU+43a22opWTPqrkAY/iYbGv4Gn/KPS919+hRVv+gfrXwJazbyyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7227

On Wed, Oct 09, 2024 at 03:14:05PM +0200, Stefan Eichenberger wrote:
> From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
>
> The suspend/resume support is broken on the i.MX6QDL platform. This
> patch resets the link upon resuming to recover functionality. It shares
> most of the sequences with other i.MX devices but does not touch the
> critical registers, which might break PCIe. This patch addresses the
> same issue as the following downstream commit:
> https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> In comparison this patch will also reset the device if possible. Without
> this patch suspend/resume will not work if a PCIe device is connected.
> The kernel will hang on resume and print an error:
> ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> 8<--- cut here ---
> Unhandled fault: imprecise external abort (0x1406) at 0x0106f944
>
> Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> ---

Thank you for your patch.

But it may conflict with another suspend/resume patch
https://lore.kernel.org/imx/1727245477-15961-8-git-send-email-hongxing.zhu@nxp.com/

Frank

> v1 -> v2: Share most code with other i.MX platforms and set suspend
> 	  support flag for i.MX6QDL. Version 1 can be found here:
> 	  https://lore.kernel.org/all/20240819090428.17349-1-eichest@gmail.com/
>
>  drivers/pci/controller/dwc/pci-imx6.c | 44 +++++++++++++++++++++++++--
>  1 file changed, 41 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 808d1f1054173..f33bef0aa1071 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1238,8 +1238,23 @@ static int imx_pcie_suspend_noirq(struct device *dev)
>
>  	imx_pcie_msi_save_restore(imx_pcie, true);
>  	imx_pcie_pm_turnoff(imx_pcie);
> -	imx_pcie_stop_link(imx_pcie->pci);
> -	imx_pcie_host_exit(pp);
> +	/*
> +	 * Do not turn off the PCIe controller because of ERR003756, ERR004490, ERR005188,
> +	 * they all document issues with LLTSSM and the PCIe controller which
> +	 * does not come out of reset properly. Therefore, try to keep the controller enabled
> +	 * and only reset the link. However, the reference clock still needs to be turned off,
> +	 * else the controller will freeze on resume.
> +	 */
> +	if (imx_pcie->drvdata->variant == IMX6Q) {

Add new flag: IMX_PCIE_FLAG_SKIP_TURN_OFF.
use imx_check_flag() here.
Maybe other platform don't want to turn PCIe at some usercase.

> +		/* Reset the PCIe device */
> +		gpiod_set_value_cansleep(imx_pcie->reset_gpiod, 1);
> +
> +		if (imx_pcie->drvdata->enable_ref_clk)
> +			imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
> +	} else {
> +		imx_pcie_stop_link(imx_pcie->pci);
> +		imx_pcie_host_exit(pp);
> +	}
>
>  	return 0;
>  }
> @@ -1253,6 +1268,28 @@ static int imx_pcie_resume_noirq(struct device *dev)
>  	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
>  		return 0;
>
> +	/*
> +	 * Even though the i.MX6Q does not support proper suspend/resume, we
> +	 * need to reset the link after resume or the memory mapped PCIe I/O
> +	 * space will be inaccessible. This will cause the system to freeze.
> +	 */
> +	if (imx_pcie->drvdata->variant == IMX6Q) {
> +		if (imx_pcie->drvdata->enable_ref_clk)
> +			imx_pcie->drvdata->enable_ref_clk(imx_pcie, true);
> +
> +		imx_pcie_deassert_core_reset(imx_pcie);
> +
> +		/*
> +		 * Setup the root complex again and enable msi. Without this PCIe will
> +		 * not work in msi mode and drivers will crash if they try to access
> +		 * the device memory area
> +		 */
> +		dw_pcie_setup_rc(&imx_pcie->pci->pp);
> +		imx_pcie_msi_save_restore(imx_pcie, false);
> +
> +		return 0;
> +	}
> +
>  	ret = imx_pcie_host_init(pp);
>  	if (ret)
>  		return ret;
> @@ -1485,7 +1522,8 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX6Q] = {
>  		.variant = IMX6Q,
>  		.flags = IMX_PCIE_FLAG_IMX_PHY |
> -			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE,
> +			 IMX_PCIE_FLAG_IMX_SPEED_CHANGE |
> +			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,

Add IMX_PCIE_FLAG_SKIP_TURN_OFF here
and move comment "Do not turn off the PCIe" to here.

Frank

>  		.dbi_length = 0x200,
>  		.gpr = "fsl,imx6q-iomuxc-gpr",
>  		.clk_names = imx6q_clks,
> --
> 2.43.0
>

