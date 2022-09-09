Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45C5B3D65
	for <lists+linux-pci@lfdr.de>; Fri,  9 Sep 2022 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiIIQs7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Sep 2022 12:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbiIIQsg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Sep 2022 12:48:36 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EAE14739E
        for <linux-pci@vger.kernel.org>; Fri,  9 Sep 2022 09:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvrsS5BZlFrdMzEhgUyKdhr+HkvEooNOUPMyriGFSfgrek+EJaA8RuAYsrArkpRdf8wgl564xGzCkUFJpzQr3/x/MB7638bhB1bVTTlMuYB1Ap+Jq7zhnNYPZpNeH9SUs0wNpM87z+cMvmR3pDscSmdKzL1cqVhdy7L9NNohruu0LR8gekW+1TJiohBrQlMbOkpQo3AFhOWuZyWERxyP3BcloJoZlWKdjdcubvUkxY47KNwhgjOVXqdFH6JDjHJhY1/fe6tfK9Uh98vIx/3FWh77ib4SGPBSqqoVi6a1T4NqRC4Xzx665Q5N/dy5CEAlsLiDINm7kNbzuhBufcwYcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdrIdEAw/UijjGEE8q7d6OX1Zm7yn1aaD70FJzoslGM=;
 b=AD3WITW3jiHdTmFDH3BjjLZLL/MLPNESSmsdPucaMRF2+qchwi+eEOTpjQTJKdzsRwpz3/GcLCK9tYySfFBgOGZF4XG0U4+QwJGul0rQcFk3T2Ty5IwjSYrIt0HIyfILmEvmsBthex6j3EyBWzFYxMMGk2mhS998Og4P8ik5Gxi99TrcDRNEKtk814ozC3DOCyE1jF83+tuYbwMHqbXS+xQBzMfk2lFzsx9p5TxSFTzjnfIXAPG0/L/VWEFPy8AVl7qarYY2Pk+wmEHqvP1Hu/jh/rBQwAA9xLPHXhT9u3Q8NnPk3yBJkylc8rmUIGDXuZKwzOQ5E8R4I5ZvqFD0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdrIdEAw/UijjGEE8q7d6OX1Zm7yn1aaD70FJzoslGM=;
 b=4sxXIhSHcoECSGfkwPyQ6DAhCVQLBgxSmkDAMtsRLW9D2bTanGlrFbILVZ8aJSUmHpcYVwlezihBwgYK0vtCvtglN/8cymEVNdYC4N6YmD84uN8ykd6Pwjls3azYLaEmM2VVbiECdDBnysKWojX9Yu0iOupkkXsD0SqJZ3a4L2A=
Received: from BN9PR03CA0109.namprd03.prod.outlook.com (2603:10b6:408:fd::24)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Fri, 9 Sep
 2022 16:48:12 +0000
