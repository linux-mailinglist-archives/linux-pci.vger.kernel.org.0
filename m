Return-Path: <linux-pci+bounces-1345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0063081DBD5
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B561A28150D
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8AED2EA;
	Sun, 24 Dec 2023 18:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QK/8RzeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164AD101FA;
	Sun, 24 Dec 2023 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XlU2cDfUeXhKKJfuBxvH9DLyC7hK3c7b59LOMA0DPk+5HUR1SxkdvNOpNRA9A8v7R6vXoEwlQ5+JRFJrLkAj5fJxeMHo1Ddvx1X3GIavCdRU9X5G3Pzc5V2jZ6UI9nXSt/SPW4U2VpVh3PwCokALFHxfkdG0o/cB6sI5MBW3Uwq/XNghZGavr1nzaCpK92/RomgMg7t33SToJmRTHRurLocRjYRFBhuCJ+kVWzjFYPXYZNnuw7yskpGLuQTWot0zyWlI41stWnNseP9CCVa8L4ILyJ6O+i+xyVFTcqW+xkAZMksCYWSDonkp7hVY3XTDZljrzXxY99pYDwZn588AEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V3HsfUdOclisMP+T8AUHfCndho4vH6otdg0N0F0yqc=;
 b=UbbRUD7M8nx3yhfmSKK87XVyncnI+01XBwUreZJEYQPNdNlyRhQBfwvMrxvWNaHIsHG5c32mC4Wx5rALoyruawh+cCrFdyhYTK7ffsjMGCZ/BmqxKyld3GLM+Bj+pWU3SjX3w8VHqSJ7AIJtWdddu3IhujXY6WwD/vbAFnwsmNp5FxjX9JA/onbWz9fgB9ak4qZKa/pZbLvBE9TBXktW5l/GYAiWRdgvnHEDFRpkXtNe59CpKkUePQDXyFekljqX37443fjmp3OzClkQxJgGQutWb7KJX7ONCjNcjGZ21eODeHpPKBTC+nvvjwXFPvbgR9IhPIB9KNoc8rHiOw0CiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V3HsfUdOclisMP+T8AUHfCndho4vH6otdg0N0F0yqc=;
 b=QK/8RzeYp/ffxI6KAOj0L4SJ1ozZWSRej9bwI2cOnZy0LqmV+zy2uXGAp6FXRhU/oL5FrUTm7kyv/ECs/L54QyHERmsAbTm+x3XvQiL0i8HVWygDvzSPSxIMGpzHUxPP91N3vzbZzy5unz281kEe6a4Ew1Hxw6g2RFUjbbYNxQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:22 +0000
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
Subject: [PATCH v6 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
Date: Sun, 24 Dec 2023 13:32:30 -0500
Message-Id: <20231224183242.1675372-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 87b9a446-1e3a-4048-4761-08dc04aecef2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	66H73DdTfJjZssjK1JX0bNgEh60L0t71/ZcbcNo5qmZ7nLsw59vzjo9ZLnzdA0qr2BQizDyKTb+sFw5oi3dML9XP5GHphkr9gncx+KTxfhwrOkLNkaXI9bk1Y/CNyWbz9TheeHqACo8yXeitaR/ydm4jrNcyDULySxWwA7WCCksFwfrlZW4Jmuk9ugljJoy8x2DsmM0ezYm/RHhY3YlncJD/F35MqEihdBQVB37Su5VGY2nWuWpj/qvuxzIv3Sc9AqLuQGyyKeERNUCv7tkAguIYmSbMR6EWQvrq5GQKFAIw8Q9FuSGpmmE5LXKxrliAUmP/0+fDpHj4sDYtm9k1o8hwjdye6Ns7pJ2+MM+oUW36vEJSB336LvndAPsOiCPM28QBSm6GPACeSrWsd9PMsiwprCTBwjUjvkb/LixnISB21JVdW/bZQ+QpijCRpLmqhZ7KYlZPFTEur8mav+Gt/XBxKezdcLymwWyD11iKdqJV/UTdv1a5kN4FN9yapHCXzlqNxGpXUDJ/1oLiUD59I/9pId+wfU4CYt3rnu+8Gw10s8V75xPuGifQmaj0zmU338/LovJaDpfXkq/XSAd+lwDyCYgmjpGbTqNGNAcjsol3IjtowMq3UzRm4VJd9N4K2JWvW3b2QVr4etzpIHO/jQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fs5JJ9bKnCwDg1cSlQJePjma8M7zSkmxUqAj7wObdi2IU1wjfSp1/BxDYU6j?=
 =?us-ascii?Q?DcVGvaZLghcJPwp0uaabVk8EH5609Ly5qay+mDaHSa6mmglsizEMVSegqDh3?=
 =?us-ascii?Q?WV5TLkb6wvcVO7nk5S8av7VpWLfZ2moTEOn9Ei7prwyP9AKYXdgC31p+SFEQ?=
 =?us-ascii?Q?7PsUhfX0e3RFATFjHVq02pYyFRqj8TzOary7FM+APhcnXZ1RQr/ssajg0k6b?=
 =?us-ascii?Q?TEXKe/r6gQkEPU4MBqsWaSIXNkXvnVs58oTYMbOVeJXZFNAfMFmm5tb+Tn6k?=
 =?us-ascii?Q?61tivIFG162FMvtCCWiJR4u+bGmk/MnVFC+CCRekOKM9H4thuoF5KbJjaoyh?=
 =?us-ascii?Q?ZJvOcsiFqI+A6/ww8SHSQM3PUX1VBj+aaBfBSPHGgrBxDHIh39crqAUkCv0+?=
 =?us-ascii?Q?jRGo6uMK6uJbNfaSqmxKgD7p+vybYXHVNojTOXVEkhXgu23HAEDt/HY1ye61?=
 =?us-ascii?Q?I5WudIQdsM48J6wPH0DbWJDi1DzceuYAmkUP+SWLuTMJ8wCZxRuT8hecA7am?=
 =?us-ascii?Q?Hfy0ZtoiJahPzC7vh3VyTXGysJ/KgW1PsC8+Extd7pi8umLPqwehcL+SN8Gj?=
 =?us-ascii?Q?d0zWIpfosy6OpO/wzJsCwI9Fr/pRFjK5r3Rbnd7csEyiUFB/OiCztitfUQZ9?=
 =?us-ascii?Q?0dXsTmJ6X3z1gXDYvx64HVESQWbKX0Aw15cSD36wscNdzgX4722tpvY6jsJV?=
 =?us-ascii?Q?xFEfsnQhxLSZOhX4hV5Sa/4N8jHgR346k3E2mA1mhcesaWQGUhxZlVTf58Pf?=
 =?us-ascii?Q?JEal59e+u6qBO744P+7YJ4mQaE6DNhWEtyKNmtgYcnYO9hfjXpQHSuMbhJl/?=
 =?us-ascii?Q?Fr6YC8OHWe9YsAaXlXgDgAIoAyrhWwUpBJNLP9t50QirXKgqSaSZY/ClRvZf?=
 =?us-ascii?Q?MzZU1fLW54Lf7n9GfkbkPWHCPlAMKErzl3bUUIAwyB6AWXXuWHkajQdkb7eI?=
 =?us-ascii?Q?bT/KVcbQLiJhrsm7Enfzc4YJ643ER9tTS81pufAdLpaTWfiWmJqDhVKyfwj4?=
 =?us-ascii?Q?YMhMLcfkshIOo5vM+P2sYRtI1YketsEg3HT6GQah3JDZ5HbCHDM/efk6Crx3?=
 =?us-ascii?Q?ChahRO9YfAM9Mpbc9pBZgmErjfvDnseZeDv/T7vztEm3reYOZyxkDEBHXd9Z?=
 =?us-ascii?Q?z2yNcsp+Y1uCzDbmKkRF6rZFQGaygu7s2FRnRFfL1IoJH5MTle4n3SiaLmWx?=
 =?us-ascii?Q?SZHeITZaf9rO/2Y7Kt86aX7lFikDiOw42lxQbpZi0zXEhS97PZDEQ+y0fJJO?=
 =?us-ascii?Q?oSavpyzOfqZ2UkxAf89G7HhJigOaM2eHz4HyvLR8MF5u1vAsR5QnGtA9a7ra?=
 =?us-ascii?Q?VvNzJ8eLmYSi4zI/ZmOB7m5pHJ9lTqIOWCQtqo7yY9dfs9A/RY6ZHTjrf4sZ?=
 =?us-ascii?Q?W5UbNr/BU4GYyM0qssCWRHEL8qRpUiGBw9Hmb9COYgdu9KfbHh8FrA4ll6KS?=
 =?us-ascii?Q?8B8oyBa+zLVOOR0M8Iy9AxorvZKiriU5lyYZ6TbRFnfMWo/kxHT1wNx/Qp/S?=
 =?us-ascii?Q?plXLwK1hOfDwKT4bPX6Rqn+xK3I3A4qkM/JI3fxzIPYOAN0HTrtLDxHUw9pM?=
 =?us-ascii?Q?JhVgZYlhi4CN19UN/CE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b9a446-1e3a-4048-4761-08dc04aecef2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:22.4341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +76GiThX+47bVFaROIGl93LoJYc+CK9z1fV3nuiY20JdDL9OSxYzzSz/vqHxPyMDpTUMk7dN8mG8onouLP8DeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
proptery for iMX8MQ to indicate pci controller index.

This adjustment paves the way for eliminating the hardcoded check on the
base register for acquiring the controller_id.

	...
	if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
		imx6_pcie->controller_id = 1;
	...

The controller_id is crucial and utilized for certain register bit
positions. It must align precisely with the controller index in the SoC.
An auto-incremented ID don't fit this case. The DTS or fuse configurations
may deactivate specific PCI controllers.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v5 to v6
    - rework commit message to explain why need required and why auto increase
    id not work
    
    Change from v4 to v5
    - new patch at v5

 .../bindings/pci/fsl,imx6q-pcie-common.yaml           | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index d91b639ae7ae7..8f39b4e6e8491 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -265,6 +265,17 @@ allOf:
             - const: apps
             - const: turnoff
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8mq-pcie
+              - fsl,imx8mq-pcie-ep
+    then:
+      required:
+        - linux,pci-domain
+
 additionalProperties: true
 
 ...
-- 
2.34.1


