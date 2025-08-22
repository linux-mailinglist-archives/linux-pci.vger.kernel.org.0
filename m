Return-Path: <linux-pci+bounces-34538-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F536B3122E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5CB1CE4413
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C82E92AA;
	Fri, 22 Aug 2025 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Su58nwCT"
X-Original-To: linux-pci@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013009.outbound.protection.outlook.com [40.107.162.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32E2F1FE7;
	Fri, 22 Aug 2025 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852305; cv=fail; b=o62lGpoHe/1uWee/PPeYAyH2glXJvu5+poUzwJsQHNfxcS9GYOIEWnwBplosHHDpcOxB9zGBXIKli23fYRGDiZxWMyXpn+WVcNTqZQjL9qyWumxawJnmXAx3g9cvK/2LlP2O2lcSKzsac+bKMF/IoY14BshrNpTxSmEpWwO2EYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852305; c=relaxed/simple;
	bh=80GmiaW5AUM8/ssNJs4riSUbbZJJAa2TStQ8BwOf7ig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bxJrukIlkyW5HJ0kRfjFYHfrk2JWLAxfgPqG9ckXw+rMN5GKov4/AVSTh3oJNhOiigBFgaNtQlRMaYcYi/Vby41YiT+olahAjm2cCKdI9TeObxoCkDh0FWdi2/B0FYJTlCm3Gdpo1O6feBIj/hEcyzGAAtlh0D2KyfUDhgx0SUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Su58nwCT; arc=fail smtp.client-ip=40.107.162.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iy59grdKYgfQtV0eMR3IGa6wKj6mBym7R8AnvlTq03hFu8JrD5Lqorqnc3uQUy3RPZ5RLMGM6SqDtJbBPrV0Z/VL5KNOateWn35+2gd7rEe2vk5nZQY7AFBxzEeUstdTkmhmtqxneZky42tqFpONmX9bWBeuh/1aLrAHMIgx985gCTW6fyAR/BB0M6dGkkwxNGKBzNLaMBSF2z2GEqSFHGB00Wjt7EOTt/z4gkhN0jE4/I5+4PzK93Qr/g+bNaRW4FjkUtCZgyNsjdKs233dhZkjG86JFMkl6A9ViiAjkK+fIQ1zf0BuZsCbl15yMPGlO5UiOLR9QKXJ0bgfj7DExA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nymIKJVtqTMVHNL6bg1hhYJuQEYf9CNzel7769PL4JQ=;
 b=xAd8oYTAUMTglWDrw6/VZL2zBxxRmMKUxXWcTnFlou1N0H0niT+49q6WlexNtrhwhMkdihmdlmLC4+QyoS0dBGXMtPY+y9iVBHfIjbcEj0kZGiFbX/WcRq3bLjwsnVv7toui1l/AH2op3OAqJQLQ371fricn0NGDTm2Kppvzxcgm+nfVChRNlAjDxcV8dBXIpwIXQVOKKEp4vPFNb3StwGkavC17ZaZBh9tdYeLvkXilfz5FtcUsgCypm7b04FQhfE+tBuAUDD0vTEX8y0bgHhnLVn7iqxh+Pa8Eo5lXGDzPmCKSSj7Op61JHW3pwONxWts6m+VMrcpl/AQ9l/+XIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nymIKJVtqTMVHNL6bg1hhYJuQEYf9CNzel7769PL4JQ=;
 b=Su58nwCT/0b4m2fxNj5AFy+Csq2NW7zbPbREpLmCjb82SAl/GBDCEGVDGaiS2CLqu0LZtdpWmk2FMIn9dR79twkhkto97Li4anNu21RSExphFN9PxhHOLtFj2+pSHFIoVp3nHjiwUuz+ZpfIKEC0MCu9SD2klVk82nGDfXzksSjot5a9apKxa4ZMssQ7FqjWMgMbAyGuNtBrnZ4ydb1FWr06BDQUCo9yWRu8KsUJle1VClePRfffV7u9x1JJ5p+IUToO7vUJYsdfPJfOcgjd4ZC5WNuBHI5K9wrnuZ0a2ENs2uY5lP/CpdU2scZP5mRZJ2eXj3jVMI60gFGjf+SnfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA2PR04MB10187.eurprd04.prod.outlook.com (2603:10a6:102:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 08:45:00 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 08:45:00 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 6/6] PCI: dwc: Don't return error when wait for link up in dw_pcie_resume_noirq()
Date: Fri, 22 Aug 2025 16:43:41 +0800
Message-Id: <20250822084341.3160738-7-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
References: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA2PR04MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 35780417-2ee4-4567-41a1-08dde1582df4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|19092799006|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oq2zqgIsvmokGMUmrapRBTyNzgr3ki7fQp8xjBDx/qJiBU33oCnGmjYvu9bp?=
 =?us-ascii?Q?89XARpYqI8VjytcO9X6MVXFsW74quGaT0wDOsbvWc//qLyEupfEZUxHTKoJW?=
 =?us-ascii?Q?KCU5qfwNG9Swp0yvJsS7oxmWxgLOOboXr3G9D/ioRXLoTcg/0AjkFIo1kvp/?=
 =?us-ascii?Q?kU9A3/u2RN9KnjkYWzPEXdbTHAoKSZX2MFhcirp7Cl4yh4Psi9OYLGRs0hfX?=
 =?us-ascii?Q?X24cj+JpCMMeS+3isgCXP/ZLjxP4kePKC9xPfAGjblla7XG33qWRKPBTHdp+?=
 =?us-ascii?Q?KP2Pdq8tXHIXG68W1AtZfcxqLGixKTWtr5i+0l0wbWnywf5+b2SqOx6ukllv?=
 =?us-ascii?Q?8btsFjisEEZXFZwWo6/FgO8ig+VSDIPX/9U6LnGFC29KoGW2Ze3c6YN6tzaF?=
 =?us-ascii?Q?lVMymVpW/zLFC+5A9DhrMLHpikR7EiCXpeCSiknuDk215sWnC8wAInrI2qPR?=
 =?us-ascii?Q?KdwwCuXcSKCtbo6HQdY9pjMUWV9ioeWzZgJ1yxj3MekzvJes+/iVRLCsWINN?=
 =?us-ascii?Q?a1v6IlVvrvO1btERmZJbFk4vBMt5ih5pTUTbmW+QK+mqbtMdgNauRiohvJzQ?=
 =?us-ascii?Q?+YkzutANGeE5+V8wtwhdq6LpYneWiZE5nY47+ZBEeB0rwMBowDC3VL22pU3A?=
 =?us-ascii?Q?tKWYDB7qsUN3kxTELrIlgy5JvkbWRDK3GQgpe7mj66A7S4WC8x50wYKXGEWu?=
 =?us-ascii?Q?moOPcYJgKLYJnCQMvgWPhYFDHGzinxOBOMmEXQVsvSGB4fLdoDGyixjUFJFy?=
 =?us-ascii?Q?Rpr/av48qIE/s2l202GF45MiK/ePJgDrFLEA3Ul946PVB1ucFYL3dtdd/XUe?=
 =?us-ascii?Q?+/h8ClBqW84bx9rnNRzluVvgl7zfJFkl61osHjmdzpmP7IFFQgChsdPcZAPO?=
 =?us-ascii?Q?KLbCbo0izjssOLWx8UG/IYlpqVIe2cbZ8OSC7hpeOGGP9otkFOuflz4T/tEd?=
 =?us-ascii?Q?Gh9IHneDocorUtMtxyTvo55Y6XeDW1ndfMSB/IoRKzAN3PWKisBq0+peA2Sp?=
 =?us-ascii?Q?9EPXphQZveH+A8QgigD6MWd3TL83BisvXBPBzTc7CFfdrmTXTnMJX4akYaYS?=
 =?us-ascii?Q?oIlvOIjlGpx+tYMf1tAW5/I23VpRxpCh3j85JBoIVNbB1PLHDades81rdNF/?=
 =?us-ascii?Q?yPk8koMclLDENTIlsGo6HyH+7na7phdUyqDm92UMzyI3YR1dUFYAnwDiVHxS?=
 =?us-ascii?Q?wwGGBBU/is35x8VZlrn4ljyuMU0KOC1Sb10BLPbSwE5dqXQuap/q+lwRXwD+?=
 =?us-ascii?Q?Jdc9lKptP3iBXFxKb/6+9Z0RG/uItDul+ILSSmDmCxAWoeZy0QhgFIaSlZmb?=
 =?us-ascii?Q?WVESqUG6457RYNXGfK0Yt9ajYY6Ybd79hOUsP/rnBXIBkbh7dJ0SrpQtSSxs?=
 =?us-ascii?Q?b2s8MZthwOHJRBw+22yHz3YIuxa9h+qjqWNa+njxE07T1BxzgYAaDuey30An?=
 =?us-ascii?Q?+U/i5DiHAztiGAP1+K0vPzKW8Z2dvPNS8J49d9C6v+7OMjvXySzkl6W0+XSJ?=
 =?us-ascii?Q?UIOpAqfbbRDBdG8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(19092799006)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OY0qQMO/U4HmKRTErpPwWCXbtvkVq2pS7Fn0F3N6/eOql56RHE5brg7kOalM?=
 =?us-ascii?Q?zLMXC1zMMntAtMcswh/CA11RdydABED8lx80sI6mw5CJtMDH8gR8lfKixAkg?=
 =?us-ascii?Q?AX1OFXuXu+lztiYrNG605gCzrRn1OzLnayoVVYKhiyi/GL9ntDANAuiQDgAY?=
 =?us-ascii?Q?XzwO4oAtDDX2BytPjaBT/LZzOeDGCLwy5UbaXyofvhgZ+rQizgdacVJVk1Bl?=
 =?us-ascii?Q?mKGYC19qXDjkTpehUHjPM+5KnfqHgv1rauhjW8e2ocez9oEbld4zsa5gVUuA?=
 =?us-ascii?Q?KTfAatuAssUJL3MWLIg/wT0GC4BOSjRK7EvtxobqtB90VEYrhmDxlMthwh7b?=
 =?us-ascii?Q?CIhkOyJSZLULmK3smB9pxaGCV9DjHuIz5JobPWCoG+xQfMs1biO0XgYa9Kiz?=
 =?us-ascii?Q?QDHtcy2T2pDKo8GYkW7rGn/KHH8va0ryNEHGwn6RHxLefNv5duXxIuedV3br?=
 =?us-ascii?Q?lB7CBU3FbqOhiIfLpo1ErnZnYymWza1261aE2TWsXYfKSPPs4Z9UutaSjs72?=
 =?us-ascii?Q?HnCI+VDiTIdaCMhBOPgty+HPi7FUgyP/eaGylE81Wy77JJUYwcTtPPWA97lJ?=
 =?us-ascii?Q?tytoXiA8STPsz+/Yc10GNzIq0zaBkMiuC9OOEKKvV0tdv8fvk3z/0UO7R157?=
 =?us-ascii?Q?qQ3jAqHcyy20A62CgOOo5CQbCivv6MBgOMXDr3oFsDZNHVHvPGpdAfLbctf3?=
 =?us-ascii?Q?hIH6JiirfOgNSgnrBvqjTa4QP1U0OJtrNMbTCiPu4C8kNT0BmdFE2m21NMjz?=
 =?us-ascii?Q?ayQcp3qOhp3lQVrSGhs2G7Hvjx74c+PKGIqBFp+N+kqOYVeq00dUn4t/Ur7d?=
 =?us-ascii?Q?yRele32IKHZTAF9GV4jAb4SQHw86Bjgdt1PJw3YPlOEklQpXtkV1g66FLFNi?=
 =?us-ascii?Q?2LPg89IZqsi0xA7nwWz4fOwX2pagR+OEJBdcyhcdR2elzF5pJyXRLzm5DMfk?=
 =?us-ascii?Q?dLZtaVBLVBEi/ZZAnh0wFNJwMBM/qtj4z6GRjjWPyGEJwxDJY6WrS3CkV2dC?=
 =?us-ascii?Q?YD7hQn80bc9LHNSP8pIKbPAz9Jlhg6CMqw3atNCm+bAVw4xW4hYeVEeGrVTH?=
 =?us-ascii?Q?+akJLSEo+snpFx5h2NkF4LHMhrwwHyvhk1BrYhPW7VxbE4hA0PY+rjRcD5ee?=
 =?us-ascii?Q?cOaWtcBVTQUFBZkBUL7hBqozfwJJFsYwc6+7PwTqMuSl52ZudIV0hP1Gti0Q?=
 =?us-ascii?Q?b6D3OipNqZzpyiPX3O1k3TxfA6Cy0YnT3GSiBQ7pOFabGxFMv0X7VZY/AtUn?=
 =?us-ascii?Q?QI9S1n6cRoR4WHDDXdiWxUEnsQOrvy6pvVeDte8r3S77rBKl/graLn69iU61?=
 =?us-ascii?Q?mdKwjUoBTFpB5y7MS7Nq5sHZvRseRi5SljtJdHwYjKCcaB9kxG4SSO3nTQiu?=
 =?us-ascii?Q?BDPNvGUJnak32EK1AONnzUZuVRN7MBLeSSiNRbo0bdALNRIER/CslObmOHsL?=
 =?us-ascii?Q?SyZoGOHXF9WPnugLlB0BJ5Wk3ntAlzj5qtg7znkjTsVwbfpDppeLIZq9hfx3?=
 =?us-ascii?Q?HaqFBa97GWKTeC2/VKimdKxnCmPOg1XWzHnC4Re6FzNbd+shkDoYehVwVX4k?=
 =?us-ascii?Q?LjjS91BZ44zRv2GN+IIUQEOTBZ7D1mMgCsZ+2sl6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35780417-2ee4-4567-41a1-08dde1582df4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:45:00.2923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CYG9fQLMoj575aNyNTlcg9TB7nPQMEx6BmrCTGV/4m5BSmo4fcSR/IdaSy5UegL6FiaHB2a326aeAl8dEY3XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10187

When waiting for the PCIe link to come up, both link up and link down
are valid results depending on the device state.

Since the link may come up later and to get rid of the following
mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
outcome has already been reported in dw_pcie_wait_for_link().

PM error logs introduced by the -ETIMEDOUT error return.
imx6q-pcie 33800000.pcie: Phy link never came up
imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index fb5639c73e29f..5cb9aa221b050 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1085,10 +1085,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		return ret;
+	/* Ignore errors, the link may come up later */
+	dw_pcie_wait_for_link(pci);
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


