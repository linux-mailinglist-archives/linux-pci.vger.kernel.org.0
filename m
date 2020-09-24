Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB633276F70
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgIXLJP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:09:15 -0400
Received: from mail-bn8nam08on2084.outbound.protection.outlook.com ([40.107.100.84]:64678
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbgIXLJO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 07:09:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NN63WzLqfgiVjMApbMdERdPzHyYwwpTblAlGcK/aY/jdk0/w6t4MXo9ag3jfu+omCFJIRBRiWs+Ays2p/1d3HwuvhllxVOtg5gUx+6mjMoEjzgOfZuFdimh/EUewDNfrZqCfz5c/ogrrTU7gr59E2vzoc1Q+3iUIeoZzEWhxccEbfw02FHIEgcXiMJGowC8aFbZXbhtCs5VbPDWEmL7ruPeGglD8N+P7T74E9vgY/CFGc45lvUACTOvwclTScSEFmDedqE6OdZjW3BBiYLKlfocDmIGrYj7i8X47t2cpg15MQOINpwwNMFdZTO0d1wzF2RJf7OlZj7LlRVGPF0dTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUNQDYZ9rMtqPs8FD/2qndtHl/sKXX6XLTpbfHpTPjI=;
 b=PISMAJ5/xIASxQ4cc6f/OK++dqy0FwSJlTMRsZ0HLHmIfYmlYmvVGfiOckh3/u1tYwHf8MpAyYIgBBJDp8hwXsKbxM4e5dH+irIWr3GVA/zfSTW3CRniR/YL1FHwCRjAVAm8qt6m69pVEr2+PmpJ+wyOUAcmBC5ybb3ErLhJn48sIJhHew3uw8q0REvHs+yKN0D0I9eAbBL1E8nkAG1HyypL0PAdB/S3ZQk1MUYXn2dAQfnzuFSBBQIHQ0Gl9tAN7SWDFaOx8myZSrhhn7cxWO8nwX0YSlj28Aaa6J5bX+az8ALQlBSo0XogMHhiZnhXRjuCA7ogGUA+uPqjyTzewg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUNQDYZ9rMtqPs8FD/2qndtHl/sKXX6XLTpbfHpTPjI=;
 b=RbHSaCf02xATKfDCh0a0ELsjV8gKwRsr3FwT9W/A+xUVPdZrWnFOGhYMyHgCeuzAbkZzUQO0mVDFNg3nLZiHkRYGMT7Rh0JGgfX8PqCS8sUkRSxm122+CDPctYHUzJ6k3yD03cJZHrWSJGVAfR/b6ha85itEC67wEGd+QdPdr+Y=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4698.namprd03.prod.outlook.com (2603:10b6:5:180::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:09:11 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 11:09:11 +0000
Date:   Thu, 24 Sep 2020 19:06:50 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/5] PCI: dwc: Rename dw_pcie_free_msi to
 dw_pcie_msi_deinit
Message-ID: <20200924190650.24c0ff8c@xhacker.debian>
In-Reply-To: <20200924190421.549cb8fc@xhacker.debian>
References: <20200924190421.549cb8fc@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::36) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0072.jpnprd01.prod.outlook.com (2603:1096:404:2b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 11:08:59 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d82951b3-e5a0-464f-600d-08d8607a43a9
X-MS-TrafficTypeDiagnostic: DM6PR03MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4698241E3FE19D7A7B05BAB1ED390@DM6PR03MB4698.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c58m6BnVFVuqq+u8mtMx0QULUVIkBXS8UUTKjHsQk8GLzJgSYdeLrePi+33M9QnlKO+KAT036xCrCgqQ9a36FBchaZ5YgZkdh6YiQfpcAh69bY3GGI4kK23rgfEf2h0Sh0fucoACMDAt1KPFpOv3tnUnGwSO8BTjNMhel6ZSGCcjvVPtNCviJ1OlFIGM9ZF8eR5RTTA+xKWFUBUSOr5SHYXqOxvFzxFuxvgO26UheMPf6HNA0bn3r6+fAQN9C2E5+34w/9BKV3fILQZMRci1JmRrcyJAbPnSsYawrnIAIjw0VhmOUzleewsL2V58AedJNiHlToZ4PP8hpEyxQ4GsKXelvtuTQeplqJGox6BosqivGaZG1ZUfgAub5LGveqgB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(2906002)(86362001)(6506007)(52116002)(7696005)(83380400001)(478600001)(5660300002)(6666004)(186003)(66556008)(16526019)(956004)(1076003)(26005)(316002)(66476007)(7406005)(66946007)(9686003)(55016002)(8676002)(8936002)(110136005)(4326008)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: V8596LdB2ey4bVQREk1T2QDQ+we/64vEdOEbR0tk32bMl6axDZIUbgnTkru6Y223GYnBaYqDMJC++/W1UNbu3mpQUSrVcS50wh6+OEET3K03Fg+QNVVQO3JxMa/ZS8KO5AcAUZQA1sLg3lxThKSvN4klRA82ed09RTe67F2O1XxfwGY/K70IJdNn3rwQiFnMeuLd026qk4Adj4uxaj6sE6rHxsTRJ/nNB9WWGEO9BNp9df8G34CQtYE9JjgC8OdktiFK/tWXi5zuXfvjK4I8OuFfjqFsUiTkbmFlWBxMV+SGqJUcxX+IQYeG/yW1rJG+bb3RZQ1B2t5cVxwcFONuAwIzWQTnb6Ji5DXouQIkSeIhCF1pAi1jTXS6QgzuWbi590cMYZypDstRDixIUT0Cnql3Z3+VK1LXAjkvaesI02ZzYyIn/HQmDX3CjIbRHBj6din1WHBePqrnFlnB2wma1xEJnNdi35Cqng9cdb9Y0muL1wWx7vjN2O557nUGdUL4NCLJ2SWEiIRChb+6xE8jS47SmCrNXw5VgPmapts3QNojwgYr+iuP2oPfaM7fIsd/nKdtzKWjKJbcyA6HgPe59DP8tbDOqsXQ3wKyfX6MvbAE6d6KoKvaFA+iTC19/9taONI3haGATtsHbHtDkPOv7w==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d82951b3-e5a0-464f-600d-08d8607a43a9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:09:11.3883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXafrv2u/U7dpykpeXQ+d8GzArDWb+WRVaJ0Frhb9VzfeMxXZPpOcLbZRkmAmNhtMKzEd/fNkE2g1rcNW1B4SA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4698
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The dw_pcie_free_msi() does more things than freeing the msi page,
for example, remove irq domain etc., rename it as dw_pcie_msi_deinit.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 9e04e8ef3aa4..d2de8bc5db91 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -278,7 +278,7 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	return 0;
 }
 
