Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABC513928D2
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 09:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhE0HsP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 03:48:15 -0400
Received: from mail-mw2nam10on2079.outbound.protection.outlook.com ([40.107.94.79]:63201
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234594AbhE0HsO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 03:48:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPuQwdWNtftdlMNtTah7xv7fl5uaHYqIxHQWagBYzlQEL2zBHoXTGsT74gW/CNwgzseOapUydAavrYxBYIqubN7HiPRA8ALLZxdxBzaLFkBeC3g1TvsNZxRJ6+gyf2x74uySEfXcBUXysG3rjLVp71HibrX075s4YxiydtSZtcmilu5qFbliFxj5XVWIZw40eNOj2DDu30vLK2vyftGf4oTnHHmgooDLIzR1dam+HRYL18nqNAw9x2VClh7l/59HIIkEN8+HXuBL1fir9p36VQ4S2MDHmMT6oCvfNFg6p+TA6wW/j/M7+d1wl2Z1NnTU7Axq6aqwz7UkS8G2KZRr4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1GK2JWWrQSWRsqdJXF260JrFBq7qIyGNr5crXTQ3Kg=;
 b=ZvA/rqIQRFWTUeZNJK9AQCdMb/uTwV4ZfCapeVGGEZUIPeGtH661Ilq+yqsJoP5ww1xr9+iBkNk7ibpef0gNBlFFW5ireyeI4uu/5PBLvdQwvszwcL+6rTI1Wb7vDn+lm+vLpWi3YVc3GvvT8hyk682JFbgfJ2ILGEpQ1eSbJZqS4JmHFllNgWpHjy6WwdL94t1EnHQAJilk/hma0WF9sMOD2Gf5+so+jc9u5/g+SHsb2naysFAk/ScHWltyn2xuWPKGQkm8XFXCu9ucQ9V8SC55S7nA4W94GN3ssy5nrfyBzS6KRhxzT5KE2zTGBrowSPgATxnIMUgdSD3NSX/EYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1GK2JWWrQSWRsqdJXF260JrFBq7qIyGNr5crXTQ3Kg=;
 b=fOvaVGIslr5I9xN3Vk/Mkufwc1UPseQYdi1pj4RcXpMP7LZs0sy/Hb3twXCFAtppth6RtxZEMxC+6c7e9X+Zh9I2PNbxDAeHnOfIFAG5QdNsxYA2U2IIDVtCnM0Y7wmqfQrcOS/LuB0K1cgJH6InPn7mRrPJEPbd8qckHlXGZ+qOndCvQEiU9kyJnSQpAB2ZQ1nyKK831W9u5tdXIkiSDWYacKD0Y35XKvZDqJ59jb5Ln47gUQaKU3yXOwTlNJ+JluaSlOUyom74gBkdi8R/U240xfDAdULIT6UXmCnk8/dTAsCrcmqHKjeshEGb2JV4GDtvPG2xjG9Z6oooUtHhww==
Received: from BN6PR1401CA0007.namprd14.prod.outlook.com
 (2603:10b6:405:4b::17) by PH0PR12MB5499.namprd12.prod.outlook.com
 (2603:10b6:510:d5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 07:46:40 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::7d) by BN6PR1401CA0007.outlook.office365.com
 (2603:10b6:405:4b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Thu, 27 May 2021 07:46:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Thu, 27 May 2021 07:46:39 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 00:46:39 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 May
 2021 07:46:38 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.145.6) by
 mail.nvidia.com (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Thu, 27 May 2021 00:46:35 -0700
From:   Om Prakash Singh <omp@nvidia.com>
To:     <vidyas@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <bhelgaas@google.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH] PCI: tegra: Cleanup unused code
Date:   Thu, 27 May 2021 13:16:09 +0530
Message-ID: <20210527074614.49149-3-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210527074614.49149-1-omp@nvidia.com>
References: <20210527074614.49149-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fde59758-ed55-4a36-ef88-08d920e39048
X-MS-TrafficTypeDiagnostic: PH0PR12MB5499:
X-Microsoft-Antispam-PRVS: <PH0PR12MB5499C7ED19DA7A7A0214F192DA239@PH0PR12MB5499.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FXw0hioQaSWTz3MdS7+PdYuVfgfpGagHjQdwzHJPzyyROWDMoZvu1CMniFFMJ/9TIczBJplMs6l7Mnkq9qCTadzc9rbm665QmTBWyTCmNylrY7cGNn+CuTdn67Qx9piKT3ThNUM4f8liqVx+nWiwzSxWQGOfztBwKkbGHPnWKIyOoZvLnXLg/L7/xi6/7mJF0o2wIC8S3EtBX/ifS22MqAzE6BX011N/0qIV21UL+cUly5t+3ZODw1B/bhcOE5B6rf7611f7QEPDdrAgaj6pBI0tp4VyOz+ljrGcG7tTrKUCsUGJYxpY0oQDqhI3X58lGt84ZnJKy3oQtv3HyfU3gS8dwxi32WjZqI8/9idZ2SxyTUKdqEQApwgtg7F4MZJXr+/f3Fk66k9ERVL78RyKKTh8F1HMJ1osDWbGzYCZGsivKAYaMf3Qa7kQSM2NDHWBZu5pMekZV5jWw8/zj98HztsWMVpDI4JIJTWc4wKKEqUy3bkkWDzfc4ZAz3q7XM0Wab39nqXr08CKVNzOgnOzWm4V0T6v3d4d03GvGU4EwXz+hwQ+kBT4jJ2a1wnPaerBOyG7DiG7qhncYYD0IpcBHsF7EAcd8jJDzRWJgZyxH9LcO+PLWBiMM2dykwNnqfDGFCJ84NHYcJgDct6948F1EfePDzDtZqDR0aav1upDNAs=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(46966006)(36840700001)(82740400003)(426003)(336012)(2616005)(86362001)(70586007)(6666004)(4744005)(186003)(356005)(82310400003)(7696005)(7636003)(1076003)(54906003)(5660300002)(110136005)(36860700001)(47076005)(316002)(107886003)(26005)(4326008)(2906002)(8936002)(8676002)(6636002)(70206006)(36756003)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 07:46:39.8180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fde59758-ed55-4a36-ef88-08d920e39048
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5499
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unused code from function tegra_pcie_config_ep.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93c89f2084a7..096aa5306fda 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2045,13 +2045,6 @@ static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 		return ret;
 	}
 
-	name = devm_kasprintf(dev, GFP_KERNEL, "tegra_pcie_%u_ep_work",
-			      pcie->cid);
-	if (!name) {
-		dev_err(dev, "Failed to create PCIe EP work thread string\n");
-		return -ENOMEM;
-	}
-
 	pm_runtime_enable(dev);
 
 	ret = dw_pcie_ep_init(ep);
-- 
2.17.1

