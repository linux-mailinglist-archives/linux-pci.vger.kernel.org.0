Return-Path: <linux-pci+bounces-3779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3DA85C118
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26D9A1C217AD
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F978665;
	Tue, 20 Feb 2024 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DJaCvgbd"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2085.outbound.protection.outlook.com [40.107.14.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B83A77F2C;
	Tue, 20 Feb 2024 16:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446026; cv=fail; b=r5ZkwSopYWbLcuYeDkTNLw+LNIQeQe1VNhusZMjtBS7c0l6hWUD1WOnnYWpSTLwp6DqX/kplG1FsVt0UOT7Dv3E4W9Kj1J3atB8kr2D4hsNNxWGCoYBgZI/DLNPJGuac6T2VQLFsodvoIFQPjAgxXciVhaqgT8hYPxx/tS2KVPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446026; c=relaxed/simple;
	bh=T1x+5xu29RBCLNUbh74bHFYM8p4OyU/ZtMVQlC1iY30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kFoXFuN6UcxgmnvrZU56BwhXscmoB4SwSwsxlRzVBLWMSy0ey81mmwMNXQqtptLUzSDInEHKonE7VYraABxkLAb8kWbICNm5MAMSqP8uS1kk+jFik1aX9Kvn/0WDfnb0imx/MKQNs7UAt1CJTxr7FMs63N+Ebf0C89YZd8bpTiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DJaCvgbd; arc=fail smtp.client-ip=40.107.14.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UULQy2qlrcNLSKFB08fxrMs4QbzLNZznvyC5cVAGDb1yJvs1NazLbpR2iSauSUcVPtq5Dq1VMYEWUbaact+cF9XomTbVYxUGCKAhYYNNgPhoDjEMPkIwttpyt6IbePVeMERvbBOCRorGmCov6HiM4D/51uy2RForvoydS6yjc8h9y48c4WRddfxM6ziKPvRsJ8z7m70X82gtgjFceuFwDi90OR9XkWglHwtZ33dAbthZLQqEsdYLwAMYbmtXA+Oopd8ULsYn4ewXB9IQ4sxyd+BxebSh6BoMK0XMs0jWssIorttXRfhHctICkOtSil9eEcmX7q0OX8GBDZnSr3waeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zZNTROLn9E87k4rdmI3GuoHZlLbg49vzGd/L9dvhobk=;
 b=ZK/d5NcY4I63zblEtzo8rmTm1RH3ASn3+KvkFi5rs/Gdt3vz7GfCMezaQzeJkCjxSo33XJE0Uhv1YlZft/7fgs+mLwr+wN+rbNJdvLqLEu+C+LoWlfkAAZaBHMgBrPPs2vnahP4m76n1OfN/LLhN5Q1q9Iz9H3J95/Ii/1R+O1IzUxt1najl3r80fVLOhPUgSAd65nE/hes0Va9inN8H+wqgVHZhigtkl9WRbPYlDk93buYNRsmOoQ7xpZMBA348f3xttRgT6UwPyRkWSzkqwwuM46/Lcj/c7wBSLsr6gNOWM07bKNbfjXZcWmbxrwDMZVrqfI3HwWytZ3huugRSIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zZNTROLn9E87k4rdmI3GuoHZlLbg49vzGd/L9dvhobk=;
 b=DJaCvgbdG6C3+bt3fY+PJspUBIJHBnhfzptA8fljVbxdjyPafCvslxXrUT2DiVnA8ug1Q26Ftlc5mxQX80RQ4WfM1RuZnU3dO6YtVn23yM6vtvvgySkcl8S15WLFvhgUsT5ms/sLBNLWsrTMGFHrv9qvFj6NyiKkm03izW/+drM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8682.eurprd04.prod.outlook.com (2603:10a6:20b:43d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 16:20:21 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 16:20:20 +0000
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
Subject: [PATCH v11 07/14] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Tue, 20 Feb 2024 11:19:17 -0500
Message-Id: <20240220161924.3871774-8-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0cfa39f-63c0-481b-f133-08dc322fd587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9qw6oVHnnhmlrfCg+Z+imr7+DLsSGQETNWr6UVFhWcbv0WKbvK+LYt06EMX2O950kjvwwlQJccngr9TzL5GOfppgSjpLtiJLaMaDkVnd5vwcu2VAHAJj6F1kJxqpB1PGGv0O5FVHnYZ+iYmC6wwNsfM9oJFFa7PIz9rraqIgU+YeloG+3mTG6aemj7v6TayKqq1BfTHKXr7Zg+ThfxXMOzqgsRg6hrJfLQDmKoy1ZhDaF4rHwBy5PaQ1ttc2g4QhC8pOXgpVR/hquQJ0vr3AgLk20K63yJTBgJIYklLiLoo3J5saO3u2nLSB/4QyqWJsCVK52PosmARDCNsJp2yKPmMfRzOAnlJy/edJcxEDLEEntCu6cGESkDnVUEFa0TEq9SQzt6Dp9P+Whgti42/E8c+KWOEcf7XdbFcGAhzbClsGvTaCyQlgoBoIVs+fg04ZIcDbnSq6MLQK4L8nPTlDOA6qMdzEZdKwZ29Ole5nNVKSTatzVEzIS5Xxt3P4PjCSjnqbI6GYPKLzrgAS2IEmpOL4sXqBqjSnllPmCmV4fF6NLF3YrAe3DXB4XGH0JvobhcEEFyRyYYHubGd2RTplOoVeYO8HuGMp+urOzpVtg3jYvjhhw4w413XITadAOLBt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8b+sKsxVi8vyQWKDOEmiNdKX6uffz9GXuIbr+eO5lmqJjMUx+y5VUCNPVA53?=
 =?us-ascii?Q?E0Edtn7YNvSz38Qq6B/s3wPrM68tYVtLSKdIl6T/jn6QFBDeOZIgsBzauWl3?=
 =?us-ascii?Q?448SW1ZNGLT9EUikU0Qcy5QnPA6ZUPIMgODa0b4YpA8UfcbLvmFfd6+H8iUn?=
 =?us-ascii?Q?S2XpOp4lLGkZQU1JIFKRVaJkLgNFLEJseNklK+z82E0pFhjDtMSDVVByPpZM?=
 =?us-ascii?Q?YSu6FRc0YRa053Zyr8LMCpGpVBEf6oKfwdXgsRDoejC180iP2p42Z0A4AJ3A?=
 =?us-ascii?Q?uwpf9aN3oTb0p1C2+NsotLzhV5F0iQTmGSs7a4cJBRb5KpWpcco0QANHeRBP?=
 =?us-ascii?Q?P34gSNdTuvwBkSlq5X7c740X/Hgg4ZAXmvgrssaEursHBa4J6/eIcRBykuyX?=
 =?us-ascii?Q?yVeiWFVs5i9d04N5JhOLTW4f8EVdVdaliUeHJllR+gsjCwQY0gnaAykHjS8z?=
 =?us-ascii?Q?2vZ8e2aPKhmEZMdc2f9evu8Z25FJ0b9AAt2tHOR8mD4AiysiMqUjbeClR61B?=
 =?us-ascii?Q?3Y92m7SWX5yb0tgbKdyMrtQ2meBohJ615QJMPLdRN+uY2egA4MNSOO6Vj6Lz?=
 =?us-ascii?Q?9m84mU10nFp+aBoXHkmL8vw4vg0IioAmH6H1u9hwBoicjnjksLpAL+7r1IRe?=
 =?us-ascii?Q?kUTvEhi9sgbWX6zET7quMffOdi+YHNAYCakuIs4w/E8wjy9L4ftJxPBJNv9M?=
 =?us-ascii?Q?/XDPwJ366twY3Q+lbuy6fAgB20taqZC1mM33olvgsPDLG/oXz6jrzYXNWXzW?=
 =?us-ascii?Q?K69D9M8BMZBcHDHGPhsLKx2dS7NfFVyJJLYRJ77tm3CSMjB23W5I0QrjStVJ?=
 =?us-ascii?Q?1d1hifZ0xKqB8KwQykQEPj5EGuYGoPdCuvQDSy2SIo+XvjaYsxZEMN01uWs8?=
 =?us-ascii?Q?W/UjETCEio3q56R1ylnR7FPW9guf1CnNY6jyws1WNLFGno6p/ulL3/ja6Q4E?=
 =?us-ascii?Q?4ksz4WR/NEFQAk1lCh+yaorpJmjwIkpy0MHWuX0YfMp53doPQyDMdTji5xaa?=
 =?us-ascii?Q?RQ2Qp83Plq1MVXWjIUW0UlFpfS7s+MISBZnD3vbN/88BKdYdPXzATWc16Rp8?=
 =?us-ascii?Q?Hm6SCkIILClrR7/clU8oi7YBGNDWv6irL3JxMrAjDMLZ7tMbNHoB5Ep1dbMP?=
 =?us-ascii?Q?rSGq0+fLorelEi4RYH630T2x8ojIe2NUZvaSVxgLoMJoK8JKXJmLmc5nwOP7?=
 =?us-ascii?Q?rdEZtCWTVvCthGP6QFAwDvN5zUL47eSc9vd+tscLifQTTkqJWcWfjNoU5UX7?=
 =?us-ascii?Q?kEv/E3t7ZsQLLIVdwt3gcUMu3DBMlm2Vf60tIvKlm/lJMpJ5uqtp7kGi5Cii?=
 =?us-ascii?Q?dJz2WAlC9NpHZ4owa3FPpdjY4yO9BfWNXkxB0RXQKhGCoWk3m8tlMBexKeD/?=
 =?us-ascii?Q?8OOEJHUy8kg08yQIqe3dl+V/C9oIcRRVTcVjYIRaV6H5ZD2pyVt9MtQHh80u?=
 =?us-ascii?Q?5KutdiT7312Oe8pJPOP0IE2T+iKI+bHOoHrnkryo8stLB1WLCeg6V3gO2Hkt?=
 =?us-ascii?Q?la8JZC1MrygOPtddK32qCKzHuK1Bw5y6JAfLvIpdPE3+OK1G6HKX3G+iF1Vt?=
 =?us-ascii?Q?XjcQTZ1t6q0xZEbNs8b3dKTFXy9QuRBXXkHS4G4o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0cfa39f-63c0-481b-f133-08dc322fd587
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 16:20:20.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmTcztQJFVerSRvstC/loneira9rkWlmha2Jh6NJHfXR549Sb14r5PvdgfM+4aqPnJjfbB+lmCAgwspwfBcwMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8682

The bindings referencing this file already define these constraints for
each of the variants, so the if not: then: is redundant.

Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v7 to v8
    - add Manivannan Sadhasiva's Ack tag
    Change from v6 to v7
    - rewrite git commit message by using simple words
    Change from v5 to v6
    - rewrite git commit message and explain why remove it safely.
    - Add Rob's Ack
    Change from v1 to v4
    - new patch at v4

 .../bindings/pci/fsl,imx6q-pcie-common.yaml      | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml b/Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
index d91b639ae7ae7..0c50487a3866d 100644
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


