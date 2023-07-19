Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30CB759E7A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jul 2023 21:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjGSTXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jul 2023 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGSTXc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jul 2023 15:23:32 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8d::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C6F1BFC;
        Wed, 19 Jul 2023 12:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7xwIkbBn0YxMXAKfwUgcZV43d2A1umkURih6GMWz1IV6F9lqW0QORcHxTTfBvexeM8mUgOkafK5K9b6dtWzlBEN9DuEmxBnQldBhIY/ijeMsbE0476M5I0lo0tr6TFskTbxt0GXbn9T5SkLFCqpd9A6D1+qaUsGpGC93E2BS7hCC9sV+0dIoYBBpBFfun3zGfVaRDaLIxN4kpk6eTQVpdM2J+fCrvssmOyTIffp0aPoNhyLcJlBmiMqGQBktgTUFtv2uItJMZ4vTiChgEBPGyWnk0P9Dc70Ebb6TeGzgCT+Dv0+LQfRDD3mBkd6LfcXdDKhEZKic6wYPYeGOLmDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnVOxWBrxNU/yJ5Ip2Q965HakR2b6pFC4vrQYvjhZAA=;
 b=C7PwM+MSa26dAs0gVkOvN2JclyeJ4Z6y9OiLnZeeEKhGsnNIhJH18ytrb6b76EKKI7j/tPJwMMaB8ynvaItGuc4e/v4yEe5O2P8UlWau0vJhd9eUowipfcaCAuU9nJfhwW5xqRjNxT8Ceb4xDzjLanTa/3WjNw4zmv3dH8l8DI8jwls7HGJEAy9/U8XGZwg6TeMZ51AvZqUx9A0li4S8IzAhpnLYWX8o4wVEx8r1Z8sJIxjRsffRnIe2c6UYV+k7OmB1JA78urOQqu9rwEo0HVH7I4c3M5y1GoL7vjI9gvALNFTKtfqOGP/cyD/z39Gim6I2gV4ELuUWk8Sr2FGrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnVOxWBrxNU/yJ5Ip2Q965HakR2b6pFC4vrQYvjhZAA=;
 b=FiBbxFrbR/SYQARkl5Fh41e7Pn3P+S2hLLGsHLH6hQ52U65LGwv+OKRA7jR9CuZF1oLyJGUOe/i5Bbj7qoUHcgkczKsIgkchKVC1+zV+Tt0KDhQ3Up5tXqhwNt96LiTf3Fi6jkSFSIEJX7K/mEsDiOWjqlVnuusyUIJN57gWAfU=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by DS7PR12MB6213.namprd12.prod.outlook.com (2603:10b6:8:97::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Wed, 19 Jul
 2023 19:23:27 +0000
Received: from CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::21) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 19:23:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT023.mail.protection.outlook.com (10.13.175.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 19:23:26 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 14:23:24 -0500
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
Subject: [PATCH 0/2] PCI, AER, CXL: Fix appropriate _OSC check for CXL RAS Cap
Date:   Wed, 19 Jul 2023 19:23:11 +0000
Message-ID: <20230719192313.38591-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT023:EE_|DS7PR12MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cbb79dc-3d56-47a9-0533-08db888da06a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8/Z/mkxUAAmdHt1LhyGbRSiZIji889gnSbcKF9iHksrs+YP8loyuS2YvjQ1WEk3mQK56EI22XeCErzm8vV4oBE4+FG/vU+H0lGrwxs7T/ce56SIin2b8fa4RuCFZ0+wiu+kY7v9BLzA8ycmj7LMeioiNC48q//Be4QxpqQu1tAY5FnimeYp3jqDWmnPc+ZtuQ4Cvc9Cts4PGUtR18kuxqqT3i7dmrPl3T4rBnYO37jvB7bQw9qVgX3bdj/UkmgadAB9mYrqLBM/gtpg4TrtrspVVv8OE1SVw02fIQ9G1400s0xxmcAJ4hRbFJiLTUCMfTSFhRI/cFm4wC46ZVUvZPX0ZlrZWT2CpfZpj7Vvi+KUkEvX1sUVuekTAd7n3aH53YN735DhLW+kPoZap+/XmgsT2PBqUpVpetuKJ/5BhFIzTu9qIYVI0rX3LvoqxyhRz5veC0O/+c7DqY4/uVotiTQ+3tPhzZy4x/GW9dAVsbkIv5PaRnD9fmC6Z4evLLri9cEkQuToeoqmvVQLkFM7L0Md4jBQzeOc6zOQ5uk34Jd/WRd+/p8MC993TknwzLtip/Tl75IK2EEuqiojWaGUzHIwabuDbN//MCDC5g7teIE8oLA4+ZWPF/T/0zkhB3ys+7ITYmeLdoHjwGWgb/f49a+ZaXz7GM6JSC6THvRU25IFnJYDwpEwJwYzqb6VRMVzqLCIUnanpDES/aN+0+4wPbJlEjhWAggvfH2sIXTHcIdCQiho8T6aGd1b2H+QVW9bnSjXnS+8HJnjhkg7ijrqA0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(40480700001)(1076003)(26005)(40460700003)(110136005)(54906003)(36756003)(81166007)(70206006)(7416002)(5660300002)(70586007)(4744005)(4326008)(316002)(2906002)(8676002)(41300700001)(8936002)(86362001)(7696005)(356005)(6666004)(82740400003)(478600001)(83380400001)(426003)(47076005)(2616005)(36860700001)(16526019)(336012)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 19:23:26.4563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbb79dc-3d56-47a9-0533-08db888da06a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6213
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches fixes the appropriate _OSC check for CXL RAS
registers.

First patch moves around pcie_aer_is_native() function declaration to a
common location to be used by cxl/pci module.

Second patch addresses the _OSC check.

Smita Koralahalli (2):
  PCI, AER: Export and make pcie_aer_is_native() global
  cxl/pci: Fix appropriate checking for _OSC while handling CXL RAS
    registers

 drivers/cxl/pci.c          | 7 +++----
 drivers/pci/pcie/aer.c     | 1 +
 drivers/pci/pcie/portdrv.h | 2 --
 include/linux/aer.h        | 2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.17.1

