Return-Path: <linux-pci+bounces-2384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00544832DD5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 700B31F24CFA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091F55C35;
	Fri, 19 Jan 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="X/PjSosK"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D095358AC2;
	Fri, 19 Jan 2024 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684358; cv=fail; b=Eol4IuseVIH4VCqVrBn6LJcujuJSNiPhhFTEulrHi4zhL9V08uzJPWwJBMql9JXY/BBGDA36fUzf8RYDTUhTVJgSb2i8TME7REs8vLnPabQLli2ypIICM7L+q4DEJjaCv2KcGWsLispsoUBJR+EAyQAXL98WXu1EQ5DV0wYjp8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684358; c=relaxed/simple;
	bh=Bq2o7cacWoEZUdgSGI6VUHYkWXIXMIAwSoRtZZ5o9cY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYFkjcN3SLAPQ/zPPwc36UEsJJzCs2OWEVpBNAYs5d8QzlXa0B4i2PDATqoVkRTI50DYZx8QeBJvNeB8HWMwRoDZbWMixdBK95jFB8yDgd+dZsktcvE2ZKaEk8i9gB1xRbHJrq05p/rnV4MXEEFgMmR8Jaa47i1rGkXjH7oIAJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=X/PjSosK; arc=fail smtp.client-ip=40.107.22.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtxRnQ1MYkxuWbwUxiN8Jk0ZFH15T8bSIUoBSlG9ujIRAIkN+Apz8d+uiCbvd/pdsY7sQZZvPtyrQcw3IMxOjIhlBfpBQl+dtx6W6kOiKEvIY/7QmxcyNnse5hVOgJuKFZskLKOqn308h91drpOlHig7K9ZnCAcAvchGJwp86D+buCHa5wAoG4soF2RSAPRTBN+sqRaVzuthIl6b0zGMxIicAmPblWQ02Vl6PM5ZHX3igQuKEeI+Fd3Cs9LQTFE5crEfwxqMUCmwJlQZgxnNLdq1ewnaBISj00jutTx/QOjfCGyi6ypEsgwKxtXGHOSujv1BYHJB+oh5JYbTo7BkbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNuEqwnvrUxPSqcjCvVLoRsw0bm7wK8OqtVGkt+aEeU=;
 b=m+ToNA09EI24AeUVQuF0oRyIWGlKWtmw/9ZKOPZM/XpTOVatUJgxlWTg+0IUH9jQHGCEiYiLvZvhsC2us7r8StXEBkEfwz1yQE62KRJQuC4IbdhOZjZtj3TgWLYzOkdBq/RXzK14wQnz+9gg1+EG0P8yFI68PGVHPoaUVMFhF3I1wQ3LYqSc1c/h8IiaX+j4dgaJ5baqDBlFIBRDFUI1oCXfOwj9vGdRDk9QEZ2YpxeWD05ng9mNEuDuOkgavCvfECptiqrbeO1pJINVB2rpl7XbFyho6/3wyq8/rXwe33zOCIK0yweO3t1bd6kuDKo4ebfZDBMfb45L7YdSVaeLSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNuEqwnvrUxPSqcjCvVLoRsw0bm7wK8OqtVGkt+aEeU=;
 b=X/PjSosKdMT3MaxCaarFI4zGOyiZ0L4E/y3XGp0GiqUoh0PeJj/C8H7lrrjG3vLlT0mPybT2+anFURJUUCLDzptTKVh3u4/6x34kEnHI0QQ9HbNQm6C+j8WvdjRzOfijlpmWZWcubo1nuWSWX+YsjYPuZDs4BZi/Xr5raljvnSA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:34 +0000
From: Frank Li <Frank.Li@nxp.com>
To: manivannan.sadhasivam@linaro.org
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
	krzysztof.kozlowski@linaro.org,
	kw@linux.com,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	lpieralisi@kernel.org,
	robh@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org
