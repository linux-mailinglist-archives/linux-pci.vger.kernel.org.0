Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6857CD74
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiGUOXJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbiGUOWy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:54 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5AF8689B;
        Thu, 21 Jul 2022 07:22:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmuAChq5i4JD5zy4DfWGYefORN5k51VJghfVkYNH/Lwohl9UuFE67J8G9nYpWqConA0L+7NFtIfV/SkIe+IoNVvHWtML070W7NlToP9S3ZSJWzJnO45rp5Vt2G9YoHqWlRtuOQeHpWey3mMNjsWsipZrPPoV70C1VtfFMoSPZhtrQjDsWMletint8zNMWONVPqufQUQ/7jvYnbebTQMVFM0WMk0SApck8EzzoaSYDKewxQP2z+4bfe7yEv/SMcU6zFhTkLHbd8yZXvO6TluAIc36gYHZHspeN83K8Kb3j6QMtAHWodwH9GO708n0AU0OtsurWRUKXSJ70UHnoM6s7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seUm1lRALWFgQ/bnly+qRXtIW5eg/FBzi9UkLfo4awM=;
 b=Gm4nyQ7infNk+UqKYPxQO52c0Y4S7yDa2eVZKUheNp5JYGiOv29dsykqeKs6squHJuOGiFixbIbL3T+R9OhbFvNtbKFb3Pc/bwAjghInkKzeQcziaJghgVLk2gBcV+nd/g86Fp3LfRxthJxScGGLO/2SaKHE55x86P60cZyM954gieynzCM4DCb/nG9cCLZcgc9TLSz8hT/wv+Y8s1rIMf45eZ1DySZYZaS4UtrIcRjN2jdVxVLxR7bbS1m9pw0JlzdhTTlmDR84nbRze5eCYnCxxDS3+T66BXBYeZen4mxgXx7t7cd3UrkeltZvJX1EFE7GiNxEkAuCErKWji1hJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seUm1lRALWFgQ/bnly+qRXtIW5eg/FBzi9UkLfo4awM=;
 b=NOse4M6KOhQ3mVPT6TdW93lI79fEflnMfS5LnA8zPthllZScVQsc59ReoxbVlQap73YgjeblJamW79V/7HGEuSrdD8oxCFnszL8riipWGzUhg5ryu57d6/NW7uMN9GyPaozOKXtNXDRTHaE2pcYCenDMbhvewMctiKTrKqPodjjYzlzGf89n9jYFEj94QYXaPRTvJqKaJXdcN0E3LqjcOawaLVK6BAaVKy94IVMgkVxvKiVohVW8BcZOTPyGdzJfPYhVgz9W48QZOPr2kDD1D/AnSYz50TSDfC+KppC9WvLBY0yZ2eo4q0scezaseKaaAqO+V0PotRv9NJSNS3kUUw==
Received: from MW3PR06CA0014.namprd06.prod.outlook.com (2603:10b6:303:2a::19)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 14:22:32 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2a:cafe::1e) by MW3PR06CA0014.outlook.office365.com
 (2603:10b6:303:2a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 14:22:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:22:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:22:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:22:30 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:22:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 12/16] PCI: tegra194: Enable support for 256 Byte payload
Date:   Thu, 21 Jul 2022 19:50:48 +0530
Message-ID: <20220721142052.25971-13-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfdfd478-931c-4258-33dd-08da6b2472e8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gGNI4S+YzT/9SWYrIddfCMKke921K5MVa0DvPCCc657wY2eQMh1fOGxXVg2+XLQs8LHQw+3R5/WtTeOmzH5HD2QaFux9fhpcUvt9cTjprsWiM3+0orU+wliNrXVkm1JAglndeOeZUW6t7ZPy+9+Ou0fzn+gDc0DZeptXw0t9/m5STV5Lf5e14IIOvcJL7cY8vIEW7qh1FFy7yCLMp0EFrXRt/ysZkc/LK3Gb+aNoaTjBHMEo/u7YNvxpXklHZqxTCBTUNq9sOR2WdtJpSJgJnJW0iGGAwWxm2++GxqG2l6Ugah6C2pvIA6Rkv5CeirIJXTaGMtEdJX5mPS/OoANktQejfSZ9SO+6MqUqBj+hpUwcIlbBgZcfAOTexGPzAkByLjT1uqbmEY2FMrk5lHZ/UBjQBGHkIe2CIGZaDXueeXRQZNsb90D/5Nkp6vU0Kvu+q/NO6xaheAfC5eEaR2HLlooZrI0uMUVTfhqFZ4jPHa/SiCixMhmg4KGsD3upOpoE/+BdRqTBmBa9kGk3PUzpyAznc4LC+l5oSS7H/7zKtjg8l6N8dK13iyd5mu+xJHMu7R4LxJY6k6cin6zSfa8atwA+Rzpnn1GsYpv3iXHloJgi69+XuFF4G0qSq09nB9SEjoCuo+sSU1XFermChIQJ+gsVHaI76mQ/b2MJDLp3a+cba8Rz7Qdx/e4m07f3O8tfn4y8GdYz+we1B4dPY/OKVsliMxiAUDzmp5KeHsprg+wDAtjgtGWs/VP7HWnrni78aqj0H15IpoBg6yGmmM8RXnToCgw1wAm+p5GKRQRp/nT7AfEQ8/PJgdWHHT4F+WZs0+v+rcTtHekusDrZc80y8X8rJ69XuDb7WpgQqe2ABg=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966006)(36840700001)(40470700004)(54906003)(82310400005)(186003)(47076005)(336012)(426003)(2616005)(1076003)(110136005)(6666004)(7696005)(86362001)(2906002)(70206006)(4326008)(36860700001)(8936002)(40460700003)(41300700001)(70586007)(8676002)(26005)(7416002)(316002)(356005)(5660300002)(36756003)(478600001)(82740400003)(40480700001)(81166007)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:22:31.5911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdfd478-931c-4258-33dd-08da6b2472e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set 256 byte payload as the default in Device Control Register so as to
allow the PCIe sub-system to enable 256 byte max payload size when a
capable link partner is connected.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* New addition in V6 based on Bjorn's review comment

 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5f1798d37572..f82c70be72ef 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -839,6 +839,7 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
 	u32 val;
+	u16 val_16;
 
 	pp->bridge->ops = &tegra_pci_ops;
 
@@ -846,6 +847,11 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 							      PCI_CAP_ID_EXP);
 
+	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
+	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
+
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
 	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
 	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
@@ -1632,6 +1638,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
+	u16 val_16;
 
 	if (pcie->ep_state == EP_STATE_ENABLED)
 		return;
@@ -1749,6 +1756,12 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
+
+	val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL);
+	val_16 &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	val_16 |= PCI_EXP_DEVCTL_PAYLOAD_256B;
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_DEVCTL, val_16);
+
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
 	val = (ep->msi_mem_phys & MSIX_ADDR_MATCH_LOW_OFF_MASK);
-- 
2.17.1

