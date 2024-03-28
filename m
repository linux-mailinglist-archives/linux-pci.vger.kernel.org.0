Return-Path: <linux-pci+bounces-5327-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44F88FB15
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 349DE290C69
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BB27E0E4;
	Thu, 28 Mar 2024 09:19:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2091.outbound.protection.partner.outlook.cn [139.219.146.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D477CF18;
	Thu, 28 Mar 2024 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617549; cv=fail; b=sTjv2uyPijMDbqB1nFjE6js8dMhpclnI/KbW0x7JGITY6rCYlRta5gPAi3Lx0D5W2n35d63tJ6MsuZIkxR2LqHqbml8k0LF+oWo/kpNCv+1s/m2WgDuRhxYrDVBGpoqpUjXJg7VvBtFoGwlSpVyKP330fp5coMWKe5Yp6sGUIgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617549; c=relaxed/simple;
	bh=Zo0vtMDlUQnEv4z3jiAEPsEljhHkUDAsLY+wuNCYIJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIOFbc+8yWccYfUA8yA+1jaSukUQYfZ+fXGJrczPynF4asbJtjq8+MflXAUe4zMt8LqnebcqDt/hShChNJegFY3BKny33HTPAMSkxBukoRq9LDz/xWY8xpKM1QxD2ddD31JKmIRzp8XikAIdQE5CltGaxZ68tOG01wLQ9NsJ7cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c48UPWRC+v5G4bXw5AgYe+Y6sxFs9rrqucIHSSGTd5u0nBDikbwqDIuloJ3BD0JHaz70yacY/a14KQrU+kNZPYnK/qBy73nG5ezZWxQY4HQFA6kmKM1gV9/EOC3WxI5+KdO01/tAnSadNwdOgkfv5o7PNoW5xPUeWA9wKbhdTf73bnT3s7UsN7i9S9IbyZor7dRSXy0t60zc5XBbVpxvw0/LXHQEqCu6Fc4+InGiz0M23OpBg88VQZEsfNyiDqrkHjPjl87T7O+44z8/wrpj3JOAdZcNCkuqsK7x/Cr2pXsRrKjWHuOMjaIVLuMUpSeuPeMcrynD1hEd+UDKk6MA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN9BSin22ElT+yVAKOhug7/CtveOW/fhCZdvxOLQSOs=;
 b=buM+U18lN1cJNFN64lmQEoZTEf1GWvs9B//oizWClWfbAb3wtQB8AaKrpN2Nm1cqv0VAxjjw1OYZODjnGMm8jpMe3pqkaNjMIvHJu+AuMv2MUNGedkKNzgUvwYJoLic7WcaEQncGG8jp9K3g7nVvgoz6O4gC/ENK1dWSfUtkguK4/WdHEHZZBCRJjQNEyhGsUltFHBQsiLhCVYs1+7juCjqxSdKdeAD89Qt60XiMi/x/GRd09kFoAzaUaKLkQVIr/mmGmzM96hg3avdXR60z5O3/zLKInzLrvNvmLJA9O5/lclz6lIzA1l+ClnN1tb7mY3J8PEkqgsexQVplp6VEkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:57 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:57 +0000
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
Subject: [PATCH v16 13/22] PCI: microchip: Add INTx and MSI event num to struct plda_event
Date: Thu, 28 Mar 2024 17:18:26 +0800
Message-Id: <20240328091835.14797-14-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38562830-f832-4b9e-aae1-08dc4f08187a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QswWP9nEkJOUUNeYdFReFuyIeW4tt1FRYdPtFs+RMECUY3ASv7ahdYpKets1vcK5oMMDTJ9E2B94OTsxTfSDfnYaJqKYqI4J+d03wC3c4fzsRDw6dldy6yDajaP5QrXaz9mtD1SLBsu6ZqtFf9Wa51l9MdLx5osRIbn4z7LdQttk0O3yltBoVFte9zJ1ADnkW3YRxI51rRfy/D6gzV6dhvdeyiv03ErI9yPJHMjMNjnuC4sP+jLPL56tKZGTz9snVi1TRYbT8WHXMx19Psl3714Jg0EsCDjWrrB8BM7wlMr1sU3r0ZSLnGRSK8o7HTtp9J8j24PIwRUCuiuL+tCk/5sc6o7RXyoh27OmIs1bolCGey1VGF3DkbBZjZ45DdtM0UVb57EVuIusdt2QbIC1QEP07rj3qBI8Y8XzKWOL/QL9/98FlyQU88yUSi27/uMwfGNpjomQoBY/ivaqy35P1guF2D/6wh4pl+acXZVvQL0KppdmlztyH0QjswyxHWcKy9YB1Fj8BmPS8+ZtAD1fuXLOleb7jgE/3nQaJqL6TCOJgwtog/lA5SLld6gQqP1LryKw4LEdISbapgNUaV+/x14UqjK0Q+ZVoNrjZMPkLiQEBE5g+uvMIrGjSRUwy5PA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+GtMImDKYaKpcpVaLqLSI5ll5kt9t9Mxz/84P6UiG5hp88djTlg1jCWkScc4?=
 =?us-ascii?Q?uISVgD0WjLE5qD5Sy+HM6XuD8izGz0VmPy/DOSPdmEFRGDCtGENfiMU3ZAnS?=
 =?us-ascii?Q?p+nXx9XWlbdaLemzBHPvzyykPVKBMRUKpk/47mbbBljX2PW7X6lw4Esw9jP+?=
 =?us-ascii?Q?3YzDiXhZ/KlIpONhIYTyUpdbQE40OIJv74MXbjvRSuVe/PwcelhWpZMSf0Vf?=
 =?us-ascii?Q?7grUqPTs66eGNojzyeSP+g8krTFhZfDMFh9bZWLtW+rtf65XdpOmJH0+wnHo?=
 =?us-ascii?Q?/wI/rp6DqoYolgIDRjJdxjNWX/I8hv4djREl9rZjuBNCTjYml2cvAom8KAvW?=
 =?us-ascii?Q?ewNgsqH5fJVxo9ATRb2xcN6EiKALR4hSPSEPwjsVaoDv1kEunonrZsS8/vG4?=
 =?us-ascii?Q?Utkmr+9XYtMnws3knVJhhG8S5moKN2xjI4zJAwO64mc/p2B2UA49ookQVo1T?=
 =?us-ascii?Q?QfUmtZuBvnlue4zK14Ww3o8Nn0cS719KnVK1T3ptCPxcgrTjjSuukDSLITxt?=
 =?us-ascii?Q?RBC4ml8j6rNeUKa5OMiRx6Vsp3VGHnTZCnJjUZx4nphYDo/K+MYINrRvlgEl?=
 =?us-ascii?Q?Oblbb7JaQRx3Ew7bP8DzytoLyuvl4brhzVDlVZswWBEArMNR2ojqWz/1gjYf?=
 =?us-ascii?Q?vExm+f1aSKf1HBiXJdULCgm2DTsR6fWLJOoIisipM9wnyXTyWLudSqqr5JnP?=
 =?us-ascii?Q?ffaVWFIX2OwCFDlwUtMor7cTgBEhhQQpKQGadZR8sDRCO81ZVAXuv0Sh+TE+?=
 =?us-ascii?Q?8cAV7Bwa1fy2rsLyU5qc95wzmu6Mdo+6LbKvVRJFuyoMxD0MaB9rSLSKpTXP?=
 =?us-ascii?Q?PkTn1D1UUQ83ITnMmvcgLj2ybDmZKHoyfMXQlmkGHffONSl27utHoXLAC43X?=
 =?us-ascii?Q?23AldsHpwEoiMpoTM+2cYaFDJuT52EbnqNWzglvceT/s+0dbQfOZ6HZSCKNG?=
 =?us-ascii?Q?bnagz9zEo5M120WLfxWggdkDOYeNMegZKvGjwA3dq+4b03zxpnq2jnStUpdH?=
 =?us-ascii?Q?j1dRve3tnsgihWMlzNJI1VSewKOokeFvGAOiAiX0Iz3DW+n30Z0GFwjFifxR?=
 =?us-ascii?Q?dz6MJuPJRA+bAKTdbg5VFMmwHlvY9gAXBfBq1PTbmpKjyU01ebrwIkHkEtSJ?=
 =?us-ascii?Q?boD3Jks7K4I3kia8eBbWL/8Lj5u49NJHuqnbr2++zqgKJ26TUDsTAVNUz8X7?=
 =?us-ascii?Q?FylUXWo8+oHGQvl0dOIUUxyrwVHGJKBeNRNGScgbIpsUMVcG4HCJ4lcm7l/u?=
 =?us-ascii?Q?2RY9v3HX49Z5sntab7L0pNwuqegPrbfM7hUl5hb+wnD7sd6OF8xhsZY9nZEc?=
 =?us-ascii?Q?L/mQ4WSkeKoVHzUqH5VZQ+HxwbdQFcgOIzx/0DiWEm7bbLf2eafr1vofGYCZ?=
 =?us-ascii?Q?njfi/8V2hqow3HbSZAnIY3tG4Ued0W5Ytwk47Rxc9YN6awE22lK9AOv4Gg54?=
 =?us-ascii?Q?K116yew9QVhMuiPNEwJ6D7Ws5Wh/RUcEPE4L31lCesASTUnDqN9zJk3pZYP5?=
 =?us-ascii?Q?XuEi5jPOenW9MBZc9UBteiiFJm8X661cwDeUhFgzbaIVMKP126IjBRfksuPW?=
 =?us-ascii?Q?hYSBOAQGcMzxu4ESSnda6n5eDwsK14F1q3sYuzO/S5gineBOVcSIEx3VPG3u?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38562830-f832-4b9e-aae1-08dc4f08187a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:56.9937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: quyYgEa7xu2wQSoR0QjanmqR8hfjMi3tNhMZVaC+fDzwY3E8WsO73tlsDyL2kDkmxPwP1UEPRLW6Yb634VStt94zxwvEREwTeIoMI1S+aiU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

The INTx and MSI interrupt event num is different across platforms, so
add two event num fields in struct plda_event.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index bf5ce33ee275..8a51d3aa7e88 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -817,6 +817,8 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 
 static const struct plda_event mc_event = {
 	.request_event_irq = mc_request_event_irq,
+	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
+	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
@@ -960,7 +962,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      event->intx_event);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -970,7 +972,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     event->msi_event);
 	if (!msi_irq)
 		return -ENXIO;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 935686bba837..89172ce18237 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -130,6 +130,8 @@ struct plda_pcie_rp {
 struct plda_event {
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
+	int intx_event;
+	int msi_event;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


