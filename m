Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362F0780571
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355011AbjHRFOz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjHRFOt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:14:49 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B212610C8;
        Thu, 17 Aug 2023 22:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcXD/RjLPWjKiVoMjXWrf9WYkQ4gq3UgCEQQFXzxVF8qxPPZyAp2PB+1sovhJcU4q59a+vKg0asq52Jqwm/5Sms7YdDjlp+9BznZFfZPCmYgSLVoyOsoz2D/D/JB+2T9GSseKk9zcWupFgeE8Llr2QB1jnDip8k+LN7unz7a5rtddFh4JCGs88vFdd/Omh4i4qibvx/T2sEaYv7V/rcwC/6aL2/m0I4cFAE5XOOGNZjricdT6FUpuLqmLuYizFbaztEkdbaDGl9Z20aG6GgtBr5Di0kd7aHHaGVSQdnl44BhtzoCvPwuA+j4v0Oqj+HXYlMgqhq2rMDhFqmNakfaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NA7IIuO5yaoRgp2ItnuvAm95U/WcuFzVJz0Fd72TYc=;
 b=kyQHuD/o8QIuj1lFkH8Qq8pchbUS6ycKtfxgDS1E0X2FmIsJLAXPTc0Bs5qt/VwJzuSt5lW+nDZBG/q+euW0ZfgfZZturcqFPWjG9R6gKydPYAiU+njvLwhLUK/zTqZp75yR9z31c76Q7vXQ4ozgkkXbg0lPuQTHO4Rb+r/T12ghLZpGod1JEX4e/zSI2RxZzdOughsX976pOWiYqiW+SvA1oYRIgqjjknz4aASWrCUUTirVVCs2vuRsfMlIHf1VyaArzCHB5tsrJOZ7tQOKxLScS/0vMrdtqNXDw2eRaf3IW83bpXn8n8mlfB+NLAS+0fAQA1Pd/LE/isoOcpEeyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NA7IIuO5yaoRgp2ItnuvAm95U/WcuFzVJz0Fd72TYc=;
 b=pN80IXKgZi5SruvT8Th68sMCrNkOviQdyn88NjM5hBgJdVIPkhfVWynigKVc1QRVref1NGCoVt4huMgU1bUNOQ6Adl6biK0jpQcp5zUNNL8c6qMj3+P+nwWHcg88XuTHtXHjTjqilvSk0rBR8EMz3yjNJ1wkfuqkED5ICc9nhDk=
Received: from DS7PR03CA0170.namprd03.prod.outlook.com (2603:10b6:5:3b2::25)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:14:44 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::21) by DS7PR03CA0170.outlook.office365.com
 (2603:10b6:5:3b2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:14:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 05:14:44 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:14:42 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v13 00/12] Fix wakeup problems on some AMD platforms
Date:   Fri, 18 Aug 2023 00:13:07 -0500
Message-ID: <20230818051319.551-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: cee6802b-7321-4cfd-bd2c-08db9faa08a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SS75PrI6gZ6NRD/aec0gNpqDfYx9Bv0xVitBx+zPZAcbzTQDXEliN6HVTWNSTuP5DdHEhRyC9NfQwANCvFk/p/elpZPV6i1iHtKpx1rF1N/iC6urlS1vaAIsZXm8vl+37Sy8e4tf9iF5DnVSVcv9GKFp1mrXI5jWZp2377e7OVAQwKk5ShgKXjICw8+ngvgdKxgTannMa5sVRcNQB5+Zf9LodD3ZFONayoYPRypCd8U3BKWo65NbiAzAI4ZE9QiteZUpuWTLZg2DkP0VlEBiTcolL5crv0spScnCIEaTVKqcuj1p3oyfn26oVg1A5f0TjBR1hiQ4Rie4vxLkQXSxpt+70NXulwN/Nv8eX0k036iCB9DTt4eaJfX+lmN8PocBi5n7ybNIh9jvZwlE/CVNt2AVam6uM0vUdKnUy3sRyILdlWjBDYQ9QTv9MaBi79yE8kfZ4SC9a8DCl1yJDchhB4CaSYceCcM27PFuLhjpzMJcNLJRQxkguxBrNycOCtMkXgaFIOEZWMVpY9P3fv/y7Jg65M0JgA4nwmvATBax7SXitQv0zwHfXcA+kujGjzC2x3Ezsm7cqJ/JUrR0ZLcdCFjP5W8PCGIUsrMl/TxmY50vF2MZFbSh3UJV+10rSmlbxWhGxIJZkZ5FPDuyiVufSAhwxnFGqj0744Xv4dBO3/15930e/pOs84jLfFZJ/cFGnqL8zcHC3yrl5NRImsYUzZCxjMwGUBvq0iiOKBG/4puKm4gE2XRGfPmdBjXyrb8aYdt2yAoTKhSE9XqYj+IooQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(83380400001)(316002)(70206006)(70586007)(54906003)(478600001)(110136005)(81166007)(356005)(82740400003)(44832011)(2906002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(1076003)(36860700001)(47076005)(426003)(7696005)(6666004)(16526019)(26005)(336012)(2616005)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:14:44.0586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cee6802b-7321-4cfd-bd2c-08db9faa08a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Problems have been reported on AMD laptops with suspend/resume
where particular root ports are put into D3 and then the system is unable
to resume properly.

This is caused by the policy used by the Linux kernel to put PCIe root ports
into D3. This series adjusts the policy to be more conservative and only
put root ports into D3 if the platform has indicated that it is necessary
to do so.

Andy Shevchenko (1):
  ACPI: x86: s2idle: Add for_each_lpi_constraint() helper

Mario Limonciello (11):
  PCI: Only put Intel PCIe ports >= 2015 into D3
  ACPI: Add comments to clarify some #ifdef statements
  ACPI: Adjust #ifdef for *_lps0_dev use
  ACPI: x86: s2idle: Post-increment variables when getting constraints
  ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
  ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
  ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
  ACPI: x86: s2idle: Add a function to get constraints for a device
  PCI: ACPI: Add helper functions for converting ACPI <->PCI states
  PCI: ACPI: Use device constraints to opt devices into D3 support
  PCI: ACPI: Limit the Intel specific opt-in to D3 to 2024

 drivers/acpi/x86/s2idle.c |  99 ++++++++++++++++++++++++-------------
 drivers/pci/pci-acpi.c    | 101 +++++++++++++++++++++++++-------------
 drivers/pci/pci.c         |  18 ++++++-
 drivers/pci/pci.h         |   5 ++
 include/linux/acpi.h      |  14 ++++--
 5 files changed, 163 insertions(+), 74 deletions(-)
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
-- 
2.34.1

