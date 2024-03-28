Return-Path: <linux-pci+bounces-5325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA3088FB0F
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AE8A1F275D2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75837CF30;
	Thu, 28 Mar 2024 09:19:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C77BB1F;
	Thu, 28 Mar 2024 09:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617547; cv=fail; b=TzzVso0FNApTDtELq2M3oI5HUnioxrkurC/nhYwIY8Ymn9xEWE/kCtzoEbUXpDCjggmicqbpfRReUVCh6AC0k/80N0QOU1ya5FuSkIPvhpGxqmWbRZiC+Wjc8VV793TO3lcAm/wvuHNEvt2oZSboe44hV8LEcBhAwHwP3Cc1Z2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617547; c=relaxed/simple;
	bh=kcLz6GXXaaMuiaU3v8rviMl71jjx5ZUPW4AIUhEerhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cgb/AFPrII7URxiBtb2tBAhsjVg6p5pOZwMTEgVARlPeRVoOc4Kk4poeuKOMNGyu/xdGyjIm+NdERWd5yURhkzo5NWdPtPxJad1xxInQz6zojT8uH4zAfLZguP+QoKUOGQeKxgJub9JW0PVHrRKfkCm5LgFHElZ4mxM2FllWoYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqUcISpoIFbNtQ6hZ0ZHt+IUMgXt9Vd160nYfjcHOVnCXb0FSeq61uZXUsTr9TlTGF2w5VANzNW89kpFoKQnBzXElQL18GIG3MpyFKiQlMORWhd9pj9upiT1kgU2LxEzzx7gUHy+EcdhfHB44jEfyJSi8h4U1imLoTgH+2njhVa+jfJ9rM3HElQ862ZrjCA9/iyV2OikDAof0TWpfIY96bjOiKvYJaQcu0yyCHtbP+FYRMCImSTf4LfGPUd3rmkQaGqchiOrjhTMnrpn34Nm8+TYfz8U9vENgZp6cIaaFXfGpD9y7LhylG3/kjd+JQYDm2UMOa8CgAynN4rDmZ7iJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCHTdafcVRRLyX1F31U5Ti4iQWrk2XaV+80OS75u1AU=;
 b=Ah1G+p+wJpA3j3weh5KWBXEqr+7AwZGqgjHadY52Earnnq2WjoZBLNtWUdteoCJR/ky5+rHupW1yh5EiacKT8ui91jJwHJj4QTlcqWZRiUn0QR//hxKogqs8W0Ypx1sdTJiTzoztAV8rriWPuRD/dl5rk5mA1a5Rb7+rZe2t3YllwJ0491my/TaHheP/LQz37yCmgDTSuWogKxwi7JdxgGXRoxwJYQKqUZEaCaRbU3jsMyIFBpucB4K8BAA689TkM/bfHFL/qL+989RSpanV2ZlxiqMGSKc+Bqa5UsF8WBQcBUUywF0rNn6CN8xE2BuQ4lVzyHOXfeMkQ6edqe/C+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:56 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:56 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v16 12/22] PCI: microchip: Add request_event_irq() callback function
