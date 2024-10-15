Return-Path: <linux-pci+bounces-14539-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D2F99EC1A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 15:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07E61F2737D
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2024 13:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC071D5AC9;
	Tue, 15 Oct 2024 13:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XWbyL3Ss"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2050.outbound.protection.outlook.com [40.107.241.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23B1E3790;
	Tue, 15 Oct 2024 13:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998029; cv=fail; b=eOL5w0lTP/1GK80GstfoYTHOBPm6S67L90X/gxCWd4lDFrTpTv3ogmOiOZNmlyuAxJiv5I4J01XYpF/Ae8FMffPoDfNB9r9XoK5NcNlHT5EVp8COuNr1XXiGhpaNXJVuqa1zz193E7DHDrhJS7H3qoucWF+zCCJNS3jAIx3Vpc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998029; c=relaxed/simple;
	bh=vOYt5pc9CLUk9g+61ym0JlfJ5NQ4N/HkRG2V7f0RPDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q+GxQGfDVWGt4zYFiLdHng1z+WXTRBZiHE1lP3GceN3JdpGi2Vt7JwPTR1o1cmBjc5AhSZqL4LBtYQbBeoeyCyQUPmlcTpL+jB/HegpSAKCK14J4s6e8zxcA6SL5KstuF/VNDZ/zBGjIITqTQc6UY9CdnFj4Hdh5YuP1YeruOdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XWbyL3Ss; arc=fail smtp.client-ip=40.107.241.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5hmET8RNtvKNfRzpfdYJHGJ3ICMNmrTAuLbWA/+SWR8WbsrEdTPpfI+BhdWgtwWbDGfFlWijnEx9XzqSOxn1WQVzqhTDemm8UGeVOL5kflXDt2K4URAGyTndPiioD+7IGyyJ2kRHO8mKWHwBKt5JfH1wp8TItJdNWTkgaL3gMrsRSIIj4dFwSrZrWpSU2StEvsJuv7YpvpDmVjR7YmrEy/GULKaujKfAqVmIwUB1f7JuV7ecQlm83Hu+ete2Z4sBShrvBxaJNg3SkPhgd6ByYRNKQQBK7ozU1e8HBc4gGZgT98JRxDjuTGcYlQplHO9AoU7FQxC+elHr2WxvQ1eBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpTDZ8jdwDxlJQiNlhbG3oBSIEbo9cWDP/D0msqeQlk=;
 b=KPH9BgDtaYDAX9mGovH/ri3//MknwmOylxTWHDnEEzdcSFiDc66scmQ/dxuS5XFwGoF6x5Q+hdX0R7hxTSdPN1WLnlZBvkzeFJ1S/GWqQYye9HyvuNMcBxCjtxD0i4+CA3Vy3qcnpDyP5Z8gDL6KQSlLpAbSnzINtGimwHeimGp9jPj+shXnR2M5cx0jEvSPSq4iZDDEObwSLUSxIKH1XlhSXbIbYKpyzyWOcNNRRE+iySnCptvkitUm8ARw0JhrTB/Z9tT2dpmWmH3RgqhWTqBIyLL1rFJh4r527CNFztOQQA0r+l3QEkbYdKJae8eIOjhSAcIjAO+unioPYPApbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpTDZ8jdwDxlJQiNlhbG3oBSIEbo9cWDP/D0msqeQlk=;
 b=XWbyL3SsmAw/EWIN3BEJBsJjc0lqfzXqXMvv+BCVPgzAiil91wSl49Xn+CpRRGqdWThNNLHcuRUPkfD4mBEp0CrkuOZ7zhDZXYDvnEPxFregTPmxcjH+QQFHqX+yE7HLKEsMRduwYeXda3382zU6REzvpmewpE6v2X/OETbvRihDR6R2sJjGO2SnQKd57SI055dxfumwn8MNd36ngrTyCFWnizV8bNG/dxN237t83+S/HyUVTC8pfBQbp8S7R7NvfSxbsmnvhz8bSUT3a16jo3Af3SqvH4XxkSQp4gxPg4Cz4J9EKqDjSEGItslsOyrF0V1CxNS8vNiRknrjI5ETKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB11041.eurprd04.prod.outlook.com (2603:10a6:150:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 13:13:44 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Tue, 15 Oct 2024
 13:13:44 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vladimir.oltean@nxp.com,
	claudiu.manoil@nxp.com,
	xiaoning.wang@nxp.com,
	Frank.Li@nxp.com,
	christophe.leroy@csgroup.eu,
	linux@armlinux.org.uk,
	bhelgaas@google.com,
	horms@kernel.org
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v2 net-next 02/13] dt-bindings: net: add i.MX95 ENETC support
Date: Tue, 15 Oct 2024 20:58:30 +0800
Message-Id: <20241015125841.1075560-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241015125841.1075560-1-wei.fang@nxp.com>
References: <20241015125841.1075560-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB11041:EE_
X-MS-Office365-Filtering-Correlation-Id: d7545c66-953b-4af0-b9f4-08dced1b3226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cb9e/8kzX7pB6GsgvXxa75PL32RZsfPO4Oug8onUoIHmUnWBPc2KshYzy/tV?=
 =?us-ascii?Q?IQEQteG/SO+x0wHfLxjKKiDP2jj3wDwTnBg2tgjX659FWrahn3dB4qB3pAW2?=
 =?us-ascii?Q?c8ACwsl7707wy3NvRSuNq2CW2Q5AI/8ToH/WXIexUbHHo7gdAgUkmeoNrqUZ?=
 =?us-ascii?Q?6k53y8b4+dmOuuL/sgHHbu3uGjeWjIPy5Y6J8/CPUHZLPqVoLpAsjlXJ1QkH?=
 =?us-ascii?Q?47T88MycW02Fse8MJ/GoqGWGyazYdBJKTtSbNPenZW3KJc1/Xiu100JEAHZk?=
 =?us-ascii?Q?FpJkPlNj8phRmZQExFV5RmYs54BZ3ARjlO6QM1mSTErs7spI8dJvWcNWMTWY?=
 =?us-ascii?Q?2KCGNYbNezY8mCZOeeYysAI9vx4/oy2JCxl3jshoS307SpAoatMsuqldXoR5?=
 =?us-ascii?Q?EPMTFSQSiJXyZXvluUGSyNGoUKDqUWqsDTU8HA9OOZvnAtXtuVtxrfpa3J1y?=
 =?us-ascii?Q?XvQFjjUuRQCYfkL4f6n0mN3JlkDSxsTIJqahdkmWgG+M2wwW2TbvNoNor36Y?=
 =?us-ascii?Q?PsFSID8Od7FoprZzkffoLq9SCPAAxQLAleQs+VupogUNj97GHTBsl43I5R6w?=
 =?us-ascii?Q?8F1RIH/wjcZS3FQ0jWAW3uE0DYVQLSkRiJzlNVjZgOn2eHOjU4TeZr4ws78S?=
 =?us-ascii?Q?fsQ4RqlCT435sEM1MWWIeMyS/J7R7nsgqAZ0CvNWCj3gTG9OHjYGdeZiHcQB?=
 =?us-ascii?Q?hq0+DUE8X0HkOd+Ek8/sfN5pIcl2P2habkjzAX13EodfFrOkPUQmKOt8Wrqo?=
 =?us-ascii?Q?VDN6cRmnNwda/IfhvKfhVr9R7cnt6Wo25/x8/ncS11vdBkS+2U3Dy2XjEQII?=
 =?us-ascii?Q?cNUdug625prQFVOKlJPmXXFoVJ2URIOy7Ig9zOq/T5bmCaDN6YuzFeCbu4NJ?=
 =?us-ascii?Q?7/x0gqb4DtpTVEir8YJWtvXf9wWcIYyTHS5mTIjVFBPeo70SPmfng8rVUMvO?=
 =?us-ascii?Q?B2zvn7YBs6J7+R1g0zsvl8ZPnNZthDB8wFklD4kYRZOw5S2a9Cly6P0VjBVY?=
 =?us-ascii?Q?NooHE53OKFmCCUEdtI99kTH7XWyH4LP08LtTP+p7pHUzX/2pMjoCDFrlwAiy?=
 =?us-ascii?Q?amDe1hvdXxmTcNghRvZjrbK+N9afW13RNyejzo5Elmpkv6aCx5QEoK2VHMpu?=
 =?us-ascii?Q?RfQUA8GT98+HWyP3RQPu/jmdVFYsgpEfnPgYFk8yamUc+cgJLwI36Z1HkbKP?=
 =?us-ascii?Q?Xx3/eO3pk02scEhTWVOE3bEihxCyp6RlLeFOH3L5b1AUixb1N4BY4e5ukwJe?=
 =?us-ascii?Q?fMhFUG78yFA1/0uOBPYzQlJKRAvFodM+RFcsPj/VFllzelGCGNokIlASXOKd?=
 =?us-ascii?Q?EM8X2hUs0OE7YcQ4JKTgvdoENS5W4D+OPIHHqGI2Gh2WEHIhQRlf1CfE4YdS?=
 =?us-ascii?Q?MRFzmhY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LbhE7oDuQA9wwmeF1ZvxHJja92ul7ZYJTM8yIIfFjvN9CphiRks1oC47z14y?=
 =?us-ascii?Q?M7D21GWNHM0kg9VWZlaDEB70PV54tlJWP/VAJMHOexvHErt8w8MzzoV+B+tk?=
 =?us-ascii?Q?5cEqnqP33Fck/cRAm7TqXvORIsbVAVfnFMDMUaDkwmeX6zRiQqinhzOARtjp?=
 =?us-ascii?Q?rC7ZKMav1vAY0dTZI/SA6QV0KXsxLbR1cSuaaIovgJX+xowvtABbHEUrud2r?=
 =?us-ascii?Q?H4uklH/BS+AUq/DtEsQ+v9UhyFo2yDNfG54pQWW2OM9fE0LiNUszRrz5LExm?=
 =?us-ascii?Q?COi0T2HHGngCzo4LPxKZwau4l2cZrU6yjdjxjUPuytuFvKCRGOksG4gntk2e?=
 =?us-ascii?Q?ffEL4XUGv4m2o3LXrm9cK3nx0VKeMF+RPgO1YVYT3BOBqCyp69w+nv2i/r2o?=
 =?us-ascii?Q?VMOAhHX9WlB4e1ukCTUfz069AKe3+FLzb1ifDfGmIIKo+xxUspxlV2t2dvF1?=
 =?us-ascii?Q?kNLjo4LoV8on80V0Q4fnSTA1InOBYmwCzKxt7lGUaRRyoEMv8oQ+rqp81jjm?=
 =?us-ascii?Q?xP5e3tEcwDgINcCP+9fl8zkLxqNIfsdX6r9QMRsFwUMLTmE9AmtyvWBtVOeh?=
 =?us-ascii?Q?0LX/S/WaSyK7fTdZIe1+4udnClmQixd9y2/Y8y9qRf94tQRf0YboyalyG+F6?=
 =?us-ascii?Q?2TVdUAUxYYMPzUSGtSRwmjDLHnyy3rfu0wbl9pkoSXOkStAcHJh6ZGMMSxSA?=
 =?us-ascii?Q?UYiV5Aj4cP+vHJk0CBRb7TRhZPeOO4oqANXqmCpy4k/R99dZDnDb3dV8uGx0?=
 =?us-ascii?Q?jthdRyiOrTHzhNuYFITUqNRK5G4aOCCE7F7Ouh0CB8cPBfT+BVpobd/XZvJv?=
 =?us-ascii?Q?+p8CebOmFVaUr+usw7wFgOXvjpjghR8jveUugiqpyzSFSZBYw3LzS9n+VSaY?=
 =?us-ascii?Q?7MASWI8gfLqRvfRrxNZumrg6NO3YpWjbWNJD28nKZ4IbOSejCkC2uCnthykz?=
 =?us-ascii?Q?Ylbb5RGboz0CqCbw6FMNvqmcN1+CKV8jsoNRmT4ZHzl+zutr0+L6x8zBA1Jy?=
 =?us-ascii?Q?mH3m97WOnAi5geymgP5HDUXd+itRTlQrEfWL7VgYnbB6OHvQNC2F4dwvw1Bh?=
 =?us-ascii?Q?OR8qGFrMYt1ppaMlCqUpOOLT/gqBp8AgEp0Bs+MFwO1+NxBZ4fzEjR6V3Wbq?=
 =?us-ascii?Q?R1iPPMKBhff6N8OdO4KUSn9CSeoNgZyw+v0bhDAYX91EsB6kIqeHX/aSKATn?=
 =?us-ascii?Q?HdmPGGmDtbm3Pt9Wv5RqFNID3q7+5zgqYH0MkP+jJQLC/X1PVBnoTTEAYNDq?=
 =?us-ascii?Q?Wm8mC09XHKJNq9lbYMolI4B04jumBKjz5lHKLmAfUFrSOjqRxm+nKkgJwsIX?=
 =?us-ascii?Q?wHJ8N+qjbalaL0BNfqgDEeQOCJ/miTNankSNCJbByeOmwOatEcMXKRZCfw6d?=
 =?us-ascii?Q?YjSbVqJB7ZnjabGZvr4Mjw6lZ/m7s+iZXj3+o3pgkZT8p7aPBZk1QQODg1LX?=
 =?us-ascii?Q?aoqfvrftBiNBzORGz8H3RBChVwLobsoQE8A8aoNQxdcrU442k7ETsxVMJncK?=
 =?us-ascii?Q?+7p9/LFp1e4NRA1XncPUMg2gLurZrjyfB8oayUEonOwRQtzt0dplcngk7l1o?=
 =?us-ascii?Q?95aKMBBgWXa56XTPY59IYTiPCH86sqjxJcVFr4uf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7545c66-953b-4af0-b9f4-08dced1b3226
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 13:13:44.5878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q95x7SdLnAB5gMGfta04giP27HvnYMJ1S7QhXS2ziGRJNiLb/yMvoqux4HKjNlVw0DNoMiR4B4uNRl/Jg+A6Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11041

The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
or RMII reference clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2 changes: remove "nxp,imx95-enetc" compatible string.
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index e152c93998fe..409ac4c09f63 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -20,14 +20,25 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - pci1957,e100
-      - const: fsl,enetc
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,e100
+          - const: fsl,enetc
+      - items:
+          - const: pci1131,e101
 
   reg:
     maxItems: 1
 
+  clocks:
+    items:
+      - description: MAC transmit/receiver reference clock
+
+  clock-names:
+    items:
+      - const: enet_ref_clk
+
   mdio:
     $ref: mdio.yaml
     unevaluatedProperties: false
-- 
2.34.1


