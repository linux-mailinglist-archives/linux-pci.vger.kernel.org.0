Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066844EA211
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 22:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiC1U5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiC1U5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 16:57:07 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2083.outbound.protection.outlook.com [40.107.95.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8718689B2;
        Mon, 28 Mar 2022 13:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T00PmqlabF8ekPJuj4X5vI8XFdyNNUtYfKASe0IbHUGKuVPTyI/WMktii1Vz7AklVAiA+QJ6yQGrjhIWk3Ppa0gQCfnpI4iyW7LaUfZTnU9g//QZmWWd+ArG3canQSKKdq0V9PW7iPTcLZB/dGS42qPZdL8ykH8MNcFRGolVNWGB0t+x5x6wmL9EGb9hKCM/Lfq1mB6Cf+SKQ8gjOXoCgfDEJlnXgLnWVWjWzriOpF7m+lHzJcKU9LaiaaYAgSmk2XtSdMcauj7jMIx24lj3mHduTPd+fcIQ+gVbu5kWTfJc7woosq2ZmqhcsDxVY2edZvIxHOaM4DrvKyQ2VV88Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiBTLGrm52JjXh1UJtX1pKFnvFaCScDNd/h9pv5CGp0=;
 b=b3NkzPTR6EumT0yIxQrhYQU44Eh5+WBFR8fEjesFW+pTJc3kLDVAuayigB5+TKvHA78+LnbrarzDuOv9f4WupS82uzd3s/NxWBByGFS7khpLZwShPgH/EwEKZr93GVzKwharFN+z7ssIRhRSd1oTjiY0GEMI0Tin9T0vU9qt2nUk9WdHBxnw9SIZhYzO9Ca4lYCdeDNwXPaf8wJ9QfziPMYAbUgZ9ehvr6xFNBGNHlDXgl5EjkjOzC40hTEburkyjPoiUp3yD98v4GZDvPpf/x/WtLrP620iVkSNrKG6L1o0GCGZNl8YtK4YSFP46J9e3I+9F+sxpppDIV4xqItJEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiBTLGrm52JjXh1UJtX1pKFnvFaCScDNd/h9pv5CGp0=;
 b=wfyAZYfU/EyFz13nR71ymYpSrY5KHSKbWKCB4QbNwDwaOocF1ApCEnxlUgbuWg/TgNb+TkQUmDda5CIqeJhOpF7pG6MntB1b+X2mNiON8sK/+RowTWyKVLJjMrKKbQPSUK12xp3TATJRKYKuswCkkSmG8UqCTSzYOYRG+bD3sdY=
Received: from BN6PR20CA0052.namprd20.prod.outlook.com (2603:10b6:404:151::14)
 by MN0PR12MB5908.namprd12.prod.outlook.com (2603:10b6:208:37c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 20:55:24 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::3b) by BN6PR20CA0052.outlook.office365.com
 (2603:10b6:404:151::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Mon, 28 Mar 2022 20:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Mon, 28 Mar 2022 20:55:24 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 15:55:22 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v5 2/2] PCI / ACPI: Adjust comment about `HotPlugSupportInD3`
Date:   Mon, 28 Mar 2022 15:55:19 -0500
Message-ID: <20220328205519.250-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220328205519.250-1-mario.limonciello@amd.com>
References: <20220328205519.250-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47698720-300f-4789-29d8-08da10fd47b5
X-MS-TrafficTypeDiagnostic: MN0PR12MB5908:EE_
X-Microsoft-Antispam-PRVS: <MN0PR12MB5908D24C27166BBC2E529336E21D9@MN0PR12MB5908.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SdB2cdvVBSxq5SdXaxQGS0eq/cSGg/Rvoxgo0lAdCBXMnGrTInJMk1l0qNFDTC2GSOKU5Pm1U2aD/we03TDzGvDAytIVqxu+/UNPiRhLfs2pDqchjtToEQ3v1CX0NgFGRbNGCT8AhZIUsmejnxDgA14Yp2U9uCIQEbz8xqHcWNgNOIsdwKur85qA6WQ4TO2jEED6R9XNbUu09NfmoZZbIWlIo/XGkCS3QDt+zHy9OiNU3I0j5Sn9QIqt0VNHi8+aPLDyJem1iTWJFwcdF+mMpSo8OzIUf1aUKcFD2aL6OXyc/lbYn2/RLDDjnAHwGjQtEqJG3DzbWZUOd/aQhZ83PuFHnOvD27QZm6gRO/7QNioeN1rvZuoqPq/KPA8vaJcMJrfqVSWiQ98gVNlXEZ/f0CJB0zISF7cpmC32w5uPnQhTciYB0IJntwdNsowPRvwnP558KQYwjvcG1SfIXaxDSyFsJcvHz/y9L8twdKLetvBdWCmc64g906i6t/Mv7MXGrHNArS6POrm0+zQo360OVTuRYnBRCJTiyA9bP9TJX7DcaYQWqE2Y80gPVD0HVu6CEo59s+9XBbaxf85c1D05OlyXHfwoohpCuY1hk+G2eTH/IwkasZnWkqZHwjE06tjykHN0/OxGc5ViHlurVEqu6V5/sr0VltMy64KroYVYU7tmAyL0swBfXcfWHrGyWJA1aa/N60/YoqSXdTzxF6flfsz1O4OE5wznKl14bs7GnR8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(46966006)(36840700001)(40470700004)(47076005)(83380400001)(1076003)(81166007)(186003)(54906003)(26005)(316002)(110136005)(44832011)(336012)(82310400004)(426003)(2616005)(16526019)(5660300002)(6666004)(70206006)(70586007)(7696005)(4326008)(2906002)(8676002)(36756003)(36860700001)(508600001)(356005)(86362001)(40460700003)(8936002)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 20:55:24.1546
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47698720-300f-4789-29d8-08da10fd47b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5908
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The comments in `acpi_pci_bridge_d3` make an assertion that all devices
behind a PCIe root port that supports D3 also support D3.  This was
pointed out however that it's no guarantee but rather a reasonable
assumption for the ecosystem used for Thunderbolt and USB4.

Update the comment to use weaker language and clarifying this is an
assumption.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * New patch

 drivers/pci/pci-acpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 91c165ea4346..4f12d4fca808 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -989,8 +989,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	/*
 	 * The ACPI firmware will provide the device-specific properties through
 	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
-	 * for the root port and if it is set we know the hierarchy behind it
-	 * supports D3 just fine.
+	 * for the root port and if it is set we make an assumption that the
+	 * hierarchy behind it supports D3 as well.
 	 */
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
-- 
2.34.1

