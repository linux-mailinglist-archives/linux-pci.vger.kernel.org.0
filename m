Return-Path: <linux-pci+bounces-14065-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DBA996672
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30AD1C248CA
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF7E18EFC8;
	Wed,  9 Oct 2024 10:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WSriArsq"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013029.outbound.protection.outlook.com [52.101.67.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6925C18E750;
	Wed,  9 Oct 2024 10:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468389; cv=fail; b=SCT0haf3Vok6OLdyOSBEhWKcZVpraE07n7PQkv7HXDvu6yNOMhJHvgiZH5gMQy5QyqsFHtQRuWIvpMrdj2rivEm9qY7zElTxgYiAWesZx40GVDsifwSicYlF3yM0ORr/HdhFOmkzWkPKi029KbTCIQjR2XxOpiP/87+krS1Q7l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468389; c=relaxed/simple;
	bh=bU4t1BrcpsRX8u67hF88gahv9X5uWqpyRMHvLxkavxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OvuwHQQk8SXrFzad9/0hvqckKR5DLIXn23Z1TmQxMf6gtGHMBY9Bm0ECia1Gehf5LlC8her8W89no3j2N/21RojohnBnjW/sUYEw/TsSq1ZF9qgF2eUBzgm6OMSotbh/wNt5wmLEGxBYu9KVWOBBtEdyoyPeYGEQTThJC02b6jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WSriArsq; arc=fail smtp.client-ip=52.101.67.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm1q18w5O0wtKi2eZ3mIQTRr5bOHYmovte7rl+/Z2WlH+leXqT3XNCpHdPMoZgy1GdeZ+Irxc89bmzPFpYni5Ui3ZSal2DD4Od+ovSXpxez/Q9sb4hIgIIbq3aNEmnrYCUerfL2fhDyUC7UgHDKxCCdKabMcoJQzevEHN88V9pZhOizZMJU6V4dDOSAbP4w6mt1A/1Ud3EcGKwd36/CSUSch1DvlD+V6xB/iOCg3loS+1mcvrJMvxoS70Lpb3Sm2V6gRIAs9d+HPNQIGzC2GYDVq2jgylutCjETFrJK+EUOlL1To1ceQD/kpCTpE7sB3kxWCTrqUiw4LPesw4ji/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4rBvBJbJjsiQCZxJ4p+lWnFEeDeDtba8geYeZvBMcs=;
 b=KEN1wudJRFCp9pLt3uYfEB175boc6a0YmCapOFn7bEGDBNnSEBkH+9GCEqLpIBWaXlWw4Y28rERPca1Gp3q0cAmwd2qWLbi7aexo9AvepA7js+hZ6q5MA9PAgtlNw7Sz48pRiFG8Kl/K5IIT2IZ5ITyhNfRPT/9IwcEsQ08jgUHM7CBd84ASWcfH1W82Wg2xi7olNh+hqUDM4AnW9nXxlwJ1ucVEj5Y3/x6XlNwL/t/Vyz5rb+KVRpR6FeM59fswUVT22vUk/oeoMWEZenjRCJaqxHsHtXcjhlPiBiJiY6p6sob6h29VXf6DFW4BE/U+2GqJXwbbDy8SkeKPpqJ3Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4rBvBJbJjsiQCZxJ4p+lWnFEeDeDtba8geYeZvBMcs=;
 b=WSriArsqGp5mG2EVmUtbqv/u0yNB7OGrnKkzOlCWdOz2uQiyNV5rb5TipdiLm1iy71RZXsHWd+66WmCyoi6tSX8AYE0xaBckxErncQ1vYMjwYxn5hAO5dfxz2xmnuNicNV7erPI5QqA7SZtAOYTELP1h698eOwuzl0NN45vamC25OrkfvjVGn1CBONw4cOJe799WORZvzmBr+YJNwSEBMcorYckEx87zkKYQIEUC2l10pm+nhO5Bel0zShorJ6PdRy3xK24bTxRMcsEjzuNdE0ec/9GHofiI3XqCS1eQY2utJDE+EpDpLVZGJOU6JTGN0sFme7xBMzc6hKLI35XMAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:24 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:24 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 01/11] dt-bindings: net: add compatible string for i.MX95 EMDIO
