Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0472C32123B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Feb 2021 09:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhBVIs2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Feb 2021 03:48:28 -0500
Received: from mail-eopbgr690056.outbound.protection.outlook.com ([40.107.69.56]:30354
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230060AbhBVIs1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Feb 2021 03:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i17Hykr5ZyTrWA/hrxRvk39Trvsbp90ZcldmamKE2zgkm+lCaaPcV9BN+4fLMiXassPaN5jIpqT9h/oB8xenhdBAL27CTGCzdxybKDMH+eozQhggCsjV0YLE/ERsrXikv4LuNMiEIGBDYlWrC5AilIqDa+atp22vMJBO6XuxdNaZOfRgx3eFzmBnA5JQNPoOg/r8nNS3sMcF9y4ilrzY9UE955BvG7wyzm0G7nwF+I4NAXqg4VkI9HeBTB/1O3BwZ3WbryypkR2toKIT+7yGEKG+idlwAMQIbFLu/+9aa+xiAX+pUV8Nr+EneRwsaDV437rVDnC3e/EDfqrlD5wMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmLMXEyeKFpgCU/tGUHhLhmVXnLHKxoeOimHwef8gMY=;
 b=Es9XNZHFeAsQL4TfMVQQzCp9/Z1gCbThnQUezqiAe1SFNTulgUuRWD7/1ZWDXSN2G6rxz8ai/jSuifdYhQJHaCJOAReESUGwsSBYmM7NhMPBlAjyVhkEe0N5h6y1H78JE1smbXwgkwYt1dWJyPNoRLiUO8M/qGi43xruYjzNA/0lzEGxeMbYH8B1BJ5gzK3H5hJd+sL567U4BXI0yuCsxRWywnzRiiYjz0wducupYbJxiKtfdZJoFOKa6lJ900iiKET/1pL7Smgfy06Oqn4nSz0PYGpT8PnvUA/U+KOxWU/Q3M6WWxVgg+gQP/vevFP/ZGNey7KyqICtZdBzcRuSzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmLMXEyeKFpgCU/tGUHhLhmVXnLHKxoeOimHwef8gMY=;
 b=FWDeP/gpZ9YsLPloy+fYgYjzC8mbgXdMAgmJ7nAp4BHNoSKG8Vve4A1e4dhgzchkYfrL+i9hTlBp2aBXcKpIjNHaQP2L2LeWmnW/pdVmGRcWmZ2aumDrbTx71hbAeEc1A+iyZExmNpaRaVKKfI0Dj8EHXnT/6GZIMyQEAqXERQg=
Received: from DM5PR10CA0018.namprd10.prod.outlook.com (2603:10b6:4:2::28) by
 DM6PR02MB6587.namprd02.prod.outlook.com (2603:10b6:5:220::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.32; Mon, 22 Feb 2021 08:47:37 +0000
Received: from DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::f4) by DM5PR10CA0018.outlook.office365.com
 (2603:10b6:4:2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Mon, 22 Feb 2021 08:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT010.mail.protection.outlook.com (10.13.5.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 08:47:37 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 22 Feb 2021 00:47:36 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 22 Feb 2021 00:47:36 -0800
Envelope-to: bharat.kumar.gogada@xilinx.com,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=33774 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1lE6sR-0007zZ-S1; Mon, 22 Feb 2021 00:47:36 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v3 1/2] PCI: xilinx-nwl: Enable coherent PCIe DMA traffic using CCI
Date:   Mon, 22 Feb 2021 14:17:31 +0530
Message-ID: <20210222084732.21521-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c96fbd61-02c4-497c-3f7e-08d8d70e8141
X-MS-TrafficTypeDiagnostic: DM6PR02MB6587:
X-Microsoft-Antispam-PRVS: <DM6PR02MB658746D465E144826E1F5E96A5819@DM6PR02MB6587.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUJuP3WUM+wayvysI2mFbot5mS+OJXCDtMk+ddNhPr6vuIO6T7uHAR1y/Nl3bWg31xxR2HEQqdcoxN0ciICL3onMabfXIYt+v73i3DgnBYZpJBtrGpsMRI/is6o0RPakicpURnNH3FoCYf4WN2WsxrXAw53ytVcmstnPG+cXQ8RMRcRIiGvpUGZzAqmVErKEj0DQXB4QwAZAl9XKOIMq+Z27VAWdiE1ETjNG6Qh1tou8fndeKs8tLoTI4p9Yi69rj2H4Mnbj2E5E5PtP7xhJROBCYC6/7T/QnaIHxFOWIhV1qdXShius8tMBv/hr+E9v4florQSPB8me9EYGUPFUnemw9qpEaDwh5MUHVxPTCkVdhqFzwY2WFqVdzwoYz3zFM9j7dNjSzwL1J7Xv6V+JxnhPFau2GpXxtzDSKojCtlFRsTS5sm29ZpPMDgHwv/1vksVrvRzdQ9wVBF8z340tuJplRuX/Yc1Y0vrn8riA98dLF1n0pur6Yz+Far/as+7Btdvytb70CaTrBl/e/X4wrDVdW0IV8AoRPOTC0lnq9kIK8Z3pzzD+FvtluSWjtjYaqvScQJTozm8ggykEjgFZQgYa6ionWhPoOuMizypP7jaYXqobtEH9l4A3z3LDgBw5JejCNk5ygB8UGcSPA4UUVCEPn0ukOv46HRIefxDtmQZzNucazcosUvedLXxOtzsZXBGRNZg4wKIf/gG/VdLxjD28O8BZ5U77REAKx3otuBN6T+mm1N2Xb4li3W36AZ7iGsuDNh0vPqWAdoL2Y5Qc9g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(46966006)(36840700001)(82740400003)(356005)(478600001)(7636003)(47076005)(82310400003)(8676002)(26005)(8936002)(4326008)(6666004)(36756003)(54906003)(7696005)(103116003)(186003)(9786002)(110136005)(107886003)(966005)(5660300002)(2616005)(36860700001)(1076003)(336012)(70206006)(2906002)(426003)(70586007)(36906005)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 08:47:37.0076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c96fbd61-02c4-497c-3f7e-08d8d70e8141
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT010.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6587
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for routing PCIe DMA traffic coherently when
Cache Coherent Interconnect (CCI) is enabled in the system.
The "dma-coherent" property is used to determine if CCI is enabled
or not.
Refer to https://developer.arm.com/documentation/ddi0470/k/preface
for the CCI specification.

Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 07e36661bbc2..8689311c5ef6 100644
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
 
@@ -675,6 +677,11 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	nwl_bridge_writel(pcie, CFG_ENABLE_MSG_FILTER_MASK,
 			  BRCFG_PCIE_RX_MSG_FILTER);
 
+	/* This routes the PCIe DMA traffic to go through CCI path */
+	if (of_dma_is_coherent(dev->of_node))
+		nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, BRCFG_PCIE_RX1) |
+				  CFG_PCIE_CACHE, BRCFG_PCIE_RX1);
+
 	err = nwl_wait_for_link(pcie);
 	if (err)
 		return err;
-- 
2.17.1

