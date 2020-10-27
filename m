Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D12C29A5AA
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 08:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507943AbgJ0HmU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 03:42:20 -0400
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:50144
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2507940AbgJ0HmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 03:42:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVgUyI+WT3haZBT/jQkJEhW1KW4Ad1vmRqGWu98voOd1cHA/StCcXNoQWJr7OZHZAkfShP8fqbvCXj1OLK3btJZerqxbh+iMp9FLmRqUzASmFiplKD8KPW6g8jkWAFTcZdaCNNNFY52nhb0NLnn6zv2CwgQ7l7R2vn1xLV8L5ClR9ceGjvWYeadgB+ikNmNVEO2TtA70YH2Ss9BfE2C9W5KhGgHyzuNIhgAGWI3CK5kQlMgBtNOBtPQoTYEVn5es0NinOinpsGDKCePQmDdP/OUpOGM+XscggeRH3qkUIvcT8xqO4h3xlr17rXrXwkLLsmjHS2h0jAgbC/riKdQ6Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgmGd58G/NWc3kA6pQs1GSF1desYjmaoDKf5hDKPHEA=;
 b=nQq3JUdqjaZnr7t4LXRqKwF5+qgJBKv4VyF5x1c/xkElz+vMB5nX2Lk4ku27Kj2oviEftt1Gn4Qz/j5wnAR6Xg+gJ4esz6zWhC8n2wEKJ0Ad3VjoHZnlGd7MP2UJeShPRCVdlV3eZmymjfnFWTJogpFxe8VtiA8vQWmUuc6ZQZNhzPo7K37X0APBwIGcVFESjYWV8xsTbW2iM5nqBlNF4UQMFWqCpxTDLP6QX61C/fOBm8rFHWR4qVh7n4LuSc6SmPfjds9oei73YOvgye3Z+dglrcVJ1kGyzTFWH+/5az3GGyIc5XgMnNFBrNVlYD7o500Z6pDQNT3JvorYhY0Lyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgmGd58G/NWc3kA6pQs1GSF1desYjmaoDKf5hDKPHEA=;
 b=aVmHU+FdsuGXc60xjuVctxQCKEPc9D4QszEQ5GYhm0y+X0/tuJ1x42bxVVC2oF+5o/gGR2q/GrMTQeFdv1kXdYqrRoBHPfDHv0j9ZJ+gJp/aPiqwDSScR5etm1W0NR1fUykZ8bg9NhyRG2cyjHp9gBCbh/k/XISEKh5WaDmC09M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.27; Tue, 27 Oct
 2020 07:41:21 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 07:41:21 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org, bhelgaas@google.com,
        shawnguo@kernel.org, leoyang.li@nxp.com,
        gustavo.pimentel@synopsys.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv2 3/7] dt-bindings: pci: layerscape-pci: Add a optional property big-endian
Date:   Tue, 27 Oct 2020 15:29:57 +0800
Message-Id: <20201027073001.41808-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
References: <20201027073001.41808-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Tue, 27 Oct 2020 07:39:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 27949b19-062f-4f32-4eb5-08d87a4b794b
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3371:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0402MB337103379527720744DB4AED84160@HE1PR0402MB3371.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+zUsVMYCrMDIycO9L80HzaoOb6tlm40D46ycCIt6xhNw8mk67mEMi8IoTFr/YPB4jAV1O8lAMKU9TJcRSGVTdR+1XpqUkRyoAPcphK5nQTO/0zZqp/bDvCUy7NPG4hhACYgEa79GTGJfgPw9ahcvBrXAbuBa1sbyQpqP3MwSwTVAC5KQAa/KqqyOWr3HvRKq1QpOZz8X4GGpq4+on1J6cOgqCKE9NEo4v4ve2dlu4TfFoF/vzgO+xscJ8WVhumiF/N0DUenTjR2Pk8qaABIIGnnEkoPHRKk2EbxcguDhG4950f2WR67jYp/5GZRf5ZrtWU9v5ftQBG41GxV1+VO3o7LSx3VHLBjNnuSmjxFXoVCmcPFG+6u/3kSO7REZ0cDyIm3Srf3a1JOh7EMZqc1NQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(1076003)(8676002)(5660300002)(86362001)(2906002)(186003)(8936002)(6666004)(4326008)(16526019)(6506007)(26005)(316002)(52116002)(2616005)(36756003)(956004)(69590400008)(6486002)(6512007)(478600001)(83380400001)(66556008)(66476007)(66946007)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N80xbcbm7u6SY617svPAUNgoLxBlzFOZOLmMc2VnKwjZUwpUW4zKU5y9OuMBeK0FJVteuG4lONw2MYMPH6C5H7sJAnp7HhHpPpWPsEo5evgZeydxfirHek6sLwuU0bfC8eT+SHPvsfETaONKXER/5fBoTuCuClJHr35tOxXE3oRRdN7ASkoqWkRAKlJcpCbodGwVQMEoyZh+kICgqSDPslJjwwmaOUfaFg0Tp5Y6FkLV5ehm7Q08ntlzUF9nhKRhcJqAuvu2dREYYtGCxIToAdSCC0al6EuOZVjG2oh/sauUVJ37dVZRZqy/ToFp+51EJ8WZVNDV8igzpDZGzu28u04KX8sHwPwKxxJs6v5lM/DNGZQG4bEci7jLe/5kK57D+cAM5kEhkiOQL2DC11TZMLfIMl62jXXWWO3zF2OhrF8nKGF7dt1q7MLlYzFnXp4htR1D4OCLMuE3teecmEEMsBKT52Ri5XKJsFh0JAn0XapGTdrFzOTE0fm1Hogcu3gT0cBZQOwjH5i0qmiR4sfM/puqKpHwaOnk9HABCXJAP1X0rM69KRU2jOMA/HRqkuQw8Hxap+7tV5/xPW52/HB29SOHPMTrKQhjeRRFOS1FyXmPsjUmDD2Ett1hCi1UWFc8RtU1sBIEyXigrRFCR5zabQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27949b19-062f-4f32-4eb5-08d87a4b794b
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 07:39:45.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2UZVWCqxduxQLLnGxSKJIU1EP+IlzWO1Rd/6vpF2cIvya4tKrQJ9jrUjQyaEjjf0+U/3iZsTMprjrazih4l+OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3371
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
V2:
 - No change.

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

