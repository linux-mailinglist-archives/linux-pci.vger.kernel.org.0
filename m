Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE63786402
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 01:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjHWXnn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Aug 2023 19:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237231AbjHWXnY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Aug 2023 19:43:24 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C7E10CA;
        Wed, 23 Aug 2023 16:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUxpEdeb1wKg9c+OAciEr8KHJ66dFs925Ot4Zx5MdSomgVIAM0hWe+3ZGr+eohi5a24TwGoJ6CMDeaYFRL14mmBjeCzqIzlJLefVBkT6b0ikLmK49TxeYI7mIGo0sg/Bwx0rsGwakxXGriPirgI5PGHX8AQCA/Y4UC5NEYJ1wihkSHtoJ7Vij+x4zKcLULY5Bd/0G8dSzTZL9AbImA2Ytu+pwwcRqs4iRSiyhAajuvsyWT1IiMe/hB1Q920NXT8DDnms5waoI0r1WvBU3y41J8eZbpiwWKnqoNLi25LBXNEOxr/DNG834EbTXt1DhCqomT2E6zjHCGSWodu2foqdCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pa8LkD68VuMhzP3AVJE3fgnl/waNovkmLFkpeUWMd5Q=;
 b=LsJNhMROR7C+HNVlb2UxKWUaznXGqp6FL6mqqoy7V8r4ydcaAE/WEqoE7xZwEBfl1vCoL2AUz7AKyAqHVorKL999qJqREXiBlqRXc3h8KqJGtF0oi15SBF1HoIbM5YomNxuQ9wByrkCT9BRmBhPcdN/f0mBNa7x2hXko5IjtH3D3oMrQMORcr+qqEuuy12PfPh0rEvW8mGbXvwbj+z9Utuili/QxJ/u+BRZa5qsxM6I07IkgklK/AMPU06OZvwBO2yjDcH4e3Y4Qku7zz/1LXGbyQH4JtKVkbdSaeNzNqiQIkjbWx5AIVRdakc8pzixMzrvEKAZqPUK9ycWLMB87JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pa8LkD68VuMhzP3AVJE3fgnl/waNovkmLFkpeUWMd5Q=;
 b=X2DKeqZ0gmgNA3og/sU2+CpKMBMfkmOkCLubDr+jcIs94bv68y/7ccc4lBdzQ9HWwMVmdDRAujZMRr5ZFOCgeVgL8YJqlk4il19+w4iK8O8Z5Ha81WbB2L5XUgzpqiOs/TDA+lRaRo0s2eUFADI/eIOUue3x80Ly5WuskLeEkIU=
Received: from CY5PR10CA0005.namprd10.prod.outlook.com (2603:10b6:930:1c::18)
 by SJ0PR12MB8139.namprd12.prod.outlook.com (2603:10b6:a03:4e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 23:43:20 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:930:1c:cafe::27) by CY5PR10CA0005.outlook.office365.com
 (2603:10b6:930:1c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 23:43:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 23:43:20 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 18:43:19 -0500
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
Subject: [PATCH v4 3/3] cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()
Date:   Wed, 23 Aug 2023 23:43:05 +0000
Message-ID: <20230823234305.27333-4-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230823234305.27333-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|SJ0PR12MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: eda58d8a-2d44-4c38-1973-08dba432bb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KPSoNQ3NQmMPVdDQBgioOzWjr95NqMeEK6u5SW3jvSimfw6zKeBWW2jBfi8RcHuykAPs8DDGWLhfEeEGlELxRV6ujoMjGIwL9WghnxQPKDYR8K/w4yvStEvFJ8Aos9IFZaHZw6TyhMOrzLrZi81n1OJU0U0kJBpeM8YcapPo+oyptu1+yakvZLge61oTDbgw5Mcans0D9GeSwXEzd+p20ocVl4t1JNIqjH2hs+gujWGb5HaXHjWNYeenpInRIRAsaLN1Lq+C7LhZdQOjJkCZ5JlwjMBqFOUtSqC29eYBzlLcz6ccIxcTifG9wK06JK0UnmFho0tJBq0ImVYoqWLRD7qvUOY9NWIjx2j7MF95cHkB1mwKPWsKbiFDnwfr3hi2D5EkRlRtOJk0hNnIFI4CNp/slV7BF3S1gFF0JmhMHf4L7wRU5wrOJ3zzgcQtFK6EtgD1lKIxUQ5waNFSmm2YsnuowDp7JUWguujegJEdofvPTujY8Ot7iWWSVgc4GLObA+yR4qqxvFiYwHkC6gSvS2QDRt909YkPmrjInFvVNZuMWdKhyKnWtfw+TcXgK8TlmUWj14hLCp7sLeHRJW5Y2y3hLF/mIxSKXrCh9Pl2AaNV/3cIT98enCpsiwxVl56scTmDj3FgJvk+cMiNGAJHXmq+sQmvWqxmgsf2qltL+94UXhbJ5WMYH/tEPq7DRqBscZfhJ2f3sQc4rqOvLrW4VwY2rQDK3J38bydFBCbPAdBjW+g4M2xV8F816Je9alS9BRQeodhZNZ6A21AnR91yPw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(40480700001)(2616005)(54906003)(41300700001)(110136005)(81166007)(70586007)(316002)(6666004)(70206006)(40460700003)(7696005)(82740400003)(356005)(1076003)(26005)(16526019)(8676002)(8936002)(5660300002)(36860700001)(47076005)(4326008)(426003)(7416002)(83380400001)(2906002)(336012)(86362001)(36756003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:43:20.5140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda58d8a-2d44-4c38-1973-08dba432bb9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8139
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use pcie_aer_is_native() to determine the native AER ownership as the
usage of host_bride->native_aer does not cover command line override of
AER ownership.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Robert Richter <rrichter@amd.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
	Replaced pcie_aer_is_native() at a later stage for automated
	backports.
v3:
	Added more context to commit message.
	Added "Reviewed-by" tag.
v4:
	No changes. Just "Reviewed-by" tags.
---
 drivers/cxl/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 2323169b6e5f..44a21ab7add5 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -529,7 +529,6 @@ static int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
-	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
 	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
 	void __iomem *addr;
 	u32 orig_val, val, mask;
@@ -542,7 +541,7 @@ static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 	}
 
 	/* BIOS has PCIe AER error control */
-	if (!host_bridge->native_aer)
+	if (!pcie_aer_is_native(pdev))
 		return 0;
 
 	rc = pcie_capability_read_word(pdev, PCI_EXP_DEVCTL, &cap);
-- 
2.17.1

