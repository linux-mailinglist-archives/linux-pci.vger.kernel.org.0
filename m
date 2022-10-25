Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024CF60C410
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 08:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiJYGxO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 02:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiJYGxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 02:53:11 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2052.outbound.protection.outlook.com [40.107.212.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063BD43323;
        Mon, 24 Oct 2022 23:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IqHrqWupdgZ/TnxflcZdQMc0WxIaoeO21TwG/ejd6NzxxUYMipx/8AagLhYCdGhRyBdIJoPsKdz+661NhX7YCED9dr0P79j2MgBJOAzfsNgpNdBUXwzhNWgbkfXWF7nD6dScw4dULGE9swmUiDtuGXBstYRMfPOVWLbJZfT2EJkv51YKY+4l90fLHBDeRLITM2Bem75Q/WSu27gRyRPgiCVBSasVpBB+h5sfq5dhdALHnoFWxIMaZr5OcC1d86NxCeIjelY2jtHvXGXaGKETdzpiv5d4vuZfWLVCgWuRrZr30B9bqVJ09cW1/xWSzz6BY64bcyMnnfJqXOH5+WlYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3W+4MPc5n6RdCbQDePmn1uWM4TgWoEY5+Ukz/RNbSVw=;
 b=jqSM2naIAskIXlBhAmRDeyYrW0a2EtHbwmNUcFBulliFlz+RdrZq9y5qCdwu0N0/dUNu/UytHZk0KjcQ643Fw5lOStyl0HoE96ZIrODt+UaS24XvJv5qxiGY2ha34etHCD2Z15r86KGOAF9gMMcD4lSX33rxRztYGl43sDhiENz54jiItuKF2qzkd8g3MzAQEMUASzzPTVy0e3wzx968L3wymNxAkYaQrlrAaNx99AkcD7QH5rNJJBYxNzQBIpMHBN8M9Ue/4R9TsQA3kee1Zh24bSecJCWAcsN7Dro4HroVW+orrXItrsKyTgax3y7k9mqlH3M3YgRCo4dKUQtxFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3W+4MPc5n6RdCbQDePmn1uWM4TgWoEY5+Ukz/RNbSVw=;
 b=ek7ZOX48pcddHFrnWOpGzlVA04ylKn+LGMyDzxzXs7j850FswBSTasfDogj3MiUwNHcQuvIyBeUEvUMeOKsaf31CFaFJrRKYkqioDK9iYOrJd9ZHCv2vwdEH26jRK8JjuxcyKb2LrQW9FQt4V/nHkRPfjPcWEw1b23UQ79cR88k=
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 PH0PR12MB5606.namprd12.prod.outlook.com (2603:10b6:510:141::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Tue, 25 Oct
 2022 06:53:05 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::1e) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.8 via Frontend
 Transport; Tue, 25 Oct 2022 06:53:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Tue, 25 Oct 2022 06:53:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 25 Oct
 2022 01:53:04 -0500
Received: from xhdbharatku40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Tue, 25 Oct 2022 01:53:01 -0500
From:   Thippeswamy Havalige <thippeswamy.havalige@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski@linaro.org>
CC:     <bhelgaas@google.com>, <michals@xilinx.com>, <robh+dt@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <bharat.kumar.gogada@amd.com>,
        "Thippeswamy Havalige" <thippeswamy.havalige@amd.com>
Subject: [PATCH 02/13] microblaze/PCI: Remove Null PCI config access unused functions
Date:   Tue, 25 Oct 2022 12:22:03 +0530
Message-ID: <20221025065214.4663-3-thippeswamy.havalige@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
References: <20221025065214.4663-1-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|PH0PR12MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: a064805e-01b9-43d6-1794-08dab6559152
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rHgOq6UuPUvFF5qX6dnpHgZimNvhE7easo+B+o9DPIa7nel4RfMpcnYI4Eo291LT3IVcek3os30rAYFLpd7ZdaBi6IhBUCp1OwVx6YbT69NmYNI6daNPKSslqaJu7OFv420teKmm39selypYJzkugsJdph/0nOdXkhUxgeQxWaIT82VfOJWPxMpHYewassnkwDu4Q5b7819WTyBx1QSF/ychFQeqd8QBARJiIUGO+CbybuXh7m7AC95apOW5+tOcjs3Lipe5lBhAWbAEbi9kd9toFFklMlXT3CSltkTBfPrDllt6J8diDHYM+sacpPrQTgQRuocH7WA12v1ouAZXFidyzkLcWN+0sR9z39G3hyXhp8hdNrIUMIJabpZ2Yx3uLWt9mhuQsPxrAYR0b/iFOdLivJ9DOBEA4p4DLKzhz3Wsrki4WCmzswIDzz4MjN5LxVrcmgbJkKHwZsZWd2co4lJhl0XT7LsjFZWPf2G9S0qUeKsGYFL0wIqwuCtkqBtWUeEdR3c4LQEX/hBdwxBTVQLx9Cxxd4O6WW9wM46KcSfvnG+Ql/5/AduAEYkSA8LgPKCtBMMDnI5Sl24z9HjI8RWz1/7yLUm3sqqeawp/nLISseiTQRYOj9uM++umLbDgoyzzYfD5q8aaKvO429gseFzm4QFUYZH9bikoWTEKthCaxwXLN/2Q36FfZuVx1tvCcVXhIt73lYQh2E9Ws5QUJH2i1Lk6igYG1bf1qf59hmUgWmUNX7kpgiwxe4PaQGeDSm4QLCCahZOOfW3BW4WpH7hfN+FD9mCWpJy9mHR7Y7XcUcy0B9HZOHuoST/E0mYC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(86362001)(70586007)(110136005)(8676002)(70206006)(4326008)(316002)(40460700003)(54906003)(44832011)(36756003)(5660300002)(8936002)(41300700001)(47076005)(81166007)(82740400003)(40480700001)(36860700001)(26005)(356005)(82310400005)(478600001)(426003)(336012)(83380400001)(186003)(2616005)(1076003)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 06:53:05.2116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a064805e-01b9-43d6-1794-08dab6559152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5606
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused NULL_PCI_OP config access functions, for the case when
we can't find a hose.

Remove unused EARLY_PCI_OP and other declarations.

Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
---
 arch/microblaze/pci/pci-common.c | 64 ----------------------------------------
 1 file changed, 64 deletions(-)

diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 69ce51c..58397cf 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -996,67 +996,3 @@ long sys_pciconfig_iobase(long which, unsigned long bus, unsigned long devfn)
 
 	return result;
 }
