Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7504E7E8256
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 20:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345806AbjKJTRA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 14:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345771AbjKJTQs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 14:16:48 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F566C80;
        Fri, 10 Nov 2023 10:55:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTY+YvtxFwfNC/D2PcuD00sBsndxwP+CdxK5qiCs5EgPzEesLxr6GESg+zae3K9Ofh0wZgSmgFXm1ehfD/0L+6bXWgDwyaneUedCK7Qp/QFR9GRW/vpVNWQFlHoLz99HtJTvCFDFwNKB05s7lYxa3H/5E4UY9pRGH92kAzTBfOJJEeXmM9mEO0HpFx0h+hTMQWp+e9lOneHffHp7LhjzEYG4sTuEDlljOkPevJSareFs4zY86sOIX6bsB5YDAMhCpelByH4zp6eTaNU/CbC551M28TKTJxasFzlLcUeUiCeRCCsj7LtBTRHxtg/gvQkbIYONKMN+HKC/mGBWCQvcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te2U4OhyqhcboMmwVsPI/aIX8VIIMtqJNuHWbfVEFUI=;
 b=CaNLELaIA/0+UlrYyX7cMSaL3JSEUC3+c3Nz4Qm8rSCqAajLoVKhMXShfboKMCSey5ggwJuTU64GGygnysTufzgEs7jQHX768ALgcFJPDdkQEcTGfNNRVUrkvVDZLBZoiiKe/4xJiYdxKtRj7hAXacf9mR4d02PSFm5jalFrsE8V9L0VTJgpLXyQ9JocQA/ugQJbeK/48Z/bNaBmZ77VRPkaTErKpCjVY7aZG6fsvWYRDNEZJvgJ2cSCi8hxWbhS50LZ0vYqWdyiQsx9uvQ4pKLOgLUq+epxjR1kUDR87OC4ThJ/qCWcqkJDzkdJjzaw3IRe5zwaDBo8fwF7hBRa0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te2U4OhyqhcboMmwVsPI/aIX8VIIMtqJNuHWbfVEFUI=;
 b=FGrJP3Rmb1kDIkpxwQaAljjb8BYSkpepDtm3Xg3E6saaonb/Lbrzjt0mKtsOSyioVJMqoc2RX4TtjYq4JKZf/+vPU3N/o5BqYXXXzWp2AeU4r0gigOs37NBYdnVu0rCo0HDPqBniyxFV7IzACiKhz7JJxBqmmg/HiG5V/Xxeq/s=
Received: from MN2PR01CA0001.prod.exchangelabs.com (2603:10b6:208:10c::14) by
 MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Fri, 10 Nov 2023 18:55:28 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::30) by MN2PR01CA0001.outlook.office365.com
 (2603:10b6:208:10c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 18:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 18:55:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 12:55:26 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 0/3] Add API for missing PCI firmware specification funcs
Date:   Fri, 10 Nov 2023 12:55:00 -0600
Message-ID: <20231110185503.46117-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e950538-c656-4007-78cb-08dbe21e9b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4dQwvUIrplcbUw+t9vpTP4SN+ySTOFRwJiypW3iOnU2yUK9H/l0sXmVRSRJ2d+h+5DB5GyyuthYmdXMZ0vV8tz8ntqFYGm8vgnEs7jjTVUvJI9Jf+OxDbZUOyvvZ9gCTs+2nGXbb0AGM+6ImkmUq4ZPruL+nw9E11TLQX6MoHkl99ulpmmrvjhZdeS3FPGjFDP0EwhTp6X1RzGQPZ652GENXv4O8j9qzNIkCbq6JZtUBwZRHy5bD/B+nphzILaXjyxJXrpccUw0sky/vJoqjFP2szVMav9f0OXjjTUk8iS0nhbnEKwvImpw1HGAilfJjTDxOgvqnj9Le661EnS66eKv6QurHCaHX5UYNAUaVjTZa4lDIN947OI4VcKw2wnIiY5rQvBA/DnoC57OwtgviBHManzEDlzbYti4ZSRgab5fSpf01KSEZgssdBydSI4+sAdUlLT7whKt8FPaHo2oXEXyiYXyAczof3latiDCXzp+fDDZ2XumfLlptpWrO5Fgzm/kipG62cF5xYhuelST2KttwDh2UCymY4lATa2z49urrJQ63VJ//HANhHUfEH6rP6pW91t4Ors4PlmUOZunR9kxS4Qc/+rV8i0BaPiQ1pPsQuDR1q6e4vBbCBDO3KXfEgckQdWsDF/fjNDn2v5mo4zFWq/71c6G29OC96bcBVZsV1sbjzzoBZepQmkw8NYMYvGoWGo3YlYz6RIgQUGfwCa9Ceqim5awRc5+k6rs2aXgvgP7u8mnGs9SNcQT05eJ83j8s7v0oaIC7XpXO3D0H9hpMfsGA2lLf0HPQub11mZBNVc4vGzv9E5F1yzIkJUpd
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(1800799009)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(336012)(966005)(45080400002)(478600001)(1076003)(110136005)(26005)(70206006)(5660300002)(16526019)(6666004)(54906003)(41300700001)(70586007)(82740400003)(8676002)(7696005)(426003)(4326008)(2906002)(8936002)(44832011)(316002)(36756003)(86362001)(47076005)(36860700001)(83380400001)(2616005)(81166007)(356005)(66899024)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 18:55:28.0498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e950538-c656-4007-78cb-08dbe21e9b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URI_TRY_3LD autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI firmware specification includes support for methods for adjusting
AUX power in D3cold as well as the PERST# assertion delay for a PCI
device.

In some hardware designs these methods might be useful for drivers to
call to configure the platform properly for the hardware's expected
behavior.

This series introduces two new symbols as API that drivers can call if
necessary.

In the Microsoft Windows ecosystem, Microsoft offers a similar API wrapping
these functions for device drivers to utilize.

Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/ns-wdm-_d3cold_aux_power_and_timing_interface
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nc-wdm-d3cold_request_aux_power
Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/ddi/wdm/nc-wdm-d3cold_request_perst_delay

Mario Limonciello (3):
  PCI: Call PCI ACPI _DSM with consistent revision argument
  PCI/ACPI: Add API for specifying aux power in D3cold
  PCI/ACPI: Add API for specifying a PERST# assertion delay

 drivers/acpi/pci_root.c  |   3 +-
 drivers/pci/pci-acpi.c   | 100 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/pci-label.c  |   4 +-
 drivers/pci/pcie/edr.c   |  13 ++---
 include/linux/pci-acpi.h |  10 ++++
 5 files changed, 119 insertions(+), 11 deletions(-)


base-commit: 89cdf9d556016a54ff6ddd62324aa5ec790c05cc
-- 
2.34.1

