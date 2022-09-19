Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66815BCEF3
	for <lists+linux-pci@lfdr.de>; Mon, 19 Sep 2022 16:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiISOd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiISOd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 10:33:58 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2046.outbound.protection.outlook.com [40.107.101.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5D2DE86;
        Mon, 19 Sep 2022 07:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlVLbEIGjEv1W9LwbD8Pm0ZuyonQELvpWDVMecuGz1KIJqJjR7e/3bioKfLJfR0qowQxvi/yTqrDktpTnDVtnnEKigH9vuFljoIJSVmb0YH/iX8Pis4YgRz+EnQGQtGaWCY47faJ7oH2Lj+UpwnXpHDUZRs+Hx3Gx0LXOn5MTrWihxSUWnW7aceS6FQvkvTDlsP0EOkp1ukYBULJbEqPPqvW4fcltpGykxs7L68zt3hcoBFkm5wMvlX/mO5DCqSZX1FXLSZK8KDTRY1FiPXTqpS7LVaGaEstn3cmdlex/uSphfvFKZp2USZsIAlpmVTYBY89C+p74s/idI235KtXFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uOeU8LxLai88fopUdeQfYznaq8V+ywnyORTj5Dw95w=;
 b=Rv7a4MCGO4+d2nP7vnWx/65DWhG5xNDY8nul55E2fRIuzuKokX4aji1dE+QhbD6eUxy4flIe5m4RKzYn+8Hmxi4Mh6a2JFBEMnECf9wrhJSf0iN/RyAdkobr+IShYIo9qw1pkh7ObDliOcHJKMNFk/qFVnKpqq3I05QOfw2S0ubjRhhmwGWSOBjabcwzk1OeqyFmokYbntQZ6RzSLKiM09Mv2hF2SqBkY1a3XnGuN8Z7MuErMpAsG7CqYxbzu7G/AQU50n0j+F69m+Wvfyd7NOWy1RdymagQKXfQsnP6h6v7jJWwFB8w/r0C44Ls+1XloJkM3USS8pK/EyjGgscD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uOeU8LxLai88fopUdeQfYznaq8V+ywnyORTj5Dw95w=;
 b=hAXzjjeWsZgnBplKoZGLE3Ku78rbpurBRwuR0pAtCYCP1nTGHFthYxbx3lgKLL9iRLE2Zg7t9/H+lkaBEcTo7XAChbwdE/GmCndGoJ2FwigpgtABXadz+/3GlF4zDgXDhHkAJj7HogY1/8pTxN6zmRwmqoZqgIwxkyqfa1oVevt6CeBSniid/CpftPKvO1TwOOZGOsXxpeDyo6tiQHHKVntp8Vyi/vH/kHbvZ4epYt5p0OEd0Xd4mslFG45maSOue+T/Un04yPtoqRt9gfZZjA/sGKxxY75vtUy3GQSUsRIbBcLmzcz7Yvc5Ts7lSZSZoXCcib+ygU7zmmejjWN0kA==
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Mon, 19 Sep
 2022 14:33:55 +0000
Received: from BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:34:cafe::cc) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Mon, 19 Sep 2022 14:33:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT003.mail.protection.outlook.com (10.13.177.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Mon, 19 Sep 2022 14:33:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 19 Sep
 2022 07:33:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 19 Sep
 2022 07:33:45 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 19 Sep 2022 07:33:42 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <lpieralisi@kernel.org>, <robh@kernel.org>, <kw@linux.com>,
        <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 0/2] Disable PTM for endpoint mode
Date:   Mon, 19 Sep 2022 20:03:38 +0530
Message-ID: <20220919143340.4527-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT003:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: c134d987-8d0b-4e4c-eecf-08da9a4bfb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qKbVhLStRXFafn95H63UzbkujQAcLg45p9k9map7VL0jxB4MJErdeZT/K0l7X4PN33PPe3J/cf6vSscoWLdNCK2UX/nBVJ/J+B1F8pevx6ADlC+LmS07gO4BB2aPr8HtGACj1IKu3i1BEbQJD8Gm6ZPI+oUTb9LB8UG9/1fXbpkj8IQC0Vota0bJFUW9U9PT1n9m3JXdyDQi6SK9j/EW83oMQUtzPztmu4rzSClT66xXoubiN/QbhfBuIjLwowFiaIs5MSpzQ4ywWZFE7PUOuHrNCmylBM1DlMbJaBy6PPFA8pVHU+rTPrtop+vRwngHk62dn+sJdvVEDyj843ESiSbX4+Ew7EJcW/Y/jRSgW0bxRTxDxtNpqyYwDVOc8BO2Jj7URUf0ZzSShTyh/cGZwqy+xDTWEshxdhYBYDAlxD+lrMPIOqL98YMiu5eRPj4sWXL0ciPMPlnhRTRpyv4MmO74teC7PtSGEduWf7pdanB4rexLlkc47XBuRmZQxMaIvJz8nfsrL5iJqbvjRDOPacnvy7Axxlv6Qa6Ajo8lTxqpnVg7yVa0TL46rbk2oNLW1zg9CnZLJaVYY/8LeoP4ByjsDoGAZQ6Oe/wvMe1zz37mkGJQHrhRKbswxV2WBGlB4GArV7DUrUBCqRlXfGq4BEpQqSs3bg88zyveXInWqSmxqoU9//yo+rZ8urwpFWJgVGB+9k+T/KR1AS+J784yFukfURvM8j5TwghS3q1H184A1RqTiCZPUguqdGSy+fl5dPo2LTXGJON7rHUg9Rai/Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(40470700004)(46966006)(36840700001)(7696005)(86362001)(41300700001)(82310400005)(356005)(8936002)(26005)(7636003)(4326008)(6666004)(186003)(478600001)(8676002)(36756003)(54906003)(70206006)(70586007)(40460700003)(1076003)(316002)(2616005)(2906002)(47076005)(426003)(82740400003)(83380400001)(40480700001)(336012)(5660300002)(110136005)(4744005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 14:33:55.1893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c134d987-8d0b-4e4c-eecf-08da9a4bfb31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains patches to disable PTM for endpoint mode
as the PCIe compliance tool requires the PTM be disabled for the endpoint
mode.

Vidya Sagar (2):
  PCI: Add PCI_PTM_CAP_RES macro
  PCI: designware-ep: Disable PTM capabilities for EP mode

 .../pci/controller/dwc/pcie-designware-ep.c   | 19 ++++++++++++++++++-
 include/uapi/linux/pci_regs.h                 |  1 +
 2 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.17.1

