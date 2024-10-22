Return-Path: <linux-pci+bounces-14974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2E69A993E
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 08:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96FBB1C219F2
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 06:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A399146A93;
	Tue, 22 Oct 2024 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VDRQ54ou"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E082142E78;
	Tue, 22 Oct 2024 06:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729577262; cv=fail; b=HJE33MyB+ej+7T5mEeI2/u/LW/JTiUk3K2GPwKEhrhn6PZ6+SA8kA8TdE/T5vJ02b7dUFmvSlIRssKBH/61hZnDAFynYIPuWqc+gGRZlwOROUntk/qWvHpHYdxpYgRZytSES0N54G0vW7XW2xIvsXHeKFNNx+30OubDHT5qZ12I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729577262; c=relaxed/simple;
	bh=i/YgLaTmsl+HLl9o60+gf4S9RynLC9oiNCimM8aYscw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zy7oZD9vVEM/gaxRSaoBBYdNA6ztSlfm7Qxkl3WxVyCo0wMfCDgFyrRGMFsUkMJ9xEBjgMmBBgse1jnZ32GWhINfjjE7XpKJOi8WDCehcUkjXUqsRUXGvRw8UfZRbWVoMjoF6hixvgtom+vSnw4+AWHYGHswHE82dzpSmBOxO1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VDRQ54ou; arc=fail smtp.client-ip=40.107.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LM7OvTLROvwGa9UA30vmu5/DC449r3SqTxbROb7zrmCtKJwo7O7CCU/xh02vJmixd05KxjDFzosy1jZPeNvTba3uxXCVrhgndgX3+0FjtArAPEeoNnQ85any1uz8+SJ/pdFl+D11igtJd0Qa/3XpTOpsa0OD8pzgSeGVZXRz/bKA2oxkTwPXSjAQEYzLKj9hsxOakwzttAfUKozIajQGsV6hANx/mAE9Ve4BRFU4mLLW9T6HeaDz8pc2sNoYOtOdu7uA5r5OTLoVgRdqu6YCDqjPfu/IxIRN3C9ZC4upmpFQbUWNDzelXdpWnayzVhsfG5K/fktct5GjnEW2BYI6Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/HrA+T8SnhCutcgYSJfi3ADIAYH0w0vO1kYedt1Rukg=;
 b=TMS4mgCZV48yH0GMiT8poDtWeaTIE3Dd6od/VEMLdsTb41NEh2jrHOzISlQv2giJVRCfK+IYhScL/59ycQbfoLXQgocEDVN6u+swOGIQPdcWB48pCwnf+7VznC4iQvHi4QUGkcFsq0LnCKJrSSSjWL+JOrDkY0Sp3HI2DwqJcmiPi+5VrBpWn78roUHmH+3LUrF37uLKNSfsXvxofu6TZ/h54uW7+0Bmptas1vce5UrUawrBhOzLmuEH58+JrQmLtLvT61mQpXilkNkKaQ7cV5s+oGFxT6MBAn9c6sm+lUwjKExNAHFoltrJaNO50sNzXIT1TzyZtwewEZ/mNzHMYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HrA+T8SnhCutcgYSJfi3ADIAYH0w0vO1kYedt1Rukg=;
 b=VDRQ54ouzOvvPri9TNS74tSAuKJi5K1dDifBIcCYS7aYbhNT4qjJHR/HRD4ivmb9mJQapROi6Xhc9XLjZ4OAhJ3otrcNorYrxg3sfL7x1urfSlmhTVEJrkMH9LzzOTc39a+s3XOylbAtjgUmTf54Wly7JOeBLu3vfP8eHDfW/koFW7ebxeQMD9zMke091RLqRCSDTxaB0ReyWplIweVyQdTraD7cN1OpCLM1ZYQozM7rgnBtsIYsdPfxWXSgcY27Ns2A2tt614naj8qF2bVsnAbvrsjt9t1FMxfNrwiTCpUwjzvDXcioKfrJH6kMPTUxvCRUSIgJPstD4d+k+D30PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 06:07:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 06:07:38 +0000
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
	linux-pci@vger.kernel.org,
	alexander.stein@ew.tq-group.com
