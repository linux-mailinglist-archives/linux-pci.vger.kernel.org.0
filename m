Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DD78138D
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 21:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379810AbjHRTlV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 15:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379674AbjHRTkt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 15:40:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2080.outbound.protection.outlook.com [40.107.102.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AC33C3F;
        Fri, 18 Aug 2023 12:40:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g0EreEOvy4DCLiloMIAfNOfpMTkZJv5BF87zvNKTbPaGZbx8KfSlgfyYAZe9kpfqmHwcNgFLK3AEzRTyCrZNpNEmBuIz83DRZQSjoZxdn8mvWimoLrL0yLq4m+QHLoAyG4haWRMkBQzmUqmhqHylUubWxewE384jDOUcjTba5fmyvphrSRnnHvMjCWqpqIlyW11FITtaCMU0qxZi34nHIZsm8oKHb4mD9vq1e3ZTybYwGWf/sRyrN+iKz8lS59ZcW7vpCePydt6uUglEUEMO5dQsz7oQxOknsD7wJUzIfszuAlM0PS7VwTOyD5tlT/XeE9Fu014ap/Gh3jA6wwAzXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxCp6em9gu9l1WtHqJOMxSzpNn8+8sXX9wsDPjvC0C8=;
 b=hZkqY+24XJz0qswL+90Uw5cXTaOpxuGeE9YbW5J21GXlxkrsDcgWS3Zd0VdAMqPLBLwEnhpWIOdIn/3qqVgja1XGRtZQ5qPpXIPTgD5dMqjeI3JQgepSLpiCWwHrRfg6yZyLyuUQz2ShzUDduMwtWZyxuTETJha3nWB2SbyDBmFeXMmv9xbjTkY5Wi9pv4k89OdVO6PFlneEUVjwWr913IdjalIFlXGBSTHMMCGqBBVYfD+sPEDYeJz0bThAKS1jH1wADKId/coVBJOCutVB6OX2qzzOuI2db/GPfYMPbkG3MfI7qoJo/94wRGyPtKMyqyxgfwbLqBszfh79+xJLpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxCp6em9gu9l1WtHqJOMxSzpNn8+8sXX9wsDPjvC0C8=;
 b=SAD4UuSenEfExb8upRFqxCSWVJLMylTm/Eyd+EbfGk/rNyMNz1tZsUHnY30Fo5YL4HguXYl79fVmbD0054X8TwoSP0MQsoxIHZbbi5innHHEDf2S9Vo6CT/SCCtxW/CFo1XLNHCaHj5nKCbxK7vePI/8PMS77SeSSeexrtL/Qxs=
Received: from MW4PR03CA0173.namprd03.prod.outlook.com (2603:10b6:303:8d::28)
 by LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 19:40:46 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::bf) by MW4PR03CA0173.outlook.office365.com
 (2603:10b6:303:8d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 19:40:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 19:40:45 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 14:40:44 -0500
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
Subject: [PATCH v14.c 0/4] Use LPS0 constraints to opt devices into D3
Date:   Fri, 18 Aug 2023 14:40:23 -0500
Message-ID: <20230818194027.27559-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6277319b-93dd-436b-9cbf-08dba0230454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O59WfGyGdfaZJHYhpgkwp1yI6d0rR4B1NKehJQZxKBSCCo0U+abkQvfBMM4HGwCiDHPsP7a3RgSYaZpm99d0jIKyzjIYBqgIZjCJs7lxlfQMSay9aAe9PQupbVv+/obs4ach/7CX0lLDcoskr+8ezI5NlnkuX8zgnpU/g5Rw4pDkdgVz44dN35txo16p7tSg4fB6AeUJftBlG1BbWOQ9P7VSr49SraoYW6rEKjB+2XxRx4ydYu3HvoFggtGEKRhnmWc18RhQes1NSb3Pz35HRjJNHXPE0PaEt4yN+BW156t1AeYgx7u3RnQt0Mcg8q8WRIy9V6xrz3qjOln3iPCJYEnyVYP6J1C7iC39LbH4jOFwZPqrvGEUv2sx1v/NkLvfIlXpVTv3fMBs0ZsxITBhL5V99xaSu8HNegP2lgHMLYzfvleW+y9UGyKVge5E5geRTS0j5DaI0lIkzE6eIu83ATHWWcTy68F2eN8LEWmJiMyfi9AZ/Nt1YS/lHs1kCMhokPMdL7/hFAL+YnnZa/g+kjJPl0ZOOOohLwNWDlGSKP634IzzO/obAtXkbAvaBvnM97i+ArmxQ+1j62pOsNIbPXPIdvuS9N5Mq5FkZ1hcBBgadYrbnFRpAmZ1ky/gMO9OHFOj/p3Q+cvNxqdPrPzW3wBKrz+QbhnYMgIcx2KEPWyEP33DuYqM8Iqo7Aju3dsMzCYmNUeVebWxQWGEO6N/0XQSX3WdMyekZg/DvJZFFvs38X0WP+EiRdLRC6ueuThBRKR30QrO01E6LhRiOdRyVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(356005)(40460700003)(316002)(36860700001)(2616005)(426003)(336012)(1076003)(26005)(16526019)(6666004)(47076005)(7696005)(44832011)(83380400001)(5660300002)(8936002)(4326008)(8676002)(2906002)(4744005)(478600001)(41300700001)(110136005)(70586007)(54906003)(70206006)(82740400003)(36756003)(40480700001)(86362001)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 19:40:45.8448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6277319b-93dd-436b-9cbf-08dba0230454
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

LPS0 constraints specified by the platform can be used as a method to
opt devices into D3.

In v14 this series has been split into 3 parts.
 part A: Immediate fix for AMD issue.
 part B: LPS0 export improvements
 part C: Long term solution for all vendors

This is part C, and applying it is dependent upon parts A and B.
It is sent separately to make it easier to follow and aid with review.

Mario Limonciello (4):
  PCI: ACPI: Add helper functions for converting ACPI <-> PCI states
  PCI: ACPI: Consider non-hotplug bridges for D3 in acpi_pci_bridge_d3()
  PCI: ACPI: Use device constraints to opt devices into D3 support
  PCI: ACPI: Limit the Intel specific opt-in to D3 to 2024

 drivers/pci/pci-acpi.c | 101 +++++++++++++++++++++++++++--------------
 drivers/pci/pci.c      |  14 ++++--
 2 files changed, 76 insertions(+), 39 deletions(-)

-- 
2.34.1

