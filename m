Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764F0298659
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 06:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1768394AbgJZFYW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 01:24:22 -0400
Received: from mail-db8eur05on2075.outbound.protection.outlook.com ([40.107.20.75]:28609
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1768389AbgJZFYW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 01:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V96W+uUNddUJakmrLAk8CxffVJqyNAObvsw+AnaAZNaSz6/E0/0FMrC8cQh2O2/dsOsYGpEqIjvSvpjRhYvYVBG4TgODlqQ0SQXr36WRYakc/EidZIp2cWGcvm8ATg7MHUjzHzgXZi9u421VzgOd9+Hyyxu5AGQiYP3Qnyp+gZYO45XmjyOfgsV8qSqbJI1s/d7OBOFrUbRQhVAV+ZIrSPUE/3xL7HndVrSOCeSfjqjcPSasUixgOsNZBzK/G1Y1m2iXG210c2U1vTuhQF7ZsGIGn0LlKbgBTZZBgGNcnUtvVbO/2Hc8oMjJfmK+GVrTrBGtFW9fIQoqYW6xQpkwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O3qfUpw8LslTuiusux3tVKM04T/wwBJ54Yuo14m6HQ=;
 b=kRPeD/RSGCwPp7DmNb9upk+So1uN09bQjhK2lcnirF4rZBE+M9EoK7sYiy1kFvdkFl06Tp7zN0ZHUZ1vqCiFRqI6/Vt7dG/QpLJU0/kpDYH60+Dwx1h6otzQqTqzB8LIQMmEYM1kCFL3B9cSsXK4EysJ66nsdAUKPtQFZIMZhEePrszvrE+agGiaoSkJhnT0F0aGehLYOJvs99itaHmPmcbV2pu+nOvT484SWMPOmHdFW1P8FPFHmI89dQP3pFWYgw6hoGIlFGApdABrDnhclcwiq2OF9vcyo0l5ANOTUOkyh2mEf8BPJ0n1NuVo+whodUzsZkjqP4rzw6E/s6H6RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1O3qfUpw8LslTuiusux3tVKM04T/wwBJ54Yuo14m6HQ=;
 b=YHDGdxlL2HSFKl9ciNJ5P5j2E9iWEZAMKz8kuJehDT51cNZhHgqre+41F5JZlJpoMM09K3cOK1CKpDG/12KYplFzzmbHL1HjbDvdMP4f6uMHj4byu7UonZegr1vGHFP4p/G6qekyN8MDKk3mw6b4nR+u2xL1MwQgi1YDEShNH1A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2299.eurprd04.prod.outlook.com (2603:10a6:3:24::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 05:24:19 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::f882:7106:de07:1e1e%4]) with mapi id 15.20.3477.028; Mon, 26 Oct 2020
 05:24:18 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bhelgaas@google.com,
        robh+dt@kernel.org, lorenzo.pieralisi@arm.com
Cc:     minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH 1/2] dt-bindings: pci: layerscape-pci: Add compatible strings for LX2160A rev2
Date:   Mon, 26 Oct 2020 13:14:47 +0800
Message-Id: <20201026051448.1913-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: SG2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:3:2::28) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR0302CA0018.apcprd03.prod.outlook.com (2603:1096:3:2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.8 via Frontend Transport; Mon, 26 Oct 2020 05:24:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eda47b35-abb6-4592-4a83-08d8796f62ca
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2299:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2299378B1B1C0F7C06A22A2184190@HE1PR0401MB2299.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzxY65pd68qCOeNmL05/jNLp80VBjo4q5LR3rMkEtKcVKbiu6oC39jVVl8r8BmmnPtZWh0XkdLX/3IS/xpyibiDnUrBhfcpc/Gw0yXRkdqTe+xfItDcVEF7EU2x2tT9ctdtPhThxCH3kBqFzCSHCxcWG01GmYQ9s3XENbtj0bpElht7evA1SviAwNTm0MQdCEFoELKaSWpZntBRVrxTwb+k+owDNdy1JDX6U//mj3SZiIUrusXVF5SnKQ1UXrOhLTEvK9I+uRUmL/8mR65W5yFZwvVBBoNqkmQKiZJMYzE6DRAzMhnWK+Y2bQ36u7miOb8Ms0xz+CV7OxKjAEFNfNh0foPEODMgkeYRKbEPU+O0fuFsSyzZQmzWHRzL66a7d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(26005)(86362001)(6666004)(66946007)(66556008)(16526019)(5660300002)(4326008)(6506007)(36756003)(316002)(52116002)(4744005)(2906002)(478600001)(186003)(69590400008)(66476007)(6512007)(956004)(8676002)(8936002)(1076003)(6486002)(2616005)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rI0E9NAVBg3F1uB4HWTqsZQQj5xACds8NstgI433S7XWyrcOJJwxEi3Yiha3fTdPHoX197Q9zNhYy3mEvmxsTV84zBUT1k+IQMDA6xJ2Cwf9ZVbAr5KPuNvKhmr80fqE+QGRGoQhs+oh58CNOs+qO6vdT0Otj4TM5/0u04wMyJIAS1Uj4Lws/PzOyfqJlFe7BWpRo3m3DDlXV2PP0P9MgGxFQE6LH9beA9MVi+MYsz3Y4D9Z8rY+Soy/Msz4GPyEuVwy+VM5Fa44B45t7sCLNhHBw0evCyWyRQMo0HZvwEy7JpjeG0/qLYqZ1cizmBlbML9taA+LS0TAwG+YpaYRG5ZrDDK6rdFuN7+JaQhidL11zMSXWvUC+aLOQAX2m0uD1c2gWlUlXPbLBUf4akQ6n2lq5UEhSfl2iUYjM9sr/NPhSxllVCuTSXgLHua7/jvEgaeRi8N79EaqD2f3n4TA4l4gCOSONGuuvZwH6hd2mu1oYqR7lB4rTp4Tm7iGhMGxk8iOSml8TLKW/4/LtnCBEJuvSplDQmEzXKe+hXMVcqzFx2R4hDalsFE7JIJDShjS7JWBCU3nBLaOcQODYqjpcBnAk8dwLXxEpGsVf4Xs7vklQ+c2fP5lqs37w14a4n847U8gXGnjf5pwW7551PMf+w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eda47b35-abb6-4592-4a83-08d8796f62ca
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 05:24:18.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E7w7mENcfIdsOGTrQJH1ZSV8MBPCP04ZooSPZdfhQDO++w34us5khThKzzKyU246zNxOs97IZhI50TFT7G/9nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2299
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add PCIe Endpoint mode compatible string "fsl,lx2160ar2-pcie-ep"

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 Documentation/devicetree/bindings/pci/layerscape-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index daa99f7d4c3f..6d898dd4a8e2 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -26,6 +26,7 @@ Required properties:
 	"fsl,ls1046a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls1088a-pcie-ep", "fsl,ls-pcie-ep"
 	"fsl,ls2088a-pcie-ep", "fsl,ls-pcie-ep"
+	"fsl,lx2160ar2-pcie-ep", "fsl,ls-pcie-ep"
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- 
2.17.1

