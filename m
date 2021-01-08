Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4283D2EEFA8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 10:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbhAHJ3E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Jan 2021 04:29:04 -0500
Received: from mail-eopbgr80071.outbound.protection.outlook.com ([40.107.8.71]:61006
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728580AbhAHJ3D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 Jan 2021 04:29:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMlpQGGYfe8AvBO6KdTpGfv7nSPMyQfq4wuRL9EwbSj6xw2PtHc2wY7aMoxe80NlScLrkv/2e0RRSEkJvTX9RRoX4uNffeWpONBTJsWj84IJmow0faNQACPcalTkuM6dLcolEE9xyx8J0GUzQmGBl5n4olZbrI5Gis0YlID57W2xXPzMJ7MNpGDlXqWiVSArUT7gf6sVzM2uez0cvibnW1diy90lUcQsvZCcWYSsSvvJqx32OV9UriPalrKMLTF7V8ML7EnzkWhyAMmwtqpDUGQ3C1nLvotCiRmc3ZYrWjTliKce076l2OxEr/V+FVL9qn15ZAewiQtZP8oAQNBLkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEZ/59/xm6HRVjgfVbBwCqDkQREI9hUe2D7/AhWtiC8=;
 b=GlSywlFjJ/vPNzMz9gZ3wDbIK8CguAJ/SBNliqj8qwz9pl07i0goZqkaZ87a6WYlZYw3Oje1PDeGpghbufH+brCDt9XXthwa3fz09ksuH+QCavdM1xsnM3qMYTfTPjOkuG2tcOhfmdH/t6gL7ZVkvYaOGp1NInLj0eBRhXwy0GIal8FoUpHPQJt0tVnBjLGJEF/A0D03tFhlsUqCKdE0btk23Xxy71Ecdeap82ip9T2ApofvaH8h4HZF5uf3YgnjTx51KrNkBZhkhzK2yhiAWsTjBpBQ7p9NFffq4Kcy58eZa6pn3AorHUdfqUE5u2wVJdc/jFRhiVumGve8yFYhgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GEZ/59/xm6HRVjgfVbBwCqDkQREI9hUe2D7/AhWtiC8=;
 b=VIPU5hHDsihWVRmVtaLdvxjiBivl5oFSYn3w9b8OcfGPJbdh0Pr25We13nLi4DRj2xr21KO4EI09OQR1iYxo7HOjNEv/2GFuxId36hyCYUrdFs326190P2ZIjzh5jyQNxt5XwZR71uukmsaj0VZZZ47gUL2aHDrlc7zSUY/Z1Gk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2652.eurprd04.prod.outlook.com (2603:10a6:3:83::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 8 Jan
 2021 09:27:40 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::3194:64d6:5a70:a91d%4]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 09:27:40 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv3 3/7] dt-bindings: pci: layerscape-pci: Add a optional property big-endian
