Return-Path: <linux-pci+bounces-3780-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4285C11B
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8293281EA0
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0964C7690F;
	Tue, 20 Feb 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="is9UJrRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2048.outbound.protection.outlook.com [40.107.14.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195A7868A;
	Tue, 20 Feb 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446030; cv=fail; b=crNGsd8JHF+TNMEnZ33Ghcwiq0rm67A1OLtCSzjeA4SlxB51+H1088r5r3erEWQZdeUS22lWVWN+s5oYR22XBeXJmM0x/UcgTE99ypKdJQn2VRHY9EhxMFM1us3PetqpDuhBOW0qfzXBBIfWN2+wIHQjLGFTKJXc/PN8ZGcKRwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446030; c=relaxed/simple;
	bh=v1qDlSDFc0Q9C33fJ+0C9n0DYjxe83RrxbWMbOeJ2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UHvWIOSJjPeoiC0QzJvMLXyOHaSJR8Ydhsl6O5voJpuy0KwP5SwZApKSCi8+qV3CE/mzP6nZIpTC3ofEZ1FA7O1QiQmXssLXMas1TJohszg1tvzjNTs/PI1L7MlwzbMLHEM27CO5pOSqINL5T+/LkNFAeXqKqqI4eXMDX449d2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=is9UJrRt; arc=fail smtp.client-ip=40.107.14.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVXLeudPaBJtka/abOAhiy5WvFgMa2867vANtoMHDO3PedKNiih5Q/ydUuAGEDl/4i8QKff1n+Kt5pvD9vRF9OGVAFsdFWIbpcbNQDqi+cJvZujcACKwSYiBym7/PRwdhcLUv2ZVd4FTR3nYnXJS1nK9HVyJXO13mrg6WKe+Mw/WFRqDpuaXBQ4hRNfyCefLFxeT+Ymt+qIR5dejTm9jF2h9jc+5SxfO9HK7QDssQzgoHL+GMbbjGStDSxicmpeaXhEGRUmh9WiNBMMPv33MkQdIxNaG12zWXrEGGo9IGuw4O4ymcSKJaO3zAN8k4PYLKewILe3kfgOeVE5hDLN4Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5vVO7HnDeTAwyeVm6+Wd2tuSRM6SgTSkBrfq99jSQY=;
 b=iCuWQJLEEizs/0GzCl/nFodF2li5wHdtAryxmtBuiUHOFixiffC5XBD+NjouRgldv2zwdWhdld/uuIfYY/XNoUwjza7JSsIyycHe8O21C+Hey4D3CmbB1QDPQn9z2EmoHwaaY15vZh0nhcFHORLF2/+fs/IMLwiPP2OWfvqdPkYsuh4xweIavlMzDmVIBCSyuXy5tbqw5xWll0b8kqirx4rZOb69lXQ1+JmZoxJq9ibg+xknjToPUxL/HG67r8GoVc9TSKk3uNYXxxNTdg4zKCSbMbNBvE5RfEU9MlU2dM3NHrvwMoFWn7xyf5eLVOTt1Jnqc22KurOBqNOy02Qrbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5vVO7HnDeTAwyeVm6+Wd2tuSRM6SgTSkBrfq99jSQY=;
 b=is9UJrRt5btk0aLPhn0SGP2nlJqje745IvTpqfVS5p+/9S+Vh9FQS0dubfnDiNRiaosHhOoFnS8Tx//J/8mfDQbCXIgQZUN/Bt6r5ziulnJjDdsumG9TE3QsaU/a9eC6hl2kewCnP3ympQEacVzUO0WmPWTzRtYSO/BSFv0OM5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:20:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: lpieralisi@kernel.org
Cc: Frank.li@nxp.com,
	bhelgaas@google.com,
	cassel@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v11 08/14] dt-bindings: imx6q-pcie: Restruct reg and reg-name
