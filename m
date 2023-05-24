Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBD370FE39
	for <lists+linux-pci@lfdr.de>; Wed, 24 May 2023 21:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjEXTHx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 May 2023 15:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjEXTHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 May 2023 15:07:51 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFADB12B;
        Wed, 24 May 2023 12:07:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JqQPSSvo9axDlZOfc+5rUGx5S27Mx1sxVhGVlLkVJHjFLQBco+GZJ6a8gzyHUCvm9Sao/CDOnnVi5tG0HYPp9GTVqGrmheXqgwkF2FuvFXe2VQ6Qg5XNhA4ay95G7pZdeDSLpVpRYFbdVAepJamFhoKkvg60Ptry8efer0Msdw9Mq/q6AAnB5oSLZRICqBQFPRXRpgsmNlo/8laTl9MWW1/ARj3uxDQL/nXylf5UERn7He94tw6b/CNQhRl9FrJRubfrdRrCrchZwBAHE2Vsn09oIIX1flGkkKAAGhb72269wdp+niDWEEkU/UgrA71GfVZIgLsZmBZhd+synth9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN5XhjMdwL/hTBA3wvpOgjLrhkNRBDaNwSHLJzJuxog=;
 b=i03d965G5g0eeVHogn5GPwSBIQ3T/2irQWAn6BE5ORDUIU8pwl8kg8ol8Htoc1zSf35Z6FfBd7f+h1TFsG6+QcOvQniUHQKMS11EUXM/lrxIqmSaaY5q1dSiqYMSy9+JTfw1Uz8C0ShMPbu0cMAhh2ezBQ8Lw4mYR7WCUq9j8XN/hm+KXHjyQLH77ysYev8GLnZVrjQbIJBZ2pSQ/VUAuidW+ZE0BRMvE1SjQD3hUQ39UeaSvZ0rSdEk46UKp+WzeKdf7f6vIICp7fZYYUICJZ+12sltMGAf96Mjswk/QDD47JB1ngBSoCuAAkUGZN0Y8NimbQfM0FuLb94YAMZEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN5XhjMdwL/hTBA3wvpOgjLrhkNRBDaNwSHLJzJuxog=;
 b=jGKFW75gOI064+EGE0LOM7vRNYhCoeBrawHVnZhOr/5ZcUPTlX6SXyM7tUyLU9GyHwPxJq+TtUbO1uJC0K5/ZtbYQKx8CV4hWnLiw7/Zb/7sPx+6iCD873BSgoQSz8y6b8w7W9PwTlUD0BjLRIfbRI2S4voCt0GmeD4z/Xm32wQ=
Received: from MW3PR06CA0022.namprd06.prod.outlook.com (2603:10b6:303:2a::27)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 19:07:48 +0000
Received: from CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::3f) by MW3PR06CA0022.outlook.office365.com
 (2603:10b6:303:2a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Wed, 24 May 2023 19:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT084.mail.protection.outlook.com (10.13.174.194) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.30 via Frontend Transport; Wed, 24 May 2023 19:07:47 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 24 May
 2023 14:07:45 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "S-k Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        <linux-pm@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Iain Lane <iain@orangesquash.org.uk>
Subject: [PATCH v4 2/2] PCI: Don't assume root ports from > 2015 are power manageable
Date:   Wed, 24 May 2023 14:07:26 -0500
Message-ID: <20230524190726.17012-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524190726.17012-1-mario.limonciello@amd.com>
References: <20230524190726.17012-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT084:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 20423d81-28f9-4195-7352-08db5c8a29d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GLgEezDeCwTykxH7CHCamNY/gPbMVzMQu73M8FTT3Ic+xi3mJZSU5ZwfQuUf+ub7UMDNtBbK45WBxZ01g63ylh2zMxAoVxFl6bIY4NKfXTqhHbypvShNSHTzf17tLtv53rMMnYQbcF2KgFsg4B9Q6h9cvh7+x/L/XuduEwM2C+NhvwIn4imj9J8m5QVNqvNbj+dXPHnrM2eWM1nNFiM6/zwhIQvWFFBPXiKEqq3EqVvPUD/l1n55y5hqFZYyqcEDPvpy0dJQmr/TALlO+HSfY2h7ojcl0Yz1DOYQZT89qQZwmD//eMZfNqU15Il3J4XnAfOieXo95KoIhju7cpTdPTKgpBcyPhS1I/b9vJUjx90mG3z40LbCkJ210EHP5JU39KEU5MyOwCrloKUiEOxuYSp1ZKv2roTvkiLRmZX77G0b9TDqTKxu4tmXUugCTrH5YtXGf0s6NgZrrpDLXpVVgV6fTanbUscj89aOvgVg3QxaYaaW2Lct2vS+yS4MZKs7KOm+qEUrBS56wKaKVqSwsG4h5nLyXXqyIunTs8nSz0skT16Gq5Ql2v1qzFuOoqJDvqiurMv/yDmPAoK5D75Lp9v3VaWFgkn4iIS3ZCJTC2+pkA8ACpEMbgd4r+xhRYnEkQSJSPDICYXMxgcTdgq6Kh2MX8hz3sFCSirZEBLftX4xNoVVhGKKaN5eQ126ntxgg6acDG3OMyN0mk91pdFi1o4K7EYr0W8R6tj3/ZZuVarbUu1pYzdpGugwZEIL4L4nOFHSkJUDWMH6avWdr4QHFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(5660300002)(8676002)(8936002)(16526019)(186003)(2906002)(36860700001)(86362001)(2616005)(36756003)(336012)(426003)(83380400001)(66574015)(47076005)(44832011)(82740400003)(356005)(40480700001)(26005)(1076003)(82310400005)(316002)(70586007)(70206006)(4326008)(6666004)(110136005)(54906003)(478600001)(81166007)(7696005)(966005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 19:07:47.8944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20423d81-28f9-4195-7352-08db5c8a29d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using a USB keyboard or mouse to wakeup the system from s2idle fails when
that XHCI device is connected to a USB-C port for an AMD USB4 router.

Due to commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
all PCIe ports go into D3 during s2idle.

When specific root ports are put into D3 over s2idle on some AMD platforms
it is not possible for the platform to properly identify wakeup sources.
This happens whether the root port goes into D3hot or D3cold.

Comparing registers between Linux and Windows 11 this behavior to put
these specific root ports into D3 at suspend is unique to Linux. On an
affected system Windows does not put those specific root ports into D3
over Modern Standby.

Windows doesn't put the root ports into D3 because root ports are not
power manageable.

Linux shouldn't assume root ports support D3 just because they're on a
machine newer than 2015, the ports should also be deemed power manageable.
Add an extra check explicitly for root ports to ensure D3 isn't selected
for these ports.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Reported-by: Iain Lane <iain@orangesquash.org.uk>
Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v3->v4:
 * Move after refactor
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d1fa040bcea7..d293db963327 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3015,6 +3015,14 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	if (dmi_check_system(bridge_d3_blacklist))
 		return false;
 
+	/*
+	 * It's not safe to put root ports that don't support power
+	 * management into D3.
+	 */
+	if (pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT &&
+	    !platform_pci_power_manageable(bridge))
+		return false;
+
 	/*
 	 * It should be safe to put PCIe ports from 2015 or newer
 	 * to D3.
-- 
2.34.1