-void dw_pcie_free_msi(struct pcie_port *pp)
+void dw_pcie_msi_deinit(struct pcie_port *pp)
 {
 	if (pp->msi_irq) {
 		irq_set_chained_handler(pp->msi_irq, NULL);
@@ -500,7 +500,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 
 err_free_msi:
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
-		dw_pcie_free_msi(pp);
+		dw_pcie_msi_deinit(pp);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_init);
@@ -510,7 +510,7 @@ void dw_pcie_host_deinit(struct pcie_port *pp)
 	pci_stop_root_bus(pp->root_bus);
 	pci_remove_root_bus(pp->root_bus);
 	if (pci_msi_enabled() && !pp->ops->msi_host_init)
-		dw_pcie_free_msi(pp);
+		dw_pcie_msi_deinit(pp);
 }
 EXPORT_SYMBOL_GPL(dw_pcie_host_deinit);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f911760dcc69..43b8061e1bec 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -371,7 +371,7 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
 #ifdef CONFIG_PCIE_DW_HOST
 irqreturn_t dw_handle_msi_irq(struct pcie_port *pp);
 void dw_pcie_msi_init(struct pcie_port *pp);
-void dw_pcie_free_msi(struct pcie_port *pp);
+void dw_pcie_msi_deinit(struct pcie_port *pp);
 void dw_pcie_setup_rc(struct pcie_port *pp);
 int dw_pcie_host_init(struct pcie_port *pp);
 void dw_pcie_host_deinit(struct pcie_port *pp);
@@ -386,7 +386,7 @@ static inline void dw_pcie_msi_init(struct pcie_port *pp)
 {
 }
 
-static inline void dw_pcie_free_msi(struct pcie_port *pp)
+static inline void dw_pcie_msi_deinit(struct pcie_port *pp)
 {
 }
 
-- 
2.28.0

