Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739872832FD
	for <lists+linux-pci@lfdr.de>; Mon,  5 Oct 2020 11:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJEJQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Oct 2020 05:16:33 -0400
Received: from mail-bn7nam10on2084.outbound.protection.outlook.com ([40.107.92.84]:59364
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725891AbgJEJQc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Oct 2020 05:16:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cjcr4NgmHzkPO65EU5sya3q+bVFFEKaHAw2woCqEntTmig4j3CnIImPK9DT+f4ffxeqBiJBSvgAi45r/6+EzEFO/rVRoz4n5PQKNhSXFIzaPEG1A1Aowz/1CBg78jIj17HNCkZcWtMkEmrLleYybQk1wR8SyW6b7YcfFFg6lcHHqhzUwOYJLCGGq5mPgPnW/8C/+UtjwD6VJgo8sfHj4yLfA9AbCmICasdBQ8dGSG6G6oIvNW//rE/oU0MfZX5Av4ssTRb+k8hV6cOVofpwEecFphpQ3CY8sbM13rwiC0ei+0rhDV4reDQDLVeDhezaz+I5K6CBWPNZttzI5ekR7ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keYn3xZSeTe02oYkXhucLonJ2fdQs/o//mSCHTY2f1o=;
 b=V6Zyk47RE/IzsfREN4g8T4uk+yU/H57W6td/ipII94ohymP2/ebsn5jMLtJHEk3gSIZm4qx7eHe2g/FhrqIypx1minmMOCuLncJth2T2tpQ6L1f9YyBxJb3PJwkht02UjOViv8D2DKVsV2qL2klSA6FRmvj0njyj9phmrdFpaOPMKQR3R/tQHKDU1aPJGYic0QsY3Lt7l8SO92pUOLcb4hW8SNGrBnBNmAf9PL2Wk+yXTHl7PuDSHcLRoLZOqRRsGiKIVtUyo/uv6Jb3cMcHUD+EwUvfCBYy4q7rG/+/lvpORI+W0lhYwKB5eXM8SFKYcirkL0DpZXAj9MyihHqxOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keYn3xZSeTe02oYkXhucLonJ2fdQs/o//mSCHTY2f1o=;
 b=Sx4Pjvnfw4gIwh9TEcVsv1UgPumkzhWtfmk0vk9WVfJjJvYXtbP/a0IFRaxpEVkYoJVKlpOIYOWwUG2HWyD+geoU7ZFjQ604bN4+2CqG/Q5JS9z7b89sTRaZ3ouI8zdQFK1ISZKkQ5uB5/kYHGRwjklCO142r8WAC3f0R0byd+Y=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=synaptics.com;
Received: from DM6PR03MB4555.namprd03.prod.outlook.com (2603:10b6:5:102::17)
 by DS7PR03MB5560.namprd03.prod.outlook.com (2603:10b6:5:2d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Mon, 5 Oct
 2020 09:16:29 +0000
Received: from DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38]) by DM6PR03MB4555.namprd03.prod.outlook.com
 ([fe80::e494:740f:155:4a38%7]) with mapi id 15.20.3433.044; Mon, 5 Oct 2020
 09:16:29 +0000
Date:   Mon, 5 Oct 2020 16:57:33 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH dwc-next 1/3] PCI: dwc: Don't assume the ops in dw_pcie
 always exists
