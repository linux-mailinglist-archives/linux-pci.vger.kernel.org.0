Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A786176F5E7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 01:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjHCXBw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 19:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjHCXBu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 19:01:50 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D662101;
        Thu,  3 Aug 2023 16:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2qcgtcoi/fFfxvyt+WOLOldTNfuVuXxGFR8s6/BAuEpRenbHoyQM4Q0y+8Byy4uKeN8wiV9AqBQxl44SdrgCgtpzEg5TF3PnDsqvw2nu1f+nlFIzIWS0vR5H/V5kCvaUIHJjD9kDrSQlWlebAza3uuPU+Vxv4+A98jInU1u5apSeLBUhgkaZG+37viYEa5I795FZoCa8/kLLSkWnE5m40huJOGXBlQCeUJtswEP/iwGLBvuMCo7UR9zrMe8SHzqr6FNmsm635XRgOqb8JOvep5rYvwLWTADqiJbOtHH4F+wKfHdHovYRku3xpIMXWLP2iDmeVyahrUAN58XfbXyxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E139Cu/GtI+mpX6fMkqExTq66BfVTreBbBqZapwpS/M=;
 b=cleKYXCpB7qSrkBtRMMKxw7gPpah6PTFbDiXgL6G9E0YyoG9+sl2+CVH3DcvpJCJxl285wpg+M3wGmFfWrC2YoOmFgPF2niQNhW5cnUd0fzIZogBejzHnYV/prY6TefuZuGZU8NF605aPpIijBYpC5Op8y9WbgscWWKKeTIBs0ZMqNgax+tU/CKclLuGeNynThT640UnpYQldmAM0YVE7gZEXD6gepiWJRViv8PdO8EepRGSkWfTcixjAFH39xPAsuTOGP0LHqrh36EljVFFBBUbQ9FcBzsUN5gMyd8iazVbQrxqCl1rXZfMaxMz7sbP4fdT3uxiv1La7SDAmizXHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E139Cu/GtI+mpX6fMkqExTq66BfVTreBbBqZapwpS/M=;
 b=qB/dkOjE/pCWvylxQqbT9w2FCJTDxF+maqZAozjwXmgHLDSTDRv71Q9s7a+cW5/PaDH9+sn8sMG7kjayKpGvW53+8lWyft9kju3EYoaK3Kpxs8DWLrRamYNhhLcVMTJ4uxn2Y0cswPqzye6pmWgmhGySV6lQIeMDKQzDxRqRSRM=
Received: from MW4PR04CA0222.namprd04.prod.outlook.com (2603:10b6:303:87::17)
 by BL0PR12MB4963.namprd12.prod.outlook.com (2603:10b6:208:17d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 23:01:47 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::63) by MW4PR04CA0222.outlook.office365.com
 (2603:10b6:303:87::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 23:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 23:01:46 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:01:44 -0500
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
Subject: [PATCH v3 3/3] cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()
Date:   Thu, 3 Aug 2023 23:01:29 +0000
Message-ID: <20230803230129.127590-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|BL0PR12MB4963:EE_
X-MS-Office365-Filtering-Correlation-Id: d4381ef0-5a58-4f72-81ce-08db94759cca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /w0jKppKSfX6dHi2q+DEotC2f0gKlNx+db2lYgHJrSCX8HyAwbjptKDJfi448EsdwvY5flkYziaLb0uN0wF0PZSzgZ4nfPNPCnEZXhe+tjEkcFxgXi3opGt4BXuxXoW1KUOIWMUtHy/mohrt6ofFRWcYXDWaOHUKschUxn/VIRjhp3g8vH8wY5qi1vCUuRG36INkecnqbKEIOZTsnOUrspeKG5Td9afTxzixt154NOz1LT3y86GBVEoVBegwOEfe/pvO0ZFjGDQzLn+0QnR8/9u222MKuf2cB0RvrqPDfCD1uwIRT6TlxkKS8o4+SHR858cISlrEZEpQ+1PcxLr1/xqUXpwVX2dN/YcVgy7roWOiIDyjT30tCm+9TlMbpKqF8MBtkzkaTFjPUUzTsH0xAPxHi/EqIGsdsPzn/MFdfyL0/0Dl+mrMWywTH7LsiBKA/8VwhULrUrp3TmdnQQOq+b2j9l03BbOeiToPSMfi8nApaZ3QXj1pLXgv3zTJK6Wh8tjF0UvbqN99EcKI7XXnynlBejQT2kbGB/iFwWGUh3lLLudcW7/EIoehx4AzRteMvnFPzvj2LNhmrREbndTDpBCn5IseLJsqj6AlgpkgCJYd4hWGL3Qq4yDTD+oicF67syhn+MBZi429EIfdxUHc8XfEK1p9JO9AmNBzNyDZz2LDAyI1BtIsCWPMIPvlhp/aJeihJYC14huTkfAg8b6x6ON8p1/pebPEX5tTfDUWVbhEQSPXnQ5anvXy0ys8LZReIJPctwKUFYyo9mjFZKlvrQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(186006)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(426003)(2616005)(1076003)(83380400001)(336012)(26005)(47076005)(8676002)(316002)(2906002)(36860700001)(4326008)(5660300002)(70586007)(70206006)(41300700001)(7416002)(8936002)(6666004)(7696005)(54906003)(478600001)(110136005)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 23:01:46.4096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4381ef0-5a58-4f72-81ce-08db94759cca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4963
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
---
v2:
	Replaced pcie_aer_is_native() at a later stage for automated
	backports.
v3:
	Added more context to commit message.
	Added "Reviewed-by" tag.
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

