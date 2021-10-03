Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACAA420103
	for <lists+linux-pci@lfdr.de>; Sun,  3 Oct 2021 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhJCJPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 3 Oct 2021 05:15:41 -0400
Received: from mail-bn1nam07on2067.outbound.protection.outlook.com ([40.107.212.67]:55364
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229906AbhJCJPk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Oct 2021 05:15:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLeujlY9jC5s4Q0SoUGh3hIXZvSE5AmUx/WQQWe3g7eV3MrkKIm3IBlIGp7+/mRXOGMSnYFbaaomaEYZTPfVp4Zd/4lcq3C0OB/fC1Xbs/8VmFPHtYkjmcnjdM1oXQB3+Y7NH3niWpGeTkd0Y4HTjANesG3bn2FyF8MaEjR4Q9vrHz1nG/k0tz6eLp7yrdHF3oo+RLtK+gJicVt7J1L0zyuYvZY9LHJ2EALBPqX+cPeMiSI98eutAvU2GhY189Zy2lnFRX9MnHitlYolt+jQFDdeAJAcbTDa9Q49gmHzSmysKl9Kgdog5lFWMD/Ofisgczw6juumzT2NbxBtryjVzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRxYjpuBBri0NCo0ia2oMfJBBwRWbJ2fM24hKK3TXN0=;
 b=V2nLuPzA8bHz8qYF1592zZ/WogrOmStRivVpP0Um4vZ87LLObc9aMSpZDKURlI5FsMQa4XWnQ2P0MabCHLrgkBargPhsog+7lQwoMHo5/dBHk4FXYxxZ4qPGAe5dTeWjPYeuiiQEkQhakSzocWQO3YnvLuJVNgc0wLW5TkKCxGLiT7kSzeUJhDj9zngSUENegTZbB1EUJrBDNNaWHcJcO0QQWAKC7Ai247uj6fgFSLao2OlqT1gZzxKobIT6N1wzHn+a/YW96fBjP84vBEdLHoVbvToN3oWuEVsbi/l8brTDTkrOtbKSuEr1Re2bp0pWNYeIpcqQtk5LitxwFwD1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRxYjpuBBri0NCo0ia2oMfJBBwRWbJ2fM24hKK3TXN0=;
 b=jG1puSsBrNi+n0o/OvZQ6gpMqhMpinyei/X/QyfGtX5vMRS9MjsOumiTJWK0TNxEfdhi3WDTJTtKLCY9D6+n0YaRnrLctP0pCnKDVRrlfTQc6/MbnZwpg+SNR/gcu/jIuaB3iOoiKlOnzkqyMW/Tw9I26p6NpiF4cIAH/KzqE9l2JOmu1g9KzEawN/WmNskAW08lhwAVMynclGObP9Zwk+N+z959dp6Ux034RPYsLGpqMLlzQqePALbhcoRZVEgJ46KAikwW/tJk3/TCi7XuOHIVsoUV5gPgtHwi/wTF99X35A4062Ryb/CEoIGIEsKkdL7SqZORLlzu3cx9yM+DXg==
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by DM6PR12MB2972.namprd12.prod.outlook.com (2603:10b6:5:39::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Sun, 3 Oct
 2021 09:13:51 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::60) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Sun, 3 Oct 2021 09:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Sun, 3 Oct 2021 09:13:50 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 3 Oct
 2021 09:13:50 +0000
Received: from r-arch-stor03.mtr.labs.mlnx (172.20.187.5) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Sun, 3 Oct 2021 09:13:48 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
CC:     <stefanha@redhat.com>, <oren@nvidia.com>,
        <linux-pci@vger.kernel.org>, <kw@linux.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 2/2] PCI/sysfs: use NUMA_NO_NODE macro
Date:   Sun, 3 Oct 2021 12:13:44 +0300
Message-ID: <20211003091344.718-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20211003091344.718-1-mgurtovoy@nvidia.com>
References: <20211003091344.718-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87866d12-151e-455e-298d-08d9864e1d65
X-MS-TrafficTypeDiagnostic: DM6PR12MB2972:
X-Microsoft-Antispam-PRVS: <DM6PR12MB297257206C96B706351DC86EDEAD9@DM6PR12MB2972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnSXXQPEW3VQLD1KFFYFyysE49BhelHyAEBNWBBX41W8R47jEFN5VpFtt81OyVw3D3gkzQosdlHWSLhMPI0MlvTu9vDJ94enj2GQqMje046YVPB3iViiPIafs4OWbW46hl7sECCDRSbJtFNY0d83gTEt0lq9Vhcm/dz3H0PaIiI6QqVd8nWwLSiZCkJzrqroqOxhOLS1jIcC8q55oPYazFGVrVQrVL82Kn5qY2tBENgkqDung4LZ08fDlqosULTmdCCxSCY1uWtBOUfMyvnvgwagyzPEuZPe6+Mzj6b0M4kYv1i6HoCZ31q2O0VoLU+c4BUu14fF55Z9vCZvVyernapLH9tqM4I2RiVRRBXMf/iyDe2KDlA2nNppqoDpZRpSIgGqF3E02K/+TKsf9e2WwcSticly9jUIXD2UTXmXl4nNbDcjeAlfwXrUdj4MhbxCFfBoUqMqIgqdDKfzNFlXHSDI8cUUO+HBk+Yjfe2KZuvaN4gpptAPpIG44hIutIuq7Sfr0/NXz+HP1bYBYEpEm5qFRsmRhiy4x2Wb2wDOpSQRXaxGy00ot/RL/GirT4fiCn6VPZnMtO3YNTF6VSlHOZ7G1ZQkrwVAtMvA8lsh/uI6tyz6Xi8UK5MOC/v8r8Wn67ZxH2p6ql2yfsp5onHxxTER9KVJYxYDnhf4DugaAW+VHu2VxlUwqxkh96h5taZLQHcRQTBAzOCHWPCzFm/HYQ==
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid04.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(86362001)(316002)(36860700001)(4744005)(70206006)(54906003)(110136005)(83380400001)(4326008)(47076005)(2616005)(7636003)(36756003)(8936002)(6666004)(356005)(186003)(426003)(107886003)(82310400003)(508600001)(8676002)(336012)(2906002)(5660300002)(1076003)(70586007)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2021 09:13:50.7316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87866d12-151e-455e-298d-08d9864e1d65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2972
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use the proper macro instead of hard-coded (-1) value.

Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 7fb5cd17cc98..b21065222c87 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -81,8 +81,8 @@ static ssize_t pci_dev_show_local_cpu(struct device *dev, bool list,
 	const struct cpumask *mask;
 
 #ifdef CONFIG_NUMA
-	mask = (dev_to_node(dev) == -1) ? cpu_online_mask :
-					  cpumask_of_node(dev_to_node(dev));
+	mask = (dev_to_node(dev) == NUMA_NO_NODE) ? cpu_online_mask :
+				cpumask_of_node(dev_to_node(dev));
 #else
 	mask = cpumask_of_pcibus(to_pci_dev(dev)->bus);
 #endif
-- 
2.18.1

