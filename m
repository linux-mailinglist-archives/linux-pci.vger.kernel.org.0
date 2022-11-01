Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE12D614218
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 01:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiKAAIX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 20:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKAAIW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 20:08:22 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE157255;
        Mon, 31 Oct 2022 17:08:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBF5ZVO3Nb/h/tQH2RBkD+7wqMYnH5NRobWsTUrIC1QGlJCa77fIjkrD9OiLnrdX1LRKygInrfP1f0QR4e7txsCyGjefmO6TJspAF/szzE6x6jp9DaJ5wcQ0ZgpcX+Ufz/GlJMj1s6ZIgajLFFrRwrbpcOb/U6Y4b6PnFwtmVn9nsjK/yYej6I4EpBmhaUe5dN1mq2kno6WBP4q9t/B1Tw5AWqUfqFh4t33/0vygbpeeBlvE5Q3nr5K6bi5uADLySJiZuiAMKqwY9XameLAVEd0md1N+g5THChr1Cr5W9g5LUx2fqjStw4HtXYq3360XD5+LxEou/BGpABVxFxWXig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WA37ek520vaTk5XeBv6U8S8EVbELFmFxvIiKeXUV1c=;
 b=Z9/AOS5huwNqfWy+U13YrwhYnCdKWWWk/jq+gl4P4zYCTDKQ1bGRT92+9hxbK7+e9vsxvZ3iDz/Evi3fU+cjg5eB1Q0vIjnOHKhDzInqccroj6cGFYKb5onkIfRfu50PYiPF557/aVGJOKDPGNzyhNCR5lfeWQzdkAkbbX5RyikOrop5B57EWGhspvk1CbpeAyvmx/dmYGMV0XX4T3lQmBd2oX4rBRG+aJoZf3D0P2XKUxIDjmlpuVpwgSZqCZ2dM74xkg8Oq2ZCdhwwItBplB6UehkHqkTrOzkS/Piho/Uwfw50WZlqwMnGENDslkHucMDW5v5IUC22Wxecf2RsCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WA37ek520vaTk5XeBv6U8S8EVbELFmFxvIiKeXUV1c=;
 b=1hW5fPDUq7A69ch2LoQUIiPAWdpjRaT5zS7ye24ILJHhXZYSJCb86GCAqxyTsxaLaxoYLBz9Ej3GCQW4FaT4BHQlvMkK9kYCJijYfsDMcPHBnCQHIwk2QlzCpAObFyeMFBAetvpYCvo4OLyhcDeqI50Tvkoam8jIpFMPOanCaeU=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 00:08:19 +0000
Received: from CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::20) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 00:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT081.mail.protection.outlook.com (10.13.174.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.21 via Frontend Transport; Tue, 1 Nov 2022 00:08:18 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 19:08:14 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        "Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 0/2] PCI: pciehp: Add support for OS-First Hotplug
Date:   Tue, 1 Nov 2022 00:07:17 +0000
Message-ID: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT081:EE_|SA0PR12MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e30e502-1bef-4c06-ec5e-08dabb9d2e7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzNDpOSjUtitvWlPgaZThBRYDZds0ttbI/vSZ2RGpiKvOccMANKk7HCzsZoEe7P/minJLPSHKNlwoGWkcBL1ccdeIKaefOnPxK/tDdZu8rQ/5Oq8z+IaXWxEpCCeSo877gswX8kfB6RBbZfi/NgXUYqBbAVxoLiR5Tzgsh6wHHg9ZivecyozeQEI2qPvdJ6EEAG9D1r0qGkeXCg4ZqlaWg/S5RRrwJoshZnl1ufHIorWEnHaAnISA4UR9aKZomgHo3X3bSXkv9fumH5GDRfNfm9yrd/7bdwqaLUR5lpPj+QVDavkPPc75bHrshGgXcSnNJvEU4GSyJqbz+ojCb5jJPRghDfERBmHDZETyis7gQFnBDfejJCNKWFrY1Ls/pTlxbIsLAMCIp6FVMoZ53EfTJpWBvtVnmVUaQZEl+wK+tVcPc6y7w0Ug5gLigqjDZcubJ8/nmeXkTL6bw5T52teCmPF6BWd8LVYi+pXxr7RpkIPAGiPn4SJjSmuS+ymLqG8UlJqKlNYwGEGh2NZQFHJNpg2AYDzE+6kbIv5IckIhuBHCU34w3thHCf5gxMvtf//LJJwpLpMu0Da4LETt68kNcFEiVCBPCbpexUTuqmc07GXU57RQzJudJa5x15HosFeiBDOAnC7ub/ToBV35I2zP1vJatqs71tYt203JtdG76Y4SNXALWZ28gYCkvyuoLCljpAxRB205aCaC1bGQaxB2JW52f8SBImpU72+zZLICVmWE0r8JPZQua+eg5I3rcQk2e6BYZ+sFakUBkIOK49GJa7jz748KlQZTamWOtcftRg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(47076005)(426003)(40460700003)(2906002)(70586007)(4744005)(336012)(81166007)(356005)(36756003)(86362001)(40480700001)(82740400003)(82310400005)(186003)(2616005)(26005)(36860700001)(16526019)(1076003)(316002)(4326008)(5660300002)(8936002)(70206006)(41300700001)(8676002)(110136005)(7696005)(478600001)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 00:08:18.8801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e30e502-1bef-4c06-ec5e-08dabb9d2e7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds OS-First support to handle AER/DPC events
occurred as a side-effect on a hotplug event.

Smita Koralahalli (2):
  PCI: pciehp: Add support for OS-First Hotplug and AER/DPC
  PCI:pciehp: Clear 10-bit tags unconditionally on a hot-plug event

 drivers/pci/pcie/dpc.c        | 62 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h |  1 +
 2 files changed, 63 insertions(+)

-- 
2.17.1

