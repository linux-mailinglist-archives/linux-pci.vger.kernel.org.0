Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABBB276F77
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgIXLJa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:09:30 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:43489
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726444AbgIXLJ3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 07:09:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaH05Wjnvw6vkNjudNpLeXLMElDoACnGW/PUDIZgpbrBnb9mvmzKAhKWI3QpgsyrVtBCfEi6VrgzM1zSs81Lly6OzFL/uHA9mFYH6JNp3Me90H2H8ARVz0MsnKIekxrdgHIQHA68scMu/b2O/w/O9cliRARonCKSAV7+K7MWQmkBGVA6nMvoJP7mf7MDzVrGmdmmFZI0MLx+HccGUru8cgLK/vMiylsqG2HWMV1/8l0A/v4xNGEisOIOG4FqJx3c/JO33V75/PgCX67B+cFS3MPhEoiy2hO3MpuSJH4N31/NsgtwSoqwN/8dCPoRtfVwr0YkPePzAol+XI4Izodgjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/XfW+d2ccySJec181Cd3HFaKQHRrJtIlLvMou+83PI=;
 b=jGruw0HWEXbi/cmSxQZDo2KuOAPXCPBIGqLv0qTOxcJcKJsAXLDfbjMMVlnScCn+AaXhYYNYhENCsTSK/zxCCbxYNQnc3Q1xW0H5oSsEC1p+HOJytP6hYEHGPb0qhCwThFKsR+T9SeCUfF20WXhAo3PK6IeyYzNBmZOhcYzoxjsqu4gphHOqBFTS5yz5nLz8q9MvX7yeCCeEQoJgvJ0bxhVgvO9riAZl9kIXiu6TBj2bJ8OKRSlHVGeiiZYpQSXVPULfn3bq1fmOE48jy/0SHmspXCZjGDTJW/xYYbDVjOmjMQCDmtMHgnh5uHv/fkKASpr4TRRkAq7KWVWrwZrCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/XfW+d2ccySJec181Cd3HFaKQHRrJtIlLvMou+83PI=;
 b=VzSGm3FUnqYYrpJ0Zmh2kzfthdYA6EVnL0HWrxXFVV+bSXkK85DUEyAiL8IFligLkq9jFHdN16gi8ig8l2GlV21kN8gCMh5D+4+qjyHPjkvBy4bV1Aw8wtH0LqPvoDR85GrxIPOb+D849/mKffylzeQkMGM+1yUgGzxwYiOrlsE=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4698.namprd03.prod.outlook.com (2603:10b6:5:180::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:09:26 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 11:09:26 +0000
Date:   Thu, 24 Sep 2020 19:05:14 +0800
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
Subject: [PATCH v2 0/5] PCI: dwc: improve msi handling
Message-ID: <20200924190421.549cb8fc@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0072.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::36) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0072.jpnprd01.prod.outlook.com (2603:1096:404:2b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 11:09:14 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02a99038-efe4-4220-3b33-08d8607a4c95
X-MS-TrafficTypeDiagnostic: DM6PR03MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR03MB46984443010BE657EC425712ED390@DM6PR03MB4698.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HCyi8jhamBFq+Mm2cirI3hJwb318yvz08vVGjxIoVCIbct/GVtsDb/Fu9Qv7jxspAz/ZnOWuxd5YGJ/KdlfxHuZamGQHcSnkpt9oPJ8N4kJuqcBmDPUeB2H9t/n5cdY8y/fkN48mQbQU+GbugiI+MiSdLtS1M/HE897FNtO5aq4VZ2IqYVakG+WzcpPOpGzbp4z5kU1cY2aSz3BD8Le4dEtLDOVoxM8Ki3k8Jpn8aIYOm3CewlbCG4uswYD8WTDHf8eshfGRnngkWi/dEAMW/RPCl3dQqLwe75+c2aTV1Mj8rXS0+0zHMEeylCdzsydvVFy/lIEf0qRITTwvs5hgYZF1GXnO6pUKyJHKUNda7Jl5YINSIxdDl9zZZ9WD0sWe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(2906002)(86362001)(6506007)(52116002)(7696005)(83380400001)(478600001)(5660300002)(186003)(66556008)(16526019)(956004)(1076003)(26005)(316002)(66476007)(7406005)(66946007)(9686003)(55016002)(8676002)(8936002)(110136005)(4326008)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vcbm7GI5dcr4QE9YADmqEQa8Py0TNqyjX9X7srnnrUhZqQOJxxV/VFNqtRiNOZF1DBuDu6FQ9OwwRdywG987+BDO884jQHpX9yaiFp5blavEZK480MeIv6m+sIoW5JzGE1vUBWYLYLC8je7CWJqJ0ULnN3vrMsGZ8aWjglJXXh9a6tac2fu36vnfn6JhfEWwaePlpIlOK4BHmdNIRgefw+bmXol4DC4f4U2HhnMkELD3CS7P9O6JdwS59faGQz/K7q+2x2Hz7ZiCUmOJGGX1VFJsPZgnlPhAoOHjAse5ZSkypETQQf+laWEEPyXv+4j7+bIzeaZCPss7JQlPRquvJD2/ApFJuF5DkAMnGXnKuI/kD9N0QaxAJPedQhAYpjDlmRw7sCwOTVYYLf2NVegs5OqoFARyrOunT8wdcCDKF6/mWLa/50kJD4rf7Po6Wdmm9rWsvCWfWlaTQ5GQWnve9tw2N37NDqaml0H+0fKh9FAsbpimtiyn/QkP6gcjaOZlnHteN75IrKv3Ga4mRBb/DLB9NaWKm/WE3FsgkNuXKERf3aO5Zi6NB9uzrUBEhePuqFlStxTu1vYfTkxVk7AfRDy8mciHqwf95qPpt182xlyRSWTluuSMDA9HgAO97AzrRMzrafteEVkaXfSepO0OQQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a99038-efe4-4220-3b33-08d8607a4c95
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:09:26.2009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: COEQ8Non1hWcp9jtTpHBgb+h7ZDwAU4wXYuB78qdJpDJYlorF07b1sHsYCHL4bzJUXxLj73t/UVNbl6c6a3aow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4698
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Improve the msi code:
1. Add proper error handling.
2. Move dw_pcie_msi_init() from each users to designware host to solve
msi page leakage in resume path.

Since v1:
  - add proper error handling patches.
  - solve the msi page leakage by moving dw_pcie_msi_init() from each
    users to designware host


Jisheng Zhang (5):
  PCI: dwc: Call dma_unmap_page() before freeing the msi page
  PCI: dwc: Check alloc_page() return value
  PCI: dwc: Rename dw_pcie_free_msi to dw_pcie_msi_deinit
  PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is disabled
  PCI: dwc: Move dw_pcie_msi_init() from each users to designware host

 drivers/pci/controller/dwc/pci-dra7xx.c       |  1 +
 drivers/pci/controller/dwc/pci-exynos.c       |  2 -
 drivers/pci/controller/dwc/pci-imx6.c         |  3 --
 drivers/pci/controller/dwc/pci-meson.c        |  8 ----
 drivers/pci/controller/dwc/pcie-artpec6.c     | 10 -----
 .../pci/controller/dwc/pcie-designware-host.c | 43 +++++++++++++------
 .../pci/controller/dwc/pcie-designware-plat.c |  3 --
 drivers/pci/controller/dwc/pcie-designware.h  |  9 +++-
 drivers/pci/controller/dwc/pcie-histb.c       |  3 --
 drivers/pci/controller/dwc/pcie-kirin.c       |  3 --
 drivers/pci/controller/dwc/pcie-qcom.c        |  3 --
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  1 -
 drivers/pci/controller/dwc/pcie-tegra194.c    |  2 -
 drivers/pci/controller/dwc/pcie-uniphier.c    |  9 +---
 14 files changed, 38 insertions(+), 62 deletions(-)

-- 
2.28.0

