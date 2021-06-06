Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2460F39CE09
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 10:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbhFFIYU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 04:24:20 -0400
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:12896
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230193AbhFFIYT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 04:24:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aE/CvRWuSKtDr4zBFiVnVxif280qZNd6PmGm4GS2JsDKyVlVz8dK1MLSlDrrCniDnXGyzsjUunt4oxbu6uaLzUTqJfhzlDArppD0RpYo5xo9LgErhnjCSHC/5qj8UFlDnh+pwUXb7pVNJ9tXqAdYcOZYwvh4Dh1sAkpzuB8qxWGmiwl1O4ylOh6MY3mxYqaF9446Vx68jZMOJQAPo1tj7vQGrvMn0DwxZzPR/iy7ogCslAUda0F6Jqbpz9zuNxMK4vEtGSG1uwFFrbhmT+MaXbcM53hYfTZrDApzvILQZhCuFXqpsL7qLvuDn4qorCtSHPg7CkJZjvauOieygfeLMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAD7x2U4YoA6uO9axRlM/TrtprWr7bRT/wwzuH45sbg=;
 b=AZIwp/q4+r7gN2Ir2Qy7WAC4dSRfDRDQBnYO/WF5VPBMvSCewxmODOkEKonHaxBjIL3sttI+BQs8cxi1U9VrSSHSy0ZDS3LGu2bTBY+8u67uDbIg1b54/gMPVM9L+oHRnBaypkQReQ30ErGeVtJ3rJ3ZqQb5fDqG+w9ZLoHxtv4RscfOtpFX9wzWtaSoa2igX0RVoyfPiYL328nf90YZp6MsV4FTuLLHyRSmoGSMENBUH/2pC9Z3mU6JrpaKvf0hb5Te0dkwHkInNiwJZbYBRg5m6yx7Wa7Ta2Q4o8xiEs4xyvgQZ3jcnDqA5OV5AJyJ2oXxvFyyrfyJFTbT8GroDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAD7x2U4YoA6uO9axRlM/TrtprWr7bRT/wwzuH45sbg=;
 b=qiOckdITCK0do/FhLX6D94ABM+FXHWzOuQbIpHyqTGTH+dwWZwJ5TDfuNtnS8wfA1Ps0okWxTYatpXlTW0yU7h8sDbUSzFtjCQpf1Fx39+fTU9kXd+9yfmPZj42BMR7v611QL8jA351ytJIiInTFBHBpT3WqCI+rKZ4eSzV2MPgITstAf5Q19F7ebvRiG936LLxJNZKAEN2oyHEU4X974pPf/Urq/p8iUwgdZh1/X03EgHXSF/eVjbwQklQRmbk0yaDs7v4eNTxbTlO2bwS1I+ctsaoQFO6QriH4GuFZgqSHeg6C2Cct18e55RVUlGG9PSALJm4jYN9WnA2eMfhmMQ==
Received: from BN9PR03CA0063.namprd03.prod.outlook.com (2603:10b6:408:fc::8)
 by BN6PR1201MB0243.namprd12.prod.outlook.com (2603:10b6:405:50::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Sun, 6 Jun
 2021 08:22:27 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::16) by BN9PR03CA0063.outlook.office365.com
 (2603:10b6:408:fc::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.22 via Frontend
 Transport; Sun, 6 Jun 2021 08:22:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Sun, 6 Jun 2021 08:22:26 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 6 Jun
 2021 08:22:26 +0000
Received: from buildserver-hdc-comms.nvidia.com (172.20.187.5) by
 mail.nvidia.com (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Sun, 6 Jun 2021 08:22:22 +0000
From:   Om Prakash Singh <omp@nvidia.com>
To:     <kw@linux.com>, <helgaas@kernel.org>, <vidyas@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, Om Prakash Singh <omp@nvidia.com>
Subject: [PATCH V2 2/5] PCI: tegra: Fix MSI-X programming
Date:   Sun, 6 Jun 2021 13:52:01 +0530
Message-ID: <20210606082204.14222-3-omp@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210606082204.14222-1-omp@nvidia.com>
References: <20210606082204.14222-1-omp@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d34176c4-0ffd-4bcc-23e3-08d928c4382a
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0243:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0243F066D8598EF808C52277DA399@BN6PR1201MB0243.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:372;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JX7ujdHGHuCA8Bkjobp+zcIoVRmyN4XAfYXjcxAW7Vx8p867IUOcwng6+39G6hlBlcDLW0D3zDhxCU4Vwg0/7N6n1iT2CtevnfyRCZnrPyA/xhcg9JCJ0V7VmXinVw4zO3bhZmyGtpUqSPzuxu9gXtBQWsKtgzaNOeWUUTpgbkxIDvz68/dFhW8pJvN85WeaDxAcUOS9RcbsA9cTOiDo2qSZgi98GRzi/sHdCmOo0wsM+w62uQ+CUDk1buw3FLnjxlNqBaCR5wrQP+yzg797xpmCtSQ7UNI/TJxtgk2xml9PsLDdlhP3Q6or5Uw17roiXQ/IgWs3ytlBzFPaBsfJqmdI0rOOiNGK+Rty+OKHHi5QWnG6T+Bqvs5yteVv4Jd6E9EE6LA0K9cMcrDqMmEFIBeUXjETjNG/EdhUTpEbfvikd17obau/XuCduucb+aV+qeQhZVPxGdvNZ+fOjpX+zhJvM9Tz2D/aHMhKt32BaIjzDpCQ/vzZpRuwRXLsw24I8H2tkxW9hPTn3FwU43sPUoQh5g8MytDHzluDmE/e065JSuhoFphcEdeM15NxVVerVsuLlWLOGBZSEzyqP6CFMNClktVvgvz7elHtJ61VWcWB9dp+Kbzj7D1nFe3sQ1KUTwSUyge8lyVEUZGX/gdHPA67W+Sfyjm+oxwMiWn4J3c=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(186003)(356005)(70206006)(82310400003)(54906003)(316002)(4326008)(1076003)(8676002)(8936002)(6666004)(426003)(36906005)(26005)(83380400001)(110136005)(47076005)(7636003)(86362001)(70586007)(36756003)(82740400003)(5660300002)(36860700001)(7696005)(478600001)(6636002)(107886003)(2616005)(2906002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2021 08:22:26.8943
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d34176c4-0ffd-4bcc-23e3-08d928c4382a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0243
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lower order MSI-X address is programmed in MSIX_ADDR_MATCH_HIGH_OFF
DBI register instead of higher order address. This patch fixes this
programming mistake.

Signed-off-by: Om Prakash Singh <omp@nvidia.com>
---

Changes in V2:
	- No change

 drivers/pci/controller/dwc/pcie-tegra194.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 6f388523bffe..66e00b276cd3 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1863,7 +1863,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
 	val |= MSIX_ADDR_MATCH_LOW_OFF_EN;
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_LOW_OFF, val);
-	val = (lower_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
+	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
 	ret = dw_pcie_ep_init_complete(ep);
-- 
2.17.1

