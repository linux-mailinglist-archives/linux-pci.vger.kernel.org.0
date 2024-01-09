Return-Path: <linux-pci+bounces-1885-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB73828107
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:27:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309B2283604
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81BA381C4;
	Tue,  9 Jan 2024 08:24:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8D374F1;
	Tue,  9 Jan 2024 08:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id EC8711C05DF;
	Tue,  9 Jan 2024 17:24:07 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>,
	Yang Xiwen <forbidden405@foxmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Vlastimil Babka <vbabka@suse.cz>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-ide@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [DO NOT MERGE v6 16/37] irqchip: Add SH7751 INTC driver
Date: Tue,  9 Jan 2024 17:23:13 +0900
Message-Id: <5851e1a010c2679f957c0c4be2539261f26957c9.1704788539.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1704788539.git.ysato@users.sourceforge.jp>
References: <cover.1704788539.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Renesas SH7751 Internal interrupt controller driver.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/irqchip/Kconfig              |   8 +
 drivers/irqchip/Makefile             |   1 +
 drivers/irqchip/irq-renesas-sh7751.c | 313 +++++++++++++++++++++++++++
 3 files changed, 322 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-sh7751.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index f7149d0f3d45..658523f65b1d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -679,4 +679,12 @@ config SUNPLUS_SP7021_INTC
 	  chained controller, routing all interrupt source in P-Chip to
 	  the primary controller on C-Chip.
 
+config RENESAS_SH7751_INTC
+	bool "Renesas SH7751 Interrupt Controller"
+	depends on SH_DEVICE_TREE || COMPILE_TEST
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Support for the Renesas SH7751 On-chip interrupt controller.
+	  And external interrupt encoder for some targets.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index ffd945fe71aa..26c91d075e25 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -120,3 +120,4 @@ obj-$(CONFIG_IRQ_IDT3243X)		+= irq-idt3243x.o
 obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
