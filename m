Return-Path: <linux-pci+bounces-5660-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1542B897ECF
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05B728AB39
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CEC70CCB;
	Thu,  4 Apr 2024 05:01:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1356E6EB73;
	Thu,  4 Apr 2024 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206873; cv=none; b=BoVDBE80kxDO27RzY3Og+fNWN0TOwRdhaXIYiMduRKG0gRaFi4VZE2WWF+coCYmycd2o0MgLfUycIrm6vh2X5jch4N0mv7YgKoZrZcv7cQaiDY4FR3JsZS88HbRRt1YisyIBcs9Nktc24r9GUuMpEGX4u9buWNkCCRt0Fbp8BvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206873; c=relaxed/simple;
	bh=UJW1y/CNqaXMUaqUfQ32jgB+zVWcGE7dF8voaeMrWZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cUzngTiiOlVXpu9HtpKgSWZtjZXPn7sWFAGtYvlh2zIgTRY1NygGC/V06cr7RIzXL58JYs/RMUZmCTJJZO9X76ysZJ8QPTK9PuLPiHM+G3gEf1KlTiIuvtp0itTsWe1OpFHwNKTi1gIgowPNNfTEIlHLPlrBNgzZqn5OcKuRUw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 22AC81C089C;
	Thu,  4 Apr 2024 14:01:09 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lee Jones <lee@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	David Rientjes <rientjes@google.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Guo Ren <guoren@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
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
Subject: [PATCH v7 18/37] irqchip: SH7751 external interrupt encoder with enable gate.
Date: Thu,  4 Apr 2024 13:59:53 +0900
Message-Id: <b6473e6551868b32201d5d405a4f850158d614a3.1712205900.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712205900.git.ysato@users.sourceforge.jp>
References: <cover.1712205900.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SH7751 have 15 level external interrupt.
It is typically connected to the CPU through a priority encoder
that can suppress requests.
This driver provides a way to control those hardware with irqchip.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/irqchip/Kconfig                 |   7 +
 drivers/irqchip/Makefile                |   2 +
 drivers/irqchip/irq-renesas-sh7751irl.c | 221 ++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/irqchip/irq-renesas-sh7751irl.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 33badb5b4f00..7670fcd6757d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -698,4 +698,11 @@ config RENESAS_SH7751_INTC
 	  Support for the Renesas SH7751 On-chip interrupt controller.
 	  And external interrupt encoder for some targets.
 
+config RENESAS_SH7751IRL_INTC
+	bool "Renesas SH7751 based target IRL encoder support."
+	depends on RENESAS_SH7751_INTC
+	help
+	  Support for External Interrupt encoder
+	  on the some Renesas SH7751 based target.
+
 endmenu
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 51855034a895..bc21d65441f2 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -122,3 +122,5 @@ obj-$(CONFIG_APPLE_AIC)			+= irq-apple-aic.o
 obj-$(CONFIG_MCHP_EIC)			+= irq-mchp-eic.o
 obj-$(CONFIG_SUNPLUS_SP7021_INTC)	+= irq-sp7021-intc.o
 obj-$(CONFIG_RENESAS_SH7751_INTC)	+= irq-renesas-sh7751.o
