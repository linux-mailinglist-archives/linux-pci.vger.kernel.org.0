Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894A84D3D4F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Mar 2022 23:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiCIWuq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Mar 2022 17:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiCIWuq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Mar 2022 17:50:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9C1122206
        for <linux-pci@vger.kernel.org>; Wed,  9 Mar 2022 14:49:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XA01S0jCxXEf/kuJyGn+jlL+ElN4rpvh1HJMnotapeHRhJrXbqAQHhXXzZa4hHz0utvHvVbxfAOFqIz4Rez2zO4cktIuNiAYhQV4Db7x4NpFV+/d6jhvzQjA4zQEw5cQOsJFrMQWAOnkPqWYf2XmIachpz8F12GkPnoAlkZOXsKJvXtSt8Te0kBCPjnAQNPB3WruGFmYiNnYxUklgcoPA1FB8JukwYbjE2EGF0xygXsDQVBk1q496f8jmfKZT/s3TwT9oaz65H/MJOd81R1FkXBkPlWq43oh6Oz8uHR9/zzh5P4cn7fKv9Jz/z+X/hjQczoAq6zL/94OxUkHHAPHkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL3BZZJKAqgeA+DW4L45oBoHo9i7NIwfmbHA34okFmw=;
 b=g0lx4mXEe1/NBAXosrd/gUyk6L9rxRSu3RXRTfS8OxQXAoU4n4UyGhCxoS30ETpRP5eB1cdMi5HEuU6GzwiJfJtxAbi83plYC6vJiMGNfQlHFy6mD61D6JoU8G01zv0eQnB3iKD9JYf7PdoYQzuTG24hq0FI8o9CmQvymWQxBfftzXE5kAtiBFbTRjqRhkiKlFbufEGvXf6gN8SwLikcoymosPt1W5Sn4mORBXFOogFeC0GLjErf1HdeZMblBOB8O7odl8F7c5oiCmPmmblLQSUqUf53sM4SbeHWwTls/SoO4TNHlUuiEk1VKYijWIo5jcFy1SQzOyORMKitbGYnHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL3BZZJKAqgeA+DW4L45oBoHo9i7NIwfmbHA34okFmw=;
 b=5kZViWX/fUqvCJXYuEUphhuuG1IW4PPtoKPCuq/jkcmBUXGU9tHTJ5wcj1wVAzg9fUwelWp0v9EhPR/MxrWlczalx7AhL43kXawpfl+Rn1iJEBDqXBkSNqjeJnseA8ON1/y0KJs4k6juHDlf/u1WqYoalLftD5qCU9Ta7rLpG0Q=
Received: from BN6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:405:2::17)
 by DM5PR12MB1708.namprd12.prod.outlook.com (2603:10b6:3:10e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 22:49:43 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::c6) by BN6PR11CA0007.outlook.office365.com
 (2603:10b6:405:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 22:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 22:49:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 9 Mar
 2022 16:49:42 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] PCI: ACPI: Don't blindly trust `HotPlugSupportInD3`
Date:   Wed, 9 Mar 2022 16:43:02 -0600
Message-ID: <20220309224302.2625343-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ee26b9-db66-4954-7121-08da021f19c1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1708:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1708BA3D037D31F5FF2EB538E20A9@DM5PR12MB1708.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3zVbq17nVct3jf2SNDY5wjq6R0s1fZq1oWBXvNNf7c7/4EJXHQ1f6soJluRt91zvvsyOdVYsd++aEnhgr5V7EU/xLdkkvf7NYIvr11yA7dFzVW5ywq1koxCsJbD3d4KH+lvCJ8SbYfl7EvWfe2rG+8D/XDVptu47H1yEIcgyAAbfQGxZkBi7Bx6j0HslyHTrFg6nC/tuS/ezBzUApKbJ+XwtHxeQO7yaDs/nyOkjdkYcicVUcLBnAnxH0xEgxmCN2nNp0mJOaJKSbtIyeyxLnYw1UB2BQ6cJqWhLkEFsuBNXCEVsZbjP4eylAtiFAs++LURYXTE59IzuNG3WgFcZlnmdIjPAnfo7+38C8/KEu/AL2UuxT9z0PhYvZAoKLPtLFAczKfp6dvHCZvN3dxBD8j4iEKdgupJytPU04mIfdLgttxlm1HRNlh8iKLfN7RJBycp4ihmHGYgxBxUg8/UphT/+oDXywBAMAo/DRa6HMZ4Ks4QQluJFVi2+PqrBrhlWZwda+fBtahDne77SaWR/XnEkgdY2NBReh0MrXlyj3CIwNDiogIuDK13QyZAd/jHhqR+aGgamQX4zSof/FzjKCaO9mIeYHTjd2KMMmLSY8p03w4vyQ19kGAfClWhMmOtJWA2jxISMcCt3y7YtTyNOlc5nzwhduC4CujvmsS4UCiejsF5S4R3ZM/dnn2gZigXDN+aKSFSt1sMb7LXpOPBTrCAyFC18Z5TqfzgavbWaQuJ2bBawVrvGYLK0eUSXGjszoJs6Hj+6Bq1ttfOsoz84QYfatznxQDxEpFz4Yp97xjfwtugrTjBRySx8UrW6KzdupTQAErhhsxLEi99CmIAyrRtlLsbMiB1Ugu03PIfMOgI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(36840700001)(46966006)(40470700004)(356005)(81166007)(508600001)(8676002)(4326008)(2906002)(316002)(966005)(82310400004)(36756003)(47076005)(70586007)(5660300002)(86362001)(336012)(8936002)(40460700003)(54906003)(70206006)(6666004)(110136005)(1076003)(2616005)(16526019)(186003)(36860700001)(44832011)(426003)(26005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 22:49:42.5071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ee26b9-db66-4954-7121-08da021f19c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The `_DSD` `HotPlugSupportInD3` is supposed to indicate the ability for a
bridge to be able to wakeup from D3.

This however is static information in the ACPI table at BIOS compilation
time and on some platforms it's possible to configure the firmware at boot
up such that `_S0W` will not return "0" indicating the inability to wake
up the system from D3.

To fix these situations explicitly check that the ACPI device claims the
system can be awoken in `acpi_pci_bridge_d3`.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..9f8f55ed09d9 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -999,6 +999,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!adev)
 		return false;
 
+	if (!adev->wakeup.flags.valid)
+		return false;
+
 	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
 				   ACPI_TYPE_INTEGER, &obj) < 0)
 		return false;
-- 
2.34.1

