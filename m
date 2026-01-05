Return-Path: <linux-pci+bounces-43984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7588FCF24D6
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 09:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DDFE3029BBC
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 08:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C93293B75;
	Mon,  5 Jan 2026 08:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QvudUoMB"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021121.outbound.protection.outlook.com [40.107.74.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F020DD75;
	Mon,  5 Jan 2026 08:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767600185; cv=fail; b=lUdWGLSrv5ev46oh5VYkUaNvofxjZ9IOzIc9shxZld1xszp0lVs8OK9o829rQYqIROKr+epPFiZp52Q3Wp1MTQp2gbtaiBvvZmjWt2dBFPDH1b3nPZJ2bhcgSY0LDSj8SwEVgCxJ52arT9pXkfvy0XrHQYlaPSjf0AbbgOGHoQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767600185; c=relaxed/simple;
	bh=jxfV7EBCD+Lh8cj4xN0YqWxzd4yTA4MknRjSo1C9ZdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TC2iVJVz+61t3YlMgSyU66wZav0Ia5i2sKEhq6xkCtA0oXSloT+M4tS1NJW3SJntsfkw4l6HdANa69ANMjRZuKJm+UFeJngS6Pt1wHo33MQIK+mKuVDSVfsfiDDg7wsxHsrETBa1tIGFeFJ5HrMagc75zbU/FZnaPkcZKYnoO+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QvudUoMB; arc=fail smtp.client-ip=40.107.74.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zd6F/5aiFMfosjvlSsV/VUir+/2nt3KGkemT5plPY3f1vhByzJHZVW4a8vLe6YP6slDz751Ldj27ELbMQvFUSlYzr69u14Wi4BblGWIJw6gs+bqTzUkydsKynB8Zo9mzDTZCssdux9I4BJOMOfu9SbMxzXq/aJ/m6aujW+lNwZe7ezBHlIpYFf4yW5d5W0nxGWbRcMIx/7SVYlT76BfsA4Ej/6V3yhdfoVxJHgvjmZg2XjcxlpipnXeTHlSRo4d58FQd6CTlGZLXKq3v14qTTh0wJz7Da9RkMfHrugeVRAgadmRf4gP7oYJP2Px09c1hJZ49vQ7lzyBgTB93eFzrig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJfuLTENv5zxG9R1c6bji07JegKN6+n/BEBiabmrRRI=;
 b=LPyq20y2Pa4YIA9kz9Hpa0atEdaVbpEsBH+jtS1kKeZCq+zf9UsM5uaRN0MY5CxEbgruH3Uh20+7JGDgQrOt+5RddD3iAToTMRc77hXrngCXTNZ4hE6tlTJJTrnhrL5PIAq1Dk1w5PNxDs5zjmlltfwvlLmeAq/yZdr8SWoQ8zeJyQIKYT/Pcu8JKmgYlGFDPpGzcL9dvNR65nEWA243RgbcQuNmgqX676bcw0PbCtgvgDPlDd9Er54yFZL1BdGTBrCzGJYzzh/F4iy19vZQusjaCkia4TNLh2RpYpqwvOy2Liz93TBeiVD4Mw0gHmfTQHJogZn5HZA0E+4/t4vPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJfuLTENv5zxG9R1c6bji07JegKN6+n/BEBiabmrRRI=;
 b=QvudUoMB8ZS01uOJzKFPGlE270aGnnRw+PbYOnPXXZzd7LLKanIhaM/lXBNGtDVzvcc//DYsyYfbuc0iv90yGndxK0YpxOb5ijYQx1wYd2HrX5LSjGwUplvxYII6J0sm6jaKT8O7V/WeZlOiN5OXWOd8efonvcu1hF9BckzfNr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB1826.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 08:02:57 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 08:02:57 +0000
