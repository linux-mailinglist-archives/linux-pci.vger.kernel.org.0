Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9615B830
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgBMEKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:15 -0500
Received: from mail-eopbgr150083.outbound.protection.outlook.com ([40.107.15.83]:49366
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMEKP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lx84M8XI56oEGXx5rAvmzCLBIvfEg/Y4x9PuaXDWGPSoKHhTYkqR63tw86T3Ik5MwZ19CVjskvhhny8Gsbv5k3BVDFa3t1vzojB1ctSIMfkjcPKim5zbZ688cFO6lsU2a6Qr5VFQ+7eeJVeeGl1pweXzBW4XkHNli23wHeR374FxAVyyXk6W0AMTfjnvgoiqLnoGhHOzQQsIUk6Lwk2nGgcLH1VGpSFcvALiFui9GCNJ1hA3aiNCtZaSqFp53Q7iiHo8yKINYvaC+p8XJx7PUlSmfUsPBCXja3i14XRvOjUmoaJbhfnNS0kamt92WIbjIwmi1/p0IFuPcMT5uTVJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9baF0TqkA50I5vBO1wWUX0h/JmEhSSa+eH5Zi6cB0MM=;
 b=le7yuRSOfDU+NCo4Y81E6XfqvqbC8r6viome4KNU3j0Uo2riB5C1S4JeKU+BsgX1o00IlOvU2k5KMoHy5hWSo8E3owysLYocPZ9R5Czm6HVuhwmc3rux7gi5PRoRgJeysLY234N8wgYON/PiL6s7vsQs7oVu2tbee7DcXdnEXAavrX+Wzu0WtcmEedKTIUaxe8/k8s4mtIUarDVHkBHNwlVhJxzDjfBm2Ct7+6qpjM9aVxYR6847/Zvb1ktPkfSSY1JIAiokpVqMFWJsRyfMQg8fWCNNLhumzavab7XyzZto6En+JeS5/Bk0/V2j673NtOcM7IouBTQPEwBhjXvhwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9baF0TqkA50I5vBO1wWUX0h/JmEhSSa+eH5Zi6cB0MM=;
 b=MjbzbeXJSi1Ekbjz5GFrFvJro6VBYNKfk/8j2/tIxwRRziStaAW1ClEMZdTvVGFNablR4pHpNNZHKDB6/sGjSIv+EJWsxUUHeGMoOCYcyDr+ivI2h9U7hXpbI0ya8Z/iGza6Nv/B60HZPB20mWyRSGtdEWJh+VepJbCZ+5bw2g8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:12 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:12 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 05/13] PCI: mobiveil: Add callback function for interrupt initialization
Date:   Thu, 13 Feb 2020 12:06:36 +0800
Message-Id: <20200213040644.45858-6-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:06 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad1fa72d-9276-4446-6891-08d7b03a9f11
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7084A65157CE8F0763B79239841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/T+NzoOm97WQ0DAg/Hj5bCIF77Fpz0oIR7rPvtT3JvbDLDfeagFz1mawehJst8JeA93lFpnojxYSCJRCorNkxoaOvlmuMIgKyHjFV2LJC/iJ2hehEC16YMxg8kP5td9jZTU/IZivWQ2WdiDtnmP/WzCyafsvwFkoPhz0MB02OgoAT9+kVX0gfrlwURdVa4YCM0gpF+BGecEzmJZSm5KdE2uGzpGZQT2+AEMndQtcM5xQs69K5olq8G9uWMmGdNW4NS4QLDb3OYjUUnCJdewrS7YXa7fkjrxQh+5y7N3GjYQS6AXSdMwfJrTZWaa/6g6/9hut+vywMmY2LFXz7lMPifMLegSRemIhwDqy9PJVtqGCgJLH0e4ac+xsF5ic7UmAS/X+6hY8+QqDY1f4uQskiTGkti1n+vy133nbtf+PPvRAK6a4Jl3D7DNynTohE3+9urDxnBHnJqRfW82ZTRPzpGGMCgKMgVoB3TJjB16QfQlBnvxlvzZWs3CSbLlOC5MsXCUTNfDLpUlNqCFm4hM1WC1m3OR0ixF1BZ830QP1806hqd7D3UtQ9YIE4HdXezwPDdvU7D3ISC0YJBAQTpFgQ==
X-MS-Exchange-AntiSpam-MessageData: 4dMJHIAJhmm9XZnz/gp2af/ZuJ1gTIU5GL7rngZBCRmOyBslihr+goCnxTnxN8IMG4BX8SNMdaBdFRJpTXbxwgn+fQE6ccoXTPk+TfIz35ApMb+0iVqNgLM/yx/taAXdjUOm1qubb2Ir5KJuNKoBIQ==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad1fa72d-9276-4446-6891-08d7b03a9f11
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:12.2302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/zwk2tUuVEIHjyAdSrN7gzPM55gi0+wmTkbGv81/uTFuPqFbEfsv1PG3yiywMBdjf/t3+BF1WNRPbMjj5ZFog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The Mobiveil GPEX internal MSI/INTx controller may not be used
by other platforms in which the Mobiveil GPEX is integrated.
This patch is to allow these platforms to implement their
specific interrupt initialization.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V10:
 - Introduced a helper function mobiveil_pcie_integrated_interrupt_init().

 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 12 +++++++++++-
 drivers/pci/controller/mobiveil/pcie-mobiveil.h      |  7 +++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index ea90d2f8692e..53ab8412a1de 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -499,7 +499,7 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
-static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+static int mobiveil_pcie_integrated_interrupt_init(struct mobiveil_pcie *pcie)
 {
 	struct platform_device *pdev = pcie->pdev;
 	struct device *dev = &pdev->dev;
@@ -539,6 +539,16 @@ static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
+static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	struct mobiveil_root_port *rp = &pcie->rp;
+
+	if (rp->ops->interrupt_init)
+		return rp->ops->interrupt_init(pcie);
+
+	return mobiveil_pcie_integrated_interrupt_init(pcie);
+}
+
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
 	struct mobiveil_root_port *rp = &pcie->rp;
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
index 81ffbbd48c08..0e6b5468c026 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil.h
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -130,10 +130,17 @@ struct mobiveil_msi {			/* MSI information */
 	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
 };
 
+struct mobiveil_pcie;
+
+struct mobiveil_rp_ops {
+	int (*interrupt_init)(struct mobiveil_pcie *pcie);
+};
+
 struct mobiveil_root_port {
 	char root_bus_nr;
 	void __iomem *config_axi_slave_base;	/* endpoint config base */
 	struct resource *ob_io_res;
+	struct mobiveil_rp_ops *ops;
 	int irq;
 	raw_spinlock_t intx_mask_lock;
 	struct irq_domain *intx_domain;
-- 
2.17.1

