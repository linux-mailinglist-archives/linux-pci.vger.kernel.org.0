Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA7C5B6E41
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 15:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbiIMNSo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 09:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbiIMNSh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 09:18:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586CC18361;
        Tue, 13 Sep 2022 06:18:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJom/FYcn73ZOiOxySrpjSnO+h5ugArkRPrPu8MaO/CWVcbCg7D8U3kXEuww8NnMMM+UUzSjSVxdgIVnT0dA1kdod4QO/nXuhfQ1sDf8m61+h+I1j3kQa+XvL7rchNaxgMzd5HxG2tTGRcSauouillYT1XZQZLceomdvsZloBwQchIUzq4a2JG8/PsVEMtYeHDCsw1z9qJDJ4PXmliG9FNtLRQMe1YbgVbQ3g+NJ4RhDypLRfqZPOwGqbTquyfNyacm++nX5BxvxEZiB/b9NjLb4NvsrWFrKd/MpS5zus85WJ8qt/xDMYk2OczeUDuGNckpYPl3A7IsmnGx53fmraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeOkBKuC3Gqsrflf4+BPLdi/zat8Oe/FCI8AzTiXVSU=;
 b=I554o6+i9Pml9uORePgh089PBMubg2lVvOHHsvbzZAdn7nH5tY2+P98j1qMjca+4y674WxVDAAf0D8b0WWmDPQeAtJyt73jBIkHw51kGDOtxBucoBBv17tvGbkyUv6ehpbjshsuv7pkZpNguyb+kHY529M+8Pxot5f8VAU/9lYPzwGWHXtMMQPyZyahpJOE9hK7SCnCHuV7Ud08DFBkYMWE4zqebJbqQU/9ZrPDx52mFJ34riK5EU4ygtoIuoMULw/ib7lnYvhQamPicVQNDwZUl7TWPSEp4Rof2Q76vtSj/dr/bOhGEQKsieEz7rxvgD5YWxBX+VWb77OQ/21PCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=linux.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeOkBKuC3Gqsrflf4+BPLdi/zat8Oe/FCI8AzTiXVSU=;
 b=mMJqRFXKog33V9JSlH4aF8M/qjBbT4bxJWSviDWbbB414BkASP3L1zGDbrpI+iM12Ro8O6frq821CvpfPRaLu96Q/GV9L6zOIVt74otrzylVaSWpwTvfTCPtN7155UQzFTsbRhY4wozb3aS1ZhRZknHEPvUUKfklcxjFyW7edqj40aIFVxggIx7GSbNpGLMjTEi7yUz70XVMAo3uF6SvuIRpywOQIE6m2O3aAQm9pegnST5YJV2ic1xL3I+l5lWHyGTGYoAORHD2OXvOjeJtteHcT+dO5KHx9nPIfVb3tA88mMGNTk8ti07+MNzS232R+hgkDKtnIeI3Z21uMB9lug==
Received: from DS7PR03CA0102.namprd03.prod.outlook.com (2603:10b6:5:3b7::17)
 by IA1PR12MB7565.namprd12.prod.outlook.com (2603:10b6:208:42f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Tue, 13 Sep
 2022 13:18:30 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::b2) by DS7PR03CA0102.outlook.office365.com
 (2603:10b6:5:3b7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Tue, 13 Sep 2022 13:18:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Tue, 13 Sep 2022 13:18:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 13 Sep 2022 13:18:29 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 13 Sep 2022 06:18:28 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 13 Sep 2022 06:18:24 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <refactormyself@gmail.com>, <kw@linux.com>, <rajatja@google.com>,
        <kenny@panix.com>, <kai.heng.feng@canonical.com>,
        <abhsahu@nvidia.com>, <sagupta@nvidia.com>
CC:     <treding@nvidia.com>, <jonathanh@nvidia.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V4 0/2] PCI/ASPM: Save/restore L1SS Capability for suspend/resume
Date:   Tue, 13 Sep 2022 18:48:20 +0530
Message-ID: <20220913131822.16557-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|IA1PR12MB7565:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c09f1f6-0947-4549-1527-08da958a73b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9fuVtWNlpkvrbKNzqSbI77gOOLB4OKPb3MCyLAa9nRPcaSnRS6jNaooF7q+VsCci6dG8y0OZ53pzVQc3FnuBnOdtKexJkFje3JLIbM9gdrh/Xtr5v3FyjmeJTFSeevMkKP/4hwOHklhNZkTKnO0GXd+OPKKUzYss2KfnnqMISlIyUG9usctCT24OJ7JwQHFWEOfXTrcL/2ZCiGFVAD+jI2qJnW273G+IFl4gw5bz0FLwsT6eMdNifOHY7iap7D5CnJJj9nJWFDjD3c6WUP/4BWDBOEYSa2mvBAn+R5EezPQ0dZsHCQ32T2IIUu+L+0Yd4Q5PNzcqJzemlBkNmV6j/0ohjmXz5AabwD5vaJp0h5ozLxIWga/3JSwATH4CkJXI2AGzObC48z1s/kFrDTFXkoL2wFwLoCDtgaU0+mBzUW0HkzYTr/l/rxCCeDCfIR3cqPepxZDzh97ZoZ2p7pp/4/5jfq7afCD82p1iNezwRbQUNstMrt30y/xQXLV2SKfv+58dR9YT4QsUkDDE2HHoQ4xFaO1UjmVX7GxKPDZv4xwilY7Ag3tiLAsprDpM4+xltIrmzCbp2Hu9yMKC1dgKYpdF0kx9lIgaVpgd/QLwqa0bhy3oQrVLuwOLLjRiZP4I8QgR03vw54GmlrGKChZoLlj3IJ926Mnbwz779DW1MK8Tm7vjC+Y90lRxaFudEOHVhaa+r8OvhK8idiKqBfprp8DLapc++oPhR+MbieO2P5jwbINk+8YyZBl5QexlNZ9wlz9TM6+F4y4mOZOkZ7die+IKrS7fCqEmzShYIB8VKQK6sC3tX0ESjyaesw7/shjMBHn6E0iZLlbv7enhnmuwMLmtzzXSq0vr9iG1Ji1xYg=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(376002)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(6666004)(47076005)(8676002)(82310400005)(86362001)(70206006)(36756003)(1076003)(336012)(40480700001)(4326008)(81166007)(36860700001)(426003)(40460700003)(54906003)(70586007)(26005)(478600001)(110136005)(15650500001)(5660300002)(316002)(6636002)(2906002)(4744005)(7416002)(356005)(83380400001)(2616005)(186003)(7696005)(8936002)(41300700001)(82740400003)(32563001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 13:18:30.4344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c09f1f6-0947-4549-1527-08da958a73b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7565
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series saves and restores the ASPM L1SS capability registers
during suspend/resume cycle of the system.
First patch refactors the existing L1SS register programming code to
take out the common code.
Second patch adds support to save and restore of the L1SS registers using
the common code extracted in the first patch to restore the registers.

This patch is verified on Tegra194 and Tegra234 platforms.

Vidya Sagar (2):
  PCI/ASPM: Refactor ASPM L1SS control register programming
  PCI/ASPM: Save/restore L1SS Capability for suspend/resume

 drivers/pci/pci.c       |   7 +++
 drivers/pci/pci.h       |   4 ++
 drivers/pci/pcie/aspm.c | 106 +++++++++++++++++++++++++++-------------
 3 files changed, 83 insertions(+), 34 deletions(-)

-- 
2.17.1

