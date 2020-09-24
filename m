Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355D6276F8E
	for <lists+linux-pci@lfdr.de>; Thu, 24 Sep 2020 13:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgIXLLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Sep 2020 07:11:08 -0400
Received: from mail-bn8nam08on2041.outbound.protection.outlook.com ([40.107.100.41]:27744
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbgIXLLH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Sep 2020 07:11:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TM9SpLwEeg6oLi7NlR7/t0U17BLXanesMxkADL+MuVH+M6ktEoPoeG2moSTcCflC4G1uXx8Z0iZej5O1g5k2a/piWLx/Up1nxZcJXzVAGUdYpmwHa3B53CG0d80q5op70I12ei/1m799gI3Zm83eMRU2Qmee2oS+16OEzV1KbKcP5aOoK61cTEYKDqMIDuVrv0JV5m0nP53QCktg/uJ+OQ9Md6TnJqxHimdw6EpY5EBRq9NmssVE0o0bHSKMyzAD09pYUV6WGA/lH836evSvq0T00JmcqNQIIYuys1BK49lgI7kLdPIOaYJQw6Jw9M6JR6046enG0tdasih2YMR6JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtOzPxEd2XeU73giEScASx6cZtQ7qwm5SynZkZNyfv0=;
 b=d8Km32gPvsWv5GSgOx6xv1YDPEHNhx5frjoj0RtYdtn9JyGHFp7kIv3qCTls3AK/3V4DcSz35CtzuUMBR2Vy4nbdFteutrMVylO2OTJVZ05A8xBmeNqHWDD2n2zrdtIeZSnfbOLqCYlOP61O62VOmZ+9yb0qhTRnu1RN3A6WAAmOpDP89X724U453F4JZvMYhAvhQiE6XTNpnY2i2/Z05I6ehyrq9OgFcF/v8URCk1iSaP00C1TwBh5kgv3oNDkWiT5aGDKvId0wVrWHA3jGSXwkEvc5pdfnUkfvy9rIrSRoIEllniu+XUeg0kwiI6Nb1nyUfkS4h4mHN6B3tOBG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtOzPxEd2XeU73giEScASx6cZtQ7qwm5SynZkZNyfv0=;
 b=jvVYZTbUmYw+cVvr5YLgwZA1fcpsg8izLMgVul4WxPtesI/vrOavkllKtgD4uiVx9meeA6i3+rvkicvWkIwdcMpTBV6eMZTsEsUiPXzZt4XCbhO9l6W2dXCMUvShUeh6cLz9645KdtiZMTo4zcu52w3u3L9AvoXiUd6fCo9Ka9Y=
Authentication-Results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DM6PR03MB4698.namprd03.prod.outlook.com (2603:10b6:5:180::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 11:11:05 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3391.027; Thu, 24 Sep 2020
 11:11:05 +0000
Date:   Thu, 24 Sep 2020 19:07:13 +0800
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
Subject: [PATCH v2 4/5] PCI: dwc: Skip PCIE_MSI_INTR0* programming if MSI is
 disabled
Message-ID: <20200924190713.74e0afd6@xhacker.debian>
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
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0072.jpnprd01.prod.outlook.com (2603:1096:404:2b::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Thu, 24 Sep 2020 11:10:53 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda9a7c4-8c37-4316-0a00-08d8607a8767
X-MS-TrafficTypeDiagnostic: DM6PR03MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR03MB469891710119770456D0EDF4ED390@DM6PR03MB4698.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:431;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3NcT+TuzlBmVhDbUoRrr/Zz90zWnbTyTIRe/P718GtIp2mQ3COxi/Rx/G6Y2Y5kQ/P0f6nWhVrnBtHApbUdnOIAx6/rFhqSa1NZ3ELJFC5pvSB83VfA+SvIEOqvO4KkqjMfYUZ9YV0mrqDNg3yPxo/YLbSF+yPgX8QN7QnBil6te2dW1imEc3TiK08Q9INs97ce+dqCFUoVHvHC1lvoG6JNNbPIDhitLxkGS83LHFC//cHP0oTtbW4SWtSEJ1DxEbQ0Ehbao2ccQN1bGGxo4EOue/Dz/kOKrsUQYFn1JIAlyFw8Onwr+d3hnl/ptMA0ssF+mkSie/uW3JWdJye6nbERt9y8x6s8kXLP1EbgjwjRU4W+GL+UMQ0eOWq0vJ4EQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(39860400002)(376002)(136003)(2906002)(86362001)(6506007)(52116002)(7696005)(83380400001)(478600001)(5660300002)(6666004)(186003)(4744005)(66556008)(16526019)(956004)(1076003)(26005)(316002)(66476007)(7406005)(66946007)(9686003)(55016002)(8676002)(8936002)(110136005)(4326008)(7416002)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: pFUCKi/e3MQfScHMBXJ9XIE2toLno9ke/16VPQ0r2BBTTRdj0ARZlvU8jsq093gVo2+bRO6UlS4ERPNoVYomWctRX5gx/3Ra0BgOLZGaqEMACAlj8LXo1JLwevuFw4PmsPyIjBmj5oH/9ZuXsvOxAQDeDH0QNtEXuCdH4oXA565fHiTI5IurmEjaZ5nNqWOjuC34F4U6vU9/E7b2+ChSvqNZI4yNkkdaJb8Koclv+rDAG2hGvOARufIHosHYRwvLJyO3pVBDqUBfYQaZqrsH5RV25KVgk3muOAuz4NjY+QqaIkUE3AGa7CLlgEev6EwK44mNbO5wcCNgMvSaOoZXOwOWmmg4BbrwSktdSP5UEqMfwHJ9Pau4LGFGtlI3m++ysMORDoWmwDzcul4wX8/QmuevP4ZKQBw8rZTBAQiZzHfDU6MS6vNaH+FN0RbVxW95R6KpZ+C2buuCLfFlIjbr2e93L3KIq1xYgi9wLRB/E1wufrxX8QkifEp5fcyGeat8ywGcCOoMDvO7q/eGVs4MEC6RGbxbBXIW5ZyC36jj4rY9UNjajiGQLzC7VMAveak0VzyKp2TL48AUtsigacRv/HzABprWeeLT274Al1zXUjnUSCTnYLY5u0A/AZK+WqokatgdUVpVkqsPC+TZq6zwfw==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda9a7c4-8c37-4316-0a00-08d8607a8767
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 11:11:04.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rqzjjtd3RED+PHw7LhAfPmrXAUeo0ginqVyZN95C2zUzEGVPRENa1r3Mp9vpjIbA/h+3x7kYG/wgPT9HeS5bhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB4698
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If MSI is disabled, there's no need to program PCIE_MSI_INTR0_MASK
and PCIE_MSI_INTR0_ENABLE registers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2de8bc5db91..7a8adf597803 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -641,7 +641,7 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
 
 	dw_pcie_setup(pci);
 
-	if (!pp->ops->msi_host_init) {
+	if (pci_msi_enabled() && !pp->ops->msi_host_init) {
 		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
 
 		/* Initialize IRQ Status array */
-- 
2.28.0