+obj-$(CONFIG_RENESAS_SH7751_INTC)	+= irq-renesas-sh7751.o
diff --git a/drivers/irqchip/irq-renesas-sh7751.c b/drivers/irqchip/irq-renesas-sh7751.c
new file mode 100644
index 000000000000..9e5337f793c8
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas SH7751 interrupt controller driver
+ *
+ * Copyright 2023 Yoshinori Sato <ysato@users.sourceforge.jp>
+ */
+
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/of.h>
+#include <linux/io.h>
+#include <dt-bindings/interrupt-controller/renesas,sh7751-intc.h>
+
+struct ipr {
+	unsigned int off;
+	unsigned int idx;
+};
+
+struct sh7751_intc_priv {
+	void __iomem *base;
+	void __iomem *intpri00;
+	struct ipr   *iprmap[2];
+	bool	     irlm;
+};
+
+enum {
+	R_ICR         = 0x00,
+	R_IPR         = 0x04,
+	R_INTPRI00    = 0x00,
+	R_INTREQ00    = 0x20,
+	R_INTMSK00    = 0x40,
+	R_INTMSKCLR00 = 0x60,
+};
+
+#define ICR_IRLM BIT(7)
+
+/*
+ * SH7751 IRQ mapping
+ *  IRQ16 - 63: Group0 - IPRA to IPRD
+ *   IRQ16 - 31: external IRL input (ICR.IRLM is 0)
+ *  IRQ80 - 92: Group1 - INTPRI00
+ */
+#define IRQ_START	16
+#define MAX_IRL		(IRQ_START + NR_IRL)
+#define GRP0_IRQ_END	63
+#define GRP1_IRQ_START	80
+#define IRQ_END		92
+
+#define NR_IPRMAP0	(GRP0_IRQ_END - IRQ_START + 1)
+#define NR_IPRMAP1	(IRQ_END - GRP1_IRQ_START)
+#define IPR_PRI_MASK	0x000f
+
+/*
+ * IPR registers have 4bit priority x 4 entry (16bits)
+ */
+static void update_ipr(struct sh7751_intc_priv *priv, unsigned int irq, u16 pri)
+{
+	struct ipr *ipr = NULL;
+	void __iomem *ipr_base;
+	unsigned int offset;
+	u16 mask;
+
+	if (irq < GRP1_IRQ_START) {
+		/* Group0 */
+		ipr = priv->iprmap[0];
+		ipr += irq - IRQ_START;
+		ipr_base = priv->base + R_IPR;
+		offset = ipr->off;
+	} else {
+		/* Group1 */
+		ipr = priv->iprmap[1];
+		ipr += irq - GRP1_IRQ_START;
+		ipr_base = priv->intpri00;
+		offset = ipr->off - INTPRI00;
+	}
+	if (ipr->off != ~0) {
+		mask = ~(IPR_PRI_MASK << ipr->idx);
+		pri = (pri & IPR_PRI_MASK) << ipr->idx;
+		mask &= __raw_readw(ipr_base + offset);
+		__raw_writew(mask | pri, ipr_base + offset);
+	} else {
+		pr_warn_once("%s: undefined IPR in irq %u\n", __FILE__, irq);
+	}
+}
+
+static inline bool is_valid_irq(unsigned int irq)
+{
+	/* IRQ16 - 63 */
+	if (irq >= IRQ_START && irq < IRQ_START + NR_IPRMAP0)
+		return true;
+	/* IRQ80 - 92 */
+	if (irq >= GRP1_IRQ_START && irq <= IRQ_END)
+		return true;
+	return false;
+}
+
+static inline struct sh7751_intc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+/* Interrupt unmask priority is 1, mask priority is 0 */
+#define PRI_ENABLE  1
+#define PRI_DISABLE 0
+static void endisable_irq(struct irq_data *data, bool enable)
+{
+	struct sh7751_intc_priv *priv;
+	unsigned int irq;
+
+	priv = irq_data_to_priv(data);
+
+	irq = irqd_to_hwirq(data);
+	if (!is_valid_irq(irq)) {
+		/* IRQ out of range */
+		pr_warn_once("%s: IRQ %u is out of range\n", __FILE__, irq);
+		return;
+	}
+
+	if (irq <= MAX_IRL && !priv->irlm) {
+		/* IRL encoded external interrupt */
+		/* enable and disable from SR.IMASK */
+		update_sr_imask(irq - IRQ_START, enable);
+	} else {
+		/* Internal peripheral interrupt */
+		/* enable and disable from interrupt priority */
+		update_ipr(priv, irq, enable ? PRI_ENABLE : PRI_DISABLE);
+	}
+}
+
+static void sh7751_mask_irq(struct irq_data *data)
+{
+	endisable_irq(data, false);
+}
+
+static void sh7751_unmask_irq(struct irq_data *data)
+{
+	endisable_irq(data, true);
+}
+
+static const struct irq_chip sh7751_irq_chip = {
+	.name		= "SH7751-INTC",
+	.irq_unmask	= sh7751_unmask_irq,
+	.irq_mask	= sh7751_mask_irq,
+};
+
+static int irq_sh7751_map(struct irq_domain *h, unsigned int virq,
+			  irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &sh7751_irq_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+	return 0;
+}
+
+static int irq_sh7751_xlate(struct irq_domain *d, struct device_node *ctrlr,
+			     const u32 *intspec, unsigned int intsize,
+			     unsigned long *out_hwirq, unsigned int *out_type)
+{
+	if (WARN_ON(intsize < 1))
+		return -EINVAL;
+	*out_hwirq = evt2irq(intspec[0]);
+	*out_type = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static const struct irq_domain_ops irq_ops = {
+	.map    = irq_sh7751_map,
+	.xlate  = irq_sh7751_xlate,
+};
+
+/* renesas,ipr-map has 3words per entry */
+#define IPR_MAP_WORDS 3
+static int __init load_ipr_map(struct device_node *intc,
+			       struct sh7751_intc_priv *priv)
+{
+	struct property *ipr_map;
+	unsigned int num_ipr, i;
+	struct ipr *ipr;
+	const __be32 *p;
+	u32 irq;
+
+	ipr_map = of_find_property(intc, "renesas,ipr-map", &num_ipr);
+	if (IS_ERR(ipr_map))
+		return PTR_ERR(ipr_map);
+	num_ipr /= sizeof(u32);
+
+	if (num_ipr % IPR_MAP_WORDS)
+		goto error1;
+	num_ipr /= IPR_MAP_WORDS;
+	if (num_ipr >= NR_IPRMAP0 + NR_IPRMAP1)
+		goto error1;
+
+	/* Allocate map array and fill in unassigned */
+	priv->iprmap[0] = kmalloc_array(NR_IPRMAP0, sizeof(struct ipr), GFP_KERNEL);
+	if (priv->iprmap[0] == NULL)
+		return -ENOMEM;
+	memset(priv->iprmap[0], ~0, NR_IPRMAP0 * sizeof(struct ipr));
+	priv->iprmap[1] = kmalloc_array(NR_IPRMAP1, sizeof(struct ipr), GFP_KERNEL);
+	if (priv->iprmap[1] == NULL) {
+		kfree(priv->iprmap[0]);
+		return -ENOMEM;
+	}
+	memset(priv->iprmap[1], ~0, NR_IPRMAP1 * sizeof(struct ipr));
+
+	p = NULL;
+	for (; num_ipr > 0; num_ipr--) {
+		/* 1st word - INTEVT code */
+		p = of_prop_next_u32(ipr_map, p, &irq);
+		if (!p)
+			goto error;
+		irq = evt2irq(irq);
+		if (!is_valid_irq(irq))
+			goto error;
+		if (irq < GRP1_IRQ_START) {
+			ipr = priv->iprmap[0];
+			irq -= IRQ_START;
+		} else {
+			ipr = priv->iprmap[1];
+			irq -= GRP1_IRQ_START;
+		}
+		ipr += irq;
+		/* 2nd word - IPR register offset */
+		p = of_prop_next_u32(ipr_map, p, &ipr->off);
+		/* 3rd word - IPR register bit indx */
+		p = of_prop_next_u32(ipr_map, p, &ipr->idx);
+
+		if ((ipr->off != INTPRI00 && ipr->off > IPRD) ||
+		    ipr->idx > IPR_B12)
+			goto error;
+	}
+
+	for (ipr = priv->iprmap[0], i = 0; i < NR_IPRMAP0; ipr++, i++) {
+		if (ipr->off != ~0) {
+			pr_debug("INTEVT=%04x (%u) reg=IPR%c idx=%u\n",
+				 irq2evt(i + IRQ_START), i + IRQ_START,
+				 'A' + ipr->off / 4, ipr->idx);
+		}
+	}
+	for (ipr = priv->iprmap[1], i = 0; i < NR_IPRMAP1; ipr++, i++) {
+		if (ipr->off != ~0) {
+			pr_debug("INTEVT=%04x (%u) reg=INTPRI00 idx=%u\n",
+				 irq2evt(i + GRP1_IRQ_START), i + GRP1_IRQ_START,
+				 ipr->idx);
+		}
+	}
+	return 0;
+error:
+	kfree(priv->iprmap[0]);
+	kfree(priv->iprmap[1]);
+error1:
+	pr_err("%pOFP: Failed to load renesas,ipr-map\n", intc);
+	return -EINVAL;
+}
+
+static int __init sh7751_intc_of_init(struct device_node *intc,
+				      struct device_node *parent)
+{
+	struct sh7751_intc_priv *priv;
+	void __iomem *base, *base2;
+	struct irq_domain *domain;
+	u16 icr;
+	int ret;
+
+	priv = kzalloc(sizeof(struct sh7751_intc_priv), GFP_KERNEL);
+	if (priv == NULL)
+		return -ENOMEM;
+
+	base = of_iomap(intc, 0);
+	base2 = of_iomap(intc, 1);
+	if (!base || !base2) {
+		pr_err("%pOFP: Invalid register definition\n", intc);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = load_ipr_map(intc, priv);
+	if (ret < 0)
+		goto error;
+
+	priv->base = base;
+	priv->intpri00 = base2;
+
+	if (of_property_read_bool(intc, "renesas,irlm")) {
+		priv->irlm = true;
+		icr = __raw_readw(priv->base + R_ICR);
+		icr |= ICR_IRLM;
+		__raw_writew(icr, priv->base + R_ICR);
+	}
+
+	domain = irq_domain_add_linear(intc, NR_IRQS, &irq_ops, priv);
+	if (domain == NULL) {
+		pr_err("%pOFP: cannot initialize irq domain\n", intc);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	irq_set_default_host(domain);
+	pr_info("%pOFP: SH7751 Interrupt controller (%s external IRQ)",
+		intc, priv->irlm ? "4 lines" : "15 level");
+	return 0;
+
+error:
+	if (base)
+		iounmap(base);
+	if (base2)
+		iounmap(base);
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(sh_7751_intc, "renesas,sh7751-intc", sh7751_intc_of_init);
-- 
2.39.2


