Return-Path: <linux-pci+bounces-1461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4D881F14F
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 19:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A8F1B227F7
	for <lists+linux-pci@lfdr.de>; Wed, 27 Dec 2023 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13219495CA;
	Wed, 27 Dec 2023 18:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LupW/Qws"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2080.outbound.protection.outlook.com [40.107.7.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B390C495F7;
	Wed, 27 Dec 2023 18:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcRTtsAotYO0fhBbIqzNbnsv/v5Q9TtyX9gajlm8mkTFYizBmh0Gj+B9DCldjpATSkLD2tg1dfdVoTEUUu9xjqsQC5mh2QqkTkT1QOrpXbjiXlZsxArIAv6EdL7X+aW2efv7jkxMJM2gwoMptY3GmP8LwZ2BqfcYnVtUUiRQ1g4TDPJvSjWwdkfabw+U400weqCkoiVJHH5wT6mRvOzjA5dtS6hPAAIt+QDlxn7yuw3eWLHFg6eo0gZm/FBV0Fs3iicszFNp3J/Ol7+bZF/pR+ePW/gevK08uLQSMqxoNO+uTE7V8ZM9QubSGiI/fj7Bu5S8+8rZ3Ean69ffA49fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJkTHzjCQwUmpxaPt2WdiulHlG0YMJvncKXbLMUyMrA=;
 b=ldu9sO0W+Uzm3U1bd7A/cW9D/zjYstkMvT+03HJhKAoGSEQs9VUlJYA81niyXkkb6TfOqOsNDhszucxQcsI41O2nuGB5qYLNce29wA4b468xt6pr8IMaMzAS15zRzGWzSxNql7RmQ0QFOCiXeCDIkQqwIyAcWdJKMa1IcuWIg7OEW/dMSwxjfeDtjX6Ue8fB9TANox6XQMiNI1INi0JClDqKLM68SQGkT8CQAS1LZwrS/3zHWBG5cw1XTiiRdWZVFeX4cooMv66DUAXmUZBTjrk8bEK2A0bDjoQRfuKrRNoE/dNl/1Y11BQutu7CCq75jaRQ9GnyQxoFRs0hFZWRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJkTHzjCQwUmpxaPt2WdiulHlG0YMJvncKXbLMUyMrA=;
 b=LupW/QwsTphEci1ZeYJbxQoPBce3mxxofMmdcRlvQZidrsBZ3a07pXLiGRj80XPANrnzYPtfgcbBCpPatP2SF8AHRR+WTWiieeEWXmk1kVK5APLHwts5qj4JdxHz0weR8xHWTWrC/Z8KGKS7MymK11IFwXwOWzFxPp47F636/+Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DU2PR04MB9050.eurprd04.prod.outlook.com (2603:10a6:10:2e5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 18:28:37 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 18:28:37 +0000
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
Subject: [PATCH v7 09/16] dt-bindings: imx6q-pcie: Clean up irrationality clocks check
Date: Wed, 27 Dec 2023 13:27:20 -0500
Message-Id: <20231227182727.1747435-10-Frank.Li@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a726d24e-9f97-4aaf-f32f-08dc0709a42d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	leea3dxdhVtoEjK7n0ANVlbBuzM3Z2/n7MQ2z1OyDevmXA8D79+K/n5QrFF13SsjIvdkiZ8sp373C2kNKq04mO2ONT1AteciskjpLM0Bqoy++YCL999iVa70+zPpU5ZOj8xBzgcK3TrXHJCXDmg7eFOHdH7ZRgKBPd9YjVeb9orcAADeqf/bOArl4mWWSji1pt6IMw5tjPk1uWTKD7rmVf1y2RYExP21FsA57ePLE8nFDc3acWDAtrSZY0dBgIM1NrUDj5H8U2ZKtkWwn80zuAwbFUK3LMgNLRCAeGLtUmT5JhLgHabq3b+y6usKd7W1bgOZEBtbftqfi3Snl19QtEy0pwQrhOeRi6UHcjOyCXXezVyD3qT9DWMzFFZM2OqKeuvOk3nPZ31p3edrg2NCDr4VkXH8CLILwgUl0pjhwcbv+KwQqT+8V7DwushOUfpgeQzgf+S69HQHXcl1xWu+KWqTOa8hfLc+nLlVkBBha6fw7xGsn0e3va4c+rqkNSab2IEbT1oEHItqM2at68onlOwo93cPr92VKsEZA8CRE56SZUmjcyoWscbYbmJLOad6/2Eswcin/7ahoAlgt9Npm7fUa0J229uMAY+AhvRnvMPYFn3GQpppIDs/Kxy3RA62X9qMV8zvzRqZ4p9iNiRoPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(7416002)(478600001)(38100700002)(2616005)(26005)(52116002)(1076003)(6486002)(41300700001)(36756003)(86362001)(38350700005)(66556008)(316002)(66476007)(66946007)(6916009)(6666004)(6512007)(8676002)(4326008)(8936002)(6506007)(83380400001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i0h5YnM4dVaqfu2fgubgsXAiUT8wyN2stgVoVZRIepeC049Q6OztF52R4LsU?=
 =?us-ascii?Q?vPmFOQ8Ge7xgLF+1kzowiRkIJd+PiaNFaqkAHeCj1pSh6xiz5uCnmwpTHtFy?=
 =?us-ascii?Q?dESjPyekglbeQLchZENaq52ti/NwWMjtWi8oN1iSjXWg+tws253kYxeonWvs?=
 =?us-ascii?Q?kxTN1mGmFa+CrThfLMNEudYY1J2vqKS6YNDTbXTcy/wF7hVm5hIdN+C5N7zt?=
 =?us-ascii?Q?u5xD5DXPQfRxeJ6yKAStGivFTL7nQEb+hgbvekH0cbMVXamqa1h7PBQEYx1f?=
 =?us-ascii?Q?nODo585cD6FQlkDSSsvRpAn9970+v9cj77MU0BwRyjfLLLqM+QYxKS/GQVrs?=
 =?us-ascii?Q?XSed5mlGEIUxEQWUwoqVSewKDnO6nobISxM0Pbi1G72xGNzLrs2GzDW3sOlD?=
 =?us-ascii?Q?5/nKRF+GK9k0cP3pvzX/DC5LDnlDNOzJGt1YPc15wQVrIzSCzUeixvYLKZXO?=
 =?us-ascii?Q?vQXwtPGpBly3vglrMh4LmgBTqB7B4B6DjYqvMBO9Fmqclgg9y1Cuxkg6CpaN?=
 =?us-ascii?Q?Jww1QZ6mZK6GHpm21nuKNqY6fTj0BGUyTi9CEsx0C1PQz3WdUdu1hPV/zKyA?=
 =?us-ascii?Q?ffKFdz9WSacKEMILobmiwtbDU9AAUYVOXGCxHpxk0yB43FoqqbHBirNY76qt?=
 =?us-ascii?Q?62tudIxOzUBOuYjGVOeN6NMD+xLwzT/1oxCLzfi7hxXXwCHGTj98m/bSThNO?=
 =?us-ascii?Q?gmHgJic8GEOJon4tReNXcBCNC2+Gz7gkU1SoUsOs0iITukSUdDNyOHFJ4fWd?=
 =?us-ascii?Q?5I4aLlrWG+wIp267tuCRc3hGKq6Vif5UWxL8rT51YF4qBkTrsk4in9g9Ih1a?=
 =?us-ascii?Q?YUhzOtvaINfT8ANCfbtoy1HsdGvJsThTjWMiOSEFkU7+/WSdnrjV8Pq8vOgx?=
 =?us-ascii?Q?yCFVf6XLeKQHLxMEF9toxQmxzhhDc4zF6Tvc15W5Bc4BZ1CGTHDzSItv2xr9?=
 =?us-ascii?Q?lHg+9TKaRLWPV36JyFvW1frw0SPgn3U8wdANxUZH6dmAZjmKLIAY3BHM9Zvk?=
 =?us-ascii?Q?yAgYCmtOVwG+8jQLMZweMafKci25nTq+KQ7RScfxAZ4/YILICiZcgl7lGlE7?=
 =?us-ascii?Q?/HtP8oFO9lp5KW8xk0CI0SyWgVsR6uDW4g0FvcYAzjSLYgQmx5wxZKXI+8zk?=
 =?us-ascii?Q?HqKav383q9W0W8ih8XkMx4i4CtyPuyOAoygUizSiK5tdlc0NsImXzS62bh+z?=
 =?us-ascii?Q?Ft6DunGs95a+/YN8nLY+8AkasuIIANJ8F2hA2+MeGmD+kuwZ6E7HG6V702Vq?=
 =?us-ascii?Q?rTtf5rGQXZJPrggilW0edOQEULgQAGOKBokueGm1SUCcfFjr8lywfpz1Zoi2?=
 =?us-ascii?Q?iVT0MBK5A+HELn0Ha/mpLB9D1PG2z6ISLvdpBnBRwDVXDTsow0CB2feraEl5?=
 =?us-ascii?Q?aQx88g/f9aYnldQPvAyzM47cryXYKkPcUhsD5nypm3lDaXG2zKl2SBI1CuQf?=
 =?us-ascii?Q?7/WKBckJ0bP7fqcmffslhm/YG5IfL+ptlz7psSR9X9lyzJI7cQMRVz0SSz65?=
 =?us-ascii?Q?yRKPUx2WXisJa+drzmdmTFQv9dYq09ZkKGZzuz7FJg/bX3hysWNigliDo/6h?=
 =?us-ascii?Q?58RSjlpRrKJ+sKAHN9k=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a726d24e-9f97-4aaf-f32f-08dc0709a42d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Dec 2023 18:28:37.2036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Db95d/lzb77iinjp/w3RBmVSWUOFtw1GPFD82EO2dqUGomuIA7VcXLg+sWoHbGq9UY+MHYWxx9lMHnH6VziMnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9050

The bindings referencing this file already define these constraints for
each of the variants, so the if not: then: is redundant.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
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


