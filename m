Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A227029A5B3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507995AbgJ0HoS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:44:18 -0400
Received: from mail-vi1eur05on2056.outbound.protection.outlook.com ([40.107.21.56]:29377
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507990AbgJ0HoS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:44:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZ1YfqR8TW39YwcG+69sVRco4amvm/XxS5JG+Y+FumAdnpYxMZ7ABNTJ+ZJTJb5blsRmo4LXLS5PTwnzNVmhXZZuqYUw5qRGzPSW93vMuXjrw9YhvZFWEHcKJnbvBAm39SGtnbBtRlRzZ8ngQKIvMaYIe1uuoEIywoyYoKdxucSnYPmcpF3VAE2rdxdi5rRaFMQsAKr1TB2PJCkekAMm0JWH2XpwK0tpVpioNRhK2VqTvgcc9nAvAux7SYLaAX1o+Sw4Iw2kUbHmOttMr+WyTYgadZc0yPVINxHadtyh3bRvcPKOvXljoDPz9j8eNpYul/mVrSw+HOIXTgjxkNsi3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jam39fFqyA/nzkn24XXLMaYiMtAQRjPcA+ORlQbXaG0=;
 b=jZfule+PVJEy91PEqWZxOzSnq9BOh8kzW/V3tk9Vfa2XqFfZiCLE6mDsrte3cbzP9B7OwCgKYxlt9SK73Vk/a8YChZTKtVdEeuw54DvDbZYSpS145k0COaeVY5wsISgpMQlD2F55GwGUGlhUUUdtzNiDBGD0hPwIAEINQZl50uo6c0AoIzrBTzgQl8XDCqLeLYo9Pys7xcUt3SnEp7CYAP2pmYZvAZwI8gqIXWbS3cEDo7RQwSAFJzgqdVCRK7U9YKRaXmYA0OeeSAb9J0KUkKxeazOMi48gV9uXL//z3a/7pRF+pjTXWCXJAtK6sDoBX1DjEJEzd8qXg5T3q7n5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jam39fFqyA/nzkn24XXLMaYiMtAQRjPcA+ORlQbXaG0=;
 b=kiPaHc0Z06WZraevFDvLz+CR380P/VqzKURQ3/5mI0SdKoYIa7w/rHu2gEwk7pbqQarz98vlPVWKGeUUFr41om50FvCRPfg0HjEFGIVse0vDjwS6C4xECRUnLQptjPUq5p91hUkCMNje5+3mYakmeRSlptD4MUOSY94xtftuxww=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:43:14 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:43:14 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 5/7] dt-bindings: pci: layerscape-pci: Update the description of SCFG property
Date:   Tue, 27 Oct 2020 15:29:59 +0800
Message-Id: <20201027073001.41808-6-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
References: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5d3337f5-7036-4408-ff11-08d87a4b7fd4
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB3371121D88EFCC67AAB36FA484160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnrwP/RW2sQG5QMQ1KrPgq+fP9BOQzeApsn+n01bBC/IXx15IgVo55kKH+0ULcAtoOlQDHy0yHdaodIJP27Ct1fX7Hvu/d65ZrRPCg/+RKCoZQ0CSBjdgsi/XVb1obKLOr5i3pFlrxQISxgQ9eJP4rXb+052i9keO+1uXh4+u6inW3LYORK+QzasV7g2rwZlZlhYJ20q+KanNhJHZnebTlmcF28l17JfxXg+doqK2FzuNW+m1/+S9kh2qC06P80ORAfBB0OXi+n+KVuhsd3RJdd18ODEo6ic/6Ngcvx6m25Y+aIj+u/M0ydt3zM8hIPuq+Uj8bmXeX87NxfAxLdBAidGR695IZ1omWS+11fU+yJ6LHkWyW1ckrNz+5dovg66pj3MBKlaLSenmGOwIEq10w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(6486002)(6512007)(478600001)(83380400001)(36756003)(956004)(2616005)(69590400008)(66946007)(66556008)(66476007)(186003)(2906002)(8936002)(1076003)(8676002)(15650500001)(86362001)(5660300002)(6506007)(26005)(52116002)(316002)(16526019)(4326008)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XuUH0p0QHO/y9cjkmoubmAcWJX2emGl1w/IgwDYOdW7u2Se3CjEWepFQ4+kRUHC0F9R2Rs5Hco6ljS8GU8s4cEG5Vw0ztIPpN6uvmqopa3wpH2MHDRdC8Vyt0BHalXFqKSzF2juVuGv1WIq+iCvyH4jBccn6JEIbvmdjr2YDvvkYV18u93mFAjOwumB7WERdqzym7LupVuMcnsOHTZNnl0zA1fK9vY2eyMZrTRNEr294ppFOvaVoN30RWcG9ozVpuUc5t9gW5AJ0kI3BMPXh0Kj5kJq78mdnTN7PED2PKRS8zVNyCPQeFr96JL1nXAndfFKO5iwY6BEDFv36Ubm8iIIdI6IA5pbxL9ZCVqs3G3jG5+LZ5e5pZbtdD/IGbCCFdGcnjn9kMA0Jgc1/waMz8PUBkJq3Hx09sgou6ibgVm4PpIS0I/zP0BM5Gp0yjiRADbE/NRwkoG8J8XWB33BQ06zUiVBUu/A/mdPeacNW+2r9CpB1Mgn/0cNG49ELk8U1lXjmLyfXfnruKM4yVoiXn8OwqaegFHqDLu5b/PQkxvddAl/KuoPbRvPZWT00ncovGNyICrpCOJv3twAqUAroB8qfadJilTk4rAkobLHZdcNXTF+zzS+HYo4zAmm55MuJjm6VhfK3wTNcIalY/Itg/w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3337f5-7036-4408-ff11-08d87a4b7fd4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:39:56.3263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KgbGZb71KK/+MYfxw23FW947II88IW5Xe5a4DIjTeW3eZAAewT3VRvugpJJM1iQqMJiIwPShWfQnJnQzy15L5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Update the description of the second entry of 'fsl,pcie-scfg' property,
as the LS1043A PCIe controller also has some control registers in SCFG
block, while it has 3 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
---
V2:
 - No change.

 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 0033c898976e..4228562be505 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -33,7 +33,7 @@ Required properties:
   "intr": The interrupt that is asserted for controller interrupts
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
-  The second entry must be '0' or '1' based on physical PCIe controller index.
+  The second entry is the physical PCIe controller index starting from '0'.
   This is used to get SCFG PEXN registers
 - dma-coherent: Indicates that the hardware IP block can ensure the coherency
   of the data transferred from/to the IP block. This can avoid the software
-- 
2.17.1

