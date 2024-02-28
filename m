Return-Path: <linux-pci+bounces-4204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749486B7DA
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F4B1F285DE
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9DD74416;
	Wed, 28 Feb 2024 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lVQR+kLC"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2073.outbound.protection.outlook.com [40.107.247.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B737C15E5DE;
	Wed, 28 Feb 2024 19:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147036; cv=fail; b=PK/IadzGJnj+8gCsOhzAATtdFZKylCv2XhpaKr/NV1Jx8L0qhEgXUWeycCiYqvUjgkcMS4FtiqbKweGaA4ypft9Tpa7p11vv6Xn04aFGMw1CkSl05/RvMgPFt45Eeoo6ZnbBiG4fmumIN31NLgJHHV1iRohXSqbbGcUVNivG8pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147036; c=relaxed/simple;
	bh=iHYtfER7OTpoB207yr8h9LY9LQnUNoZrnhZ63VpQfpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SijYgUK4WFIld9sFZAvmeAV3JVggrPCOKMGphJWw2OgBc0cuhwf+1hYTndxyhdnDpUGi58hCpViUq0P27SctQrplwCejgLLzr0O+lCnKsX/EFkEz00Re5fMyYB3Z/e2bYzz20J8pRQiZ36i0fvvTWURbUD1qveeZoPv18/bzOA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lVQR+kLC; arc=fail smtp.client-ip=40.107.247.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oC6o5whHbS/Ifd5KcO6jQxyxrM8lmpw8fqPlovG5irWOvdMlhMYAAwoge5qQltjppv71k6zjHBg9rcdCfnWRYkmQ5vJQXzTozI1KA6vmgViNmxgOQbAix721Q0OTgV8iEomksr2FhMzwIBbYMgtCMJ/VG1cgpoy7tnMjZBT+hVLC2e0DgjT/c4mDgoJ4BLP1KNqvATlg581lMbFCLjFXAj54Om59cG39NEnxo15Motb/FvkE0VHT89/c3WwC/VwdkQba/92E4lDBRafmuzYsKSvH2abtBcdjMAAMOdpNb1SHwQbwN4RKV54L7YMRsn9yt5ZNqVu7OwjQ/48oKImppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUpGVAxR1hk67J6CGSQjN28ODUst8NRJt27mR+B4YN8=;
 b=g4ysDUhGCC20Ks2igmJRIg2Zz0fPWoaOMEwofe4orJZPUiyj2u6wI76V6i+WB214QgH0dcLug82nsRV6mkyfwFYRhWYjzyFul8tcy8LI1VjWkJuAki9oPd/6bzDpNnWgcdIU+KTKKGG+ODFxxHkFOMX+GBwpw9lcqJli8WT+Ggbn8QvvNltAcalj+m7Mz12RqWXTV77FZ805HnYSbEz90kKIaKcqQL2cnyY1Qco3LLwSoC+8a235buIumb94UoUAaxWOeK1RBHNXJKpHDc9/jdOdcde5IR1PNwPDs16DLImmd2NVGfEjf0h9CCMBlqfGAlKOI976i5EHi+yYRNIM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUpGVAxR1hk67J6CGSQjN28ODUst8NRJt27mR+B4YN8=;
 b=lVQR+kLCEpZ4raApAQ0Q9phXF3xx4okkV1rTnnDQpNk13483mOT+UecUvjfpJVLLn6s0GIDHjSzl/LH54Qm6VvCSYOt3H8yMuDqP4grkFj5yWNbELxAyPfVmic8moSiregqJcmkeFH+wy8qXHt4XxZIfraUOgS3SUrmlyxXIHhU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8370.eurprd04.prod.outlook.com (2603:10a6:20b:3b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 19:03:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 19:03:52 +0000
From: Frank Li <Frank.Li@nxp.com>
To: helgaas@kernel.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	conor@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: [PATCH v5 4/5] dt-bindings: pci: layerscape-pci-ep: Add snps,dw-pcie-ep.yaml reference
Date: Wed, 28 Feb 2024 14:03:20 -0500
Message-Id: <20240228190321.580846-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228190321.580846-1-Frank.Li@nxp.com>
References: <20240228190321.580846-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8370:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef09673-af62-4668-2295-08dc389000ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BfTXClD0nWY+KYZtmiqL5a5R0mMMMYZQLs0mLWDAF8gnyAOMT+8ap5zxOs78rlA8/U3FhWBFTfsjphj9FWzZCCZp7Xhuu10OjL4/yV9o++EFCezqtZuopAK1amqRCV9r1R8M0B43uWG4fBxEYvut4J6MKTm2/dJKKHK2Xa3FhHCnwrWtx3w+oCxmSFy0pGGwOdJjOxYWleL6oaLx0XMljUdM9wDFZujvTkpynePb0ahjJpsK1FwZvB4ukg2mIlORS85WNZmG11tt0gW6bvBihpSJl8SDkU5bRWcLU3O6VAtgr8ag6ZOY7nsbVxJ7xytW6I7v3AAS2M6UpGz9dVEyVm8+MAQ/T+n0mHfgTXOt0MzEQgNzOqgRnejfjpqP/O4BMYsBzY64rDB1ixW6XjQuoXiNr0d35tFVZWkD2dWP5gL8d6VHQl4jXa36YrCRfrNOKdv/JkVJtOHAnGLMC7DtNAXweXRYLGWqXxy7xsWyFY2Q9g8TlnrqSSfetmQjA4+Iig3TVPBtvBKMCDQ3Mt6HhU6RheoC4MaPJWjQGMdjCr/PB8TlLIahh/YdS8xHXJUpaOPMcYZoebeV7zm0lfiGBoArrFWdLoVdPNDAILYKgd5qngb9VgJdvfRNyfdbXyv9f/GpTNU0DD/Wsf9bPcRfLlJRuAwpggZTStO6uwfYn54nXmh/tKaKI1eXElbOOqKMnm+xaMg0IsnyIwH99Fx+1w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+kdgwtZhVPkoQ/XdTV5sh8S3Aulr6QQbD8lnFH+MAwGRrzpubYIqOmp3Stki?=
 =?us-ascii?Q?DPlfIPF/L0P5zBjLhL2KTfiR1ROVoj/Hs73/YE6HMQjxU7NY7RgIMkyiVqzE?=
 =?us-ascii?Q?eSgcorKy0RYLsgmqWIGaT6M7HnN4z2/8rLTy8P57OlMYYAEH88k4BOAiQ3qg?=
 =?us-ascii?Q?ePuwaWm+7zRt72RWU7RCn9yUo9ZrNx7er/EWSzalcVyAlaDUrjClXcKEQc2d?=
 =?us-ascii?Q?kef0XBzDmJfclhDuIFvpFWY19iyRxUuBwMZpa4DC/ZBymWpvk3oCkuLcdO7l?=
 =?us-ascii?Q?SwO6VIuxQbSeSEMLsnE391hhO1pbhpqDtLyWNbcuPjsLaYhg+v9RRt5WRmCF?=
 =?us-ascii?Q?I9t4xD5gA+gHNvs8Cs87DD4YVEfAL7eR/9TysywX/grSezXz1l04nor+edYH?=
 =?us-ascii?Q?o/+i31sMYXjBtCCapL0XzXqWxcQz0Z885oA3vRQ/ANGlKI4cpAIsFIIoGbBP?=
 =?us-ascii?Q?FtcNzcmmPWTKZRkMdzu0u6CjvtWbEOsUM9DE0217+Dnshmr/yiutGtpHzHoZ?=
 =?us-ascii?Q?lvDAv84mKJgXUV/xMJw0p2Xp/YYVim6aaV0Y1xDLCQjvFmit0dfn5yCEWvQa?=
 =?us-ascii?Q?RkfVYi9P7ZBCc5HMYlWVAT1Jjr4FHOQxklb65ZFvHov8+AM0nuCY8D9YVqWX?=
 =?us-ascii?Q?CZBbSI9mlHxGMCm4B4HreRi8B6Rsqu64aGMlTf/j2M4MPax8sVs7sJwAiLGp?=
 =?us-ascii?Q?JNXaC7LP4SfpXnphHbUqwMvDVTsXUmDm9NOTm5qu/gdoBGnW/QDkIGDw06jf?=
 =?us-ascii?Q?pdpJtgRJOIyjSVhsmLSHLAJ4/YyXbNbnO6+5OvULGQMZkjMvdR5IexKqh9TH?=
 =?us-ascii?Q?boqzwxhJ2w2dxeUrNgd5VwkH5KOzqELhLvMOUtuiI8uiCVhQ4GDd3rOqilqD?=
 =?us-ascii?Q?OgKrjKJL0EfMFpSztGPe6nWG+UhemRVX5DFjSHz3hdrAl9NOHKCjC3cdmzeH?=
 =?us-ascii?Q?ul+PxaFrNFuQ4vdbFngYvGtJ9M1R4HVpJ9EPDJy+/XDSRpZHXia56EdGMDm8?=
 =?us-ascii?Q?xbFJfqN53NfkxAudGbSFd3gMpGQkok1CwzW/r865SFiSdfahDsiKcbkyne1y?=
 =?us-ascii?Q?ITqDA9XFadi1OtaxwUGLAWyeO1Ezgak41o1VHXQv81d4TR3SV/OK/AtgrIBm?=
 =?us-ascii?Q?MK5ucfTAQoPtNdKa1ebNm8NcLjbLhvNHRtBVVs3A3V/+8lP8/w7CdGSGuog/?=
 =?us-ascii?Q?vipOAoGo3hltXan4ACbFyE4ZJU4Qtj/2ex5poxYX1HH5AyGyPGDbHLfcEOtF?=
 =?us-ascii?Q?4tY+VfqtLTSq6QZfUK94Rf2+MkLwpNtf8KJZOBZIUXcodP8F2MbKDoj/4IGs?=
 =?us-ascii?Q?EFJgmBdUgec5HNE2vPlAi3yLzXx8iNWCplUUb6FNx53ocbiwf3qo7xRZ286b?=
 =?us-ascii?Q?lfzZUxp5qSfm/Nf5oNpBU4oYXlugJTosEHDgVAD4n+Nik7/eq6pMRYchSiHY?=
 =?us-ascii?Q?6rxTwVpeGyUWX1Czjx1fI60OpxoS3ykEj2dXNceDqf4KKIhKwb3PYbl0gz9Y?=
 =?us-ascii?Q?bDd6afCaUsHJGnD1SfnU1gInRSK3Aa2+C+JycERCENikb5x1ElOO99WYvs1S?=
 =?us-ascii?Q?4vqXeVxqnwCE25zH01+2X6nGJOH0GPNodFlBojDo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef09673-af62-4668-2295-08dc389000ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 19:03:52.1222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFUJtkd8UCIoGsgS3JrNkNmTk7/T7qqJXTro//cdi7budKiPgM7CiLvp+vzFrXri++xHn69XW5IZot6/O6g+1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8370

Add snps,dw-pcie-ep.yaml.

Remove context that exist in snps,dw-pcie-ep.yaml.

Add an example for pcie-ep.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/pci/fsl,layerscape-pcie-ep.yaml  | 54 ++++++++++---------
 1 file changed, 29 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
index 0af70a4bc5d91..e75b8853dca8c 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie-ep.yaml
@@ -10,8 +10,7 @@ maintainers:
   - Frank Li <Frank.Li@nxp.com>
 
 description:
-  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP
-  and thus inherits all the common properties defined in snps,dw-pcie.yaml.
+  This PCIe RC controller is based on the Synopsys DesignWare PCIe IP.
 
   This controller derives its clocks from the Reset Configuration Word (RCW)
   which is used to describe the PLL settings at the time of chip-reset.
@@ -35,31 +34,18 @@ properties:
       - const: fsl,ls-pcie-ep
 
   reg:
-    description: base addresses and lengths of the PCIe controller register blocks.
+    maxItems: 2
+
+  reg-names:
+    maxItems: 2
 
   interrupts:
-    description: A list of interrupt outputs of the controller. Must contain an
-      entry for each entry in the interrupt-names property.
+    minItems: 1
+    maxItems: 3
 
   interrupt-names:
     minItems: 1
     maxItems: 3
-    description: It could include the following entries.
-    items:
-      oneOf:
-        - description:
-            Used for interrupt line which reports AER events when
-            non MSI/MSI-X/INTx mode is used.
-          const: aer
-        - description:
-            Used for interrupt line which reports PME events when
-            non MSI/MSI-X/INTx mode is used.
-          const: pme
-        - description:
-            Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
-            which has a single interrupt line for miscellaneous controller
-            events(could include AER and PME events).
-          const: intr
 
   fsl,pcie-scfg:
     $ref: /schemas/types.yaml#/definitions/phandle
@@ -68,10 +54,7 @@ properties:
       The second entry is the physical PCIe controller index starting from '0'.
       This is used to get SCFG PEXN registers
 
-  dma-coherent:
-    description: Indicates that the hardware IP block can ensure the coherency
-      of the data transferred from/to the IP block. This can avoid the software
-      cache flush/invalid actions, and improve the performance significantly
+  dma-coherent: true
 
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
@@ -87,3 +70,24 @@ required:
   - fsl,pcie-scfg
   - dma-coherence
 
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+      #address-cells = <2>;
+      #size-cells = <2>;
+
+      pcie-ep@3400000 {
+        compatible = "fsl,ls1028a-pcie-ep", "fsl,ls-pcie-ep";
+        reg = <0x00 0x03400000 0x0 0x00100000
+              0x80 0x00000000 0x8 0x00000000>;
+        reg-names = "dbi", "addr_space";
+        interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+        interrupt-names = "app";
+      };
+    };
+...
-- 
2.34.1