From: Koichiro Den <den@valinux.co.jp>
To: jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: Frank.Li@nxp.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: dwc: ep: Support BAR subrange inbound mapping via address-match iATU
Date: Mon,  5 Jan 2026 17:02:14 +0900
Message-ID: <20260105080214.1254325-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105080214.1254325-1-den@valinux.co.jp>
References: <20260105080214.1254325-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0236.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB1826:EE_
X-MS-Office365-Filtering-Correlation-Id: 391bfc2e-fb5e-4ac0-aa65-08de4c30d6a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FTtwA2KHAawcbZtBhzG57pwDSQ8Leo4biWvtTXQdu38fK9cAeq5LKMU69pvX?=
 =?us-ascii?Q?0AMQYIvU7kudj/q/w7LQgHHPD35t/VXgeihIXSrLYF1pWy8Ub5EkCnbNmGP1?=
 =?us-ascii?Q?pTloMf5ppq9OuGSenM8npd3m/PG21xTjRj4H6hJVnEwlY7gS+Bkl1k3baieM?=
 =?us-ascii?Q?CVTRxKaCi6Se1caeLNMYhL/FeZonVcge7qqUFM66BL/LNubc5eTIMdeTFrDD?=
 =?us-ascii?Q?xHyPiTXwH9CE8MplJJw6FeNiJKwxDioFAWtXtEELcEcTuvnSUWL4LIXN97NL?=
 =?us-ascii?Q?nGtk5gzoLvtev9k4A0OaRJXOj8f+6v3VavTn08RfQ+nFkBQUcNREjzse9Pxf?=
 =?us-ascii?Q?txx1d4qKOdoGC1bG70q4eJM6mRB2wt8wwMhWrFDwJGuO5hAXpmZpU+inFr0y?=
 =?us-ascii?Q?QUoQLaXoUTaKFlVMifYO4XwVJeW4nymD5TK+kc4rlzDeNz3WYNKIFAwsBMti?=
 =?us-ascii?Q?f5qpZubBINIoTZxiHd1xjg2gD2tw8HOCvq+xORdyQ+XV1gDN35E3DxR98Hh8?=
 =?us-ascii?Q?Yv2VUe5bZgpFDV+UzIw+GNJ2hEuzalWr5e1roleNATeBDj722rJZL2jq/vx7?=
 =?us-ascii?Q?LMbRZl2GgN6H6CUv97AsbxYjJcDdmLw5FSorFDEv/jcFe1E52508MbUK7fUL?=
 =?us-ascii?Q?C5b2fTJQmJjdrHoSN6LZc1X15+VpB3iyrMKXAFsCZVhcxmBPPnQh0rgx3bY1?=
 =?us-ascii?Q?ITCDif9jEs6SPHpidnB8SsllwejMqV46MWGHpZ73wnMK3O/zsIBYYaohFX8h?=
 =?us-ascii?Q?4Z6cexLWqCqMS+k6tPhjRUPk/9AoPpKEqq8KyeVpEmx8Gr+VNx6o5HcTb8Yv?=
 =?us-ascii?Q?TX3Px82z8QDUN3893vn7+x+04wOD8HCX8rkr5uYp+4PqD866nOQTbFhTF+wP?=
 =?us-ascii?Q?VDaZi1XC/5UJHoepD3J8mC2zeOH1gsTBncvV/+DvyOQPC0wDdn5hqBoigOhd?=
 =?us-ascii?Q?3BRSUwRTaa6A86llcZJiO3dg6JTXceLJPvglDmvEzBErevHcDCjSQi3Ww3sX?=
 =?us-ascii?Q?uCy3GyEOgUcVyYhsQzOM4xL9EaIPSFJWRLthkZgKgyVPqRJddC3HkmfG0BcN?=
 =?us-ascii?Q?lGv8kIj3qy4/9Vi5UfpA8JVC511FvGob5LRbZl16DR313Cm9mZ7sK2y0FKhJ?=
 =?us-ascii?Q?vB11STc7Gme4MzP29gfUt0XhlXhTx3OVzNxLymWAIpHoMscE46Jb8/l3nCV4?=
 =?us-ascii?Q?CG2l7/MulXr7MOxPCFA9gJP/hbHtUIVQP6V/6u+aXuP89G2VjSmSrnoVVQ2J?=
 =?us-ascii?Q?r2AtbuUHc1G+nqa+irpolqaUuN0na4xmYV+EfmpUTqBnsJCt0hQzlpWtDBSP?=
 =?us-ascii?Q?bZqRs1abvdrvWDEW/w9zv5dYacDX1YKtCWJcUuy5IqvtOfDGdRYAMr2rpajm?=
 =?us-ascii?Q?8VYKoRvza+ayFuR2noXafONpaNeXchWkR0kg61uwhOsBR1T3pArF6HGYaRQS?=
 =?us-ascii?Q?IeluIpmHNf3mDcmghG/tUwEHoV9RRxVd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9CVwghlEW6vuURkLSOBb594N0kHgRVZrFerVRpBVZxccJCRl3dAzKeYLqswV?=
 =?us-ascii?Q?If9Z1Zb+K4DlkAfQ0+6oat9FQFZBp6yH2siJ0rPQPoep5BbRcJBCgjvW+Aby?=
 =?us-ascii?Q?8tDQa4ssJdIqZH3r4jQ4IWxjel4Q/VoTGVFRZ+6tlwjXd2Uq6458K3dP6agf?=
 =?us-ascii?Q?axoDTSqd5akxWfKM+T3ADGwMp2jHVrNyJyROKFhzs8YbA0cDbTWtqWfFq85l?=
 =?us-ascii?Q?7Fcn9kkJp8sPdbOYLovyMu7u+2l/kKAtlmoXim3p8HvVMUD6BKqZjSeWvuUM?=
 =?us-ascii?Q?pU0zdtYDx4+EHCXSyy4y3p2RpZcgFRuHqkMVT53hqVvSkreoBDxxF09mLlgJ?=
 =?us-ascii?Q?OUuGIJjfcuhMLCTBWQaq03e0ZwQ7XIlzJDNqVpSSiBmoCMtPzwsMIwp1Ewga?=
 =?us-ascii?Q?3GSNmmi8gIFTQo2wgCkN+IVUO006fHS5/rxZQA2UT19rycBXR1fYZwAas2kO?=
 =?us-ascii?Q?B56tyndX/YggWjy1rT/hib3k5jS52jDrWvj3Ah7E/zngTn7ojd+AlMC0NYB1?=
 =?us-ascii?Q?oLt87rvMyzZGyQxsrPzdPsds+jlvYM+YKQtJjtPvE7QP2shlhSnknGMY7Y66?=
 =?us-ascii?Q?5fPqGYCkwIHVIOAyZBOprEhVCc5P232IC0TbuFmD1ROWFxZIrSO2EN8w4sPn?=
 =?us-ascii?Q?XcvgvxmxHrVv+/hL6+xIjF3Cfn2ts6yFRbu4H7l5lpFEkwUuqqdNlqvR3PCn?=
 =?us-ascii?Q?P0Mk8ELeKttEoIodjagdP38NyqESBEc7B0zXHkqRKtHEECaF7RiHqWmcqk8e?=
 =?us-ascii?Q?zG7PFwlfNh0p59FPTwr6DdlC/6DPdCUR6kLpUUy3K1y4PnfhzWkIxDeKkrIx?=
 =?us-ascii?Q?PCI4dnNa3vnboD0SNMTVP5hmDwyC+yRCH6MrT/A37dYhHxdihvFZUyOwGvft?=
 =?us-ascii?Q?X0+YhyZcZeNAl00HbPBG2C3G2TYhbqh8yCoO4W0hpn6FlD2EtgX698GF10CP?=
 =?us-ascii?Q?GcMmzms5w6bdUJYwfVCdRGruiGeaOSyF5+LdW05TcKc5tnfMvZzljwC7J3sy?=
 =?us-ascii?Q?ds0TG6ejRM6V2Mtz9HNzm35gy8v30SbHXxh6AG1ENQN4FqZSnlarXWsQPvyt?=
 =?us-ascii?Q?PFCdJqzuEtvW2neeoBInJqRh63K/Q6IxDCWsn8ES3HgMiFcj63KLy8xO36U3?=
 =?us-ascii?Q?FRD1kCGzbjYb5bj/oEPx06ByyHobkVnxJTdm4dt6Oz4VoUZiHQoymEu24olT?=
 =?us-ascii?Q?CS41GQ8Y0cqCjm8wsV57/+BDZmEsCe6tq6eUwyngWvwc4cNbzPUNqUNUe2bm?=
 =?us-ascii?Q?HEV5dvY3rZYzlV9hXzT1sRY51DxJW3A4oVENfUutMXBQJgl9O0SGIqvsECam?=
 =?us-ascii?Q?8RE+KoeiZSI2dv/IZGYnJJJTGX71qKjb51o8LPVnWIBfyznqQCvCNA2PD/+N?=
 =?us-ascii?Q?qx+44GedYUUIGVvkK2ifyKKDCFOdJBWiiY1S3kBDJnQx9ZVNsCXUvtmuq3cT?=
 =?us-ascii?Q?l3E1jbTznfluA3ozy+1HzZrAGqZjjh+tGt2LoGW/AlHIcaYkoE4SteL2HrT3?=
 =?us-ascii?Q?b6YvcwZKuk3C5V2mJZNNU/GugweqsGrZ1062hP7z3NcMuoaRXjnOqCr+XBow?=
 =?us-ascii?Q?Uliii/1FJpOZQxaZ8HYXUGyd7jRC1sdfVY053zSVPSHevmUeFuW2o6o5x7lZ?=
 =?us-ascii?Q?2vdlRKB3PXKP7455l/Ej3rEzA9ch7vBZwfOfCxYIU3iYKEuVn05e8M4yAnV6?=
 =?us-ascii?Q?dU+TJEeYfE7s8kVRd80lCH1Qjn28m49ykpoY8oCmP2Zq7RF12mDfwauRFkmr?=
 =?us-ascii?Q?JfYnajhGwUks7VAqaQ+0RMBHpOqxUqZcL4H1p1osfueA1a43Ga6i?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 391bfc2e-fb5e-4ac0-aa65-08de4c30d6a2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 08:02:57.6885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /uIldf77Xqap8wZADQOHKlbAVHQK+Tx7XIpp8byUZFh2CM5xwHj7w4JIxMt80vwieu/M5OkgFM1qGdX7VTfAog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1826

