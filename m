Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A3F3763AD
	for <lists+linux-pci@lfdr.de>; Fri,  7 May 2021 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236433AbhEGK2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 May 2021 06:28:32 -0400
Received: from mail-eopbgr760049.outbound.protection.outlook.com ([40.107.76.49]:23907
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236247AbhEGK2c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 May 2021 06:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lf+Hx4i63Iu3CZojjG6OQMoo4PEGhrpQdZL1JAg6w7+MaoQYIV8sNTfueFP0fPhn4vmzz50TyQ9+BnsOf5VOHlqAO4+9thkBaDF9KWgHm4j+JE8im5ISAUWt+Q2Cfo/h/h5brdYN49Y82nxMq3vBPX5oV4UHpMN/o8mQnYcMAXO2jhv+R/4uXW1nVtZocvw11/ZXNtBoNykm0frVLVibZAdgbzfZH3L61K5bfEteCACewvzuNVQPoIfULExqrci/lYZEG1h8v8Q1pZASY3eHtKCsH/LNKNLXoWswII6Ee9QP7DOMyXS2LnuMOGkfQwXXwHjXab3G2+pu/9MiDjUE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=242bc/DRAu0NlgfecTZTFDFs7ckZHvigaCHQesRHh94=;
 b=kR6kmZU+uUwQ6m6IT+QBRxGo9nO9JrnsXXTBzoTp+eeliQicmfb840bdZA38R5LTwEZ/YfaBWHhYFMqJhPYsZ6WyhfJMM48Zx4QrFgUPBQAQel/CwU7tgnv75pVm4dr0kpKmWp+pD/n+UUd4m8BazJaw22M51F2/7P5Nc7uLNBpoGzmi6EhbyelgT7olqF/ehDOk8SvJRJT5+ZglxEHFdnurm56HM/mFlql3FLcJ5bH/FY18ow6LQ8RzSc8EGhUIe9IF5FwBxqHrcpT0wIoGZ5sDNReVjwnoNYapG9zcTLDvB0IRCfhb1Fs9EGAnlnvUwzHfMLEblq4F+uymfyzcUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=amd.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=242bc/DRAu0NlgfecTZTFDFs7ckZHvigaCHQesRHh94=;
 b=xPLt1uYP/YxosvnEUbTSsFR1hZirGs5tZKqci/EnWh1ff3cL7JKOuno+VB6adkHoxWeRuhVtU9yvYxECFqL/w5CGWPTQA86vYT1Rif3ubkTOki/Igl5dAYUsOFeLdAl1znyK60tiLecmHexUNZaJ0yvJn1pinefDb/fMZSyRzoU=
Received: from DM5PR17CA0062.namprd17.prod.outlook.com (2603:10b6:3:13f::24)
 by BN8PR12MB3458.namprd12.prod.outlook.com (2603:10b6:408:44::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Fri, 7 May
 2021 10:27:31 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13f:cafe::d4) by DM5PR17CA0062.outlook.office365.com
 (2603:10b6:3:13f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Fri, 7 May 2021 10:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4108.25 via Frontend Transport; Fri, 7 May 2021 10:27:29 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 7 May 2021
 05:27:28 -0500
Received: from master-X10DRi.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Fri, 7 May 2021 05:27:27 -0500
From:   Danijel Slivka <danijel.slivka@amd.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        Danijel Slivka <danijel.slivka@amd.com>
Subject: [PATCH] PCI: Fix accessing freed memory in pci_remove_resource_files
Date:   Fri, 7 May 2021 18:27:06 +0800
Message-ID: <20210507102706.7658-1-danijel.slivka@amd.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7239bdef-2a1d-47c5-2f6b-08d91142b7d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3458:
X-Microsoft-Antispam-PRVS: <BN8PR12MB345887C2AD49E0553F31C76C98579@BN8PR12MB3458.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:576;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yreBGJhzC8SSDQ6ThtFlseRY/0GNZKxNxAtyHJ5un2PSJzYlJ/3Olxz+zfaqjrNja/M9zTM77MF93zr17qEiR6He+HB7oXktTeqVsTVkPfrrPJvjBVmPL6OpgmGKbVyrNwVP8aL72leEdJijErLLKcZZ5/rNcsJowi0JQUUVsXevdtVLUqXXCJGDB6wBgseoU9qaGeAQ0IF7oKjusCyXG1GCzkxCKFpvYWWXnMj7znionq/+S24KDwpxnobxlX5PKPGDQZ9MwJ62YPIOsZvPpPHNtg7RiEFHauzqg7sF/LEGbyd7MypSrWT23skvOarUP98P55z8Zg1aPtMJzEFSrarJbPYZ17V5hsZPl3K5MjU8i4I1aQ5z5qgblLvhy/V+X8kaUW8O8ma5RpStvEzbXW6wvCk+weQnRQCVNHnwIZJjFNyBinDs1MdcNecOMuOU3B0DrzdSemmhHVou59sYdyo9cZztu0RA+pmNZlU99JLaBa0V4RGxyDDvVuuFChjlOMQ3icMwC9Qvzp2EOyQ2NlAiJ3Ft05JCBCnQ9/vprZu42MVfX90+pBNtXQ7JlFxGGRMP6wqAm/75CD1mJb0KUjQTkOcoEHvLn6hQItO1k4QE8t1QECSNW2TAy3tXe/Y+BFI0msXtsy9v76cyOX66oIH5rTIfvDPogGROt+eb8wIxALXSOUtbgKPeAsqPMHUz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39840400004)(36840700001)(46966006)(478600001)(8936002)(5660300002)(44832011)(26005)(1076003)(4326008)(316002)(2616005)(70206006)(54906003)(186003)(4744005)(2906002)(70586007)(47076005)(36756003)(426003)(6666004)(83380400001)(81166007)(336012)(6916009)(36860700001)(7696005)(8676002)(86362001)(82310400003)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2021 10:27:29.8004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7239bdef-2a1d-47c5-2f6b-08d91142b7d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3458
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch fixes segmentation fault during accessing already freed
pci device resource files, as after freeing res_attr and res_attr_wc
elements, in pci_remove_resource_files function, they are left as
dangling pointers.

Signed-off-by: Danijel Slivka <danijel.slivka@amd.com>
---
 drivers/pci/pci-sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f8afd54ca3e1..bbdf6c57fcda 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1130,12 +1130,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr[i] = NULL;
 		}
 
 		res_attr = pdev->res_attr_wc[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr_wc[i] = NULL;
 		}
 	}
 }
-- 
2.20.1

