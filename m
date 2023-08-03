Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B672776F5E4
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjHCXBs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 19:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjHCXBr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 19:01:47 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9FA2101;
        Thu,  3 Aug 2023 16:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFFdwECzuG/wUM9FHxxBVbSN3DvrqP1LNBa0WKZDh0OUTMCMBybZu7R7sZKjmQol7BjCvCi7SSRPvxaXBsIKJbowZTyWxof4ZrZ1/HgeRW36DE6TV8AcKF05mR+SgukwvwFrdZaXHKgoyxjlcvX0p+nfhCnlhpm9OfFTWLq/RzsH9VGk/8s6EU3dZ/ufRwq2Y1hyf4xmqK2ZKwKPJtw/arrOiCZIDuVJTcb4gdoL90CxkXQscxYudvsSn99/u8LAVbUXpxO+4PbQhkNwmtUC7yW1RPon4xLNzbet7oMb+RFu6eSBb6zoB+bkA/Y7FaovOY085PlbEXTtDwA7BcYFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q878+yIBYuhPs2ICqxGGfvLq1gZe+uiZYmKHej4i9r4=;
 b=Lw0uLgSkzQc3g5Zxqq5NEIvtlOUTJKYfbdCYkrpRUbyu3TsmoSX+G1sW/SgEZb8xo4Vz2OVdr7gA5YiFK6lP6pBNizwX7WPbEXzdLIKWO6JDuBGnbOJEqIG9j4NJ8F415piNxRlsuXMBvpYrtUGyBXx7GyMpUXAz6iM7QgfupZwogDTUuYGHQyJ1DPKTBnb9cJGA+coS/uvgP+3f4S9u0ScEdDlY0sQc1R3vgQLcudW1sls8F2F+8IgY0rFiFTug1Zf5jvc83mcmZglWPeEWXqB4hI7XONON/OhSw8yLqLkVKQHT1mqrPkQ5G1oRCceYAmYC84117aQbja7fKcmb4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q878+yIBYuhPs2ICqxGGfvLq1gZe+uiZYmKHej4i9r4=;
 b=JbRzekXiqHnxg0hJHQFX4GnqPVUXDM6mvJDODejOSlawstZQyF6PAHOoYB1Y2MxSno+8sKnDjbmvXlDcbPHezYg7I/5LRt32GSt1PV3mztssT7VbNJv9JfebEiOcft6Ltw8HZPiKXIg3+vJO2mIKgFzzvSwcYBeQNU2QaD33W6k=
Received: from MW4PR04CA0212.namprd04.prod.outlook.com (2603:10b6:303:87::7)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 23:01:43 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::a9) by MW4PR04CA0212.outlook.office365.com
 (2603:10b6:303:87::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Thu, 3 Aug 2023 23:01:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Thu, 3 Aug 2023 23:01:43 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 3 Aug
 2023 18:01:41 -0500
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
Subject: [PATCH v3 0/3] PCI/AER, CXL: Fix appropriate _OSC check for CXL RAS Cap
Date:   Thu, 3 Aug 2023 23:01:26 +0000
Message-ID: <20230803230129.127590-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 06d7c4d3-7a95-4165-5af6-08db94759afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F9vP/OAbS6QUDS0ruj000STtuh0ouptN0OUz3WcoY14WxGuk5rSYigpZyh7I+w/1rwvwbwwsHyZlf+gM3zHntPJNy70wpH8uGnnGEz0wGqbioiD6zcQn7iWm0zd7/7wpTYdA51XF5QZBV7Fod7EeMKkUpWB+SSWqzv5Vkqykemvdfp3RI3o1tkt2NVmzHZzJ6eXgoGLf/TOc1lbqk6h9XzXEoXiQrNi0EL+bDh90QiM8KpnA18jjE8fx1bmpPHIqTYlBtGBbWcCIIpiJyIQX6+UuX86dAJ2EX59tHHX9ttdvwnVh9tvzVnMkTuFwsYwlinaPx88St4OqW64fsu0P56aky7O3Ryhz1YLHH1LQTNYID8Qwo/9kOeAkacFpNsFN7e2DR0vRkk6bhcPNMjRpwoWz0Y6vC+DOJ/0dgpDuCKl3Lwsnm1xc9Fm2ATdV0PKC13khZ6lPxGuQCaPJ9Gh26U4ffptZZl+z3zxz4kKE8B6SugE+kqAWEicOtPOF8qcly/vGxpuwy7h0DyHtgPrvQ0GdzggtvcUi30xvUA6QrL0bm/Mm2Ne94oUjBRVLL6w/Dk6idbh6bBTL/uwbwsKFxOUaQZp5kS2Qf0onLtPcD12DJMw6shVHnMZaQAnljpjb5x5uGvaifNEkAbndiYHoimmDq4r11VqY5EOWbZVrQBF0nwTNiW7p1+6KSjPex2d9wRzvvVuuG6vBbGiJ4octbl6p5zQU+WapsiVs2yo7lu7VDjS8CXMyp8swecZoNJPd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(186006)(82310400008)(36840700001)(40470700004)(46966006)(40460700003)(16526019)(426003)(2616005)(1076003)(83380400001)(336012)(26005)(47076005)(8676002)(316002)(2906002)(36860700001)(4326008)(5660300002)(70586007)(70206006)(41300700001)(7416002)(8936002)(6666004)(7696005)(4744005)(966005)(54906003)(478600001)(110136005)(40480700001)(356005)(81166007)(86362001)(36756003)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 23:01:43.3939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d7c4d3-7a95-4165-5af6-08db94759afe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches fixes the appropriate _OSC check for CXL RAS
registers.

First patch addresses the _OSC check.

Second patch moves around pcie_aer_is_native() function declaration to a
common location to be used by cxl/pci module and third patch reuses
pcie_aer_is_native() in cxl/pci module.

Link to v2:
https://lore.kernel.org/all/20230721214740.256602-1-Smita.KoralahalliChannabasappa@amd.com

Smita Koralahalli (3):
  cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS
    registers
  PCI/AER: Export pcie_aer_is_native()
  cxl/pci: Replace host_bridge->native_aer with pcie_aer_is_native()

 drivers/cxl/pci.c          | 7 +++----
 drivers/pci/pcie/aer.c     | 1 +
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/aer.h        | 2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

