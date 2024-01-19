Return-Path: <linux-pci+bounces-2378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C11F7832DC4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 18:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E38EE1C24694
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 17:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3755E5D;
	Fri, 19 Jan 2024 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cWwVxj8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173656476;
	Fri, 19 Jan 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684328; cv=fail; b=Vm/Us+uZnrfT3z1aJx498tPznoAqSAggUeCs8O9818nbAs3M1qBdQn0BuO4WBaqEPEXUYGSS+EwxTP/RsamyQutajLzqYJthUwFggrCU3G+bDQfxhgLDXmGnXT7JQqXer/4hON99mSU0t/nMlNMw/4eUY3qfCDFt7H/0e1mFJnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684328; c=relaxed/simple;
	bh=FNUfEU2NBJdh/n7ePbKkcWgC89DpajZR7gZ+IIFZvVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GdhvWShC0ZhqDISlD3wCLvd49bL8oIupVFjcAwEj1EEUjtj8bN+VUW1P4zELTwC6uS5qqVw4+C3OrGgHckTZpFe0gpQS81BBZLMj33B6ZgOCoOm9C6LFk/AHjkVg2qRs3F88vR+zVBcPbQExW+FhRr7mwInCsaY6KE2COHJcpFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cWwVxj8I; arc=fail smtp.client-ip=40.107.22.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XvRlYIGOliRt8QJT8Xhkk5U22FJbRymvelptUXtJPis1/Dec4LSdl2dLDufoET+YF1uMKTr+rQV1tiExAG+kizJPBQrYi2ltqBctVn/QrDSM1uyXsxmNV+P+wyavmtrXiOJdjwk/8ptI2CPn5l3J2hg/1rsrvR4iZYENG53FXF1xcwIW7Pwk3wq3vGtypLZDOTxzwsn63u15fw8xNafTnDTcari4F63xQa/7nDgadaxDCRfpiFlcpS8bLiWN8gscz6t3OOLSbMppX/a6+dKw9CHRGDvrf+xJX6/jqNBG0lgP2trT79SqudYxp1w/72dIQCgs9Onvzhm9MRFQByV2AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoxR+TinRacNV4SkOVSqNvChWq7u+ai+t5XxaquMaNg=;
 b=IwNwQFvfPBk9Rys5KxHPftxgDzlJ1Xe1kjR+qE3syc6JNDYOyUji5MIZIH0FxQD4tbeAT7XlKqxh/AVT8F2GrSp6pWrHawP4HvtGC/v8MVqK5zh/NgbuQ40e66PRoe47Ws4fkQsPIbO3rcixVQ69qfMXgMtD1+XmAR+MhF3FDMk5M9QOsFVSpqyfgb3d7ImxTgDTET7QCFuiEHMnZhVaPh7aM6/zCGbsjqFvL0nHssAlJTYhzRk5Gi3ZRilDl+VTwPHJmuNErBVgeIUMIkzyLjCRKf/vtJYHa7RSHfWqyj72vWwo5bnNoF0ZYMOd5W3OJoXNRTlG1bldWKm1lRsjtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoxR+TinRacNV4SkOVSqNvChWq7u+ai+t5XxaquMaNg=;
 b=cWwVxj8IXC6n43Itwf2FNzvhUSMSbYjnzA1dSt79bXePSX16qowUanX0s+QJ8UPzkDINXaD2e3NsENXNgJ8xp04IGNIG30mZl3BR0uEmAEFcCy8EJzqY5B0RdcRUsJ8h+D4gGNMfYE0OlRvwbXu2CYVFhJN/FIu/ey50xepadAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9688.eurprd04.prod.outlook.com (2603:10a6:102:271::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 17:12:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.020; Fri, 19 Jan 2024
 17:12:04 +0000
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
Subject: [PATCH v9 04/16] dt-bindings: imx6q-pcie: Add linux,pci-domain as required for iMX8MQ
Date: Fri, 19 Jan 2024 12:11:10 -0500
Message-Id: <20240119171122.3057511-5-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: eba96308-f15d-4715-9e82-08dc1911c201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q6yUAmn/mmeVBiHZn8J9b10dovPZJKbyPCWdQ1eUnAcLDxu9MIPJGiU36Q+kgYXPyHsNb14a3fbruaSYYlZ8K3tmwyAdvV4lSjt4Hd/5Hud0MomO/DkSHfLAhyzMYCyH0P6Z55kwWAkjlDR2kUTQGD2h6q2X7vxf4w/a2iW+YJtugD3mVdYRXZ4b0anurJZs25DwVVEcGZHEuMbCHhFykTCicfiZS6swrJoJYN7o3zHrwaxyQ8cvHkGqLaMtUre89AR+78F3ur8r0qDIHYweSzR2/S4WpGwGShUloC8hf7yYkWob5UmR1OnXOfV4k/mcsPhjEbQI2ezLt4zp1AYGfB9+b1cYObTJg6hpJj84Qy/0SJYo7rdI6yOJ7Rl/41UILs25EkPsyTEfufLI6sEMQntXAE3x3TNeyWFnFo9bQnfwwaS7iZhM6kTbd1RKDWBx/3+64Z0q7eRnecVHPXQCohHDrIrOcrs4Nw64mbpJ9dEGfUC2iLw80TDYZgLzOI38h2yDtikZJ+7fAiJmiM0yHnLfSkVd6W0Bs+V/h37UoeNTN09ONsp0/m0Qev5lMu7bn95Bqb2M+ZoV4YUR+Luqgesneb9IUhLt9eWdQHbbRFUYcwVqmOoryG8S5lTsZ5258qAxLLGt1ZVqiaihU2gAkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(39860400002)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(38100700002)(6666004)(41300700001)(6486002)(478600001)(6506007)(52116002)(26005)(83380400001)(2616005)(6512007)(86362001)(6916009)(316002)(2906002)(7416002)(36756003)(8936002)(4326008)(8676002)(66946007)(38350700005)(66556008)(66476007)(5660300002)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JqhHZGE9wxfYfK+P3CtSfw8ocbw3Au9YlF5QpSVh3MmakmobI+wlCj25ZnLu?=
 =?us-ascii?Q?CyvMjffKEP9//FVxkat8a5hYALeNK1WV4A02IHouyPlkrnRw5SAp3NQ0RTH6?=
 =?us-ascii?Q?XMxAm/HRds8LV3aBgLzfJ1QbumxoywrQER3arY3MGiyjYqSoh7IKOsFwdgf6?=
 =?us-ascii?Q?44kfhrgd0aZ3xTZbzls4g0Pc7KTZlOlgrfIbPYdGobsiohjOm6cBNFUDm885?=
 =?us-ascii?Q?5wCY6OTTjq/ju/CgoNFcp+r+5ZY1VMhqTFxpy7MR4mG2t0A1WUa989TJ/x4d?=
 =?us-ascii?Q?QRhSAA1SrcbZ71sJMM83eBfyQpivfNbMo6QLSReLJk46SvASx99P5cHbYiVw?=
 =?us-ascii?Q?35r0+J6zevD6766YuO71KksGP3jGsScAXtMhwAmomzv6qXBXiDa8wUnmYnQg?=
 =?us-ascii?Q?hxh9o6yDqGGcP8/StFEH1TEnIXckhwoukxvZY1qpp4GFkxbu78B0ajYwO4om?=
 =?us-ascii?Q?KPJ3LT+GX7KYGV3KMjkk/7VtuofC0VKA9rzyWQkwaFJWlCnY1jOXfVhidodL?=
 =?us-ascii?Q?MOvoedlpip93pVZ3PRA0LPylgNbykxKqvUDxYWTvWLfB7Zm0Cd6pf1FlLv+s?=
 =?us-ascii?Q?IwrWy/SxjzVO/c8Y5Q0nQ0jDLWhUTW0+DI5IFZH3wbspN0s/ThZoKLqqpcBh?=
 =?us-ascii?Q?LRtIQnyiiz6iAPtlaCSTtpLXoP1e/NnshkzCoUHKbpIiy7AZv/AlkAgs02pk?=
 =?us-ascii?Q?E1WgqQBU1X/iWtRSxeqORkd1ZUxfdkJDeuyVqfYGOFhfux5hf8cG3bEzMlEs?=
 =?us-ascii?Q?V2vGSHQMMLO4UoeOqSl5GbMyg1Qwnd5WvyoqyjWd9BUQSBWQaBlGb71HBu3U?=
 =?us-ascii?Q?CNAyFaBI8O/0hMpAhUnLMTHdqKi0sbf0+ZSJzOyhBgrN2SyjXWssLNiY99B0?=
 =?us-ascii?Q?5SbNJU1iIWbajfIAXlASQ0gJb/R9/jw+YvW9l2vanDK3/0MEBIOcsX1uTFR2?=
 =?us-ascii?Q?uLvwm2rM0WRO+HgjseS7JTkoL3HdTyOzO1rBBVaeNWDcRmFeFxAu8jNnbAzj?=
 =?us-ascii?Q?rGd+xc1myJU23sNMKEoEHovH539Wz8gLrF7XspzqzjlWiWNGdoP5VK7OUEtf?=
 =?us-ascii?Q?6Mynv62UQp0OKnJwzzoF3d/VKwdmen6sDwU0O6mONwnxgADIYEro/UGqwUWL?=
 =?us-ascii?Q?MAW27dcYvv6IDEdafFmzHbyuY69Mwa9fGrP4tr3Bj40hbfS0SnTOB9s7bwHR?=
 =?us-ascii?Q?MYlleNYt6f3oBqPaYWBemC7zoXSXrOXWxrGegaZlZUxCBosHHlaxmt2G0kCU?=
 =?us-ascii?Q?n/rJXLHWLjbsg2UFHcBbB2/vCW6ZgIQjfIBW/tYn1iekqkGArnxIIndvdFxs?=
 =?us-ascii?Q?7gSoIu7kj5+R9msJIvlLivH6LZ+7ACaVilKujsqJ2vRt7ewsaoiMNY+OGu8c?=
 =?us-ascii?Q?fTnRoHj+k7ooRt447Hf0W5+jl3O2sJ5GrBlcSQrIAiPuY92uSo5ytlt54/AF?=
 =?us-ascii?Q?nVUjBiRv38EeL43pSjz7MWGgmIuTuCp6vD2qo9O2Bcn4/8ho23uyJshUazvc?=
 =?us-ascii?Q?9Fni/nWRjoHzYweDS1sj8HB4ck92o0fPEM8xr8emrLTtkIkVOCpKTdIG0XW/?=
 =?us-ascii?Q?LMauT1wSmbKYYJSHP7w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eba96308-f15d-4715-9e82-08dc1911c201
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 17:12:04.1627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmNWKnRiyVp+RCZWXPXeGPonFoCuOs1IzRjXKX+6mTSOErcERvjvAMNXiIcgoCJp00fDmMeb75Pr6KcTW/axQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9688

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

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v8 to v9
    - Add rob's review tag
    
    Change from v6 to v8
    -none
    
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