Date: Tue, 20 Feb 2024 11:19:18 -0500
Message-Id: <20240220161924.3871774-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220161924.3871774-1-Frank.Li@nxp.com>
References: <20240220161924.3871774-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0268.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8682:EE_
X-MS-Office365-Filtering-Correlation-Id: 2260f168-8316-495b-b527-08dc322fd8a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sABSVqnQQrolHUWFwZYTBp87qJFNukwarQCulcK2DO+emXwwrhdI8n3evkyY40f02I8EjGjFwBuJXRrFFsBVgziJAcSLhdBqDaWo1jXE6CWrp3pCu/qwwGNRK6J33hPXyNrzDKrX3GKTrNj5N2mGdR5er2E1m4iEE85MnOLDurqy/5ytNFojJh0wqngVMjOgVLjXLWhDHnkYLro8Ax8Le12RDrldcfgrOwv0/rjnwpgr/LUJnLt+2RDpZDthOduMW9vYn5PEwRhpjQSlshcT8OFqenU3mHZ7dBAQ2mWtCoyZG34bKf+SvUFGoSBlhZfpjrBtIu2X2e0iPQGLmHRBBc99RROkT1+S5n5iAs5wr1ugO+VeXjsOSJKesMOap3EnpHEiHonYHX0x0YJile3mDfMDpij4h5wCrzaBzA0OkIgCM+Dw6prmxSbwPbFGMh8ru8V94KJt/mCTRsOVLZiObSFxv3aha7NVESLnMflmOexY5df76zfuYlrg5UngqzTL0TTT1C3YOPKmBJkZPKDlweHEJ8kSdpjN5X/dbdeQr6E2QapMrYAhOtrrpzl072y6Uvuudk/6CayMrZ+c4jK4x1re3mUTRxXDRlxKog/FOeLuSeTX/vH2U3Aj8+HvzCzv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L5osfhO1UvA5PQUFXCbRtf3bbN7ubCttHt1N/6U4WHCE5Igzl8GHwLsuxNez?=
 =?us-ascii?Q?HvXhXfSnvimsnvQZHLo+pRk67oSf0DmWMCpB1/q4ll6gIJwbMZMSj64+mijd?=
 =?us-ascii?Q?zbVBd/E+NxK+M9LppTtseHR/PGBuW4eP7k+2iNyZjXuC0y/HFSzaw1ajTmt2?=
 =?us-ascii?Q?NlNhG3Tct0All2VIiek+C93LOaTlTKhunSKoR6EFH666YVxoWup5MlPSTLEo?=
 =?us-ascii?Q?igtPNlDliPsPELTgenDH34dPDzA+m5DYR34bPkXHJ0ehDxJrbTK+eNqwzsEE?=
 =?us-ascii?Q?uBTXf4gvgObAMCSYrN7vAGxU6nPtqj4NZkBEdJFC9j2tlJN74ikJFUqVovcY?=
 =?us-ascii?Q?ELWaqRehzWI2Q2er0VBWT9aJjU2Wh6juJhoON2OW8EUBbmHZAKZWAhxt9UJT?=
 =?us-ascii?Q?ackbWGqfMU4NqmYNLcu/TvI2kwNaKit0+ZLTplkPpGUJKKhPYttOmCyvSV8r?=
 =?us-ascii?Q?Xjs91WBNxWjffJ0m8dMcFf9rMp+j3GDBtLuOZJPBRaem0G5Nb9iVEfObKdON?=
 =?us-ascii?Q?ch1aTOy3c9p3L6kDh8mZvkmvNXK5aR1RC0dDayDjOTb44sDa8Gi6joUpeHmv?=
 =?us-ascii?Q?GXdfrnlLbmFPEmBGlJsTzGDpDnkVVhJbnRycBCMXx02wdbnBKS2YK60QxC1b?=
 =?us-ascii?Q?HGWC1vF1z88iMr1oDVOCoVYKpDDzLYVZd7YD8f9b1xeObnXn16uOxoSCGOJv?=
 =?us-ascii?Q?ZL0jvf0Bc6z+PotGYUQU7fs28fmR7YuP/kb7g9+gX92+equS+pEXxOS3WuTL?=
 =?us-ascii?Q?CkPT3yL4wTN3/6FcP7w8yb3+oobfyQ56CP7D5DXArYNzE8fbG8V8sx5I+sqn?=
 =?us-ascii?Q?UyKcul0xBbgB0JfGUhZor4OBR7swnEERzQdmVl0gRy7UmnrcT26QSYUYZ8l6?=
 =?us-ascii?Q?PRq96kFAvs9dWrExrOHu+J1WBPy2RlFHWnu8mvUT3ic5PdIQRXDxeLZeGD8P?=
 =?us-ascii?Q?rKZOmeQXmsoXdOcXSg6z06VcQL8HTMzXOZwcD3k5LJkd/VUvEZRgTHSqwKjp?=
 =?us-ascii?Q?EJ05cKQwhBDz8Ydzqjb3uHBTE2vFRVu31kV8YlRP0yLwVzlARepTzHuBWjBI?=
 =?us-ascii?Q?Oa/qZxxnMAnNGHEJbfjnQpbarRvLfHH/czP83EKnLkMld1fuHkRLdd626Dzo?=
 =?us-ascii?Q?6uPpBWF4CBSECzE5T01MYIu0l7sMj2EP/ciU95cD2A2vXVaZ4LFTWAExsIU5?=
 =?us-ascii?Q?wk1ZlSpAgdPn79Dqesi2HeQcaeYMzZb4dADUJel3KxaU3h0WF904I63YOQE3?=
 =?us-ascii?Q?B/c0UDLfkbuHSJaBSJZY3gCcoxULFZj5lZoVgxSsSxD2oXhuOi6jFa98qMus?=
 =?us-ascii?Q?cu+NLdRo7suZjEkG+dNbqabTaGpLM7HyrWg8QKGReLc5EJT5YY50hO2/ZP7d?=
 =?us-ascii?Q?Kiv9qVN2sicnsQV8h2NBZvLmqgXsJtKb5X1vLDOsWTKNzaufbTDZShDAVJRP?=
 =?us-ascii?Q?dJexUkA4RZxzPkFiGgj7lDkO4mpL++F1mtHgL7Fk8d7i5LbfCd73uGoL0hxn?=
 =?us-ascii?Q?7eVDeD4h418drMrECQNDAi6prV5MPRBJYjw4dvy2GqmeDzHRzYu4ZqQHoBp1?=
 =?us-ascii?Q?ENA0TH4DAwkLI584EBtnJBy5hu9R5Stk1OwEn+Wx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2260f168-8316-495b-b527-08dc322fd8a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:26.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivNYQ4UxT/Iy1Sz7gk6MyprHzBT8bYNYaqO1j6Iu5xPdYgKAdMPr8tISWYLBBnq2uVqXr/VAW5kJEPthXqaRJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Add 'if' check for existed compatible string to restrict reg and reg-names.
This prepare to add new compatible string with difference reg-names sets.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - Add Manivannan Sadhasivam's ACK tag
    Change from v6 to v7
    - add Krzysztof's review tag
    Change from v5 to v6
    - Add if check for existed compatible string
    Change from v4 to v5
    - add Rob's Acked
    Change from v1 to v4:
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie.yaml          | 30 ++++++++++++-------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index 81bbb8728f0f9..eeca6b7b540f9 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -30,16 +30,6 @@ properties:
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
 
-  reg:
-    items:
-      - description: Data Bus Interface (DBI) registers.
-      - description: PCIe configuration space region.
-
-  reg-names:
-    items:
-      - const: dbi
-      - const: config
-
   clocks:
     minItems: 3
     items:
@@ -90,6 +80,26 @@ required:
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
   - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx6q-pcie
+            - fsl,imx6sx-pcie
+            - fsl,imx6qp-pcie
+            - fsl,imx7d-pcie
+            - fsl,imx8mq-pcie
+            - fsl,imx8mm-pcie
+            - fsl,imx8mp-pcie
+    then:
+      properties:
+        reg:
+          maxItems: 2
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+
   - if:
       properties:
         compatible:
-- 
2.34.1