Date: Thu, 28 Mar 2024 17:18:25 +0800
Message-Id: <20240328091835.14797-13-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: a6447209-6191-4018-74f1-08dc4f0817e3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WLaObnClvK4MoiRymgNZBswN2z504NpbELK86C4DurmBE25/tJ1+mbGLW/pTVOXXrc8Omh9HrUxOsJHVpDi/b+P1ndPN6+to6KyLaSvRCKGn6znVk8PBCPl4J2ZU8Rw02fX38DqZUpoYcoE8ZwR5UQAtqE//siqMaRP/UWghpe4JjGLh67qR6qwjVfrmlcBswKr4K3krt1k865ohORqsuqDEs6VxCCIfYUhra4E2KLGLUWnpPxjHXHYpvh5f8m3hyZ6Fpk2WG4Rpy4bHRtEHf1NCjEr6UnoNOtb8RpXJ5cDzgiu+7ABlx61yBYlo5Uut997BxZ0SgQUIh25oDWwtLoPcpSUggIn4Kd5rfsiEdNieI3jO3cuBW5znE7O26LYIJz/pTzhwycxWMT5iLcQFzzPDyWX3DhOM2UbXmZMT2SOywJgdmimrwRDKx5ogkleDdvkOdFiGCxGZSoAH+NGOoSV5OhB+9pITHM6wTBDJDR8x9+8MukoHEUCwFjc5MOniRETbOozVoQEGVZ79m4EpIVlT4ibRsQN6XP2PhXht2DLBXjEtqZV/9lwtWYraZBc8KVcmx3TPpdrZq07RW2rgjXnO8ymxkkl5rD0PwhOXfnsHV+/f5Retw+eADkYq4duM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lLwFZqXOlTdfQUPYTHmMjKu/eWBpw65FS1b3SvA6UBxzURX36yXDFJZJ+U2q?=
 =?us-ascii?Q?5pzriRRmh838f+IHGHI66uRfn4sFn4hlqBUC/LyQdafGF2CRWMsc0OM5bINP?=
 =?us-ascii?Q?yh4hnEgjzis0pLBPU+Tuz1915WBojvkQRKat+DP5CnXTueS6mzyFE3cL6A4L?=
 =?us-ascii?Q?M+uoInpkhF9NX5SWMKwZl9Ocb4qOAtrrolmrLlczbKmyyqu4+PWW2j3rb3qd?=
 =?us-ascii?Q?qsj7VbQl8axQ244UQYxdHoPBwoa4rATeRXshO8bTVsxgQIMSiJ5DagmczEoS?=
 =?us-ascii?Q?Zef+isjH9zxbpfLtXt5hil+3nbma3BdcAW8gvx0Wiy2pKKr3YnPEv8aJnD/F?=
 =?us-ascii?Q?rz6/s0LJYYyWXkx/D/EpjnFuVi1JHkTYmnXm8aCO/DKCaWt7Dbbs7zRVYqzl?=
 =?us-ascii?Q?0ZtWK0j7V7pQ5e7WuzUEaDW/fBmNVyuwVizbKkPxadcnND1tc3cJlSrYmpxv?=
 =?us-ascii?Q?9vLMPIoGICqH9CAwgfCK9/yDraD5R2Q7gvo+dMZMiJ+uw2bkgxeo2NU4YaqG?=
 =?us-ascii?Q?8KLyMLed5tH3PY3w4jLAGiQAkkCOK8xvUBwbqmpDb6a2H76zJuxlSIxdjckV?=
 =?us-ascii?Q?02nNM4cuLRLmuta6A22dRLN5Dk7IZ154TdhUPwFCzO/1VTfmPYGry+nDSEU7?=
 =?us-ascii?Q?8MiXcvA/P1V5ST+zWiHSSLAhlFeb1wKEp2DwXQBbtIWqsB7c0AWpvy0e+4Eh?=
 =?us-ascii?Q?ddqMNlPAusVOA7Dv/Z30RUIObJmO3pECZ/YBzviGL57NjB5KwhdWYJgwgxnE?=
 =?us-ascii?Q?8xq4HWx//mQOKaY6ToD1cHdHmxljiI1XBPExQIDMH5omF2TDTQMI4qlxL3kr?=
 =?us-ascii?Q?2Q6ira6IO7YfZoTVDUJ6EJ680kzzkACmIlc1c5tmwYYv/0FzTgYrqycOktJx?=
 =?us-ascii?Q?G4jsTYioHPrcHsnJb9DO4AcouEgI65GfDjSn7qP7OooLmLdcDZO/TQSi6OFF?=
 =?us-ascii?Q?t1WN3Jqp86yGR/8yloh2KlsTMysVsvNVf3J7layccKcnR/RnC86CGGftJPmI?=
 =?us-ascii?Q?nmjqITRWLBEAo2hAD9EMWlXQzdPyrC/49aequ/VkLPph2gyc6jQcyPViHJcq?=
 =?us-ascii?Q?1trPByxJ1feujy2sRBiMCLq2RaVGdR1n0T7INl3ATrp0++UuQsLOPVUE4ZPp?=
 =?us-ascii?Q?uEb6HUocRm4dYlJZvQkUhXQrufJWROvgubdCeCwV7SqihtMbq7TPGWdxzsNV?=
 =?us-ascii?Q?yVz4VdmIe3ChlrxHl0tyB71atWF0Io4TqfL0/4IkpZg0/RaUFvnuCq9vVF7Z?=
 =?us-ascii?Q?Zd8X44g6ChcUO+xV2RXLwCeVPRUBdmcdQ8JCP7wq8A0NH0H/Zod+/AtGhPqB?=
 =?us-ascii?Q?lRfXdEYNd3dWMjxmt4wJflTusA5iCpMYrFgJF896ssUBCq91WzqzyItLL1Sr?=
 =?us-ascii?Q?ksYyg3hcZZL67PMqh9z3NnAL4tnSjX5IJxyle8J/A+taF0SiYIduU2kQiSq/?=
 =?us-ascii?Q?jcrSdBPx/CuiUgb6HVJcb82eZecPKZbND2VVWjGx6LWMbMpSAlizHLSfqmAg?=
 =?us-ascii?Q?e6Za609XE6X8VmnXJNtS7WtKQSoLL4pozHiG1I4C/CaBqMnK7Jtqabzf2K42?=
 =?us-ascii?Q?6EaFatmgCBqYOgFnGhDwTeDa6sk5Be0K8i6MWAEheypH7ryLLd50VT0am8OY?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6447209-6191-4018-74f1-08dc4f0817e3
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:56.0007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brl5r0ZuHl3hKDqR2m8LINCGCnmem0M9AuiL3K6wAgZXQZJhUcMCZbhY1QsoMua90dZBaJ47VNzbIH0qThs12y7pVcSoD/KPwrFrZUUi3MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller. Microchip Polarfire PCIe add some PCIe interrupts base on
PLDA interrupt controller.

Microchip Polarfire PCIe additional intrerrupts:
(defined in drivers/pci/controller/plda/pcie-microchip-host.c)
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

Both code of request interrupts and mc_event_handler() contain
additional interrupts symbol names, these can not be re-used. So add a
new plda_event_handler() functions, which implements PLDA interrupt
defalt handler, add request_event_irq() callback function to compat
Microchip Polorfire PCIe additional interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
 drivers/pci/controller/plda/pcie-plda.h       |  5 +++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 0a5cd8b214cd..bf5ce33ee275 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -642,6 +642,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -803,6 +808,17 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
+static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
+				int event)
+{
+	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
+				0, event_cause[event].sym, plda);
+}
+
+static const struct plda_event mc_event = {
+	.request_event_irq = mc_request_event_irq,
+};
+
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
@@ -904,7 +920,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev,
+				struct plda_pcie_rp *port,
+				const struct plda_event *event)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -928,8 +946,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 			return -ENXIO;
 		}
 
-		ret = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
 			return ret;
@@ -983,7 +1006,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = plda_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index f7e900b395f8..935686bba837 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -127,6 +127,11 @@ struct plda_pcie_rp {
 	int num_events;
 };
 
+struct plda_event {
+	int (*request_event_irq)(struct plda_pcie_rp *pcie,
+				 int event_irq, int event);
+};
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1


