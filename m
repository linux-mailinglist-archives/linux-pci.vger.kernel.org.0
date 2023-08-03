Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFBA76F5E6
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 01:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbjHCXBv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 19:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjHCXBt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 19:01:49 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED2C1FED;
        Thu,  3 Aug 2023 16:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAIVBJeAkO30tqU9m3K4uoGzlm5Yv3HU1GHw75QpZQJMefOO8sBDiNF6ZR0Q5QYudX9oUOMphxclL5sA5E9XPcKT2NTqTfp7/bVLnxmfnJ7SnnuRAjrsYeH5LbLXg9U5EDdJPby5JiwFqdSTzSP6TU92q91mfLLqZKo8U3O78S0NJSTH6gLnQhS9aYE4UoIsAzwrChJeeBxFMdjvKPeC7woI8odJ/TouJQvGNmjyqLBC8iqAEBoZWKj5WVBcxUuecuBZj/ATQnXoP7unYNcJpBQk1M7pdAEMULzgX6dS/vQ6/mcSZtFBS8Z669pQuyOhSfkvtnqWncxsXa4bu3BgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emACnBBgEhj6jZ7r3URKO9wHc+6b3r68Vnmbnr8X2VQ=;
 b=SgFviAuq/5rJgI3fAHd2n+eYkzPFK2WwWQJ9xtY0NxMrC1WooIzfwIQk13Lkdw8TAM1/PIceur5pmILzwYQIU1Ap5vyz0Qplp2u+O7VN3kQABNDwEyZ/YipluSCpG886tSZC+dQFN37CgXQpqXI9fj95f9KUxFk+v7jq4ELVAk/nmr6JSgKE1ShvPjjJx06MR5DehFhEudkXspblc2hlUAbOl1mhH6RqWJs8BwrtFd1y+EP/SpY/3mWd6/w/vtIWjzl4XLh1Oi5ZGdMVvClOdPrJAYvKB3tH86PwGA6RDRhmUKe0mWBAd/kOKhRk55te/5kxxbbPub6Oc6zYM7XiaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emACnBBgEhj6jZ7r3URKO9wHc+6b3r68Vnmbnr8X2VQ=;
 b=vsXVxgyjRpfvNwiw70iOsUOJOA2r3C38MCrLW5qw67WVXoOxnX93pR7hdMNijN21QfhzeA3JApNYCs42lfwIckh/P5qIxKWoVXFYxKIxlydDrzT6kX5AJgVxOz9NkdESXFh8N4sm/PI/C9ItH2EhTTQL8sNq26UNbI2+dxx5YvQ=
Received: from MW4PR04CA0211.namprd04.prod.outlook.com (2603:10b6:303:87::6)
 by PH7PR12MB7455.namprd12.prod.outlook.com (2603:10b6:510:20e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 23:01:44 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::d1) by MW4PR04CA0211.outlook.office365.com
 (2603:10b6:303:87::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 23:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 23:01:44 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:01:42 -0500
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
Subject: [PATCH v3 1/3] cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS registers
Date:   Thu, 3 Aug 2023 23:01:27 +0000
Message-ID: <20230803230129.127590-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b71e10a-1d5f-4c1a-2e6a-08db94759b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lLm6w1dQ7lC1bN7Ojbn58hDtZF/rXwc/jf/TCJtdHoLm/UIG+8cWuGbX55MAqdnwAiP45fWRagW4qH4ZhiUKXHYSehQDOj+bYQ5nfPE7vxWOxK5PXCzbx1Zt6EpfBcDdKD2I+P/jdWLb6hPm4kcioogNU5kM/TU+9M1FA8K+wGMW0QJIfX5Ti6ENN/JI4diC7Ru1VVRSkrIIrV2Vs3nUgtWUiVJl+KUkksm/mtwHylCfTlzXXslPEUEctrREUlYsRzcT9FYHm8Vk7xnk0ETWxPCcm4W59cR9PUlPOnsIgigTa23TIcCUTT8HuV8tXTj2rfb/xB3vnfaSTfNqxRDlnFcqGeyHv9HGfA1ekTw3CQ7Vn5bGQDWFc+5IYkOLp0UfpOmFVx6GEbpPgIVGFa4JqAyiMDLaqHja49n6aZJw1FMpLGdE3fRzF2/0E8lI6FRsAAxrB0hBUD20RrvIkklFcROjmCNyuYCtAwg7sK9jL+B+sEbLvBoTIBiFB1ElmIDOn1jXtVRdVn066qzhpU9wSGIVgxWkTm985qVNz6jY0y7fKENeKETII4c6nAnBljAbyq3O2V/sN0vW6OgRym1BBC7pKMuNdqz9k4nVcAZCxcgqWZLsPVdA2g/EB7Iz1wRvcBAU4kHCYaYItLsAOfB0b/370Wh/1NW4Dm5sry8kCNflXE47mHckUjZGnsC7xSBWwM4evP8ltp7yAW1FeIMvQ8GwYmVGef/creMkG85wDyu/m3tl3GO/Fs9u8c3/mJbDs6zRhNJz2kT3qPCHU7+Uw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(186006)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(426003)(2616005)(1076003)(83380400001)(336012)(26005)(47076005)(8676002)(316002)(2906002)(36860700001)(4326008)(5660300002)(70586007)(70206006)(41300700001)(7416002)(8936002)(6666004)(7696005)(54906003)(478600001)(110136005)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 23:01:44.1439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b71e10a-1d5f-4c1a-2e6a-08db94759b73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
Reviewed-by: Robert Richter <rrichter@amd.com>
---
v2:
	Added fixes tag.
	Included what the patch fixes in commit message.
v3:
	Added "Reviewed-by" tag.
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

