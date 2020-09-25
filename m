Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A644E2782F2
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 10:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgIYIjt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 04:39:49 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:34080
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbgIYIjr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 04:39:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F68iZ5y5QNGcYYmRbOkx5/YN8qxdnVmTXfTrcOAdvoYr38EPqXzVCsWZlVNOarisDImMeiFSsBEx8BQQnTYQsR7MpZ76Go46Gtg5m8+7xO8dtWClnA3iPp+fJ3p56jVs5xMtry+R2NqnSNB6EN5PEiwxkEiKqSS9sSfBqei+9+u+PCG4WgEA93s317eJIPPV7g5eWGUU6KfMO25yHTvv+sy7deA+D6MlZHpxFE/AdzW4SbWScgTZCw4nIVJZ9cdHRNM6N1vMhNU25CBiMXVlZqoGkF9pFE9YNZjA9RxYqN0sLGzdUKVdb+sgvvAhG9i7Am5+Ac7jmZmQYt0gVBaI2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb+wZhW0itwAMhFOtnFDVhb3o/dqljZAHvqIk2sHcRY=;
 b=DlGo8IipPSZpVfqKHS8HIGkHxsGiGd70Hl/dkSYcA3a5wWl4iepR2TxOiR9RtOziQe4bu7riC/gwCZC1GlvDpQTyJNDh0YiTZd9tCIY9E+CC96lcDDWEbUpUu7GJ6OFBQxv7wcEV87Wk9DVukamq9MBwQ+dOgLDRWxFhVsPhsBPq1Jf6ODBHKHFXXdyd83O2oHlYkzFwY94c9hcJnrKLmjtSsPchYi1hjHNbpVuWYyplHS2yhn6tBi5A9+mG3yCsE9DOfp9UH6Jho86qX2m2r2oCbMYTsDnDnnjco94CRUXXenW6sg7qIqOai0PqnfmzNxYTwDBmglE4P2tGHV8Nxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rb+wZhW0itwAMhFOtnFDVhb3o/dqljZAHvqIk2sHcRY=;
 b=QllNWp19W7FQJfDMU+8/ZgsxqROHXuWwGnCA3iznAWe+UxV8GNcYAaNuobydt7ZoesdCVbb1+Hyc+gnFzLqKzPbRMWGfNMAk1OwxWZBNdDo0/SSmZPdKQL+NW7xZhe6IC/KhVFtDgy+7910GaJ1pyoFvXWkxknJhdNjk1ewIQNY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4697.namprd03.prod.outlook.com (2603:10b6:5:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Fri, 25 Sep
 2020 08:39:44 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.028; Fri, 25 Sep 2020
 08:39:44 +0000
Date:   Fri, 25 Sep 2020 16:38:52 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] PCI: dwc: Use an address in the driver data for MSI
 address
