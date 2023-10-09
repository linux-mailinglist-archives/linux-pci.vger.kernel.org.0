Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E749F7BEE9D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 00:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378950AbjJIW5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Oct 2023 18:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378939AbjJIW5Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Oct 2023 18:57:25 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358B09D
        for <linux-pci@vger.kernel.org>; Mon,  9 Oct 2023 15:57:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rj+5PO1h0t0lTc9cwCbMq0pwAu6DGOOnv+NlKaNA9uVUsMb70TGZhON70KLaIFgo4HOk0YeXv8e8bLaWhRTTBOo2hvZwEE7zkchg0eqpKDy4hCGF0hLQMy7HQlvY+PAuLwXrpyH6JqAeOPsvPlRgrDKBil/bp6Mxdv+Exs7TyLwcYHXpF4pFB3LX8c7Q0K26vi27y/mlU4wZDnxawr+/PAoXqaMF+JKW8yMvK5mUF7rhYYsXbo3hmfPSOw/hjM1zi1oa4dFlr8WUnPlvpQMPtjKNTuscx6ZOo/qN7o9NaXWMi+H/vo2sTL/GlRjjqiV3BPhz41m+ifnPW4iCCpaFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeMEEDA0o/xz+YB5OAwmFUl9k7FxdNparpTFBxGlRcE=;
 b=bwVbYRKG3QIDPYj+xer4MaNtPFuUtx81Rl4os/BL5DibdW8PluOW5OxEqKSqVg/BhbWL1QtPfbnQOxnTraNMgE++hMLyksbCNrY50rqiwDlcRNWjfJy1DvXBMeWi81Ic3dv8tlitkhCV18oILhRcVw2qaSgrpX5V8RtJL/Bpx9YqEuGTb0XLW0ED+BT/lx8MM74zorPzw1NhgExjmijltW+XiZYYfEKY2wticbEt9Sww1l0SHK2VthMsjzvm9Ahj95k1rFCUkQsQuzwzNr8/qtchUAqUXuYtsIZG0AW77DmRK725lIexIuwGj3GMoF5pbQU4isdQW/lw9Hqno3hbWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeMEEDA0o/xz+YB5OAwmFUl9k7FxdNparpTFBxGlRcE=;
 b=b9lEuxDvhZsrwJrZCHalgOyyVun+bVhjvSUInifePGP2mR/5Pek1bAEaJnqty+5OlvNlXpN6enF9mad7B4dfRCp+n7EaYq0+0eAO8tC8gyGjTlq5R/2ssihFTUeO55t0JROqOY4RqnnT0FxTC0C7K7exxyFe2swJ7ItlnFfZNNA=
Received: from CYZPR05CA0027.namprd05.prod.outlook.com (2603:10b6:930:a3::10)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Mon, 9 Oct
 2023 22:57:20 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:a3:cafe::b7) by CYZPR05CA0027.outlook.office365.com
 (2603:10b6:930:a3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.23 via Frontend
 Transport; Mon, 9 Oct 2023 22:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.19 via Frontend Transport; Mon, 9 Oct 2023 22:57:20 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 17:57:18 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [RFC v1 1/4] ACPI: x86: s2idle: Export symbol for fetching constraints for module use
Date:   Mon, 9 Oct 2023 17:56:50 -0500
Message-ID: <20231009225653.36030-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231009225653.36030-1-mario.limonciello@amd.com>
References: <20231009225653.36030-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: eb27af40-cdbe-4ca7-6a25-08dbc91b17e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSY5ZZ6SPk5Q5mkSGCAv+Zy1Lot3z1V2v5MvieOtxVlyJnXBxCwL6msl0ywbeyWA+M8k0u3t3YScI/XcPcXS3ioPYxmjdyih7DD5x5LUKwQdibdjouTLyK81GxTn+zYABS5Au29K0BotjMA1JWom1PMZwAVyESbhfYGXzMm+pRwfoZNgVsDMX4Gc+lWPIxqH6+8LD0bmlFCeGBbrie9ujioZGq/jduZ5o3Xfp7LYJIeVNkwOQI0J08bosC00+jNXb7hr+HQBJHPi0VvgFjpd5+IOvoEQKsZgm0nbQ5U6NWq2j79FvKFCjLl5D3vsnVtbjf+roe7a61rp2pYxnpBfiSSO5AArsZoJBNGkxxCytOXepSHg7b8/icsJP8glCQI3vzLSwzfoR3jRgSMLRWWEpVH/JANLpmuluA7JbIRAWiQqIr/gk6zC5fG0lA8Bnu+lFpIYSlaUpwDJC4kIqOjnipyK6FcRXiJ7es/zriU+Plyx1sieMz2Rfr36pkUAx4szfNi6g7inMdYYn91pwrd+ygRQpdQUfZE72hiIIq3CyTiufCdqBs6ltY70VPQKIPfNgV+Z4iIKrZAxKwb2Z8puTshbFc8WffUi/lisrC8FFe0W8NyCH6tU+IV2mj854aUdHKs20PQBEDD7B2JgCSTMSf5YIoOXHt8rvfPVhhje0fFrxvxJWpGvyLAZX3qQ3/4LQCeyFDuNJ69w+T9w6XHm4rfJ+z7okCFgw7NGENm2Y1PI2+BXXKxCCWdL/0+DBc9/am/MH2VRZy+2tuFdQ4RtNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799009)(64100799003)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(7696005)(1076003)(478600001)(41300700001)(316002)(336012)(4744005)(83380400001)(47076005)(426003)(2906002)(70586007)(70206006)(54906003)(110136005)(5660300002)(4326008)(8676002)(8936002)(16526019)(26005)(40460700003)(36860700001)(44832011)(356005)(36756003)(40480700001)(81166007)(86362001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 22:57:20.4043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb27af40-cdbe-4ca7-6a25-08dbc91b17e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The amd-pmc driver will be fetching constraints to make decisions at
suspend time. This driver can be compiled as a module, so export the
symbol for when it is a module.

Acked-by: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/x86/s2idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index 08f7c6708206..de9c313c21fa 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -322,6 +322,7 @@ int acpi_get_lps0_constraint(struct acpi_device *adev)
 
 	return ACPI_STATE_UNKNOWN;
 }
+EXPORT_SYMBOL_GPL(acpi_get_lps0_constraint);
 
 static void lpi_check_constraints(void)
 {
-- 
2.34.1

