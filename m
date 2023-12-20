Return-Path: <linux-pci+bounces-1241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A81CA81A83A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 22:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD6751C2198A
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA814A9A9;
	Wed, 20 Dec 2023 21:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="F5ZewZ/O"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2053.outbound.protection.outlook.com [40.107.20.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CDA4C3D2;
	Wed, 20 Dec 2023 21:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF7zBrvTBc+AQybQIqCgG4Vbj+d9FYJks+fctoFI18Ioqd7LVQ6E7odxH8CFAs2NEqozLMgD5vuaHp5GWK6Bp/c4aYEvo81syiW6BUMKDQfvat/69vV6zmxkn8yRMsHq+JKkbE0ZbcT4fQsRokXUhnpFNxlfh0nKSMW7s/LLbhQeI1sLnYOiAgcZJWzEE5DAVqF7fzy/sfOP41gKkK6mLB+TvQSbMX40Wg8PdpQl5gTAs3frRqxl+P/cvhXJYw6NSyyfVF5SA3p5FUIk+zNGjyGrd4F/tD3N1KtIjY/K09ci/L3vJR/7pglJEuBwOVYYC08WCgmOUuCZmI2aRqls1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+6bkDM41BMATE8rf6K8b34570DjVBKEO4VsaZXlmOA=;
 b=Wy/ihCmQ8TfBnsppip5GvOWWTp4IJ8Dbifct9+Cqrzl9LR/ww16g8USwzNTaL6vN0g7dg5o0XABxL2vridQf+26YqFLH6qGAs8oXb92dcB41BBbVdTrcj7wlZ7Lmm1WHoepCtB2VAo8LE7tIacr/guh/J7bdm3pDG0k080cS0Wj/Xn3Eu8G9fItgEosSsfxQV/v6tvnDLIYiTUXf1EG/8YMQR3EZoQVy4T3gxp468kwv5KRCwwRGmRG8S0AzSLk9ckQaiG3BIMESsHnvPUYPC5OOqR8Tfp+ANR7xawOnxMDbJc9bX14brZzFuiKJAusbVfn7B0PIlHzcjkbuIr9uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+6bkDM41BMATE8rf6K8b34570DjVBKEO4VsaZXlmOA=;
 b=F5ZewZ/O2iSE81EmYt6D5AQ6e8VZCmkEn3V95N0MNsfFvdhhGC9ivWn38MrUBrHhhRBfwag88KkEh3tdpRui4nVWaoW263n/tk7UpdifEAuuBDx6dBgPIf9A9B4VcPAnbK0d54ZW13xHk+HJG2+7SVktrMkYVsZv+97lvG97fDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB8PR04MB6777.eurprd04.prod.outlook.com (2603:10a6:10:11f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Wed, 20 Dec
 2023 21:37:28 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Wed, 20 Dec 2023
 21:37:28 +0000
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
Subject: [PATCH v5 09/16] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Wed, 20 Dec 2023 16:36:08 -0500
Message-Id: <20231220213615.1561528-10-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220213615.1561528-1-Frank.Li@nxp.com>
References: <20231220213615.1561528-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0110.namprd07.prod.outlook.com
 (2603:10b6:510:4::25) To AM0PR04MB4834.eurprd04.prod.outlook.com
 (2603:10a6:208:c8::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB8PR04MB6777:EE_
X-MS-Office365-Filtering-Correlation-Id: 324c6ce6-830e-4bfa-0728-08dc01a3dd26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nxsIJXMc7dr6fJ99/e95arGSw9B1jU637bDLZyDtFNN4cCkoaW+Hmykq2/Hryf1+oyEbvXqeQqHdVOCbtRQYLEY/Ier8Q3VQgjP6Z12or2490rrw20469PQfaDedHmDFLm6Zn/YYkQ8sSzxbPLZHjYZgmSgsY68wpkKzcEnEUoyICmRkIedLyLLAWh6sdi0U1z7kDmwmJrTKcIQ87ul5a+HIkR6VmCnywUj5mxs27WM0s9tt4GhJm+jKx3KZPmyq+PHazG5U2pKqco3ZWnFsr8Rn5Uv05iFFJSu7/Z/RsxMAx8FAYRDJLWKJZT7D35Rq4YZe/IsiSt6G9suuNFKPZlb9v1jGLJmEKMa+t9t+BdrMQpI+EpVfG+f1KAoU3HRWsr9z/ki0EuZt5K2TfCJIdlaVYrNV+9K9uMcyBhsebLK3AVpGDCFrLYoFk3TWbfJJzHsI3cug+y1JXISYQSUXFxUKuHyUJk9LhISB1jzMO4q6rOMcr04pCoVU9lb20DkiVqDMtZCklvtpSWweNvMub4LVk1dlEFUUsBlF17BeiqMQpI4TgrKrlj37nICmLgnAZJztIF6tzJtORRhgc6bHWZBSoCotDDYGIn96F5RR6sfhKQT9ve7u684Eln80f44J/PxOGWRckaDulWj8QGn/JA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6486002)(6666004)(316002)(478600001)(6916009)(66476007)(66556008)(8676002)(8936002)(66946007)(83380400001)(6506007)(6512007)(52116002)(1076003)(26005)(2616005)(41300700001)(2906002)(7416002)(4744005)(4326008)(5660300002)(86362001)(38350700005)(36756003)(38100700002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uNgskJpM3keDoLjsnEkL3Yr5bHMeRBYGHUl3uWpYSIyG/KU14yIyWPXnd4eX?=
 =?us-ascii?Q?DjynjrXFbRlwV23wejCjBW/cFbvMG2vTSh7d5+40oLs0xIIgkDOxPJs+cwgL?=
 =?us-ascii?Q?PEKDFyuKIyfD+M447hf/7JrjLe9yVQqmcJeAUOn0UkoXm7JsxDhwPaELC6s1?=
 =?us-ascii?Q?Zx9Eyvf1Ju5pGqb4yXtYOn7yf4Nnrg79CAr31u0lbMGdWHmnit5BpKDN+ofU?=
 =?us-ascii?Q?L2JDrFpt3QdEj02cZZQdUJfmKm5neqK7PQcT6SBYpJxJsxQevR/cBlM5Zzp/?=
 =?us-ascii?Q?72S+lBFx43AAsShAXf1puCMdCFeQBwZV+2O60tkOYcSZrMfi2WT9b0/seZkH?=
 =?us-ascii?Q?eG4viZQ8ojUTBsqNF340zpaQdFCULTYnm1XxsDOLqftvDe1TLLVNu7OaZB89?=
 =?us-ascii?Q?2Kono0om1si7W4RRt5ZZ3g0Z5obojb/sRkOHshAaOge5FX7M4fwBP3wFGhbu?=
 =?us-ascii?Q?2cM8XUAMhp7aKUlMr/AyEvOXAYanxfFof+q7v0hNIhlRZj7/IaX7SLqnSpCc?=
 =?us-ascii?Q?GjDk8p9Gp+XuQSF7mW91VzF9sXEl6KAtX94gllMM3lu44XuXlUqUy/cPTAAV?=
 =?us-ascii?Q?Z2ploG2ZHXY1q182db6sTTgXQ8M2FSRZrlAykJS1lOIev0e8AQL2Rly/O3ra?=
 =?us-ascii?Q?A/ayC+7Ihk47Yzp6LTL3WxzFkg7pRivgbIipZEdg6bFznzcG/gEwb0DkvHkZ?=
 =?us-ascii?Q?f7eygZtTXHFFQJBvZ0DMuZWDeNadt2jYZ5RQslX3dvOD5SmCb/sfZ4HkvKv5?=
 =?us-ascii?Q?nGgizji1+QAZDNkfWuXpocSpkV+PxH//VE7hC9XtiugM97ahcmbHSz3glt+5?=
 =?us-ascii?Q?jfzJDTSapr2Td3aMW7h+/ctzaesFBQPxIktfVpS2ASzSm/Ge0g4aXDYpqFsq?=
 =?us-ascii?Q?izrZdRMADLYL3gAN01dPeny3R6QFZOOFRMdeor6CaIpqRMpx3LMTtkKQf0/U?=
 =?us-ascii?Q?M68hmll+UU7Am0DHI6ueZNpUIkWPTvdKNoS+fzIplDxof+bRAuUH8HOOLGai?=
 =?us-ascii?Q?epD+IlI6GE9gDyKLOAdWGNf9cEDT5LE1JpeSt6HlPkSvLIfK7JkVuywkBelu?=
 =?us-ascii?Q?1vM6bb8E0iFxJVFnvl7CGa8tq43Xhf+PlFE7Z91gFImMQCNIva4pfngSvVYe?=
 =?us-ascii?Q?g4Vh4MBGiUUVB+KdUByX29N5XCs4KhyQyCq5PGd1F8Ld+3cSaOfXpH/tBXB5?=
 =?us-ascii?Q?eepfzXZv6RUPW1NnKitYvG+RVkmyRWMzCPAW9NxqHCrEJ4FV0vyuTjuINwGj?=
 =?us-ascii?Q?HQJDvoC7DlSefqG/vE30m4a2SMPr/6/zUSUHsVAqmkjXeUG62nf50kSbUE4H?=
 =?us-ascii?Q?ulCLAuWnyd1y+R5VpoAIdA/x4jYZc65+joVlzyC2SbWctZfk3K+RkENPYW6R?=
 =?us-ascii?Q?XHdy4PKGclZJBcNVdtuaNkUr9AtBqty5sVf8nB31A21jjCEyxOMVUF8UGgLC?=
 =?us-ascii?Q?p3Dr9XdtjjNUhmpkR836Tp6rBNMhJ3b9ZjW0SKAasxrBtpFDRlENWdl+iceY?=
 =?us-ascii?Q?J0gynUoJtKy6cR5kqkUPNXyWWKXamuuZsj+2HyE//KLXobliApuArTSfuJdZ?=
 =?us-ascii?Q?GY4JeSnDKb6LXn3gRaU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 324c6ce6-830e-4bfa-0728-08dc01a3dd26
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB4834.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 21:37:28.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Gqb1Lc3UDHiqzJ+CCKNojmWeF63e/B99p0780RPgfOk1pzVL8u3htYxhnzLPefjMP7+PAHQqzJer2emQsKt2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6777

There are clocks and clock-names restriction for difference compatible
string. So needn't irrationality check again for clock's miniItems and
maxItems.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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


