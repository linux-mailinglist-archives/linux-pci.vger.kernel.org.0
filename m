Return-Path: <linux-pci+bounces-25684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFD3A861FC
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2ED14612AA
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D554E1F76C2;
	Fri, 11 Apr 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hZc88OaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B1487BF;
	Fri, 11 Apr 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385716; cv=fail; b=uI0R9DhUnvFLv4moh7uaOxM9Po43j3pzvafL4A2Hq9qiyteYwfBkbu6Z0j1hdRRwhl3/ViMuocgOtwaiDC2ksFPDJ9fahh++KZ3b2c6OLKdNrKJ4hk602n6k01ccKuw1ufHyrIhqpGh6XghnY3f0/UK43aawxrtRmyimKefM1pE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385716; c=relaxed/simple;
	bh=jM3DjSVS+dpszwY229eXX4TdlSK8orUTLwrQNYiPxNk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u8IXA7xhm2O8FwC+xJKW8xi+WZ1dmaT+G4B1HxboDvzAsbnh7X/XOmsrUyPc9NCfshny5Bl5QIDxy4ap2s+0fY64y77+X+wSPeH2BJ32PA3dYJWm12+Ym1feFF0aRAXaSqGuZplXWTlg48gII3KGu2iLMpACug6lC1FMsl332uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hZc88OaX; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIMldf1miwtHXLlORiCuUwwls0Vk9gLnBrAR9CGul1W7v5OX+4yD9y+Y6IAenSehN9bxVGJ9M/m+Gl+I8cduTT+6aAb1eYiuqC7rV6anT7fHFwltuONefWdY6Rkrk1MVWEwWG+QR0k2xf8HTDOnROEhp52H5Wuuyg1SCvyiiCcpu9h4JuXhqbtZN2mTOFw2TpZrHXmQeXWQ4Hw5WMsz1BD3hCJ1x1/JSnawy0NEMYch1YjDpL5jUaHiuAwXnkVbMSvI2Ab8pW/NaZOLWkeUGQqKU5SLDLJNKwKjSPTWvo4vUJBjX6CMdlJJVaB+78u3U69WI4gCrXYSbYFSxIr0LyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD8ET43vilSmbbEha8XAhP25pzyvlYKe3jALG0O2CQo=;
 b=K8+gPCkH9K1uS7e78RR2PQAohCZ/KQwXJcTiVj//Uiz9Lr6CTaanEBDXMA7devURD6hqsjQlfufGmAMMBS0C1N9Mfwz02SPnVHvLJwH4IgIELBU4zAaw1q+TlnFfrWA+BH6jX8hT578XVsuMTg1llaPt2h8rKH2SqCShfBc8e6bMlX7dTuWX1fsYZh/jF7EFGP6yct4OfiT9TMxZiTtu9IsgWSLJOFGBDLks60Sw7gYSalRHOAw+Q9uDqBj6agcl1th4j596y3oVbzDO4KNe9uV7sIV1dY5a4PyXqA+qSt3Krl2N1Wmn1zTl1z2xQAdI9zYd1Lcaq/N6B6Y2Wxf/6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD8ET43vilSmbbEha8XAhP25pzyvlYKe3jALG0O2CQo=;
 b=hZc88OaXXCG7iqD2szqcpcEZIODCjUXhwSrfOfDAWmVTYflct0xRHvEEO9eT+mZsCviOdE/Cjyg+kM7u0vOwG9RIQ9Peuh49Kv9FWvMsAeZJ0OcPmbTOwLm9NKnBNe92F9rkpmnJwPMIeYdC5EFaIvXkU9jTgMTfeN8pjoRdVcvvRv36+XsNELCfk1wbhdDcCvKodbBJhda4CN9Sp5NitUIuGgxsKpUKYnID8POX8Od+m2OMsVomV8sWeNhrO2uumV5Vd7mBkYp9RbSHVa4ah8t5A2onDZruNtFc3udaon4/2RVeGTYX6c+Z2qZWoGmNOcRonP69tdjMeHElRPQwEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8159.eurprd04.prod.outlook.com (2603:10a6:102:1c1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:35:09 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 15:35:09 +0000
From: Frank Li <Frank.Li@nxp.com>
To: s-vadapalli@ti.com
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	kw@linux.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	tony@atomide.com,
	vigneshr@ti.com
Subject: [PATCH v2 1/1] Revert "ARM: dts: Update pcie ranges for dra7"
Date: Fri, 11 Apr 2025 11:34:54 -0400
Message-Id: <20250411153454.3258098-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a69c9e-44db-477c-7fb4-08dd790e7137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hCREMt6jxUmyxqTigkieWT6lbQ50AjMvKEdJjjZVJGAznGcOhmEOb6uuXHO0?=
 =?us-ascii?Q?18EydddQd0gQ1as4Rjo9cy/axk5tEl+X+xxQBWs3KI34u4CcrTJ+t7HmDr5s?=
 =?us-ascii?Q?7virQwqgPKgeaHyTDyQCIqHbD3rf1MgBj/sexkUx/X2ky/SDGrV8IBz8e3XR?=
 =?us-ascii?Q?HVQPbtUi8nXuCQLTKgcZamsspOGXONxw+/wFFQT1cZ6OiwH15/rJJJKBJowa?=
 =?us-ascii?Q?/w6PFmly5aq3zmKZaSJLs6Cjf2wu056efF8EseY21nSVP3eRlehmlg/gCeAS?=
 =?us-ascii?Q?uLOwEKB6br0EnCJ3QXzvHblCzUPoT49NgS1nJUqOExC1wcXinOw0sB+s0EV/?=
 =?us-ascii?Q?YlLPD9hlVHqNXbIklnP5Z5myB4ty3qLlbInMhz0nGKWTv/OeYtzB7JXeUYEp?=
 =?us-ascii?Q?svezMv1aQPMtdLtKItw1krDc1ub2urXKeLzikjZDBxTZJfOeEmaSXXwM8mNE?=
 =?us-ascii?Q?eZ4UfVhp65+XSrGg5rz6rpLilBEHx94VtKliCd91nF+vAJFSrpthVY3Cj8Vm?=
 =?us-ascii?Q?QUVbdiiJxA4SQtmI8u0T1TpbKI2KIFj88bKQsolBK4aZu+hSIivTkjA+CQHP?=
 =?us-ascii?Q?Z7LZcLtym04wH4fdELiaBBDNVL78IAH4lXWAnGbiwnghgxfqw6CYSGjMSOPn?=
 =?us-ascii?Q?AMum25z/EPVnNPlVCY6WGlaJiqrSqzdmjR31V5XKBu1QsDUch6/U0IkGsbjM?=
 =?us-ascii?Q?dz/0NjjRvRYvpTL3itOZ8HbgShktKmvrOSe1wzyM+4VuYFgr299/avSwOg4x?=
 =?us-ascii?Q?+352XtuiREz+SNPM46iXRDIuHaPdvFclyeI3wqPcEbXs3ICwpWlMkV7xGlon?=
 =?us-ascii?Q?s5Jx3OivTlm+LoegXTuzzrqA8D2RihNkevUvoVj8OGBffnYwb/++u21k8TQW?=
 =?us-ascii?Q?aqITRiwqVJNUk4crKILfbVFmebc26H2XuxlUKZIoNsG7DXFrZMdlKQauTfN2?=
 =?us-ascii?Q?od8G3pTtoArvlJawY+M+M2IGuAG1upqrotQJ+dsH7TtrBvlnuZE7yjdDLS+S?=
 =?us-ascii?Q?koa5hU4bXgvlaZbdifGgTQwYnBYujm3bdnUg1PKIgt0EgE9YCBj/sP43Fv/0?=
 =?us-ascii?Q?uluEh2D5td9txTQnvsC2fycD6Czwsxq2Mfxie+q1iI1YXX0CvxpYFGadUI2f?=
 =?us-ascii?Q?HdtXqvey6/Gi+WGTABDNm/vF21b/hSNgc77aUsS2BG5LdO2s9dYZevjE890X?=
 =?us-ascii?Q?vCfqCtg+D4dl7TWEF02xtMyH2Mk2REQSjKfFbA8OPO+mEqUdEmKplh0Iw+8H?=
 =?us-ascii?Q?LX9xMDCGChOWL6R13mcb09X2TDqb5I+/ZnSXZSKyjH5tctrGoFxbAA/TXEJG?=
 =?us-ascii?Q?s0tMmHwvIDzxKyhLTXgl/fuWOt7v2M+s4K8H314p7uZDa5ih2kelXYLtj+du?=
 =?us-ascii?Q?IgaHHayjGrHBBwv8hBUifku15EBp4SIZgZR2hyg7rFAGcx7d64Q4d6jVVg52?=
 =?us-ascii?Q?tD5gqZhiAsQ2E+3Q2JPHu+CWs0kXJ+TOdQC/MWp0GlEDm/b0sP2BfUenoir5?=
 =?us-ascii?Q?f7WQ5Hfc5E6Craw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0kYyi6a2cHNZBctLChVcBBMknjXNmaw2YMJZV7rj0QDgmNqFMcswQ+HbHbdn?=
 =?us-ascii?Q?k5rVi/JPhy2sU6/ihXyc5SBo+0IYLJQqpXVm4Hptr410a6ubxQdw0EcZBO4s?=
 =?us-ascii?Q?mZ512xZjVddYtCIBFDDG8IZUzUV/aQ4VpcCyc0RHKcrbb/SBt/AFtHJ0G4Nu?=
 =?us-ascii?Q?EUH749CB9uyEAqD+yOelcibSh2NkAIPg6L+OR0MKnbVBb9HeLTBAgOyWUplM?=
 =?us-ascii?Q?xJKwYxrI3Ak+j8O0l1j+yu4Pjti6bMMBOOJPbsoBM1WjJaiajrV1FWqg2FOH?=
 =?us-ascii?Q?MUvb0jhkbPwCYAee3mtN3vIjVU/ZpfGZiA31rWYWbFpkKLb6mypMAZRBPyBi?=
 =?us-ascii?Q?2kuje5SnGoA77piR0S/VBxgc8znpjjNRGDHzBD9yeEC2kkEwYQplkEJNIKox?=
 =?us-ascii?Q?Isg7a3jebDcwF/HfQyCxQ46Mc/Y7MczMzKlk6FT8ygWgDaceISchnRFsDQp/?=
 =?us-ascii?Q?oWmLcYlVhAPl1JqFhG36BCF6MXalpUhLW4YF4T1NmVwZO00ysYhLOc6soeOZ?=
 =?us-ascii?Q?n/7i4Qkfy8P+KKaN5dd+nC+qeAA9yYdp4i69rl1RTCgt0VY9ahxkhamWu71a?=
 =?us-ascii?Q?Z6oVR5MdQ+f6JXXakcnRRIPMgvNIoL16SR57uQaXdd37zJaMItGHBItXeZRB?=
 =?us-ascii?Q?P5yhanOWp4PFnY5yiHbrXs9UIbvmj+pb9XZBoRLv2q+oGl3TcCpjD6lJQ3Cn?=
 =?us-ascii?Q?0gOBb7ejnXflvOnKfbOdg5fUI1YEaMbOYJvGcKMbAlhoQLSt3lzgnwhfR0uv?=
 =?us-ascii?Q?mKiG74FU9NpkwF1vQfa09L7rLoxhGqDudo6JQJjyPWp3EVSEsb3xmZKJYeWu?=
 =?us-ascii?Q?vtvK4I6FSI89H5Qa0Vlp0CM27x9UYCA7cQIdSG8qBAvCfJnSA6RKiNBLaP/m?=
 =?us-ascii?Q?oN8jlJTuzS6E4u4hbiDBGOh4OP7eJm7feWVDKiB9CHS0UAmy/+d1dA3F2kAJ?=
 =?us-ascii?Q?WjP+EehSbnJFOr6GxPXfJSYe9Sdbn7gK0eyahRpChx7KYqYdsfom+nxkGd3W?=
 =?us-ascii?Q?JnfioHz57cs3TfS3+lsV3W4z5dqAMSSZmgDzSdK4TMRk8eRhkSLh+8wWS7yk?=
 =?us-ascii?Q?QnVclTSvoCgTxOGIzFjBmnQDca9NqR34nPDRr/jmpp8noJedn9dE1lTYSigD?=
 =?us-ascii?Q?qTdq4K2LyQRuIWviuXwoDSjV/lCYuWuy2tz3V+gpfIxi84i6O7QnopxQCEtv?=
 =?us-ascii?Q?n2blNDm9so+kYpYMUzYxCwVtMWjvYEw7QQI6P3BynmVcKqG5WPw2Sy9zA8f1?=
 =?us-ascii?Q?T3N1JBdVN7Gs4pZsJA9oZX76RZfq9x4ckMWe6EI04Pm9CNeRwfaWACHofkRs?=
 =?us-ascii?Q?xSHXS3l3Df2szm9z77SaThl9j/vjVhUAJnkuZWO6qodQ1S7iqT0heesgwiCj?=
 =?us-ascii?Q?JwT0tYyO4D74HeGYp4CpkXLyqF/Lf1kcPev4+wUQPHnvIYO43/wYivZAqw0E?=
 =?us-ascii?Q?andejfZavsZe5JcKuZxtfGssjj5rBvREwBidnuZoaeEGMUx1tG2M2DNFXzsm?=
 =?us-ascii?Q?W2e1VTo5wJaDTc2ZrhaoKNIxNZh4jT297aUMd4eKZnu0OygR/MSdYXdEzDEM?=
 =?us-ascii?Q?l3nl4F5U0+IwzWbOFtGZJMWrvQiO2sgQgp6rErqU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a69c9e-44db-477c-7fb4-08dd790e7137
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 15:35:09.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r/H1vSza7WXtI+x60cM5ZSO0qc/1ZSicEWLTus0cxxeRv2ffX08PmO1dpB/XQaBMtkdYTnpnutxAmnTrBuDN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8159

This reverts commit c761028ef5e27f477fe14d2b134164c584fc21ee.

The commit being reverted updated the "ranges" property for the sake of
readability. However, this change is no longer appropriate due to the
following reasons:

- On many SoCs, the PCIe parent bus translates CPU addresses to different
values before passing them to the PCIe controller.
- The reverted commit introduced a fake address translation, which violates
the fundamental DTS principle: the device tree should reflect actual
hardware behavior.

Reverting this change prepares for the cleanup of the driver's
cpu_addr_fixup() hook.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2:
- update commit message to add more detail.

Previous disscusion at
https://lore.kernel.org/linux-pci/20250314064642.fyf3jqylmc6meft7@uda0492258/
---
 arch/arm/boot/dts/ti/omap/dra7.dtsi | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7.dtsi b/arch/arm/boot/dts/ti/omap/dra7.dtsi
index b709703f6c0d4..711ce4c31bb1f 100644
--- a/arch/arm/boot/dts/ti/omap/dra7.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7.dtsi
@@ -195,24 +195,22 @@ axi0: target-module@51000000 {
 			clock-names = "fck", "phy-clk", "phy-clk-div";
 			#size-cells = <1>;
 			#address-cells = <1>;
-			ranges = <0x51000000 0x51000000 0x3000>,
-				 <0x20000000 0x20000000 0x10000000>;
+			ranges = <0x51000000 0x51000000 0x3000
+				  0x0	     0x20000000 0x10000000>;
 			dma-ranges;
 			/**
 			 * To enable PCI endpoint mode, disable the pcie1_rc
 			 * node and enable pcie1_ep mode.
 			 */
 			pcie1_rc: pcie@51000000 {
-				reg = <0x51000000 0x2000>,
-				      <0x51002000 0x14c>,
-				      <0x20001000 0x2000>;
+				reg = <0x51000000 0x2000>, <0x51002000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 232 0x4>, <0 233 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0x00000000 0x20003000 0 0x00010000>,
-					 <0x82000000 0 0x20013000 0x20013000 0 0x0ffed000>;
+				ranges = <0x81000000 0 0          0x03000 0 0x00010000
+					  0x82000000 0 0x20013000 0x13000 0 0xffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
@@ -235,10 +233,7 @@ pcie1_intc: interrupt-controller {
 			};
 
 			pcie1_ep: pcie_ep@51000000 {
-				reg = <0x51000000 0x28>,
-				      <0x51002000 0x14c>,
-				      <0x51001000 0x28>,
-				      <0x20001000 0x10000000>;
+				reg = <0x51000000 0x28>, <0x51002000 0x14c>, <0x51001000 0x28>, <0x1000 0x10000000>;
 				reg-names = "ep_dbics", "ti_conf", "ep_dbics2", "addr_space";
 				interrupts = <0 232 0x4>;
 				num-lanes = <1>;
@@ -269,21 +264,19 @@ axi1: target-module@51800000 {
 			reset-names = "rstctrl";
 			#size-cells = <1>;
 			#address-cells = <1>;
-			ranges = <0x51800000 0x51800000 0x3000>,
-				 <0x30000000 0x30000000 0x10000000>;
+			ranges = <0x51800000 0x51800000 0x3000
+				  0x0	     0x30000000 0x10000000>;
 			dma-ranges;
 			status = "disabled";
 			pcie2_rc: pcie@51800000 {
-				reg = <0x51800000 0x2000>,
-				      <0x51802000 0x14c>,
-				      <0x30001000 0x2000>;
+				reg = <0x51800000 0x2000>, <0x51802000 0x14c>, <0x1000 0x2000>;
 				reg-names = "rc_dbics", "ti_conf", "config";
 				interrupts = <0 355 0x4>, <0 356 0x4>;
 				#address-cells = <3>;
 				#size-cells = <2>;
 				device_type = "pci";
-				ranges = <0x81000000 0 0x00000000 0x30003000 0 0x00010000>,
-					 <0x82000000 0 0x30013000 0x30013000 0 0x0ffed000>;
+				ranges = <0x81000000 0 0          0x03000 0 0x00010000
+					  0x82000000 0 0x30013000 0x13000 0 0xffed000>;
 				bus-range = <0x00 0xff>;
 				#interrupt-cells = <1>;
 				num-lanes = <1>;
-- 
2.34.1


