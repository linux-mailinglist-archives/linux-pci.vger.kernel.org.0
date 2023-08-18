Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4010A781384
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379698AbjHRTkz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379666AbjHRTk2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AE9421F;
        Fri, 18 Aug 2023 12:40:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjdSmBpeHZ5o+Xq1sVXZPJGjE1gNuFoX6acT80Vo5UgebBqHjWW6h+rmjcMwq5sVAX3hjNROREEswWr5U6JadRqZWOfsnV9jvIdtbVyMT0XSNqvpxkJEYQgMSbdOGvDRKKYGHV2pqetQpACoWcuW4K8bWLBsso6pMPShEFMQbNGuatgXxvFrTeKvc/RAS5iOFhrqVtfZRcpgyA1F2HefyaUoKDoehx+gohWbLGvhGN6RtZEJtcaV7QhQBusAikgkz63B+iQU8zqmhTgwAVwh6ArtTV46vQ9YEEobA2pNiuHqhBueSalIl+mGDMpxGHk/QDFZOXBnUDNNXiVQHnZaQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8HJCidW0jfcJJ9a+IRRNX+/i0v+T/ZRD7q4+ZGmFSY=;
 b=Gt5eXLVkTHFMGVaB5oIuLh/DC/MNDs0975MuWjy8r/ibD6QfIATY0kyaJufOZNHDjxFqFOJzqaG0l3XPbULGvCn3L0VcZl6wL0XLZMiCgBk62cN3WbuAO7K0LaCCFKg53lrvz9J4pVdwddGbGp1vNGe8EuyngdCZgWG0bccnLV+KbAiX8y6TREREUm1ay3pH1dsJJaF6NuOg2LWthTgYoS0jnMxxZ5pzXsLEodsCjoB9uQ0cohmyPnZ3u8QV7pVhAGUCwoIxRiXX+eNLB/kP6lA3m5jPV+qERVfuZvbacXTW96+UF4rTxdLJdzEi/OJ9phxMgSt93ljGmO/hpUpufA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8HJCidW0jfcJJ9a+IRRNX+/i0v+T/ZRD7q4+ZGmFSY=;
 b=sjJ0lyiA57sBOPCGwgogqPTZ+84burJbaCAtcAfpqMbB4+w+XLanqaZVLUtLxq3kZKdl3R4JRokSlQpm1IpKO/Z1D0GUUVMxESmh4wXZRLZeERwRzWdXwXSr7cNDlH3jY+C1cC7QkH3DWGW0eobEHgPJWJChzSXz+1EYy6JO/9A=
Received: from MW4PR04CA0241.namprd04.prod.outlook.com (2603:10b6:303:88::6)
 by DS7PR12MB5767.namprd12.prod.outlook.com (2603:10b6:8:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:40:20 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::b6) by MW4PR04CA0241.outlook.office365.com
 (2603:10b6:303:88::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:19 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:18 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, Iain Lane <iain@orangesquash.org.uk>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v14.b 0/7] Export LPS0 constraints
Date:   Fri, 18 Aug 2023 14:40:00 -0500
Message-ID: <20230818194007.27410-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|DS7PR12MB5767:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dfddf7-25d6-4818-2f7b-08dba022f4d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PDycD11ZGwI31UFMDPrO6+It19QoZ3uipOMtcJKJt0eovqqcmFHwdUq2hdwwH2VGWPwSmSW41MU8AildVhAg02N/zSN8keqPHMoI6zJb9m6mMQ03j6HWCBU11cvzRl5RK/SY7zte0yheWws0U6EF5Upp3fUoY/tjAIbaY+6qVc4egwAalRdl/xEH4DwbfAfpZwwNv/YmLRu6D41/IcYOfyndWBHw43a4pCuPcSmu04lKKNXA+1XK9kLyIK4f6Et1wl3iCC7WsIgqOkhMFIjirjurnc4+8bYd19r30zLtyUNLSPajG0usAAtGZt2T1hFqu4G/kTSfWcnSFPkSx+5RsEqE/pejLfMjBP50P2E8q8oHOEWsoUMAijh1GrHinTzMWm8eHroM766IQYnFO/y/TFOEqC2wxSew+NJy/n2LYpoKWf+ENOFxJ7T/rna/7Gxh69z11dHIg/ux6T3BOd2iTov8AgDkCwzvD8cgeGAPiGCPtMcwLErkcy1rbeMiQlmKG4iNyZVphj4p2XAOnSHZ1VNzZ9L1lJ/PSF8JA23nItWQGDU/BImL++FBifRzMheJFEWHXBsiTsZykrYt2T5Q9ZuGYmyOQXoqKPOfNydm27f6/3q2PPgqwLjdMRBx9i0W7qM8dS0JA56Lgj6Mn5GYNEoOFzEmIRmO+djAFwi+TJcF8ES9AUj9NFyJ4dyrmAKN82FHljxG2dH4+LI74SfmJULC3xquOPbmjsAAvR5fYDNTQhzvnCLSiDw6E3FW0aoeS7Rtbo3PYZQ2ZskXQ/lM2A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(110136005)(86362001)(70206006)(70586007)(44832011)(5660300002)(2616005)(41300700001)(4744005)(2906002)(316002)(54906003)(8676002)(8936002)(4326008)(478600001)(40460700003)(6666004)(7696005)(36756003)(82740400003)(356005)(81166007)(47076005)(16526019)(336012)(426003)(36860700001)(1076003)(83380400001)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:19.8544
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dfddf7-25d6-4818-2f7b-08dba022f4d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5767
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LPS0 constraints can be useful to other parts of the kernel to make
decisions what state to put devices into.

In v14 this series has been split into 3 parts.
 part A: Immediate fix for AMD issue.
 part B: LPS0 export improvements
 part C: Long term solution for all vendors

This is part B, it can be applied and reviewed independently from part A.

Andy Shevchenko (1):
  ACPI: x86: s2idle: Add for_each_lpi_constraint() helper

Mario Limonciello (6):
  ACPI: Adjust #ifdef for *_lps0_dev use
  ACPI: x86: s2idle: Post-increment variables when getting constraints
  ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
  ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
  ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
  ACPI: x86: s2idle: Add a function to get constraints for a device

 drivers/acpi/x86/s2idle.c | 96 +++++++++++++++++++++++++--------------
 include/linux/acpi.h      | 10 +++-
 2 files changed, 70 insertions(+), 36 deletions(-)

-- 
2.34.1

