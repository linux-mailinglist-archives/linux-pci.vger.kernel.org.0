Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CCE6664DF
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jan 2023 21:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjAKUbh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Jan 2023 15:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjAKUbg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Jan 2023 15:31:36 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6169E2AC2;
        Wed, 11 Jan 2023 12:31:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je1L2GwZi78LbxOivJG8ikF07l+JMva0/M9wrOQJG/DPA8j/Y+vEQTGpK+5xloNq56R6FYPuc7lcN5ZRBtP2tnLP3lE29meUYzh0TdMJU7AcASik6SUVcPgI7erQGR92wCCk1k6SDKXGQQ0V0bJdzmZuRAeB2630DV2Im9Q3TbgcmfO/e7m7S6IVSRtsa/ESabDiufqrwMHqdwlNq0Mw5E5VX7ecHON6w8itfyYZCkJV4x/FLIBsfPmlwGTPjl1Jwe1AAAkx820THmRxU6AvaAWXJVDa/nJ3MaNAx1kpa0Vprcy1x/HmYgESdGUxDg8DXLlGYVvjFtdFBlojRYehrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VJfTbG/Qv88ipqQH0Jw+ZamckaKF6FdA2RU/JpQhjv4=;
 b=Yto4ky3rJeEmNUFiwHMe/bFYCeTyG/NDyRIFC7InJ8gYin21XRQWgqG9sVUtkDNWVMQz+krFwarPdWVIAeQWN83VSO7Y1Fsvf933GiXr4yTqnENBJtr1fS4OmLLO9m+hlWjXigf1JBIKcqK7m8wdCTnCQVkQ95nx/SYtokSEy1mmQWJHMB61Grc3rc97SVs6+gfzllSb5PjVQBphX8hxsPR1B3VBbdcWcH+cXycGGKdzoTMEwlm6LCbO/UH9avOig+k/G/oljlCfjxyo8LgjCVpB8mByupZztaGUmyFnuhSbDrOGe0EKl1hajKyjIMVD2ltLEeuAoDJbYQB8zhmU2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VJfTbG/Qv88ipqQH0Jw+ZamckaKF6FdA2RU/JpQhjv4=;
 b=GhcvYnTCDRUOXDR78HFk6QTXYkAi9slDiYJR8MpxAkx/4VU+x6oyrOFRb94k4MRlgonW5+g/xJcFXF/oBin5qSHzKJAuJ9Bgh7oghCi4CG8KKVQ4ZJFc+eF1gZcBkPjTfSTQuC0qt7vh1UXW7oknwtgL7rLjcsZoLn2wUzOhuamzpiNrqGFXU0yA+uNec4yK+WvbfrhOkBED6dSG1c0hN/tZ+mV9G0qR2oz9x0R7cbJXaIGylP0YySOLSz2Gqo2dSkdDBPHy74VPfLsnfrtiiEQWA1N/XkVZSAPCrag0xTMJAcDdAl/bmG+yUSO64QkWio2z3qAk5EqwYiXhh/e39g==
Received: from BN0PR07CA0030.namprd07.prod.outlook.com (2603:10b6:408:141::13)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 20:31:32 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::5f) by BN0PR07CA0030.outlook.office365.com
 (2603:10b6:408:141::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13 via Frontend
 Transport; Wed, 11 Jan 2023 20:31:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Wed, 11 Jan 2023 20:31:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 12:31:22 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 11 Jan
 2023 12:31:22 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Wed, 11 Jan 2023 12:31:18 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <ruscur@russell.cc>, <oohall@gmail.com>,
        <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <vsethi@nvidia.com>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1] PCI/AER: Configure ECRC only AER is native
Date:   Thu, 12 Jan 2023 02:01:16 +0530
Message-ID: <20230111203116.4896-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT025:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c7be6e6-03a2-417a-684d-08daf412d3e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ui3JpQf3jPfI+bEj5ddrbHZoCUkNA+0ZjhmAO6vkGbUmCCSkjN8t99Q+5SlEyTCFonsNrvs45ZVnjYc14Q4PunKMlP7IWMSmt3ghKmOlMh3Vr+GgLSyywxtMGKnaeO+gYWNr9+4NVBU3oIhutzncu87kUQP+8WUbAh9hFppJKadO0BhR8k7unc1mdPEtaPsDQNxYLg7aEUrVp/6xOjk6YDuShsmGAC1ZvIFhgLmF9YlRoelbNGxxlhC8EWwOie6wjeN+2pGsHNtG06cKeD47pXMZtVEueKUP3fJLFFZe8b2Ws+bPrgTrz4uWH29VB+uW0yepWZ/UWHdYGi1R8VnFL6TZk1P2uhn+3nbHmw13Q5SXnxA+JkDn1vnKNMIcDqV6fGgSlSWtUz/BShFbOqVO2Oaj6Qq7rJTWISxavMWWkwqPP/M3DbgFAllgIvw4CNT0fh5NiKkwaQvCpre9tEMFI931ABRDopSArOahTXxN42w6ocbYU6bpDDMJ0ROqOEjziBYnUMpkZP8sghkV7Xw2a8AQ5XpXOQ3kpc2OyosuSxGTN7MfBXS8judggBHQmqlyussS8HB38giJnFweNr8KiJiw1fZXjmniIcm//kmGDh0aEzv2e4VQrVdrLlHO4glBbJkvJlfgY4XwU9kIUvAFgabdk+dliydgCtdQGGrUTF0dkydMr0z0jW7tCZjjA69U3PLFcEd0H4R8POfJvQRM2A==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36756003)(7696005)(40480700001)(54906003)(316002)(86362001)(110136005)(6636002)(8676002)(2906002)(478600001)(70586007)(41300700001)(70206006)(4326008)(8936002)(82740400003)(356005)(5660300002)(40460700003)(4744005)(2616005)(36860700001)(1076003)(7636003)(186003)(336012)(26005)(47076005)(426003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 20:31:32.5865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7be6e6-03a2-417a-684d-08daf412d3e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the ECRC configuration bits are part of AER registers, configure
ECRC only if AER is natively owned by the kernel.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 drivers/pci/pcie/aer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index e2d8a74f83c3..730b47bdcdef 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -184,6 +184,9 @@ static int disable_ecrc_checking(struct pci_dev *dev)
  */
 void pcie_set_ecrc_checking(struct pci_dev *dev)
 {
+	if (!pcie_aer_is_native(dev))
+		return;
+
 	switch (ecrc_policy) {
 	case ECRC_POLICY_DEFAULT:
 		return;
-- 
2.17.1