Subject: [PATCH v9 10/16] dt-bindings: imx6q-pcie: Restruct reg and reg-name
Date: Fri, 19 Jan 2024 12:11:16 -0500
Message-Id: <20240119171122.3057511-11-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119171122.3057511-1-Frank.Li@nxp.com>
References: <20240119171122.3057511-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 022bbb97-f736-4b70-a315-08dc1911d3d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lyO5IWMaPdbWiRBYOjJecWPxXtMSZC48CgICm4XWnz19p8T6+OV9+MmfG4dOlagiz4VCIVuawK4fMMygPjgrveGcvvT0HMIbTkEsqMiUyOY7Ztyl2lpFCRZ0EFGEuG3QPXPrp490wR4/85caCTqIISKkz+tA8L6bE/p59v41U7rvK4jyCTfZOCR9iFyPHO9zR406JqKnG9LnMbhv3ecLEMsIRh5GPFLYRAW5y61NxlWtUsz8vzP+iPE5pEx9Eww4XYf8WKko5yEqmKm84IdzRSXaF5vkGPl4hNH6LzaZkOsoGq4DcBgjb7EXAUzqjlHj5aOpS83BQ2AB3inEvSYLCGXgQ5t0+/xP7IV4y6eGnAFzN6l3oWGZzyxTcD3BtXM7wOwaZG5Jl+NLAbOH8wPVSG3X8MkVli56GK0dXQgBXzeqjJbzyyVO9ObCPEDV5A5sKpKSYP86PUc5SgnGZ6DvDTxGdpqFYSL07yaaDEITW/IHf6NbbfDJnBvXAbFsX4OXJgMFejUYsfIXvP0t5fsIujXOYITouut2YqTk0D91J6+04bqJKFSZArX5E/Y6wG/h5mSG3SGUAzvob4808VJTbQFA2zyPebzbVycg4FwIvqecaBjnSWkRHMHA18e8WNujqtrkzo1HnpkN5ETe0KWWVQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gQUpUgsXu4dE6d7Yhv8JNVqFMT9lLeSea56PV1J/zUJQhjy+TUtRmccfHSuO?=
 =?us-ascii?Q?FBcr/zTdHk+6R8Sc64RCCOhmZusHKeO7iuZMWkPl+VwXAtJAQ6bFfAWtlD7j?=
 =?us-ascii?Q?ss2DM1+P48fNX3uF7Ni/yQpI1iCO5kyLwAa2bMt3g+xu0Ms9o9aWNZQooDz9?=
 =?us-ascii?Q?RV95OXS3ZR8Q0vuCmUmMXxZyS0NPiAbpkKY7w5M0B6cS2vwzTQv4nAQZMgUd?=
 =?us-ascii?Q?ov2swhcMaXpyyJXERCAA7WQE/PkN3oEYJubvK3CtC5XFQ+FKAG8v6ejemCs4?=
 =?us-ascii?Q?z1LWkJNqvRQRQ/zSaKaFKS5IUAhepTDTfeKhH/EisxZU/cXnm6xcUq4CFBxM?=
 =?us-ascii?Q?Aur0Il8xkvwEDUHIZPHSeUrxl4LYJReYeRsLphaFstrD7U3ZHSSoVbxvlW/K?=
 =?us-ascii?Q?YNtp+p5BzOaWMH+B3OFLnJQSHUKB5SrTmy96CO5glTb0xMEvW1CeTFH9Aou2?=
 =?us-ascii?Q?URxIE+Flh+Y2a2RkIyXM9ArxXoKxMTyzJcoFZa2fUUwXkSxd1PFRmhTFhvog?=
 =?us-ascii?Q?v78Bnh2qa4tGu3Ux+oMcOMyxax9ENtrRbUSGXuSQNSnFQEgl3DnGFcmunVVo?=
 =?us-ascii?Q?kJlrpccwIOzNdEjR6eNYjt9BuZtsjK6nYtkULA9wXGl16/HzyrQAQ8CKSrPG?=
 =?us-ascii?Q?Hl8KUmwINWKjQIoEeCWcl9eFmw/vCtwX+21k8xxcoeHaAkgjnf+5QryRUbc9?=
 =?us-ascii?Q?Dz/VxvvZnrRla2tzYcsL15GgSwMH797velzyM9ZexXwzMpaSdk/US9xo1dql?=
 =?us-ascii?Q?FL09to120DJchS1G2WeZICqNlf0gF/UEWVabQTRdLE6OU+l+tsgX2cl5NduB?=
 =?us-ascii?Q?pPMXYQcC0CHqwOZNukuKfq6hdd1yHU2AufwthqoefBuebycgfvU6w/37XJX2?=
 =?us-ascii?Q?HPI6ogqq9QF7fjvQACjxxkXeTPLJvleYNTyHfz4H747iOwb2C09N1WbDX4Gi?=
 =?us-ascii?Q?u7Aj1ftzCYpXROvmb2yOkIZJVfK+6ybf16Bdag4OX2E5onYa7g9bvkxStvJx?=
 =?us-ascii?Q?iroCYI8safWV+24cNzAUWO9lkil0NwZbC2x+3Yg/ukCViRTJ/Aa3QA3cbpaP?=
 =?us-ascii?Q?ZUnl0THt3zkpXZifWtWZd0HwQsH79O+JznqdJbn5lZm4pWUDXb/vr3HnGzt3?=
 =?us-ascii?Q?4zgS5+kyesZe4zUNf8cyZB6XWXzA70ia5wDoIkb6PVhboOAXRbd19GDUiTQA?=
 =?us-ascii?Q?rpu/6yVuUseKmP1D3dz6H2LPRg2Gj5Vfh+r5nFyKk8dJ1OT0HjAH6WTq2n82?=
 =?us-ascii?Q?tPdn+ZU7bG91bgadiUJbX//otfTOGwqtlk8FeA1EIZVis51ZregFbty4iHZX?=
 =?us-ascii?Q?8PlffMjdoiQAk5tH8NE3yTBmW9DtjkhzEN9dloN6HyIIkMODUzVe/8XK10eX?=
 =?us-ascii?Q?ko3MUKYD/lLuWDro/zbHP9gW9tqVH7MDk+qteIk9aHomE3vYOkZfj84ayQZh?=
 =?us-ascii?Q?QsgIKN2ZO9cPWwkZl99LgrmMrCrTJqOSR+325uavfVuccSG07M7dhpm5CNGx?=
 =?us-ascii?Q?7IpGTEKUXyh2FENGczhIqT7x0PdYkMRESmp7PbBa/PmikQ9EuzR9wocKosuE?=
 =?us-ascii?Q?LV59Ydte2c3CA/T6OWE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022bbb97-f736-4b70-a315-08dc1911d3d2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:34.0015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jc0WJ9DaBofutQanL/R9IhHsr/AQ40NgMfCkfVs/kcdcDeweEYaNFMCgT0fvV+GauoJGI3/YvkP5erZ1+Qskyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

snps,dw-pcie.yaml already have reg and reg-name information. Needn't
duplciate here.

Add 'if' check for existed compatible string to restrict reg and reg-names.
This prepare to add new compatible string with difference reg-names sets.

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