Subject: [PATCH v4 net-next 02/13] dt-bindings: net: add i.MX95 ENETC support
Date: Tue, 22 Oct 2024 13:52:12 +0800
Message-Id: <20241022055223.382277-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022055223.382277-1-wei.fang@nxp.com>
References: <20241022055223.382277-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2f18f5-e723-41aa-e8c8-08dcf25fd427
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yyjtjQWylNt9ysK/wK+Zr/nQId7QByL0JHhYU9fT00L/yZevrgXm4MC2A6aP?=
 =?us-ascii?Q?Uo7Wah/zUMVej4EFpn2LzlZYuuju/wYUJ368+B9dJQkCNfAJAzoNuoH4IuEn?=
 =?us-ascii?Q?yiFtCaboeo//nlUjqKEmCQNOpGDZ0A4iAldCoSqIG4uOJNYC2R+LElIAWqdZ?=
 =?us-ascii?Q?/OCdzbj2GmAjiyYou8lA6BwdbkLB2f7vrsl4V0Jw8/A3riJ+c/mNnJ+P+0ge?=
 =?us-ascii?Q?E0MZb71+cCGWnyj+i1YASOTwQk1VEmqOtP7JEIhmTItoONTYBreoXgv2VbDS?=
 =?us-ascii?Q?6yTeXBABm0DqBuPjJks42zkO25WbmaZr3Mk2LmD4FJ8Lw3mBClDb4nLAIozo?=
 =?us-ascii?Q?+YIWmWzL9HVe3J7tUCe3WUhsp4AYdobctYTamEjfd1Ldnw1d0K7mK6rt2oB9?=
 =?us-ascii?Q?adlL2c7zlntYjkS0HSuasRmIseboS7uNGaUs8+s3YLtZ2OrCd8ZuC1Ajwueb?=
 =?us-ascii?Q?7d9NsU5DIh5CWI9aq58nBdym3SWvRz7IjM7srfmT1hb7x06mZAiSziiIOUBN?=
 =?us-ascii?Q?1niUeJlgDVEefgQLeYFn8NuqHLVYHEQDrUUnc4tX7JfbXf8fDFIToC/tUKz7?=
 =?us-ascii?Q?z3stRmDgpLi/vQdC9xdPXenVG3hSuWq8GOOgqJYFaYZuzmxPwL+ur4DQqtss?=
 =?us-ascii?Q?dC4smzsT5+qJyMbPJkcPBC9+4p+qVJsqh65QjVZLKO/uJUnjpRkpQ5JYp84b?=
 =?us-ascii?Q?6gfgZC0vr5YydBnc3YMO2vnP64brrEGM+rXvOaaDcAqyQcqVGezPbLIyNa5q?=
 =?us-ascii?Q?MenabfvsVKZIRWbJjnY2/d4tVnQL9AJFO+q9Hm6k6IqQUyxQFdQOdW301xDM?=
 =?us-ascii?Q?Qj4/zLd6D5w5GTrAYjPmc7+NLAUrl8rItlUJ4OdKfqmxACNoJ/hziIquAmsR?=
 =?us-ascii?Q?Md967f2+qujLC24EbFF4BSc3L0S63l+G0oLCDpBK5HUyXlh0eSoYjgq17h0I?=
 =?us-ascii?Q?ANpH6kqoXOlUvt8WaeWgxTnZQjr8mpgd+N/25+FEYVY3m4DXHTuN4fvT/s2z?=
 =?us-ascii?Q?lZ09Uamiu/9WTYTNvqWPkBXYlRenO4A9Z/OVELD9nQO5VIMo66EfU5VNc7ca?=
 =?us-ascii?Q?B5jD3LGurZDO6lheMVFMoouSm3ypBif9pdHFv4/q0EucqfNGReYf7/cIxX61?=
 =?us-ascii?Q?ZG/tBP2XNUvWMGlR/mSoJ2f1Aea/kt9ezpfAMAJO9WquGS3QRm31hXceixyp?=
 =?us-ascii?Q?/IsRJJB1o01D8RnMROY441sNhRnk2F+R3890HpxnODzWcwIoFkHXGc1Matt6?=
 =?us-ascii?Q?3AJ4Lv+odk8x6hbE/Cx88YvBmTKEWGu4SqR86G2WK3Kj0os6CN3ZzfmxiJ/y?=
 =?us-ascii?Q?XQ+2CF2RUS35nlyaLOAQJYzYxRuVChQIhRbrZxAFpmXODOvNu2Txr1m8KRzl?=
 =?us-ascii?Q?p1TJe2qZsFfBgEFU08Yfz22R07VZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mraN9I9fJhh7zLxHI61Kk//LT00yYwV3Yro7WUBK/2qdZjjuQWz8jxugyPfz?=
 =?us-ascii?Q?yMq1a7Cv24JL5+gXrNryawMCyWwttWng06Df01f0hLb3JVyWqsSN7fecIo9H?=
 =?us-ascii?Q?wy5UumSeVW0nYHmqlL/gRENqdR+k1aI5Z+Y2uzskLYmGNIFdnOjVlj86rHj+?=
 =?us-ascii?Q?2b63mfhkQ6ZpnvMf7m0034wUyL72I65vt3roNYB5LITB5LyeOH97K9lmDZE8?=
 =?us-ascii?Q?Nm9QSGvCFuj7dHQ6xCiJ9vSWfStoC83X0mRS2n/egPXdB0Wsi4i8KKMGZdWG?=
 =?us-ascii?Q?5HHvygSXjZVaLXyWn/4o8fa19ioSzcTLh5wfACnUYH8B++yHk8MzShNfp5la?=
 =?us-ascii?Q?gG1pTc6QN5YmIhKP2OMqZt2WK3u6sdb85jE4jgQtrI7wgCoQL5zSLOyn34T2?=
 =?us-ascii?Q?nCUx6t6SOJliCdFEZbjHCwU+87K4hWNs00sEGqaaZxLIeHUgmpj26WJdY318?=
 =?us-ascii?Q?djIpp3RvoGLOmK6QSx3i3vg8f616/G1DluL0f8KGcDYE5M4Mxu08VFxYGvzc?=
 =?us-ascii?Q?7ANDS6BtKJlRRntfiY4CrFpf3KHDTwkQdZcAnPuSXn9j+2mnubVgDDENAF6w?=
 =?us-ascii?Q?BT97Uho1NXhB/tLygr9n67IoxbAK7k1Uph7de3Ah34YdY0Dn0BZGwt20RyrJ?=
 =?us-ascii?Q?x3ZNOytEvO9LnGd2UPnLrMoiK2zgTi2b6XRzSK111aBwrSOmdfQYKfgece9U?=
 =?us-ascii?Q?FmVQOS8JWtA5+HdcjDqMhAsYO8QPvdxjqPLZ5XqOeT6Dh7Gpwxd+rQQyJPDH?=
 =?us-ascii?Q?Kse+HXEaZeHtTuRh31RQyWJ1kXXxuTKTw51Hz1/qC//1pmScOrnTlQEDmaDg?=
 =?us-ascii?Q?Hos99rNArQ6WEDoyDyHVB1K8btmnDqFQRXxzyvbAZBzgrJKWvySsxi6BVCT6?=
 =?us-ascii?Q?LRkLQRTADW36R6Wop7F6gcenD2kMxRA3t8ySgJa722xDYhdtP7AfneEKrk4K?=
 =?us-ascii?Q?0BxSDRCvU7kCfkrIxVnpft2RBFpJ4YhNdGCOOpATxVHZ2U+Uvmzs4lJ/YpaT?=
 =?us-ascii?Q?Z6TZOigkJhDVAs3PNsZVavk034wYcYojlwS2seeVdIsJfe7dOO3cXVd7eGQO?=
 =?us-ascii?Q?HJHmhMVx8DJJnADnt0VEjW9y+3XV3qw6MnIr9jTYk9bP6/FMYTSrYSyFUfq3?=
 =?us-ascii?Q?Mwtvrh9Odp1DRnWcgawY06tkm4dfj7AV3XXSbwtzyDFcetR2KMXQY8rN5GVm?=
 =?us-ascii?Q?bfkpXajXJLAkKMMZ1twLsHALXf+B+Jseu7/4Lii40iL1YMl7kaW6yzts5cis?=
 =?us-ascii?Q?ME6nyJ+iQf6xayQ59OFLNr9hGYyWv5CTdMNeNelCrjr609g0qJXYs3mPfgZM?=
 =?us-ascii?Q?6lcrAF8KPrQQ0Fma3e44nTLtr6ue3gvhfglqeNUfVEc7QLzzGTPCg4iK4q0g?=
 =?us-ascii?Q?KXSGf2ozqaXbv66xFBeBOvyYlhz8IXwg/Z4aaR8eSTtigR1MU26dwtPsJqnt?=
 =?us-ascii?Q?VKeMpzrSZt/Q62N9VawjZll6zhn/BWI93TTfYJGqLGChSgv3+CNDs0JEmJuv?=
 =?us-ascii?Q?UwuhRGzwPISaEiawHtMYKaQtChMtfK4nb7NEc5SEwPuMDU7sr5bEMN1mIcfL?=
 =?us-ascii?Q?MZgL5qGFxDy44VJBqFLWRYobw0iw+VwZNmBIHxfl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2f18f5-e723-41aa-e8c8-08dcf25fd427
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 06:07:38.0600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nsMQaCk5snBg94QItredc05wQYZHUfyCFKQFsB+siBOxqkqLe1WMbSKUWrT/MbFa7kXmiHDlQ7pA1tQ8cVPuEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178

