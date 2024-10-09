Return-Path: <linux-pci+bounces-14067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C808499667A
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CC2AB26A8E
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A118FDDB;
	Wed,  9 Oct 2024 10:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cR5RRkq9"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012036.outbound.protection.outlook.com [52.101.66.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A60518FDC2;
	Wed,  9 Oct 2024 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468400; cv=fail; b=sLb/WyBbSoBf6fXoDoQfejekjTkCob4m/5c3vYqgDG8tFBr/aa0dSHVul1d3GZDGk3okmu06IXoWOOaZ1/+AaWBJhwvEq6GwdPlCJs5kueR+u7rcXHUDWkMDuFFNIj/Kk8qj6O+xhgW3TlXKyFIels+h20L1Gp/NRv62Qrgt2Wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468400; c=relaxed/simple;
	bh=CaWyKiunnXGdynJBcUs/O/rlLyQZ7RwbB4yRqWomEXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lV7uy/bdj3EWRYBHqHU10qWKfj2+kUvDgXa5nUCkf5L1uce7pxH+slp+xzyRm0SxPaUY+gfkMGcXjwCM8P0HrR8fOV6cHkT5HgkF2uHGwBp6posxNEWVrJpZAJX02jr8zxN6igQu/4ApgdWf4uCe1rNL7uHGbWh/OkzE4WA9Km8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cR5RRkq9; arc=fail smtp.client-ip=52.101.66.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0iQSghrGW/3OO9g4kJQ67QoLplkn/ufkAMqL+0ekgRX1XlpEcrmXwyWagKe4fG5K+Ml+EIWQVavPj+tDhSrGiH+th2Vm8n74g1eIIdITkmQUpVMv56EsCf9gOofoo/u5OVlNFCSuMUqd3O9QTDQ/wnV0xXJR/+kSIblk1bFJFB/TJr02kXj84fJhv4vXY9/zM5BvU1dDeLRBFk+1mEQQwBnt7G4wzbLB5LuWwWgjizhi5PGdJAWpL39FUOFY/VyRVDyPgjsVzdOGRqnqrO7fmvJjjS/EDHTCgL7+CTVPE9l/W1S7cNiL56NEd5NvF7PlELa3fCrRMlHtaa7pHtK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJN9lcSp1kjVXoCCjR0SMfer9/CG6KAkkvc50/LCOIo=;
 b=SNjCaXfMXlsYZBrCzb012CqFgNjm6Y2w7sB9DSPM5hOw7hbGjF5i3Vb8NkLFjiN9SryIyIXQrgKMqVCP052T96QF+QQKw2p/1UQ7f3Io+Epe8FytCZQstkjiW0zBIXpleRN0ncloFzEVAxWiI21ASBDv8UDTl4iPnWWTDxgFV14Sf1beMhabommXKoa0HrzhgZxK0Agh5cbjUAYTyUIbx471vce4njlZwHV44VFRSt3eJMhUsE/sjk+ziae1WvotaoHJ7kGvNrMi+Q5MJ/XEpO8ygfOizTEF0B4+y6ox0rTluW+ggThP+IQt8z7fZ+ccW0oMbJiPcMT2hMq1mKKT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJN9lcSp1kjVXoCCjR0SMfer9/CG6KAkkvc50/LCOIo=;
 b=cR5RRkq97Q0rgZ5+GBVPmVcrsi2oaaU+5DcCcTJzICoZf+h+vboL748i7sxTbySkIcOqyRoM1N2bJlhCuxJx2Kk6Hj5aIDXn2EhJ5wxxIbQ2+sYrxVlVvAd2TVIzJaua5myG/zGz9QssUNtXZUxLKry3c/yzckdzcYaykaezMs7UibkR21DIX4ry6OslORbr5yjkxqrkGpNknP7yDGq7mSMUNuXsXuqXLdbgVHkWNKXAIAkAtP5C9H4QWJmVIOgIJ+3Dxj5zzIVKVidee0+HjufRlvnDc7FF9Wvw0h8Au03Mptbj7kPkt1sjAgq3W7XRXA+XLI04az36Jxtysba10Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.24; Wed, 9 Oct
 2024 10:06:35 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 10:06:35 +0000
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
	bhelgaas@google.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH net-next 03/11] dt-bindings: net: add bindings for NETC blocks control
