Return-Path: <linux-pci+bounces-5552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEA89570A
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A05B226F2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D4135A6E;
	Tue,  2 Apr 2024 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dFdVmjKh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2097.outbound.protection.outlook.com [40.107.6.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59012A14D;
	Tue,  2 Apr 2024 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068492; cv=fail; b=ukFJnmgjxbbXZlf8oBZ99jJksynYnsySfl3nvZ7YXAXxomAox44fd6POp83T550Z2P2ot322Ky/A3s57p24ZQnO6oU0EdiAqN3ZXTHxZILkYQIcVxzUq0G2X7N2aGvE74YE67wXpdHFVPD5/o7U1lb4PzTtvQK7Dw0F6f9hmUZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068492; c=relaxed/simple;
	bh=uYxRRhEdO8Op6DTFc/KsdWsD3YBT7Dqg7jlzrmnm0K4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Ub+/9m+dKygGzrqJoD7iLamCv+9OGK5MzCoOgaCS5Xr48ZOmyKN1Ny6xHEDDuDqZ1As4XZg/s8TVbxpGJmaIv2WSp8tei0GT0IVKnq8aj5CkrrLP5JSeEMHZWv+CwL0wwPHPDhvqx+w+AJOZQLOJBugms5XbBg9cJzLCB4KK3V0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dFdVmjKh; arc=fail smtp.client-ip=40.107.6.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdkPQdLwnuoLN1otNk4qqCXyF9aMrZZakilmP5SpAXGSJ1tzBeZKtO44Zg28uWTQ5CR2yu3lxgXw+vkL/clUhRzKlyhsZIhBRjsSpdb8kopFyuGtTfIIvfHV99Ji5eybpPr87DWn0yP7hHm1O6QlnjYqRkWXVtHUe6h6zVJJbPGPIhEq43NA/WCjNN11F23kw1zLNWO+c01xyM8amoN+rUTggJtv0YQfAPOcIlsygE5VQw8EJzFIXnQkWiLgNVA9Gw8JkH8D8Gc5M8nZkdZqNi7h3UarEHAGgdxbTSHx0U1Dt9oP3vcIUtWTlFHbapm6Whus+JRXc7Ip9hU9KiLY2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwqfHfZPUpoS+JPj5+NsOWVWn3HmciXazJhQ3qM/feU=;
 b=WDTASvxA0hhxhQ6ptRUOzHw7e2uZ61KuLJK+Q8B11M+eg0SmZFZCWehb7ppKkhjdmFCDrFv8DkG4vwy2Vrum0ODO6UAYVXneEEqQ83zxj19Hiy9T8O1Xu+EyAzcIiTSHfUejm3SCf6Grve4isByipUtYe+Y06DJfbFDkFY/3eeWCbDoAuCuCqsC2uJTkFqIwXytPj9yT9aqvEpIHatibGLvfoIiEQzr5Ftcvj/MOgCQz8z3U9hRsvILKp8e6+K9/9nXAbVH4CV4Dq7PE+Dkj58Z3posvWcTZtYd5zLDKskSgRdIVY1XFYAqOaJl6dtA/CrTCVExrE+yu+4CRR/6ipQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwqfHfZPUpoS+JPj5+NsOWVWn3HmciXazJhQ3qM/feU=;
 b=dFdVmjKhhWoXsgM36EsihRX4dFyHJ/zYaZou/JLqcIZ30DViLKbIZstUxo5xcqyspW+NCeMkbSGAQFwwJQbyLYkx+n6380FFFcQXSHxszk0iuQ9yaNFr3Nu9kYjRV6pLRzOkOyrKUWkJmRrm1pd/bIN+P8p41eNU7+5Whcw8EWM=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8926.eurprd04.prod.outlook.com (2603:10a6:102:20d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:48 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:48 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:46 -0400
Subject: [PATCH v3 10/11] dt-bindings: imx6q-pcie: Add i.MX8Q pcie
 compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-10-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=2236;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=hR2tYSzPSPzPh+Bvg1NYZZOz6QTugoJC4tZMVcPoyCA=;
 b=0wsWG4wPXSe6Cz6ulkGzvOVMvrb/JY2K3VAXL7nNEQ1CngdiX55mCJCOj4FfZQpjOv4z5rMfI
 YVWPFbQIlVnCo6/yHzoAEvG463V8mRFijyf8OKm3hiNfqzo5Xk361ME
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8926:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mcOQHkSt7QO8KsRPuWL+BDjauxh1C8P9svQIxWUzPVRQvxa2IfslQK5ukO8dJ3gvbGkAQxWexCIWrvgsdKb4H3dnaLA3CRoA4dJdGQYyYqejdu4SlEwKQ73sIZ7aWyy76KrGEX56wMhksNiSq2mdOHnFc3BU42QJTRlnakWmWrI05AA2uftH/98v4ogUkJF9jEgqVNcV61vRWj8UHeVMGrR268wrxDLU9HOL59PZtwgBCYxGky6WsYMa+BA5bbjn5aWlDWQwve+R6IX2T+QvHN2GYAW8TjxUuhFArene9h2JeLJ5XozF+yhSLYBd77ikC1/gNK+3Uxhn5cpF0dzVmgA3amiYyA8yi3aGmJjnWN1eR59Ayy7zd/oW7adRtXQAwP1v6j5wsBQg1WNsuXKrKKSV9Js22TAagXqTwkAnNuwtFcRj/EvUayR+diGgCmL2+Ji89I1jmivhYTK5tYbt5Zwg99xkTM8C47/c8pdC/DIlrkRhYSH1kcf2Og4BO8S7ZjeEEKA/0mEtNyqH0DGhSsxKrtqeHdLQbF7yR0hCxgCJ1Rs11J6SBYPEsJZfrJwmhZrXZzDnPnYgIxCBjDHzDmFgIXRBcm4ujkjrXNrs3o2DIrmVkNLjjvuSA6UyQZATv/ypfTo7evoWl2mTf7hZ1Rt+DT1uqVZsFURTbNCukpyvsMhEWV+ywORrfxfI/TTwt7UxN57EJIcne5WiSpwK8wDUQzqqCMKujjVXkiQBz4Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUMvQ3lvUE9qS1paYXhvWmxTeWtqWHNUQm9YV1Z4TGcvMVJUVnJoVVFmKzVB?=
 =?utf-8?B?THRwaExsRTBsSUVvb1BtWjVnUnB2d3BwcXZGNVRHNVVWNzhBL0Jqdk1VbUQ4?=
 =?utf-8?B?U0VveVpqV1ZuZ0lhSmxBcU0xdjg0VnNNc0xXc2FsRm1CbGtoczdoL1ZycEZG?=
 =?utf-8?B?RjdBeDNzQldjMis0bUV3YldEenFHRWNQVi80VDhmOVBEZ2huTTRnQXVlbHZr?=
 =?utf-8?B?UFpQN1EvN3hSQ3NFQTF1QkJMd0hudTUyNTlLd0pUdXpzV1ZGTWQyTFV2TlBJ?=
 =?utf-8?B?U2tlamtjSXYxbkZTdXlJLzJueDlGa1AxalJkNDdqcHkxdkVNREtOa0h5M0xR?=
 =?utf-8?B?TTlWdXBiSU4zdW4zcTJZTUFQQUlIMlM5QkhVYzdHQVYzd1J5QWljSmlnelVX?=
 =?utf-8?B?T2Z2Zk9IbkoyTW5ySitvTVJmemlWanpFeW51WHF5OTh1WjhFOU9SVEt0ck81?=
 =?utf-8?B?OWh4SmZibStBcFRsbmV6cERibm1Vbk53Z1pOcG0yY0E2WVJPQndPWWE0dS9y?=
 =?utf-8?B?VEh6aUFHQXllM3V2MFBOdXI2K2dkUXAzVDBabWhKUmw2aVBFa081aXJDY3kv?=
 =?utf-8?B?TlpDQm5ITDl2cGNzbEVUT2pqZC9BNkhtSVZiVFBsUERER1E1dExuQ0xDa0F6?=
 =?utf-8?B?aEh0enVxSkFFelQySkVyRDl3V1dOcWo3NHJpbC9YRG1kN3dTN1lPcmRodi9F?=
 =?utf-8?B?a0dmSHE5UkEyeCtQdWo4c1JJUGpuNERZdFJvbHVaeSt0enBlY29qbUZJSDdF?=
 =?utf-8?B?bk5pOFZtcmtCWW1SUFR0dFhyNklQMEM4WXJqR2M2YUQ1QnJnOWltU2Q3QjVx?=
 =?utf-8?B?OUtWdWFtZGsvRmdQVk9IT2o2VVhaYU90T0N3akhrKzVtd3FIUHhjQWNlazJa?=
 =?utf-8?B?SFNDa1pwZjZITGJkQlhib2ZsTnRrTWNhTlA4M3ZvVkFCN0dQdHFRck4zRlow?=
 =?utf-8?B?bDRJbloyQUlBaHlINDEzeWpRc29VTUw5SG5NY0ExeVdlZUNpTmlhK1d4MG1i?=
 =?utf-8?B?ZDgvQ2VhQ3hvSXRzM3h5dWNZeVgzQ0FLSE55eDVSSTJqTFR1c0FEM3RJMlpK?=
 =?utf-8?B?SnJFcnFDOGxEVmNOeVRKblFoVmZEVTdCaFRQRlJ1cXFGN3YyTFZ4dXFnb0sy?=
 =?utf-8?B?NklaNk02cEdrbUQ0WlhLNWx4MUt4VWg1QndHeVZacHY1d1VqWUJYL1EwbGph?=
 =?utf-8?B?WUFWd2VzbzNYdWVMUThac2x5NjlkSzRPYWRaNXlrU2JSdC9NRThIUS9GTFFz?=
 =?utf-8?B?L3VXTCtVNEY0SHg1Vlg2RkdwSzg0UUdqU1I2YWsyOHErdHRxVlc3R0xvNzRi?=
 =?utf-8?B?UU1JWXlvQVhLY2Y3VVRWVnJMOWtJTGt0ZitOZWZES0dYTXluMmE1b3RaMGxo?=
 =?utf-8?B?TVJJUGV1YUpIQys2T1IvUUZ2Y01JdENCdXZJNjc0Nmc4NzAwcjkzcGNZaC9i?=
 =?utf-8?B?MjlHYkpUM0dOWHRMdkdLWWtzcmFoUEpPZTE0Y3BPV21IZTlrN1hNeEVtMDEz?=
 =?utf-8?B?UUphN1N1blg4MFhBcTRyNU5qZ25EaFd5eUZvdUtpU2g1cHBRaWxKSHZQMGQ3?=
 =?utf-8?B?TTBPdmJSOTBrYnBmWDBxR0hSZUM5aml2NDY4YndNOXorcVpFbzFwd2R3aWN0?=
 =?utf-8?B?T3A2WEJ3YTJUaEZrVW41T21zWGU4TFdXWFR5dVU2NlJwTCtuaW14U2xlMGkv?=
 =?utf-8?B?YzhieG5qQmdVNmVnSkFUalp0NVhNVVJuK1Y1VzU2K1ZNSlY1SFp2RzBEaXA0?=
 =?utf-8?B?QXdTeDhKQ1BnTUoyVlJCYnROdWh4UDdmYzR4SU11U3hrYU5Wck9PQlpxVTBH?=
 =?utf-8?B?eG5mT210MEgvSEpNbVQyNGpjSGdBSnVuY3BDZERVRTg0cnh1RmREN045aHF4?=
 =?utf-8?B?WW5DaVFZVzNVbWxqK2g3ZzRiVlN0TnBIb1pWcGRYNUQzQzVhZmdMcDcvaFVz?=
 =?utf-8?B?ZEZ5R1FwdnJrS0ZRSTVxKzN5cTNTaUtJMUliblZoaElDRDVjTzJTS2FGb3VT?=
 =?utf-8?B?M2xxMU5wWnpVc011RC9wNEJYdjgyMCsvL2NJSENTd2xTaGR2SUwvRzMveTFI?=
 =?utf-8?B?ZWFuV3ZyemFPenFTa1NGazFOeGlOVHpvYmxldkJjWWVlZjR1eGlSQmlERk5t?=
 =?utf-8?Q?/QZ0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91003759-f276-4583-e8a8-08dc53220c48
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:48.1121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Au1UikEpCjxWRFVPZlUw4j50xqjUDvrJ10jx4IwRIF61PBeJlS8jHT4GVoT7/TPCNdULN4DjmYpkPRxHshmF2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8926

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX8Q PCIe "fsl,imx8q-pcie" compatible strings.

Add "fsl,local-address" property for i.MX8Q platforms. fsl,local-address
is address of PCIe module in high speed io (HSIO)subsystem bus fabric. HSIO
bus fabric convert the incoming address base to this local-address. Two
instances of PCI have difference local address.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml |  5 +++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml        | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a8b34f58f8f49..9e767695d6480 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -92,6 +92,11 @@ properties:
     enum: [1, 2, 3, 4]
     default: 1
 
+  fsl,local-address:
+    description: Specify the local address mapped by the HSIO bus fabric
+      for i.MX8QM and i.MX8QXP PCIe module.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
   phys:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 8b8d77b1154b5..b73218933b80a 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,6 +30,7 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
       - fsl,imx95-pcie
+      - fsl,imx8q-pcie
 
   clocks:
     minItems: 3
@@ -184,6 +185,23 @@ allOf:
             - const: pcie_bus
             - const: pcie_aux
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx8q-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: dbi
+            - const: mstr
+            - const: slv
+      required:
+        - fsl,local-address
+
 unevaluatedProperties: false
 
 examples:

-- 
2.34.1


