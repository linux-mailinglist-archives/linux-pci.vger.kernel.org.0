Return-Path: <linux-pci+bounces-4108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5338C868E0D
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5F66B29861
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6011386AF;
	Tue, 27 Feb 2024 10:52:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13192F9D6;
	Tue, 27 Feb 2024 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031166; cv=fail; b=DoWCCHEF6GmCu1J/9vI8E9B5tIEFAhbOjlI7tlIQMYEJx88HG2d4s2TPF4oGwQvNnCpFbgU+kFNqmGw+iHaXcYnWH2lnOjOOEYta8GqDyqoo5fuOwDnrsrFJ8hlrvnVejXm2Vu6+redioIlr6cy7Ra3/lK8grib9MsheUf1XqTc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031166; c=relaxed/simple;
	bh=6SnxoGHctv+weLX/56bmnX8+FM2s7IXcfCAn0xJUvD8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6XhbORca7qrqQER2GA8rGb6GhHoj3jaDgKnxijk+RQw8Evnas1WbU3e1lA6TNQ7GKDxQ1AMBZGRIHU42lXbFUE6ca4H6UaVf6Uv2QFRhCeTiwn21KZSIPn53g2lxDP2ZUQdYYTLN/Qh7+2iK9GYVEXyC8A5OSCqDOh1QkzXfJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNXsaEMDiav2GzBMEwlCMjQcVffcDVdzT7WD1haMdMCjJJdKgqGZc+o/NCYmE3mAm5nZ5UzVuIyXNgeRXJtqIjvQN2cfurHiY9G9J0GbU6PG7OVidykP71qUyS+FoxC3msWJSXlW5pUHiIVFHc8ZNUDOqc/Pl1a1pcpEDg2OVrpA53zhipYkhMc7RbZBW19wzhmxdj7WCWHERsQTokbr3BW06tWFEHDUFEaMHyQFTE2sPqurGH0bTwhY/1mnrSxYBAJcmlABy3ecwuQAvm2aamjNHRLl/XzkOlonHsYZLJe/0r7w3epBkkRjShbQqq18Ie+QlKikWZJTQB45gU2XQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFAi/9ANhMNoN8P+bySA8VVky1s7VfWBI39iKhS+vok=;
 b=dIoqz+q4C56UT32f+qiQX+t0R8GtcviKklDwOBLm16ltANpulgQRfMQ2TY6zMh7k08hN2qEFX6Repam+/Y7DmQm7QB6SkUY0CTUY0/TQImritOEW5VSqw5BMlDL90Yf++OfqsTS6xoChsctMfzgCtpiJkGnM5aT3vfcLBmRZ3ENJiyphpFXxVx/igmYKhSZ5NnlLCsL2N6RwqUEpBxPwJj1O8ganXBcnMGSl63xfi8LxYY9R1D/aD0uiSvHNYnX0qvHAYAKOhXRmzmfUjt8PL+5R0WN98EVkn9h3Wr0JifScUJK5vGWVdJFkss9z296pBj3fbo56IqarDnGxdsku7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:45 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:45 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v15,RESEND 15/23] PCI: microchip: Add event irqchip field to host port and add PLDA irqchip
