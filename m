Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990E95668C0
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 12:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiGEK6C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 06:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbiGEK5X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 06:57:23 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D36112D;
        Tue,  5 Jul 2022 03:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThMChHhuameb3ru/wnPHCEapTrTUpVSQ/eae30c5mBlLX8xepwQ5jqAbyx0UEAt4famChTZ6JKYkxx5apyjyf1xjnDAfw6U9SgvHr3nEkQOHYCVubagqPScbmbEhZWht+OcQUSWCWlRc2wda026hwGs+tJjvn4RMFXgS3ErPIVMne7iA2PoV+h95ssZ5+ebI6fJ2rhGtidI3vDgUvXfgeizmlldQ+03bk0IKse/13rslufC58oUInsAC0W0BRAQnA6Kiuby5+1QY++n8oGCNR5pfgelv3qeMNalJDxRJrw8eJcx9edw4DnB/DA2YRN8F7HiQ94NSnAB0o1fdn4J7CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DcJT1zdPztMJBpkEQnEwVuH+IOGbYodo9ajlMLb+NGw=;
 b=b5Q/GTImsqb2KWm+rfvlSj7j2dL3E4YdwkL8FB1fgIfLZmD+leaydEd+E1cUd8hnTJlTdev0wrZptICK/QprX8sR/dt/vkwHFkQe4GC5sb1DzUyb6Wh0q0bvYRBYv2UgrNVPMaBKacw99lIZi9TQK4ToYocSmXmiFsipVapPd6/LdXanagB1rUqqN/ITVPRNz+65d+CWkAaTJiN89dUMJRKuhYTVQxWSPSFg9OszqpoeUtWT02nxHZuQte5xUffD/+gHvUMvOQ6c1TDKTS/rq84bB6DPPzOuT/lgfBqgPcD3088xCgtJL/3Kaeoerr6kEqnGLAAJ0ksqmm6OYRCE6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DcJT1zdPztMJBpkEQnEwVuH+IOGbYodo9ajlMLb+NGw=;
 b=oVCUe+EZQGoKVMcztz13wXZMgrNz1hhor4tZZMd000uqHWH1gcNBgIEEdR11hIYR3raH1KBQ4LXwMF3WzHD00JfnpRCPi0kOtoQbKkiS7VsGiAvZB5nok6Puv+4BQh9058zilNn7ABEUVDhjancdR3sgdVLIrm35gJYu32aOcYA=
Received: from DM6PR10CA0017.namprd10.prod.outlook.com (2603:10b6:5:60::30) by
 DM6PR02MB5771.namprd02.prod.outlook.com (2603:10b6:5:159::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Tue, 5 Jul 2022 10:56:51 +0000
Received: from DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::a0) by DM6PR10CA0017.outlook.office365.com
 (2603:10b6:5:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 5 Jul 2022 10:56:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT019.mail.protection.outlook.com (10.13.4.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 10:56:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 5 Jul 2022 03:56:50 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 5 Jul 2022 03:56:50 -0700
Envelope-to: linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 bhelgaas@google.com
Received: from [10.140.9.2] (port=51530 helo=xhdbharatku40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <bharat.kumar.gogada@xilinx.com>)
        id 1o8gEb-000FEX-Th; Tue, 05 Jul 2022 03:56:50 -0700
From:   Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Subject: [PATCH v6 0/2] Add support for Xilinx Versal CPM5 Root Port
Date:   Tue, 5 Jul 2022 16:26:44 +0530
Message-ID: <20220705105646.16980-1-bharat.kumar.gogada@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea750c98-d473-4b7d-0b02-08da5e7510bb
X-MS-TrafficTypeDiagnostic: DM6PR02MB5771:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5p0aO1uw3VcBJ7p/fvG8x5lea7jSR+RCQQXza9Q46qnXByICcOke1dMyZU8Zs7p3+KOFNHGqn+B0/8qHjmo1edx29X6ITdoqsFCvRLkY9ozVAhmqKTD6sscc9C7Od9h0UrXRLgAYVbW4zBa+eDGZsTH4oSgRIWp7sq+LEvgjDMrPGA8hI3nAmPGVgUDJ00bPEkJuPX7f6ETJBXS6Lwnf2COSDscrocPtqCe5L/DgG6f0cZueg50mRuWW6OcBb0/va2OZCpbGy7XlA5kC7RcAAwTQrL556A2qu3JwV1hMwJ+fkCtg8z0VrPg5MqiAbz2d/xpe/m0A9IDQebQQ7QY9On+bVyQKNYkT0LTFhsAXjkaHmsn+tM7jMNwIRazzO+QyETcr95X0u+3iSxTH0b9IgjOnFQnyjVApjn+1nUSe/yTfHcn2Drn9yAEuwmmovVuo0sksm+WIUZVhaqTIh0zm+0YUQ1eIMFCbbRu20dqeg0eG9VjkkAM9IsFld1xipiOXfemEiUZk7T4iaatxznnLBCK8i0TgxA7TKy2aLBiFyd0mn9BFYnm5jfvHcEJTEl27YL6db8ic/UgRkGuolRMSyZYHghDLhoxlT/DGNMvS4rbG8VUPuzmVEmrOcr5fLRkHNkNEt8jt29hFJjzF3FuPxcy1iWYkfR4TduUp6JsI1pGfbP85/B3J5E9Oh+B7i6G3fQTCNHaciH1w9Jb5X+UFLUGnCpzE/ySPzPIY5Ag7BC3KMEtGlwwVLVBUhZL3iWq+L17iL3HLwKzjAHEaHGqvCe4AAvH1tUuoKvbK7tupzhGvqroo8EocwG/FhZJriU7byYwcwT1JrWjOHSKOfmNCNyZVpL6VpbI3nM9syiEqzp0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(346002)(136003)(46966006)(40470700004)(36840700001)(36860700001)(40480700001)(7696005)(8936002)(478600001)(5660300002)(7636003)(2906002)(70586007)(41300700001)(103116003)(356005)(82740400003)(70206006)(4744005)(6666004)(8676002)(4326008)(82310400005)(36756003)(186003)(47076005)(110136005)(426003)(336012)(26005)(54906003)(40460700003)(107886003)(1076003)(2616005)(9786002)(83380400001)(316002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 10:56:51.0287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea750c98-d473-4b7d-0b02-08da5e7510bb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5771
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

Xilinx Versal Premium series has CPM5 block which supports Root Port
functioning at Gen5 speed.

Xilinx Versal CPM5 has few changes with existing CPM block.
- CPM5 has dedicated register space for control and status registers.
- CPM5 legacy interrupt handling needs additional register bit
  to enable and handle legacy interrupts.

Changes in v6:
- Added of_device_get_match_data to identify CPM version.
- Used enum values to differentiate CPM version.

Bharat Kumar Gogada (2):
  dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
  PCI: xilinx-cpm: Add support for Versal CPM5 Root Port

 .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++-
 drivers/pci/controller/pcie-xilinx-cpm.c      | 64 ++++++++++++++++++-
 2 files changed, 98 insertions(+), 4 deletions(-)

-- 
2.17.1

