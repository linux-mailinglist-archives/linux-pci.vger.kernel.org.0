Return-Path: <linux-pci+bounces-1352-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 216D481DBEB
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB3EDB20A92
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232DDD287;
	Sun, 24 Dec 2023 18:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cLnB38u/"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2081.outbound.protection.outlook.com [40.107.22.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AA217738;
	Sun, 24 Dec 2023 18:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGb/XwriG6+Vpi8/hX/3WQN2ZjhdT6Kqyq+DjvAYs6m0lD8RBbhLCL9UdUiZK2FW4IAIIek9se+G+0ln/4m4NtSKgCvdeoZaBsBR2Aa/3uNa8buUfx9Jdr/x7ysnTVSxMycl9fmPtbaHkGYLf62iO2Bzsk5CU6IK0dPE1gGvCxl04Qmp4NmhgZ14wOo69h9guPmtB4xMfwdk3bIqew0GIpExx48j1Ovm2u9QZYxB97Vw2SsMpVFb10iiEYokyWa64z5Gi79lenvvpzejJRK86LjYDBu1qwG77vdU/VQ0VS+qJQVKzBfCk7+AkN5Zk9u5IyrjKAW0ZK2Sd9X/4bj9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9BJ7w54FLLy1r7idavEXnrdY5D9AgX0T+UheGxC4tc=;
 b=lEx5zOjJ5HDl4hkQwWD/AnQVhqJACQNqrIA3wRj7K4S5yJK4sQIJwJ6h4jg6qjCtKD5e+9xYF7ZTSsk/3RZnbpKzLD+MXh5EpU1UqKZQWLUYDeqydIRYc9P35GQIRN4wm7LSLg5HdTDpuerX8MlQuUBzr6V3srjSn3ltQKR7dy7quIzDAPy5LARME5TafGRLIvIrsN+IOsa+QmGZ+LgCr4z43LPrRkQgP2/CL2aNQ+8QIAcK3BHmhzjy600AyKATtQ3r/q6g4tVEnhlIVgA0SigdFSBXxBPrFg+brKVIeLynnbP2msXHZXcYu54T3XVQn9ZNv0voa1aW4MImmBJuPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9BJ7w54FLLy1r7idavEXnrdY5D9AgX0T+UheGxC4tc=;
 b=cLnB38u/CtGPgWiM2rmIbLlDr+AQT6HooycXACbHOZFybT6/IIsP/ctuUPB2uABX65P2hL7lbohJX8LbdOUbqbi6rwI/gMh8G5A04z71BQ1JOSRO4e5dHhYeu9n0G9RmBzqlBdpN+Foac3Hlm0ttMD8akOjHEG7WzJCpSVyf4Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:34:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:34:00 +0000
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
Subject: [PATCH v6 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Sun, 24 Dec 2023 13:32:37 -0500
Message-Id: <20231224183242.1675372-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231224183242.1675372-1-Frank.Li@nxp.com>
References: <20231224183242.1675372-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10020:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8f6ff7-87fe-438d-9c64-08dc04aee55a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nFnH1ac2b3zwJ8gO1rqpGqoVowOEwh4h7z9aTvlcErYmTTsX1JzkLd3r+gSt5fjxMp6gMU8e2vMl8+Aczjyvj4j/YLR5D8cny6OBvNgif7xXtPDGjzssVlgSaA4B7oDoZ7TbkXrw9vBLD2voEFUwP9K+t9O3kTiMUNSXOGEn08yD9IEddxR+TcioxzPJsWBRatANy3ugXON21StZJI4s3d3g66TQpWM8BYSQw4ffXlmILzBPRk/qGGoobzxy5xuxSKVowaDd78seqvoSoY1YWSIErY0nsysxJjydMexL5/z8Ojp1jFaO22Z4Hex0Gv2DUG6VmhprgdnyPnt0Nvpbfng717vlrCBk51ULTf3S8bINbEMqtaMeFSt1UkbP0Q4EpALEas/L8VCJ+1+3UUT2QdyUT3j9xcNf4ZBeZ1k8abQdKdfceoGBCY8zpYqMFmypHekn2FNNe+GbZovahPk35bHw9woWLWT60vqGxDMVzcd9bB+HD47xeZFr6mfoA7xhCjLJ+QbzoU/57ROv/uFtacghlvuXxDEobPHvPwb/5tewOUJGO7PMfcwsXTs4C8UqhFk/dXTpUM4pvc6ybVzrqEtssyuUzWyUiWEnjZcDa/lf+ovgpRljkkZ6gtaT/pMlS9Kau8w3YHfEG2k+Xvszxw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ul4FYqSS/ur6qpzr50VVr3aI5KbxddzQ3sAYD90q6lbPGGo3PSjEyl66JKFv?=
 =?us-ascii?Q?lqGYvxdIXrH183S2k9697cKjQSOdXGYJbJmWRpkLo8HvssEpo2IGlBpHxI2B?=
 =?us-ascii?Q?/UZjTQjruL+smcSI9jAW3iK98HSNDd59uHa80BhLvPx+fL7pvwhT9Hyb7YzD?=
 =?us-ascii?Q?cO45uNwhhyy9BR/W8pr97D8/Ks1m3a8KVxzIwFSPLgRuagVGLBUK29CPWru8?=
 =?us-ascii?Q?VmGBAVkh2iJnjYYuPyZFUVRJlR8KzCBceXRCWq2XZgreTiGUA8yXbzPNXhAV?=
 =?us-ascii?Q?N8MqAN3u6Gv1ioDPjPjHRiMeVbYtpjVnToAP5itJxsyHSga/SRmB052fyyW0?=
 =?us-ascii?Q?fhfHAbbBdfRCtLgy7lUd9QsEsrDdQdnHXHlAhaHzmHfLCavwnBuStlP7HXGe?=
 =?us-ascii?Q?wAjrZwvaHsU/HVbN62qovRmotZ04Ru0D+JnFEHenQPpNwR7qSgRvttTmh9JR?=
 =?us-ascii?Q?7nxORuCJvOkR862ozie1KZngnSfSRLoPTrbtOqDkbNxzOM+f3g1R2PhQ66Fs?=
 =?us-ascii?Q?mWRB0/PJCkg8+rTSQYIuYePRXb2GU1ThctDuaqGCSNVG9op5W2M3hvdim/IX?=
 =?us-ascii?Q?k2Np/FDQHmRQHwrNXsyXHBW0UvRxfIKs4/EVCwDFrI5LbxZCs9PKK80NlU7A?=
 =?us-ascii?Q?Oz1GlYbwYcDvb9gtrMqGeN/Ou+Ee7qF+P8t7oEGSRibkczl17zp6FOLtBNGm?=
 =?us-ascii?Q?l0yEi7GaDxxU5xmK7kjgFTtwTfcxvEIhTP0Wn+T2JcCDIgTq9M96pfSmV2Le?=
 =?us-ascii?Q?0AaxQhrXy6q0bSyyik2ES4mKyLLlrC6tH3aE42qI9XXJ8mwJN1++BhpywZTW?=
 =?us-ascii?Q?juUseXtDG63v3iV0CvRsku3nDZFldIvpaRB/LoB2LS8UkHO5295V3RG7P3+J?=
 =?us-ascii?Q?Zl0/tu4KPAsEgz9ao9kPBhwyJBjK6tGH3/jRCewpXsrAxft5lsi0vWBWrmD+?=
 =?us-ascii?Q?YqIQ/GBpZr23sktcGezQ64Yn7P2X3hgeC+vk0jNokkMdPhE3Rdcx3rgpc2Ri?=
 =?us-ascii?Q?5t9C+qRLQpBoa1EwQ8o8Vo8hozp7K/VGSzxeLgwa5hn/gNnaxJLzHq3JzuQQ?=
 =?us-ascii?Q?BoYQi7GvPD9o2Fipa8dzKgI1qTIf8cwWaIpI1sLCt5XqIPZ1nWJmq+HYBnSN?=
 =?us-ascii?Q?0tUeJpb43/xRf3Uk2BqQeYWMvanAmQ6HnstpJz054UNqnY4MzdA3QSa3cQVM?=
 =?us-ascii?Q?oDFg+iWZh+DPJGj5prdN4gOdnT79xsPKiwcYHjQ6ATg4jdLvnIl7Zfw2DGge?=
 =?us-ascii?Q?T41Rl2hrmJGY9zmqzm5jro2M7OPbK78ncfDuVB3ZoJetVmqVt2yPXtQ5p4Fb?=
 =?us-ascii?Q?IRK5Bdj9HiKBgxe9+mtAHBh1Ey+qINz79Oo3Ki9cU7Ji7y+AgbkDwNVi66lx?=
 =?us-ascii?Q?f1W0aMt6yJCkeSOQdqbHd9zQt5IQH4vhndjXeeV4EfEwWXMKs4qOMHx7QHPQ?=
 =?us-ascii?Q?Fbvj7ax3cjv0eYxCMJ5N82VGAuZlAd7kk1on8EfFKtCjq87zUxMGrdBIG01l?=
 =?us-ascii?Q?Z2OFQYekAcz/GahzycWopJavy8A/7I2H9L0nFUmDkdfhOr25IkX3fR5P9JDc?=
 =?us-ascii?Q?V1n7jQ71AHQTzTIi04w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8f6ff7-87fe-438d-9c64-08dc04aee55a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:34:00.0622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vI4fMBcbNsOtz7SRG+53c+cJ4U5IqsDM1Pdo8QVDyDc9X52gPzjUf2HBYU37alPej299UPU1ubNpPH7U0HKEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

From: Richard Zhu <hongxing.zhu@nxp.com>

Add i.MX95 PCIe "fsl,imx95-pcie" compatible string.
Add "atu" and "app" to reg-names.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---

Notes:
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


