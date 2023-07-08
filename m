Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0101E74C7B6
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jul 2023 21:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjGITAq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jul 2023 15:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGITAm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jul 2023 15:00:42 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2060.outbound.protection.outlook.com [40.107.101.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328BA129;
        Sun,  9 Jul 2023 12:00:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiIIGBG/y9oyuyHWrenPat37IU7GMWANIKKpU0CLkXkexDOM3zs2DsoF12apOplljorQJnYfpVPnrOpFyjJAPBJywnBjm1nzmQ2U2KJglyXBOkG4CPkgD1qAieF2ZKB9dJncDPk2TXmAQLg9pRr3hoTm8dKozB5ImcWifisYYMUlJ9B8MpZRqwTX92HQab5TufJInL+DtFtPSK/JWy3g9hgbtCr5jTtx1E/vWEtUuHLDu5EBoYpoxZnmm22n1vx8uYdQAp+9hAg+KjHD+Tdxiq+p0n+jBe2pZnU0Uos6rWDqCt1Zj1SuHzTpQ4dLdDk4b2pDOZlw/zNqcYbtQqF4MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X9srVhJuN6holpbqCUTwNSIHKDhekchgWn4KggqLWQ=;
 b=dVEBJvBhNNYWIr8WtBwblm39jMBz54KKq5o3h6yTOXm1devXC00WtGrqwLdviv2RoPCclcxGNTkkwwAwiSXuW6/MbEV0lClKcU1+YwqaR5wPvA02uN0nYfUwYucXSEELKJ1516DrM9Q54zj7j+FAaS6cg5DIKnR2/HsyXSKJFFlufFUOhXX1qpXVb/lq3k+tBwx+bWlqweMVi3wt3qRvjdVTQr5caiRwjW2GyU3eiD8+M7sB7wOs6W+Crki3Qpy2v6nEyf7U67i2ekeZFxAdHWl0MZyR9py9ofAhICXk3p8LxCfWLDK+k7AfTRLVwCkeFqXYLvTwO0ZUGVfQgYupng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X9srVhJuN6holpbqCUTwNSIHKDhekchgWn4KggqLWQ=;
 b=XBHpjWNLBXkhT6hyebmi7bZo3q7mOUwr2gMzbslViH/sAL7gfeXKB78O2VdrsDBr1goQjaztR0g0tLCE/4jZGJCuZGA8iU/z0+TQ6+NF0u2+PbaB+l8F8KznMe3c0yXE0jCUGLGuxxMQCBRRAxl+WDpGcmeB7poC+9ZJ65q9yug=
Received: from BN1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:408:e2::18)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 9 Jul
 2023 19:00:34 +0000
Received: from BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::fa) by BN1PR13CA0013.outlook.office365.com
 (2603:10b6:408:e2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.18 via Frontend
 Transport; Sun, 9 Jul 2023 19:00:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT115.mail.protection.outlook.com (10.13.177.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.18 via Frontend Transport; Sun, 9 Jul 2023 19:00:33 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 9 Jul
 2023 14:00:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6 0/1] Fix suspend issues with AMD root ports
Date:   Sat, 8 Jul 2023 16:44:56 -0500
Message-ID: <20230708214457.1229-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT115:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 4533be4f-3669-4aaf-dc2a-08db80aec612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EhO8d2ci3RRORGlVHY8p6zIToDxcs8KefFifRyVJy9NSsGrq+Wq1vhOxGaMitayOzspZ8e7e0HS0XQPi9ZzmtziKRoRcB1IQ6+oXvYv6vrbIT/F1b+TcwuVQ2mvr9EzlZJzXamQlNPLsDAO2QIBNUnER3MYf9s9J6Z2ySQH81YsAcAiFPzfYljVaEdZ7fKhJKcqKE4HPH0LuvkicM4rPHMpg2wITEnGB1B2PSCUgqySPBURF60MFC7mO6C7+SB7XqxRUaK3kYIsuTUC+NDcJqPuB1RLkB5M+NvZrUGeW+MwTxh4Hf7/s5QJ/+6uLNLQIQaN7+OMPM8yHufnUmaw+PtdxppAhoDrdPIuQqQQoIaICESPsLWTorpjygcuKFLF9xxcXy5hhAB+enJy5NifxAC7bqoHjwCLKC1BG8h/Yb8k3+kutKmz8Ug3DFdZbQioJAmcQ4+JIsHc5//92D/KmlHg2vdXX3cx/PhWh1vA35rao2jmqmU5YEbDL/Ud5b823/d8twgW98RsrP0ECnA1zcD83mikn8+C6LtShMXk62r177zdtzAvUqB+go1hKlYFwsIDsb8+o8JrbJPeBB3VGqKMERO5iyH7nBRq+T8Ovz/eYDuQordSymcu75oCKgNIwZEY1NSLqRrw0wVb0FEsOBf8nnjcnTUwzWovjSTT3NR69v4PZdH23OYNVuHeUYI2PicDrGaL5aH/Lq2e04YTSNfm8tRa35aqAiqZvHUaNYKP2NBYD86jwYascNLTj5DrRiyRn+gkX3tG2zTkMztZJfcxjPywqm02PQ2CO/GkrZfY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(40470700004)(36840700001)(46966006)(44832011)(5660300002)(966005)(15650500001)(2906002)(16526019)(1076003)(86362001)(26005)(186003)(6666004)(82310400005)(4326008)(336012)(83380400001)(426003)(36756003)(478600001)(70206006)(2616005)(316002)(110136005)(8676002)(54906003)(8936002)(70586007)(41300700001)(7696005)(40460700003)(36860700001)(47076005)(81166007)(40480700001)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2023 19:00:33.8221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4533be4f-3669-4aaf-dc2a-08db80aec612
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT115.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Problems have been reported on AMD laptops with suspend/resume
where particular root ports are put into D3 and then the system is unable
to resume properly.

The issue boils down to the currently selected kernel policy for root port
behavior at suspend time:
0) If the machine is from 2015 or later
1) If a PCIe root port is power manageable by the platform then platform
   will be used to determine the power state of the root port at suspend.
2) If the PCIe root is not power manageable by the platform then the kernel
   will check if it was configured to wakeup. 
3) If it was, then it will be put into the deepest state that supports
   wakeup from PME.
4) If it wasn't, then it will be put into D3hot.

Earlier more general attempts [1] to fix this have been made in the past to
change the policy so that only roots power manageable by the platform would
be put into the appropriate power state advertised by the platform
firmware.

It was hyptothesized[2] that this is a general issue that affects non-AMD
hardware as well, so I spent time to try to match it against the PCI or
ACPI specs but I can't find anything that says how the OSPM /should behave/
in this case.  It seems that this is up to OSPM to decide.

A concern was also raised how this would affect other existing hardware
that may not have root ports that are power manageable by the platform [3].
I suspect that they *should* be fine as Intel reviewed and acked the
original patch, but I have no way to prove this.

This patch is a more targeted approach to workaround the issue only for the
affected AMD hardware instead of generally changing the policy.

Link: https://lore.kernel.org/linux-pci/20230530163947.230418-2-mario.limonciello@amd.com/ [1]
Link: https://lore.kernel.org/linux-pci/ZHp45fNGuPUWPnO7@bhelgaas/ [2]
Link: https://lore.kernel.org/linux-pci/20230607080154.GA7545@wunner.de/ [3]

Mario Limonciello (1):
  PCI: Avoid putting some root ports into D3 on some Ryzen chips

 drivers/pci/quirks.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.34.1