Date: Wed,  9 Oct 2024 17:51:08 +0800
Message-Id: <20241009095116.147412-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009095116.147412-1-wei.fang@nxp.com>
References: <20241009095116.147412-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0175.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::31) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAWPR04MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 179d701e-1377-4934-8e98-08dce84a0ea3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJIIS38jXyKtNSc/bDuoEVUOEt80B+FvXN6GgCz9Xd71WU//HRJzoC00v942?=
 =?us-ascii?Q?I45YpDO6WEJjMkDobjudSJdDEvd1DZDDY6KPwogxFdIbSLBS2Wu+63ypd15b?=
 =?us-ascii?Q?+cSJFiSuHjQ3IR6WirlHzqE/l3gujkXiOZvGEORZMoQ3RDIpVO7SVWRz8nx7?=
 =?us-ascii?Q?z55cdZZ0pYw8tjh3FKY3dmZSAmlcYHuH6jgC60FWzt0D+2d85C+cpZSoRSJw?=
 =?us-ascii?Q?48ZALEZsZgYGOHSw1iYj4fhC+UXdjsjMV2mhPn3tE5bwshlGNGZLibQoO78m?=
 =?us-ascii?Q?c6FrG1dbh7udGpMaiqVxT2RUBM0lLiKndGy/y7q8W+/rdIkuYLm/wnmzma65?=
 =?us-ascii?Q?MqY3QnSVDyOZr75FZ8yJAlYWNSGjspkoC1l5wiylJInrfRN8nzImWskU1+xD?=
 =?us-ascii?Q?yda4QIkKdQG26JcXu+DD09NZEtFJrw4RuwAo7nre4QO7KUatuGZKWJ+YX6P4?=
 =?us-ascii?Q?fnbWElIlHu0bZBE1iyee84F+Ozs73SfKEGRs17L12byx75fFTO2mhOs+IsBa?=
 =?us-ascii?Q?xZLUmw8wTE5QL6TyM1WWaNCmjYEZKn26GMz+JC9ESvZ4Fu1G7uqvi7Z9pl2p?=
 =?us-ascii?Q?F6h7wEOhrXGTwmpcwtjU4aQyO1ytXurAif9kDs7CPsfPLaZS2owA2xX7VIci?=
 =?us-ascii?Q?F2N0Yt+PrmFd9FefTxHQ1nU9xXvu3nyYZO9NXKYsVb9JbYCPJF6K0Io2hx+8?=
 =?us-ascii?Q?2ECrBCodmOGkOH7xvSLiFP2BZsrRU1eTxyeR/o8IeuqTg0OUK7ST4ZSwZZXY?=
 =?us-ascii?Q?iThSVtaYC94E7QtV1ZOGWXj9HvMSt8oD0fu9/dqifoo0xfNYoavwUXkKLzZY?=
 =?us-ascii?Q?BzkaESFJitNdO3kR0VzOlsuzqER66f10hO2ZEpnm5wMktEwxW5fGIa3Zv4cf?=
 =?us-ascii?Q?nE+VmreAo9d9aWMF0a/jRXGpbw3JXAZGiR9JyE1HCe033vAz46EaCZl1fXe1?=
 =?us-ascii?Q?16Xfo9Io6mp42ivWjxcoKUJTVDgnBrDtIo6txj850c4qHsDR76/W+Gs9vkQo?=
 =?us-ascii?Q?eKFMbkWIos6Y/a46UEdV8vFU5qdrnqJalg5ZHJ8ouAKB/IzugkYj9PlNBCUM?=
 =?us-ascii?Q?i3S09f35yCP6d7uDwiyhqWKEL3M41KmFKSPouLWmTWcZKoIemPHziPw04DJK?=
 =?us-ascii?Q?bi+8WjqHkJz0a2IGgix2oXkXv8Qce3zCKhhaz5g1BpN4Wwba3gXkfix9EeuX?=
 =?us-ascii?Q?2NK7wZd6TDSJVcODCl/uauZCktu3dCDBTjyzS/2BhrUxMZ1JX7t/+qCOy8Od?=
 =?us-ascii?Q?t8RT87epBkXCkVjr6ssu9YKe03PMdrWHn3En8L+m1/eRSX7IjBvhQxZaFrxG?=
 =?us-ascii?Q?OwQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lt1gtHWqtChsa1Kx0+quZL1Isvmbl6XZKRajIK6yn/wvYkj7No8lhCqoGdyK?=
 =?us-ascii?Q?NQUc9YSGlYjB0Kv86VqGKVfZC0DkeghUv2q3SRdDhsW0rSQ72C9JhgYp/mid?=
 =?us-ascii?Q?d+G6h9I7I1pjLZyXrWop4JSx+V5dJDLHBfsNVo5oEMyMGiR07kmFCmL5pOpV?=
 =?us-ascii?Q?iivSjtRhLtFsRZbtgSDeYfrFRB6w3aqZ6ZiDlMYMLXZrKJ+CFZW77yExshdt?=
 =?us-ascii?Q?UNu12vro9x0YyonN3ZJ0sm7avaWrYpiBrNHtZSRJKLplNqLFW6w6rdywJEgN?=
 =?us-ascii?Q?J5qTPMM1tLym2xJ6qg7vuUx5cj26IGIAK7dv/TsG2RFysfb4DSF8jdzRTmgB?=
 =?us-ascii?Q?90bcUODazMP5BQbG64eW1zDmdZRZXCI6nTiIrFG0C2PKxR04F2j7K2KJeggu?=
 =?us-ascii?Q?Cny7UYu4CVPB7W36m4qjBNByOzID0VR/oty1/IX5T7cFJLA8Lys4F/k7qS6+?=
 =?us-ascii?Q?/cJmOGICsA8bvv3eSe+90/GLU61I9LZAWDnGzl45LNctdli2xy7AMzyg7ndT?=
 =?us-ascii?Q?Iw91kpdf33FWrJMBCNULE6jItwfeoZvK8/HsgZ6VZwEwsdHbLqaIo6uY9f51?=
 =?us-ascii?Q?pLbUuS+Rfmi32T+7wwPAsfgICUTLdem/S2urVDG12h0buW6Ejvjjc91u/7+F?=
 =?us-ascii?Q?1/vT5lMfZP1s3Jqfj1PIbHhnlANnZkbV7XWS8He8dJt58t2hMu6hERGD0rQy?=
 =?us-ascii?Q?pOb8Iyet2YpoaQyWjYOep53nKWfWIZ1jLi3p5EA9EUTa0agQ4iRKZkXuAtT/?=
 =?us-ascii?Q?dbYp50BTf5ExMOIermsqi7XpTLtlUsjjz5t9W+fho9WsU84AcT88uuYc2rVT?=
 =?us-ascii?Q?VlI1yXNq2HbpdTxnZggXsQ5vZ89uIZXbP/DC3NOlpMiHRFGEI1Eyn9bissnE?=
 =?us-ascii?Q?Ssz4UmTrLQOIfeJRgPV1Efz9yuTLJ4W2iPIA/5WXRvJi7OdKKVkMKnRuRbHz?=
 =?us-ascii?Q?ZwkyVlIXVanCySXsjbm/XTxoWnhoktmlUc681MGiCjvqzGg5elI3jqrx0fHd?=
 =?us-ascii?Q?C32ii9cnw+7ur4q+Ed6n7a1/72NYr+jECNe2wfaG/7aqPRGn2uax4fk362nV?=
 =?us-ascii?Q?8MPpdT597our99e4hJIIdphf1XOpk6xnZZFPgS0yik9kMk+k14wZ/xCoOKqO?=
 =?us-ascii?Q?ggJybk4CvSgz4/iXFDuYlfJSq5MdSQr7sGiyoo9TP7l6BXRgCWuxnq2ulwcG?=
 =?us-ascii?Q?JkK1/a/kdrsJrlk2gRHII49JHlvnEmbR03LkkPR03DgMYA0IC1PGp8s7eNAh?=
 =?us-ascii?Q?JYqblYEKlglpB0VFn1Tn2NSq4g1NicucwnYmWI6KUNI4SxDcO0GKQpUQuuiE?=
 =?us-ascii?Q?OZ9lA9ITRXiiBgpptbApuE/uWKeaKQiTyn1ok4EncQ2V4XxH31B9sEma97UZ?=
 =?us-ascii?Q?ahXMlk4YU1IC86/22jOcnpw1oPua9KkfpbOrrBELgjHPYcPQ4t/yAYy9MZu+?=
 =?us-ascii?Q?5MECKYF/vjSc0HJbehJTJ3GwipZeueYxeRJfV7UDTqnw/HAFcOlxBstsKGYI?=
 =?us-ascii?Q?p3ANaNihg2Co/T0E1wZ7T/AK8BoTT5uLEIpuA6ZN/vkfJLnx41UYS4irlpaa?=
 =?us-ascii?Q?Xubqxh9mSA3SbANv+RKDFd+PH7WCPdIIGiPG6Mgt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179d701e-1377-4934-8e98-08dce84a0ea3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 10:06:35.2228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3TC6Nar+SkdX0DQtapG/Xu1l6D+22+/7nQsDG8FVECvfEfu/jaQGmmOZUuBhWAq2hZ3Ieu/Yoxt0tL1gwbDq7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933