Extend dw_pcie_ep_set_bar() to support inbound mappings for BAR
subranges using Address Match Mode IB iATU.

Refactor the existing BAR-match helper into dw_pcie_ep_ib_atu_bar() and
introduce dw_pcie_ep_ib_atu_addr() for address-match mode. When an
endpoint function requests subrange mapping via pci_epf_bar.submap, the
DesignWare PCIe endpoint controller programs an inbound iATU entry that
matches only the specified address range within the BAR.

This builds on the generic BAR subrange mapping support added in the PCI
endpoint core.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 198 ++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 2 files changed, 188 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 1195d401df19..d1e50e9989ed 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -139,9 +139,10 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
-static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t parent_bus_addr, enum pci_barno bar,
-				  size_t size)
+/* Bar match mode */
+static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
+				 dma_addr_t parent_bus_addr, enum pci_barno bar,
+				 size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -174,6 +175,151 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
+struct dw_pcie_ib_map {
+	struct list_head	list;
+	enum pci_barno		bar;
+	u64			pci_addr;
+	u64			parent_bus_addr;
+	u64			size;
+	u32			index;
+};
+
+static struct dw_pcie_ib_map *
+dw_pcie_ep_find_ib_map(struct dw_pcie_ep *ep, enum pci_barno bar, u64 pci_addr)
+{
+	struct dw_pcie_ib_map *m;
+
+	list_for_each_entry(m, &ep->ib_map_list, list) {
+		if (m->bar == bar && m->pci_addr == pci_addr)
+			return m;
+	}
+
+	return NULL;
+}
+
+static u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
+					enum pci_barno bar, int flags)
+{
+	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	u32 lo, hi;
+	u64 addr;
+
+	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
+
+	if (flags & PCI_BASE_ADDRESS_SPACE)
+		return lo & PCI_BASE_ADDRESS_IO_MASK;
+
+	addr = lo & PCI_BASE_ADDRESS_MEM_MASK;
+	if (!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+		return addr;
+
+	hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
+	return addr | ((u64)hi << 32);
+}
+
+/* Address match mode */
+static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
+				  struct pci_epf_bar *epf_bar)
+{
+	struct pci_epf_bar_submap *submap = epf_bar->submap;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ib_map *m, *new;
+	struct device *dev = pci->dev;
+	u64 pci_addr, parent_bus_addr;
+	u64 size, off, base;
+	unsigned long flags;
+	int free_win, ret;
+	u32 i;
+
+	if (!epf_bar->num_submap)
+		return 0;
+
+	if (!submap)
+		return -EINVAL;
+
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->flags);
+	if (!base) {
+		dev_err(dev,
+			"BAR%u not assigned, cannot set up sub-range mappings\n",
+			bar);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < epf_bar->num_submap; i++) {
+		off = submap[i].offset;
+		size = submap[i].size;
+		parent_bus_addr = submap[i].phys_addr;
+
+		if (!size)
+			continue;
+
+		if (off > (~0ULL) - base)
+			return -EINVAL;
+
+		pci_addr = base + off;
+
+		new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&ep->ib_map_lock, flags);
+		m = dw_pcie_ep_find_ib_map(ep, bar, pci_addr);
+		if (m) {
+			if (m->parent_bus_addr == parent_bus_addr &&
+			    m->size == size) {
+				spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+				devm_kfree(dev, new);
+				continue;
+			}
+
+			ret = dw_pcie_prog_inbound_atu(pci, m->index, type,
+						       parent_bus_addr, pci_addr,
+						       size);
+			if (!ret) {
+				m->parent_bus_addr = parent_bus_addr;
+				m->size = size;
+			}
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		free_win = find_first_zero_bit(ep->ib_window_map,
+					      pci->num_ib_windows);
+		if (free_win >= pci->num_ib_windows) {
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			return -ENOSPC;
+		}
+		set_bit(free_win, ep->ib_window_map);
+
+		new->bar = bar;
+		new->index = free_win;
+		new->pci_addr = pci_addr;
+		new->parent_bus_addr = parent_bus_addr;
+		new->size = size;
+		list_add_tail(&new->list, &ep->ib_map_list);
+
+		spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+
+		ret = dw_pcie_prog_inbound_atu(pci, free_win, type,
+					       parent_bus_addr, pci_addr, size);
+		if (ret) {
+			spin_lock_irqsave(&ep->ib_map_lock, flags);
+			list_del(&new->list);
+			clear_bit(free_win, ep->ib_window_map);
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 				   struct dw_pcie_ob_atu_cfg *atu)
 {
@@ -204,17 +350,35 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar] - 1;
+	struct dw_pcie_ib_map *m, *tmp;
+	struct device *dev = pci->dev;
+	u32 atu_index;
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep->epf_bar[bar])
 		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
