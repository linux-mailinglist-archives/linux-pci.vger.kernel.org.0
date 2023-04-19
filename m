Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F886E723A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 06:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjDSEUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 00:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjDSEUl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 00:20:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731DE7A80;
        Tue, 18 Apr 2023 21:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TUlT2D6rV0PtgpgoqQSQ1fa1FgHzVHKtrhtBpeawpbOId85nS6ZZa6Jag/14U9thdPFYMJn5LPoxd+92JVGpMEmZ2lKxXwt65gR0kXHsl3GkYDmuW+rFVBPV9JNUOD2UWUP4pDO+bkmWGt6obP/4DOyLoSzEGh/oR7wBmde4WypRYun9jmJANv4PL4903mW3zquuFZM7mewQtmrwy451BGwqp3LzdqgGsfS4CthvgVUAjYNdeOcC20cMnhlnLgn6V9e9Jx888PejulARM+IPV6C2zdfu64kbVrfFtzvsQbN3vQb5XfB/th1IyA9Lx3wUVYM+RkETmOC2nTZksaTRwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EUXj2ElTOnvAcy08m0ea9S1QZpa/0OKybIYvDr0np8s=;
 b=KaoF/cHM3pgFbR/h+ReCuVDKsYU4c7GLPNB2gxMX9I8owMAQ5hR+chf2W4uTF15fvpzjJrp8EHkBDVRxXRbHYkViiRQ48v8A5d+OE5aX/L8/Mx6X6yydSPzXzbcbw2doQB5tHZzo/uzJwb6tQbIvxU4DCkkXzf+GRB+q3TDYHr2RmYF+eCqQQk8Me9Vm0Yhj0vdmQRDDzfGQFwzLrgzTHz4Ab44bWxDVbkQCm2S+jlE3dwAn8KF4Wm0dixoU0biLv1pjK9szoZu6xoH+h/aPEtCqAFWsjRDq+8i97yeagNi2SMBDrGX3IdtgrogRyAyGC1lLfJV/yYsblm+wv9cR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EUXj2ElTOnvAcy08m0ea9S1QZpa/0OKybIYvDr0np8s=;
 b=QxwlF3+y8Lt4yRv32MK/anFTHSbAN/RjUPrllPQZOJp8SVcvNWte2jeVkYIfzHxXsJ6vN4iBYTIOiRZ0da9er+0Ih6CqzinnhrsrfIyqInpSWeOvV2NXWzME8ad6IAPvh4rqsr9IyxV0JMu3HwjarrB9TeYtlQx9FRmlhvfQg8w=
Received: from MW4PR04CA0213.namprd04.prod.outlook.com (2603:10b6:303:87::8)
 by SN7PR12MB8602.namprd12.prod.outlook.com (2603:10b6:806:26d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 04:20:34 +0000
Received: from CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::87) by MW4PR04CA0213.outlook.office365.com
 (2603:10b6:303:87::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Wed, 19 Apr 2023 04:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT095.mail.protection.outlook.com (10.13.174.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 04:20:34 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 23:20:30 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 18 Apr 2023 23:20:29 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V8 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Tue, 18 Apr 2023 21:19:54 -0700
Message-ID: <1681877994-16487-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681877994-16487-1-git-send-email-lizhi.hou@amd.com>
References: <1681877994-16487-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT095:EE_|SN7PR12MB8602:EE_
X-MS-Office365-Filtering-Correlation-Id: 440221b8-7dc0-4867-415e-08db408d6bd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k/1jsKVWSZQ1Otr15Caw8JsPUEc+BPwi+o6pb+54UT+Kh/I5gR9RjEIUAOjtUOQ2GlvYyot32d/AsQoLPrC5zZ2liuZKYdBCU6fPNwdOH10GA1kN2fgA+Wprafx14XVldOa1SBPjG1WYWJ4z4Xy1FeBH/T8A0OQF6FuRHUaYlrr0VWv+iocfk++KewGAnWlWLlCBSFAyo97pJv0EuWDqwKt5uraHuUmd7rlk/jdgp8hA/KOlbsjHV75VrMPVZ2KbGAhBzlu0gosVUnS7kQZAtEjNc0VA8k5ACU63x7ImyB1/1sQaLsVyO5HWeRgXzt4/hVISEx/QX191DSRNNMhNid9FNHBYiuiiIU65c3yzu2xah1LeXcAkYXrDN3D8RqAGRU/70xT4YFPTbYz1MqUX57EIKRPBwqKmQuNSojqYkA8QvdxBHBhWkPgoiyUxapk5eX00b8pyoesagWE8rFRqw9rutR38YQu0IFbCkZ/3iiiCwmzVtJDsfZXWNObTBKSo15whnr6PdEjBKQmykFfTKTumg4oMS/92x4f1oioGdNK7t09tWEZ4MaHcC/CjbySzn416Asph/uvk1f925/6EWIy4PEHhI78A14hgVhlHaxcz65Wl+7d1EUJHdsdGE6L5za9iKfgv8rkgXnhTxLXR796ZxyypxrKwjnjgXlJAF6UP4HGHMBCLIN3tbh22JYi9/Xb2gn+Mq4pmbBj5ug/mKGkCshKfSQXnx8TFDyA9nOs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(8936002)(36756003)(8676002)(40460700003)(44832011)(2906002)(82310400005)(86362001)(5660300002)(70206006)(40480700001)(478600001)(6666004)(54906003)(110136005)(186003)(2616005)(36860700001)(70586007)(26005)(316002)(356005)(82740400003)(81166007)(47076005)(41300700001)(4326008)(426003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 04:20:34.5420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440221b8-7dc0-4867-415e-08db408d6bd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8602
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
its PCI BAR. The card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. This allows U50 driver to
load the flattened device tree and generate the device tree node for
hardware peripherals underneath.

To generate device tree node for U50 card, added PCI quirks to call
of_pci_make_dev_node() for U50.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 44cab813bf95..35745e7b457a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6023,3 +6023,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+/*
+ * For PCI device which have multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
-- 
2.34.1