The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
ID and device ID have also changed, so add the new compatible strings
for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
or RMII reference clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v2: Remove "nxp,imx95-enetc" compatible string.
v3:
1. Add restriction to "clcoks" and "clock-names" properties and rename
the clock, also remove the items from these two properties.
2. Remove unnecessary items for "pci1131,e101" compatible string.
v4: Move clocks and clock-names to top level.
---
 .../devicetree/bindings/net/fsl,enetc.yaml    | 33 +++++++++++++++++--
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/fsl,enetc.yaml b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
index e152c93998fe..7a4d9c53f8aa 100644
--- a/Documentation/devicetree/bindings/net/fsl,enetc.yaml
+++ b/Documentation/devicetree/bindings/net/fsl,enetc.yaml
@@ -20,14 +20,23 @@ maintainers:
 
 properties:
   compatible:
-    items:
+    oneOf:
+      - items:
+          - enum:
+              - pci1957,e100
+          - const: fsl,enetc
       - enum:
-          - pci1957,e100
-      - const: fsl,enetc
+          - pci1131,e101
 
   reg:
     maxItems: 1
 
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    maxItems: 1
+
   mdio:
     $ref: mdio.yaml
     unevaluatedProperties: false
@@ -40,6 +49,24 @@ required:
 allOf:
   - $ref: /schemas/pci/pci-device.yaml
   - $ref: ethernet-controller.yaml
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci1131,e101
+    then:
+      properties:
+        clocks:
+          maxItems: 1
+          description: MAC transmit/receiver reference clock
+
+        clock-names:
+          const: ref
+    else:
+      properties:
+        clocks: false
+        clock-names: false
 
 unevaluatedProperties: false
 
-- 
2.34.1


