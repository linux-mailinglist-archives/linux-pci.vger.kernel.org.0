Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1D646FDD
	for <lists+linux-pci@lfdr.de>; Thu,  8 Dec 2022 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiLHMjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Dec 2022 07:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbiLHMjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2022 07:39:10 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E158000;
        Thu,  8 Dec 2022 04:39:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGqkL159/lGgBKEQd/qbxDx1GL0tHlj3IN3HgfgXLLDlAT+Td7WnroAIgK3V4wBk8SIPk0ih9J6BvXND8IgoTF82lNdp8uSpWqeiVoOxyK85MMPnWqDH3oyIgxKNLndGLXXTLERTFXK19H0c/87C4vWJkmnXaFSoPCUVDmR9+Qla4Wnp2RkfPtialcIJWp0lUVuV2dV2JYzrhjUHMeBH8cMR4aeRs7dwBliV7fC6I0FpP0UMMw646Ly4hYD/D83+TOZgoN77ap7gTgWAHIFoVHz21NJSh5K8kVIM6whT3CFlczQSvwuCdsd7eth3XdICE1kb2b/FDun9SVIjbWYXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOlfyscrOD5f71G6jc+KBeUdpi3Rs6FgT/611HGuTmg=;
 b=BkUVKpwOzn0hG5n1CbnQtmrTbUjkHmMgbamqQuq5SHVZY8YY0emOAw5RgbrZK/R10NsI57s6KtAUkzd/nixo8EUYeRoK7ifqaFuYTuL/SfHni1BPyEgkUMLHIGsK9Sg7jZIoL61ycAE+AMeisOykeMd1eGzjz56hI7BExF1vI6/JGuOvWeAi6dAUQWn8JLnhI4BPVRV1Rey3ajC+Xdh5N9eA/qk6Mx3QCiga1JxQOvcXkdUxld/AUKkyYsXqC1MHZH+azyJ9gsoedMJ1Xng/TXBHYtr/WSPVbBRuRFAb6t1IhxjQoUFldbulTAyuAqmLvKBHTF6jruo5d30qYjET4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOlfyscrOD5f71G6jc+KBeUdpi3Rs6FgT/611HGuTmg=;
 b=bN4SLZK1/QgzfXqxLMsV1TTh0ckCQDgguV89+9dDRIsMJAym5ymLh0f/sUntxBIcQ+pbwvlVPX391w06SlIZJYA83p0vWoNRqiesv7PSAMtXky1rbO8tPMnFUjhZahsTH3lVbVigvmfqr4o+28U+g2m7VPKPOgfEPYMfvc3SJtc=
Received: from DM6PR13CA0027.namprd13.prod.outlook.com (2603:10b6:5:bc::40) by
 SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Thu, 8 Dec 2022 12:39:05 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::e2) by DM6PR13CA0027.outlook.office365.com
 (2603:10b6:5:bc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.5 via Frontend
 Transport; Thu, 8 Dec 2022 12:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.16 via Frontend Transport; Thu, 8 Dec 2022 12:39:05 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 8 Dec
 2022 06:39:03 -0600
From:   Michal Simek <michal.simek@amd.com>
To:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <michal.simek@xilinx.com>, <git@xilinx.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH] PCI: xilinx-nwl: Fix coding style violations
Date:   Thu, 8 Dec 2022 13:38:50 +0100
Message-ID: <17c75e7003bb8c43a0f45ae3d7c45cac230ef852.1670503129.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0a079c-663e-414a-7953-08dad9193168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sTk6jQCgpHzOVEB8foEMJI64pfQ8cs84ZumR323WZj0/YW9WBSMEf3b2aDSk6rq/EuZFuhkQDp6uoG1zG86vU/Lm3xAOnCeXadA0af4qXxyuARfTV+C6o4PeH4WpPFcvlcrRmmyYsnHLceOfzCfQr6Hzuo23OfGH3be3ScxThwkhM3XGYh1tXxt6cg33YMmicqXsr4t9j9nJawG1gUln0NNhh9EWJV6a9Dis+v+h6z9HihxhESPnQoW6TAiluIcuYwFR/hx3/kmHIigagmPlG/gG8W13Y9H3nj1su1oXhC8TWFLGg2OxpIfxc6UT/h087/SNuFXwX7hMVCETgwBJXueeMyCgPGC28VPZnuZcvivfFGNTi+Iiy5ITUpPHYaYm6qGqP4Uf0eYd+Y2fIELcX0yCkdeS8uFUEVqlnWdU5ZN47sBVBhcKb48aXshSv0qa9vGlKbdbQ+q9b4TXOBgnPZx/1WQ7Vac3eFvMkqmSttcQo4wJl8V9KPVNV5obU9vHZ4xG1DDwc1GRr5POIWFYQ+QZwyIL8ToEJP7dUIoV88OpoJj3jnC3kcsGFVyBXI4d7TZeY/bYcPB8YHJyLphRxMCEGFObjrpm3StXshlBSa0L3+kpbwATXIDjAGQIfyQ9fne1b5wNk8D9nkCuhjDnb1GubRgEU0BUlbeI05rmusqRZaZhB4akPN92oK0ZTKhqb3aSQ02BsXzDqEbUsHpMD6DgaI+beGhB0PwN0TWEjdyFUJLaiCa8VfSCfzbZD/2L
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(16526019)(336012)(41300700001)(2616005)(8676002)(83380400001)(36860700001)(8936002)(36756003)(426003)(40460700003)(5660300002)(82310400005)(44832011)(2906002)(356005)(81166007)(82740400003)(47076005)(478600001)(40480700001)(6666004)(4326008)(110136005)(54906003)(316002)(70586007)(70206006)(186003)(26005)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2022 12:39:05.1905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0a079c-663e-414a-7953-08dad9193168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix code alignments and remove additional newline.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

We have this in our tree for a while. It is just coding style change which
is fine. Let's see if you accept it. If not I will revert it on our side.

Thanks,
Michal

---
 drivers/pci/controller/pcie-xilinx-nwl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 40d070e54ad2..e10a58649bf5 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -474,15 +474,15 @@ static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	for (i = 0; i < nr_irqs; i++) {
 		irq_domain_set_info(domain, virq + i, bit + i, &nwl_irq_chip,
-				domain->host_data, handle_simple_irq,
-				NULL, NULL);
+				    domain->host_data, handle_simple_irq,
+				    NULL, NULL);
 	}
 	mutex_unlock(&msi->lock);
 	return 0;
 }
 
 static void nwl_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-					unsigned int nr_irqs)
+				unsigned int nr_irqs)
 {
 	struct irq_data *data = irq_domain_get_irq_data(domain, virq);
 	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
@@ -722,7 +722,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
 	/* Enable all misc interrupts */
 	nwl_bridge_writel(pcie, MSGF_MISC_SR_MASKALL, MSGF_MISC_MASK);
 
-
 	/* Disable all legacy interrupts */
 	nwl_bridge_writel(pcie, (u32)~MSGF_LEG_SR_MASKALL, MSGF_LEG_MASK);
 
-- 
2.36.1

