Return-Path: <linux-pci+bounces-9546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9E091EABE
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 00:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A3CBB20AB5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 22:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD5C17BBB;
	Mon,  1 Jul 2024 22:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s5/HrNfY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2062.outbound.protection.outlook.com [40.107.20.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44025482C8;
	Mon,  1 Jul 2024 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872195; cv=fail; b=JE2OmubtHrTHme+bwIypeQ0lCJ5Bw7gMkwOOk8VscCGupUqcB/PUGwwsRrrYCH7LoTBcJbqANM8bkdxDBdEiEzP9CkvIFczuG3Q1qYXhXsS7fJTFHFAJM7vOE3Ffd3UhvhBzdTFo8M9dHZEtRN5Somhqve8/zYP+5AdcNl1vlm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872195; c=relaxed/simple;
	bh=6iNnABJeqKGxVh+ehGJ32eqOw92Z9aT7VNfxWU7vKZU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ZwHRziI44E+aY7n7RxpEhfnKL+uBnCDf06SDIgQB9EZt74LSTDp23hsDwdNqkfYKwXOwhQq/VjG2eAkpBryPQ0/E443x8+DHdlwGxFNWYxUHDf24soPlysssVPRURZmt36ioKlA+vulqGELRgj4GGXgiwCn4yV8aCuEx75pQmhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s5/HrNfY; arc=fail smtp.client-ip=40.107.20.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQjKmRbrE1FwkjL3rw7uu8pvMcYdioiWq5z7DbiNIP6goB7yXujfmITtk2mG8O6WbrVMTmCBvHhv8BdSmgL3PbHs77y69h4HY41OYuM38K3aSZiDtzXwUgFX3SJDIzNoUU9sqXor9G6NX5UVYuqJesz7XVAagkqaOEgsAjTAHDkTNakdo3cY2/usCGL1RdYbe/EKSoogVJQYXfbDkq4otBHItSj+6LJEZakbVcXpPxQ5SFBCp79o0OVvl3TgmBry72DcoRv2Kcg6AEUO1UpTIZ7ZtYPj5+02ejcQk1E/6QDxRo7n/ivtmkvb4T+mW+owmUfct4SqV48QN4CM23yNVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsPXErIhw4lFU9B2eU5Y+lQhJz8/uQmy/mIG40HbQtQ=;
 b=EKYJz4sxsE+ozdZj1UruQ3WnN5PA40nOZcBTBpI8OE8xKlGn49OFR7VB1PolbW5j+v/JnkzAoBunVg2rO7MRA847zvCRodQW37aRlIS3Fa0Io3htVoI2reNuFP2fvI/j9AKLvg5arNNH/mUMndvINc7k4D/1uLywXVh1x5ZRufr0HBNWxnF96nCYjsJoSw/U68E6i3e1yigP2NITB+f/Crj9D3MSzgTOdp2B7XPOqdBoJINLUE+YFcFs9GGfCh7c7TPgOK2dV6ImpkoHZTT63FDGD+uReoWjJN7fY/0T1IpGHD4DwovXVX9JHJo5Pj3f23ew2cDbo/4qh/RHTt4KMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsPXErIhw4lFU9B2eU5Y+lQhJz8/uQmy/mIG40HbQtQ=;
 b=s5/HrNfYEQ/hXfGSRpeQnUbeTY+SJ2JUSzKIzIwQi8KHceg6uQCLDRXMaASWzz9sVxrUBoGmSjmriR/2Te36+Sn34VzrJT/DYRDo9DTAyBgf/LClwq2EhsZ9KTtiXjAcG8xRWRSmifmrjAEb7+Jv7nk+iDNWpuHgOkISil/DuR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10360.eurprd04.prod.outlook.com (2603:10a6:102:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.33; Mon, 1 Jul
 2024 22:16:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 22:16:29 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v3 1/1] dt-bindings: PCI: layerscape-pci: Fix property 'fsl,pcie-scfg' type
Date: Mon,  1 Jul 2024 18:16:12 -0400
Message-Id: <20240701221612.2112668-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10360:EE_
X-MS-Office365-Filtering-Correlation-Id: f85e42a0-471e-4989-3447-08dc9a1b7499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aeY15sUt/kNz/cDWR4iW/54MrjSe/9HhHZIazb+7NH0ndQBks7bRCuVDLk3D?=
 =?us-ascii?Q?q/HtnLS9Q7Y0imX7FesQxhhM7yzNgPxSTUpYMmnZq4wazUcjFvsfxy9buAXx?=
 =?us-ascii?Q?hZD/w8m4Vb8FElDAKxesbfZ9C9ert1M5NeEoDXoLuRQBoM98GwTEjZy2ePIZ?=
 =?us-ascii?Q?LfUjhBq0d8Rojhv30GWJm1mlINqv8zV7oHE58Zma9VINnc7N4rp6JP97MDJI?=
 =?us-ascii?Q?bRm3OTUUFjMMjQ+SN2sidyi+a9uKuC7G2KCbDE6p6ONxkpa4A/I/H4Tm4OYn?=
 =?us-ascii?Q?usvU/I4uO6GH8DDtRAMCh3FisEORA5ZW7D9LcnvExn0SXuWdLpkTnFKMRpvm?=
 =?us-ascii?Q?0dTcMIXW4JfmI/JOjPhXewknSTllHF+Oq9+pll1hVGZiWfyxmP1NbIp4HVfT?=
 =?us-ascii?Q?eTPQ42Ay0a1irQbIJYYH1Mp6oTGfHZSDai6vtVs7J8fty/1DP/XE/QiFAUpM?=
 =?us-ascii?Q?OcUjwH3JZzR32CrrEPTWakJ1CflxTWEGGKm9gA41vIeCpQleN0G9j5coTlCa?=
 =?us-ascii?Q?NQtQM0OQVWLs5APS5EL8RMl7jL0mhMBRbljx0Wki4k8wQG4M6e8Fp/+Z+NII?=
 =?us-ascii?Q?F3d6d3BFS5NZtUcbhgxCBME4W2eIvxopvH7uNicwo9sDP4Y+IQ5ghAZ9OUhP?=
 =?us-ascii?Q?gK3cIiqyEWUHNLfBQ+mACG1DKTEo3VcAgVqDD2Im+csR9683fZk+29FpwNbK?=
 =?us-ascii?Q?pHsXFNoxdQUJnEeGqyi+4TxV7mommu8BBXx13Mqc9vIE0ImCQueTFrxI8zF/?=
 =?us-ascii?Q?QawCwHFL58ksIVA9/x6RfPx5fGr+Nr2wFrOdM6pPde5Vc3iGjpUyiWWNmL2y?=
 =?us-ascii?Q?gR5A7ALWB5mGsMqf9zqwB9AFeveDYxhAI25W+Rq+EWxH1HbF/1PIjhllfsTF?=
 =?us-ascii?Q?bhfqXLSEdzQP+J2koUpiHrH8VL9PIkjJGRdYdRQkeKkEX1gUu3MkzgwWFiyN?=
 =?us-ascii?Q?U+HFsQ511qiTKhr1ZE0L1qjERf4rIlOueqhjg/OT2/uY+Y5j+3I3SfPjLmwK?=
 =?us-ascii?Q?q9kyjl5Z/SxdEEAK4GO432zA+zYaEz3SdRHWSJT31n0b4gekCDicW2stTDT4?=
 =?us-ascii?Q?p1EnCU+y2hIDUO6sIk/bvXYPRnLF/EqT3wOtQRyBYlj5bEY0BrtXGdm8h1h9?=
 =?us-ascii?Q?vIizHvQAOgOmoG0QBz8aF8uEUjfkTHJj+fZlbD5fl6WjYDwYuEmdcen8AZu4?=
 =?us-ascii?Q?CGxuXqTuSagHhbiiCIxP0rLFBi1w8qoYJw7mXvaNAaQqAyaoM7PAeQFpUVE1?=
 =?us-ascii?Q?o5BigXtUs8Fkyx9uk3my3h/sExh5F5I6v/nN/AkPJyp7hs+lr7xpzG/Ybxn8?=
 =?us-ascii?Q?QMrsJ+1Apyaj5AD4rF7sokvz8oKkKfaLWT7bQanTRKbtW+muWrRaLCNDZ1oe?=
 =?us-ascii?Q?X5+4kEs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AF4W5p2CQ5f6AiSgc5bbUTJyIgwlQWU9k/EW3ab3iCgUG3FFbAmLZz257RyL?=
 =?us-ascii?Q?FRooYz/CDImXqGvEk+1KnYJw1G6KJ9TPyNiaZAneM6hdIlHtydvdniVQX1aY?=
 =?us-ascii?Q?Ff4hUEWN7d3Ldbd3TX9dRxMDM0/KbnwFpS56+bEoEISIbz1tXn5Q/wNlUEKj?=
 =?us-ascii?Q?cGB4sgC6ViFR5lbIbUnhpey5X4hogAQrA0YkjWF3QJ8mStTE9BQATdUY87h7?=
 =?us-ascii?Q?UgQp0moCQ3Y5C+92ee3sqcoMQtRldpG35nvwb1ZKGwsiPuG6HZIkcCj5wJw3?=
 =?us-ascii?Q?Nx+wNGZ3zKFWhxsX+rIZaexNIw0Tx4f+McVshKU+oK0Lpvb3AjxVX+1E0SAh?=
 =?us-ascii?Q?8kD656ktaO4KbldBKRhexqRyxcOuXqgIj5PnMVGIM0yTAaJFLxxoAIvzPjLL?=
 =?us-ascii?Q?l64LQGoOWqsu1SF1OF4GF75oFgbmuaz5R7Y/P5zRTcclyyRKyNEM5jb7FBGX?=
 =?us-ascii?Q?Rymw5ZHUXcDzLcF9CvRCVO5eTlRrLgq1B16VPi420lf1c1W1w7+/bhKZWuq7?=
 =?us-ascii?Q?7wYJb4VhRG7ijuGSyFA809ZjTVPE+Xm3v5kwJo17shX/0s+ygP3wfNHpOJYb?=
 =?us-ascii?Q?VfbI/EULM43C61dUaciAE1fdPG/t+wpcSL69SnMomW6Mba/m3yVnAtyWPEyf?=
 =?us-ascii?Q?jiDrVXd225QhvCohJmgcI6/aTGiKP5a/xy0teyC+GXY29AUaaKDi8mwT138G?=
 =?us-ascii?Q?47UTHQVG9tW495gJRjJMPdGlQMx4QMOX4liY3vwPokIIGGLytRPhfcQpBHha?=
 =?us-ascii?Q?W35w7DKEMdBUy8542hrRrtTqylD7hxumWrb66oWJoDIQ75sNGgSpNal0HSTZ?=
 =?us-ascii?Q?c+lq9dixuNZaY7/0FkVu0kke1EGdh7PsOTq8qwGELawmIeCaRAVmwz/8cQap?=
 =?us-ascii?Q?pJ/Wy+cQHDHSkbaJh6/VRHOoEon2BDNXPYF04c/JTwh3Jin2oD/23jEWI67x?=
 =?us-ascii?Q?uCk5i4E0TdRs367HCDpkyS18e6LHHU5UXhvpf0rQtjH9cgIjUeJwIFnail9I?=
 =?us-ascii?Q?eVZjeZvg9XoOdnLrU0HNyFW2W0WqKCfZC9J9YhA0mzrEpylzls0uk7MiWv9Z?=
 =?us-ascii?Q?AwvUWGXhsG5onypRsb856T9GSuGxg0gTep95ht/lBiJQTAp5gzMMX/gWudnT?=
 =?us-ascii?Q?yyMFJD2A28QYsKXHuKLONnOv4iszjWF4hf0gckyW062nYhnzD44C8F7coSrm?=
 =?us-ascii?Q?cPvBF7CevhX0W6Vr7kvqlTQlQxRrNWHIk4KUr9FPScmCa1olmiReNf46cGYT?=
 =?us-ascii?Q?EnvKtLd5AFERISYIRUmZ65Ay+bvRfTfmNc7AEQ4KZtYCuQXDBF/2TUwhmo8x?=
 =?us-ascii?Q?2gSq3VVAF+iizBK9ZhsqkVrJLnITb9v05nuK9k2F+e+CdX3RRuMLBRa4j/de?=
 =?us-ascii?Q?bypGFm8QAs9vmeINweNgG1XQoY8lAv+P8uhop4pe/fZaJ2MS3Kk+6fXxDZJ8?=
 =?us-ascii?Q?aT5L152mHeBy8IIDP78Nc61fsCvfymVpPS8GJRK7l4jc/vmnK0fx8k9tNM6A?=
 =?us-ascii?Q?efxAyH0cwYVhXsX0l4uocuIMqOKGVQkOam61UOMsaI7nIiDSDs9v/Dwcb8M1?=
 =?us-ascii?Q?rQiN7ya31Wwb9yiXZ2hyOd69KTt3p1qZsjgz3z+T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85e42a0-471e-4989-3447-08dc9a1b7499
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 22:16:29.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmR4+yS9HnnQiGEEmOQnCz2L0Sny+KO892b3Vkna/0jKcABvac3nGlB33HFWsdF+pjDxFYZ6vfKaI8y9Qmgj3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10360

fsl,pcie-scfg actually need an argument when there are more than one PCIe
instances. Change it to phandle-array and use items to describe each field
means.

Fix below warning.

arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dtb: pcie@3400000: fsl,pcie-scfg:0: [22, 0] is too long
        from schema $id: http://devicetree.org/schemas/pci/fsl,layerscape-pcie.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v2 to v3
- remove minItems because all dts use one argument.
Change from v1 to v2
- update commit message.
---
 .../devicetree/bindings/pci/fsl,layerscape-pcie.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
index 793986c5af7ff..741b96defcc95 100644
--- a/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,layerscape-pcie.yaml
@@ -43,10 +43,15 @@ properties:
       - const: config
 
   fsl,pcie-scfg:
-    $ref: /schemas/types.yaml#/definitions/phandle
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A phandle to the SCFG device node. The second entry is the
       physical PCIe controller index starting from '0'. This is used to get
       SCFG PEXN registers.
+    items:
+      items:
+        - description: A phandle to the SCFG device node
+        - description: PCIe controller index starting from '0'
+    maxItems: 1
 
   big-endian:
     $ref: /schemas/types.yaml#/definitions/flag
-- 
2.34.1


