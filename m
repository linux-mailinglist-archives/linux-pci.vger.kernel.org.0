Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF546AB6F9
	for <lists+linux-pci@lfdr.de>; Mon,  6 Mar 2023 08:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCFHYw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Mar 2023 02:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjCFHYv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Mar 2023 02:24:51 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD14B1EBC7
        for <linux-pci@vger.kernel.org>; Sun,  5 Mar 2023 23:24:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWSXUsbFyi4g6bTDYIgWsCUc1vF58QMdDpnqpKQxJYf9eVY/YhNWqRHUVOCy3tV0pFob4fEzHwKR3z9XeHkX2PgE+NrCHEK0wW0CJvVsFcUv5Ws2aFcqaMI/W++KR28aoq11RCsB2oo5n+bOunpXhnJKKPntdWvZh/sq0d4yzETEX7CnWk3fJNIu8Uet1gZVRirlVpqGs7amMfS03aTiWqmOos30UE9KSUplbYMAnyh+SWwCVJZa+axYjZfLCNOFtyIuC5MRxk7ysvD7DPoN47cG0Wr5nNPS6tw1Hd6T730BDmyAY7bQgIrbC8F6F4/SVsbsktNrFboBOaDZ0UBhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pIVJX3uUw+D89xVcclhKTn2js0Cwh1frq4toex6nUNE=;
 b=ABIBEQe5Hi0GN07hqJVIy1smDrJWmmVuBU5AMYxCrgXP1Y4dCd9xgccMLSYIFD8H3EkPZivkZUGpobyoR18iTuqXrcSaTgQmb859Xni/1gYpFz6YKD9T0o55eGJ+l7oB5ctf8p/YxMM/KEmeVOD+T7uZ5k+BbOjTdaC3jC1KaCkINw89xRLItwFoGUMr52P6rzBrP6/dOeWbN3DBzmFrDq3qqFM5ArOe1ng4okFHKn/I8N1GNNNx6wAjht11wNQ2AaCYhhO9bvK3gOFRIvwNBcuDyXIwrmhva3PqW5veu9wWiawzeV5pbYJR71lCoQ8wx+3lUKM9iq8mMgBgfJBMJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pIVJX3uUw+D89xVcclhKTn2js0Cwh1frq4toex6nUNE=;
 b=Una9Moh5i3oQnCGoPjxKvh+aFZv/Y2LE7mUzTiPdw0mSkf/wL0pdAb7xmLvHjNyXq4U0/awxvmuazFCIeIV6BciRYPJs+xsoKVY/GeTrIIKRmOdXhXR/+6AOs5q52p4il+5CFVAdvTWTm0OWioM2OUFVXnkj7JUCGl2jojtDffo=
Received: from DM6PR04CA0024.namprd04.prod.outlook.com (2603:10b6:5:334::29)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 07:24:36 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::9d) by DM6PR04CA0024.outlook.office365.com
 (2603:10b6:5:334::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28 via Frontend
 Transport; Mon, 6 Mar 2023 07:24:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.15 via Frontend Transport; Mon, 6 Mar 2023 07:24:36 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 Mar
 2023 01:24:33 -0600
From:   Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <mario.limonciello@amd.com>, <thomas@glanzmann.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH] PCI: Add quirk to clear MSI-X
Date:   Mon, 6 Mar 2023 12:53:40 +0530
Message-ID: <20230306072340.172306-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT033:EE_|MW3PR12MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 4639b9da-63b3-4566-6189-08db1e13d6f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WMIhOoQkzLWF4G0YDe2AOpQqw9M9rc49oF4XSIDRwiB0Q/mUB6Umehh3YczOe1uzHTTvWh4+Gpr2OKWc9Di+kXxOlT1iMadZBka/eFEqsXFI7EEqu55TG8xXG+ceHtByczrwhCT1r4pYRyBoV5ccBAd3HhE5H8CWK+v5XW0c1QHHlQFyuaSu6safiXZEf4FnJWDT2Ut0GEtEGImFYwshto5qsw6LDR2h7DQ9noSdZZimTa9Lro6kR1/pBVTSeE/LXMAQdgqYy4cqnURUOzf9M7hyeaHNAvVnk2rTbIshEKbMmaxJDurp9TugoE5KiOujMkZJdPxE/RIZeU6SfpJ6Ihgwtiqg28OPjtjkY1K22OA4fWVgQp6O6iPlJa/x+M7DAxqSHJbnzY0VjxIUm5KDf2UCOULg/1LTXC9nAv9rudLxKBWQB7mqWN2kCVYwEuiOcEclfVhDxpFrNUxkUOU/zuPXGWssbYipVZWAm7uVsYfHGvrOgBjKZ73xAcjvwumExzDbbp1Npfw2WcPDnk0omSm18JgRgzjIj8rJp7Rj7m/ZAE3DuiCvU1f9RpDuYWKRsKs5f45Lpyd2mHwiLfPWm7GnOsLzgMd29MCj5gsRT7M57NyOYcCjeCieE5cb1JKpS6Cur0fmAT2/blcHGY8hGcH2t3oxzF/I4MPi8SuoUctsIN73SLiPKX1mmPqF+EHWu2PPNeNhiNwjZRK+p40NKPZrlDbie6fWE5liUbX8/Uw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199018)(40470700004)(46966006)(36840700001)(478600001)(36860700001)(47076005)(83380400001)(426003)(7696005)(82310400005)(6666004)(36756003)(316002)(356005)(110136005)(82740400003)(54906003)(2616005)(336012)(1076003)(16526019)(26005)(40460700003)(966005)(186003)(86362001)(81166007)(5660300002)(41300700001)(40480700001)(8936002)(2906002)(70206006)(70586007)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2023 07:24:36.2089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4639b9da-63b3-4566-6189-08db1e13d6f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

One of the AMD USB controllers fails to maintain internal functional
context when transitioning from D3 to D0, desynchronizing MSI-X bits.
As a result, add a quirk to this controller to clear the MSI-X bits
on suspend.

Note: This quirk works in all scenarios, regardless of whether the
integrated GPU is disabled in the BIOS.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Reported-by: Thomas Glanzmann <thomas@glanzmann.de>
Link: https://lore.kernel.org/linux-usb/Y%2Fz9GdHjPyF2rNG3@glanzmann.de/T/#u
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/pci/quirks.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..ddf7100227d3 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6023,3 +6023,13 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+static void quirk_clear_msix(struct pci_dev *dev)
+{
+	u16 ctrl;
+
+	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
+	ctrl &= ~(PCI_MSIX_FLAGS_MASKALL | PCI_MSIX_FLAGS_ENABLE);
+	pci_write_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, ctrl);
+}
+DECLARE_PCI_FIXUP_SUSPEND(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_msix);
-- 
2.25.1

