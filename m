Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE8827CEFD
	for <lists+linux-pci@lfdr.de>; Tue, 29 Sep 2020 15:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbgI2NWe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Sep 2020 09:22:34 -0400
Received: from mail-am6eur05on2049.outbound.protection.outlook.com ([40.107.22.49]:38110
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbgI2NWd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Sep 2020 09:22:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TnBgeGJNUEBYN1c/9C40Kd6XWmGcg7HCuxOFmcE5rs8Kd4T1VmCsNEyiL4Vi+xYkqAu1YQigusbUk4vgxoSkB/KJfueWDc4dyAYkaPYtHw0+x4lm23w+MPjcDwfoErzhe+C8yRyDrCJbnxkFwC9oQGOmMo0o5D/jqjSRvvGB1+zjCmu+GkCVdOPEhH3BYq5pCHrFzLvdvecZlL4NgWfgPID5S1LprvDrVRo9z2rsVO26DTaVlsyjUJ0yq88Aky2Xdgcp+iZje6CPkVcoo/0BYLR//9mHXHzxHdvk9IL/RCmH2rYVljXSLrLR7pSGgp5XHS2tsAR/M9IRuawS9s+0bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjzpdvIK11BRHe3ydrstdDLZBo7G6tPqvZuB3pbI9Ls=;
 b=mUyqpGrwZIy1gYx+hGWGUIMpXj9K60h+f6UYBRa4PwyLVRDAiaaBRXHyeU6Kg6KG8IEE9YcfScRrAfX3zAG/BLxpq73ov6FLp0mv308LQxOzaBFJtc1y/0W52QCcVT9ndGbCMCmAxl0Yh+wPdJE1jl4TlqL/oWSkK5hb9y4jfrsG8NQ9YBlc+tCA/Dw3RsyJ1gbYqCf2StS1+MUsydR3Ox90POOesSuu7yxbqyGFJLAix82CbNMytKMhV8lRAufm3fCCy2aABI/yDWNAINC18wtcRvcoNe95/AqrKgEuvRXPkRaBWPQNQqC8TG84RK32o2EAWNKswriAiu7Q82rFgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjzpdvIK11BRHe3ydrstdDLZBo7G6tPqvZuB3pbI9Ls=;
 b=qZ9fmyVANwQy3ex0TfdQo20OQmMmVFnRgxcnrpcFWrwaOM2ozpVDud1Wern8IDd/2H+DNm3qfFq1aAzv6c0JQMWXjjpCZUC5cI6MOMmEIl5WQKupxBUszterqWSHn38w1sJGsQteuPmqw07v5ekxnzCoJzE8EsxW2QESSVBGcdE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2379.eurprd04.prod.outlook.com (2603:10a6:3:26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Tue, 29 Sep
 2020 13:22:30 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::c872:d354:7cf7:deb9%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 13:22:29 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com, minghuan.Lian@nxp.com
Cc:     roy.zang@nxp.com, mingkai.hu@nxp.com, leoyang.li@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCH] PCI: layerscape: Change back to the default error response behavior
Date:   Tue, 29 Sep 2020 21:13:28 +0800
Message-Id: <20200929131328.13779-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0246.apcprd06.prod.outlook.com
 (2603:1096:4:ac::30) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by SG2PR06CA0246.apcprd06.prod.outlook.com (2603:1096:4:ac::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend Transport; Tue, 29 Sep 2020 13:22:25 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8fba8ac8-9b37-428e-c602-08d8647ab6d4
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2379:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB237927758A9FE5A95EF855F684320@HE1PR0401MB2379.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QNF4U/TCedGsSnnsMRIHgL/3tyjHjE6jSbMEsynKlgbd+5NjeYdJXb/jsulR37zUwIG1l/Rq4aH/DQUbGeIpTa2J3dx/LDLPXV1+qXlZOhnI45ipa6B2WzEFJUjwMv+jsOlcVICeS70CDvHgKH19MnDg81gdWmMI4Vnjd5Ikp/tpmKL6TZKE33WNpFrz7SbraRlVGGkezs1tHf/s7omU90Cmf3GaRBRQsYMBnDlhg6LJdjY2bU8HIWFP1B0G/CzSafFsqVmAUotWXXgC9lyIUCYYOeR2SNogxSfLWxEJYK+1vu2hqaj2bq25MJ5UBn/9xIao71qVjJdPDv4Xh7te9t8Q+rECQGDZShToOBz8kOirCE95le4v5Sgvs6tSssty5ZSncVQNTBOxuLlkkqZJVh2Zi6SQ/6UQLd6fjrsG8Hc1gzJOKyZo4wJepnh1z+G4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(2616005)(478600001)(8676002)(8936002)(6486002)(5660300002)(4326008)(66476007)(66946007)(66556008)(956004)(6512007)(6636002)(2906002)(16526019)(36756003)(1076003)(316002)(186003)(26005)(6506007)(86362001)(69590400008)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uvXRNRHjKhLyyg55B085oQbO5Yc3G9dTpexb8qCC4DqbB4UyQkAV6+xktWF2XNv+jPaPuW+3GEFwC79oE6QbuaLnmpYaa5kHPzSNqKmhAONQO9obNhFVd55t2WBBkBDGUzDP67uIfXvxFc/3baSXV6Nw5B/tTIAodwEw93JtejmqxuW3S2cf1etPSWMiTxK7S2GlzTTO3WaD6/RuIVXUJlqRynHgArvO6/wH9bmDNRnP+EKseR2jjUXKjFyQ7en1uVtFFuRx4Plabm6hYq+1usA7kQ3CpJitEMeL03ZVIGBqPiJqA6YnSvra5Ua6gEHFz9pkJplJprAatHmyfRNxvBv2cHzgfcz8CUNZxQZ7McSkHYn2k2+H0JJkEuLindN5JGatHievpAs2+CkpnF1szfcJX7B/gWdpDDyyED4PooIessPv1JBLWhj7R06zusyH0iQG/YBI597CtedY/HzbIHvw3xfTBxUryTIgSOzhbTlrHcRG0D3JDuIaeMjDOv+2dvfUqOdEENyXUl1RHy81HQdcSm4kCs0woFZJXildwGjYIMKn8qQEaiGTKwo7rN2k5W1wDy0XHfYsiTS1IsfTVqcMhmlIRzEJpaB00yRonN4jEJS7RaqxliHVCYozWTPOSMK6AbWF9Seeh6TAYVfnew==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fba8ac8-9b37-428e-c602-08d8647ab6d4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 13:22:29.2878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nJXqdEWx6pYxDkFrcyGNdJmjGXc22G/woUTfXiu9n9lxN1A1Pnyv3cOTVGJfvZ26UtTf5aG87VLxvQFgLS/Igg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2379
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

In the current error response behavior, it will send a SLVERR response
to device's internal AXI slave system interface when the PCIe controller
experiences an erroneous completion (UR, CA and CT) from an external
completer for its outbound non-posted request, which will result in
SError and crash the kernel directly.
This patch change back it to the default behavior to increase the
robustness of the kernel. In the default behavior, it always sends an
OKAY response to the internal AXI slave interface when the controller
gets these erroneous completions. And the AER driver will report and
try to recover these errors.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 drivers/pci/controller/dwc/pci-layerscape.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index f24f79a70d9a..e92ab8a77046 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -30,8 +30,6 @@
 
 /* PEX Internal Configuration Registers */
 #define PCIE_STRFMR1		0x71c /* Symbol Timer & Filter Mask Register1 */
-#define PCIE_ABSERR		0x8d0 /* Bridge Slave Error Response Register */
-#define PCIE_ABSERR_SETTING	0x9401 /* Forward error of non-posted request */
 
 #define PCIE_IATU_NUM		6
 
@@ -123,14 +121,6 @@ static int ls_pcie_link_up(struct dw_pcie *pci)
 	return 1;
 }
 
-/* Forward error response of outbound non-posted requests */
-static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-
-	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
-}
-
 static int ls_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -142,7 +132,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 	 * dw_pcie_setup_rc() will reconfigure the outbound windows.
 	 */
 	ls_pcie_disable_outbound_atus(pcie);
-	ls_pcie_fix_error_response(pcie);
 
 	dw_pcie_dbi_ro_wr_en(pci);
 	ls_pcie_clear_multifunction(pcie);
-- 
2.17.1

