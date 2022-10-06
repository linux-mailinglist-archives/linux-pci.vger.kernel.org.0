Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACF5F5F3C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Oct 2022 04:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiJFC5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Oct 2022 22:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJFC5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Oct 2022 22:57:33 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513EFC0B
        for <linux-pci@vger.kernel.org>; Wed,  5 Oct 2022 19:57:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T3bmbsKWqGWI0LNGeqGNs4ZJgEnxWy4AR7ZhV2oick5mrNYoMAbZQjfaD8VSh4Vf/gNS5+rx/K4XJp4OJwsdmM9f3ic1S1r+nmAj1ibQa7G3m2aOB4xdBFA4IRcoIErQndwWV/OrRwvS7EAOS+aSrmmA2r2dfeeXiSOBy4nNnHZbzG8r61+8iMIwtaCRcKQdC1syj+LPUe1mq/mrw3py5G8blncQ0zRNyJlZnuSsW0rh6PpNFL9JrKp0+ynoEY6UDDA49rMd216PVXpePxqdv59XK2h9LfVI8Zto2UPqEYzzEHpXcKPcnD2Z43zW7effq2x34BQFlLVx30fpTwgG2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6mXjGiWQwcSc3xOhMBUe9IcT7/8gx1ehhdxHm+2+PI=;
 b=KC0oJNf0HXAlq+7g9EIMobLFwF5vXC0wUeUtFAPj/GAxdHXvi4z9oyU4TcnJvcRaSs1rtUA6wm3UkyJDGy3CWCme0y+zv1qCkAolyzwsf8NGmmuj9V4VdJ7A3ravKgqBcBTjo7OPE8MNqCdCEJzDwZ042OyZKe1PiBktvm2sxRORAcvczmt36pq483ZBLpV+3SL2z8YlO8mLswtD+6tVRIuFulR7RvO1jd0GpULVDiY8J3DRhZt/QuXAxP20y7h89YIAoYMI0xwImvKCrH97boF+7S+e6E6qgHSYdlSt160AxbXbUijtjhvObAEWRHasz1eMmDX9eqhELF1LKwFC1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=deltatee.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B6mXjGiWQwcSc3xOhMBUe9IcT7/8gx1ehhdxHm+2+PI=;
 b=UHMP8QMrFimkkmzib2DdnTRboJTN52FQVX3YvwQf0mJKwRLB0aDfdkokiqYAVWXSXRlQAKmQQWBQ/z2FT5hriAWwjZ77M8fMvKOzDOt3nlyASmkf7oO8LfkoBTJkEK3sAM0IrmI+fiLPn9iyRbh9LS+lgohmlheXNOr9iDBCBIs=
Received: from DM6PR13CA0042.namprd13.prod.outlook.com (2603:10b6:5:134::19)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Thu, 6 Oct
 2022 02:57:30 +0000
Received: from DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::c7) by DM6PR13CA0042.outlook.office365.com
 (2603:10b6:5:134::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.12 via Frontend
 Transport; Thu, 6 Oct 2022 02:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT038.mail.protection.outlook.com (10.13.173.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 02:57:29 +0000
Received: from RErrabolDevMach.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 5 Oct
 2022 21:57:25 -0500
From:   Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To:     <logang@deltatee.com>
CC:     <linux-pci@vger.kernel.org>, <ramesh.errabolu@gmail.com>
Subject: Understanding P2P DMA related errors
Date:   Wed, 5 Oct 2022 21:56:53 -0500
Message-ID: <20221006025653.3519854-1-Ramesh.Errabolu@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT038:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b25a7e9-1dd9-4bbe-aca3-08daa74681e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CYYJSd51+I+310oclESBv5tvHHxmX9MxxKOjp8V/83E2cMQia04poDMa3zzTKdPz2oQDS3ls/PLyWvg6r686ATWGh7+VAiWdjMCoFO2D7vA41qr4cOxleloqoHY3sU4s6vbQPWsZEfKfIRqcTG/N6x1Zazup/0x+u8Qhd4tQ2ARbOcmlBevcKRAP8r6dq4K9U/bv0BMbRx/pOguvsQZLcWnZIsc4dTTjkZG+qIZQ0LAvLdWyucMfeI0TZmW4SGOm57+uwXW2aGrbaSnHz54n+AhDsTdviRb3iy+kscytfkNwnHYNVJ4FDDtBxPribuWgxnKx0YfFu5pNy5pwW7KR4gctpP4GKYI8WlfwzK90RNEhPl037V1UXXBmMsAz8APLtWPZMIDieuryiqX6zPDhAi53ze1++MHIecNy9OobW6ZQj8ihBHC2ma/m/Fm4VTXQ+k4ir9qJrYOr/vs0g0BRE5rYFeXLKeUjmU925XRWVcZtiX4GOFrevv0JN7hh/ZUpoAYVCS34IgYuTC1wDMR8YVd8aYnLqGEilRjJr/EuDzGutIjft/hy6Se3Rxr/OXzwpayecLKP6yQg9UTtmgWTr97j3yx6D8zXy6Ib/eUtt2p6gQ76bAuc9YIigLUUyDvs1ebEhsQYYpEyH5Ccdqn7fRvWsefxF5Tjr02akO990yCyIRZNR94MF+3fCzZAUMeFOK2JLGsuLH6OYLhrKBLSpTse0pjyX2jxItzJSikCy072E+Io/CDHaMTu3xHuF9IqttcA7dur81V4qJPeaQs7KlYWBH018w3hj/mUcO1shFFVgWLSGVV07SI99uTiXG0
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199015)(46966006)(40470700004)(36840700001)(316002)(82740400003)(5660300002)(81166007)(83380400001)(336012)(47076005)(2616005)(356005)(36860700001)(186003)(16526019)(1076003)(6666004)(70206006)(40460700003)(4744005)(40480700001)(7696005)(70586007)(82310400005)(41300700001)(8936002)(426003)(478600001)(2906002)(54906003)(4326008)(26005)(8676002)(6916009)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 02:57:29.4205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25a7e9-1dd9-4bbe-aca3-08daa74681e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650
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

You are right about AMD devices connecting to buses [0000:16] and [0000:64].
However I am unable to understand as to how you extend that to mean they
belong to Intel 0x09A2.

Per my understanding I am expecting Root Complex enumerated as a device,
with various other devices hanging off one or more ports/buses. In the
PCIe device tree, I don't see that.

I see the [domain::bus] as the root of the AMD device. Furthermore I see
Intel devices 0x09A2 hanging off the same domain::bus. I will take your
word, but the way the root complex is reported could be less confusing.

If I could make a request, it will be very helpfulf for folks who don't
dabble in this area with a simple cheat sheet plus write explaining with
examples the various root complexes and the variou end-points hanging off
of them.

Let me know if I could help in this effort.

Regards,
Ramesh