Date: Tue, 27 Feb 2024 18:35:14 +0800
Message-Id: <20240227103522.80915-16-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1c0fa8-0057-4b38-46dd-08dc377fdad4
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qm2+IOy7SohhWm/eqIpf/SAnWoPEzel10FFY2eaJxgKz/Oweqw0ry5I1q/PyjYmmrY16p4kBSmHvPW3/eGuhgEcL7kOsKip2yHYhwEHeOGoRjLCeHE3TPOZShJMM9NohH2PL8oJBWBg8Ogp0xgFcaRqdz+bxfMLLCZ7TNiD8l9a781GVAwMu3oEBtgNspD5EKzsh/H2fc/mYmDo5DcZuck6MZlNvLsP/7VT8lmLsYNnLvwTGbuIgF4FvhIU/pUq96L2Hy813OtOYWJaL/USzg9fwYOV33ygfc7aXhOMzhlyI9y+1a73MUv8lQXXsApvSO138f6jRgxwsaLiZgSCtuufZ48RwPTu5F9v6vnYd0R5GPMBzjgdJpyuuXsJiy0WADSYqbumdoVpS6YCYc2rfvYr6Qh06WZMrnNzAf+DZAzdp7Bt2cNzlD0lvZ1WhxoXQKMWkUNY6hs2K/XJyq7yGhjCHwPMNXinlyRRV0dr69u4hYH07kcNO6IA050hbeTphGNVws0LBER9OGAdn0ou2vqOxwxB6BqsEH5jraDgjNlZxmMSzg8VoK3l2iK0mdgkPTQDWwGSM3SVyTquZDo1voI2cayCUlL+jmD+6ySr5RQWZsxw87kwNA1hkszAnGQLm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ziXWBkhXYkRb5jMlNQKgXMkg/o/LDE1sXQi3XWQmMbl1p7kSl8nfZWAS1Zwz?=
 =?us-ascii?Q?v1daeTdLjncg+VyksjOxma7JaYgHgY1mPppi8RHRe5+44dJdWSCkVlNZS5Iw?=
 =?us-ascii?Q?NJTL6KYcYuBn9RKdUwd/sU4wYWlNA598MJvs2JaMNpmni85FW/2Kq/jYPy+m?=
 =?us-ascii?Q?ys47EfV9gn/E+/fw3widG5oGtYDkaWWJcXWeknPdU5rM9JgK9la2ytDq1XME?=
 =?us-ascii?Q?R9GJI2X0TL41zml6CfQKY9Ove53urhwC1PowFQMGltD57ucPR3sP6h9gCo8j?=
 =?us-ascii?Q?ncMZ15L9usUITJXeDmNiSZG5XPDRd8DigAgNyIeEnd9ynRskwhCvNwMM3EOF?=
 =?us-ascii?Q?+OvU/bVCxs4gpafnTo6CzPgVxtXRjA5HNQVbupnGp9KrgdB3sLRioqDmo8AB?=
 =?us-ascii?Q?LCYfupfFkjksBD01n1ExXqaAFFKrKV/TcaveYr/YorZi/97jfE3I9DkQi9KT?=
 =?us-ascii?Q?G72oHn8y0iH7drz4oJ9MGO1HCzK5S/4vr8CU18x53BIcfvXbYXEhK/NYKjFV?=
 =?us-ascii?Q?A9DbD2uuhfXZ+lOBeFyZv8P+3Eoo1GDUj2M9V9nu0DWJ3L4viSgPVw2o4zf+?=
 =?us-ascii?Q?yLx8G73K83XKVDYhuApocR1DfYaBcg1I0LBX995BtcLO5KkixC6/YfA1Lz5l?=
 =?us-ascii?Q?UY6G+VZ/Kyo80Bz456xsnHb7Fs7mRdXGv2CI3EfDu35rknax4ByB9wvJh2ct?=
 =?us-ascii?Q?u8TIDFdmJ0Cq16XGHRZlx/zOoOAs+slmEXxmLvk7f7AxEB9DEuokEkiRIeBE?=
 =?us-ascii?Q?q/3V87bnTmxog68EVI5ELLPMQsZ6Gg3tard0XxReSyaBwTGb7EYN5pVirmOW?=
 =?us-ascii?Q?NxbsWbDyApgVoOkve6ST3opSFAY/7eRTwtr4UXuXEJ6xp3KPZ1orFVZvo4Jl?=
 =?us-ascii?Q?i4vFRKI8Hv0OGHfAGqysX2YlHejyxBCZ+8OooI2PwNu1P9ncKX3SUcEcF7US?=
 =?us-ascii?Q?ZGGrJmaPSuaEDUpYwc24FTddCkT/jcxviGByLZWZnyE5JEo1NsoMCBuLFxtH?=
 =?us-ascii?Q?e7utkL0GP+QiOlIPX1bZ7qUbOUo4voDM0aaC6z3xyewFkadIlFHhaU23p6cY?=
 =?us-ascii?Q?Ju3ghIWZMFBHkj+YE5ZOwMGAVuVeecQUVFa0mAcskO/92DJ8BKBqtIkRwRmX?=
 =?us-ascii?Q?rVGiOPv0Gl4zFYo4+VoweZS73QNyr81FJCaUW0dlSrm/Dm+tywj5qFHUEl12?=
 =?us-ascii?Q?+zaobO4nsI975xVp2KK8IZRoZrqjC6vmlmZxQlKbI8IIor6YNoWimwm/qyIf?=
 =?us-ascii?Q?bLw1JxwRno9o4JmwBjVB2nieEriCVHE+7nW1+RASlVFj1H3XGzwyzbJypRNS?=
 =?us-ascii?Q?rUvmQvQHKpLwl9Mfxv5RY7un/KLHA6wka0SB5zE8zuHDaVzYrA1Xk4seZYDM?=
 =?us-ascii?Q?M+r7beAzpQICYyMFTm0R7gAjkJK7KP1SUtiA0UfB+nsNrzt/2Su6QPjZ17KU?=
 =?us-ascii?Q?ZsbUxre4CSjeDz1EmhT9Q1H6ejXgQJ2GF3zUstVrUOdftoigVvKXvbcqonm7?=
 =?us-ascii?Q?9eACPkTukf4RCU/sD9UNyflOYNabv4Jnx4usTOANVVKGA2nzS2lj1sOh/bPR?=
 =?us-ascii?Q?GJJg1ZfZUfH4SI647K37k3kxFiPDanV3s9Rxm/1ra75j52WxSIWwfP+ff5Nf?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1c0fa8-0057-4b38-46dd-08dc377fdad4
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:45.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLp1pE7dnUQT7yt11Yzo8Ahz4KmEjb26Tye4UMiEEhhim51JmKySzHMMnrOxI3h8bBVTdN8vYRbnd8Eg74FcgXlLEOVubvU58p3ODLF83fs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller.

