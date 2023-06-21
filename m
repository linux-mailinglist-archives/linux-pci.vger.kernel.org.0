Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8703F738F36
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 20:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjFUSw5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 14:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFUSw4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 14:52:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B1AE6C;
        Wed, 21 Jun 2023 11:52:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSD2Z5ldbM4KMgykADLal2bymily/WcL2gZpc3o8rzbF074s0nnlJAcTKnorS2LQV0DtYpzyb6V3BNjAkcIfTARaEaOs3NJipbtN+mRa/Yq3UCJAlHfJan9hMswzXIS2w1zJdilbHPspLzIu69KlF99GuLqbU5UaT4xuhUSA/BMM7A/2xBHsrS9sFMslMO2Minp6UCm8GxFIqnhJmdpckTHdcE1a10SVosGK85grM/j3BIjW/QRpCZX1Mqq6+Cd8L2mF9M3JlsdCcWNLOcuf+y18kFJEs3G8Wudveixc8GQ25fs9WAd86vN9LSnWJYPf4AUYDx2vqMvPIGz5gDWjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQmd5CIaVqIqJgewV7MARdUTtyvzhThvmxN3sQWj5Wo=;
 b=GemmzcO65PqUZobmxYrMaBscREeUOujMl9WOpbCoPkq/lUvZw5wHaqE1LtNqsUOkh7OTz8q8o0KoQS39AneyNqNEnvk6NQzziNf52nIGWnsbbZWoPO6/v4Qv+HwSsOLWEERpF4ItYRkxuUBUDlkZjbxE7AQYOOPvDHjH3Vs9jEnG33KvhLw3j1BWI9WBqAG4UmKuEeKFlOLzulgDn4iL8Fwk9Cv5La1CqtLFHxelUpKeJkep77o61XcioSJfyxGI41TBf4vSB1Tm8fOdeSyu38D8PoS6ZczTr+a0UEA5LJiEp9RaG7J9p98HlZOVajX/BpEfxYxvMTP+24anpfa5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQmd5CIaVqIqJgewV7MARdUTtyvzhThvmxN3sQWj5Wo=;
 b=YmFS8ziK5bbfm4HQ9++a1shUAc/kIQbUF417C1+LxRP1ncDlVCnfNAzegs5MCTu1kiW+wTiUpWVJhc1RJPORvhtwGLXkS1CHBTe2LX61yVcP5QxAN5V6sS7M+k/K4ex0FCM/KsbqjNcX1Wy3PwO6ZSIAgvdWRw5Hvzpjcwzfs9E=
Received: from BYAPR02CA0007.namprd02.prod.outlook.com (2603:10b6:a02:ee::20)
 by PH7PR12MB5926.namprd12.prod.outlook.com (2603:10b6:510:1d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 18:52:51 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::85) by BYAPR02CA0007.outlook.office365.com
 (2603:10b6:a02:ee::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 18:52:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 18:52:51 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 13:52:48 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        "Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v3 0/2] PCI: pciehp: Add support for native AER and DPC handling on async remove
Date:   Wed, 21 Jun 2023 18:51:50 +0000
Message-ID: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH7PR12MB5926:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ab4c96-6db2-4492-6169-08db7288b6f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLdNtf23N5vEP6zIvV8Pkzh7lmKNmrzkRyMVP/O+WTKzQWrOpY739/TBvl1DR4rl84VAzqvYoWPfeuJ5tOBVj5Y4yjKthpFbs5iVn/KcLL2VXPV0STrla41Mz8lk7aCS3ZkvaQsFAI62cQ/RJ+gQArCQVeVnWwSzALIk/auYKXJXjobWQTskaU5/TuG4x+UUk0WY4EwxRc4Jx4LieIxTVS/3xSRKCVnkkvezfHAoPWvTpsTlfU2LHRAm2Ww+72EAHsXn3salmbCMP6JjRGfHXDAeaPmSQLmU9Ml4PHh9/gYpI1wlsRmtfurYT6QWAoNNpWcCtUNCLCvtS+KDj16NEeNBQPVwuMylU7AYpE+7w3/892qJdE5xVT06ypNteOW/g31lA/6U4SL8xFVn7uXPOxoGNGGPtLCJflFWaW18hPlL4fygvOtDOxz5LRWDYWxBBmvmOT1HtljC2/Mi1+LCuEuJmsBIzG/bu4t1YcoUYOfIcPuZ9nbMnisr/h4124QY6UAtCVHncUFp4YGGj0xeteF5enP8f1vwzx2qEtR1SdE+fUED6ck7LMxAOkz7ehSDDj4WlJFVcxi1kpoB97b2IwRUCyWr7CFG33IDltbYEHV1jEHtO3uUDecQOmLFmsOUbGwW286Mdzwdj4UfjM3tW+N+dg3sb3MkhIEimeKNi5FTraedMRmu6gDCsfjMeck1eD36y4YmunKPUNrN7KXudwX6+G4vXzUQ7qtMkIM+8BrdbLnjRmNXOwV5y7aUIcEPPf+lhqFThp5D2Pj2abqzZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(36756003)(356005)(81166007)(82310400005)(86362001)(4326008)(40460700003)(41300700001)(8676002)(966005)(5660300002)(26005)(8936002)(1076003)(40480700001)(478600001)(2616005)(16526019)(186003)(4744005)(426003)(336012)(2906002)(47076005)(54906003)(316002)(70586007)(6666004)(7696005)(110136005)(70206006)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:52:51.1729
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ab4c96-6db2-4492-6169-08db7288b6f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5926
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

This series of patches adds native support to handle AER and DPC events
occurred as a side-effect on an async remove.

Link to v2:
https://lore.kernel.org/all/20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com/

Smita Koralahalli (2):
  PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
  PCI: pciehp: Clear the optional capabilities in DEVCTL2 on a hot-plug

 drivers/pci/hotplug/pciehp_pci.c |  4 +++
 drivers/pci/pcie/dpc.c           | 58 ++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h    |  1 +
 3 files changed, 63 insertions(+)

-- 
2.17.1

