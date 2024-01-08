Return-Path: <linux-pci+bounces-1842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FCF827B6C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 00:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9054528523A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 23:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485BD56747;
	Mon,  8 Jan 2024 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWXdZi8D"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60956B92;
	Mon,  8 Jan 2024 23:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6zD3ltlt5xk/VscOFiDKOjv6gyD73uiYVEac4xAqo147OBXUOfBkyw49u6KnV9evT/E/sB5tis2aGEaWg/x3i7MNDpetuiH1vDAk1PLcpJhltStuD/HDAauRhqCLLIh3Ox3xCHRzILOHogf18mAm8FIZ8q+WWOT7zGHW8StzonDMRt5mTT8OUny/EXTf67J1xWmMUAsmWIG+kw7htBBEyg2axan3O820dLeaZNx8eyBKowa54CspDk/KFjY7f7TeEFupqT5NIYL5RbJo/0WNr8MRbsHqMSD4NoM8E84VVBwgye3H114MqZBQq3S/KOkLjUlRQ2qAVMXGvLTlLgDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FkptuwPkZvm+k4HZ0KmqkduaVwiBlCWTjivfPMQ/Z1Q=;
 b=DMCmQb0skZcw0U+Aowkptw50rqOCY3smDyES3o2CgJPwZNHNxoD3yxQkhgz4wb5c/wFx82YCuyQRPAjgYvuch9eX8nbVNXkJ+q5ogyN/ITn5OtWB8XS7SBV6IJcYr7H5TcbgQCx6HTgE8qWeC5O9I4IgJOziQRQhmpTNZQylSk5n9K4rrkeYuyQj1atyutzQStgqge3UCEHpMArUAuU8FVxjK941qnB+I96jqzVmvxY+uWEt5vFS6bfNMo92mpC9217Du30m7e6xqq8CGXIGz6/Rh/dyPhJypshsj7UlFEjjbby76lfNZOY3AVx43EhYS58Yl03n35XEsYF3DeDZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkptuwPkZvm+k4HZ0KmqkduaVwiBlCWTjivfPMQ/Z1Q=;
 b=UWXdZi8DNu1LuTAIyTrY16tI+IxmGPNl1sLYLMVkd0AVnpF8b7uBM8QNWJ0Z4bXt3Hj9w5uv49/UZdOYUZTWYj7d8xg77GdUjy0bdqOvq4fVn7Jnd7eVVihGAWnJzVtlF/ZYIeVAFA5M2D9wK7J9MOxhFISTBqJm3a15oiwT2F8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by AS4PR04MB9338.eurprd04.prod.outlook.com (2603:10a6:20b:4e6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 23:22:28 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 23:22:28 +0000
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
Subject: [PATCH v8 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
Date: Mon,  8 Jan 2024 18:21:33 -0500
Message-Id: <20240108232145.2116455-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a1ad3ce0-a9e0-4df8-3436-08dc10a0ade0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y6x8x4TemKOl/uvK0ZJQqWMnZqlR8HbRKOQNAMb9MBs+4m6CP4Ye39/8FAvd8LMLRhVVcuDKTpKM+bu7EP4U6ylVt4mc+Zj1onMrQnCzistfFXheNlkq/SVm7M6m2blF+QtfOBNwSAP2eDbVSoEVTYeHoAn/EPesDt2lhtlwiWpHUFkEJBnyKyoPMEZRIUd4PhAwjWUTyaEQVLknIAKkbDsGQ6A2WIBHS3GsyHNtXqNDoPHtSG3mc71rkJqOXJgajbC0aO8aCJi3rdn9LCDZLRo4QK+RVRdQ20aNbOrdCDMQPOba5Vp6A3qQoL0bHBTa8XTJNZE2Ryqjg6hIyZMEdvvte6CeWyzrOQlhENLRB7dIGhiz7c3WbJHZ+jMLC4vM0+iHU7yypqwcY3Ys2GNeuxRyh+PXdS5wFC9xTOjVDyEanoipZHeyY0kmVIIthzvqvFhctmiSZ43xU+EgWKfSMdmjuvfpAik+kjmw9R6CbrihFwBPaBoXkc1+Y9eyIcOGfMl5ZI9d7fUW3aXtIG5KDCReKTUDwme0Apo03bq5iMyf47eQhR6rXuNZRbDcZq5oOC28HLtrNh8SpTji14H0RUo/oW+WAOK15e9Kd7/1PNjAjLIKuNfiq5WAYv9A9LmWOJnURM7wF2wc1uXQF0wNLIj9x/C2IZ5MNLnf4sL/yP32Vlk1tueBb5f6ULGavwND
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(186009)(451199024)(1800799012)(52116002)(6506007)(2616005)(1076003)(6666004)(6512007)(478600001)(26005)(6486002)(38100700002)(86362001)(38350700005)(36756003)(41300700001)(83380400001)(7416002)(66556008)(2906002)(316002)(66476007)(6916009)(4326008)(5660300002)(8676002)(8936002)(66946007)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FSK64xFEJOgbXMH8cm7u6wehPJSg4/BhxILGSojWi4OYKriMT1qgNe/8jHWf?=
 =?us-ascii?Q?toiLCJ4DCqCRwBAldavy2DGS/N5GglIfCYoq/usN1ebS6OOEODIV1DKga2eu?=
 =?us-ascii?Q?JGRrKehbA4QB8lQg+8dBqxkVgKdYZOREzomROOge10SNcyTR4/F3K+DLQPwd?=
 =?us-ascii?Q?4wjLU5xBYQkrs6n1n9gfTyGCDr74J7xkTGUVoK91pfHjeVn6vE/BDCYB8g6D?=
 =?us-ascii?Q?K7KPg6R+Q/OsrUiBjB4DbeBInzhGB3Bo/oU6u44oYVupmzBne7Insa5r0mxM?=
 =?us-ascii?Q?Ee4OBq6VaoSJh8uXAYJnREO/Y73RZgGruXCuxrldWJywmNBqLb2pjWsR+c13?=
 =?us-ascii?Q?nqkBfyRkhmb7rApIkfCtjy9oaSEGVCW6au0B0fMMP/zz3Z+Eidvj1FQD+DeM?=
 =?us-ascii?Q?zkB6iXXPJySbKUhRyttUtJcepekbJUTE5H3Pk5lf9DEKV6FMcUQtKB7VOQOQ?=
 =?us-ascii?Q?5Sz/u0EbEsIpjLg2MLPdzBkAxEMvhO7JX96FiBXB/NQ/Pl/svZMwCQMEEuAK?=
 =?us-ascii?Q?0j4hSYh0Levn1fp4BUxIhNN3d0rF54fgT/bKnHj9dPJVJSFWJ+o90NCVD5VQ?=
 =?us-ascii?Q?ISseynHP5XXdMyKj2dUVyFhdvWKV71J+JZO71WlhsSoZUBTa1hUNRcfe6F++?=
 =?us-ascii?Q?sh8uPq40r0Ylj6TcIAeTVs9GOZ/XFt/wWWFLw2JO2Bde9+0lgvFXc21tBYfe?=
 =?us-ascii?Q?x8RFOMsTvrPtbt29afi7bw1Naxefw5qo61zBI0wtJ9/41rUiB1clj2MioL+J?=
 =?us-ascii?Q?5g+jauZfwVW0TJAxUgvle1PnXpfRM3VleiXgf1f1vdeH3bUWfo/uVv2PbEZo?=
 =?us-ascii?Q?x30Znfl7nrKjPKq3EphRvPVy8TE0gLrJ4PkaGccThcMbowCyJ65VowNvynpe?=
 =?us-ascii?Q?f3jLbreuF6lRzJ/bapKmmkcO658ESABmwQ/ie/Oqq5xlHnGK8F6GfJM3J60e?=
 =?us-ascii?Q?O4CY9JnrbLf3ydiT2/fxcdOBoK/zob5Qcd3EkHfMy6d9spkALIjQEUtwcLLW?=
 =?us-ascii?Q?jM9AXGXD/yFAxsLhnIGKhFvIR2v8wMf6eV7zjfyLdVjuqmmBLlx2MouK18W5?=
 =?us-ascii?Q?8BVLp+AVMD7rDbykP/8SVIT9PYw/Vvi/hKTce8Zl+DjtXCPtO+/RSozGX2ll?=
 =?us-ascii?Q?RFu3x48st+9vNA2GBkfp2iHm1cfD74nLSuh5hiVHXHWpLeD9+UZvzvonaNSH?=
 =?us-ascii?Q?U4KQaKiYZGgDVQJpDps7ouEsRKRJYwtrNj9EWYZsrOnf1b5XDcG4ZHkZqQM1?=
 =?us-ascii?Q?6dQCcucmqpl9xAPzVZrRulxQLUVHt+vvPJrABCGK/SW/627IrEcZo8AGuuCr?=
 =?us-ascii?Q?8JfpIXrrbqAw0sFCh1b6VddC4SY1dtxnxGMHJmExMwHIbIEHwlU1wbNyW+lL?=
 =?us-ascii?Q?sDBCT82nM8E/fnadkBWbAGDnslhM+K6/P3cb3ZRAqw3ZUYw5jitc5zsbGHxa?=
 =?us-ascii?Q?sgoM9K7TGX1OqpZ6ZekQoZFkARsY1HAUFjRASKerwaWKdlQcaoWmDFCqUOiz?=
 =?us-ascii?Q?4erSHjEb1W0pwIs8fQbSMxTOsay0gBbwElDgh34jqXukqyg/kx9/YXgvn7K7?=
 =?us-ascii?Q?bZHa+oQet7dEy6M3ujPNNs6QNLLBfEuzvP/7rd68?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ad3ce0-a9e0-4df8-3436-08dc10a0ade0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 23:22:28.5845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svPx3IpPcFKVt/J0Ke5+UW6FAaDbKmIvQ55BcSmkjJFwAZSp4F3VE6oX0bHfe/txH1cEAJDEzyOjKbDao0xnqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9338

iMX8MQ have two pci controllers. Adds "linux,pci-domain" as required
property for iMX8MQ to indicate pci controller index.

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
    Keep current to avoid DTB_CHECK warning. After these patch merged. Will add
    linux,pci-domain in all dts file. So dt-binding can remove condition check
    by soc.
    
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