Microchip PolarFire PCIE event IRQs includes PLDA interrupts and
Polarfire their own interrupts. The interrupt irqchip ops includes
ack/mask/unmask interrupt ops, which will write correct registers.
Microchip Polarfire PCIe additional interrupts require to write Polarfire
SoC self-defined registers. So Microchip PCIe event irqchip ops can not
be re-used.

To support PLDA its own event IRQ process, implements PLDA irqchip ops and
add event irqchip field to struct pcie_plda_rp.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 66 ++++++++++++++++++-
 drivers/pci/controller/plda/pcie-plda.h       |  3 +
 2 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index b3df373a2141..beaf5c27da84 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -770,6 +770,64 @@ static struct irq_chip mc_event_irq_chip = {
 	.irq_unmask = mc_unmask_event_irq,
 };
 
+static u32 plda_hwirq_to_mask(int hwirq)
+{
+	u32 mask;
+
+	/* hwirq 23 - 0 are the same with register */
+	if (hwirq < EVENT_PM_MSI_INT_INTX)
+		mask = BIT(hwirq);
+	else if (hwirq == EVENT_PM_MSI_INT_INTX)
+		mask = PM_MSI_INT_INTX_MASK;
+	else
+		mask = BIT(hwirq + PCI_NUM_INTX - 1);
+
+	return mask;
+}
+
+static void plda_ack_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
+		       port->bridge_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static void plda_unmask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip plda_event_irq_chip = {
+	.name = "PLDA PCIe EVENT",
+	.irq_ack = plda_ack_event_irq,
+	.irq_mask = plda_mask_event_irq,
+	.irq_unmask = plda_unmask_event_irq,
+};
+
 static const struct plda_event_ops plda_event_ops = {
 	.get_events = plda_get_events,
 };
@@ -777,7 +835,9 @@ static const struct plda_event_ops plda_event_ops = {
 static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
 			       irq_hw_number_t hwirq)
 {
-	irq_set_chip_and_handler(irq, &mc_event_irq_chip, handle_level_irq);
+	struct plda_pcie_rp *port = (void *)domain->host_data;
+
+	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_irq);
 	irq_set_chip_data(irq, domain->host_data);
 
 	return 0;
@@ -962,6 +1022,9 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	if (!port->event_ops)
 		port->event_ops = &plda_event_ops;
 
+	if (!port->event_irq_chip)
+		port->event_irq_chip = &plda_event_irq_chip;
+
 	ret = plda_pcie_init_irq_domains(port);
 	if (ret) {
 		dev_err(dev, "failed creating IRQ domains\n");
@@ -1039,6 +1102,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	port->plda.event_ops = &mc_event_ops;
+	port->plda.event_irq_chip = &mc_event_irq_chip;
 
 	/* Address translation is up; safe to enable interrupts */
 	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index e0e5e7cc8434..a3ce01735bea 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -107,6 +107,8 @@ enum plda_int_event {
 
 #define PLDA_NUM_DMA_EVENTS			16
 
+#define EVENT_PM_MSI_INT_INTX			(PLDA_NUM_DMA_EVENTS + PLDA_INTX)
+#define EVENT_PM_MSI_INT_MSI			(PLDA_NUM_DMA_EVENTS + PLDA_MSI)
 #define PLDA_MAX_EVENT_NUM			(PLDA_NUM_DMA_EVENTS + PLDA_INT_EVENT_NUM)
 
 /*
@@ -155,6 +157,7 @@ struct plda_pcie_rp {
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	const struct plda_event_ops *event_ops;
+	const struct irq_chip *event_irq_chip;
 	void __iomem *bridge_addr;
 	int num_events;
 };
-- 
2.17.1


