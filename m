Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EDA4AB47F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Feb 2022 07:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243967AbiBGGPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Feb 2022 01:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbiBGENF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 6 Feb 2022 23:13:05 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2071.outbound.protection.outlook.com [40.107.96.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8BDC061A73;
        Sun,  6 Feb 2022 20:13:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgwbHjUWImcF4xdTHv+K5ZrCkP4zZFPWxYYIK79wTRQXTCpHigIHW249bioDQ8csI58lyjSt0Y7QZ2AxnLnjQAPSRtAjhVl4krp2tZb/dqQrjOGsFn8REB7tX2Al/1haHAjWfiDuKxF2pxFS+1RPvGmO9AeeX7bhd6UtwrKHOFTdQAaozIwMWxc+Fcx/IQxmVdYLOdXzWWE7qAgoKE2oksVzwBo/6BK0RN2k2zUeEAUQ5GosJoJJyry3901hqffNbIybnqgjpQXE3tmrkgsyRUgRi+H7lMLCvZlrt0qhayMOWdE3ch5NVNQJBEb9EAFCNgJeBEqvZkSh87Lhu3I5+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Svqj+OXpJNEBSKlWzrxDj/rz1V7xMHE3HSuZeNhhZmY=;
 b=eN4TUsc4/oJLMSfMHmsL5VjZkZWWMm1PFo37XfojEgheByNI4gwI1srgS5hINJQ38HNwz3qn8xkEjVJliX538u2vOigKWyqrWwCo0Pf7OWiry7eHz8ixjMH/9fMpDgbZll7ASufPj03cchHgteBI0IcdnP+woLKz9wQH2Q/I2LdODF39viNo99SxMRgnvOfaDn2TARMiy5SLu1DEl432R1MFfhJnlHRzEhRcZmHjqrLUr6/974kSS+87QpnUq00qq0SD+mtmWkAlZloI3Po1ayMl7JxUD6yWnz3C9nJpZm/+6P2luA/pW0gIkAltrhX5MGXegIePUxb1avzkJ+Mm3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Svqj+OXpJNEBSKlWzrxDj/rz1V7xMHE3HSuZeNhhZmY=;
 b=IYAFsrfl96iM1lA6wWE2yeolYmUhF8gg1rFKdwcCIGaIE9auPdB2TwaCznYFcR2/3bcbQ6Fh4LZ1TYGlBeMvs5qKQD7XRIa2qeJbxlhfcWkcHfSxYwvPX9RyItlPsYiIanVrYi56nuIjemQwjmC+seN4opW6xFmGfQupvC4D5Hg=
Received: from DM5PR15CA0037.namprd15.prod.outlook.com (2603:10b6:4:4b::23) by
 DM8PR02MB8038.namprd02.prod.outlook.com (2603:10b6:8:17::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.16; Mon, 7 Feb 2022 04:12:59 +0000
Received: from DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::9f) by DM5PR15CA0037.outlook.office365.com
 (2603:10b6:4:4b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18 via Frontend
 Transport; Mon, 7 Feb 2022 04:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT009.mail.protection.outlook.com (10.13.5.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Mon, 7 Feb 2022 04:12:59 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 6 Feb 2022 20:12:56 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 6 Feb 2022 20:12:56 -0800
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 lorenzo.pieralisi@arm.com,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=45184 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1nGvOa-0005Nx-8o; Sun, 06 Feb 2022 20:12:56 -0800
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Mon, 7 Feb 2022 09:42:47 +0530
Message-ID: <20220207041250.1658-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c7c8e85-57fd-4f99-5e7c-08d9e9f0204f
X-MS-TrafficTypeDiagnostic: DM8PR02MB8038:EE_
X-Microsoft-Antispam-PRVS: <DM8PR02MB8038B294E4E5960C0236E7FDA52C9@DM8PR02MB8038.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a21zLgB11vje+a0GfVoaFfXx5yc6OslZpwjVv1vioJOGAFT6o+SlMuXnHJDoOWNlKJTviAinrH+xt5OGhfly4RDt3ajqtRm4OGgzOD5BO2AYDTXgh5T4C2pOL3Xc0YfIw+tJjc26KKoSN/HtF0JbYSfqY7f+Wwwt1BvOktxIgoQRKxDx84hNDiT1l1fQ1RrMf7+DbTq7GUYfyNegwU5tyY3y93dQ3LJUqOiSVUqRh4h/HskmIRz1UngjmMnL8gzuSW7T4PXjfJWluyDW7qa+k3O/5p2UR7ENX4ob6gvsFcDid7HdXp/T+a19cW8NrZyNhOR/Wo30tIKuraD0WOf4sNpAErTcJJqudzAc/6fMyl0RQ61OU3CvD+mq48ohRubo/HkNK3fxEad4qrhUJRife6zW0GIOepUTl6GzYYf0h3SY1gWvmaj76ZA+JBQsFzJKu3GofHouBKNRpzmEutdMBqKBb7ZlfV7H5dIy7a0n1+8Ue2B8pyCYrVEcVk6pv4CsZ2ebs15C+VjouLKnxTkX6CfvCDMoEZQJA6YXmT45L9r1UIew7E9jK7dtHDX9DB1kCUSTfiY6+Ae5dU0SCenHUOzwWmACj6NWSZYZcISuqnqWycwS1G75wQJiIjK3PDqPCcnhD+m/YS3YJfZ6y/bCd93dJjrQkgYMaUquCcKMrMLt0UuBI/HUNsnm/WV72hMZfrblQJDmee7Y6nUf+PUWRc5uVW7jbIs+Ko6csmhQqWY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(5660300002)(356005)(36860700001)(4744005)(110136005)(7696005)(6666004)(82310400004)(54906003)(316002)(2906002)(186003)(336012)(426003)(70586007)(70206006)(7636003)(83380400001)(4326008)(8936002)(2616005)(9786002)(107886003)(1076003)(26005)(103116003)(8676002)(508600001)(47076005)(36756003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 04:12:59.2193
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c7c8e85-57fd-4f99-5e7c-08d9e9f0204f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8038
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Xilinx Versal Premium series has CPM5 block which supports Root port
functioning at Gen5 speed.
Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additonal register bit
  to enable and handle legacy interrupts.

Bharat Kumar Gogada (2):
  PCI: xilinx-cpm: Update YAML schemas for Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port driver

 .../bindings/pci/xilinx-versal-cpm.yaml       | 47 ++++++++++++++++---
 drivers/pci/controller/pcie-xilinx-cpm.c      | 33 ++++++++++++-
 2 files changed, 72 insertions(+), 8 deletions(-)

-- 
2.17.1

