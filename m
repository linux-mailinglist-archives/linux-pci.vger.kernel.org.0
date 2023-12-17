Return-Path: <linux-pci+bounces-1110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB44C815D8B
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 06:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC702B20980
	for <lists+linux-pci@lfdr.de>; Sun, 17 Dec 2023 05:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DCD20EE;
	Sun, 17 Dec 2023 05:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ru7Md7WF"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2079.outbound.protection.outlook.com [40.107.7.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE68779F4;
	Sun, 17 Dec 2023 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZolYISi3RhD83eYET0CpauMtbSt2rZIOvFmyhCA5yehs1gwgGcUl6eLQAWGQHJDsrW4aIflai+CkaraP4QYwVqN/aMmrckM6N4UYTKmWzesCTujghL892InyAv6nQHQvdQIuHv0vSCUg5YzHHLYmhxpkxENyY2pf6SGD4SEw2K7E1eYSVMQALNxduW1zX1qaNq0iNQZ05t24EySRPcO/YYWnnO/Jhfj6ak3wRZMtvU2hs9BuLsSPQBo7m2luEwfb0vV/TXv+nnyXcYcIIXGHRb2WsDS2WueCAs3dKwZSuOgYLWV/51IlbFfnJRXSoP1nOe2ao23xnWGMEW7yAo4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rch8vWPNO6T/sZoCRhQP+K7IUpFwNwWNFEzzp58beFU=;
 b=Q1kfcEQzZmYELoBvqicy9bCCxw9pDh9NLOfazP7pUp0Brh2XDuc+EkRNArncNrrrDYbngA/riAKi6q7PnpunhmwGAfEKoa5GrlLB8L9WW4f1NevWNN8TKtIgEhpP40EqcRloVLW8iJr8VUs/AGSic6ViSfNcEnD+vGIr11qNhTCUCTatKyAjcUGDGZlljvUDJJyyx7Fl+8Pyz8S4+IG7eqACPQ9KyL3KYaPpQoTJjimBhlikmWqeDFk41yRwfWMh1ApHsn5NSAIkQrs7IC/DHLo6WGLv0IvG/RX0M/oaq2e3RqcYqBX6Y4qNk8ulYDRys7g6gUjLt5xmoBug3tj/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rch8vWPNO6T/sZoCRhQP+K7IUpFwNwWNFEzzp58beFU=;
 b=ru7Md7WFxMRhRIaJ8HCgpIBCm6LtLC7RUR/So9Qp/rPXDeVkToXUzXJk0+pyfViNMPnb4pvCA2+Ia/jMFmm0jzOkaaJQwVzdoX8/QPxfxht/Q62ZP38rGIHqv9XSOVVFZ39XTwoI86Y4nMDN8BOWW5wSPndadFHoqR6/slkn27o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8174.eurprd04.prod.outlook.com (2603:10a6:102:1c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Sun, 17 Dec
 2023 05:13:16 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7091.034; Sun, 17 Dec 2023
 05:13:16 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.li@nxp.com,
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
Subject: [PATCH v4 08/15] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Sun, 17 Dec 2023 00:12:03 -0500
Message-Id: <20231217051210.754832-9-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231217051210.754832-1-Frank.Li@nxp.com>
References: <20231217051210.754832-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0007.namprd04.prod.outlook.com
 (2603:10b6:a03:40::20) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: df04bc62-8a17-4fc9-5713-08dbfebee004
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nYbRkzMwlcotG/7FoieYYAjXesvv6zwQVvgZPRPapUqE20XeGT9ZDXD05VQ3qHKaJjIkqTHNEI/F5ekzwtd0yJwclmwykdXxdo/iaFjvGusmlEjqFVG1LOvti6bmxs1qjPS9pPQqjjb8QfBVTEvXk/ZkIvtNJMXpvduN8GOxn7suydlNcw9hry53c6LLQBIsp+h0ECi6fXMJFa9R0aprgfjLbah7cWd1hGG7D3uZh//xeQrtXKSqcZSSbuPKicfRxTR4r1sUCxcZhiBoAmDvrSWRSYckMmDnPbxDrq5/dkchfO7+NHP0jT4GzjjYTui9gNR2XbnpK6FVZDYrCmau3iq9oguMH924aJcgyBqLQark2VqorGQkcmhuFZm8AjrSiHzMC+o5Vc3IENrXC/dVly42byzdSjEt1c9tXCH9UN+beMX+vHDyJGWr8PfQvUhxwybkG5rV3n1RtpPqxC5XKkFacYP7kmHOU32rifKsKLF74NittHmyNh8KYOUKbD2ilnODnMK5VJPjfUuua9k0Mmjuvb8n2IdHqYZSayofEcdYJF/x8Z8G/9hHpUKUdVbxsd5yISRCkNobMWz1wOaXLAIBEfuk+hZPhIxZJo1/VVLtAGhrmD6lK7ezWpC4SPxkxronr8VPkaz7TZrUcs71tQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(38350700005)(86362001)(36756003)(38100700002)(83380400001)(26005)(52116002)(2616005)(1076003)(478600001)(6486002)(2906002)(66476007)(66556008)(6916009)(6666004)(6512007)(6506007)(4326008)(8936002)(8676002)(66946007)(316002)(41300700001)(7416002)(4744005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A2GBd67Vx60flz3izmMWNNHejlmjTqDspOwD3kJyf4fRnPSj0XrH8XZbg5ov?=
 =?us-ascii?Q?QvwojG90QDQcpAUuzPHIiAXpFhXC34OrE9ex4Ljn4TU3D3OOewQ3HW1vbXj1?=
 =?us-ascii?Q?Na9IuH46W1U539viufePAWCMIMW89OHmxW4eiVFTGRPboH6JakiyLe9XvdE8?=
 =?us-ascii?Q?8u/Zrin6gpwilS65+mt7bFnVMhTXKtUzLXWQpBHn/An0xvy2YiOcVFxhOwID?=
 =?us-ascii?Q?R4DacUKxb1f1yWxn6hOCJ4su4x07fFoq6/mVM6KQscJu9b3zI97jKpjHPWiT?=
 =?us-ascii?Q?bkCFR/O+AEbisdutjKgtDvztM8mC70xMi0HXf7Bnsblz2wl+1DFJrAOqP34C?=
 =?us-ascii?Q?ITYZv0a1FGyHHJloqIK9QZIWNLBC4GKuQlBHiEi3XpP01CNZE8COaV2HJXZB?=
 =?us-ascii?Q?Rwi6lJG5PAyQUFy1Dxd1Flp87asb59PIawYUKZQy3XI3u2Q2GsJfrtmPIhU9?=
 =?us-ascii?Q?UWO5ws9YVsQEsH+Ij5ESioATvffk1c8wFSM4ADIx7SJicaXuIPQ+1zeuJjx0?=
 =?us-ascii?Q?MAAkaCEyyFVEf1Yiebz1sF6viZkEqBoKO6sMcGq3jOYPVIyuNrHYHSWm4Yte?=
 =?us-ascii?Q?/jqJH9edNIDGEYG4wHZWTvAaPBJgeMndCgilbXhuOYawiHAo10ts6fsQBv/S?=
 =?us-ascii?Q?XM1sY3B1fm0kfXBX1HynwGUBcfbIvoH8zpmXbHaYbGUpnvWcVBjh3R/nJmHr?=
 =?us-ascii?Q?c217K8HYwjk1905q5Ug82gyRxOjAL+eN8geJJuk22o8Ma6YNhYFVN0rNtcCw?=
 =?us-ascii?Q?eQ2VSp9zovBgh1VIVDgZVMoxHBzvDXk/rKEXPbHYMBedH4jdnQ3PLW3aQYfU?=
 =?us-ascii?Q?i+5sALswtHjT8MyeRNN6MyqlGpqVfc5W/dQfbunRT1VqyitVjIiMOgRT1aF3?=
 =?us-ascii?Q?e+/MZ8PC6R7KW9mb4M0xz6uUklRlTT+mjxxDPCmMsvye0J6JWEsYiopSwGoJ?=
 =?us-ascii?Q?YzdZrxgCZzypYOLCHcozw/tQpvgytxF7XuxKpK16mCy+83nIW62Cm9Vb3uh8?=
 =?us-ascii?Q?Ek4645NW14NZLNTnHcA3P4dw946tdrj0Ak1kFnmexlDRUv6Fu4318cHGiNtN?=
 =?us-ascii?Q?2tl4oFwU28AHeLFqjzmvTa8R0DuqcG1UDAdoNVEBEdf/1mmm6Mn+nKAbmew2?=
 =?us-ascii?Q?Mlyc5sgCQyAOn4Hv9xKrEaUuX0YuRgrVt9sC6+c+kLwhyhPzn004SkI5HzPl?=
 =?us-ascii?Q?T7ltRJYZPUvIGnIuFJkDHMZTr3uPk2CYOzLfVjMTgM05S7ey/wU6a1hu640e?=
 =?us-ascii?Q?hDF8j+CZ0x82Xs/oJ5LuEcmBkOsRUmQoXkn+umjAr+GIDegNN1qXTbQXkT6o?=
 =?us-ascii?Q?BguO4SkTJN/8fN3EAM84MQONR7XLd5BOTMxYz5qPbRF0lZI+e5A7S7Omyj4X?=
 =?us-ascii?Q?BCNEf1M8aWzXXxI9Hq+HgDUeHexmbE3tbS7+PyLqjCxDKbHrpPdL8Aq3tuGJ?=
 =?us-ascii?Q?MCBUoBgdrROh6v0qDk3YXL/0Yph3EfK8hohzCV6dvo8VJoxma2fnIrWQHPEX?=
 =?us-ascii?Q?MGo3LEGURWzwX4pzeE3/JeChhzd4dZ1bvfTwp4EFkNF23R0FxBMYtc7ZWU58?=
 =?us-ascii?Q?shzmEOCe9vlQGyewP0g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df04bc62-8a17-4fc9-5713-08dbfebee004
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 05:13:16.1499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNNhvL2HtDrYDn/E+EoFIXZmk59Qn1wGyhKWuvzYQ4mYEnntRtMdSofGnQbwjP/5yd5HvItdNRFkxGFLR6zkEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8174

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


