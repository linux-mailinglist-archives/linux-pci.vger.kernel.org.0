Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFCF314CDF
	for <lists+linux-pci@lfdr.de>; Tue,  9 Feb 2021 11:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhBIKXR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Feb 2021 05:23:17 -0500
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:27009
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231566AbhBIKVF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Feb 2021 05:21:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL8ZRz9nQOdU/hbMdXL/cFMQ6q1aS1j9gCtESmpMbibBq0dfYiiUssQ+03KrKfpNFdhjj75hOGhUBCP0Ba4z2UR1Mww2kyaz2v87fDdG1v2Tiv1oPgLes6c/89pCtWSmMGfFOZVZGFAqHVN+42P6aVXS1GKQDTV9GXOVOZNlcLtfpJuPsVMS9stgtseHtcY1WdZugKntIx+5y+7yipZK1ZfC/ocNcq4kYBbAHxKeysLpI4sQqdUn0tUyGG6Ap7ttoYh7NNJckqSUWeNI7rHE9fL/bbxAqqZ+SO+N5riHnULAzLAH+7IwIHeFeUKfO4t0g9W/QLhC8jV9MpbX6sPV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAJBDMZtnz/3Nh7sg7WxEhIVfhctbv3mMSkZ4//yYx8=;
 b=XBnD3SSV5YEhQRBR+qXifRNiLZkKtwmbMT80c7DBGyhRFVIhcMY3ViwM3TDpZdwauK4O0jU7fhjGcHaRZXR+1ON49B8h3r6LVV2CcXrzbTHFv0jwmeCJq75/ircWV5NLT2+P3MkMRpLZsd75UpC8lQCBRWYYdNV/8RrKQBE41CPsPP89JiUwh9+Zq2fmaTZdO4vkUNPGjWe+Xrr0fLMtDjCPDNCcq6lkMztx03NhXyLKNvJ3VCwYIjh+wEUsl7d1mavk097jqHbq2dDNLmIq8z34Px9C9yVp1iotu/2eTih0glRXfadNwbnctSk+LyMkqxEv/2Xu1dKrBMJ0rF1WNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAJBDMZtnz/3Nh7sg7WxEhIVfhctbv3mMSkZ4//yYx8=;
 b=VhNL4qBQLIwBPgCf4cCzv7z0tex0uGmmg/IgaA5sI9+WC/B+8J3xSUKNBDslGPYqDvYf8lXPK2WcDN0Y6utFhnPt47asHdhI9gjj3RS4mh+NVrEAh7q8UgGP4tI1E/fHQtAFHQ8Z8PvDuLrguDfmv76lfHXgf0fA5t+icM0HmBg=
Received: from MN2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:208:234::27)
 by MW2PR02MB3788.namprd02.prod.outlook.com (2603:10b6:907:a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.29; Tue, 9 Feb
 2021 10:20:10 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:234:cafe::99) by MN2PR16CA0058.outlook.office365.com
 (2603:10b6:208:234::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Tue, 9 Feb 2021 10:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3784.12 via Frontend Transport; Tue, 9 Feb 2021 10:20:09 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 9 Feb 2021 02:20:03 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 9 Feb 2021 02:20:03 -0800
Envelope-to: bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=53404 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1l9Q7m-00007p-My; Tue, 09 Feb 2021 02:20:03 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic using CCI
Date:   Tue, 9 Feb 2021 15:49:54 +0530
Message-ID: <20210209101955.8836-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b00f2a1-75f9-4b7b-1786-08d8cce447b7
X-MS-TrafficTypeDiagnostic: MW2PR02MB3788:
X-Microsoft-Antispam-PRVS: <MW2PR02MB3788CC11501B44F7F93804F3A58E9@MW2PR02MB3788.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 29N8MwnkSCZ2FPVozAUGuGDV8a2k/zPXFPYgpCDiF1MZDPLtR+aCAMPkgt9cby1Pr/Q89behV4OCpOvV+p8dkAA51PzFvhLA+NkR+D1mPolX/Bowlg2XDiw6aFtzcduC3QjmyhFYtS1xv5lDtWadd/FeZPlGqqXPbx0M4dqFT6NIaJDdkkxbIB8dO0O/5CCVIqELBqFA7srsU1TP48XizyrtM2CGmFKGTVJoJLyAHkGTec2w8LlygjPdLLVHfifMR4YdM1tpg7LcDheVe2C9MLFz7ieYm70nWH8YmXL1/g247KSY98sUB8Yj8T95v9UyruyJrTc48h9LyrhBDsBo85q3xIn9zUduXCfpmHY4oQ3O9VmKaYLnrVQKDo3Hw2NRq6Atgy1qUXY7X1XcDNXVHxBAYrJikNxGdUGEuygR1Q6xl/i6UkLAtoC4TjGGZY2uFICc/vCkDR57HrgXFHZLTn+se+4duygw+SUp2hNdjtJgR9UsdFgJWlGdv1Oh5E7XcKc9/t6MtJjbt1lhnMeZVv3SgG3EdjwCg8VFrqriWH/BgdC26vJIhRX8fqbeWJWN4B7u2qZd4RHdZRYqDZonnocU7C93AhtuUr+nVp/vcXE6uTR9embzkQ5SL6tjp9oOHGzDbmJeq2848xtkUOcZjAP0zxvF5amBKfXG1z0reLwQcfS5yBOgEJ3Q+RJf3kyCSl3juT4SnXT2sZESll2spmGT6TQZMPlZ+wLCtrjGB/zhCw9su3J1g4Wa5Hmbw/kQzeV8HOGFOgNevdwrZyj0EQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(46966006)(186003)(9786002)(7636003)(1076003)(2616005)(36756003)(316002)(7696005)(6666004)(70586007)(54906003)(110136005)(47076005)(356005)(5660300002)(70206006)(103116003)(36860700001)(82740400003)(426003)(2906002)(26005)(336012)(8936002)(8676002)(107886003)(36906005)(4326008)(966005)(478600001)(82310400003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 10:20:09.9227
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b00f2a1-75f9-4b7b-1786-08d8cce447b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR02MB3788
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for routing PCIe DMA traffic coherently when
Cache Coherent Interconnect (CCI) is enabled in the system.
The "dma-coherent" property is used to determine if CCI is enabled
or not.
Refer https://developer.arm.com/documentation/ddi0470/k/preface
for CCI specification.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 07e36661bbc2..08e060574cb7 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -26,6 +26,7 @@
 
 /* Bridge core config registers */
 #define BRCFG_PCIE_RX0			0x00000000
+#define BRCFG_PCIE_RX1			0x00000004
 #define BRCFG_INTERRUPT			0x00000010
 #define BRCFG_PCIE_RX_MSG_FILTER	0x00000020
 
@@ -128,6 +129,7 @@
 #define NWL_ECAM_VALUE_DEFAULT		12
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
+#define CFG_PCIE_CACHE			GENMASK(7, 0)
 
 #define INT_PCI_MSI_NR			(2 * 32)
 
@@ -675,6 +677,12 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
 			  BRCFG_PCIE_RX_MSG_FILTER);
 
+	/* This routes the PCIe DMA traffic to go through CCI path */
+	if (of_dma_is_coherent(dev->of_node)) {
+		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
+				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
+	}
+
 	err = nwl_wait_for_link(pcie);
 	if (err)
 		return err;
-- 
2.17.1

