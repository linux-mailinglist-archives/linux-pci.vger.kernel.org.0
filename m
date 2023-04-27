Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3264D6F006A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Apr 2023 07:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbjD0Fd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Apr 2023 01:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjD0Fd6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Apr 2023 01:33:58 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF16E2D69;
        Wed, 26 Apr 2023 22:33:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCEGkgKvlJYq3eE9YEQ1DOBMiseqp2tqsRnRw+2TstD0cgQVPvC4nU1JMj2v8VGwgCm7O8Skyy3D9D+pCaRgqkxs36MJTuGpmEXKNUT0BPOCweHyJBRLSOdjrigO7jLU6q9JsrwZluTDfMqmNNM8J4i/EyKuw8NakqkAL60/7qMhEFPvJYrn+u3MWD42zKYBx7fF2macq8Ft8BzAmnzo11zjzwFOR9GeiL8yxrVfDkem12im32MTw+Nv/a1RTQ1qiPKgTx7qmpbbbKb3Pl+f62Bx6aE+0XvXitvd3Q2tUFmK4K1dZUypx1/EQvjIBxcBEVlDsF7oEcQbXLpY0QB3Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CZOmdQOctJ8xwnztLZB0kKl0q86T67N8nbyEZcWrjY=;
 b=KuOT7xXzRFfO5b8qNynCC0nRSuTG+hVuhZYZftWP3i7SGdmpE4ZK1rWK1u7yeVGb2pZ/IrbWU9b3vEA7bFzCFZ46EwIwuqQ1jsibdyn7MSGToqJ91dSvjiYmltTlmcR6KfqT1JFXEkWKn9SQtBFg9GM93EOUpQ4yDmYEzh8fkflBo46de7OLzWr0jdeZVeB/n+QPy7Fy5TsbZpCjFYoqWmE0JpAXym5DuN9ozXZDhEtKs7Zn0cVRkdvQnw4kro93pfK4FCvyvri/TOcnX0gHuUkwc01rFmTgMdktpVFQcD1jw+tWiAlpW0yU4xs3cV72rnIUlB0e9Lb2/SVxfm5ltA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CZOmdQOctJ8xwnztLZB0kKl0q86T67N8nbyEZcWrjY=;
 b=GhpdBBM1rDNh4p0skirAgOqC2yrxvR6q4xEAtXo7MB67uzN3tAtM2jeywHAvLOA13tNPogZT3VwtzaGQibNPhy8O9zltdBNTUnJj0EJ1d0ZkeOwcxHOC9Q9ddCW6b2Wzkv95wMS5bS/KA2nabtSTJCQEPB8JwvkXHzGQPoV0TbQ=
Received: from DS7PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:3b8::8) by
 DS0PR12MB7897.namprd12.prod.outlook.com (2603:10b6:8:146::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.22; Thu, 27 Apr 2023 05:33:54 +0000
Received: from DS1PEPF0000E640.namprd02.prod.outlook.com
 (2603:10b6:5:3b8:cafe::c) by DS7PR03CA0003.outlook.office365.com
 (2603:10b6:5:3b8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23 via Frontend
 Transport; Thu, 27 Apr 2023 05:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E640.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6340.15 via Frontend Transport; Thu, 27 Apr 2023 05:33:54 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 27 Apr
 2023 00:33:52 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        <linux-hwmon@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     Richard gong <richard.gong@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Regression in s2idle for family 19h model 78h
Date:   Thu, 27 Apr 2023 00:33:35 -0500
Message-ID: <20230427053338.16653-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E640:EE_|DS0PR12MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be2888d-a3ef-4314-d6bf-08db46e0fd9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3YbZiVHn46Kz3/TmBimTXt15NoDkEK+wn6TtAnJr2K4Oq1YhEV+ZmgK7b18ut1az/tkkrVLhI5hm17G+MuzAWsdytNbYkUZ4euR0+hpNPcWKa4H/ix1GEZGJ58zDjjEquyjN6m6MbBrvdK1QT0KU6hfosmHSMILJIqC8NGgOOtpVo3LZ4/c2y4q7HDWTVjUy2z2/rUsBJnQr8r0sHy2NXQhy59uAO7AXuv5gIBaqwOd8D/7musKDBPl53KBDulb3bCC8we20MjxFuVfz/h0Bt98HYsARQaao/L6mZ2XQ984vlMeQGJy45Lzn1fI2vC5pq0/ZC86/o/MHSpGpwRob3eySGE57xSATLq+HZvA1QPtN9h49axWXoKi0gHk2jZyKyEP78Kgfxunh0J21hW2naz09bj7WLCim3BSxu7kclDlFNGMKzc+Yvj99fTyg2+JIP31oH/OdrXpJ6yYHn6qd8QIAlqKYIUa0xxCqxbMBhDrmHSil500pdQ/iiy7iZMYVgRzq3rztQ2aEYc6Ym0/y/imgjeGthH297c5DMDqtCnw1bCc/T3qP7qewpk3Qzbgiw6fVsv0ds0ZqGJnnGFCxTNI2odekfFa0N5oNWoZX7RtFMs+6C2LpOhBjd+aPGuXCyrLPv3IwMTbU0l3OMTIReh4+vq3z42tz8o5L203rfNvyZXx2UhTd7fhR9FmVHpXA411VskGydXmItRVi9X7A0nDD8CHhoHuaoWH48NUlrEelTG9ajBX0c9/bUZ7whv/+mZSpcGUVuVjGvaxRjdpcS8o3UGaMl8h3mYuWrSGrFc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(46966006)(40470700004)(36840700001)(110136005)(40460700003)(86362001)(70586007)(16526019)(186003)(40480700001)(478600001)(6666004)(82310400005)(54906003)(1076003)(26005)(7696005)(36756003)(8936002)(8676002)(336012)(426003)(36860700001)(81166007)(356005)(41300700001)(2616005)(47076005)(2906002)(4744005)(5660300002)(44832011)(4326008)(316002)(70206006)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 05:33:54.3430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be2888d-a3ef-4314-d6bf-08db46e0fd9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E640.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7897
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A regression occurred in 6.4 due to a missing ID in `amd_nb`
and the `amd_pmc` driver now being dependent on amd_smn_read().

This series adds the missing ID which fixes s2idle on this
system.  The ID also enables k10temp to work.

Mario Limonciello (2):
  amd_nb: Add PCI ID for family 19h model 78h
  k10temp: Add pci ID for family 19, model 78h

 arch/x86/kernel/amd_nb.c | 2 ++
 drivers/hwmon/k10temp.c  | 1 +
 include/linux/pci_ids.h  | 1 +
 3 files changed, 4 insertions(+)

-- 
2.34.1