Date: Wed,  9 Oct 2024 17:51:06 +0800
Message-Id: <20241009095116.147412-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 08952c40-0759-4070-4a4d-08dce84a0846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q69C7XuTi6FrgI3iqTGXcAHC4Ht2PBxH7RExhKP0O46+gr+mg7kIUHZ528gY?=
 =?us-ascii?Q?p5roAaXkuGD4J03cj7V4kbD1R+Slzs8cZsVfe4MweE/LI2kX3SmkN3b1YDoY?=
 =?us-ascii?Q?NJKYySNVimizGKRP/ZpiG4cjmE5JqGMr+feN/5O+1IM/ZeR5REz+8hOwPRNN?=
 =?us-ascii?Q?ZtaMsApNduCzBpd9jmcsRFvT3mU30dkkzwdRPc3SVG4/ME1MwDMnJskAhXEd?=
 =?us-ascii?Q?WU+W6JX8w+FzyCKG8/VorfFKu6q4MbjCjXEeqUZcwClRmDj4Jr6LkplFef9h?=
 =?us-ascii?Q?ohTKfb1fVDnGizm+oeNRf/YStacrbj5YYa9v/gW/URNUy39YEtwzFW8PowS7?=
 =?us-ascii?Q?L2drfXSAs48bMEsFIa6M5o0dc8EVfD32L97DKAUivvn3/GqguQjZYJjMO2Ny?=
 =?us-ascii?Q?6lVILV0ioVY591mxLuz73cjtqg3/FIMsVqE1YzmKVXxR2QCylG+NCat13x6S?=
 =?us-ascii?Q?T1CnXGhoYKzhkhldfevqKlLo0s+Q8gn7vrk5kdGkbd3DWZ2cNoQPBgWuiOgC?=
 =?us-ascii?Q?emoJFAUgayRaXr58o0JBXdR7ZAaLEhr0tjV/GJWQM9XadLYFUEw/n0KVJZgd?=
 =?us-ascii?Q?i6vZ4pzKRoau/9Esbrp2BCXFc2MaesqQeGB806V2fDvYO7gMv5v3qA1JtD84?=
 =?us-ascii?Q?b8szPciHfCR3dVOqz133mphi9z5Ul3Tv0SGek19kgoVZCTiCqr3IySGJbjv7?=
 =?us-ascii?Q?nPacJReC6BiuJEyfOYYAGt8zw76S0sT8G7F8eenmFBtwDF8/QDACVBc9nBim?=
 =?us-ascii?Q?HMe+u4CqQnl0LbQ2uCCp6MCM0zrqozcu39IAl8qsO9Ttsp2F95nfVKXb1qqW?=
 =?us-ascii?Q?lVVleeAGMUXyqIlC+FMtud9gVAaC5GKu0z2iFX4EgI1/tvqDo/MhnLf0s8HR?=
 =?us-ascii?Q?86wJTaAHolpjFKrbNA5+WjklEvH9yIvuCBx5hx9S5gi3YQh2ArdujAhF5bCb?=
 =?us-ascii?Q?khcqK9Ut/NeWERKGySMSSLO1S0uThrufgIREMYENfGuZpjWfW6q6Ss23KjQp?=
 =?us-ascii?Q?j2ksTS95ixVY1T+EgyIyXmSgQKDUdf6Z/IDPQLWxZ5qY3/FadhOG0nBm6ehU?=
 =?us-ascii?Q?AoQR9I9FsoFGOw3NNvzFyHdq4CR1QhwhtffyPYCl6JyTDPlUEaTv4MBg5The?=
 =?us-ascii?Q?kLWlPrGLIVuikYZeCDlRNAfCHwevWD5/rbl2mEq/N7ncu4+VZvmsqTW4kO+T?=
 =?us-ascii?Q?qSa17butfmHYeCwEnIlPlY7rD1FdY7w6LS7QJ+qxhKow5CRzaAuvhra1yHpD?=
 =?us-ascii?Q?WgZ8016feJbj6qNUwRk+TRKSfICiBnWEwV7lfLAdvrQAC4MgCGXCJAcDEojk?=
 =?us-ascii?Q?oUG37YbfavgJpTvq0jjZD07QqlSYnC08/G+hO/V5864PU/BtCssRKkAo3wpk?=
 =?us-ascii?Q?swQ2udM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lO31Oic1VlJVfvc0QXDvZzTBr9RK5JM1s78Zm09BIBAxfHgSL4aaOi2sqyUL?=
 =?us-ascii?Q?X82sJhmyj9ciJp14txZ57i6g+R7oO4j/hUBTaCBV5P5kiQmvnEfqr2cHgrMn?=
 =?us-ascii?Q?8DR3Ozl8fGKxuItTX79G0aLkGsp+NS6EAw3aB+Xhqpy+CVWNbpEqpEUbBLVx?=
 =?us-ascii?Q?1r8R1utzKYGmi/vGY9mQ7TBO9Nz/lafGG2lWMJRkWlLg2XY8PF6v8ukvsdXv?=
 =?us-ascii?Q?nRFQfLPwArCqL2o+UT7EA0cthkrUgH8SUYGS7WxZOzrOPH2Ib0O1ywNhB/pW?=
 =?us-ascii?Q?M7q+U+mTKX1y5fWZY0wuiJ6sH3441wWpDXEwZzORZI7ybzc4nXxuc5bc3FVS?=
 =?us-ascii?Q?HsBYpdDnb5y/yaVDI3qE1ovZDan5YutdTRzUuIA9srXWQy0O+tZ6tgLoV2TB?=
 =?us-ascii?Q?FJM2y5c6xMG9Af7WbZfsReyCH4T7K5LJ81Gvc3Drx12y9PUHDx1IgeBzrGtX?=
 =?us-ascii?Q?PLM/U8jqi2uLpox6TFNRzG9gB6jDOLa/vb/3/arIKI4K+SP5AZCuK2iW7Upu?=
 =?us-ascii?Q?PXyRMxFDQlz1ynCqjDZRbNTc81Ln4H9SLq9QsM9Q+jIrqNZbXiCimkRBuR7k?=
 =?us-ascii?Q?k3c7BoqGs624j9HJh/pHabi2hCZBp8WSdfSEz8HjgZaDds7BqHx/C+P4pcCk?=
 =?us-ascii?Q?sFkYbZM2o78SEeIB2FXtWPGz8xYR8uV9uUJrFcdo1WEpKCp/tpe/w7v2x1gY?=
 =?us-ascii?Q?PxvMbxoBGBH14AyV6oAcd7kp4cSCPKdLrR2IOJVFsT2cD6yY9UwRgh3f5Yfm?=
 =?us-ascii?Q?FgebKkoeNmT2V94qu0gUHFIkSplkbMO3ZntlLUiZz86mxOOcf2KzsWwu4KaV?=
 =?us-ascii?Q?kJ6LOQHHX/RQJ8T4JyxfpUDaQJKknlxyNRbaolZbpZZQUQfPMNN+gjQ5KCSE?=
 =?us-ascii?Q?/loOrvujxNR9yAXMrktXj3NONWAT5HAxxmxd0rmJXXdNpu+jKtZvIUmaN8Hu?=
 =?us-ascii?Q?PQ/8nENWLYKgfg2tKYW8vAd8qY3EPdReTWTOkPHOz0WrLiO1QRPisKTwIeTq?=
 =?us-ascii?Q?z+KCqdFHDLF/CvN9L2E+/WhHesCz3KljT7tgcQiry0izgEEyGSAPgNSCZhXf?=
 =?us-ascii?Q?43i8GKYDE9S7ooBxYMnAiOqobr7iYw+jdiHxGJLzltNyPF9bQyq4z7fCBlKo?=
 =?us-ascii?Q?FegqFWJY2StrTmCpfWA6nr+C6xCHTJPJCf4JWMbGwqvBcYP0fG8cm7H4b4qh?=
 =?us-ascii?Q?C+nvIi6Yf4pWXavcjpTFXp1VfZeR8aOfZ0F8knyntpFN6cv3Z/B0ZsIrB7E2?=
 =?us-ascii?Q?a6jLZ3XZhccfvu5BFF8BiME/Srl6k7y8t/U7gOFi7o7oxDWEXmN0h+kA9T/n?=
 =?us-ascii?Q?NsLqSr2f7GYTIX2SCzZeK0vA8oYYvbYQkVivhP36j4mYtqmotyK0TBpTifWK?=
 =?us-ascii?Q?uCjNkH6yxd7dLUzhhHDeCTOGilrefguFc82XHn3g1jLTOhPYypsmWLo2N/kI?=
 =?us-ascii?Q?A36mVQhx4Ul7ZdOtyhm1E3oxFiV02abTAi9RLgRqjvIImiWgsCcYdAapKhri?=
 =?us-ascii?Q?wFXCiMafJaokLlGhL2ApBN/WIf76yFnshmbcX/Rsdq3kXfjXL1IKap9mXwYw?=
 =?us-ascii?Q?UEUG15M72oyUThYNg+b4545BrSRbst+K93FZ1ka0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08952c40-0759-4070-4a4d-08dce84a0846
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:24.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GA0rVbDuCA1aNBky3E2TzVb9B0jGV+nbrOwaMGln0vOx8luHqA9VOpDHKbMLJNZ7BPFMJ9GhGpqOy9MA3bO/Pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

The EMDIO of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 EMDIO.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../devicetree/bindings/net/fsl,enetc-mdio.yaml   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
index c1dd6aa04321..71f1e32b00dc 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
@@ -20,10 +20,17 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,ee01
-      - const: fsl,enetc-mdio
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,ee01
+          - const: fsl,enetc-mdio
+      - items:
+          - const: pci1131,ee00
+      - items:
+          - enum:
+              - nxp,netc-emdio
+          - const: pci1131,ee00
 
   reg:
     maxItems: 1
-- 
2.34.1


