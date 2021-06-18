Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7021A3ACFA2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 18:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhFRQEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 12:04:37 -0400
Received: from mail-dm6nam12on2080.outbound.protection.outlook.com ([40.107.243.80]:42721
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhFRQEh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 12:04:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7krZCSU9TwpF03ak9bRCLr5y5VpSV9WGfX1MV+GKbTsxHPfjLLp73njUmx/tcI2k+xocH3I+02gsqvZKb448+F1Q9wvWOBdfB4ggGFfmYyg/yEG0EWZMMUtJmsg9I+Z7g9OhJIDuHjApWDniTsKwFIigzRmhQwMvWbbKglSM+cuG/W/CY6RJFmJvZgM0/gym0KNU5cyWTxTCpfjK9WZ1QeOpOjOBBFlWv9fFQ+E7YVEuHbkYuWz04uNyVyHZi4WLS8U6RrfaTgBA07iNAKgHavD2AUM7oVmrUlkXELHLsYRdMbdRm2rBzSJErwhtX3Awhu2w3r2sz2iOWfFcOnmhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PDbRDZTdu1LiyKB3LKBECP7k5jFp9quK5yV3JQ7DVQ=;
 b=jb3CQ0VRCg07DljJ2vT7TK0+2gzM71s18pYFi7NmQg0JWm6TxzzIToGFC8Z9PGjrlUPcNDtHH+3Hz7QDmqsWR/JQpP2CgQn8gEpJInRJ/PVQRKi1mMuyQhMm+K9UvWKqJQO4S8klvBzrWn2NS2WGXKUP/jfRaNE/s5ef4XxK06ySB7GXkesoyUdlY6hC1zVwdf67VJoS71DWSjhbjX0mEUmxEX4wJBY128aIG0Br8XEB+XWzhj9J1PrGCXg7MmjqvK+bvD57/BEsVl6JKRaMjyOPPdwbc3T3zAEYZEB2UdgO1vdeDd+Jlzz9BykW+9ponUP2FTojfKCdu61DqGpL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PDbRDZTdu1LiyKB3LKBECP7k5jFp9quK5yV3JQ7DVQ=;
 b=Kr6KnoGDrLJlx7s0RyZ3VNLdWY8VNFd5o5KDpatDpg9FP9oyyvCYetZSg0D1LgETzCwHPEo7FJbz/V/Zx8iZhKRBNd+xNLLn/ODZvCmpv61o98G0dsy3K0/U3uWaQEo40P4aBGC42+NwSB0vc5ARbnkm/p5LLX5hanhv1Ps5pz3t5xnJ+BMs3+FkSltdq+IYnQHiiD2TvURMO1vBhEnwBtTk+60Y8cS6IsXckEVkMxq2EQRas0pooQ8LA8gGZu+UJ6BI6Xc+QJGP7Jg7qfG7SYVhxygrndUfc1+iLJlgpaAYe7+st6AddB6aa81lxl5bx7exgopVtyTRhhEAz56W0Q==
Received: from MWHPR15CA0029.namprd15.prod.outlook.com (2603:10b6:300:ad::15)
 by DM6PR12MB3818.namprd12.prod.outlook.com (2603:10b6:5:1cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 16:02:26 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::16) by MWHPR15CA0029.outlook.office365.com
 (2603:10b6:300:ad::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Fri, 18 Jun 2021 16:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 16:02:25 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 16:02:25 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Jun
 2021 16:02:25 +0000
Received: from moonraker.nvidia.com (172.20.187.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Jun 2021 09:02:23 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] PCI: tegra: Fix shiftTooManyBitsSigned warning for Tegra194
Date:   Fri, 18 Jun 2021 17:02:19 +0100
Message-ID: <20210618160219.303092-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60e3ebed-495a-432d-7106-08d93272775b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3818:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3818F4D3C23B976126330A6DD90D9@DM6PR12MB3818.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82BSdF3h8M3A1qZfwhR2B9d/ttZrWKmvbJwb82sx39nmQzt7gy1Jde60E0DU6o/hMgFFiIWg/xsWuWq8aojOjQjUdbTNn9t0HrqVfCnaVjc5FE3MyqJyt6b8osIUksRKGFBd/m02bDn4pWaugq8tvWBvuOFG0CVOEmgRBeH4Wdb4/VjZkgkyQT2+BiH4t6JKuoTB277T6qh4WtwXNy5jAR38B8nBhE9PEQfr/dPWfcUdBWAFVAL4uUmorfNc8+9Q6ae24R1ARQSv3JlZzGNOr/YvtXvgr/Vnm6SnTS02F65pLzAwzyFirU743XRxqmztNP/cw5c92lU82dzsemT/EnWp2M3KpArvmF4kalG3NdvjTmZrJSXSrv+MvVa+c7bVES3d6EEeqkYZmQzj09OVBq+AsKxzwhm1dTVkAr3BmqCnmZG0VQZR9CD+0zRFnmmUjXJ4fwxn5pEK1lQHh85YW8+75JNOODwVARQTD+6VC6GY+eFgLke27faDK+FIu4qhpMoCsKWPnQC0EKoBkKHXe07yaImgselb3XOOcQP6ROZoDzupTXj1VgLDQCbq4IlfI7B+s6Lhb27UiUKVXym0jWzI7gw6+r1b+bYzo4ukbHiJYkd/klgUCnRIJePNfqghof0aSDIJbrLj0JAQp1FPMjNrBrLTadEwGoeWIFcT46LukH9/yBlTvvhUt88SLask
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(36840700001)(54906003)(7696005)(36906005)(83380400001)(8676002)(8936002)(2616005)(70206006)(4326008)(82740400003)(6636002)(186003)(316002)(110136005)(6666004)(7636003)(36756003)(70586007)(2906002)(426003)(5660300002)(26005)(336012)(356005)(47076005)(478600001)(107886003)(82310400003)(36860700001)(1076003)(86362001)(145543001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 16:02:25.8608
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60e3ebed-495a-432d-7106-08d93272775b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3818
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cppcheck tool issues the following warning for the Tegra194 PCIe
driver ...

 $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
 Checking drivers/pci/controller/dwc/pcie-tegra194.c ...

 drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability:
	Shifting signed 32-bit value by 31 bits is
	implementation-defined behaviour. See condition at line 1826.
	[shiftTooManyBitsSigned]

  appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
                      ^
The above warning occurs because the '1' is treated as a signed type
and so fix this by using the 'BIT' macro to ensure that this is defined
as a unsigned type.

Fixes: c57247f940e8 PCI: tegra: Add support for PCIe endpoint mode in Tegra194
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 8fc08336f76e..3c1feeab104f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1826,7 +1826,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 	if (unlikely(irq > 31))
 		return -EINVAL;
 
-	appl_writel(pcie, (1 << irq), APPL_MSI_CTRL_1);
+	appl_writel(pcie, BIT(irq), APPL_MSI_CTRL_1);
 
 	return 0;
 }
-- 
2.25.1

