Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC22276F81
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgIXLKg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:10:36 -0400
Received: from mail-bn8nam08on2080.outbound.protection.outlook.com ([40.107.100.80]:53920
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgIXLKg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 07:10:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bI6sZj9pjliX3u3QjifeWsBYi2gdtehhL8OkVFqpYWLP+Virgb6RRd4CXIbXrxdAQvnYQFC7fqA7heLKSfXXa0EvpJdq5qOUYdxBRmq/nSqP2ErAT3NbrwxjyAYe4mZyT+tKazfEiZ0/53leSZyVDC4BD5hbX7U1XMy7/AZJxeUlr/L2F17fosMJeAcf4pg0q26KcsuLB3e9Uz52456KtDdhtKtY7pBMzxmy06X63j785aA+En3tQ652JJpsQp2uw1svdesQkOx/ByXgVAZQxLjZ0IktY31EbWqaJpYmKREBNpcVbWvtqkftlq+yCWsynlGXvdxEDw8fIngGe4l0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acz77/pflNcVdEV1U42qoD+DQZydsUzkqwBd3G+9rkI=;
 b=VKZN9Pjtfenp30Da1UlrbguJvYtahjcY19Mhcp0DYEbt68GTp2h+anXqerIMMd6UrBMyK/D5jknakNQ6juAryvcBH3dBSATeJxFV+yHVHxmPOJz6biz5zVZoZuDoQLWaqTRQjMo1AvUMEHR697xaJqxOCDfmrawRME8TgXHu4YIPeKQxQZmGGeK59BeoHZoRsflIdj5zIxa7rKcCCYlQy7b2Tn4zckpSMQvhRtADsK711GCUa0AI33X6j2ONO1z932kkZ5YTuSirQheWXbGamPuA6brryYb4yCkQFelgv4rrPbGDQ42Dao5JiOeDMAPIaYB7nhkMhc2fFr5/kh878Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acz77/pflNcVdEV1U42qoD+DQZydsUzkqwBd3G+9rkI=;
 b=Jk6IOAGo0hMtAydUGk9ZxtjtDZdCUH85ScOE373R27xi1fxiFBSdoEk4yIQ7P8RkRQJN1OrNtZ299rFBNrOVRKei6Qs5nVeY+75ZnYm3roShaCxI+zDBwgPrkRSkyDXtBDTG8OjZcESVVq8WiaqjAMITnXYLezE/VMuedOzdC18=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4698.namprd03.prod.outlook.com (2603:10b6:5:180::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:10:33 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 11:10:33 +0000
Date:   Thu, 24 Sep 2020 19:06:23 +0800
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
Subject: [PATCH v2 2/5] PCI: dwc: Check alloc_page() return value
Message-ID: <20200924190623.3251c2ac@xhacker.debian>
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
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0072.jpnprd01.prod.outlook.com (2603:1096:404:2b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 11:10:21 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9297cf5e-76d2-4fea-a169-08d8607a7492
X-MS-TrafficTypeDiagnostic: DM6PR03MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR03MB4698AD330E4BD7C4A0F88ABFED390@DM6PR03MB4698.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t0btgccwOGojDdAaCv0wgZnNV7PTN/TCuiwSg0FB6OVX9+F/Qk8dnVynC0N31ulPlq3OK5gCgp44WWNxEnSV0PwsP9v3PVu0zV6g1JUPI0f5GT7nzTg81bBOnkFIXUXO3YY04SJ/NSx3MCnY/ZVbeMz6sb6xRQZMma311tRKdi26KUVdUEAFx2dtCLuUfzcqoWyKnj6mIHDu1JGLO4I/mHphOC18G7+HqsJXMbJSQ6vV/oi0W6uapMruuD/ES3esOyT/NIcQ4UJKI+zroy6IsZYx6ZEc9+Fq/6BgiibfIhq3NECEqOzXFvRL9iPGbOrQZlZEQHDk9pvst6dItYg5FFzbZy8/UJXzmEA8NuXLWxV0lB2jT/N8DLb8SkgfgCyX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(2906002)(86362001)(6506007)(52116002)(7696005)(478600001)(5660300002)(186003)(4744005)(66556008)(16526019)(956004)(1076003)(26005)(316002)(66476007)(7406005)(66946007)(9686003)(55016002)(8676002)(8936002)(110136005)(4326008)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ThZuJR8ax+hGtWKFSItGEbCRsjR1hkm8jqwn6FE6pwMjVlNErjiiAw7/3GqWJMZKyZ/xBy2Wo0ARd1VoDZCzNPQuzumlhDOnebY0LKZV38005FjqPYn8wAq/X1bzIven6vOjB+UhHJqlAbZjXyafJ3RQajm05duMupTMqWOkuY0iDTwBP3FUEbo/QAlCZlsQL9IxfDp7LRaBxyvF6sJJ/td832GaqDajF5Kf6AvYGOhxIorC3DgXiCeqT8B7nqGcNEE7scN1UC1BL6vGZ9d/YA6DudNV0Fe3b2b0BuMt7pPehY6KrF1VnGJykbExDFHfnF633KEo2FhlswFQek5byOtC5Ay9luGHpjyvfIywmTEaC1oHy6JerSI2ebDIZaksi7LaHUt64bkLgxcKCHuycCWJYJ46sNgMXbbBAKh8pffyhEE/xST/MH6RQejJTAn4GIxz+c3GsVV1V2jGTYMJjvxddIxyZ1XFBZB5wprziBlbaKcyk9HqvtaD0bwef7P9EifDYdi50jZObmq1ZuiwWiOGtq8TY0WzcQChFZ+nVPsMLmgjv/SurcIeC4Ej44zKrk4Z/IO6zsD/39NxBYW3cbam/i6XC8CtPiXjUIwgSjHKoMh3W0xHMSdHeED0ryVopEar0gaFYmk8a+36QHcxXQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9297cf5e-76d2-4fea-a169-08d8607a7492
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:10:33.2917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0KdVNy1pp8q56TtyKEyqSK+JlCejxU8JAZeVAODVEtdXvVukYoN8MgZuqQPhZRWeP7SO7vx7BL8tuKJ6tiJ0yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4698
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We need to check alloc_page() succeed or not before continuing.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0a19de946351..9e04e8ef3aa4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -303,6 +303,11 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	u64 msi_target;
 
 	pp->msi_page = alloc_page(GFP_KERNEL);
+	if (!pp->msi_page) {
+		dev_err(dev, "Failed to alloc MSI page\n");
+		return;
+	}
+
 	pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
 				    DMA_FROM_DEVICE);
 	if (dma_mapping_error(dev, pp->msi_data)) {
-- 
2.28.0

