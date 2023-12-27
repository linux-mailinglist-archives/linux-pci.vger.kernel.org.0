Return-Path: <linux-pci+bounces-1456-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AD681F13F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF241F23012
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A114777D;
	Wed, 27 Dec 2023 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CChl6rWY"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC12481C1;
	Wed, 27 Dec 2023 18:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alNXx3VVpvUUx6ji/Kr/PCl4okzwfcnTyYkVshlt2lJjox6nOpEZ+H+mZusjVx5N9liAJt8P8eYUzFjI/sNlJcHq9A2cZXr8wnxeJ4G4SZNXLtN/klyBs4FUV9d3nAnBUKJZSDNx9VTgXFbyv96/af8NQc1qQ7tOwPZKs2U4fXxrFzvlRLMB3GMZBXCFzrHwbWnJULDy8A7KzJRcZG0DdpuUuka8pajN8o9h0a0Idtt0wWRHNj7Or/IhQ4R+UQACcJVy/HNcKOrJHWlzciyLIF0VxgMwjFgAyuAYS5WeA9zPEmHO1VSQquUgA4R5x7XDRvwrYJDp5PqFlRtxotnPCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V3HsfUdOclisMP+T8AUHfCndho4vH6otdg0N0F0yqc=;
 b=m5XfGjSuLYLq+2xcL3kvQACtAfdEWT/epmFiAo5sJlbNWehcXbybyaaEpxea8iu0w0zmygKwMMP/S3MAp5SFAh7bX1LoADcq1N3ohAVeiIjnA52Q33l42aXok+sLRwAx8r09X+32lCwjs5SU6kBQ2UCoJ071Qf15tRAV+ZYMFSFMw+vdYYGtFxdNMmkEn5oZ+4k9fMRzcJOcRyVDePwOCvz6N874eyUdwJ2uOw/os6LOFymIEplRS0WcBGh6hK9xsftuBk1OnrEx2t5IAsLRT390nD/ph9bTDTD6joV9ZlKCiJ17xXV8g844iEh6FQgGL8vvo4nTfXkKM4BWJZ04MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V3HsfUdOclisMP+T8AUHfCndho4vH6otdg0N0F0yqc=;
 b=CChl6rWYme68bDkgcuNBSDMT/MFXYj8fXVbbQ3KSr+YZ1GhsbGKodEEex7fVz3Wbad/WCNuA44NuIxI9kBU0ulMfJyY/I1AFiXwTe2h9QvXGvG1XI3+ta1qEdKFRdfqJtgoYHamMJT3W+p2MHuk+ODYaZDYpQLkzgz34ihlkQ5k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:10 +0000
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
Subject: [PATCH v7 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
Date: Wed, 27 Dec 2023 13:27:15 -0500
Message-Id: <20231227182727.1747435-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 897c047d-ba04-4f56-d7e4-08dc07099477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HbRILfcstCUCGRdaiXE9MoFvzdaZskfs21b0Q8y5bWSjabtRnxBEOlekwMNhKxBuR1dQeGo5XXNdUIg1EzmeIpnVqCKdGPHk3tFFSf9BmMTVJLSaAYo8wRH+IXN/UmKxkz0QgJXOkSIs4/eCrV3U6FFdvH6SdL6ddrD1rv+O4e4r38ZV7zCyhx+1iMZSzh7GUj0i8JP3dEPKd2vvq+RgSXF6NpC/+36VZyUPEnSElBQHo7JRLrmyrC8/z7c6KPFJut9BPj/cO+xFD2C0ygp+gU48xJvu8YfWE60X5jsNYSmnkq5IB1EjQv8sr0BbHvStohdp45tTyeT6beb32Wnba4jHMeQIxiLOhD5gcFR/WPXtLG2ovMHQW3Z21jROCyO+Ec7b3mYuo8Re4wKD8lxDbO247QYfFjQIOn3zG2q1BdrQiAUFFV56fy7hJhjizfYTIFLWhN5jsTDLp0t5oSzFFt6angfkasxpVWocNgNNJ/pZor3R+6O86CTnAZR9zeNbxsNslZGV9ihwfD40A7EgdyvfUL+3jC71lVZ3aZbvfZnThDyX8N44RxRD41MwDG5uCGhXOXTFfVhZSlgIeVtPGQL78wfzneGHnNwInaRoF82sba9KwPA45EHh0kQgVsiPaj7RYaOxpDaY5Etx6RBDvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xD0tJjjLNketT5puMGBZrvxrpeeOOYJybZzEewBeFnUZdNyRsSe5BKP0F6cx?=
 =?us-ascii?Q?CvQrANtyudOoOQJzsUptoEeCl6uMto9vXC3YFfYRkVbrjG/0UnRKioJXYXZV?=
 =?us-ascii?Q?ClHJYWKSujtnZlhXLpC+S6UVaQ9RHnWROVX4R4Bev7j1HA6k3r+kABwYenV5?=
 =?us-ascii?Q?SQPoSMrWVtEjIq1+s2KbdgKa55xUNl3PGlM7zFWum48nnxMRYtB2aXOPvog6?=
 =?us-ascii?Q?vla11qMaCnIqFyM4OPP25OtoTKq1kVmocaYHttukUj/GNyypKC74yztWEB4Z?=
 =?us-ascii?Q?+1/B8XX+sw1To5HBw7L+iYGLvvlwSzx/ccBj7x5RJ/7v1dAEkjCO8vEHrbFu?=
 =?us-ascii?Q?rAKQVwHq4tHxFLRnXlkjjW9HT+H4QeD4uj2loYGAXBPtWmOCXL9jIeJBYItj?=
 =?us-ascii?Q?iXZKEraQiHr9AeH/y33j2LaWcOFnA3BswBGzYW2JEEvzKj8Ti+NBbkhKQvx0?=
 =?us-ascii?Q?KlTCNME6eaoI4L6lFtEypJls1zIxv7ZH7cZM8iyNHLNzbWz8Q0lvsLh1sWda?=
 =?us-ascii?Q?hWg2lkmyC/maydGedP8uAY+UnpncAU8tRlRU+6+MlULtaKSbPA7uRUhzU1z9?=
 =?us-ascii?Q?EyFhMtRvZ+dQK0BCZMwoo9PmKYKI37cy7aJtFqiYAA+zoWtod1ymM2t5xqDt?=
 =?us-ascii?Q?nqXnuLRIUr1PQp2hjy8SXZlBQ4VsNSNs+ZvCixKodi+zuc1eJ10JGsJw0J5r?=
 =?us-ascii?Q?ELhqghdLsE3IroagPwnat8EGmu69M/EfEtrMsyAOJG7r4mAph10mms9nNIrM?=
 =?us-ascii?Q?jJAr/EvYdG79HrnguEvGr3DeB/4oIGgIZ/h8JRvlXSO63P7PHujKvQxITLsh?=
 =?us-ascii?Q?h4Ne/RGG8WSuxAic4YmqfkQrVz9u3jYc2FXqlT3p6QyitGErlogGZvLFLSl6?=
 =?us-ascii?Q?W9qCuvio7ja8wmWLsAMKiwjSVe8FIgC11GqNCj9dUucWUdqgimUudMrND9TN?=
 =?us-ascii?Q?81c6kDPb/E1KcPxI8OzzsYPnZUvFI0zyDnhgwziEeW8w9iwE0YvLUw6K4VP5?=
 =?us-ascii?Q?7W7m3B4d7h2PcJ7EUPP+pCBtqV1JW3DmwTViy/W7QmwSgGiSIgQIju/+AL1N?=
 =?us-ascii?Q?vLzh64G9XvDHWD65tamx5GCapr8y2RZ8dVgdr4conZE+Q1kXKeSU9whNJQqz?=
 =?us-ascii?Q?rLYFTgEh6X6S4iJl4Hg0P7Cb/Tr6piyhlLQAC/u0Xlu7xWnl+Obx5hf2YdZ+?=
 =?us-ascii?Q?zqpgsqOl3ONHe6Q8OLgg3s5pQox6vVXHhn9yJOVohznVzozLIY6IJwBp+7GW?=
 =?us-ascii?Q?k/iDAT7i22O+QYANuXtHN1zLIzj/IsHmwb6ChQ7VH2BCC+XUq0OD5+HW1qBQ?=
 =?us-ascii?Q?2kPX9+YTQNvCN7njII6izQ+EKqsiejiFpuPWhRsbXRaGsmaJtGqp6Sec+68b?=
 =?us-ascii?Q?2DhsFx+DiSJUEnijQFn33M7YaMdgT+UBHmBWkzwZ7hHXzAD3ryRKUOwKu7x6?=
 =?us-ascii?Q?uEBRAUVrx5G1LJ3veeICTSnoB06JWR9WrqXGZMJI//+3Rq7foGjKo5lrl4Ss?=
 =?us-ascii?Q?4z80jJMM5U3lbkBW5A7uOyXsb6bFBvdHqewGAAueDZc5iqIakAaP37cwjmj0?=
 =?us-ascii?Q?AD5vKS/sKGOdIBA909Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897c047d-ba04-4f56-d7e4-08dc07099477
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:10.8447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MnFey9Gyjnb1sF6iCLzGWx1wrP7W8Qs8Vqi+lRzDUdct5Ag9uXSaLief/mwoZqn7u+vhZ8wYYDe5T6s3aClGJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

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


