Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341D7759E79
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 21:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjGSTXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjGSTXb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 15:23:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B3F1BF7;
        Wed, 19 Jul 2023 12:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVR1OMsWtm+5j7IEgvviWnTTFFPSMnQm70CdpYCMvTYY07UdHpJObMkJxp1XaYdP3A9x/jdBjiiJhkpwH/0HT6G+BUg+3TgZSMP2HX6Xptfrdzat+8QqMnR7YcQP7N5LNvSmuCLI8bbDv551itwS1XKX7GOb8v0mY7VX0SnFRUFis6UYmYWtTdDeev5WD3zjAuxngXY/27l9paR2o8nwXtEd8hSXmbFdh4iLZSVdvH5yf3xYrWNLgRazkvtXWLhrghmqymLQ91a+ZPG6nsCY85vhvDUGytC8UeqTL7OzvvBSbKEly2oJoI8HCdaklX2oltsh1LDEUCsMIJ0+/WK98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLPmOOeyh7gR9cySHSNk9ED1GEJZkTIqXjs3KmPK5Bc=;
 b=c581ORGcNpM4wpcqvK4irGJdvNNu4CtUUnR0LCePf8TvguuFI+PzPbzWO2z/PpmyzaemxiuEt2JCY9aYkNKOSVDfoJXm3MeA0broTHEigUtiHSy4otM9Yis1wKEsewFbCTlcsqf5dCrF5qud76GfvFW28NA1hB7BAflWEgJiP9o+ylFbaW4H+cSLfOeFIl7zrMYkou8WtCPWDqZMsKqeNEhwlTs2kJWvUh/N/EU/aY3oRgCkgVKlI3n9SXx8RhryMm9SJqcio7b9toLFK9dP+e6YtR987aiL5IyjrtXnWk5WsknIUclUIw+LEgpyn395ONHr7weqWxJU3GyrOQPJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLPmOOeyh7gR9cySHSNk9ED1GEJZkTIqXjs3KmPK5Bc=;
 b=xFXzh3Zzlhqp00IGCRk+PjEdzuF+uSIgXuwimUmRyQ8iju8SDEEaDYp/d2pWez2KJ1rzrdkjxUZHsa///S71FcBy+YcMfV3ZtUTcUvd/Ko87JI1aUleWFCdERFNwgfPcbqfjiuEphC6vqIn0BzwUS94oDidTO2ei+MCiOHKXLb0=
Received: from MW4PR04CA0312.namprd04.prod.outlook.com (2603:10b6:303:82::17)
 by MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 19:23:28 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::ad) by MW4PR04CA0312.outlook.office365.com
 (2603:10b6:303:82::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Wed, 19 Jul 2023 19:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 19:23:27 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 14:23:25 -0500
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
Subject: [PATCH 2/2] cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers
Date:   Wed, 19 Jul 2023 19:23:13 +0000
Message-ID: <20230719192313.38591-3-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|MW3PR12MB4364:EE_
X-MS-Office365-Filtering-Correlation-Id: b33d5df1-9777-4e15-1e40-08db888da14a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m+9yJQZeKFWBg0HNPV3Hd+Gle7JxvDEaMYFq4X/dFq5gFXNWFcwP3t4nrJCW71X4W4j5FezS2nbQa4gMOsXelO3HkLwohbZpckBDZNVIWa4wBtguUSXu1Bs3wQiD+uRjtHdb0ae2ZgBXVeqpAm443nFVMJMzocqEyfVr69QYgzYtmRWRtalEx9CFLczf1my8LmlV+aTl8uzwwn01Km7CeHozZVTH92OQGD9nWkvCdoA2RIQFqJQwqEo2KtNqhq2Qtku8rZb/ua6oWk55vfUghOqbi4mufR6BwDWNjKCEv9CBiDiZeXnW6ta+QnX8Fw/J/+8FCXJdP4PLHSMEtpT2Ca6UCXi/xMu0kgBux7SpGobdFOOhZrDYWLDFYfR9qaurOcvQZIsB3sMRlG4D7Fi/R6xaHrgw4ZiAm0B/mqc5LEMGtgAChb696kmyur5GQmtTGYmYUhu0I4gPfYk/VQtW47bLmRKoDC/rigoHCGhn1/J6jYeCi50I+WE8NV518tgvW1b5ld0pWDMKwlBTB6DlDhi1UsjOqIhJGVVkYQGPTcdBDZkhxb78OL8asn3+68SXfKCfqbaiv4do5MDACCOoKKPIXICXJiuafdIHMPjBfAQE/lvZZfQK01BCkZpZ6Oa9BFCIx3cG20KBUsmaJsvBenHvUIuKqUdiuQsFSvEVp7yi2xtFPKr8yAh6iAaPF5ijEBoyjTf4g8jw/z0eNtmAOD7ZPjabxWs7uDTzo5qVXM3TWqla+bwqfmOwd5nnqDky5+8ISmaZzvbNjDzsOE3rKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(82740400003)(478600001)(81166007)(356005)(26005)(1076003)(40480700001)(40460700003)(7696005)(6666004)(4326008)(83380400001)(426003)(8936002)(8676002)(7416002)(5660300002)(2616005)(47076005)(316002)(41300700001)(86362001)(2906002)(36860700001)(186003)(16526019)(336012)(70206006)(36756003)(70586007)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:23:27.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b33d5df1-9777-4e15-1e40-08db888da14a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

[1] Compute Express Link (CXL) Specification, Revision 3.1, Aug 1 2022.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/cxl/pci.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 1cb1494c28fe..44a21ab7add5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
-	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	void __iomem *addr;
 	u32 orig_val, val, mask;
@@ -541,9 +540,9 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 		return 0;
 	}
 
-	/* BIOS has CXL error control */
-	if (!host_bridge->native_cxl_error)
-		return -ENXIO;
+	/* BIOS has PCIe AER error control */
+	if (!pcie_aer_is_native(pdev))
+		return 0;
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
 	if (rc)
-- 
2.17.1