-	clear_bit(atu_index, ep->ib_window_map);
+	/* BAR match iATU */
+	if (ep->bar_to_atu[bar]) {
+		atu_index = ep->bar_to_atu[bar] - 1;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
+		clear_bit(atu_index, ep->ib_window_map);
+		ep->bar_to_atu[bar] = 0;
+	}
+
+	/* Address match iATU */
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, list) {
+		if (m->bar != bar)
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->list);
+		devm_kfree(dev, m);
+	}
+
 	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
@@ -364,10 +528,14 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		/*
 		 * We can only dynamically change a BAR if the new BAR size and
 		 * BAR flags do not differ from the existing configuration.
+		 * When 'use_submap' is set and the intention is to create
+		 * sub-range mappings perhaps incrementally, epf_bar->size
+		 * does not mean anything so no need to validate it.
 		 */
 		if (ep->epf_bar[bar]->barno != bar ||
-		    ep->epf_bar[bar]->size != size ||
-		    ep->epf_bar[bar]->flags != flags)
+		    ep->epf_bar[bar]->flags != flags ||
+		    ep->epf_bar[bar]->use_submap != epf_bar->use_submap ||
+		    (!epf_bar->use_submap && ep->epf_bar[bar]->size != size))
 			return -EINVAL;
 
 		/*
@@ -408,8 +576,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	else
 		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
-				     size);
+	if (epf_bar->use_submap)
+		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
+	else
+		ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,
+					    epf_bar->phys_addr, bar, size);
+
 	if (ret)
 		return ret;
 
@@ -1120,6 +1292,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	INIT_LIST_HEAD(&ep->ib_map_list);
+	spin_lock_init(&ep->ib_map_lock);
 	ep->msi_iatu_mapped = false;
 	ep->msi_msg_addr = 0;
 	ep->msi_map_size = 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f87c67a7a482..1ebe8a9ee139 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -479,6 +479,8 @@ struct dw_pcie_ep {
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
+	struct list_head	ib_map_list;
+	spinlock_t		ib_map_lock;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
-- 
2.51.0


