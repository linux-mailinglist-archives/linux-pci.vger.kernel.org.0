Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B071F2BA8D2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 12:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgKTLSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 06:18:05 -0500
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:23201
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727364AbgKTLSF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 06:18:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DYRny9C5YC/30egSyNyvENV/Fc0XrYyOeWMhJ+dk11iAhdS3VjdZSv/grKYguwUiFEZSA9jtFx0J5eCWJeK6RbZNZqiY4kXZHjsy02NtjMFTZjCgdRhOjnqR18zRWIU5k5ho4Cecx0bzRgw/2l7rLBiZ++IISVyVZacjJTz7yUucZp7cXKTxsJdQSPPKJDgS/jSamUb2UI5+KycdVKdYxxe0Qk/n8TVnbtE1I4C/VNsEaTr+LUco/GlG36UNLImeR4X1buHbihFJBMi0DnAX66B/bxefS+LAawfo+q5nCdGJ8KeYDi3izjkr/v2FARDoGHpioHHpLcjYlbHENodW6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXLs34JjViDh3Z/H+XleHO7N8pQudyiqc8ptrPvCN2M=;
 b=kznJziwuq75+hsojiBRVK03fN14758NoGK8pikQ4POoipZhCq1b2gVK7sOCPKHE8Kb7HvL7M+JIbJ9xuhcntpZZxq5xKsBi5nL2ZKzTJju29ozGWENF9KcBAONV64Uxw7Y0MxcLInplrmPB83G8X8ojiahrelF20AAALMwgBlLTkl7zUeh5eYv9J0TYx4opU6JGX6IPbhTWUWEwe/y4pns48S2G2u1yI+MxBeYIb2Izh4lnE4b8CSnEYrLD+GdXc4VbpbNT5hUV/T7qpQgRGHSgR7HA64NTmblps4l/n3rCJSZLxPd5WhepvbXI6vzWsmDsCsG0dHDSHJmBNLCDlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXLs34JjViDh3Z/H+XleHO7N8pQudyiqc8ptrPvCN2M=;
 b=VN0hvyhn+Bxl2SJugOLAmOLVMp3mIOcaKn+3ytB6UmYMeh9xzX0+NV0n88z+j9bYDK+Im6eGfsn/mHMMpTwD0bBwtYMQAYpdMx/HNfU1e/+7K/fEzPTRkD51l7GLjk+QRAdXwgo7UIXnB5DrYequsAy52WeaCUu2gN9cNDucaPU=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=synaptics.com;
Received: from SN2PR03MB2383.namprd03.prod.outlook.com (2603:10b6:804:d::23)
 by SN6PR03MB3808.namprd03.prod.outlook.com (2603:10b6:805:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 11:18:02 +0000
Received: from SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39]) by SN2PR03MB2383.namprd03.prod.outlook.com
 ([fe80::412b:8366:f594:a39%9]) with mapi id 15.20.3589.022; Fri, 20 Nov 2020
 11:18:01 +0000
Date:   Fri, 20 Nov 2020 19:17:43 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jonathan Chocron <jonnyc@amazon.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next v2 1/2] PCI: dwc: Don't assume the ops in dw_pcie
 always exists
