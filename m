Return-Path: <linux-pci+bounces-1350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7317181DBE4
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 19:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925531C20308
	for <lists+linux-pci@lfdr.de>; Sun, 24 Dec 2023 18:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F35E574;
	Sun, 24 Dec 2023 18:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GbUjiP/C"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEEEE572;
	Sun, 24 Dec 2023 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5bF4DEAwBu+DX+/tqEUnK0TlA3g1w3paxRPB6EtOAa2+udM6tRjGcW/6Cz8yQk9keTX2MgAtH3F46cgp+IuCQCFw7OKPZ14wM+p9Ju5z6jvyAJZ4i9m7DqcTdXKpwlVgDndyYoYC4xUEYARH29/UWdvsEWqQHYgtutBIRIiBclbAqyKNzOUxHjLOQSjcdt35e+RX3oLGpmFX+zWN7J3oTSqVyA6ENl1JvIN+i9S3lqpWMeTLIyaLKglN2zHqUVWqN7PjOaXFPsTH2CGW1L1U5W3vk3GyQrprtRwMvrRztKxGDz9iXBEj/jXvq/Td57HiaSmnGiUvRCZGo9bQG8pBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwGNcVVm9dRFaWrWACS5+4/Jv6HAxqd0aWPvzjOpLIE=;
 b=mlpbKulOXiPMrlukQb9yLWBOdEYGiKCgdZU03EYoCK+hM7DkP2LYELAA/gprTuJs4yejSY9P4rCiy/n8aIKXEmEaT/04j92QOs1Cm96Lg01OtQITOZRDpYUjqnibH6fzjpeTi8N6wQ21m6+hAA3Etj4k2AWmUEpIn7gkvQCQrOfriiOaP30TafpiSd6l+AneTtHCMqUfQAcM1Qf34fEpwDNjgJYaGHcOD3amHnh4rvM9ieuIr4hVP2J+00FFcVKJT7nzlLm6s3vg7XvQXEkc+2fCVpmRA0Ck9FLyOmJ74m+w0PgSUFvp7I1Nnni7dFEyt06SW0UfCEv5D5IkObpbAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwGNcVVm9dRFaWrWACS5+4/Jv6HAxqd0aWPvzjOpLIE=;
 b=GbUjiP/CRd6WOzlDOvntdopat3uGtTKMlHfzJ/UAHf1qSVf44i4dTbSyDvDpkqcrQAbC5CvYo2PZWZJKjDI5IHVejjGrE7kFjix0PhuAqB2q3nVqaiRHO9U8u/wwkHL8BnhwwG8ajf2QrLEQlu4oUgvMm9nOyUE+fEQIMQZs67k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10020.eurprd04.prod.outlook.com (2603:10a6:20b:682::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Sun, 24 Dec
 2023 18:33:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.026; Sun, 24 Dec 2023
 18:33:49 +0000
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
Subject: [PATCH v6 09/16] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Sun, 24 Dec 2023 13:32:35 -0500
Message-Id: <20231224183242.1675372-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8bd999f8-13b0-49ae-107a-08dc04aedef7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fBPOTqvr1QskLGfFmBlQsx8d00hBSH5PJoAAiEfln/hrTdnEZdDBJ5WXiAFqGXpiMe+lJ8cvO/bfDHrpkm1RIAZyvpobgIU9dE07Yieu6aktT3Lpmxy2RQrKA2lNF4XBUvQzaeVk2qp4ZVcnPhiR51rtuku5IiFmn7t6ohzwJfmONBMX+b5z3UZRyJyL8QY3CR5nTDA7hExmEbqNinle+/e/a63wMs2koqOhK16hEyEogBu7h/1L6P8FFVefyQdc7TDCZ0NzMNWFe/PIwsHcfEkKO44LoosHFz5OfDvhgJ9OLXxJa7fMA2na6QchorEBA9zpMScO0OeVC9dafmp8Rpu6ZO15QAmowXP37ANiyzXcmKtej8NBtHcCSPbmNPS2TLgX2kWLrp8hnoI3Z5dvJS/yaz5OwDo/8cfbtQSwtWuRPgfKllugOQfyX74IABIDVdkV53xD41v0WZNwo5jqdAiww3OO850UclSyOpJ7onW7t6DXLM35EtXm4KCDubXjXtjttX0LrnKtDJecawGrY2SCUH04c80tmk9mOIIBa/txzWoSwEZq8c3ATc8YAgpCaWV0j7ycHkwkMsAIWoMsgqelDImQp71ub5byDVuPZVVyaPmqhGtoXZY6APUFFjcoWQk5e1SWQ1hjn4AwUSQ+yw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(38350700005)(41300700001)(86362001)(26005)(36756003)(2616005)(1076003)(83380400001)(38100700002)(52116002)(478600001)(6916009)(316002)(66476007)(6666004)(66946007)(66556008)(6512007)(6506007)(8676002)(8936002)(7416002)(5660300002)(2906002)(4326008)(6486002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mSjiI2tarp9sQ0IcxlsqsQM/VJwvE43kcxtaFuxSt9eoMIFd2Twy1UqZF0jV?=
 =?us-ascii?Q?gx80kr+oxHL5d1jTrEb3jWFITj8Qw9DhGmiKDRa6LNTHNmvwptTCQ8vEI/rt?=
 =?us-ascii?Q?Ce35nqmc9dRpgwNs+gFSQaaKX3qcYOflVG+t/sJnFbhhRjU9RDnLXptcAiZb?=
 =?us-ascii?Q?qycgw8qZCSan1Y6RmOGOUySIZShSc8wLgr78VmVJVvWa906cY4q4KGkngJjr?=
 =?us-ascii?Q?pTNXgPHEFDYNYqq6o/z0Z0guLCAby3tWN1u6hnZiJHjW61mZovjfuImxirIF?=
 =?us-ascii?Q?4LramVKsT8ui7WQLIbEm+JoKTQsdHkKWnlbdT6XDx4PAGbdYpseyKDwdMUi5?=
 =?us-ascii?Q?CwL8dL0lBw9tUTWnqy4FHNuxu8wQtQCJVLboA4ETxYrGU1DMJYr+zNLnfpIa?=
 =?us-ascii?Q?c7v9MZ5e0jokHat4xtW8UwAzVYw9ewmDszBi2CF6n0z9nRNFYUAE8VlF6jdt?=
 =?us-ascii?Q?QkI6SuW3/lxxrCK2x9ulrXVPsqhoodiMpICUN5ZJJdwc37wsZpDtc7iF9l3T?=
 =?us-ascii?Q?4OYTmesNzsK7TFA81QGcyJjRKzNRXPV1QAqepZPAJGCKHEZcYeAd5LseotvI?=
 =?us-ascii?Q?fKR24kRu9rEliWqfQeJPDg2UyQDEDIRYDma90hhIbySQMzpRou/0ZWKwi5jC?=
 =?us-ascii?Q?jYGnmmSegd1QFp9TpoyPGzodmhfuOUZIAHdTBwWHAolh/AXaSuH4XFTe1xgf?=
 =?us-ascii?Q?N+dY4rc3vjLUcaEJYJw5/A2Sd8BL9PV6jWvpvqx1FbV/ySKqsHo/Vg9yNS7l?=
 =?us-ascii?Q?kooaD+RGimQ/p99r9slzJpqaUMTp5PZCFN7vDcmn/hIQjNPFxDIM3SNLbOLJ?=
 =?us-ascii?Q?VwAm3LfJuyJwHdPoWbdBflYgjApnPGZbBn+pm0WsTW2Y/JkfLxEn9nld3n7b?=
 =?us-ascii?Q?ABG+46ZfOvN8Y5NWYHFcw1nCm9NB9Anbwst9Q5IO1DNAirVPd5rw93MkFti+?=
 =?us-ascii?Q?JYYnB7Q6NVsina5B2hDfHoKA1mdvlKusw482D8KPFf7cnDGypUfLf6uo+MMB?=
 =?us-ascii?Q?t/QjLpfzTPz8Uag3S7XbOP9aTi2H4/nnRGNcrZfD/4alI6+AX8JCwYsyaHrY?=
 =?us-ascii?Q?I7n79XSYF7JNY+yU8D33uzgiDK0JS+xCXP/3Tb5VbRtBgC9/u5B1CrOVW33z?=
 =?us-ascii?Q?FOmzrj4MSJXNR4oSv6drgzLKsF5/pJbVl1cdYHovVWI18NkyMdRjMa/DJAdX?=
 =?us-ascii?Q?apNWHLFmRSZRjjFJWczeIeysk6jt1NlrlLnR6MOSkGDPqXsquDzT85JxWGLc?=
 =?us-ascii?Q?E1mGT2DhGxw565lpRi773O/D6YxvlDhlYC9FdtH5DPUOfjtF/kql9JsdryJx?=
 =?us-ascii?Q?H+jWZ9Y984egTDFBqGISC5mqjxNt5orLOJKgfRRcMyA0e7/1YdLR+fL6NtDB?=
 =?us-ascii?Q?Xhg99A/pAt5ljiczqgIygMKW1yu2rp3qGYt7leyWNKI/iCc6hhz0NjL7dFQB?=
 =?us-ascii?Q?qD+ANNiy10YWd3Fnr0n7zserP5bpGQD+aIzc7Qnw0T6HhakHs5P67lca1qt3?=
 =?us-ascii?Q?j+QL20muC29OQPMJ5eFeEv2DBykUsM9ut17/bhGf//zzvgR1MIomoQ0b2J+2?=
 =?us-ascii?Q?9ChP10EGkA3PZ3fgkqE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bd999f8-13b0-49ae-107a-08dc04aedef7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2023 18:33:49.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbDiBuEK1YvC7EE4VLFTQbP4/tETqV720gyecPmmCJTcGuLzccBVAz2ID8nIV8WBoRBc5J5rI9tFW40lGKMZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10020

There are clocks and clock-names restriction for difference compatible
string. So needn't irrationality check again for clock's miniItems and
maxItems.

In fsl,imx6q-pcie-ep.yaml
    if:
        enum: fsl,imx8mq-pcie-ep
    then:
	...
        clocks:
	clock-names:
	...
    else:
	...
        clocks:
	clock-names:
	...

In fsl,imx6q-pcie.yaml. There are 7 compatible string. Each one already
have clock check logic.

    if:
	enum: <compatible string>
    then:
	...
	clocks:
	clock-names:
	...

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v5 to v6
    - rewrite git commit message and explain why remove it safely.
    - Add Rob's Ack
    Change from v1 to v4
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie-common.yaml      | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index 8f39b4e6e8491..a284a27c5e873 100644
--- a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
+++ b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
@@ -150,22 +150,6 @@ allOf:
             - {}
             - const: pcie_phy
             - const: pcie_aux
-  - if:
-      properties:
-        compatible:
-          not:
-            contains:
-              enum:
-                - fsl,imx6sx-pcie
-                - fsl,imx8mq-pcie
-                - fsl,imx6sx-pcie-ep
-                - fsl,imx8mq-pcie-ep
-    then:
-      properties:
-        clocks:
-          maxItems: 3
-        clock-names:
-          maxItems: 3
 
   - if:
       properties:
-- 
2.34.1


