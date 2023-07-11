Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36EBB74E385
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 03:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGKBi0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 21:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGKBiZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 21:38:25 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20619.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::619])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3983CA4;
        Mon, 10 Jul 2023 18:38:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3oLUua32ojT4jW4EQoYvv3gWRrsarXc8AU9XRXPaIGwNBPv6xgMk+iA34vbmMI24lT0GFwq7QpTQcUQVIYgHdEaoILh77keQ1CQkHJfV4HsuvzKgB9GAxFDLTBdKhu4gChiPiqd8VWn9tgSQ3WrWf9lWRmMwteP3lAAIeMWo2uvJ6pKROszJeBX4ZYhuPz8ca6KEqfZ+QtcTQWp5kBSPO3GfZ7KOrXpWBfbQS/AVzPT8a8jK9HwWDyP+oawIf78q74vCOKVg/2zfK00Qob/11m1cQyL0IiGz4D2KWtMVWp8PyCGX+V79RB1fxfB6KhcmiM6HkedHfm6l7tLPGiTRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UMwQ0anu9X0ninCnKVUnTw+oqIs4hJgxfAsK6/6TYg=;
 b=eFE7RV+FFf8+NG0YhC3Eta4W8/7avkw3ryj1RX6su7GSs0PMcQ8NVUildOe1ajkmPwAGLVftiZFfGCrvq4W55ezkelSycgVj4vQG3bLuUDWBjNVMBcrZW5RBS7QCLBQsHEWSCD2isy8fAon+1daTg2oFuScjVfFnwTwzpvKxFKYYY3UT8zsNWwgg0cHcLkuZxKNk8y6UJ7Q6ine7YROvupwlAqIVq153QUEpz1NuIOdVUvtOvy+AVMkcky2jpbLAkdVRAm4l6seMkcRVaydwvOm//bR7JUCuxjW1pw7H4rmx4QgTgu24+vNq8q5JbW62zC3nsMQ5CNHRV4S32aieyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UMwQ0anu9X0ninCnKVUnTw+oqIs4hJgxfAsK6/6TYg=;
 b=R7alQyZ8Xb5WN/olueptqZJ1Tp+l6pi5fKTQ0RO9Fpx8ygx+ace5LOnC5tjvWBXOe061SRBOIOLYZTWhRz7PQhmg1aKJwSBp+SO6N+9a/yjIHfTcIh4fAbsuJ/lKBcmk5I/W/agQGCzZwgxdOUTBi7VhDjso3K7018nLtoLtVCE=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by BL1PR12MB5221.namprd12.prod.outlook.com (2603:10b6:208:30b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 01:38:21 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::4c) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 01:38:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 01:38:21 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 20:38:19 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v7 0/2] Fix wakeup problems on some AMD platforms
Date:   Mon, 10 Jul 2023 19:53:23 -0500
Message-ID: <20230711005325.1499-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|BL1PR12MB5221:EE_
X-MS-Office365-Filtering-Correlation-Id: 36540204-c5b2-47bf-0597-08db81af8294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xpazbz+BjQSTyWL6XxZKZpj3VTcTSCPSGjnmpa7BQbSk20ikiXsniFe/Bn5mA7hGZ6fRx/QZJiWR5E7K+wupyGj7u0J5RdTN6NLSSQX6aJK4QbdYST0WimapZcpMtfkmB899sluDSpFHMeJIMrRiIdsr24nGuYBdiHSyzw0UternFAVoA8jhNHZK7mJs1zl4OyBXoDYRBhfFCTToOxrftIV42PlbqSBHsdfrY557EFICnOdyszlKHvbprZYNq1h7iQHAi4Teeq8rds2LiFdHwJJDqakcer4tH+o9DM7F/35w1iUzSUWEMhn7nacX8QxeEXkrNOXME7cVwa9PWRrbPoIqI+Tmj5AGx2DVWfh2bFjJg1Akf80tebubgWcIS1i5qPOcV3V6ydpNRWatKwbweYqIYcp+6mZUBvrOPTt6olWwbro1aFvH4qinKuF4gnKx4Byis0cWQVSg0F5EfeYMJEYVwRgqcf49aWPdk4TG7d9iMMvj4lXTKS9/8PbfLZFgT8YL92rUD2RSRAlWC1dH/rnyAf9jmx//ckawtXwVpzYAjUZ1Qv6nMlb2wIUaKysJHD2yu1QkHGPGWZj3yWBlxHQDAylmBxn7L/95z/UoCKWZMpIGOvAu2mbRz5Dtj5gLxyhNW4KRPBaUOvjOVIxj3LS7TQiACQHvtW9NnmJnC3PwNG17RRmGgWZw5/UiYCrKNnn5cVhiWgiMlXBY1Oqy4IFClztqvTPsak5V88o2iHRCJmqvx/Mai8irxtcCTJnSQhAgUmV57XLUoLD7vPcSLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(40470700004)(46966006)(36840700001)(44832011)(5660300002)(8676002)(8936002)(70206006)(70586007)(2906002)(4326008)(316002)(41300700001)(6666004)(7696005)(54906003)(47076005)(1076003)(26005)(16526019)(186003)(83380400001)(2616005)(426003)(336012)(36860700001)(40460700003)(110136005)(478600001)(82740400003)(356005)(81166007)(82310400005)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:38:21.1337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36540204-c5b2-47bf-0597-08db81af8294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5221
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Problems have been reported on AMD laptops with suspend/resume
where particular root ports are put into D3 and then the system is unable
to resume properly.

The issue boils down to the currently selected kernel policy for root port
behavior at suspend time:
0) If the machine is from 2015 or later
1) If a PCIe root port is power manageable by the platform then platform
   will be used to determine the power state of the root port at suspend.
2) If the PCIe root is not power manageable by the platform then the kernel
   will check if it was configured to wakeup. 
3) If it was, then it will be put into the deepest state that supports
   wakeup from PME.
4) If it wasn't, then it will be put into D3hot.

This series adjusts it so only root ports that are power manageable by
the platform will be considered for being put into D3.

Mario Limonciello (2):
  PCI: Refactor pci_bridge_d3_possible()
  PCI: Don't put PCIe root ports into D3 unless they are power
    manageable

 drivers/pci/pci.c | 76 ++++++++++++++++++++++++++---------------------
 1 file changed, 42 insertions(+), 34 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.34.1

