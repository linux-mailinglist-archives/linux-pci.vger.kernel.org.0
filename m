Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4675D6BD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jul 2023 23:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGUVr6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jul 2023 17:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGUVr4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jul 2023 17:47:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1667E269F;
        Fri, 21 Jul 2023 14:47:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nR6ZZU3X/pMQhFg4r4cjVSBDlsKlafZYHeEdS3yI+WC2GZnBlXdZFghhJ6+RCDN+MGE0yYb4lJIUOoWDf08uOhfbOsZ97dIdSE1F7xpNGB37ATf9WcO4Y90/kcjXwmvQzQnTcntn8A+VhBdCKvF9KTt+Az+uFGEzBTfO6W4USF0Y3Lo+44jLVl9mswhxVDurx5upwFOhyEQf+nNEBygOzRhWe37VQFa8IXJ2KGcr9PNIYpMiWCbgklE+lj5VPsI8+ZZAKOIs4cD41Bnw6QWkywyFWyB1AVxTqyW+Yz6fJd5YZg12apucYAUgDmY5zc2qAfkjq4wDCvNoJZ35WBEtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ImFtej2hD+NQ+WEh9U58ju2LXmLakH5vglo5gPxX1+Y=;
 b=MXmCpu+OD4QqA1gVGIZpMkZVWcJotsMCqetz3JviXYeHESFhPqa6RoWmuUntql9tNk8TXWHcnfDd0eSlOlgsBLj5iRDHzbPiTurtQBCdaJ/JR2xNl2AANGQuFpJ5IOcs8RqQFO6gOHKIEB6QRVRTqxXt3qJ9JpdpTL4bZThHjN9hLSLvCk6f+T25M7a7pJ5ccKpOZ2H31Yrj8qNKem/wppl3qRLW1f/pCp5ULFjc6Kv1hYeFEpelvxPdxbxCnCYUhgjqHW/DfIjOjLTsf7dqs9DLMbSFABPGsbF9PtpWKaCsUQuvjy5xLUXQ9r1U4YYa6c2pU/XlCet7kEyuL4eTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ImFtej2hD+NQ+WEh9U58ju2LXmLakH5vglo5gPxX1+Y=;
 b=JzOXFj8h8AdIaUeFpeLWo8c4wpF5nGzlfBxUVdsFdwxUWlEZNRvlEn+fdwNTxrlRDx/T4LCL0Ya1CENuUrCki++EsCIi8sgOhLrR3oDV4/wMHep/AqBjsIE7ea7v39QQbOPvxSI02bSf7f0p1hT2CKdYlUxr0ha9Vxy9IYCz4EE=
Received: from DM6PR06CA0001.namprd06.prod.outlook.com (2603:10b6:5:120::14)
 by MW4PR12MB6778.namprd12.prod.outlook.com (2603:10b6:303:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 21:47:53 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::c) by DM6PR06CA0001.outlook.office365.com
 (2603:10b6:5:120::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28 via Frontend
 Transport; Fri, 21 Jul 2023 21:47:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6609.28 via Frontend Transport; Fri, 21 Jul 2023 21:47:53 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 21 Jul
 2023 16:47:52 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Terry Bowman <terry.bowman@amd.com>,
        Robert Richter <rrichter@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v2 1/3] cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers
Date:   Fri, 21 Jul 2023 21:47:38 +0000
Message-ID: <20230721214740.256602-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT003:EE_|MW4PR12MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f10c06-8b07-4f54-f42a-08db8a34230f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4T3g/ZHtE9doqUvtrz2aSKiManJ6R/g4svxmjG+CflHDG5VZMNnkIcw1DpGlTX6XKhLCCpLjiYQQMY5eXKI0ae5hA++WmbCshu9CFv3XpR36u9fEq1FUDIqHkBWnjvfWdCTUB/jeriCA/3durlW0NC2I+TWOfcbAUZeeUtJyG9heENSJaiLVAKwJYYQyu9m6QB4URFL9bvalJgTwiwz68RXycosPMzSWtfkKx+T9cUVz3026NJYkhghra1LDw6eUD7CRCJcOp+mDCCLVOq3y0zKLm9zt5Hilr2N6Yxo3Qlyo4b8fMZRKHNG0DTB7A09Pn9awa0eomXItT+xVyzWxTWq7Np1tC1b4pNesVJSWGSDiGq8evk9i5uoyFbsc2UJ1+HYCSut4gj6TSnTIoAm0K5yUQASc05/m7ghy1GKeP8B7zR9Jd1jUAemYCpVa3/3QK9s7dUwpMTbtSDA+0BFllYOiCaTYEFf2feaOyvX4HKzGYRJtwWCZNOuKkMNk8cCSrr7ZyWUd9NKQAVFUIhMwYgWCDzrT4YVdtU9ekW41kD/nu9fRoK1ZWSfKGQCgj/qvORq6n4yHWovXjtqO8RM5+uEPsJs+0Vp3Gt+zp8zAgyNpFb7DjKzoPV/T6tuYePSP8bsfmfme0Hnn/+HCThL2Nr9IEvmBnx/qn0rdov7BjAMtoxkp3bnh17Rb8raF16lqCQTDKluJvSWe+cbf9PI8bM94hiX9UHMXOc5lCT3nWbwV8h9gf/g2joma74Fyw/9Ez89Lpdfypg8T1ofCtOoO3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(2906002)(36860700001)(83380400001)(40460700003)(2616005)(426003)(47076005)(356005)(81166007)(82740400003)(36756003)(86362001)(40480700001)(1076003)(16526019)(41300700001)(70206006)(336012)(7696005)(70586007)(4326008)(316002)(26005)(6666004)(186003)(8936002)(8676002)(7416002)(478600001)(54906003)(5660300002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 21:47:53.2675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f10c06-8b07-4f54-f42a-08db8a34230f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6778
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to Section 9.17.2, Table 9-26 of CXL Specification [1], owner
of AER should also own CXL Protocol Error Management as there is no
explicit control of CXL Protocol error. And the CXL RAS Cap registers
reported on Protocol errors should check for AER _OSC rather than CXL
Memory Error Reporting Control _OSC.

The CXL Memory Error Reporting Control _OSC specifically highlights
handling Memory Error Logging and Signaling Enhancements. These kinds of
errors are reported through a device's mailbox and can be managed
independently from CXL Protocol Errors.

This change fixes handling and reporting CXL Protocol Errors and RAS
registers natively with native AER and FW-First CXL Memory Error Reporting
Control.

[1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.

Fixes: 248529edc86f ("cxl: add RAS status unmasking for CXL")
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Added fixes tag.
	Included what the patch fixes in commit message.
---
 drivers/cxl/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..2323169b6e5f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -541,9 +541,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 		return 0;
 	}
 
-	/* BIOS has CXL error control */
-	if (!host_bridge->native_cxl_error)
-		return -ENXIO;
+	/* BIOS has PCIe AER error control */
+	if (!host_bridge->native_aer)
+		return 0;
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-- 
2.17.1