Message-ID: <20200925163852.051e3da2@xhacker.debian>
In-Reply-To: <20200925163435.680b8e08@xhacker.debian>
References: <20200925163435.680b8e08@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:404:92::31) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR0101CA0019.apcprd01.prod.exchangelabs.com (2603:1096:404:92::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Fri, 25 Sep 2020 08:39:41 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d899aaac-10ea-471f-760f-08d8612e8d57
X-MS-TrafficTypeDiagnostic: DM6PR03MB4697:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4697C7FCAB65DFC0711A3224ED360@DM6PR03MB4697.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbn9a5GYiltSKoOb/EMGorObrzwMT7CxQTWziBLZMpVeTra7JEAYzUwkor1gZecqItD8qHVOD5Cve7DTlohGUhBeJDoM2/lBr6brVqcl5Ka0KcO/pk8BvvUtYhxxd42702voB9jYKYgUrklCp0UTgdKLQwPZnVN5yE/ifv0Tpd78QjbQQ9YnMe0skxiO6PK2wXQGVcTu9JnVnCpCC/klOjTM8TtAhemJb/jNn2x8vht9INYpq2o9YZbFbPCPdrESLyDWJB4IuHx66gdAMAsKsb92TIR7m+8jwehdcRJG14E4kDu+7mkcGoLgGMXyf9Sm8yW76gDs8Qil28TzHSXQyUIhrwx/Z5b+IurdvtgpKRH4GAMP11RcTs+fis1CVvWM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(366004)(376002)(6506007)(52116002)(6666004)(110136005)(4326008)(478600001)(7696005)(83380400001)(26005)(66476007)(66946007)(8676002)(1076003)(956004)(316002)(9686003)(86362001)(8936002)(66556008)(5660300002)(16526019)(2906002)(186003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 8yGvGSXP82zl+b9EMjESAOnREhzKkiGekF+8g18A1WwRrTjIJnR2mU8c2FZzgcJVuTGx943l2pVLU4oqD1J90vl6aCn0OF1OmDgXoLXXCs5G0ipA7hRQWA4HaEuCh/pxu4VWTvLL2KLdDCh9EqtkSWtQz+6aH4yCx7m8Jub8Ykq364BwKfOSXiibwZRHs1ytPdrZMVnsCbuJloiH+49PPWA732RiIZ68dZ+FULz6B0dDfrQ5/QkXK5tt3Usqk8a/7SqRzXxcRBPMKxA7RaQ7yzofKe+VEMsbQCcVJCb9FDWvX79LrD5LHTwRZdEyMOR54b4sMkZTGaMZITcZhL5VZUFJOZKGHLQW46jKS96OJKVZ7CFYbrfXv7eWWhB7u7p+zIj+pmDV2w0UYyCRUo+aYo4KHVFM9eS9C9jGjtSwdVQnvuEIR1RrKID+i5Kb97Q9UtjZvAvOI9hwpPV+OUfb9+TRuoq1iYXTbf0IDrGodpWqgemHCpHy4AumIzcNg00IiSK0o8sqnE4drt/hlG/CzmRZu1fWQ0hnnwlNvjgSrZji4y3k8X6QqsGnDa5qbWCNVzfReRT63oDR8H8g5BEcvODatFEpgrwLgY7P2LVeWICjd2w8c7XqOECnoePYsLlm37cERvDba17MlxHyKoaQTA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d899aaac-10ea-471f-760f-08d8612e8d57
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2020 08:39:44.2173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LQUVVk7EhNSbkhnejhnAmEU4O8ZimAvv0UjGszjl2JeidZlWglviMBnnElK54rZ38cIltvIIWd8CZAVBfBJSCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4697
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's no need to allocate a page for the MSI address, we could use
an address in the driver data.

One side effect of this patch is fixing the MSI page leakage during
suspend/resume. Take the pcie-tegra194.c for example, it calls
dw_pcie_msi_init() in resume path, thus the previous MSI page is
leaked.

Fixes: 56e15a238d92 ("PCI: tegra: Add Tegra194 PCIe support")
Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 22 ++-----------------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 -
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f08f4d97f321..bf25d783b5c5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -126,9 +126,7 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	struct pcie_port *pp = irq_data_get_irq_chip_data(d);
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u64 msi_target;
-
-	msi_target = (u64)pp->msi_data;
+	u64 msi_target = virt_to_phys(&pp->msi_data);
 
 	msg->address_lo = lower_32_bits(msi_target);
 	msg->address_hi = upper_32_bits(msi_target);
@@ -287,27 +285,11 @@ void dw_pcie_free_msi(struct pcie_port *pp)
 
 	irq_domain_remove(pp->msi_domain);
 	irq_domain_remove(pp->irq_domain);
-
-	if (pp->msi_page)
-		__free_page(pp->msi_page);
 }
 
 void dw_pcie_msi_init(struct pcie_port *pp)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	u64 msi_target;
-
-	pp->msi_page = alloc_page(GFP_KERNEL);
-	pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
-				    DMA_FROM_DEVICE);
-	if (dma_mapping_error(dev, pp->msi_data)) {
-		dev_err(dev, "Failed to map MSI data\n");
-		__free_page(pp->msi_page);
-		pp->msi_page = NULL;
-		return;
-	}
-	msi_target = (u64)pp->msi_data;
+	u64 msi_target = virt_to_phys(&pp->msi_data);
 
 	/* Program the msi_data */
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_ADDR_LO, 4,
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f911760dcc69..a88e15a09745 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -195,7 +195,6 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
-	struct page		*msi_page;
 	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_mask[MAX_MSI_CTRLS];
-- 
2.28.0

