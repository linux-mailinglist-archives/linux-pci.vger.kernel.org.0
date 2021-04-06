Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C78354FBA
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 11:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbhDFJWN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 05:22:13 -0400
Received: from mail-vi1eur05hn2210.outbound.protection.outlook.com ([52.100.175.210]:15872
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234721AbhDFJWM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Apr 2021 05:22:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrY6Cb6oKDPy8Nwg6U80F+J5IeJ+qMkxbpGFZEiSQaSoI7o4k0XezaaK+Upz3F3SAuHJcQKuFOwR7T9wMlmofhEm9uGvhtOnmdiaNzFMtaaCwe7avIcN9P3B421Zgz09OC6cUYxgDqVNsKIhQxBjFMeE2tVnYVgrkWlBsJbaMM6+U1Fe+pR9tCo40c5JzMP5cJR8EZKgag2TGMm4I1dhSGU0JU/uUhI9JqSKz8YB/w0Cxpe2onCHkZPVoTHTsvxu2lpkIa3HuVWN1jVV57l/G9PRKy6ZlWLcRVjqjDMwNPwJ79iPQLDmFzqP41oEPAJFtem55IuFuD3QqusIqFxkCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LDgpAet9Ej7oRPnwDxOZ58fM9jv5LP/m/HXsA3FgZ0=;
 b=gTT228CsucYBoAQcXZg5ADfL/1eHef93yuWQXoYi02ze8QuOfP8ZiTdebVYRL/KipqieDb+OqM+DvYUJRSB4FJ53xbszQF5TJvHoaOY0dkDadBt75Vjx8CVgcnsQGolM622KGsVe3OawaMNyrYHmZFQ7QJPAsW3b5oJqzcIdyyRTx3rUJei/74WNAWYi6dFtTPIKmJAyzzzsZD4TQxRRZaacECMcYITPK3IDRb4U6Tfj9v7hVlnXMcIiEEjrSmMBoDesg4Wy27wlWHZaixFsenKIjKj0xMxXVbGskD/akt0IxfEygiCNUBuRkCVbnqFCHBJ6WyhxABaxDML0vYv2Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LDgpAet9Ej7oRPnwDxOZ58fM9jv5LP/m/HXsA3FgZ0=;
 b=F3duSQu98MrsOWkolYpw69R9BaU9TI2xrYW3pP4wIfiS4xKqtgTLE0zcWadfsebKYWiiHzBDr4I33ZV9vEZIQo6la6k28H4lNiZV2EQo0/RS4QuKLHQSq81NpF9WylYngysJql4KoqVeJpuA33fRQT1Ix+Kg9p+ZYISDpN7qMpQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nxp.com;
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2458.eurprd04.prod.outlook.com (2603:10a6:3:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 09:22:00 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::5df8:1a69:47c3:44fc%3]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 09:22:00 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Yue Wang <yue.wang@Amlogic.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Jason Yan <yanaijie@huawei.com>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH] PCI: dwc: Change the inheritance between the abstracted structures
Date:   Tue,  6 Apr 2021 17:28:25 +0800
Message-Id: <20210406092825.24579-1-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [119.31.174.73]
X-ClientProxiedBy: HKAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:c9::9) To HE1PR0402MB3371.eurprd04.prod.outlook.com
 (2603:10a6:7:85::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (119.31.174.73) by HKAPR03CA0022.apcprd03.prod.outlook.com (2603:1096:203:c9::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend Transport; Tue, 6 Apr 2021 09:21:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5c2656c-ad99-4b02-bcc6-08d8f8dd6df4
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2458:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2458A25BE95CD80603B513FC84769@HE1PR0401MB2458.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CCYKVEML2PY++GPBvdTc/cMNtAYY8DX8IpVJ0CbaTw6DQhd0rN0lx4OzUsN0?=
 =?us-ascii?Q?Pz/zrlMyMJ1I0nJzxoBCrDzPuLLth6/jKzddvPMKSnzvk0XWGs6TJ/VG+Lwm?=
 =?us-ascii?Q?qEswjnauA7C9NO5mYfCelts48HXZIej+MzbVsF1YBxFGR2/Uj1REH+Ht/LhC?=
 =?us-ascii?Q?Szi265cDtRME9vSLyHtaRI9NAlAhy1NRqTJId2iFvfZjNTK3gwjrWyG0UtRW?=
 =?us-ascii?Q?PDywNolQvQUIrbfhrrkJ7OVpNfpYnb3NrnETGAyDQPddja3YgfFIEvo075i3?=
 =?us-ascii?Q?Jh3Wn+zGtFpi5A0qeDJttNGiRiXcG9lGFPeDEwnu8r4ikcEbmugH4NYaUzd6?=
 =?us-ascii?Q?GHTQ5vdNXjN0a1dmOxVRxNotmF3/DMBA+9iuOHyzjh61ycFZecPftNOpDcGq?=
 =?us-ascii?Q?C9Rcs8PQ8UlmcO6/KuiMw4600UB5yZXD4A/DaSOHEidhNtdxYVMAgWG9o0/A?=
 =?us-ascii?Q?Ys9+JqWg1pOmbxVFuhVpGktoaigcD8l/eCWosiwgAUruEmORupU8gnUNspTW?=
 =?us-ascii?Q?TFeukH3TXNL0lUMKH2NtsV4+as4rCkmf3+agfJB1XL0M+yynJgFlCtBfEsww?=
 =?us-ascii?Q?SOm+Lt1+IMlALQiVWy6N7HVD9CUMCB9DEtf853pffMP9AmMLfOqw5bWPAV2n?=
 =?us-ascii?Q?12SLOETEQZpJT9pHep85/exoFs/s3lKCbzxLUBmv+Z6DQHWex6CNhq2OTGkg?=
 =?us-ascii?Q?onJeiP/Sm2C0w3SSrNJdwHLD6Lj5OXpFu2Q9FtGOcf4nXl6AGd+nMHxKTLkb?=
 =?us-ascii?Q?Uzj4SUPM5yawPtCtyBxT3jYWZEz+Pfo8qDTfd3IWtMZdICEtdezKtQ0hNpfv?=
 =?us-ascii?Q?MSU5PPkDwmy8gscsjx0xSz03Do9jRBz+yroL4zBQvWbUj32rZtuG62ldywL2?=
 =?us-ascii?Q?YpU3JuxLndQLemK5H/WSzBThmJfb1jnL4zia4ZuavHIry/bEN/jmx9c2gVT8?=
 =?us-ascii?Q?1YHD2AXN0AR1++jzXmDeQ3WjV72v7lGYY1yGANgsTbcvv/EFQ6xuZNeawfz6?=
 =?us-ascii?Q?1ZZAD/pgIIKuF+pYnSnwasvbnRBZ1dXa+SI0mrvn8cSe/5drGtruQwLpuR6x?=
 =?us-ascii?Q?96DR/CzP?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:OSPM;SFS:(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(4326008)(478600001)(66946007)(66556008)(83380400001)(66476007)(16526019)(6512007)(38350700001)(8676002)(6506007)(86362001)(26005)(1076003)(52116002)(54906003)(6666004)(7416002)(69590400012)(38100700001)(2906002)(36756003)(186003)(6486002)(316002)(2616005)(30864003)(956004)(8936002)(5660300002)(218113003);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2wmT+Sh2Pn8qGSvZn8CQ9OuBdQH7JP0+I5m6i+uaNoWHRrqaDLsuEVurdLaB?=
 =?us-ascii?Q?pO8NOmtrc4I6lUJ5ztVyvQQsg0l4DEp/oQa6VZ8N2qE1M9AcJZqE6Qd9wkAn?=
 =?us-ascii?Q?lqtDORUAgy7a1WjkdviDdLnaNN80Ps7P1beIHthy/FlxsiYg+Hu78V7qms98?=
 =?us-ascii?Q?CQSSkqnZOc31/WSDG7RyrhSpd2z01SjacZhlfQEvkDZa/XwHkCCzp8p2Pv2d?=
 =?us-ascii?Q?/j4PsXlHsZWedc60QRQ3MbM2Kdw8akiiHavDTzBMiKbXZ1mnfjJ/Z3rah1yi?=
 =?us-ascii?Q?UCQIwo6qxmYPKDVDXO1I8g3GFQ0JDGTi8GlhCJcImGBA4WbJFoeKbHvmtf2O?=
 =?us-ascii?Q?fMxTLro9CE+GNXdnc+kkEacvO8vBN3h84MoYEuuJGd0Txq/BDnTd2l1hap8x?=
 =?us-ascii?Q?dKfXA/3TO2X+GMaPes3Bcq2W6tCFI0OVtUj3WXAU6krfiAJY5uq3Ij+Apuhm?=
 =?us-ascii?Q?klt6kFAK7TRfqiXhlCJu+AVy4um2PelyrQ0mFSLnGT656C5KhqG9k30x9KcL?=
 =?us-ascii?Q?KpufKKnxRf5B/jEC2VyONCoqBPN8GK5RLs2TkxfVVwTAX2CD4NbPgGSPYCAa?=
 =?us-ascii?Q?sy3QCCjEjH5OVxiwgRRCOCOdO0OyFQk4flSfNMYGNlNayMU0ZcLxzeZqy8Dn?=
 =?us-ascii?Q?IRAmeauNM7tBgYvCHWbCxVJrauoJIdv8iAdk+P4rmXp6Gjc2rogo2CYLiY5j?=
 =?us-ascii?Q?b/DtV4NpHlCx/l6eaEf8JyL3WMP+50SzLWFduWvROaw/klA7EFMMz5igqkGT?=
 =?us-ascii?Q?f8GkesLUaIooei17GV1CZF0wkoKF81S9+zzDz2t+HryyRhHDYTcJhQQxYJ8i?=
 =?us-ascii?Q?e/1z67j+Fg+T/kGAzSVdS9ie81L0F3px+TUHOF+TZslk3BMFxW3QNO8KYMxC?=
 =?us-ascii?Q?OvmKUD6Ce9rb8qoKrkjE8O7XLTULB7ZHqhjpnWsPBd6wMIs2nsgAzyg5KKDQ?=
 =?us-ascii?Q?3AwNl1xIR1b2HjHurbxx4OLvqGBnnGsr1MvQLzgz9GdCJ+9CNAbsu1pXLZWP?=
 =?us-ascii?Q?PuaNoI2oRQhFaeI8FULXMCnzvQU+AxxwQm/fCAe5LvjAgx6FQyg4oksfblZu?=
 =?us-ascii?Q?ahuSQiRo3HK2vlCpuccOXUeKkeeMNrwGjglNKP/rapY+03CM0wwxgISax6Qp?=
 =?us-ascii?Q?/sAMg6sRwitAV0QW0MS3in/xQp5BQIYygoeXd2P9tUeUSP6lqykH5HgEwShK?=
 =?us-ascii?Q?nBXPspcZ2LZdP+ItRL2owgg5japi8H91Fy61Nc9IvFfUgTq1fofAPlVHO/qJ?=
 =?us-ascii?Q?Y4OUsVuiHggCse5HQVuuM/vgjq8W6aJYIM5mHr1LmRtNIjGP7hhJaBDaY8d3?=
 =?us-ascii?Q?ZR4a9o+Kt+e4AzJ/aG4ucxag?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c2656c-ad99-4b02-bcc6-08d8f8dd6df4
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 09:21:59.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dtacQCOswCjHk4Wc3TnHQUErXy+tTdue69wOIx+cWzj1Vm126nUvVqxTS2XheoUHne588ORz22JexhF64lVQNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2458
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Currently the core struct dw_pcie includes both struct pcie_port
and dw_pcie_ep and the RC and EP platform drivers directly
includes the dw_pcie. So it results in a RC or EP platform driver
has 2 indirect parents pcie_port and dw_pcie_ep, but it doesn't
make sense let RC platform driver includes the dw_pcie_ep and
so does the EP platform driver.

This patch makes the struct pcie_port and dw_pcie_ep includes
the core struct dw_pcie and the RC and EP platform drivers
include struct pcie_port and dw_pcie_ep respectively.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Jonathan Chocron <jonnyc@amazon.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Jason Yan <yanaijie@huawei.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pci/controller/dwc/pci-dra7xx.c       |  74 +++++---
 drivers/pci/controller/dwc/pci-exynos.c       |  26 +--
 drivers/pci/controller/dwc/pci-imx6.c         |  46 +++--
 drivers/pci/controller/dwc/pci-keystone.c     |  79 +++++---
 .../pci/controller/dwc/pci-layerscape-ep.c    |  18 +-
 drivers/pci/controller/dwc/pci-layerscape.c   |  51 +++---
 drivers/pci/controller/dwc/pci-meson.c        |  25 +--
 drivers/pci/controller/dwc/pcie-al.c          |  21 ++-
 drivers/pci/controller/dwc/pcie-armada8k.c    |  17 +-
 drivers/pci/controller/dwc/pcie-artpec6.c     |  74 +++++---
 .../pci/controller/dwc/pcie-designware-host.c |   2 +-
 .../pci/controller/dwc/pcie-designware-plat.c |  38 ++--
 drivers/pci/controller/dwc/pcie-designware.h  |  72 ++++----
 drivers/pci/controller/dwc/pcie-histb.c       |  27 +--
 drivers/pci/controller/dwc/pcie-intel-gw.c    |  42 +++--
 drivers/pci/controller/dwc/pcie-kirin.c       |  42 +++--
 drivers/pci/controller/dwc/pcie-qcom.c        |  40 ++---
 drivers/pci/controller/dwc/pcie-spear13xx.c   |  16 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 169 +++++++++++-------
 drivers/pci/controller/dwc/pcie-uniphier-ep.c |  14 +-
 drivers/pci/controller/dwc/pcie-uniphier.c    |  17 +-
 21 files changed, 557 insertions(+), 353 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 12726c63366f..0e914df6eaba 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -85,7 +85,8 @@
 #define PCIE_B0_B1_TSYNCEN				BIT(0)
 
 struct dra7xx_pcie {
-	struct dw_pcie		*pci;
+	struct pcie_port	*pp;
+	struct dw_pcie_ep	*ep;
 	void __iomem		*base;		/* DT ti_conf */
 	int			phy_count;	/* DT phy-names count */
 	struct phy		**phy;
@@ -290,11 +291,19 @@ static void dra7xx_pcie_msi_irq_handler(struct irq_desc *desc)
 static irqreturn_t dra7xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct dra7xx_pcie *dra7xx = arg;
-	struct dw_pcie *pci = dra7xx->pci;
-	struct device *dev = pci->dev;
-	struct dw_pcie_ep *ep = &pci->ep;
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci;
+	struct device *dev;
 	u32 reg;
 
+	if (dra7xx->mode == DW_PCIE_RC_TYPE) {
+		pci = to_dw_pcie_from_pp(dra7xx->pp);
+	} else {
+		ep = dra7xx->ep;
+		pci = to_dw_pcie_from_ep(ep);
+	}
+
+	dev = pci->dev;
 	reg = dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);
 
 	if (reg & ERR_SYS)
@@ -447,11 +456,10 @@ static int __init dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 				     struct platform_device *pdev)
 {
 	int ret;
-	struct dw_pcie_ep *ep;
+	struct dw_pcie_ep *ep = dra7xx->ep;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = &pdev->dev;
-	struct dw_pcie *pci = dra7xx->pci;
 
-	ep = &pci->ep;
 	ep->ops = &pcie_ep_ops;
 
 	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "ep_dbics");
@@ -476,8 +484,8 @@ static int __init dra7xx_add_pcie_port(struct dra7xx_pcie *dra7xx,
 				       struct platform_device *pdev)
 {
 	int ret;
-	struct dw_pcie *pci = dra7xx->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = dra7xx->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 
 	pp->irq = platform_get_irq(pdev, 1);
@@ -693,6 +701,8 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	struct device_link **link;
 	void __iomem *base;
 	struct dw_pcie *pci;
+	struct pcie_port *pp;
+	struct dw_pcie_ep *ep;
 	struct dra7xx_pcie *dra7xx;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
@@ -715,13 +725,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 	if (!dra7xx)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
-	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -759,7 +762,6 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	dra7xx->base = base;
 	dra7xx->phy = phy;
-	dra7xx->pci = pci;
 	dra7xx->phy_count = phy_count;
 
 	if (phy_count == 2) {
@@ -796,6 +798,17 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
+		pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+		if (!pp) {
+			ret = -ENOMEM;
+			goto err_gpio;
+		}
+
+		pci = &pp->pcie;
+		pci->dev = dev;
+		pci->ops = &dw_pcie_ops;
+		dra7xx->pp = pp;
+
 		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_HOST)) {
 			ret = -ENODEV;
 			goto err_gpio;
@@ -813,6 +826,17 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 			goto err_gpio;
 		break;
 	case DW_PCIE_EP_TYPE:
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep) {
+			ret = -ENOMEM;
+			goto err_gpio;
+		}
+
+		pci = &ep->pcie;
+		pci->dev = dev;
+		pci->ops = &dw_pcie_ops;
+		dra7xx->ep = ep;
+
 		if (!IS_ENABLED(CONFIG_PCI_DRA7XX_EP)) {
 			ret = -ENODEV;
 			goto err_gpio;
@@ -860,12 +884,14 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
 static int dra7xx_pcie_suspend(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct dw_pcie *pci = dra7xx->pci;
+	struct dw_pcie *pci;
 	u32 val;
 
 	if (dra7xx->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
+	pci = to_dw_pcie_from_pp(dra7xx->pp);
+
 	/* clear MSE */
 	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val &= ~PCI_COMMAND_MEMORY;
@@ -877,12 +903,14 @@ static int dra7xx_pcie_suspend(struct device *dev)
 static int dra7xx_pcie_resume(struct device *dev)
 {
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
-	struct dw_pcie *pci = dra7xx->pci;
+	struct dw_pcie *pci;
 	u32 val;
 
 	if (dra7xx->mode != DW_PCIE_RC_TYPE)
 		return 0;
 
+	pci = to_dw_pcie_from_pp(dra7xx->pp);
+
 	/* set MSE */
 	val = dw_pcie_readl_dbi(pci, PCI_COMMAND);
 	val |= PCI_COMMAND_MEMORY;
@@ -919,9 +947,15 @@ static void dra7xx_pcie_shutdown(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dra7xx_pcie *dra7xx = dev_get_drvdata(dev);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(dra7xx->pp);
 	int ret;
 
-	dra7xx_pcie_stop_link(dra7xx->pci);
+	if (dra7xx->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(dra7xx->pp);
+	else
+		pci = to_dw_pcie_from_ep(dra7xx->ep);
+
+	dra7xx_pcie_stop_link(pci);
 
 	ret = pm_runtime_put_sync(dev);
 	if (ret < 0)
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index c24dab383654..ab5acfa79faa 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -51,7 +51,7 @@
 #define PCIE_ELBI_SLV_DBI_ENABLE	BIT(21)
 
 struct exynos_pcie {
-	struct dw_pcie			pci;
+	struct pcie_port		pp;
 	void __iomem			*elbi_base;
 	struct clk			*clk;
 	struct clk			*bus_clk;
@@ -61,7 +61,8 @@ struct exynos_pcie {
 
 static int exynos_pcie_init_clk_resources(struct exynos_pcie *ep)
 {
-	struct device *dev = ep->pci.dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&ep->pp);
+	struct device *dev = pci->dev;
 	int ret;
 
 	ret = clk_prepare_enable(ep->clk);
@@ -214,7 +215,8 @@ static void exynos_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (PCI_SLOT(devfn)) {
 		*val = ~0;
@@ -228,7 +230,8 @@ static int exynos_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 static int exynos_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
 				   int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -276,8 +279,7 @@ static const struct dw_pcie_host_ops exynos_pcie_host_ops = {
 static int exynos_add_pcie_port(struct exynos_pcie *ep,
 				       struct platform_device *pdev)
 {
-	struct dw_pcie *pci = &ep->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = &ep->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -315,6 +317,7 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct exynos_pcie *ep;
+	struct dw_pcie *pci;
 	struct device_node *np = dev->of_node;
 	int ret;
 
@@ -322,8 +325,9 @@ static int exynos_pcie_probe(struct platform_device *pdev)
 	if (!ep)
 		return -ENOMEM;
 
-	ep->pci.dev = dev;
-	ep->pci.ops = &dw_pcie_ops;
+	pci = &ep->pp.pcie;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	ep->phy = devm_of_phy_get(dev, np, NULL);
 	if (IS_ERR(ep->phy))
@@ -381,7 +385,7 @@ static int __exit exynos_pcie_remove(struct platform_device *pdev)
 {
 	struct exynos_pcie *ep = platform_get_drvdata(pdev);
 
-	dw_pcie_host_deinit(&ep->pci.pp);
+	dw_pcie_host_deinit(&ep->pp);
 	exynos_pcie_assert_core_reset(ep);
 	phy_power_off(ep->phy);
 	phy_exit(ep->phy);
@@ -406,8 +410,8 @@ static int __maybe_unused exynos_pcie_suspend_noirq(struct device *dev)
 static int __maybe_unused exynos_pcie_resume_noirq(struct device *dev)
 {
 	struct exynos_pcie *ep = dev_get_drvdata(dev);
-	struct dw_pcie *pci = &ep->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = &ep->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	int ret;
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0cf1333c0440..57a75a0a0d9f 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -61,7 +61,7 @@ struct imx6_pcie_drvdata {
 };
 
 struct imx6_pcie {
-	struct dw_pcie		*pci;
+	struct pcie_port	*pp;
 	int			reset_gpio;
 	bool			gpio_active_high;
 	struct clk		*pcie_bus;
@@ -143,7 +143,7 @@ struct imx6_pcie {
 
 static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	bool val;
 	u32 max_iterations = 10;
 	u32 wait_counter = 0;
@@ -164,7 +164,7 @@ static int pcie_phy_poll_ack(struct imx6_pcie *imx6_pcie, bool exp_val)
 
 static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	u32 val;
 	int ret;
 
@@ -187,7 +187,7 @@ static int pcie_phy_wait_ack(struct imx6_pcie *imx6_pcie, int addr)
 /* Read from the 16-bit PCIe PHY control registers (not memory-mapped) */
 static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	u32 phy_ctl;
 	int ret;
 
@@ -213,7 +213,7 @@ static int pcie_phy_read(struct imx6_pcie *imx6_pcie, int addr, u16 *data)
 
 static int pcie_phy_write(struct imx6_pcie *imx6_pcie, int addr, u16 data)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	u32 var;
 	int ret;
 
@@ -364,7 +364,8 @@ static int imx6_pcie_attach_pd(struct device *dev)
 
 static void imx6_pcie_assert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
+	struct device *dev = pci->dev;
 
 	switch (imx6_pcie->drvdata->variant) {
 	case IMX7D:
@@ -411,7 +412,7 @@ static unsigned int imx6_pcie_grp_offset(const struct imx6_pcie *imx6_pcie)
 
 static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	struct device *dev = pci->dev;
 	unsigned int offset;
 	int ret = 0;
@@ -471,7 +472,8 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 {
 	u32 val;
-	struct device *dev = imx6_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
+	struct device *dev = pci->dev;
 
 	if (regmap_read_poll_timeout(imx6_pcie->iomuxc_gpr,
 				     IOMUXC_GPR22, val,
@@ -483,7 +485,7 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx6_pcie *imx6_pcie)
 
 static void imx6_pcie_deassert_core_reset(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -663,6 +665,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 {
 	unsigned long phy_rate = clk_get_rate(imx6_pcie->pcie_phy);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	int mult, div;
 	u16 val;
 
@@ -685,7 +688,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 		div = 1;
 		break;
 	default:
-		dev_err(imx6_pcie->pci->dev,
+		dev_err(pci->dev,
 			"Unsupported PHY reference clock rate %lu\n", phy_rate);
 		return -EINVAL;
 	}
@@ -709,7 +712,7 @@ static int imx6_setup_phy_mpll(struct imx6_pcie *imx6_pcie)
 
 static int imx6_pcie_wait_for_speed_change(struct imx6_pcie *imx6_pcie)
 {
-	struct dw_pcie *pci = imx6_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
 	struct device *dev = pci->dev;
 	u32 tmp;
 	unsigned int retries;
@@ -867,7 +870,8 @@ static void imx6_pcie_ltssm_disable(struct device *dev)
 
 static void imx6_pcie_pm_turnoff(struct imx6_pcie *imx6_pcie)
 {
-	struct device *dev = imx6_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(imx6_pcie->pp);
+	struct device *dev = pci->dev;
 
 	/* Some variants have a turnoff reset in DT */
 	if (imx6_pcie->turnoff_reset) {
@@ -942,7 +946,8 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
-	struct pcie_port *pp = &imx6_pcie->pci->pp;
+	struct pcie_port *pp = imx6_pcie->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (!(imx6_pcie->drvdata->flags & IMX6_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
@@ -952,7 +957,7 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	imx6_pcie_deassert_core_reset(imx6_pcie);
 	dw_pcie_setup_rc(pp);
 
-	ret = imx6_pcie_start_link(imx6_pcie->pci);
+	ret = imx6_pcie_start_link(pci);
 	if (ret < 0)
 		dev_info(dev, "pcie link is down after resume.\n");
 
@@ -968,6 +973,7 @@ static const struct dev_pm_ops imx6_pcie_pm_ops = {
 static int imx6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct imx6_pcie *imx6_pcie;
 	struct device_node *np;
@@ -980,15 +986,17 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (!imx6_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx6_pcie_host_ops;
+	pp->ops = &imx6_pcie_host_ops;
+
+	imx6_pcie->pp = pp;
 
-	imx6_pcie->pci = pci;
 	imx6_pcie->drvdata = of_device_get_match_data(dev);
 
 	/* Find the PHY if one is defined, only imx7d uses it */
@@ -1136,7 +1144,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = dw_pcie_host_init(&pci->pp);
+	ret = dw_pcie_host_init(pp);
 	if (ret < 0)
 		return ret;
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 53aa35cb3a49..e11cb7efad5c 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -113,7 +113,8 @@ struct ks_pcie_of_data {
 };
 
 struct keystone_pcie {
-	struct dw_pcie		*pci;
+	struct pcie_port	*pp;
+	struct dw_pcie_ep	*ep;
 	/* PCI Device ID */
 	u32			device_id;
 	int			legacy_host_irqs[PCI_NUM_INTX];
@@ -256,7 +257,7 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 				      int offset)
 {
-	struct dw_pcie *pci = ks_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(ks_pcie->pp);
 	struct device *dev = pci->dev;
 	u32 pending;
 	int virq;
@@ -281,7 +282,8 @@ static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 static irqreturn_t ks_pcie_handle_error_irq(struct keystone_pcie *ks_pcie)
 {
 	u32 reg;
-	struct device *dev = ks_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(ks_pcie->pp);
+	struct device *dev = pci->dev;
 
 	reg = ks_pcie_app_readl(ks_pcie, ERR_IRQ_STATUS);
 	if (!reg)
@@ -388,8 +390,8 @@ static void ks_pcie_setup_rc_app_regs(struct keystone_pcie *ks_pcie)
 {
 	u32 val;
 	u32 num_viewport = ks_pcie->num_viewport;
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = ks_pcie->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 start, end;
 	struct resource *mem;
 	int i;
@@ -569,8 +571,8 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	unsigned int irq = desc->irq_data.hwirq;
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irq;
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = ks_pcie->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	u32 vector, virq, reg, pos;
@@ -615,7 +617,7 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	struct dw_pcie *pci = ks_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(ks_pcie->pp);
 	struct device *dev = pci->dev;
 	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -634,7 +636,8 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 
 static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 {
-	struct device *dev = ks_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(ks_pcie->pp);
+	struct device *dev = pci->dev;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
 	struct irq_data *irq_data;
@@ -688,7 +691,8 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 
 static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 {
-	struct device *dev = ks_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(ks_pcie->pp);
+	struct device *dev = pci->dev;
 	struct irq_domain *legacy_irq_domain;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
@@ -771,7 +775,7 @@ static int __init ks_pcie_init_id(struct keystone_pcie *ks_pcie)
 	int ret;
 	unsigned int id;
 	struct regmap *devctrl_regs;
-	struct dw_pcie *pci = ks_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(ks_pcie->pp);
 	struct device *dev = pci->dev;
 	struct device_node *np = dev->of_node;
 
@@ -875,7 +879,7 @@ static void ks_pcie_am654_ep_init(struct dw_pcie_ep *ep)
 
 static void ks_pcie_am654_raise_legacy_irq(struct keystone_pcie *ks_pcie)
 {
-	struct dw_pcie *pci = ks_pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ks_pcie->ep);
 	u8 int_pin;
 
 	int_pin = dw_pcie_readb_dbi(pci, PCI_INTERRUPT_PIN);
@@ -1087,6 +1091,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	const struct ks_pcie_of_data *data;
 	const struct of_device_id *match;
 	enum dw_pcie_device_mode mode;
+	struct dw_pcie_ep *ep;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
@@ -1116,10 +1122,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (!ks_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "app");
 	ks_pcie->va_app_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(ks_pcie->va_app_base))
@@ -1135,12 +1137,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(np, "ti,am654-pcie-rc"))
 		ks_pcie->is_am6 = true;
 
-	pci->dbi_base = base;
-	pci->dbi_base2 = base;
-	pci->dev = dev;
-	pci->ops = &ks_pcie_dw_pcie_ops;
-	pci->version = version;
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
 		return irq;
@@ -1184,7 +1180,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	}
 
 	ks_pcie->np = np;
-	ks_pcie->pci = pci;
 	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
 	ks_pcie->phy = phy;
@@ -1212,7 +1207,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
-	if (pci->version >= 0x480A)
+	if (version >= 0x480A)
 		ret = ks_pcie_am654_set_mode(dev, mode);
 	else
 		ret = ks_pcie_set_mode(dev);
@@ -1221,6 +1216,20 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 	switch (mode) {
 	case DW_PCIE_RC_TYPE:
+		pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+		if (!pp) {
+			ret = -ENOMEM;
+			goto err_get_sync;
+		}
+
+		ks_pcie->pp = pp;
+		pci = &pp->pcie;
+		pci->dbi_base = base;
+		pci->dbi_base2 = base;
+		pci->dev = dev;
+		pci->ops = &ks_pcie_dw_pcie_ops;
+		pci->version = version;
+
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
 			ret = -ENODEV;
 			goto err_get_sync;
@@ -1246,19 +1255,33 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		}
 
 		ks_pcie->num_viewport = num_viewport;
-		pci->pp.ops = host_ops;
-		ret = dw_pcie_host_init(&pci->pp);
+		pp->ops = host_ops;
+		ret = dw_pcie_host_init(pp);
 		if (ret < 0)
 			goto err_get_sync;
 		break;
 	case DW_PCIE_EP_TYPE:
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep) {
+			ret = -ENOMEM;
+			goto err_get_sync;
+		}
+
+		ks_pcie->ep = ep;
+		pci = &ep->pcie;
+		pci->dbi_base = base;
+		pci->dbi_base2 = base;
+		pci->dev = dev;
+		pci->ops = &ks_pcie_dw_pcie_ops;
+		pci->version = version;
+
 		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_EP)) {
 			ret = -ENODEV;
 			goto err_get_sync;
 		}
 
-		pci->ep.ops = ep_ops;
-		ret = dw_pcie_ep_init(&pci->ep);
+		ep->ops = ep_ops;
+		ret = dw_pcie_ep_init(ep);
 		if (ret < 0)
 			goto err_get_sync;
 		break;
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index dcee95e16139..ab58dedac401 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -27,7 +27,7 @@ struct ls_pcie_ep_drvdata {
 };
 
 struct ls_pcie_ep {
-	struct dw_pcie			*pci;
+	struct dw_pcie_ep		*ep;
 	struct pci_epc_features		*ls_epc;
 	const struct ls_pcie_ep_drvdata *drvdata;
 };
@@ -126,6 +126,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
+	struct dw_pcie_ep *ep;
 	struct ls_pcie_ep *pcie;
 	struct pci_epc_features *ls_epc;
 	struct resource *dbi_base;
@@ -134,22 +135,23 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+	if (!ep)
 		return -ENOMEM;
 
 	ls_epc = devm_kzalloc(dev, sizeof(*ls_epc), GFP_KERNEL);
 	if (!ls_epc)
 		return -ENOMEM;
 
+	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
+
 	pcie->drvdata = of_device_get_match_data(dev);
 
+	pci = &ep->pcie;
 	pci->dev = dev;
 	pci->ops = pcie->drvdata->dw_pcie_ops;
 
-	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4),
-
-	pcie->pci = pci;
+	pcie->ep = ep;
 	pcie->ls_epc = ls_epc;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
@@ -157,11 +159,11 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	if (IS_ERR(pci->dbi_base))
 		return PTR_ERR(pci->dbi_base);
 
-	pci->ep.ops = &ls_pcie_ep_ops;
+	ep->ops = &ls_pcie_ep_ops;
 
 	platform_set_drvdata(pdev, pcie);
 
-	return dw_pcie_ep_init(&pci->ep);
+	return dw_pcie_ep_init(ep);
 }
 
 static struct platform_driver ls_pcie_ep_driver = {
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index a590194c0f95..6ac4fb8a9211 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -71,7 +71,7 @@ struct ls_pcie_drvdata {
 };
 
 struct ls_pcie {
-	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	const struct ls_pcie_drvdata *drvdata;
 	void __iomem *pf_base;
 	void __iomem *lut_base;
@@ -88,7 +88,7 @@ struct ls_pcie {
 
 static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 {
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	u32 header_type;
 
 	header_type = ioread8(pci->dbi_base + PCI_HEADER_TYPE);
@@ -100,7 +100,7 @@ static bool ls_pcie_is_bridge(struct ls_pcie *pcie)
 /* Clear multi-function bit */
 static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
 {
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	iowrite8(PCI_HEADER_TYPE_BRIDGE, pci->dbi_base + PCI_HEADER_TYPE);
 }
@@ -109,7 +109,7 @@ static void ls_pcie_clear_multifunction(struct ls_pcie *pcie)
 static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 {
 	u32 val;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	val = ioread32(pci->dbi_base + PCIE_STRFMR1);
 	val &= 0xDFFFFFFF;
@@ -119,7 +119,7 @@ static void ls_pcie_drop_msg_tlp(struct ls_pcie *pcie)
 /* Forward error response of outbound non-posted requests */
 static void ls_pcie_fix_error_response(struct ls_pcie *pcie)
 {
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	iowrite32(PCIE_ABSERR_SETTING, pci->dbi_base + PCIE_ABSERR);
 }
@@ -162,6 +162,7 @@ static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
 {
 	u32 val;
 	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
 	val |= PF_MCR_PTOMR;
@@ -170,15 +171,16 @@ static void ls_pcie_send_turnoff_msg(struct ls_pcie *pcie)
 	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
 				 val, !(val & PF_MCR_PTOMR), 100, 10000);
 	if (ret)
-		dev_info(pcie->pci->dev, "poll turn off message timeout\n");
+		dev_info(pci->dev, "poll turn off message timeout\n");
 }
 
 static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
 {
 	u32 val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	if (!pcie->scfg) {
-		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		dev_dbg(pci->dev, "SYSCFG is NULL\n");
 		return;
 	}
 
@@ -198,9 +200,10 @@ static void ls1021a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
 static void ls1043a_pcie_send_turnoff_msg(struct ls_pcie *pcie)
 {
 	u32 val;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	if (!pcie->scfg) {
-		dev_dbg(pcie->pci->dev, "SYSCFG is NULL\n");
+		dev_dbg(pci->dev, "SYSCFG is NULL\n");
 		return;
 	}
 
@@ -221,6 +224,7 @@ static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
 {
 	u32 val;
 	int ret;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 
 	val = ls_pcie_pf_readl(pcie, LS_PCIE_PF_MCR);
 	val |= PF_MCR_EXL2S;
@@ -229,12 +233,12 @@ static void ls_pcie_exit_from_l2(struct ls_pcie *pcie)
 	ret = readx_poll_timeout(ls_pcie_pf_readl_addr, LS_PCIE_PF_MCR,
 				 val, !(val & PF_MCR_EXL2S), 100, 10000);
 	if (ret)
-		dev_info(pcie->pci->dev, "poll exit L2 state timeout\n");
+		dev_info(pci->dev, "poll exit L2 state timeout\n");
 }
 
 static void ls_pcie_retrain_link(struct ls_pcie *pcie)
 {
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
@@ -286,7 +290,8 @@ static void ls1043a_pcie_exit_from_l2(struct ls_pcie *pcie)
 
 static int ls1021a_pcie_pm_init(struct ls_pcie *pcie)
 {
-	struct device *dev = pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
+	struct device *dev = pci->dev;
 	u32 index[2];
 	int ret;
 
@@ -318,7 +323,7 @@ static int ls_pcie_pm_init(struct ls_pcie *pcie)
 
 static void ls_pcie_set_dstate(struct ls_pcie *pcie, u32 dstate)
 {
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_PM);
 	u32 val;
 
@@ -410,6 +415,7 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	struct ls_pcie *pcie;
 	struct resource *dbi_base;
 
@@ -417,16 +423,17 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
 	pcie->drvdata = of_device_get_match_data(dev);
 
+	pci = &pp->pcie;
 	pci->dev = dev;
-	pci->pp.ops = pcie->drvdata->ops;
+	pp->ops = pcie->drvdata->ops;
 
-	pcie->pci = pci;
+	pcie->pp = pp;
 
 	dbi_base = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
 	pci->dbi_base = devm_pci_remap_cfg_resource(dev, dbi_base);
@@ -446,13 +453,15 @@ static int __init ls_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
-	return dw_pcie_host_init(&pci->pp);
+	return dw_pcie_host_init(pp);
 }
 
 static bool ls_pcie_pm_check(struct ls_pcie *pcie)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
+
 	if (!pcie->ep_presence) {
-		dev_dbg(pcie->pci->dev, "Endpoint isn't present\n");
+		dev_dbg(pci->dev, "Endpoint isn't present\n");
 		return false;
 	}
 
@@ -466,7 +475,7 @@ static bool ls_pcie_pm_check(struct ls_pcie *pcie)
 static int ls_pcie_suspend_noirq(struct device *dev)
 {
 	struct ls_pcie *pcie = dev_get_drvdata(dev);
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	u32 val;
 	int ret;
 
@@ -491,7 +500,7 @@ static int ls_pcie_suspend_noirq(struct device *dev)
 static int ls_pcie_resume_noirq(struct device *dev)
 {
 	struct ls_pcie *pcie = dev_get_drvdata(dev);
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	int ret;
 
 	if (!ls_pcie_pm_check(pcie))
@@ -504,7 +513,7 @@ static int ls_pcie_resume_noirq(struct device *dev)
 	/* delay 10ms to access EP */
 	mdelay(10);
 
-	ret = ls_pcie_host_init(&pci->pp);
+	ret = ls_pcie_host_init(pcie->pp);
 	if (ret) {
 		dev_err(dev, "ls_pcie_host_init failed! ret = 0x%x\n", ret);
 		return ret;
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 686ded034f22..895df30cb497 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -65,7 +65,7 @@ struct meson_pcie_rc_reset {
 };
 
 struct meson_pcie {
-	struct dw_pcie pci;
+	struct pcie_port pp;
 	void __iomem *cfg_base;
 	struct meson_pcie_clk_res clk_res;
 	struct meson_pcie_rc_reset mrst;
@@ -77,7 +77,8 @@ static struct reset_control *meson_pcie_get_reset(struct meson_pcie *mp,
 						  const char *id,
 						  u32 reset_type)
 {
-	struct device *dev = mp->pci.dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&mp->pp);
+	struct device *dev = pci->dev;
 	struct reset_control *reset;
 
 	if (reset_type == PCIE_SHARED_RESET)
@@ -108,7 +109,7 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
 static int meson_pcie_get_mems(struct platform_device *pdev,
 			       struct meson_pcie *mp)
 {
-	struct dw_pcie *pci = &mp->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&mp->pp);
 
 	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
 	if (IS_ERR(pci->dbi_base))
@@ -196,7 +197,8 @@ static inline struct clk *meson_pcie_probe_clock(struct device *dev,
 
 static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 {
-	struct device *dev = mp->pci.dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&mp->pp);
+	struct device *dev = pci->dev;
 	struct meson_pcie_clk_res *res = &mp->clk_res;
 
 	res->port_clk = meson_pcie_probe_clock(dev, "port", PORT_CLK_RATE);
@@ -242,7 +244,8 @@ static void meson_pcie_ltssm_enable(struct meson_pcie *mp)
 
 static int meson_size_to_payload(struct meson_pcie *mp, int size)
 {
-	struct device *dev = mp->pci.dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&mp->pp);
+	struct device *dev = pci->dev;
 
 	/*
 	 * dwc supports 2^(val+7) payload size, which val is 0~5 default to 1.
@@ -259,7 +262,7 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
 
 static void meson_set_max_payload(struct meson_pcie *mp, int size)
 {
-	struct dw_pcie *pci = &mp->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&mp->pp);
 	u32 val;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int max_payload_size = meson_size_to_payload(mp, size);
@@ -275,7 +278,7 @@ static void meson_set_max_payload(struct meson_pcie *mp, int size)
 
 static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
-	struct dw_pcie *pci = &mp->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&mp->pp);
 	u32 val;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int max_rd_req_size = meson_size_to_payload(mp, size);
@@ -395,6 +398,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static int meson_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct meson_pcie *mp;
 	int ret;
@@ -403,10 +407,11 @@ static int meson_pcie_probe(struct platform_device *pdev)
 	if (!mp)
 		return -ENOMEM;
 
-	pci = &mp->pci;
+	pp = &mp->pp;
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &meson_pcie_host_ops;
+	pp->ops = &meson_pcie_host_ops;
 	pci->num_lanes = 1;
 
 	mp->phy = devm_phy_get(dev, "pcie");
@@ -453,7 +458,7 @@ static int meson_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mp);
 
-	ret = dw_pcie_host_init(&pci->pp);
+	ret = dw_pcie_host_init(pp);
 	if (ret < 0) {
 		dev_err(dev, "Add PCIe port failed, %d\n", ret);
 		goto err_phy;
diff --git a/drivers/pci/controller/dwc/pcie-al.c b/drivers/pci/controller/dwc/pcie-al.c
index abf37aa68e51..e9d438354275 100644
--- a/drivers/pci/controller/dwc/pcie-al.c
+++ b/drivers/pci/controller/dwc/pcie-al.c
@@ -128,7 +128,7 @@ struct al_pcie_target_bus_cfg {
 };
 
 struct al_pcie {
-	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	void __iomem *controller_base; /* base of PCIe unit (not DW core) */
 	struct device *dev;
 	resource_size_t ecam_size;
@@ -218,14 +218,15 @@ static void __iomem *al_pcie_conf_addr_map_bus(struct pci_bus *bus,
 					       unsigned int devfn, int where)
 {
 	struct pcie_port *pp = bus->sysdata;
-	struct al_pcie *pcie = to_al_pcie(to_dw_pcie_from_pp(pp));
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct al_pcie *pcie = to_al_pcie(pci);
 	unsigned int busnr = bus->number;
 	struct al_pcie_target_bus_cfg *target_bus_cfg = &pcie->target_bus_cfg;
 	unsigned int busnr_ecam = busnr & target_bus_cfg->ecam_mask;
 	unsigned int busnr_reg = busnr & target_bus_cfg->reg_mask;
 
 	if (busnr_reg != target_bus_cfg->reg_val) {
-		dev_dbg(pcie->pci->dev, "Changing target bus busnum val from 0x%x to 0x%x\n",
+		dev_dbg(pci->dev, "Changing target bus busnum val from 0x%x to 0x%x\n",
 			target_bus_cfg->reg_val, busnr_reg);
 		target_bus_cfg->reg_val = busnr_reg;
 		al_pcie_target_bus_set(pcie,
@@ -245,7 +246,7 @@ static struct pci_ops al_child_pci_ops = {
 static void al_pcie_config_prepare(struct al_pcie *pcie)
 {
 	struct al_pcie_target_bus_cfg *target_bus_cfg;
-	struct pcie_port *pp = &pcie->pci->pp;
+	struct pcie_port *pp = pcie->pp;
 	unsigned int ecam_bus_mask;
 	u32 cfg_control_offset;
 	u8 subordinate_bus;
@@ -323,21 +324,23 @@ static int al_pcie_probe(struct platform_device *pdev)
 	struct resource *controller_res;
 	struct resource *ecam_res;
 	struct al_pcie *al_pcie;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 
 	al_pcie = devm_kzalloc(dev, sizeof(*al_pcie), GFP_KERNEL);
 	if (!al_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &al_pcie_host_ops;
+	pp->ops = &al_pcie_host_ops;
 
-	al_pcie->pci = pci;
+	al_pcie->pp = pp;
 	al_pcie->dev = dev;
 
 	ecam_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
@@ -360,7 +363,7 @@ static int al_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, al_pcie);
 
-	return dw_pcie_host_init(&pci->pp);
+	return dw_pcie_host_init(pp);
 }
 
 static const struct of_device_id al_pcie_of_match[] = {
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index 4e2552dcf982..484cb1deddaa 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -28,7 +28,7 @@
 #define ARMADA8K_PCIE_MAX_LANES PCIE_LNK_X4
 
 struct armada8k_pcie {
-	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	struct clk *clk;
 	struct clk *clk_reg;
 	struct phy *phy[ARMADA8K_PCIE_MAX_LANES];
@@ -110,7 +110,7 @@ static int armada8k_pcie_enable_phys(struct armada8k_pcie *pcie)
 
 static int armada8k_pcie_setup_phys(struct armada8k_pcie *pcie)
 {
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	struct device_node *node = dev->of_node;
 	int ret = 0;
@@ -211,7 +211,7 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
 static irqreturn_t armada8k_pcie_irq_handler(int irq, void *arg)
 {
 	struct armada8k_pcie *pcie = arg;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	u32 val;
 
 	/*
@@ -232,8 +232,7 @@ static const struct dw_pcie_host_ops armada8k_pcie_host_ops = {
 static int armada8k_add_pcie_port(struct armada8k_pcie *pcie,
 				  struct platform_device *pdev)
 {
-	struct dw_pcie *pci = pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = pcie->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -267,6 +266,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static int armada8k_pcie_probe(struct platform_device *pdev)
 {
 	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	struct armada8k_pcie *pcie;
 	struct device *dev = &pdev->dev;
 	struct resource *base;
@@ -276,14 +276,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
-	pcie->pci = pci;
+	pcie->pp = pp;
 
 	pcie->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(pcie->clk))
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index f833daf6d422..f1ccd74eff9d 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -30,7 +30,8 @@ enum artpec_pcie_variants {
 };
 
 struct artpec6_pcie {
-	struct dw_pcie		*pci;
+	struct pcie_port	*pp;
+	struct dw_pcie_ep	*ep;
 	struct regmap		*regmap;	/* DT axis,syscon-pcie */
 	void __iomem		*phy_base;	/* DT phy */
 	enum artpec_pcie_variants variant;
@@ -97,8 +98,8 @@ static void artpec6_pcie_writel(struct artpec6_pcie *artpec6_pcie, u32 offset, u
 static u64 artpec6_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 pci_addr)
 {
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
-	struct pcie_port *pp = &pci->pp;
-	struct dw_pcie_ep *ep = &pci->ep;
+	struct pcie_port *pp = artpec6_pcie->pp;
+	struct dw_pcie_ep *ep = artpec6_pcie->ep;
 
 	switch (artpec6_pcie->mode) {
 	case DW_PCIE_RC_TYPE:
@@ -141,11 +142,18 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 
 static void artpec6_pcie_wait_for_phy_a6(struct artpec6_pcie *artpec6_pcie)
 {
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	struct device *dev = pci->dev;
+	struct dw_pcie *pci;
+	struct device *dev;
 	u32 val;
 	unsigned int retries;
 
+	if (artpec6_pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(artpec6_pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(artpec6_pcie->ep);
+
+	dev = pci->dev;
+
 	retries = 50;
 	do {
 		usleep_range(1000, 2000);
@@ -168,12 +176,19 @@ static void artpec6_pcie_wait_for_phy_a6(struct artpec6_pcie *artpec6_pcie)
 
 static void artpec6_pcie_wait_for_phy_a7(struct artpec6_pcie *artpec6_pcie)
 {
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	struct device *dev = pci->dev;
+	struct dw_pcie *pci;
+	struct device *dev;
 	u32 val;
 	u16 phy_status_tx, phy_status_rx;
 	unsigned int retries;
 
+	if (artpec6_pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(artpec6_pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(artpec6_pcie->ep);
+
+	dev = pci->dev;
+
 	retries = 50;
 	do {
 		usleep_range(1000, 2000);
@@ -240,10 +255,15 @@ static void artpec6_pcie_init_phy_a6(struct artpec6_pcie *artpec6_pcie)
 
 static void artpec6_pcie_init_phy_a7(struct artpec6_pcie *artpec6_pcie)
 {
-	struct dw_pcie *pci = artpec6_pcie->pci;
+	struct dw_pcie *pci;
 	u32 val;
 	bool extrefclk;
 
+	if (artpec6_pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(artpec6_pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(artpec6_pcie->ep);
+
 	/* Check if external reference clock is connected */
 	val = artpec6_pcie_readl(artpec6_pcie, PCIESTAT);
 	extrefclk = !!(val & PCIESTAT_EXTREFCLK);
@@ -377,6 +397,8 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 static int artpec6_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct dw_pcie_ep *ep;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct artpec6_pcie *artpec6_pcie;
 	int ret;
@@ -397,14 +419,6 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 	if (!artpec6_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
-	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
-
-	artpec6_pcie->pci = pci;
 	artpec6_pcie->variant = variant;
 	artpec6_pcie->mode = mode;
 
@@ -423,18 +437,38 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 	switch (artpec6_pcie->mode) {
 	case DW_PCIE_RC_TYPE:
+		pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+
+		pci = &pp->pcie;
+		pci->dev = dev;
+		pci->ops = &dw_pcie_ops;
+
+		artpec6_pcie->pp = pp;
+
 		if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_HOST))
 			return -ENODEV;
 
-		pci->pp.ops = &artpec6_pcie_host_ops;
+		pp->ops = &artpec6_pcie_host_ops;
 
-		ret = dw_pcie_host_init(&pci->pp);
+		ret = dw_pcie_host_init(pp);
 		if (ret < 0)
 			return ret;
 		break;
 	case DW_PCIE_EP_TYPE: {
 		u32 val;
 
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+
+		pci = &ep->pcie;
+		pci->dev = dev;
+		pci->ops = &dw_pcie_ops;
+
+		artpec6_pcie->ep = ep;
+
 		if (!IS_ENABLED(CONFIG_PCIE_ARTPEC6_EP))
 			return -ENODEV;
 
@@ -442,9 +476,9 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 		val &= ~PCIECFG_DEVICE_TYPE_MASK;
 		artpec6_pcie_writel(artpec6_pcie, PCIECFG, val);
 
-		pci->ep.ops = &pcie_ep_ops;
+		ep->ops = &pcie_ep_ops;
 
-		return dw_pcie_ep_init(&pci->ep);
+		return dw_pcie_ep_init(ep);
 		break;
 	}
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0413284fdd93..27292e2f3389 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -299,7 +299,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 	struct resource *cfg_res;
 	int ret;
 
-	raw_spin_lock_init(&pci->pp.lock);
+	raw_spin_lock_init(&pp->lock);
 
 	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "config");
 	if (cfg_res) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 49d51584a547..8aac7f6cef08 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -22,7 +22,8 @@
 #include "pcie-designware.h"
 
 struct dw_plat_pcie {
-	struct dw_pcie			*pci;
+	struct pcie_port		*pp;
+	struct dw_pcie_ep		*ep;
 	struct regmap			*regmap;
 	enum dw_pcie_device_mode	mode;
 };
@@ -94,8 +95,7 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 static int dw_plat_add_pcie_port(struct dw_plat_pcie *dw_plat_pcie,
 				 struct platform_device *pdev)
 {
-	struct dw_pcie *pci = dw_plat_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = dw_plat_pcie->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -119,6 +119,8 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct dw_plat_pcie *dw_plat_pcie;
+	struct dw_pcie_ep *ep;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	int ret;
 	const struct of_device_id *match;
@@ -136,20 +138,21 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 	if (!dw_plat_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
-		return -ENOMEM;
-
-	pci->dev = dev;
-	pci->ops = &dw_pcie_ops;
-
-	dw_plat_pcie->pci = pci;
 	dw_plat_pcie->mode = mode;
 
 	platform_set_drvdata(pdev, dw_plat_pcie);
 
 	switch (dw_plat_pcie->mode) {
 	case DW_PCIE_RC_TYPE:
+		pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+		if (!pp)
+			return -ENOMEM;
+
+		pci = &pp->pcie;
+		pci->dev = dev;
+		pci->ops = &dw_pcie_ops;
+		dw_plat_pcie->pp = pp;
+
 		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_HOST))
 			return -ENODEV;
 
@@ -158,11 +161,20 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 			return ret;
 		break;
 	case DW_PCIE_EP_TYPE:
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+
+		pci = &ep->pcie;
+		pci->dev = dev;
+		pci->ops = &dw_pcie_ops;
+		dw_plat_pcie->ep = ep;
+
 		if (!IS_ENABLED(CONFIG_PCIE_DW_PLAT_EP))
 			return -ENODEV;
 
-		pci->ep.ops = &pcie_ep_ops;
-		return dw_pcie_ep_init(&pci->ep);
+		ep->ops = &pcie_ep_ops;
+		return dw_pcie_ep_init(ep);
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 10ba09237def..689c4c89e1f6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -171,12 +171,44 @@ enum dw_pcie_device_mode {
 	DW_PCIE_RC_TYPE,
 };
 
+struct dw_pcie_ops {
+	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
+	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			    size_t size);
+	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			     size_t size, u32 val);
+	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
+			      size_t size, u32 val);
+	int	(*link_up)(struct dw_pcie *pcie);
+	int	(*start_link)(struct dw_pcie *pcie);
+	void	(*stop_link)(struct dw_pcie *pcie);
+};
+
+struct dw_pcie {
+	struct device		*dev;
+	void __iomem		*dbi_base;
+	void __iomem		*dbi_base2;
+	/* Used when iatu_unroll_enabled is true */
+	void __iomem		*atu_base;
+	size_t			atu_size;
+	u32			num_ib_windows;
+	u32			num_ob_windows;
+	const struct dw_pcie_ops *ops;
+	unsigned int		version;
+	int			num_lanes;
+	int			link_gen;
+	u8			n_fts[2];
+	bool			iatu_unroll_enabled: 1;
+	bool			io_cfg_atu_shared: 1;
+};
+
 struct dw_pcie_host_ops {
 	int (*host_init)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
 };
 
 struct pcie_port {
+	struct dw_pcie		pcie;
 	bool			has_msi_ctrl:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
@@ -228,6 +260,7 @@ struct dw_pcie_ep_func {
 };
 
 struct dw_pcie_ep {
+	struct dw_pcie		pcie;
 	struct pci_epc		*epc;
 	struct dw_pcie_ep_func	*funcs;
 	const struct dw_pcie_ep_ops *ops;
@@ -243,43 +276,8 @@ struct dw_pcie_ep {
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
 };
 
-struct dw_pcie_ops {
-	u64	(*cpu_addr_fixup)(struct dw_pcie *pcie, u64 cpu_addr);
-	u32	(*read_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-			    size_t size);
-	void	(*write_dbi)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-			     size_t size, u32 val);
-	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
-			      size_t size, u32 val);
-	int	(*link_up)(struct dw_pcie *pcie);
-	int	(*start_link)(struct dw_pcie *pcie);
-	void	(*stop_link)(struct dw_pcie *pcie);
-};
-
-struct dw_pcie {
-	struct device		*dev;
-	void __iomem		*dbi_base;
-	void __iomem		*dbi_base2;
-	/* Used when iatu_unroll_enabled is true */
-	void __iomem		*atu_base;
-	size_t			atu_size;
-	u32			num_ib_windows;
-	u32			num_ob_windows;
-	struct pcie_port	pp;
-	struct dw_pcie_ep	ep;
-	const struct dw_pcie_ops *ops;
-	unsigned int		version;
-	int			num_lanes;
-	int			link_gen;
-	u8			n_fts[2];
-	bool			iatu_unroll_enabled: 1;
-	bool			io_cfg_atu_shared: 1;
-};
-
-#define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
-
-#define to_dw_pcie_from_ep(endpoint)   \
-		container_of((endpoint), struct dw_pcie, ep)
+#define to_dw_pcie_from_pp(port)	(&(port)->pcie)
+#define to_dw_pcie_from_ep(endpoint)	(&(endpoint)->pcie)
 
 u8 dw_pcie_find_capability(struct dw_pcie *pci, u8 cap);
 u16 dw_pcie_find_ext_capability(struct dw_pcie *pci, u8 cap);
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 86f9d16c50d7..62d7ae4fb14b 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -50,7 +50,7 @@
 #define PCIE_LTSSM_STATE_ACTIVE		0x11
 
 struct histb_pcie {
-	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	struct clk *aux_clk;
 	struct clk *pipe_clk;
 	struct clk *sys_clk;
@@ -105,11 +105,12 @@ static void histb_pcie_dbi_r_mode(struct pcie_port *pp, bool enable)
 static u32 histb_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
 			       u32 reg, size_t size)
 {
+	struct histb_pcie *hipcie = to_histb_pcie(pci);
 	u32 val;
 
-	histb_pcie_dbi_r_mode(&pci->pp, true);
+	histb_pcie_dbi_r_mode(hipcie->pp, true);
 	dw_pcie_read(base + reg, size, &val);
-	histb_pcie_dbi_r_mode(&pci->pp, false);
+	histb_pcie_dbi_r_mode(hipcie->pp, false);
 
 	return val;
 }
@@ -117,15 +118,18 @@ static u32 histb_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
 static void histb_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
 				 u32 reg, size_t size, u32 val)
 {
-	histb_pcie_dbi_w_mode(&pci->pp, true);
+	struct histb_pcie *hipcie = to_histb_pcie(pci);
+
+	histb_pcie_dbi_w_mode(hipcie->pp, true);
 	dw_pcie_write(base + reg, size, val);
-	histb_pcie_dbi_w_mode(&pci->pp, false);
+	histb_pcie_dbi_w_mode(hipcie->pp, false);
 }
 
 static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (PCI_SLOT(devfn)) {
 		*val = ~0;
@@ -139,7 +143,8 @@ static int histb_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 static int histb_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -310,12 +315,12 @@ static int histb_pcie_probe(struct platform_device *pdev)
 	if (!hipcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
-	hipcie->pci = pci;
-	pp = &pci->pp;
+	hipcie->pp = pp;
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 0cedd1f95f37..29d56bda2550 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -61,7 +61,7 @@ struct intel_pcie_soc {
 };
 
 struct intel_pcie_port {
-	struct dw_pcie		pci;
+	struct pcie_port	pp;
 	void __iomem		*app_base;
 	struct gpio_desc	*reset_gpio;
 	u32			rst_intrvl;
@@ -99,18 +99,24 @@ static void pcie_app_wr_mask(struct intel_pcie_port *lpp, u32 ofs,
 
 static inline u32 pcie_rc_cfg_rd(struct intel_pcie_port *lpp, u32 ofs)
 {
-	return dw_pcie_readl_dbi(&lpp->pci, ofs);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
+
+	return dw_pcie_readl_dbi(pci, ofs);
 }
 
 static inline void pcie_rc_cfg_wr(struct intel_pcie_port *lpp, u32 ofs, u32 val)
 {
-	dw_pcie_writel_dbi(&lpp->pci, ofs, val);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
+
+	dw_pcie_writel_dbi(pci, ofs, val);
 }
 
 static void pcie_rc_cfg_wr_mask(struct intel_pcie_port *lpp, u32 ofs,
 				u32 mask, u32 val)
 {
-	pcie_update_bits(lpp->pci.dbi_base, ofs, mask, val);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
+
+	pcie_update_bits(pci->dbi_base, ofs, mask, val);
 }
 
 static void intel_pcie_ltssm_enable(struct intel_pcie_port *lpp)
@@ -127,7 +133,8 @@ static void intel_pcie_ltssm_disable(struct intel_pcie_port *lpp)
 static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
 {
 	u32 val;
-	u8 offset = dw_pcie_find_capability(&lpp->pci, PCI_CAP_ID_EXP);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
+	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 
 	val = pcie_rc_cfg_rd(lpp, offset + PCI_EXP_LNKCTL);
 
@@ -153,7 +160,8 @@ static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 
 static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
 {
-	struct device *dev = lpp->pci.dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
+	struct device *dev = pci->dev;
 	int ret;
 
 	lpp->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
@@ -211,7 +219,7 @@ static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
 static int intel_pcie_get_resources(struct platform_device *pdev)
 {
 	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
-	struct dw_pcie *pci = &lpp->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -255,7 +263,7 @@ static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
 {
 	u32 value;
 	int ret;
-	struct dw_pcie *pci = &lpp->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
 
 	if (pci->link_gen < 3)
 		return 0;
@@ -269,14 +277,16 @@ static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
 				 value & PCIE_APP_PMC_IN_L2, 20,
 				 jiffies_to_usecs(5 * HZ));
 	if (ret)
-		dev_err(lpp->pci.dev, "PCIe link enter L2 timeout!\n");
+		dev_err(pci->dev, "PCIe link enter L2 timeout!\n");
 
 	return ret;
 }
 
 static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
 {
-	if (dw_pcie_link_up(&lpp->pci))
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
+
+	if (dw_pcie_link_up(pci))
 		intel_pcie_wait_l2(lpp);
 
 	/* Put endpoint device in reset state */
@@ -287,7 +297,7 @@ static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
 static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 {
 	int ret;
-	struct dw_pcie *pci = &lpp->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(lpp->pp);
 
 	intel_pcie_core_rst_assert(lpp);
 	intel_pcie_device_rst_assert(lpp);
@@ -300,7 +310,7 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 
 	ret = clk_prepare_enable(lpp->core_clk);
 	if (ret) {
-		dev_err(lpp->pci.dev, "Core clock enable failed: %d\n", ret);
+		dev_err(pci->dev, "Core clock enable failed: %d\n", ret);
 		goto clk_err;
 	}
 
@@ -309,7 +319,7 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 	intel_pcie_ltssm_disable(lpp);
 	intel_pcie_link_setup(lpp);
 	intel_pcie_init_n_fts(pci);
-	dw_pcie_setup_rc(&pci->pp);
+	dw_pcie_setup_rc(lpp->pp);
 	dw_pcie_upconfig_setup(pci);
 
 	intel_pcie_device_rst_deassert(lpp);
@@ -346,7 +356,7 @@ static void __intel_pcie_remove(struct intel_pcie_port *lpp)
 static int intel_pcie_remove(struct platform_device *pdev)
 {
 	struct intel_pcie_port *lpp = platform_get_drvdata(pdev);
-	struct pcie_port *pp = &lpp->pci.pp;
+	struct pcie_port *pp = lpp->pp;
 
 	dw_pcie_host_deinit(pp);
 	__intel_pcie_remove(lpp);
@@ -415,9 +425,9 @@ static int intel_pcie_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, lpp);
-	pci = &lpp->pci;
+	pp = &lpp->pp;
+	pci = &pp->pcie;
 	pci->dev = dev;
-	pp = &pci->pp;
 
 	ret = intel_pcie_get_resources(pdev);
 	if (ret)
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 026fd1e42a55..6cc35a4d738f 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -79,17 +79,17 @@
 #define TIME_PHY_PD_MAX		11
 
 struct kirin_pcie {
-	struct dw_pcie	*pci;
-	void __iomem	*apb_base;
-	void __iomem	*phy_base;
-	struct regmap	*crgctrl;
-	struct regmap	*sysctrl;
-	struct clk	*apb_sys_clk;
-	struct clk	*apb_phy_clk;
-	struct clk	*phy_ref_clk;
-	struct clk	*pcie_aclk;
-	struct clk	*pcie_aux_clk;
-	int		gpio_id_reset;
+	struct pcie_port	*pp;
+	void __iomem		*apb_base;
+	void __iomem		*phy_base;
+	struct regmap		*crgctrl;
+	struct regmap		*sysctrl;
+	struct clk		*apb_sys_clk;
+	struct clk		*apb_phy_clk;
+	struct clk		*phy_ref_clk;
+	struct clk		*pcie_aclk;
+	struct clk		*pcie_aux_clk;
+	int			gpio_id_reset;
 };
 
 /* Registers in PCIeCTRL */
@@ -172,7 +172,8 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
 
 static int kirin_pcie_phy_init(struct kirin_pcie *kirin_pcie)
 {
-	struct device *dev = kirin_pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(kirin_pcie->pp);
+	struct device *dev = pci->dev;
 	u32 reg_val;
 
 	reg_val = kirin_apb_phy_readl(kirin_pcie, PCIE_APB_PHY_CTRL1);
@@ -328,7 +329,8 @@ static void kirin_pcie_sideband_dbi_r_mode(struct kirin_pcie *kirin_pcie,
 static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 *val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (PCI_SLOT(devfn)) {
 		*val = ~0;
@@ -342,7 +344,8 @@ static int kirin_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
 static int kirin_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
 				  int where, int size, u32 val)
 {
-	struct dw_pcie *pci = to_dw_pcie_from_pp(bus->sysdata);
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
 	if (PCI_SLOT(devfn))
 		return PCIBIOS_DEVICE_NOT_FOUND;
@@ -423,6 +426,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct kirin_pcie *kirin_pcie;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	int ret;
 
@@ -435,14 +439,14 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 	if (!kirin_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
 	pci->dev = dev;
 	pci->ops = &kirin_dw_pcie_ops;
-	pci->pp.ops = &kirin_pcie_host_ops;
-	kirin_pcie->pci = pci;
+	pp->ops = &kirin_pcie_host_ops;
+	kirin_pcie->pp = pp;
 
 	ret = kirin_pcie_get_clk(kirin_pcie, pdev);
 	if (ret)
@@ -467,7 +471,7 @@ static int kirin_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, kirin_pcie);
 
-	return dw_pcie_host_init(&pci->pp);
+	return dw_pcie_host_init(pp);
 }
 
 static const struct of_device_id kirin_pcie_match[] = {
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index affa2713bf80..0d375c7d9f50 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -188,7 +188,7 @@ struct qcom_pcie_ops {
 };
 
 struct qcom_pcie {
-	struct dw_pcie *pci;
+	struct pcie_port *pp;
 	void __iomem *parf;			/* DT parf */
 	void __iomem *elbi;			/* DT elbi */
 	union qcom_pcie_resources res;
@@ -237,7 +237,7 @@ static void qcom_pcie_2_1_0_ltssm_enable(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -309,7 +309,7 @@ static void qcom_pcie_deinit_2_1_0(struct qcom_pcie *pcie)
 static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_1_0 *res = &pcie->res.v2_1_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	struct device_node *node = dev->of_node;
 	u32 val;
@@ -434,7 +434,7 @@ static int qcom_pcie_init_2_1_0(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_1_0_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 
 	res->vdda = devm_regulator_get(dev, "vdda");
@@ -476,7 +476,7 @@ static void qcom_pcie_deinit_1_0_0(struct qcom_pcie *pcie)
 static int qcom_pcie_init_1_0_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_1_0_0 *res = &pcie->res.v1_0_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -554,7 +554,7 @@ static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -607,7 +607,7 @@ static void qcom_pcie_post_deinit_2_3_2(struct qcom_pcie *pcie)
 static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	u32 val;
 	int ret;
@@ -681,7 +681,7 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
 static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_2 *res = &pcie->res.v2_3_2;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -697,7 +697,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_2_4_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	bool is_ipq = of_device_is_compatible(dev->of_node, "qcom,pcie-ipq4019");
 	int ret;
@@ -796,7 +796,7 @@ static void qcom_pcie_deinit_2_4_0(struct qcom_pcie *pcie)
 static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_4_0 *res = &pcie->res.v2_4_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	u32 val;
 	int ret;
@@ -970,7 +970,7 @@ static int qcom_pcie_init_2_4_0(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	int i;
 	const char *rst_names[] = { "axi_m", "axi_s", "pipe",
@@ -1020,7 +1020,7 @@ static void qcom_pcie_deinit_2_3_3(struct qcom_pcie *pcie)
 static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_3_3 *res = &pcie->res.v2_3_3;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int i, ret;
@@ -1131,7 +1131,7 @@ static int qcom_pcie_init_2_3_3(struct qcom_pcie *pcie)
 static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	int ret;
 
@@ -1164,7 +1164,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
 static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 {
 	struct qcom_pcie_resources_2_7_0 *res = &pcie->res.v2_7_0;
-	struct dw_pcie *pci = pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
 	struct device *dev = pci->dev;
 	u32 val;
 	int ret;
@@ -1274,7 +1274,8 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
 		u32 smmu_sid_len;
 	} *map;
 	void __iomem *bdf_to_sid_base = pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N;
-	struct device *dev = pcie->pci->dev;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pcie->pp);
+	struct device *dev = pci->dev;
 	u8 qcom_pcie_crc8_table[CRC8_TABLE_SIZE];
 	int i, nr_map, size = 0;
 	u32 smmu_sid_base;
@@ -1463,8 +1464,8 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
 	pm_runtime_enable(dev);
@@ -1472,11 +1473,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_pm_runtime_put;
 
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pp = &pci->pp;
-
-	pcie->pci = pci;
+	pcie->pp = pp;
 
 	pcie->ops = of_device_get_match_data(dev);
 
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 1a9e353bef55..d721118e9ed9 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -22,7 +22,7 @@
 #include "pcie-designware.h"
 
 struct spear13xx_pcie {
-	struct dw_pcie		*pci;
+	struct pcie_port	*pp;
 	void __iomem		*app_base;
 	struct phy		*phy;
 	struct clk		*clk;
@@ -84,8 +84,7 @@ static irqreturn_t spear13xx_pcie_irq_handler(int irq, void *arg)
 {
 	struct spear13xx_pcie *spear13xx_pcie = arg;
 	struct pcie_app_reg *app_reg = spear13xx_pcie->app_base;
-	struct dw_pcie *pci = spear13xx_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = spear13xx_pcie->pp;
 	unsigned int status;
 
 	status = readl(&app_reg->int_sts);
@@ -154,8 +153,7 @@ static const struct dw_pcie_host_ops spear13xx_pcie_host_ops = {
 static int spear13xx_add_pcie_port(struct spear13xx_pcie *spear13xx_pcie,
 				   struct platform_device *pdev)
 {
-	struct dw_pcie *pci = spear13xx_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = spear13xx_pcie->pp;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -191,6 +189,7 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 static int spear13xx_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct spear13xx_pcie *spear13xx_pcie;
 	struct device_node *np = dev->of_node;
@@ -200,14 +199,15 @@ static int spear13xx_pcie_probe(struct platform_device *pdev)
 	if (!spear13xx_pcie)
 		return -ENOMEM;
 
-	pci = devm_kzalloc(dev, sizeof(*pci), GFP_KERNEL);
-	if (!pci)
+	pp = devm_kzalloc(dev, sizeof(*pp), GFP_KERNEL);
+	if (!pp)
 		return -ENOMEM;
 
+	pci = &pp->pcie;
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
 
-	spear13xx_pcie->pci = pci;
+	spear13xx_pcie->pp = pp;
 
 	spear13xx_pcie->phy = devm_phy_get(dev, "pcie-phy");
 	if (IS_ERR(spear13xx_pcie->phy)) {
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 5597b2a49598..ef2052bb50fd 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -272,7 +272,8 @@ struct tegra_pcie_dw {
 	struct clk *core_clk;
 	struct reset_control *core_apb_rst;
 	struct reset_control *core_rst;
-	struct dw_pcie pci;
+	struct pcie_port pp;
+	struct dw_pcie_ep ep;
 	struct tegra_bpmp *bpmp;
 
 	enum dw_pcie_device_mode mode;
@@ -311,10 +312,7 @@ struct tegra_pcie_dw_of_data {
 	enum dw_pcie_device_mode mode;
 };
 
-static inline struct tegra_pcie_dw *to_tegra_pcie(struct dw_pcie *pci)
-{
-	return container_of(pci, struct tegra_pcie_dw, pci);
-}
+#define to_tegra_pcie(x)	dev_get_drvdata((x)->dev)
 
 static inline void appl_writel(struct tegra_pcie_dw *pcie, const u32 value,
 			       const u32 reg)
@@ -368,8 +366,8 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
-	struct dw_pcie *pci = &pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = &pcie->pp;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u32 val, tmp;
 	u16 val_w;
 
@@ -467,7 +465,7 @@ static void pex_ep_event_hot_rst_done(struct tegra_pcie_dw *pcie)
 static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
-	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(&pcie->ep);
 	u32 val, speed;
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
@@ -513,7 +511,7 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 static irqreturn_t tegra_pcie_ep_hard_irq(int irq, void *arg)
 {
 	struct tegra_pcie_dw *pcie = arg;
-	struct dw_pcie_ep *ep = &pcie->pci.ep;
+	struct dw_pcie_ep *ep = &pcie->ep;
 	int spurious = 1;
 	u32 val, tmp;
 
@@ -596,33 +594,46 @@ static struct pci_ops tegra_pci_ops = {
 #if defined(CONFIG_PCIEASPM)
 static void disable_aspm_l11(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci;
 	u32 val;
 
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
+	if (pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(&pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(&pcie->ep);
+
+	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
 	val &= ~PCI_L1SS_CAP_ASPM_L1_1;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
 }
 
 static void disable_aspm_l12(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci;
 	u32 val;
 
-	val = dw_pcie_readl_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub);
+	if (pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(&pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(&pcie->ep);
+
+	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
 	val &= ~PCI_L1SS_CAP_ASPM_L1_2;
-	dw_pcie_writel_dbi(&pcie->pci, pcie->cfg_link_cap_l1sub, val);
+	dw_pcie_writel_dbi(pci, pcie->cfg_link_cap_l1sub, val);
 }
 
 static inline u32 event_counter_prog(struct tegra_pcie_dw *pcie, u32 event)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&pcie->pp);
 	u32 val;
 
-	val = dw_pcie_readl_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid]);
+	val = dw_pcie_readl_dbi(pci, event_cntr_ctrl_offset[pcie->cid]);
 	val &= ~(EVENT_COUNTER_EVENT_SEL_MASK << EVENT_COUNTER_EVENT_SEL_SHIFT);
 	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
 	val |= event << EVENT_COUNTER_EVENT_SEL_SHIFT;
 	val |= EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
-	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid], val);
-	val = dw_pcie_readl_dbi(&pcie->pci, event_cntr_data_offset[pcie->cid]);
+	dw_pcie_writel_dbi(pci, event_cntr_ctrl_offset[pcie->cid], val);
+	val = dw_pcie_readl_dbi(pci, event_cntr_data_offset[pcie->cid]);
 
 	return val;
 }
@@ -631,6 +642,7 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 {
 	struct tegra_pcie_dw *pcie = (struct tegra_pcie_dw *)
 				     dev_get_drvdata(s->private);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&pcie->pp);
 	u32 val;
 
 	seq_printf(s, "Tx L0s entry count : %u\n",
@@ -649,22 +661,27 @@ static int aspm_state_cnt(struct seq_file *s, void *data)
 		   event_counter_prog(pcie, EVENT_COUNTER_EVENT_L1_2));
 
 	/* Clear all counters */
-	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid],
+	dw_pcie_writel_dbi(pci, event_cntr_ctrl_offset[pcie->cid],
 			   EVENT_COUNTER_ALL_CLEAR);
 
 	/* Re-enable counting */
 	val = EVENT_COUNTER_ENABLE_ALL << EVENT_COUNTER_ENABLE_SHIFT;
 	val |= EVENT_COUNTER_GROUP_5 << EVENT_COUNTER_GROUP_SEL_SHIFT;
-	dw_pcie_writel_dbi(&pcie->pci, event_cntr_ctrl_offset[pcie->cid], val);
+	dw_pcie_writel_dbi(pci, event_cntr_ctrl_offset[pcie->cid], val);
 
 	return 0;
 }
 
 static void init_host_aspm(struct tegra_pcie_dw *pcie)
 {
-	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie *pci;
 	u32 val;
 
+	if (pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(&pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(&pcie->ep);
+
 	val = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
 	pcie->cfg_link_cap_l1sub = val + PCI_L1SS_CAP;
 
@@ -726,15 +743,15 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 		appl_writel(pcie, val, APPL_INTR_EN_L1_18);
 	}
 
-	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
+	val_w = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKSTA);
 	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
 				PCI_EXP_LNKSTA_NLW_SHIFT;
 
-	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
+	val_w = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKCTL);
 	val_w |= PCI_EXP_LNKCTL_LBMIE;
-	dw_pcie_writew_dbi(&pcie->pci, pcie->pcie_cap_base + PCI_EXP_LNKCTL,
+	dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCTL,
 			   val_w);
 }
 
@@ -802,9 +819,14 @@ static void tegra_pcie_enable_interrupts(struct pcie_port *pp)
 
 static void config_gen3_gen4_eq_presets(struct tegra_pcie_dw *pcie)
 {
-	struct dw_pcie *pci = &pcie->pci;
+	struct dw_pcie *pci;
 	u32 val, offset, i;
 
+	if (pcie->mode == DW_PCIE_RC_TYPE)
+		pci = to_dw_pcie_from_pp(&pcie->pp);
+	else
+		pci = to_dw_pcie_from_ep(&pcie->ep);
+
 	/* Program init preset */
 	for (i = 0; i < pcie->num_lanes; i++) {
 		val = dw_pcie_readw_dbi(pci, CAP_SPCIE_CAP_OFF + (i * 2));
@@ -860,7 +882,7 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	u32 val;
 
 	if (!pcie->pcie_cap_base)
-		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
+		pcie->pcie_cap_base = dw_pcie_find_capability(pci,
 							      PCI_CAP_ID_EXP);
 
 	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
@@ -1215,7 +1237,7 @@ static int tegra_pcie_bpmp_set_pll_state(struct tegra_pcie_dw *pcie,
 
 static void tegra_pcie_downstream_dev_to_D0(struct tegra_pcie_dw *pcie)
 {
-	struct pcie_port *pp = &pcie->pci.pp;
+	struct pcie_port *pp = &pcie->pp;
 	struct pci_bus *child, *root_bus = NULL;
 	struct pci_dev *pdev;
 
@@ -1445,8 +1467,7 @@ static void tegra_pcie_unconfig_controller(struct tegra_pcie_dw *pcie)
 
 static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 {
-	struct dw_pcie *pci = &pcie->pci;
-	struct pcie_port *pp = &pci->pp;
+	struct pcie_port *pp = &pcie->pp;
 	int ret;
 
 	ret = tegra_pcie_config_controller(pcie, false);
@@ -1470,9 +1491,10 @@ static int tegra_pcie_init_controller(struct tegra_pcie_dw *pcie)
 
 static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&pcie->pp);
 	u32 val;
 
-	if (!tegra_pcie_dw_link_up(&pcie->pci))
+	if (!tegra_pcie_dw_link_up(pci))
 		return 0;
 
 	val = appl_readl(pcie, APPL_RADM_STATUS);
@@ -1486,10 +1508,11 @@ static int tegra_pcie_try_link_l2(struct tegra_pcie_dw *pcie)
 
 static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&pcie->pp);
 	u32 data;
 	int err;
 
-	if (!tegra_pcie_dw_link_up(&pcie->pci)) {
+	if (!tegra_pcie_dw_link_up(pci)) {
 		dev_dbg(pcie->dev, "PCIe link is not up...!\n");
 		return;
 	}
@@ -1539,13 +1562,14 @@ static void tegra_pcie_dw_pme_turnoff(struct tegra_pcie_dw *pcie)
 static void tegra_pcie_deinit_controller(struct tegra_pcie_dw *pcie)
 {
 	tegra_pcie_downstream_dev_to_D0(pcie);
-	dw_pcie_host_deinit(&pcie->pci.pp);
+	dw_pcie_host_deinit(&pcie->pp);
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
 }
 
 static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&pcie->pp);
 	struct device *dev = pcie->dev;
 	char *name;
 	int ret;
@@ -1571,7 +1595,7 @@ static int tegra_pcie_config_rp(struct tegra_pcie_dw *pcie)
 		goto fail_pm_get_sync;
 	}
 
-	pcie->link_state = tegra_pcie_dw_link_up(&pcie->pci);
+	pcie->link_state = tegra_pcie_dw_link_up(pci);
 	if (!pcie->link_state) {
 		ret = -ENOMEDIUM;
 		goto fail_host_init;
@@ -1637,8 +1661,8 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
 
 static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 {
-	struct dw_pcie *pci = &pcie->pci;
-	struct dw_pcie_ep *ep = &pci->ep;
+	struct dw_pcie_ep *ep = &pcie->ep;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct device *dev = pcie->dev;
 	u32 val;
 	int ret;
@@ -1757,7 +1781,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
-	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
+	pcie->pcie_cap_base = dw_pcie_find_capability(pci,
 						      PCI_CAP_ID_EXP);
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
 
@@ -1834,7 +1858,7 @@ static int tegra_pcie_ep_raise_msi_irq(struct tegra_pcie_dw *pcie, u16 irq)
 
 static int tegra_pcie_ep_raise_msix_irq(struct tegra_pcie_dw *pcie, u16 irq)
 {
-	struct dw_pcie_ep *ep = &pcie->pci.ep;
+	struct dw_pcie_ep *ep = &pcie->ep;
 
 	writel(irq, ep->msi_mem);
 
@@ -1890,13 +1914,12 @@ static struct dw_pcie_ep_ops pcie_ep_ops = {
 static int tegra_pcie_config_ep(struct tegra_pcie_dw *pcie,
 				struct platform_device *pdev)
 {
-	struct dw_pcie *pci = &pcie->pci;
 	struct device *dev = pcie->dev;
 	struct dw_pcie_ep *ep;
 	char *name;
 	int ret;
 
-	ep = &pci->ep;
+	ep = &pcie->ep;
 	ep->ops = &pcie_ep_ops;
 
 	ep->page_size = SZ_64K;
@@ -1961,11 +1984,14 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct resource *atu_dma_res;
 	struct tegra_pcie_dw *pcie;
+	void __iomem *atu_base;
+	struct dw_pcie_ep *ep;
 	struct pcie_port *pp;
 	struct dw_pcie *pci;
 	struct phy **phys;
+	size_t atu_size;
 	char *name;
-	int ret;
+	int ret, irq;
 	u32 i;
 
 	data = of_device_get_match_data(dev);
@@ -1974,15 +2000,6 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	if (!pcie)
 		return -ENOMEM;
 
-	pci = &pcie->pci;
-	pci->dev = &pdev->dev;
-	pci->ops = &tegra_dw_pcie_ops;
-	pci->n_fts[0] = N_FTS_VAL;
-	pci->n_fts[1] = FTS_VAL;
-	pci->version = 0x490A;
-
-	pp = &pci->pp;
-	pp->num_vectors = MAX_MSI_IRQS;
 	pcie->dev = &pdev->dev;
 	pcie->mode = (enum dw_pcie_device_mode)data->mode;
 
@@ -2079,10 +2096,10 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	}
 	pcie->atu_dma_res = atu_dma_res;
 
-	pci->atu_size = resource_size(atu_dma_res);
-	pci->atu_base = devm_ioremap_resource(dev, atu_dma_res);
-	if (IS_ERR(pci->atu_base))
-		return PTR_ERR(pci->atu_base);
+	atu_size = resource_size(atu_dma_res);
+	atu_base = devm_ioremap_resource(dev, atu_dma_res);
+	if (IS_ERR(atu_base))
+		return PTR_ERR(atu_base);
 
 	pcie->core_rst = devm_reset_control_get(dev, "core");
 	if (IS_ERR(pcie->core_rst)) {
@@ -2091,9 +2108,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		return PTR_ERR(pcie->core_rst);
 	}
 
-	pp->irq = platform_get_irq_byname(pdev, "intr");
-	if (pp->irq < 0)
-		return pp->irq;
+	irq = platform_get_irq_byname(pdev, "intr");
+	if (irq < 0)
+		return irq;
 
 	pcie->bpmp = tegra_bpmp_get(dev);
 	if (IS_ERR(pcie->bpmp))
@@ -2103,10 +2120,22 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 
 	switch (pcie->mode) {
 	case DW_PCIE_RC_TYPE:
-		ret = devm_request_irq(dev, pp->irq, tegra_pcie_rp_irq_handler,
+		pp = &pcie->pp;
+		pci = &pp->pcie;
+		pci->dev = &pdev->dev;
+		pci->ops = &tegra_dw_pcie_ops;
+		pci->n_fts[0] = N_FTS_VAL;
+		pci->n_fts[1] = FTS_VAL;
+		pci->version = 0x490A;
+		pci->atu_size = atu_size;
+		pci->atu_base = atu_base;
+		pp->num_vectors = MAX_MSI_IRQS;
+		pp->irq = irq;
+
+		ret = devm_request_irq(dev, irq, tegra_pcie_rp_irq_handler,
 				       IRQF_SHARED, "tegra-pcie-intr", pcie);
 		if (ret) {
-			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
+			dev_err(dev, "Failed to request IRQ %d: %d\n", irq,
 				ret);
 			goto fail;
 		}
@@ -2119,13 +2148,23 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 		break;
 
 	case DW_PCIE_EP_TYPE:
-		ret = devm_request_threaded_irq(dev, pp->irq,
+		ep = &pcie->ep;
+		pci = &ep->pcie;
+		pci->dev = &pdev->dev;
+		pci->ops = &tegra_dw_pcie_ops;
+		pci->n_fts[0] = N_FTS_VAL;
+		pci->n_fts[1] = FTS_VAL;
+		pci->version = 0x490A;
+		pci->atu_size = atu_size;
+		pci->atu_base = atu_base;
+
+		ret = devm_request_threaded_irq(dev, irq,
 						tegra_pcie_ep_hard_irq,
 						tegra_pcie_ep_irq_thread,
 						IRQF_SHARED | IRQF_ONESHOT,
 						"tegra-pcie-ep-intr", pcie);
 		if (ret) {
-			dev_err(dev, "Failed to request IRQ %d: %d\n", pp->irq,
+			dev_err(dev, "Failed to request IRQ %d: %d\n", irq,
 				ret);
 			goto fail;
 		}
@@ -2183,12 +2222,14 @@ static int tegra_pcie_dw_suspend_late(struct device *dev)
 static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci;
 
 	if (!pcie->link_state)
 		return 0;
 
+	pci = to_dw_pcie_from_pp(&pcie->pp);
 	/* Save MSI interrupt vector */
-	pcie->msi_ctrl_int = dw_pcie_readl_dbi(&pcie->pci,
+	pcie->msi_ctrl_int = dw_pcie_readl_dbi(pci,
 					       PORT_LOGIC_MSI_CTRL_INT_0_EN);
 	tegra_pcie_downstream_dev_to_D0(pcie);
 	tegra_pcie_dw_pme_turnoff(pcie);
@@ -2200,23 +2241,25 @@ static int tegra_pcie_dw_suspend_noirq(struct device *dev)
 static int tegra_pcie_dw_resume_noirq(struct device *dev)
 {
 	struct tegra_pcie_dw *pcie = dev_get_drvdata(dev);
+	struct dw_pcie *pci;
 	int ret;
 
 	if (!pcie->link_state)
 		return 0;
 
+	pci = to_dw_pcie_from_pp(&pcie->pp);
 	ret = tegra_pcie_config_controller(pcie, true);
 	if (ret < 0)
 		return ret;
 
-	ret = tegra_pcie_dw_host_init(&pcie->pci.pp);
+	ret = tegra_pcie_dw_host_init(&pcie->pp);
 	if (ret < 0) {
 		dev_err(dev, "Failed to init host: %d\n", ret);
 		goto fail_host_init;
 	}
 
 	/* Restore MSI interrupt vector */
-	dw_pcie_writel_dbi(&pcie->pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
+	dw_pcie_writel_dbi(pci, PORT_LOGIC_MSI_CTRL_INT_0_EN,
 			   pcie->msi_ctrl_int);
 
 	return 0;
@@ -2256,9 +2299,9 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 	debugfs_remove_recursive(pcie->debugfs);
 	tegra_pcie_downstream_dev_to_D0(pcie);
 
-	disable_irq(pcie->pci.pp.irq);
+	disable_irq(pcie->pp.irq);
 	if (IS_ENABLED(CONFIG_PCI_MSI))
-		disable_irq(pcie->pci.pp.msi_irq);
+		disable_irq(pcie->pp.msi_irq);
 
 	tegra_pcie_dw_pme_turnoff(pcie);
 	tegra_pcie_unconfig_controller(pcie);
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 21e185bf90d6..7a3d6e386e6c 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -56,7 +56,7 @@
 
 struct uniphier_pcie_ep_priv {
 	void __iomem *base;
-	struct dw_pcie pci;
+	struct dw_pcie_ep ep;
 	struct clk *clk, *clk_gio;
 	struct reset_control *rst, *rst_gio;
 	struct phy *phy;
@@ -270,6 +270,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_pcie_ep_priv *priv;
+	struct dw_pcie_ep *ep;
+	struct dw_pcie *pci;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -280,8 +282,10 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	if (WARN_ON(!priv->features))
 		return -EINVAL;
 
-	priv->pci.dev = dev;
-	priv->pci.ops = &dw_pcie_ops;
+	ep = &priv->ep;
+	pci = &ep->pcie;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
 	if (IS_ERR(priv->base))
@@ -316,8 +320,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->pci.ep.ops = &uniphier_pcie_ep_ops;
-	return dw_pcie_ep_init(&priv->pci.ep);
+	ep->ops = &uniphier_pcie_ep_ops;
+	return dw_pcie_ep_init(ep);
 }
 
 static const struct pci_epc_features uniphier_pro5_data = {
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 7e8bad326770..249430d4173a 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -63,7 +63,7 @@
 
 struct uniphier_pcie_priv {
 	void __iomem *base;
-	struct dw_pcie pci;
+	struct pcie_port pp;
 	struct clk *clk;
 	struct reset_control *rst;
 	struct phy *phy;
@@ -120,6 +120,7 @@ static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
 
 static int uniphier_pcie_wait_rc(struct uniphier_pcie_priv *priv)
 {
+	struct dw_pcie *pci = to_dw_pcie_from_pp(&priv->pp);
 	u32 status;
 	int ret;
 
@@ -127,7 +128,7 @@ static int uniphier_pcie_wait_rc(struct uniphier_pcie_priv *priv)
 	ret = readl_poll_timeout(priv->base + PCL_PIPEMON, status,
 				 status & PCL_PCLK_ALIVE, 100000, 1000000);
 	if (ret) {
-		dev_err(priv->pci.dev,
+		dev_err(pci->dev,
 			"Failed to initialize controller in RC mode\n");
 		return ret;
 	}
@@ -365,14 +366,18 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct uniphier_pcie_priv *priv;
+	struct pcie_port *pp;
+	struct dw_pcie *pci;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
-	priv->pci.dev = dev;
-	priv->pci.ops = &dw_pcie_ops;
+	pp = &priv->pp;
+	pci = &pp->pcie;
+	pci->dev = dev;
+	pci->ops = &dw_pcie_ops;
 
 	priv->base = devm_platform_ioremap_resource_byname(pdev, "link");
 	if (IS_ERR(priv->base))
@@ -396,9 +401,9 @@ static int uniphier_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->pci.pp.ops = &uniphier_pcie_host_ops;
+	pp->ops = &uniphier_pcie_host_ops;
 
-	return dw_pcie_host_init(&priv->pci.pp);
+	return dw_pcie_host_init(pp);
 }
 
 static const struct of_device_id uniphier_pcie_match[] = {
-- 
2.17.1