+obj-$(CONFIG_RENESAS_SH7751IRL_INTC)	+= irq-renesas-sh7751irl.o
+
diff --git a/drivers/irqchip/irq-renesas-sh7751irl.c b/drivers/irqchip/irq-renesas-sh7751irl.c
new file mode 100644
index 000000000000..5990f2cd9a3d
--- /dev/null
+++ b/drivers/irqchip/irq-renesas-sh7751irl.c
@@ -0,0 +1,221 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SH7751 based board external interrupt level encoder driver
+ * (Renesas RTS7751R2D / IO DATA DEVICE LANDISK, USL-5P)
+ *
+ * Copyright (C) 2023 Yoshinori Sato
+ */
+
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irqdomain.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+
+struct sh7751irl_intc_priv {
+	struct irq_domain *irq_domain;
+	void __iomem	  *base;
+	unsigned int	  width;
+	bool		  invert;
+	u32		  enable_bit[NR_IRL];
+};
+
+static inline unsigned long get_reg(void __iomem *addr, unsigned int w)
+{
+	switch (w) {
+	case 8:
+		return __raw_readb(addr);
+	case 16:
+		return __raw_readw(addr);
+	case 32:
+		return __raw_readl(addr);
+	default:
+		/* The size is checked when reading the properties. */
+		pr_err("%s: Invalid width %d", __FILE__, w);
+		return 0;
+	}
+}
+
+static inline void set_reg(void __iomem *addr, unsigned int w, unsigned long val)
+{
+	switch (w) {
+	case 8:
+		__raw_writeb(val, addr);
+		break;
+	case 16:
+		__raw_writew(val, addr);
+		break;
+	case 32:
+		__raw_writel(val, addr);
+		break;
+	default:
+		pr_err("%s: Invalid width %d", __FILE__, w);
+	}
+}
+
+static inline struct sh7751irl_intc_priv *irq_data_to_priv(struct irq_data *data)
+{
+	return data->domain->host_data;
+}
+
+static void irl_endisable(struct irq_data *data, unsigned int enable)
+{
+	struct sh7751irl_intc_priv *priv;
+	unsigned long val;
+	unsigned int irl;
+
+	priv = irq_data_to_priv(data);
+	irl = irqd_to_hwirq(data) - IRL_BASE_IRQ;
+
+	if (irl < NR_IRL && priv->enable_bit[irl] < priv->width) {
+		if (priv->invert)
+			enable = !enable;
+
+		val = get_reg(priv->base, priv->width);
+		if (enable)
+			set_bit(priv->enable_bit[irl], &val);
+		else
+			clear_bit(priv->enable_bit[irl], &val);
+		set_reg(priv->base, priv->width, val);
+	} else {
+		pr_err("%s: Invalid register define in IRL %u", __FILE__, irl);
+	}
+}
+
+static void sh7751irl_intc_disable_irq(struct irq_data *data)
+{
+	irl_endisable(data, 0);
+}
+
+static void sh7751irl_intc_enable_irq(struct irq_data *data)
+{
+	irl_endisable(data, 1);
+}
+
+static struct irq_chip sh7751irl_intc_chip = {
+	.name		= "SH7751IRL-INTC",
+	.irq_enable	= sh7751irl_intc_enable_irq,
+	.irq_disable	= sh7751irl_intc_disable_irq,
+};
+
+static int sh7751irl_intc_map(struct irq_domain *h, unsigned int virq,
+			       irq_hw_number_t hw_irq_num)
+{
+	irq_set_chip_and_handler(virq, &sh7751irl_intc_chip, handle_level_irq);
+	irq_get_irq_data(virq)->chip_data = h->host_data;
+	irq_modify_status(virq, IRQ_NOREQUEST, IRQ_NOPROBE);
+	return 0;
+}
+
+static int sh7751irl_intc_translate(struct irq_domain *domain,
+			       struct irq_fwspec *fwspec, unsigned long *hwirq,
+			       unsigned int *type)
+{
+	if (fwspec->param[0] > NR_IRL)
+		return -EINVAL;
+
+	switch (fwspec->param_count) {
+	case 2:
+		*type = fwspec->param[1];
+		fallthrough;
+	case 1:
+		*hwirq = fwspec->param[0] + IRL_BASE_IRQ;
+		break;
+	default:
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static const struct irq_domain_ops sh7751irl_intc_domain_ops = {
+	.map = sh7751irl_intc_map,
+	.translate = sh7751irl_intc_translate,
+};
+
+static int __init load_irl_bit(struct device_node *node, struct sh7751irl_intc_priv *priv)
+{
+	struct property *enable_map;
+	const __be32 *p;
+	u32 nr_bits, bit;
+	u32 irl;
+	int ret;
+
+	/* Fill in unused */
+	memset(priv->enable_bit, ~0, sizeof(priv->enable_bit));
+
+	enable_map = of_find_property(node, "renesas,enable-reg", &nr_bits);
+	if (IS_ERR(enable_map))
+		return PTR_ERR(enable_map);
+
+	nr_bits /= sizeof(u32);
+	if (nr_bits > priv->width)
+		return -EINVAL;
+
+	ret = nr_bits;
+	p = NULL;
+	for (bit = nr_bits; bit > 0; bit--) {
+		p = of_prop_next_u32(enable_map, p, &irl);
+		if (p == NULL || irl > NR_IRL)
+			return -EINVAL;
+		if (irl == NR_IRL)
+			/* IRL15 is unassined bit */
+			continue;
+		priv->enable_bit[irl] = bit - 1;
+	}
+	return ret;
+}
+
+static int __init sh7751irl_init(struct device_node *node, struct device_node *parent)
+{
+	struct sh7751irl_intc_priv *priv;
+	struct resource res;
+	struct irq_domain *d;
+	void __iomem *base;
+	int ret = 0;
+
+	if (of_address_to_resource(node, 0, &res))
+		return -EINVAL;
+	if (resource_size(&res) > 4)
+		return -EINVAL;
+
+	base = ioremap(res.start, resource_size(&res));
+	if (!base)
+		return -EINVAL;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = base;
+	priv->width = 8 << resource_size(&res);
+
+	ret = load_irl_bit(node, priv);
+	if (ret < 0) {
+		pr_err("%pOFP: Invalid register define.\n", node);
+		goto error;
+	}
+
+	d = irq_domain_add_tree(node, &sh7751irl_intc_domain_ops, priv);
+	if (d == NULL) {
+		pr_err("%pOFP: cannot initialize irq domain\n", node);
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	priv->irq_domain = d;
+	irq_domain_update_bus_token(d, DOMAIN_BUS_WIRED);
+	pr_info("%pOFP: SH7751 External Interrupt encoder (input=%d)", node, ret);
+	return 0;
+error:
+	kfree(priv);
+	return ret;
+}
+
+IRQCHIP_DECLARE(renesas_sh7751_irl, "renesas,sh7751-irl-ext", sh7751irl_init);
-- 
2.39.2


