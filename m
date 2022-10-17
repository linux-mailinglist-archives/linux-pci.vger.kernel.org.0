Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF60A6008E0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Oct 2022 10:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbiJQIke (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Oct 2022 04:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiJQIk3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Oct 2022 04:40:29 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69D8F5B1;
        Mon, 17 Oct 2022 01:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ud5YrjvHhNZ9w9aH1PeMNKNZryBuscL4gaQxXWQJfC9ZSIlGrfs61KhrdKvR3mCe4AM6f+3BkaVgdEBcQ8rbYlPC4dnkdTDIny6HplMzqUhSIKURANvgyVRP5aAnhl3gVkIoIz4IxVr8uOxY2oU+Rw8yStYNShT0FJEJ7JOMYQvYoXHWOJKjp/aV2NrZbpfnkNLnm0pNpFX4VBy5cKM9n3JB1cGZM0hNqJ3AWf5v4P06H0F1//sgvlvzFPl1cNkcd+FRPMc/gGYxLk3pEoBN0o4dR181i96HZHt5snS5tFpO/cHj1/sDQf9gWir/QwssOD4GNIy+nbPYUrBZ7pdz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dt4gWUmXrVtc6TrIo7l1gVaD3l/okHMzidHdEsWR7z4=;
 b=YbpZkslcmsDZNodbSJYd1/cf+kS68PAqOBKgYFl35GDlmKALY4+yLAnqDKQOA3cHqi2p4JCvm3sv/96/42UiqavoQVgR9djLjzkkcBsuQaLuuBNJSHOfw3rhea4eevwjWVo2QZm+6bZOul2yXxmD3vDY3+IzJ0LEsuivTIu1jKcv8i/XBVVLu0hT2OcN8pPcM0GS5SW3tnl2ps/2hP7lMOgDYbKM+Yn4Mty6bK+e8q/vzg63Dm2I1pOg/o06N2Kr21v+NY6U6p/t5DXXV8nCs/0VS+cUPjiXv4pJnNv5XWeWZ+azVaLJ7l13LYKttzy5IYgnX95pDxdWAX01/qlIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dt4gWUmXrVtc6TrIo7l1gVaD3l/okHMzidHdEsWR7z4=;
 b=kvR300glS6nDvJ5phAuqu6+Lh0GaEo5Dv3aChw+NIx6N2j7wTHo44k+Oufz1/k+K7khmj/gwsBYkdXHLbeL4uAid41R+8KZfQm5ZBNWSB+ycJ8/Ccrr6Te52Vso0oJepn6J6jWkCp7XkHnGH0TiUvhrzdUW8B7hnMUKxHISAVLq3WL2PN0szmtOrkiCBdPO2sNR02/USPaGvW5FId8yBbUWF4+K7PecBjQb2McN/KP4v9dAumCG7U6tENFpgttFnuTH8yu4P4ERiRimDcxsrjpPFg1Nq3uhgLbMJoQ/5M2KFrbyL6/rehGJ1juQKXzuW1t+qgFZeYWK64K5Hvjg1Pg==
Received: from BN9PR03CA0047.namprd03.prod.outlook.com (2603:10b6:408:fb::22)
 by SJ1PR12MB6169.namprd12.prod.outlook.com (2603:10b6:a03:45c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Mon, 17 Oct
 2022 08:40:25 +0000
Received: from BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::e8) by BN9PR03CA0047.outlook.office365.com
 (2603:10b6:408:fb::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.31 via Frontend
 Transport; Mon, 17 Oct 2022 08:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN8NAM11FT019.mail.protection.outlook.com (10.13.176.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Mon, 17 Oct 2022 08:40:24 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 17 Oct
 2022 01:40:11 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Mon, 17 Oct 2022 01:40:10 -0700
Received: from moonraker.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 17 Oct 2022 01:40:09 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH] Revert "PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro"
Date:   Mon, 17 Oct 2022 09:40:06 +0100
Message-ID: <20221017084006.11770-1-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT019:EE_|SJ1PR12MB6169:EE_
X-MS-Office365-Filtering-Correlation-Id: 58e6c2d6-0fad-4b54-963c-08dab01b3c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdZwno51Loxb4/3fBzc2p+nFa7B/TyYctcb6td1jPxyYG1ktSYRhT1eiMnYliEfKvuxncgQyZlDDkPprNrZDSz6pdCJ1v/xt5L2qws0RYf1olaB2qDsGUhaBU60aui/R+nTInxml17bXYp0NyyNQ/6oAcD/QksvcqIsBSoN1lzJMYaIAElykPQeOvfxJjm37dv9eOMp3+6p+QF9fWsf4SNw+5PouTek4nt6x6Kl4GmFBYkvA6EPhbW1pi+3HKn/BrLogKnwBFeWgKe6p3ikxc6+oKUzKfPDHgfwhQ9xmDxl0fsyAbugM/NY1qGjO1fgoLvpLdi1599szNB2e1EzYOMgPO6iCJ2OKmCKFpKHGWNaCRPVY4bGNvdDOXD0YR5MpqnCx535Z3hil4mE/UF8eM0+Q4HbbwQKb97RxnOTfhbsUPdDjRMaBVstaV4V/FRB1q5KgY8qlrf6cKFqjM7pwxFJw5mzAW/FIw2q0G/F2o5hTF5b/A+7k9SWOCX9q7OTYeKsQ9BAUQjTXjZnBZuNEpfLUbSrqumXoefv9IiDTHXLIsr/sdG4ElzueAgPLtRj+sJPH48sB62DcNAee5w/DuLOujtRseC7nHKoEpyX4gNwm5KSHYfqv2+oy2Bxsxt/5LIM5YyH8/UxGHunZlX1DE+E+HFaTodxERwGXaKEzPL/VEkO72TrE1D+666OPOZOMACOp1aZgIl8fkw5AGSZAjwcAvExdQKOALixJXZ4hdW7xbJ1d5IUX7JiBw5TFS0H3lDwWqEg3sOdiQKHf+Vmzwg==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(36756003)(36860700001)(40480700001)(7636003)(40460700003)(356005)(82740400003)(86362001)(8676002)(4326008)(70206006)(70586007)(110136005)(54906003)(316002)(41300700001)(5660300002)(8936002)(336012)(47076005)(426003)(2616005)(186003)(26005)(1076003)(478600001)(83380400001)(82310400005)(2906002)(107886003)(6666004)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 08:40:24.5131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58e6c2d6-0fad-4b54-963c-08dab01b3c36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6169
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This reverts commit 8bb7ff12a91429eb76e093b517ae810b146448fe.

Commit 8bb7ff12a914 ("PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro")
updated the Tegra PCI driver to use the macro PCI_CONF1_EXT_ADDRESS()
instead of a local function in the Tegra PCI driver. This is breaking
PCI for some Tegra platforms because, when calculating the offset value,
the mask applied to the lower 8-bits changed from 0xff to 0xfc. For now,
fix this by reverting this commit.

Fixes: 8bb7ff12a914 ("PCI: tegra: Use PCI_CONF1_EXT_ADDRESS() macro")
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/pci/controller/pci-tegra.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 24478ae5a345..8e323e93be91 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -415,6 +415,13 @@ static inline u32 pads_readl(struct tegra_pcie *pcie, unsigned long offset)
  * address (access to which generates correct config transaction) falls in
  * this 4 KiB region.
  */
+static unsigned int tegra_pcie_conf_offset(u8 bus, unsigned int devfn,
+					   unsigned int where)
+{
+	return ((where & 0xf00) << 16) | (bus << 16) | (PCI_SLOT(devfn) << 11) |
+	       (PCI_FUNC(devfn) << 8) | (where & 0xff);
+}
+
 static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 					unsigned int devfn,
 					int where)
@@ -436,9 +443,7 @@ static void __iomem *tegra_pcie_map_bus(struct pci_bus *bus,
 		unsigned int offset;
 		u32 base;
 
-		offset = PCI_CONF1_EXT_ADDRESS(bus->number, PCI_SLOT(devfn),
-					       PCI_FUNC(devfn), where) &
-			 ~PCI_CONF1_ENABLE;
+		offset = tegra_pcie_conf_offset(bus->number, devfn, where);
 
 		/* move 4 KiB window to offset within the FPCI region */
 		base = 0xfe100000 + ((offset & ~(SZ_4K - 1)) >> 8);
-- 
2.25.1