Add bindings for NXP NETC blocks control.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 .../bindings/net/nxp,netc-blk-ctrl.yaml       | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
new file mode 100644
index 000000000000..7d20ed1e722c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,netc-blk-ctrl.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,netc-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Blocks Control
+
+description:
+  Usually, NETC has 2 blocks of 64KB registers, integrated endpoint register
+  block (IERB) and privileged register block (PRB). IERB is used for pre-boot
+  initialization for all NETC devices, such as ENETC, Timer, EMIDO and so on.
+  And PRB controls global reset and global error handling for NETC. Moreover,
+  for the i.MX platform, there is also a NETCMIX block for link configuration,
+  such as MII protocol, PCS protocol, etc.
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+  - Clark Wang <xiaoning.wang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - nxp,imx95-netc-blk-ctrl
+
+  reg:
+    minItems: 2
+    maxItems: 3
+
+  reg-names:
+    minItems: 2
+    items:
+      - const: ierb
+      - const: prb
+      - const: netcmix
+
+  "#address-cells":
+    const: 2
+
+  "#size-cells":
+    const: 2
+
+  ranges: true
+
+  clocks:
+    items:
+      - description: NETC system clock
+
+  clock-names:
+    items:
+      - const: ipg_clk
+
+  power-domains:
+    maxItems: 1
+
+patternProperties:
+  "^pcie@[0-9a-f]+$":
+    $ref: /schemas/pci/host-generic-pci.yaml#
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - reg
+  - reg-names
+  - ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        netc_blk_ctrl: netc-blk-ctrl@4cde0000 {
+            compatible = "nxp,imx95-netc-blk-ctrl";
+            reg = <0x0 0x4cde0000 0x0 0x10000>,
+                  <0x0 0x4cdf0000 0x0 0x10000>,
+                  <0x0 0x4c81000c 0x0 0x18>;
+            reg-names = "ierb", "prb", "netcmix";
+            #address-cells = <2>;
+            #size-cells = <2>;
+            ranges;
+            clocks = <&scmi_clk 98>;
+            clock-names = "ipg_clk";
+            power-domains = <&scmi_devpd 18>;
+
+            pcie_4cb00000: pcie@4cb00000 {
+                compatible = "pci-host-ecam-generic";
+                reg = <0x0 0x4cb00000 0x0 0x100000>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+                device_type = "pci";
+                bus-range = <0x1 0x1>;
+                ranges = <0x82000000 0x0 0x4cce0000  0x0 0x4cce0000  0x0 0x20000
+                          0xc2000000 0x0 0x4cd10000  0x0 0x4cd10000  0x0 0x10000>;
+
+                netc_emdio: mdio@0,0 {
+                    compatible = "nxp,netc-emdio", "pci1131,ee00";
+                    reg = <0x010000 0 0 0 0>;
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+                };
+            };
+        };
+    };
-- 
2.34.1


