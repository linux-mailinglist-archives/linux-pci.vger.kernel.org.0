Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AEB058A859
	for <lists+linux-pci@lfdr.de>; Fri,  5 Aug 2022 10:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiHEI5E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Aug 2022 04:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbiHEI5D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Aug 2022 04:57:03 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A174E0D
        for <linux-pci@vger.kernel.org>; Fri,  5 Aug 2022 01:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxRJiyYuRZhBoVgy+IrHml4Jvu74a6Fw9Trh9wqiIdjjYnDsHMcnjnxENN38tAtwOY6p95ZiBaMaRFNh7mqm/yKv1gDnEwSxYlAtj6SJQYHPwd/IersN72YhuioP0qqTbpCqXxrP/uFMDblrbshA1IW+v96PlTkfUqXgViF7ehyFh7cMLtCzjiLu1jEM3DQ5Pq2CiPgEzNJz8V/myNbauZRFlSehXXSQqGHR4qSvNIoCfUoccbKVn62Xw/vnxe9xF7epq6rdWSn0+fTqqmXrNIIH4ofCEZPI9tzPdiCwPWfiyeCErHv5BkG56/eA1gs6zgXqDEObT+mvCs8dnASE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7HF4AVKI+QIXTLWKn2o55wSPveVNejNl2ZkAL+pU0Q=;
 b=DTq/6eMFWE6Ek+cMAPFLmRiuaRx1QRYjDLLcxnJH3ThZDeue5Jrxw7K5mpid15SK9OExFIOZdrvgi8m5xxOLUN9H3aQc4vnL6O5auPPQo0HoGS4fbN04tpdVOPwWRIKHlJK2JW25JDIVCcPYKS38qZLRe3BxVQ+KlMDSGBMvl4EbMjdy/mdgwAyLn5r3L6EKOgYKPoM3LjAJABixn8MG4j2ptWlzFQNZoBRIjXCzmWdwEkpdlgqtiykqThxO2+FZRSn2zysje7A27PR8vs9ez1du2ZB5oLibxwNASTA4sYXJMTZ2mtLu0L067z+pSZK639xJjOXypAzCu22Q7UNp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7HF4AVKI+QIXTLWKn2o55wSPveVNejNl2ZkAL+pU0Q=;
 b=1hli6CoBgnNvCgjs+PBGg5LgGvD3bg24DpZRnVigPwo10DLvtCa83m9Ug1UGaa9Gp9a8INGrkwiC/D3RZwmUcbZARu+0YdZtU1sFYdfsjCLCMTN8nFu/zQ5RNALj6y5NcbByAPBr3j2To4/eRVu6p41AcZkrEJJNza+DQe7VhmI=
Received: from DM5PR07CA0087.namprd07.prod.outlook.com (2603:10b6:4:ae::16) by
 BY5PR12MB3732.namprd12.prod.outlook.com (2603:10b6:a03:196::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 08:56:59 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::31) by DM5PR07CA0087.outlook.office365.com
 (2603:10b6:4:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16 via Frontend
 Transport; Fri, 5 Aug 2022 08:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 08:56:59 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 03:56:57 -0500
From:   Yang Wang <KevinYang.Wang@amd.com>
To:     <linux-pci@vger.kernel.org>
CC:     <bhelgaas@google.com>, Yang Wang <KevinYang.Wang@amd.com>
Subject: [PATCH] PCI/IOV: export pci_vf_drivers_autoprobe() symbol
Date:   Fri, 5 Aug 2022 16:56:39 +0800
Message-ID: <20220805085639.1629653-1-KevinYang.Wang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd764bec-c364-4352-f229-08da76c074d1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3732:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W2O6ih6GlwvIRpoR5+lqyLCixn2yFZ8giap48rf4byKVUQ67mAjSm7n8hl/MfMn55JqLasiKNQ7qCCw93xdCRHv2eBjIEV4N/sdX7nK2wFpVm9foo7RrYFHde2ADGM2Xq3nc7b+7+aw5AXTRwf2a56OAKmBZTWUsq7hqkV/TeuJtSwop+sQDu8r3zDq2CkUqiRXoh7rsiAROCcv2c8zJHQZKr3xfaZdHGgxGlXTIYTxvECySJ/My8Tk0Igvf8Ut2XMleS5ZWxJs6Zi6gvqQLR4fgjbHfVkjwO1lwjdZT6U4rKxabgURIYDWkFKLP+m50fVqgnio1g06K535RhQH1fHhMcYPQk+HBw93oI/QGwV3mi6U7RbU+s79B4Aof/6TIz1ENE+BO/qvZmeOWsQgrmRM5NPZbnW2m259pe7TocVqlShP3/RPoTuN5T0289gmBUNCLeDCvicEe5BuRZsIlF4YzRV40Ln6XcinPmMedFZI88NtYNEXGDCZhKE3DB1k6G38OyNAA4OybK1J5yB2Vmq0FPNkU2nlA/iGMM3D+jLiWaGjY0Hfud4+AZxfUF2TUiJFMdThec8fhot1R2+HlsmunVKNsEXQrptw1TKpcsseUa/dhGP2fVd8x2Qbhajxj89kqFLOqgm97K57Y4q0dZJkvx8eFL5H548hVdthZGHqGyuXOtDJ4mHkG6SzWLP50OMuz+7XOUHN8oOgm/aKulq0dk4kyn+BVivxBNPiiUYsQs9UTD5Zh0xJQaRDiloyYT72Z1Z+3tdVE8I9/6nWGIprD22pCILyRgtEXe6lYkDncBTC40Rjjd54yvmFHXwusFouDoT3ALPLwuI0VUS12Ig==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(396003)(39860400002)(40470700004)(36840700001)(46966006)(70206006)(4744005)(4326008)(36756003)(70586007)(36860700001)(82310400005)(8676002)(316002)(478600001)(6916009)(54906003)(1076003)(16526019)(2616005)(26005)(336012)(47076005)(41300700001)(6666004)(2906002)(7696005)(186003)(8936002)(82740400003)(356005)(426003)(5660300002)(40480700001)(40460700003)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 08:56:59.1123
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd764bec-c364-4352-f229-08da76c074d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3732
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

make pci_vf_drivers_autoprobe() as export symbol.

the external module have no way to control vf autoprobe flag
before pf driver call pci_enable_sriov().

Signed-off-by: Yang Wang <KevinYang.Wang@amd.com>
---
 drivers/pci/iov.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..4d992424959a 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -1033,6 +1033,8 @@ void pci_vf_drivers_autoprobe(struct pci_dev *dev, bool auto_probe)
 	if (dev->is_physfn)
 		dev->sriov->drivers_autoprobe = auto_probe;
 }
+EXPORT_SYMBOL_GPL(pci_vf_drivers_autoprobe);
+
 
 /**
  * pci_iov_bus_range - find bus range used by Virtual Function
-- 
2.25.1

