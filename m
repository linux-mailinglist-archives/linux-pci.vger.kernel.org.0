Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13ED5720234
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjFBMhr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 08:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234769AbjFBMhi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 08:37:38 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC93913D;
        Fri,  2 Jun 2023 05:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8gCmxCP5gi3sKimzXdOeKQhHbF8ZK2+XlraAYa28h1lTVqoeWTP/T0VNFKRwx45QSkFmBfWF8v+0rmJC2MwCEaCsH8WCcZDk8jS8LQG8eB2ebwFSeYgjr9NTyXmnEwlSKJytE4/ipGZJP/E6G3CRnhEZItyE0IxUdKbS+uw4I4x0Qst27cQ2/xdQDCKNdSO4FFTQZBx+aJLvdHgVZG3dmMVERNtsELNgOmJJENfT3Lu4j3SkUIhBVtqDOveaHmx2PVAzqpzNpjof4e+XzgON1A3BZrHIU4cxpMypo30Sd95rT1EYKAHR8d6wEaeSqbu/fNFTGBNAsEWgi5ntJ8YAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/eZbnDVbXzjBr2zEuM/T2tm7tpG4IDORP5Lxfj6QEk=;
 b=ic8uJ0P0vCA+++WU3YLe6X3ETX3/WgQzxLbFaCQnuxpgffHYo3w8Ox6Nb+7oNJSg8np2UarQ9P+qVU3OkV+2t7ocjb01+ZSZOm34dgeZiViWOJUnh65Ev64wtsBqvluG73jKDCZIpq50/mVxHDpBEDlEQlkK0AgmAPliib+zVe1XYIrP+6wk4AL2NHmStXWl1cSkC6TikcVbizgMT2+iE8JxPcLwbiP5E9VxDi6peAmgySZc+q+PhUSbCmN7BN9ruW0NKOb2SBZDY0Bj1smqRnG0P8ismYwKToNt0+8iKxClJWYbK6/8k1h0UW95ZdlKm/7U9Hs7O1zwYprUBRxs9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/eZbnDVbXzjBr2zEuM/T2tm7tpG4IDORP5Lxfj6QEk=;
 b=dPSrrH9YO9ZBpUrZzSJlxQkxwX/2jYOIEkKRVvPtzj1dEcgLbVz5vJANCORHogBwsdmx2HmbbCkqlfz3yJg6CiHitN5CaTd70sOApOvlDIuDvlyob/Jb67yPpekfM+ShFSwYoq8U9f/suF879zkaVUklOFRb5VeBDYKwLRNVW2M=
Received: from SJ0PR05CA0008.namprd05.prod.outlook.com (2603:10b6:a03:33b::13)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 12:37:32 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33b:cafe::f9) by SJ0PR05CA0008.outlook.office365.com
 (2603:10b6:a03:33b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Fri, 2 Jun 2023 12:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.27 via Frontend Transport; Fri, 2 Jun 2023 12:37:31 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Jun
 2023 07:37:30 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] PCI: Call _REG when saving/restoring PCI state
Date:   Thu, 1 Jun 2023 22:11:22 -0500
Message-ID: <20230602031122.18350-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT051:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: ec80ad4a-dfb2-4a38-eb87-08db6366224d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eko2wRYexRCNNxDvxLOJpAuQ7vKh4LnuXOi/ncOJcJXECNCXziIfK6KwDnDMPOEaXOC8IXA/k4eOmDR+nr0zG4XrSwqkh7k4XFoKvAOSykeEer2z7t5j3JjTR7KaULAcoeny4G3qnYh/PdrvtXpXeVhB50BWpyjCNVxWQDroXMmE+1vYHD/igi2Zqo3J5ns23GNtibOZctbm23940BlpAyP8vMMbds+7/G/I1sHEMZsDtAPnBmzf7YMI9ToC3so/zYfaDNY+LebGdtBD05wod9s8vt7zllmB733AK7Cp4ixV1MfkOiqzM+hb6Lqc22R6EAF/Y3iJiJvCui5rMBntmSeSf7GNnzJVZiXGOYKgtpSSXkchIIZXdwiazdKtAm6Xfo8s0QuO2Qcry682Hvqd9CkSnk3kyV2JF90yCSNkwlJtSIF7OY2gLIjXe0AqPDN10VG4ZzyGQJDPwIu/54i1n4w7knUuTVEwnT1QVQRzrV1xuuP6sMI4HhRnrxTlg8OTTYxLkSrygxD2Slf9cgBmXW5IBudPlqHARbu7ya8ImsgN/BfGg4FPkOJCwZHjllag8yHiwW/Kd3jNVw4l0uQk4tENxoKshRD6VmrbNFSuDkkz7s+6xjG7bNHb35DzD2BMN9AI7JIf5i86cBChX/A1DNT9Dvzx1lTiFUXrWvUwdJM9IFCyzPtcV0UpHa4X2HptTGUN1QbfG3ycoo+IoWzjw2v8aq7af/Z5Y+K57b0iTBIbNV3HDuwjg+SGy2LqK+7vPJo1O+UdP1nEkXqn6H1Xk9CidgLiyFe00pUHxftblwY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(82310400005)(356005)(81166007)(40460700003)(40480700001)(86362001)(70206006)(54906003)(6916009)(70586007)(4326008)(36756003)(7696005)(6666004)(966005)(478600001)(16526019)(1076003)(186003)(26005)(5660300002)(8936002)(2906002)(8676002)(316002)(44832011)(2616005)(47076005)(36860700001)(336012)(426003)(41300700001)(83380400001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 12:37:31.4840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec80ad4a-dfb2-4a38-eb87-08db6366224d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ASMedia PCIe GPIO controllers connected to AMD SOC fail functional tests
after returning from s2idle. This is because the BIOS checks whether the
OSPM has called the _REG method to determine whether it can interact with
the OperationRegion assigned to the device.

To fix this issue, call acpi_evaluate_reg() when saving and restoring the
state of PCI devices.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/06_Device_Configuration/Device_Configuration.html#reg-region
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e38c2f6eebd4..071ecba548b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1068,6 +1068,12 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return acpi_pci_bridge_d3(dev);
 }
 
+static inline int platform_toggle_reg(struct pci_dev *dev, int c)
+{
+	return acpi_evaluate_reg(ACPI_HANDLE(&dev->dev),
+				 ACPI_ADR_SPACE_PCI_CONFIG, c);
+}
+
 /**
  * pci_update_current_state - Read power state of given device and cache it
  * @dev: PCI device to handle.
@@ -1645,6 +1651,9 @@ static void pci_restore_ltr_state(struct pci_dev *dev)
 int pci_save_state(struct pci_dev *dev)
 {
 	int i;
+
+	platform_toggle_reg(dev, ACPI_REG_DISCONNECT);
+
 	/* XXX: 100% dword access ok here? */
 	for (i = 0; i < 16; i++) {
 		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
@@ -1790,6 +1799,8 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_enable_acs(dev);
 	pci_restore_iov_state(dev);
 
+	platform_toggle_reg(dev, ACPI_REG_CONNECT);
+
 	dev->state_saved = false;
 }
 EXPORT_SYMBOL(pci_restore_state);
@@ -3203,6 +3214,7 @@ void pci_pm_init(struct pci_dev *dev)
 	pci_read_config_word(dev, PCI_STATUS, &status);
 	if (status & PCI_STATUS_IMM_READY)
 		dev->imm_ready = 1;
+	platform_toggle_reg(dev, ACPI_REG_CONNECT);
 }
 
 static unsigned long pci_ea_flags(struct pci_dev *dev, u8 prop)
-- 
2.34.1