Received: from BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fd:cafe::e4) by BN9PR03CA0109.outlook.office365.com
 (2603:10b6:408:fd::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.15 via Frontend
 Transport; Fri, 9 Sep 2022 16:48:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT081.mail.protection.outlook.com (10.13.177.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 16:48:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 9 Sep
 2022 11:48:11 -0500
From:   Alex Deucher <alexander.deucher@amd.com>
To:     <amd-gfx@lists.freedesktop.org>, <helgaas@kernel.org>
CC:     <regressions@lists.linux.dev>, <airlied@linux.ie>,
        <linux-pci@vger.kernel.org>, <tseewald@gmail.com>,
        <kai.heng.feng@canonical.com>, <daniel@ffwll.ch>, <sr@denx.de>,
        <m.seyfarth@gmail.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 0/7] fix PCI AER issues
Date:   Fri, 9 Sep 2022 12:47:51 -0400
Message-ID: <20220909164758.5632-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT081:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 943b5c56-211b-46e1-f788-08da92831562
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yTJ3yuYVLya0M24MXsT42FoURguOhUHVPubjDo9PpIP9VXeMC24ENiZsfgiG29xbW7+WNO6WXO60VdSuptoiL+d0S0lVnWfvV4dRbZHjMgY70ITfdT4EIKdl9ct6I/Uf2WseFqdMbdFb4PxvLyMKL+DeTEy6KU8FGeZgOQ1ti3YEaLV/osPVrNxnUVIPGUVYYaf8ajwwgGR2KXEGQXqj6jswm/NVl+LdVZZ3KRGKjT0PZq0QnR+vo1LxZHZyds4Ey6Vun6TZCpaO7/WvEOHu1gdBAQDpL5chd/QeUnJ0t2PaCAjTDEUNV/MkEoLIpal1T1G3hE0zQRLSD/uXvrSm900/feIb9DAIw3m7IsJJ85X7uFSsIqGVwANTPpQpBkfCuYFZtPvuGB/xSUz0u2yqzXY2f72PjCdOMRhcc+3dhenOIC/K7uuiu3cyiHj+UStjy3RWgKsrSqQODZAaQKqtPy4MtBfPdNjtYgdfW4KI/bHbTLh7DYSrZbH0SWJ9vtEriHBK4voeqfUvmwihKyl1jtv2vJCbdJgj8Kfib+Q0QBQJecFaWdNT7cgPdBpZZ4vbejSmi0wqRXVOPkrQZBqUhAzLBrkO5ymFpv590c9MW3ktHUDnzxUIAW6rGQis4dltx/arBVulIxz78yy3IRAlfLSGnopzmX8vTWxKaDl0K8P+iXIN55bXnv6jjyzTyt+NlXXgjIxEEPa8Ykffe8HOwdGZ2guulKPXBc9VEqm3FFP57Z5DmKeZ9NMdVXDi/MwIlaqu6IRO/GmTaGy07+2P25CNRyxOam/Jil9o9bkZUH0=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(8936002)(5660300002)(36860700001)(2906002)(83380400001)(70206006)(36756003)(478600001)(40460700003)(40480700001)(8676002)(82740400003)(4326008)(7416002)(70586007)(47076005)(316002)(110136005)(54906003)(82310400005)(6666004)(426003)(16526019)(26005)(41300700001)(2616005)(1076003)(86362001)(356005)(336012)(186003)(7696005)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 16:48:12.2900
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 943b5c56-211b-46e1-f788-08da92831562
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The first 3 patches fix the actual PCI AER issue by moving
the nbio HDP remap callback to the GMC code where it is used.
Lijo prefered calling the common hw init early, but that
ran into additional problems on vega systems because it
depends on doorbell apertures having been set up for IH
and SDMA so we run into an ordering problem there.  We
already call the other NBIO callbacks as well as the HDP
callbacks from other IPs when they are needed so it seems
logical to me to move the HDP remap into GMC since it's
mainly used as part of memory management anyway.

The 4th patch just fixes up nbio 7.7 for consistency.

The next 2 patches are optional, but make the code more
consistent with that we do for other IPs.  See those
patches for some additional comments about the ordering
with respect to the doorbell setup.  I didn't notice
any problems in my testing and the VCN doorbell setup
already breaks that rule, so I'm not sure if it's actually
necesary or not.

Finally the last patch enabled early common IP init to happen
before GMC.  It's not strictly necessary with the first 3
patches, but there may be value in it to have the common stuff
enabled before GMC.

Alex Deucher (7):
  drm/amdgpu: move nbio remap_hdp_registers() to gmc9 code
  drm/amdgpu: move nbio remap_hdp_registers() to gmc10 code
  drm/amdgpu: move nbio remap_hdp_registers() to gmc11 code
  drm/amdgpu: add HDP remap functionality to nbio 7.7
  drm/amdgpu: move nbio ih_doorbell_range() into ih code for vega
  drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega
  drm/amdgpu: make sure to init common IP before gmc

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c     |  7 +++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  7 +++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_7.c     |  9 ++++++
 drivers/gpu/drm/amd/amdgpu/nv.c            |  6 ----
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  5 ++++
 drivers/gpu/drm/amd/amdgpu/soc15.c         | 32 ----------------------
 drivers/gpu/drm/amd/amdgpu/soc21.c         |  6 ----
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c     |  4 +++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c     |  4 +++
 11 files changed, 54 insertions(+), 47 deletions(-)

-- 
2.37.2

