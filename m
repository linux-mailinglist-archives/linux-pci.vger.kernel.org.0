Return-Path: <linux-pci+bounces-1463-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CD781F154
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D0B4284F06
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65084776E;
	Wed, 27 Dec 2023 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="M/WXM2n0"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0349F68;
	Wed, 27 Dec 2023 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRFnMMQTwBVJkKIEjxq6w2mH1j78MxW7a0hsnPn95QHPATPc2WiEfg2BIiBrstf+pcS+JwK6X1u5pAxsIuJYh7I3sbcUSGUE8u9DSPpKAvh9N1GdSN/VklpEMCOMlizSkUfDR8HoRsUvwNPCzM2t/P6pbBiS3Sr81VapZwZtpSFoAzclHj79o7jtfom7DCcChxaiBwdT28TA2zSbdVp4dcIaOo/geu2MAY1tvoy+Wu2gPvgIg8SeflS8QLMxtJUF6oZYoH654TIF00HZu2xQnPqNWTQI5PDapQ6TYw9UeXHzWexFn5vWaG9xWwG7WlEhDDAT3JCmRK+6wTsy9M8Fig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbWvqYteYvr1zWHZKqAAJdl2+jva0a7FHdVtrlJj7y8=;
 b=cJyJQgyfHSODFGnjHr9Eu0U1Lw6rbNZUYJFsX4fzp/bG/3wVjmI2VHefRu87ZfYN0pRkQQHUUz+MrN5huCwUU1A0bIx3H6UbzZQSt2MaFzsK8Fy9Bf3Z0dB5gi5jOYkbYFiv7UxMPsUV5MyofrT8ckkjV0QPuZceR/rSzfiTr5rrETGPt0nE7rKoQ3OyRiZowGiEdXXgN48nfw5pys82iZJ+1bcryrTjV2guCxERjHXIS/HFDMWgeBGlszQz16e68P75ewOJxCUIoQr6z0VjKjVq2dy1aZwIBLDYEnNEyW4FDMAl6X22bJbpOyY+uUy5rmz3n9MmyzYXVWRW/rjT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbWvqYteYvr1zWHZKqAAJdl2+jva0a7FHdVtrlJj7y8=;
 b=M/WXM2n0NHXDsxTLeqZVsODyaMbmW76ymg2ahzncyP7YnIl5o0jju3xPY+RAjH59bhJDVsWExlXduBLp+G2oiy4rz3S9y1UbVcNgnPlSObD7wSVWEjMcVg87vZHHwiX0O8mSwyvzpSf3Uc8aAZtL9SuDOvk4q2LJ0MQ2uIHuwWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:48 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.Li@nxp.com,
	bhelgaas@google.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	festevam@gmail.com,
	helgaas@kernel.org,
	hongxing.zhu@nxp.com,
	imx@lists.linux.dev,
	kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v7 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Wed, 27 Dec 2023 13:27:22 -0500
