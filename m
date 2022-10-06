Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A206B5F6E45
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiJFTd7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Oct 2022 15:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJFTd7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Oct 2022 15:33:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCC78E9BF
        for <linux-pci@vger.kernel.org>; Thu,  6 Oct 2022 12:33:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyN0qRp6Pv8TQOirgNBDS9bFpdAuHTH6NvgcdWCgeHd/NK2izqYTzP9dFctknCfnCUhO3o0b0PJY9GCadtsKMsPqe/haxUEZXxWvxYz9XdcCk1NPr1ffxLD+hJ+ZowMzK0aFsr2xhcT3liXuJbityiW1IxOHQ+zHmn1VNgWjnuXbSMJhSvqyuTnirHFxXs4kP863dMlpYEVbtEI0FZrB03iAFsdQPF2tGra9mOyIKljDD4ZsN7bJhYrpii421qylaeHHj6hRoxrKf9Ie96K0EGCyZpb4EWAzsSkcWAOFypKUrMAvqRN3gF4BJhSphWe3mHwLIhUqbRBSdXFe9BlPkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aBflO5hG5ErUh0wh/CT5eno3sr84f1mtDu7W4T+94kg=;
 b=bEcF7+lUytvw9GFPYoWl4NevrgrFy45vpPBVYPDzp4dG0p/V2RYbN9RwsV/aeB86bmXmC3XGr2PMA1O1zE4/zq9ufN2QIIWFGCybpxdgqRH1lmd1E3UgRVlWXGx3dbYQ+xrukMSD80KjSRY34gNkSJP/+0SNx4xvBQD3ZWbGB57VDvgkAO/aDhDhhWrKameZ4Y34Y+2mj7Q2sqA8+mSL27bIZeSDhCcZVA16dHp3lzsSx3Mjp7wjRa64vkAlYVS90ql5pkKEimd8IiM2DDXYe+PcGKfokxpb7BpIiVf68KWA6WiFHKAyMt71KphUbL7utWgnu/Re/bpyE0lwjfx5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=deltatee.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aBflO5hG5ErUh0wh/CT5eno3sr84f1mtDu7W4T+94kg=;
 b=MNLyVESC6HUtjvI3L211s3WEh67KebBV3c5cQ7YhisY86bVz8akBioCIr21x71hQctC7gHGYt/AqcWCQEw/w/TfH/SoHmwH5wkxAUMLJA3xHOuPVp6hVFukQR1mN9xFVAbSnhg5yTA80CXqg6GZKejKK3UTQFWGlnHg+m1tTgQc=
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 19:33:56 +0000
Received: from BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::2a) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 19:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT110.mail.protection.outlook.com (10.13.176.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 19:33:54 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 14:33:54 -0500
From:   Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To:     <logang@deltatee.com>
CC:     <linux-pci@vger.kernel.org>, <ramesh.errabolu@gmail.com>
Subject: Understanding P2P DMA related errors
Date:   Thu, 6 Oct 2022 14:33:48 -0500
Message-ID: <20221006193348.608047-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <5d3b257a-c125-fdd6-e29f-229e54679f45@deltatee.com>
References: <5d3b257a-c125-fdd6-e29f-229e54679f45@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT110:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: f027e9c9-feeb-4223-874b-08daa7d1b4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b37dlR1JMLdwHya+qI1g2R7SsTFmBO0ODmoNSxKdAcmXKSZJ3Ajhdfv3FHF5Br5CbBLnun2ghwKoH/JBB7j4S21jUZz0yb0Nae+DL9BMAVj7LChSvkyEVwSB+dmdpufKyOAZqAP2oO9QUKLnaYhvBRC1btuboBdccMXUtBek3vWu7ji33bRVMT3xymCcqsT6OkbhRF7TfQ3Y8hbidDo6+a7YQp1QNGWyxvzeqngroQsyuP+YmKFPJH+M7Uk2Kzzn8yD3LDblmY0DnqqluPunAvqCh4oQvfdrmXy4PhuFMmQHj5h0o8PSlnsL2BtyGEeRHOHpKI3t1VOeAfOuYeBtRTjrUtZfQYqdN/npfQL6lHP3wp4C9se2H34bXUqLbIXPpswWxBP5OSsnzyncF9DZgqZpxPSnC6Uv+MeQ0LUwLwhjS2oKRupH9qFGmLIKcphDTkVg5/q2GszTQPbUDX5083Z5T23quSrDJ/9yB1LN6HdfPweGIJU/iLrtw56OnWjAzh90ThPPJUVo4FZ6UIVD0ZFO31bcQjeCxr1g4e+SZxT7wgrIRTdR79v6BQrXgYpYUx5uMg7yHDOVb0NNWZy3htqgJXTD5mANV1G6mZvSBvz7b9XSGrXne4ZJSA4lVgOpaNV3QieC8ME+Mry7XkdkR72FBZtMZgPoPOxza1W0UeA7kG4u66Ax5GZ3hw0ZBSlMySEfxp+0cGUkzbNs26ZYFhZMbDBxLcGloq0vSvtvzDZPrQZ+X/WO8dpiS1Sz/9byjsZpawoyB5jJ9VbKS2nnrIHvUZ66mzq8XMzzfLZo5wbpEMqGR/5bGf5POKpJkamv
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(26005)(82310400005)(47076005)(16526019)(36860700001)(426003)(1076003)(186003)(478600001)(40480700001)(82740400003)(356005)(81166007)(8676002)(4326008)(70206006)(70586007)(83380400001)(6916009)(316002)(2906002)(41300700001)(2616005)(5660300002)(7696005)(8936002)(6666004)(54906003)(40460700003)(336012)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 19:33:54.7520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f027e9c9-feeb-4223-874b-08daa7d1b4b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT110.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Logan,

Wanted to thank you for all the time you have given me. I now understand
the PCIe device tree better. The thing that was throwing me off is the
way I was looking at the "lspci -tv" output.

I realized that Root Complex should be understood to mean a set of special
devices hanging of a BUS. The most important member of this set is the device
that acts as "HOST BRIDGE". This becomes apparent when the device tree is sketched
out on a piece of paper. One can then circumscribe this set logically to form
a logical device - "ROOT COMPLEX". I wish I could share my sketch via email.

Including below lspci output of this device set:

    localhost:~ # 
    localhost:~ # lspci -vs 0000:16:00.0
    16:00.0 System peripheral: Intel Corporation Device 09a2 (rev 04)
        Subsystem: Intel Corporation Device 0000
        Flags: fast devsel, NUMA node 0
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00

    localhost:~ # 
    localhost:~ # lspci -vs 0000:16:00.1
    16:00.1 System peripheral: Intel Corporation Device 09a4 (rev 04)
        Subsystem: Intel Corporation Device 0000
        Flags: fast devsel, NUMA node 0
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00

    localhost:~ # 
    localhost:~ # lspci -vs 0000:16:00.2
    16:00.2 System peripheral: Intel Corporation Device 09a3 (rev 04)
        Subsystem: Intel Corporation Device 0000
        Flags: fast devsel, NUMA node 0
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00

    localhost:~ # 
    localhost:~ # lspci -vs 0000:16:00.4
    16:00.4 Host bridge: Intel Corporation Device 0998
        Subsystem: Intel Corporation Device 0000
        Flags: fast devsel, NUMA node 0
        Capabilities: [40] Express Root Complex Integrated Endpoint, MSI 00

    localhost:~ # 
    localhost:~ # 

In the above log one can see the device 0000:64:00.4 playing the role of
"HOST BRIDGE' while the remaining devices 0000:64:00.0/1/2 play the role
of devices that act as ENDPOINT. I suspect, not sure, these devices play
a role in Inter-Root complex transactions. If so the whitelist should have
all these devices to support P2P traffic.

Interestingly in a patch I could find I see only 0x09A2 being added. Perhaps
the intention was to support only those systems that have 0x09A2 and not these
other devices such as 0x09A3 and 0x09A4 which may be newer.

Regards,
Ramesh