-
-/*
- * Null PCI config access functions, for the case when we can't
- * find a hose.
- */
-#define NULL_PCI_OP(rw, size, type)					\
-static int								\
-null_##rw##_config_##size(struct pci_dev *dev, int offset, type val)	\
-{									\
-	return PCIBIOS_DEVICE_NOT_FOUND;				\
-}
-
-static int
-null_read_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		 int len, u32 *val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-static int
-null_write_config(struct pci_bus *bus, unsigned int devfn, int offset,
-		  int len, u32 val)
-{
-	return PCIBIOS_DEVICE_NOT_FOUND;
-}
-
-static struct pci_ops null_pci_ops = {
-	.read = null_read_config,
-	.write = null_write_config,
-};
-
-/*
- * These functions are used early on before PCI scanning is done
- * and all of the pci_dev and pci_bus structures have been created.
- */
-static struct pci_bus *
-fake_pci_bus(struct pci_controller *hose, int busnr)
-{
-	static struct pci_bus bus;
-
-	if (!hose)
-		pr_err("Can't find hose for PCI bus %d!\n", busnr);
-
-	bus.number = busnr;
-	bus.sysdata = hose;
-	bus.ops = hose ? hose->ops : &null_pci_ops;
-	return &bus;
-}
-
-#define EARLY_PCI_OP(rw, size, type)					\
-int early_##rw##_config_##size(struct pci_controller *hose, int bus,	\
-			       int devfn, int offset, type value)	\
-{									\
-	return pci_bus_##rw##_config_##size(fake_pci_bus(hose, bus),	\
-					    devfn, offset, value);	\
-}
-
-EARLY_PCI_OP(read, byte, u8 *)
-EARLY_PCI_OP(read, word, u16 *)
-EARLY_PCI_OP(read, dword, u32 *)
-EARLY_PCI_OP(write, byte, u8)
-EARLY_PCI_OP(write, word, u16)
-EARLY_PCI_OP(write, dword, u32)
-
-- 
1.8.3.1

