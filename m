Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA66B7C9E8A
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 07:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231135AbjJPFMS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 01:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjJPFMQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 01:12:16 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FD4E7;
        Sun, 15 Oct 2023 22:12:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJRnc/PjM6rjJ88/lwg2NjZGXraxOFdbGANpYEZkdBD45CJQk3AWoK4jzok4UEisR6ReJ4y5sx9QY3nxn+JrLI14XhItJsWl2EKQx+It3kN2REuSXE+W7tKGEJJd13GWG7BUT+jdTykukOnFiIxNUrChbgTC3fgoDlUBNFuX4T+e1XsYljpBYa/S4gCJ8vYY2YSt+gVbVwQde4pAZRZN1mIkZpif08sl5aWm5lylVUWFA1B9IY52jFOGqVJA7f7WTlt7LTJcBqY11hlDqe6Apd12cN0vKTqwrV6h7IEOeC96T7azaLGGgdHTE1ufg53n61uzcnXVCdvozP+v+/6Jfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBJZOK/3Sd/hkz9852w+GyNxaltQ9eMs0gDMLPobpgA=;
 b=Coqalt0WGyEIoZnn0mCsz2z2Kdh5hmtghoi2nG16CWlXslo/UWf6GKD/e3yL7I+xmdD3XBVZgYsjqUexNJXGk5ag9mkLMObgGwXDHCe+gl6mgkD6SBxM5TMH2Ke9vUK+N+kj7z0oneMQ8zJO+2rWs6Ilc0No31IzcUCvrQAQGfRqMwGCsxegG5VPWP/cUqyS/shZ/8ZgGJrKKE8yFJtxXvGiJ1eUFwR9JhTcOAPtcwkvr6VQdzC7B2KCKv3wG6DwK1gnZKzvdT35pLzv7yaMKSP047SUtdfUsXBSUYAEMv6QYM84TiEAWWNQNu/DZkv7drVHymkQX7XPEvnc2o16iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBJZOK/3Sd/hkz9852w+GyNxaltQ9eMs0gDMLPobpgA=;
 b=xiIEpa0Ut5AT/solBBZGZNlAz1LZbEoos7jT2XMt9ydIKoEWo33rz0lEHQfMmRFtUqonSCKOjUZg2dEbj3zIIoXOPsNU01pE3nvERbssBFXEorPWdJ9dmorrrp0z0e7hJzrLrKaNR69INZrWDjOgurdY7N3n5wtnn4ktkHYwL00=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.34; Mon, 16 Oct 2023 05:12:00 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:907:0:cafe::c4) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Mon, 16 Oct 2023 05:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 05:12:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 00:11:56 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sun, 15 Oct
 2023 22:11:46 -0700
Received: from xhdthippesw40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 00:11:43 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <colnor+dt@kernel.org>, <thippeswamy.havalige@amd.com>,
        <michal.simek@amd.com>, <bharat.kumar.gogada@amd.com>
Subject: [PATCH v5 RESEND 4/4] PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses
Date:   Mon, 16 Oct 2023 10:41:02 +0530
Message-ID: <20231016051102.1180432-5-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
References: <20231016051102.1180432-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH8PR12MB7160:EE_
X-MS-Office365-Filtering-Correlation-Id: d82b5e9c-eee9-4c55-b3fb-08dbce066d7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1Jk/Tm8D19N4nctEK5SVxIhhSL3+vOFsbHK1pUb0XwNkxmex3/ahdk67jc+EcUL2TlySXV4L6C57UwobNjtnw2KCQ3HY/DPdZapAtcAoLIjxcC15/jPurUMEf693zFQZAovUAzfpEnajdvgXLB+DdQCZDXPWuWHBeLylU7NWXKX2fls0AKy6VNmxqDUyutWmtOGdRWbnXuw5GHLvjvjhVFT1ufNs+xJjgGJLQq46ccjBT2MWCsL+bjD3VtfwPB/yV3dB0RpdSxi29fQ+OR4YxSIpN+ozcYK+p0wUNWWA9EnEOIRxe766155pAC1lXRGtsaEt1ThBeSyYoiSpTtIo95y4TFlMUhJJz/fqz9pn0A4W9HiiEdYdzJGnMN82TKhTtBGQzv2OcS1Wp5wxcdIRfIXaN+Az1FT2xLPYuD7fHb8LSJ9sUUkjbMa6pVv5d1LvUCaPRTENSGwDnjVQy7f3/F8IjduqoOxRefqm8JG6BrK4g32J8tzmW3gIK2Ol8xsQVRbZs4h9JmT4sf7Ii86T2MmpYXP626A7F6gmQd76C8bBU+lpFKeqek2solodYkADypXG73Jqj3vMldtlJh2MHnfOuEkTgHsCEDo3daRiSYnPoJ7p5ywRjH5EJnqhlyvdlddc1R3P1i3IPWIsJvkI36QCM0YhSsHcYLm/rUXa/KhU+f3MNkmlLBbfGt65fubA9gktbLqmUWDmIyadb2aNAPUG0roGkI4mdw8O9mUetQEi3+frxdhztbfGCJXR5G8vPSOLcK2bkygnJN2giSSiGAAMraTYuJ0p4zzZ6M/8z0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(47076005)(6666004)(83380400001)(36860700001)(336012)(426003)(26005)(82740400003)(40460700003)(40480700001)(7416002)(86362001)(4744005)(2906002)(4326008)(5660300002)(44832011)(8936002)(8676002)(70206006)(316002)(70586007)(110136005)(54906003)(41300700001)(36756003)(1076003)(81166007)(2616005)(356005)(478600001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 05:12:00.3418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d82b5e9c-eee9-4c55-b3fb-08dbce066d7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Our controller is expecting ECAM size to be programmed by software. By
programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
ECAM region which is used to detect 16 buses, so by updating
"NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
ECAM region to detect 256 buses.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
changes in v5:
None.
---
 drivers/pci/controller/pcie-xilinx-nwl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index 8fe0e8a325b0..e307aceba5c9 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -126,7 +126,7 @@
 #define E_ECAM_CR_ENABLE		BIT(0)
 #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
 #define E_ECAM_SIZE_SHIFT		16
-#define NWL_ECAM_MAX_SIZE		12
+#define NWL_ECAM_MAX_SIZE		16
 
 #define CFG_DMA_REG_BAR			GENMASK(2, 0)
 #define CFG_PCIE_CACHE			GENMASK(7, 0)
-- 
2.25.1