Message-ID: <20201005165733.1dc15ce0@xhacker.debian>
In-Reply-To: <20201005165657.0fd31b10@xhacker.debian>
References: <20201005165657.0fd31b10@xhacker.debian>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR01CA0070.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::34) To DM6PR03MB4555.namprd03.prod.outlook.com
 (2603:10b6:5:102::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0070.jpnprd01.prod.outlook.com (2603:1096:404:2b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.34 via Frontend Transport; Mon, 5 Oct 2020 09:16:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b34c4805-8003-46f5-4023-08d8690f5806
X-MS-TrafficTypeDiagnostic: DS7PR03MB5560:
X-Microsoft-Antispam-PRVS: <DS7PR03MB55608CF0979A7F11D13848B8ED0C0@DS7PR03MB5560.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AQrz36fnz30Y7/IOWJplgw3TOtMQkCQBCRZSpokWhBKdyQgVELlFohTFbiTSpPyJAZ6dUMBBUuzIAPEe93ODPy+XlqLjz3FVK2jbryAbRp63lUXXQyajCsAp//bysmr6ACgqsWM9+BQ4HbvelY5tPO5rOluIV0D/dKsls+H5wuXLZIAwRsC19PO0NuOt00SDbNU+fV2SdmceSLo1XtkHxycv+U5Falasv5lEnDi/Q5n+dgaHcXjAZyGcil9h5f8o6NhhLj0r6LiP5zSOU5ATuElpMh7b9ABRl8hNMoD8cqKA9Ja0jdxSvyOsV4JE/nLjVU39bqqw9cJxpUKtU9q9BBR3ORE46qbvFARsuC9eYmEDt3s+f4LftT6RKL644+Eq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB4555.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39850400004)(396003)(346002)(376002)(136003)(2906002)(8936002)(9686003)(16526019)(66946007)(66556008)(66476007)(186003)(26005)(8676002)(7416002)(55016002)(83380400001)(1076003)(5660300002)(6666004)(478600001)(52116002)(7696005)(316002)(110136005)(6506007)(4326008)(956004)(86362001)(921003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3J0/kGRQnzbg4YkzOxW+Ndir6zZ/WcR1IW3B7Qd8JNQtTZEd+AQE5xrugqZk031nyMFmM1GhqpEzlCfkUzHIOcfb0rqALgIJ11he7dxwG5qJJHy1yb2XzN9muF93GXHrxL3XlrtUkj4LP8tS2mj/7U0xzh7t53bRM9IdnDd+VNBW/avbG4z6D0lROODPEry2ldGnFFIOuUIMduygqNblVtSK8jND4YXBedEdDtCkdq9Zm67Nu+ROwdH9OdGa/kCJrPkM0knLJLYLW2kDJiP51ilM+zGL2o7xXpntkg8Ur+y5OJRLfZf9+lVrfYMeqqcNsDfhsKnbZ8uyjsIrbWQPoWfLt7Ajy/znP4lGgXkQi5X4iRrX10P3XZPZFmdGP4q4zt2z0/ad+GBwbzHgZ0JzsBDfhdaXbE4bA+nP1dzMvpBqnnKNOYbD7ECJXNXaw+KIZex+dnb5L9RIM0ElmLZCrY/bS95WEwLKpGQwrz6m+nxj3BAtQvHy7Gl9q/d8dXBxJh5Ekrb9xZW6e3EovY6NJvJtRp4Lr4HyqoTWco+brpE53T1gTqSGLCkTtyUUrwFLDoKQ61ViRgOvl80KzJL3jc++lzvLlTH14T5f2Yh5GIg32m4mbTYxwR4ETN0O8gSCKFRLd7EBCKt8jOVEqkGKZA==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34c4805-8003-46f5-4023-08d8690f5806
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB4555.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2020 09:16:29.7264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY7vUHOO+iNIZKK+P6TuWSegGCuPpa14zVXafWXq9CWaIb9eFv2wNatJCjVpzXPWhotFADZO5M0j1CEVXFyjiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5560
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some designware based device driver especially host only driver may
work well with the default read_dbi/write_dbi/link_up implementation
in pcie-designware.c, thus remove the assumption to simplify those
drivers.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c |  8 +++-----
 drivers/pci/controller/dwc/pcie-designware.c    | 14 +++++++-------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index ad7da4ea43a5..411b7624331d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -432,10 +432,8 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
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
@@ -443,7 +441,7 @@ static int dw_pcie_ep_start(struct pci_epc *epc)
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 
-	if (!pci->ops->start_link)
+	if (!pci->ops || !pci->ops->start_link)
 		return -EINVAL;
 
 	return pci->ops->start_link(pci);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 3c1f17c78241..2a6109109029 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -140,7 +140,7 @@ u32 dw_pcie_read_dbi(struct dw_pcie *pci, u32 reg, size_t size)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->dbi_base, reg, size);
 
 	ret = dw_pcie_read(pci->dbi_base + reg, size, &val);
@@ -155,7 +155,7 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->dbi_base, reg, size, val);
 		return;
 	}
@@ -170,7 +170,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi2) {
+	if (pci->ops && pci->ops->write_dbi2) {
 		pci->ops->write_dbi2(pci, pci->dbi_base2, reg, size, val);
 		return;
 	}
@@ -185,7 +185,7 @@ static u32 dw_pcie_readl_atu(struct dw_pcie *pci, u32 reg)
 	int ret;
 	u32 val;
 
-	if (pci->ops->read_dbi)
+	if (pci->ops && pci->ops->read_dbi)
 		return pci->ops->read_dbi(pci, pci->atu_base, reg, 4);
 
 	ret = dw_pcie_read(pci->atu_base + reg, 4, &val);
@@ -199,7 +199,7 @@ static void dw_pcie_writel_atu(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	int ret;
 
-	if (pci->ops->write_dbi) {
+	if (pci->ops && pci->ops->write_dbi) {
 		pci->ops->write_dbi(pci, pci->atu_base, reg, 4, val);
 		return;
 	}
@@ -270,7 +270,7 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 {
 	u32 retries, val;
 
-	if (pci->ops->cpu_addr_fixup)
+	if (pci->ops && pci->ops->cpu_addr_fixup)
 		cpu_addr = pci->ops->cpu_addr_fixup(pci, cpu_addr);
 
 	if (pci->iatu_unroll_enabled) {
@@ -478,7 +478,7 @@ int dw_pcie_link_up(struct dw_pcie *pci)
 {
 	u32 val;
 
-	if (pci->ops->link_up)
+	if (pci->ops && pci->ops->link_up)
 		return pci->ops->link_up(pci);
 
 	val = readl(pci->dbi_base + PCIE_PORT_DEBUG1);
-- 
2.28.0