Message-ID: <20201120191743.7687612d@xhacker.debian>
In-Reply-To: <20201120191611.7b84a86b@xhacker.debian>
References: <20201120191611.7b84a86b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR11CA0092.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::33) To SN2PR03MB2383.namprd03.prod.outlook.com
 (2603:10b6:804:d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR11CA0092.namprd11.prod.outlook.com (2603:10b6:a03:f4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 11:17:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600fecfd-183f-44c5-8466-08d88d45f179
X-MS-TrafficTypeDiagnostic: SN6PR03MB3808:
X-Microsoft-Antispam-PRVS: <SN6PR03MB3808371F861F2D65F45E66E1EDFF0@SN6PR03MB3808.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0ipg8y/MfVp8NccL9vC4TfCO59ayZ2B1T2Xkw+UwaMw6ug8l9WBpZuHFws+QolxNhc0fnn0bW0Xo0kEJmlkNaDqY3x/t1XBQPOHz90ZoY2jtoepwC7gy9MsnxXZ3QkylbDuz2uSiYwzqO68lnvbIYIQnB6rRwwZ9e/RLmvlzJERTSq9u8x/tCEwd27Z0AJWtUzRnfOHv3XHP7zWbgN2cu70OFW4998H0r5+PCuw7tXgxFq0hONaMwh7Rlw0NqrwlpydBvWHrvHvTNq2bxm3TBrxmbHYI9pqOAQ7dyla3NZLZyAwdkOu9XFCGMXXoZeLF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN2PR03MB2383.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(9686003)(66946007)(8936002)(316002)(186003)(478600001)(4326008)(26005)(5660300002)(55016002)(16526019)(8676002)(2906002)(6666004)(6506007)(86362001)(83380400001)(66476007)(66556008)(52116002)(956004)(110136005)(7696005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uAyfKgQDxCvsMazSOGOM6K7Pu+8iSdskXjAERzsRW3EDEL5Srb/FwyJzvUNFQVb2UPKjrjVu0yeg6dhsEd2MjqNPGUXW3mHcSJ8A5JelzEhfLP9u4HoOnAl3PCNmgXOnGU1zzeOtIyfUhZC5LOTmTTSjpb41G1xdqtq21qbBl4BfG9tUA/10OeZhTYvPa3Qc1nencJqVo7OKWDGd/fC4SIdgEZl873lFpqVVcQMudoN5b1dMx462+3h/TtBtN+oanXVboVQSvgRU5GSsgVGkad07MjTwxc+V0tIZBkSN70/TVkpKw0JbmtOBalBJqBlUJFkgTYLkIYH3Q46+7/ZGW6YwjXwKW83x8i2cVwtn0oIJyEL3t7W6MGPbf6DU2JR4GD2Z9LUit+TfohUiBQ/oxnMfaiw+wlsxHglsspVe1MOomT+egt+OdPt8TIM7kxztp/kGBaKALTgSMg9bgRZCdwtU/2NhJDb4QPL5oXrRhslDCEUhBwLj8a+nQrNewvdYGRztHQS/KYusGbL4rTn1H7VDalhV+EX75S0Ij8plw2ltYh4FkW/BP33I4xfB5Wrml25Jw0d6LeM6twyvSLfn76ybytZadkTxOnLJNZYcGO51yp3mINht2lNJuOD7YqsrBCfMPT5+a/agav9NyxcVFg==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600fecfd-183f-44c5-8466-08d88d45f179
X-MS-Exchange-CrossTenant-AuthSource: SN2PR03MB2383.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 11:18:01.8596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eA5A3mI/cSZICbXNNE0azn6L0q9gRpS3YNgrNOd/DAI24OVn5Ry20VBLNqFPsRddYcv7Bkmu2c1Haa7aiFrfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR03MB3808
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some designware based device driver especially host only driver may
work well with the default read_dbi/write_dbi/link_up implementation
in pcie-designware.c, thus remove the assumption to simplify those
drivers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c   |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware-host.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.c      | 14 +++++++-------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index bcd1cd9ba8c8..1c25d8337151 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -434,10 +434,8 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops->stop_link)
-		return;
-
-	pci->ops->stop_link(pci);
+	if (pci->ops && pci->ops->stop_link)
+		pci->ops->stop_link(pci);
 }
 
 static int dw_pcie_ep_start(struct pci_epc *epc)
@@ -445,7 +443,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops->start_link)
+	if (!pci->ops || !pci->ops->start_link)
 		return -EINVAL;
 
 	return pci->ops->start_link(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index e1db9056df0b..082ff75b14c4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -420,7 +420,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
+	if (!dw_pcie_link_up(pci) && pci->ops && pci->ops->start_link) {
 		ret = pci->ops->start_link(pci);
 		if (ret)
 			goto err_free_msi;
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 645fa1892375..cf895c12f71f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -141,7 +141,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
 
 	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
@@ -156,7 +156,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
 		return;
 	}
@@ -171,7 +171,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi2) {
+	if (pci->ops && pci->ops->write_dbi2) {
 		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
 		return;
 	}
@@ -186,7 +186,7 @@ static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
 
 	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
@@ -200,7 +200,7 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
 		return;
 	}
@@ -273,7 +273,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 {
 	u32 retries, val;
 
-	if (pci->ops->cpu_addr_fixup)
+	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
@@ -481,7 +481,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops->link_up)
+	if (pci->ops && pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
 	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
-- 
2.29.2