Date:   Fri,  8 Jan 2021 17:36:06 +0800
Message-Id: <20210108093610.28595-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
References: <20210108093610.28595-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::29) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by MAXPR0101CA0019.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Fri, 8 Jan 2021 09:27:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31788afc-3ba9-44e9-bafa-08d8b3b7a50e
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB265286F16688914B60BD58FC84AE0@HE1PR0401MB2652.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QjyUmryt8rqGOx2fCFPjW7YX9NwjiWA0jqEcQOvx9KzcK0Pk98cD2JXsfe1Fxabq8S8z6SD0ieotPhOTEMlAqXJLR6PBmNhlEKWk1HhFk9CKIcikO8fEM5H7ZmKy163jZEAEqnlxVlHhLjMAmJPBn4qnSKcXZN1h7f8Wrf7WVHsqynVwKQeTEJC8oulOXKVU+e/aJMvmUoANiLn5mnrLFHsku1HwUtJS7kjVTZQXtgtDFSFGEnSuBX0I1jTb7ZGo47PTBX9aj+G3lH4pc6OOl46QFH9pYf0SvNo6kbmzy2y9bAFYY4tEie+8oVLGcJSEva2/tF1uK4aDfIOo/ZmFW0maUMF2XEYSGAgpOdpeTMsggzgXxuC7gdlXDrcaLg5mTYVdGFNQVzwyfj2rWXSuyzQNgNcn5pnh1quOt0FlLMvoq8Kc4w0CB2luYpWnvjCbrrBUzVSoA5cXbn3Co9s6kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(316002)(478600001)(6506007)(6486002)(4326008)(52116002)(2616005)(36756003)(69590400011)(8936002)(66556008)(956004)(921005)(6512007)(1076003)(66476007)(5660300002)(66946007)(26005)(2906002)(6666004)(16526019)(8676002)(83380400001)(186003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?SUPVJkQcLK2EBm+gyY5gndRrEmfuCSFDF2M6yZ/gSDXXQPiUp+nK8v8oBkzr?=
 =?us-ascii?Q?EEi0tcvJCXyf7GJH/koFSmGdHWxSgEbuAXQHWC4YmhevxK8ZdpaOiFa9NXT6?=
 =?us-ascii?Q?xekjhB6XCnnpA0TOrCk515I33eJRi3/ZG2wAQD2Bi2SNofkOkc5OUnpiE2LO?=
 =?us-ascii?Q?bv5etVbE+1Mi0p/1BsEvr2FkwD0YwDLx6bpEDCNQmF5J/o+l1o0mzKpDlx5G?=
 =?us-ascii?Q?DPYEWXVYJRTKEx5/gvsje3ye31EgqoL8YPCQKo+n4SgFp9qiRseVNUzlASyL?=
 =?us-ascii?Q?QFqT7MkuR2pa1MqflSyGOWuURkoPYh4g1XJHZ/tSdytIprJf5Vd2lGkisQsd?=
 =?us-ascii?Q?h4K0tRjUEIQZ54A0qDb03nvueQrEeihWxFAK9/fBO3mBqvMGfpCsGiwlMejL?=
 =?us-ascii?Q?D9RuP3tEWf+3ZlQsnmRqWESr7MoS/u5RYrllGbpcH3lKIDu5xuSY1Hk0WNdh?=
 =?us-ascii?Q?SOTV5muAKuZc7wm3V0VUYI2RdzhL7w02pf6zQl7kQ1HB4UXGsPisMOCvhIu2?=
 =?us-ascii?Q?djhYaIL/7CAKcZ7v9qi5ZrMSkZf2Pc5GXHTlVeFTaZoiPMTH0ySEXecEW+kr?=
 =?us-ascii?Q?ofxs5L1ILYm1fx0tJ/DQebmlMRS/XSyFEqaRZn7mUde3wPFnMAPkUhR0849W?=
 =?us-ascii?Q?FqNxNwfw6AExjPiKqr65NxH+7VmNmv9DMxqAwF16CPvOFsYg4Y9FKM9dH++n?=
 =?us-ascii?Q?2hKJSk+c1R9SJ11WRmaTargY+WRFMYZBdKX5VJHqJXm0RxiCx7HKru+a6KmJ?=
 =?us-ascii?Q?d4aR4dP5j/xjOGzRn+cdx1WRRhpx9uczz5QHfgrSIKBlGDAfzuEtAf0osbDe?=
 =?us-ascii?Q?EPZPxaekxpj02cN0gzYjOlcAlrQBgQwvXN3McAInhJVJgdtAnhqoclx8wyOV?=
 =?us-ascii?Q?8Kdah4qgznKkw+gOg5ai8w/ETpYpcP49aRLTJ6nAuliAD7fBZ6MZFEH2PpL6?=
 =?us-ascii?Q?vWG2UlbE2E7lvjBqL4D7t73VqD1/BFQ69GhT2ZNFv97SPyDa0OUaR/rlbJwf?=
 =?us-ascii?Q?I6tG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2021 09:27:40.0589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-Network-Message-Id: 31788afc-3ba9-44e9-bafa-08d8b3b7a50e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDxhHWdLW+ZZaErVSFgh3vHJNDlDPGxizb6dsrnGNkjBTHVNoPRMAgm/KZo1YfWT8d0spPWjkOzyG/OZYWB8lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2652
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This property is to indicate the endianness when accessing the
PEX_LUT and PF register block, so if these registers are
implemented in big-endian, specify this property.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V3:
 - Rebased against the latest code base

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index daa99f7d4c3f..0033c898976e 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -39,6 +39,10 @@ Required properties:
   of the data transferred from/to the IP block. This can avoid the software
   cache flush/invalid actions, and improve the performance significantly.
 
+Optional properties:
+- big-endian: If the PEX_LUT and PF register block is in big-endian, specify
+  this property.
+
 Example:
 
 	pcie@3400000 {
-- 
2.17.1

