Return-Path: <linux-pci+bounces-1849-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7561F827B80
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF8961F24145
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153C456B61;
	Mon,  8 Jan 2024 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mFTAhk0h"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CBF58137;
	Mon,  8 Jan 2024 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiX10OHdP5Lu4BFG5PXGOzqV+W1rXIKf/xxad95s+kSNlwTeLUOB8kL6rYA0NRB03qqq5HjJNtsQzHxR3lCR1Ib9wHd9YPki9bNC9idLDph/torgqS4xggc6YwU3F+Yk7b4lVXgpXGtPuRzAIt6xIruG22iTb5vD+wRUYzkQ+tvWzqfTh61iG/bwkuhpLw8vKrdqUtOcyTYWLjELGmD2gmPVbV+rDKVmciSZ/7eTCZ6zznyLRJ/6e+tc7/4htz+KF1STQl+BArXdW4WAN20v/zECfykuRDn0lQIDfh31MSUEDduWSHs9MXWtKQl4cBSGUyFWe6688W6lg2HpYZpw7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbWvqYteYvr1zWHZKqAAJdl2+jva0a7FHdVtrlJj7y8=;
 b=grsJoC74IR0oLDuzKQ2EERKISHEebHJ1omTuqbwp56nr7jZrmMgbNUeNRbe3wWPM2qOx7PzQkuK+lui3YDpTYL7LKWXGDrA3B8FolAfSUKL+VvwZEylNSRd3QOBjV4aXW+VkuU2tEPq2p6k98SiC9MUQaZwtNvQ1iebCF4FXp4iASqLJvjGbyXoGKHr5WDSCQ0qrlh83FqypoIAz0wmckSfFov7+NkHOVtfZzKXOSbIlWtlfPHoOYjT8+1M4kblVF0ymwJqk81v/itdHxF5xhbQTjGau/eiYXzZ0k2YEkSpgMh15TiZtgZr7Nts+tZ/pUx9K2ZPP8zTqZJIOi4IJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbWvqYteYvr1zWHZKqAAJdl2+jva0a7FHdVtrlJj7y8=;
 b=mFTAhk0ho5W4krBH7sq5Bj8Ho1BCs3VnNzS6WKCuyzXxnKrPj5l1Bmq3yZxNc0pArgA2B4zX0pjoxnBHP3IDhecPQXCFK6hHfOCGOy2Xe3ywLoQRO5w0T6Lb7Um+FdQjwAMM+q4Pf/whfs+CTqRcyU20/Yy5LLMohje6gou8jkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:23:05 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:23:05 +0000
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
Subject: [PATCH v8 11/16] dt-bindings: imx6q-pcie: Add imx95 pcie compatible string
Date: Mon,  8 Jan 2024 18:21:40 -0500
Message-Id: <20240108232145.2116455-12-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108232145.2116455-1-Frank.Li@nxp.com>
References: <20240108232145.2116455-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:a03:54::40) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|AS4PR04MB9338:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd4a6d2-0f59-4526-61a9-08dc10a0c3fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s43I1vnJQRB2uXxDhSnsML2vuUeCOzAbU+zIjfSGAF+G+oQ24RY9hVtIRzETeqPEbXEhhJk94unViGpwRUSjrJkHb7CgqRPyyTRthGBe/cQaUCM0eKhoPAtBpxQgRsg2Bzqp20fnfFg1PqetOtAgxoqzXgDEPogV/tsWllFOWgzIltDETJHUeT+9xkuG6CIlRC0wyt0v79xuTuZyaihZZT2egr22vaFKSomG2WsPFMQiYtsweIOHtB+1BfRnf78df2qL/zMHdxnScf0aWPFRbFvk429iUAu/OmNVllwUQ3BWiZCCBk0ISU/raeuY6StzWI6pCaHCx6xOQZbY5dWcgi4SBAYEFuSuQuPdZwJDfgI6s0ZjDW3v8X3Vrs3ZW3V9/7I0Uc3JGSHOs8OPA9MNK3hILdJC5TNAU+h+K6DOuD62gCWwtSuzsgHZvx4AtM4zx/3GLjucUSB0HMzOB4/s6FOiRMtBNbfVlw3lpIXne7QTgYNy9J/yvagjGWWt5GHEhtQoreAcqsyhzcxpvRHKthTkBwlVgfyV0kkKE89WIw0ryPhrbKXiJgNjFvQcdAmz13jx9vYuePscAQzNUBLv0XxYblYl9qKK40dX4ZhNY8K78Mp2cam3phEmUgPTAuNo6fHLHxrkrimN3soDbH570Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zh0StdwWnLcBLItipBT2D+NHuVc4D6XR+OUToSq1aAp7vMno0ARvkLlbkU18?=
 =?us-ascii?Q?ddI0QWsX+Lap6mIe8Q1pOVplio1Vz/Aw5uYJneUNY3d6BstGO+G48rQDpJLh?=
 =?us-ascii?Q?wQhp+2+cHGTh4ZozoqfCPCMJM4BabhdetUkQCwClACeuk8MeKQcLzIf+4nbS?=
 =?us-ascii?Q?+idL6T0iiM08Qc4sf21HjaoRxOWeMRpLhFbFyoqrN83XthASVvqkd9tERFdC?=
 =?us-ascii?Q?x+R+leAqbghsPtR8D0vuRbirC/8zT33Xd/tDBHUzZA7Gg7XldXO2ibmm7VA9?=
 =?us-ascii?Q?BUUrkoT/0eekQRgAty6cwQaSVkrlkxEJ1MhKcWJvbCG3jr+UMIgdLSAfr95G?=
 =?us-ascii?Q?bQPm066WMvIbF8ahTWkF7Gmj4saf653TRkeLZSHdal36Sw51xwHPdUhqzSN+?=
 =?us-ascii?Q?F7PfmbdSBiFsaZ2tIjKnB2Ps3+T8N/NziSLmoSEdYqlPFCRUTLtUHMsfmDkw?=
 =?us-ascii?Q?T36TzTL6yve2s7Gjgf6KnZaUakbVLhuhWW9HfZx1GziIKjdtPreRAMojUNB+?=
 =?us-ascii?Q?IPXUcmE5ygPMOYnHMOqh1RpSR08ynGz/ytfyncz4dPfwDFgQNcGCjekeLMFT?=
 =?us-ascii?Q?vRBJFgHlb7+uDgqTpNjhGqwrAaFVWGJTHGAVnyynsWsZYzxK4d87eAKcnWGd?=
 =?us-ascii?Q?jot4BosVvsuCJgchz0RHkzEXW9e1BaxnD17TzuenSYpgBQAUNQ5BnGfwghus?=
 =?us-ascii?Q?xkllxXWThoJukVkLeY9xcdt1pFoTBgO1tkfObRZ9hj2n8dTPFUfrC/1PR+Kw?=
 =?us-ascii?Q?aFkgZc2TK2638xS76hZ3VvXAd6ykkGIqLUUg/gLChUcvCJQfVqsyzPT1+QbD?=
 =?us-ascii?Q?EnzJtquVJ4a+vDop7xKuTrTSi58WOzorB8dNFWkPijzhDU/D9usoPj5UMbsP?=
 =?us-ascii?Q?I9l4DVbg8qgpkpM1ye9Ii3hpRcbDSRslJU7Mzn+8mZwQPjiD870uDp6lQckf?=
 =?us-ascii?Q?leCIJtPNyZS8DZWa5AiIsejjyfOweTIHYqDVP9KHgj6h6b8OCBKqKYuhiWgS?=
 =?us-ascii?Q?35V6KFkv+2oxSL6ElkBjthnHOcaMdVAWTg+1EhwChdumXRjXE/HVT7uDTqjZ?=
 =?us-ascii?Q?ULQeZBCn1m3HQ+IKSa7N5raiP6ie7Y/VIunFgq+R6LiA5z98h5qjfhJ5hBX7?=
 =?us-ascii?Q?foRXKyT74vi3PihN8TMfyzORxRim/QMMLnzdx8xkY8TqE3qiVoeOuiuPUW1d?=
 =?us-ascii?Q?JzfwOkuT2i7czN8vDsBHkPwBurczQA1QieZ6WOEoyqhLYycGhLTDTHvW9Qhl?=
 =?us-ascii?Q?mZhk37t++ghiZ5mcQ8gAJntNjuTEDdMs6mI/1CykPBsgcPSvn+MHF7SkUu05?=
 =?us-ascii?Q?+AI8i8IEgrTN6OtytHw0ACawXuXNPieuo1Ie9uTc33rplTnqsWAv9hjnRD2/?=
 =?us-ascii?Q?mAqFNk4AF5N241cxgujjjXvfqx9ftCkZXDk3hF9KLVKYn9Uvl+eJpv9l2U8L?=
 =?us-ascii?Q?yfo2tHteDV0FQxHDi3O2wMtfcyJx2aYWa/lyyjgrLhhuGjwJuu8vneTDp5QN?=
 =?us-ascii?Q?jLn7Rv+VtZq77M7nwbtYY0ATyXnRGRJGx+hn8WOq/KF7mNQtkJKlmEbkS+HF?=
 =?us-ascii?Q?+eJe+IQfKHDXCOpVl1DivW+zJJDS3qSwrAjhZ2M4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd4a6d2-0f59-4526-61a9-08dc10a0c3fc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:23:05.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: etzpouti8GDpQmX7BqgXEXnxIad9P83j0HBNaI3AYpsUOi5pS8mryTXMPWb8rOULNY0PTlnRA0GlOHJ8gDhUKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

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