Message-Id: <20231227182727.1747435-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231227182727.1747435-1-Frank.Li@nxp.com>
References: <20231227182727.1747435-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a03:505::22) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DU2PR04MB9050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2d6d39-4fa5-4663-a77e-08dc0709aa79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8h95sDOQFsm9H1g5rRZsWQ0hw9GKwO+OYmnOtz9colibmrne/xU7v3p8/Dk0LYt8kIY7QC5gVv8c7T73BWP67x0MRaXXQK+FBSR0aUBtML0EuzbwE0O3K+XkjezFY3xmblAE53vK0X/il3aECLnNqnfqfd8ee/AKtXpeIrLLE53q7PGQsBJxi0OZTMcQOADxSDh6gB1ALIEV0n6aPHDrXJqBXmpNGgHpUyMzKTjfnTrN4nDLuN3NKGlwcKmGVyCJsyYXBTTJK2nfWxs+2NtFXGg7xmHoUUmdLngi8yDJP/YQ1nFEESRPbJ3B6x8wMHnWpBdut48KfBRODTpzKKmmfTqHE5JjwYhV2YXN0s8O6Md3rsDLrHHx29OVtMLMEZvEgprybdll0Lnh6EDccWCo5IpEwF6fdff/xtY9aOLwPX0cAutHDwoZTmhnpaHqEKn178WZLb9d940clIR7tW7jdiW8djAloBPzp6jMSKN+yS1u87jpf5USHObZ6X4VvQxiyIIQ7rz5fjf7P6JBqMJEnkRT2Z9lQR0hkwulndEXee/7zUlDnWaO6OdM2G7tg2a4MmZTRdttG+YWQNtEMUAx0v1K0hKP30SedrUj8PMBVGYuxeaU0YpxPQamapVFQSj10da6r5SCGVJ/KpikxxM4cA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eEj0Ka0i6EDImFpi1t/1VDKqmgYFKtTEwuzEYcTryoLaC+Sal3A7w5i8pNU9?=
 =?us-ascii?Q?dsnasy2PUcKbUopuHWemnxYDHblmeSILtEQkdHqvlAcvuCSMkac6ZmP6vGx4?=
 =?us-ascii?Q?7svgVazqTszKgL7QF1BIc3GlG0Bu+PzbVWH8ihhKtqzZbuZLnAPuzaCr2+3h?=
 =?us-ascii?Q?qJPVCrmlsn294zF3cJSxlalQRAY43Gpt+3nfCFYUF8ePVYKCrWe9KRkOxMhI?=
 =?us-ascii?Q?NercohRaRKKI6mTi+gBgN5BVroflk7fCOmVRNtJrEGycEscIOMaubG/A/6be?=
 =?us-ascii?Q?ULRraPkaEWlGqCfV5mKXOB/nZ1Z7HGu1w00Fi1cTzWsnNYJUCZm1kdBzwx33?=
 =?us-ascii?Q?q7/KWTeGqRvHS+Ohf7e711x3jD/u0oFTzB6NYee0wABqjwDSwcxOj7NHmTjC?=
 =?us-ascii?Q?C41WIksDee+QBGfiKz3H4trzWwIs2KzAuRjR0tvY0Wb0hf7lmAvMiQLVw8Pb?=
 =?us-ascii?Q?Ng5a2gJOlHIGvysDlNs63tizKJiQZOm5L7DxsAQuvOOReV+pSHJJrI9zQWJ2?=
 =?us-ascii?Q?WM0Q3sTvgie9eGgDreyIqi2GggiDLvRaZMkTdE9khYzNz4MbCwrHFlSTsjmK?=
 =?us-ascii?Q?2ymfcC62ZEdb50JS+q7vnc6z2W25jjAxvTZFe00bMtNKm9xYdfOzqciMAvOm?=
 =?us-ascii?Q?raP/1u0DukN/KessMEKeBhtYmqtuZQSKW5daNQNa5c790ftnNdpPC2VGbmxg?=
 =?us-ascii?Q?qfGDR+GZXP+idQuA39IWgLWFhEYz/Nk+uhpYaJevBs5ek00b3BwxgNaL4CFf?=
 =?us-ascii?Q?XUowBmMRBlIDacIzceVc1lSc+tBkrEWRq2VJh8jqYSPRbP7ySDyIt/2yk3ul?=
 =?us-ascii?Q?bwtNgJ0Fjdpa69FVA05ittgVE392p779+1XKkudQYY1qE1TB9/DKrv9fI9FL?=
 =?us-ascii?Q?XqvnKNUeEQBNVA6gwfdDGzReNBKUXeSeFFVOpo4CHgKCe8nQbsgKS1MWrhFx?=
 =?us-ascii?Q?HvRGA1tp4gkMaGnY/ndzlgoFv24XMarr8EzpZ1qcona8yWRU/8bHukDSReAw?=
 =?us-ascii?Q?MzWxiuVggy4V29aWThhe+pE6NYaKdWNCTQ57JzPMrIt0+X8l5ejrS3nIFsFk?=
 =?us-ascii?Q?vV7WLIevOMdeXt2/8dn/d7Ha6b4CZDtEduwvMp9qoE+GIztSKxxBkVHPVmEv?=
 =?us-ascii?Q?3GmGNDDgPLIxnpLm7zZygsEq5iaQqgZbR0ESCd4gwhkaoR0zF+veB/rcYS2C?=
 =?us-ascii?Q?cCh6FrONOTUpmhqR0YuJV3s4s6SVxGZwqJD5wbFbPQ4S6om6PZw4hx4NXbpr?=
 =?us-ascii?Q?bSPYx4L70VPL2cM/4TGmjzfJRX6wA+/gbqULU9eWztkfz3k6+hBx4VQCyyd6?=
 =?us-ascii?Q?kRgxl+/qv/ivzoN79DkdHnmLH18BD81rQze+JhYSrTuW+oXJd5AhicQcYfK0?=
 =?us-ascii?Q?liJMhX9GANLHKliahhLGGz9cVSBcnmhLO1NhVx7klIeNtc11VRy+UaVqUj3X?=
 =?us-ascii?Q?HCB3ZygY0flvTHvkTEpQOMcWgkaO7nr3wDESXaXkzA/iti3A5+5OSqEM7kkQ?=
 =?us-ascii?Q?GxrrsC/ahArkK+ZLy2CjOJOJI3J3P5UBqXasunUFg0Csah18xxrLp/dYtLrF?=
 =?us-ascii?Q?D+Cy2tMUgjKvCexJ5TY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2d6d39-4fa5-4663-a77e-08dc0709aa79
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:47.7697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JEfqonJivWpiS517OXcF3KvLu0lZMHfctlT1NnPW/N764nsAhjruqap+dPvK6Vb7jGrnEgK1mlw4cPfLiWEUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v6 to v7
    - Added my sign off
    
    Change from v5 to v6
    - move atu and app after config
    
    Change from v2 to v3
    - Remove krzy's ACK tag
    - Add condition check for imx95, which required more reg-names then old
    platform, so need Krzy review again,
    
    Change from v1 to v2
    - add Krzy's ACK tag

 .../bindings/pci/fsl,imx6q-pcie-common.yaml   |  1 +
 .../bindings/pci/fsl,imx6q-pcie.yaml          | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index a284a27c5e873..1b63089ff0aee 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -207,6 +207,7 @@ allOf:
                 - fsl,imx6sx-pcie
                 - fsl,imx6q-pcie
                 - fsl,imx6qp-pcie
+                - fsl,imx95-pcie
                 - fsl,imx6sx-pcie-ep
                 - fsl,imx6q-pcie-ep
                 - fsl,imx6qp-pcie-ep
diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
index eeca6b7b540f9..8b8d77b1154b5 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
@@ -29,6 +29,7 @@ properties:
       - fsl,imx8mq-pcie
       - fsl,imx8mm-pcie
       - fsl,imx8mp-pcie
+      - fsl,imx95-pcie
 
   clocks:
     minItems: 3
@@ -100,6 +101,23 @@ allOf:
             - const: dbi
             - const: config
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - fsl,imx95-pcie
+    then:
+      properties:
+        reg:
+          minItems: 4
+          maxItems: 4
+        reg-names:
+          items:
+            - const: dbi
+            - const: config
+            - const: atu
+            - const: app
+
   - if:
       properties:
         compatible:
@@ -121,6 +139,7 @@ allOf:
         compatible:
           enum:
             - fsl,imx8mq-pcie
+            - fsl,imx95-pcie
     then:
       properties:
         clocks:
-- 
2.34.1


