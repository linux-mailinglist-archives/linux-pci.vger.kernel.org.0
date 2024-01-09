Return-Path: <linux-pci+bounces-1877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5A8280C1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C7F284506
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731892EB00;
	Tue,  9 Jan 2024 08:23:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D5B2D60F;
	Tue,  9 Jan 2024 08:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 946F31C05E5;
	Tue,  9 Jan 2024 17:23:53 +0900 (JST)
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
Subject: [DO NOT MERGE v6 08/37] clocksource: sh_tmu: CLOCKSOURCE support.
Date: Tue,  9 Jan 2024 17:23:05 +0900
Message-Id: <f7a504fc42486f4f3f75ca7ac8cd57c084407da0.1704788539.git.ysato@users.sourceforge.jp>
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

Allows initialization as CLOCKSOURCE.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/clocksource/sh_tmu.c | 161 +++++++++++++++++++++++------------
 1 file changed, 106 insertions(+), 55 deletions(-)

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index beffff81c00f..e4ae83c9f7d4 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -17,6 +17,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -65,6 +67,7 @@ struct sh_tmu_device {
 
 	bool has_clockevent;
 	bool has_clocksource;
+	const char *name;
 };
 
 #define TSTR -1 /* shared register */
@@ -148,8 +151,8 @@ static int __sh_tmu_enable(struct sh_tmu_channel *ch)
 	/* enable clock */
 	ret = clk_enable(ch->tmu->clk);
 	if (ret) {
-		dev_err(&ch->tmu->pdev->dev, "ch%u: cannot enable clock\n",
-			ch->index);
+		pr_err("%s ch%u: cannot enable clock\n",
+		       ch->tmu->name, ch->index);
 		return ret;
 	}
 
@@ -174,9 +177,10 @@ static int sh_tmu_enable(struct sh_tmu_channel *ch)
 	if (ch->enable_count++ > 0)
 		return 0;
 
-	pm_runtime_get_sync(&ch->tmu->pdev->dev);
-	dev_pm_syscore_device(&ch->tmu->pdev->dev, true);
-
+	if (ch->tmu->pdev) {
+		pm_runtime_get_sync(&ch->tmu->pdev->dev);
+		dev_pm_syscore_device(&ch->tmu->pdev->dev, true);
+	}
 	return __sh_tmu_enable(ch);
 }
 
@@ -202,8 +206,10 @@ static void sh_tmu_disable(struct sh_tmu_channel *ch)
 
 	__sh_tmu_disable(ch);
 
-	dev_pm_syscore_device(&ch->tmu->pdev->dev, false);
-	pm_runtime_put(&ch->tmu->pdev->dev);
+	if (ch->tmu->pdev) {
+		dev_pm_syscore_device(&ch->tmu->pdev->dev, false);
+		pm_runtime_put(&ch->tmu->pdev->dev);
+	}
 }
 
 static void sh_tmu_set_next(struct sh_tmu_channel *ch, unsigned long delta,
@@ -245,7 +251,7 @@ static irqreturn_t sh_tmu_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct sh_tmu_channel *cs_to_sh_tmu(struct clocksource *cs)
+static inline struct sh_tmu_channel *cs_to_sh_tmu(struct clocksource *cs)
 {
 	return container_of(cs, struct sh_tmu_channel, cs);
 }
@@ -292,7 +298,8 @@ static void sh_tmu_clocksource_suspend(struct clocksource *cs)
 
 	if (--ch->enable_count == 0) {
 		__sh_tmu_disable(ch);
-		dev_pm_genpd_suspend(&ch->tmu->pdev->dev);
+		if (ch->tmu->pdev)
+			dev_pm_genpd_suspend(&ch->tmu->pdev->dev);
 	}
 }
 
@@ -304,7 +311,8 @@ static void sh_tmu_clocksource_resume(struct clocksource *cs)
 		return;
 
 	if (ch->enable_count++ == 0) {
-		dev_pm_genpd_resume(&ch->tmu->pdev->dev);
+		if (ch->tmu->pdev)
+			dev_pm_genpd_resume(&ch->tmu->pdev->dev);
 		__sh_tmu_enable(ch);
 	}
 }
@@ -324,14 +332,14 @@ static int sh_tmu_register_clocksource(struct sh_tmu_channel *ch,
 	cs->mask = CLOCKSOURCE_MASK(32);
 	cs->flags = CLOCK_SOURCE_IS_CONTINUOUS;
 
-	dev_info(&ch->tmu->pdev->dev, "ch%u: used as clock source\n",
-		 ch->index);
+	pr_info("%s ch%u: used as clock source\n",
+		ch->tmu->name, ch->index);
 
 	clocksource_register_hz(cs, ch->tmu->rate);
 	return 0;
 }
 
-static struct sh_tmu_channel *ced_to_sh_tmu(struct clock_event_device *ced)
+static inline struct sh_tmu_channel *ced_to_sh_tmu(struct clock_event_device *ced)
 {
 	return container_of(ced, struct sh_tmu_channel, ced);
 }
@@ -364,8 +372,8 @@ static int sh_tmu_clock_event_set_state(struct clock_event_device *ced,
 	if (clockevent_state_oneshot(ced) || clockevent_state_periodic(ced))
 		sh_tmu_disable(ch);
 
-	dev_info(&ch->tmu->pdev->dev, "ch%u: used for %s clock events\n",
-		 ch->index, periodic ? "periodic" : "oneshot");
+	pr_info("%s ch%u: used for %s clock events\n",
+		ch->tmu->name, ch->index, periodic ? "periodic" : "oneshot");
 	sh_tmu_clock_event_start(ch, periodic);
 	return 0;
 }
@@ -403,7 +411,8 @@ static void sh_tmu_clock_event_resume(struct clock_event_device *ced)
 }
 
 static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
-				       const char *name)
+				       const char *name,
+				       struct device_node *np)
 {
 	struct clock_event_device *ced = &ch->ced;
 	int ret;
@@ -417,30 +426,32 @@ static void sh_tmu_register_clockevent(struct sh_tmu_channel *ch,
 	ced->set_state_shutdown = sh_tmu_clock_event_shutdown;
 	ced->set_state_periodic = sh_tmu_clock_event_set_periodic;
 	ced->set_state_oneshot = sh_tmu_clock_event_set_oneshot;
-	ced->suspend = sh_tmu_clock_event_suspend;
-	ced->resume = sh_tmu_clock_event_resume;
-
-	dev_info(&ch->tmu->pdev->dev, "ch%u: used for clock events\n",
-		 ch->index);
+	if (ch->tmu->pdev) {
+		ced->suspend = sh_tmu_clock_event_suspend;
+		ced->resume = sh_tmu_clock_event_resume;
+	}
+	pr_info("%s ch%u: used for clock events\n",
+		ch->tmu->name, ch->index);
 
 	clockevents_config_and_register(ced, ch->tmu->rate, 0x300, 0xffffffff);
 
 	ret = request_irq(ch->irq, sh_tmu_interrupt,
 			  IRQF_TIMER | IRQF_IRQPOLL | IRQF_NOBALANCING,
-			  dev_name(&ch->tmu->pdev->dev), ch);
+			  ch->tmu->name, ch);
 	if (ret) {
-		dev_err(&ch->tmu->pdev->dev, "ch%u: failed to request irq %d\n",
-			ch->index, ch->irq);
+		pr_err("%s ch%u: failed to request irq %d\n",
+		       ch->tmu->name, ch->index, ch->irq);
 		return;
 	}
 }
 
 static int sh_tmu_register(struct sh_tmu_channel *ch, const char *name,
+			   struct device_node *np,
 			   bool clockevent, bool clocksource)
 {
 	if (clockevent) {
 		ch->tmu->has_clockevent = true;
-		sh_tmu_register_clockevent(ch, name);
+		sh_tmu_register_clockevent(ch, name, np);
 	} else if (clocksource) {
 		ch->tmu->has_clocksource = true;
 		sh_tmu_register_clocksource(ch, name);
@@ -451,7 +462,8 @@ static int sh_tmu_register(struct sh_tmu_channel *ch, const char *name,
 
 static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 				bool clockevent, bool clocksource,
-				struct sh_tmu_device *tmu)
+				struct sh_tmu_device *tmu,
+				struct device_node *np)
 {
 	/* Skip unused channels. */
 	if (!clockevent && !clocksource)
@@ -465,53 +477,59 @@ static int sh_tmu_channel_setup(struct sh_tmu_channel *ch, unsigned int index,
 	else
 		ch->base = tmu->mapbase + 8 + ch->index * 12;
 
-	ch->irq = platform_get_irq(tmu->pdev, index);
+	if (tmu->pdev)
+		ch->irq = platform_get_irq(tmu->pdev, index);
+	else
+		ch->irq = of_irq_get(np, index);
 	if (ch->irq < 0)
 		return ch->irq;
 
 	ch->cs_enabled = false;
 	ch->enable_count = 0;
 
-	return sh_tmu_register(ch, dev_name(&tmu->pdev->dev),
+	return sh_tmu_register(ch, tmu->name, np,
 			       clockevent, clocksource);
 }
 
-static int sh_tmu_map_memory(struct sh_tmu_device *tmu)
+static int sh_tmu_map_memory(struct sh_tmu_device *tmu, struct device_node *np)
 {
 	struct resource *res;
 
-	res = platform_get_resource(tmu->pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&tmu->pdev->dev, "failed to get I/O memory\n");
-		return -ENXIO;
-	}
+	if (tmu->pdev) {
+		res = platform_get_resource(tmu->pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			pr_err("sh_tmu failed to get I/O memory\n");
+			return -ENXIO;
+		}
+
+		tmu->mapbase = ioremap(res->start, resource_size(res));
+	} else
+		tmu->mapbase = of_iomap(np, 0);
 
-	tmu->mapbase = ioremap(res->start, resource_size(res));
 	if (tmu->mapbase == NULL)
 		return -ENXIO;
 
 	return 0;
 }
 
-static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
+static int sh_tmu_parse_dt(struct sh_tmu_device *tmu, struct device_node *np)
 {
-	struct device_node *np = tmu->pdev->dev.of_node;
-
 	tmu->model = SH_TMU;
 	tmu->num_channels = 3;
 
 	of_property_read_u32(np, "#renesas,channels", &tmu->num_channels);
 
 	if (tmu->num_channels != 2 && tmu->num_channels != 3) {
-		dev_err(&tmu->pdev->dev, "invalid number of channels %u\n",
-			tmu->num_channels);
+		pr_err("%s: invalid number of channels %u\n",
+		       tmu->name, tmu->num_channels);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
+static int sh_tmu_setup(struct sh_tmu_device *tmu,
+			struct platform_device *pdev, struct device_node *np)
 {
 	unsigned int i;
 	int ret;
@@ -520,8 +538,13 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 
 	raw_spin_lock_init(&tmu->lock);
 
-	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-		ret = sh_tmu_parse_dt(tmu);
+	if (pdev)
+		tmu->name = dev_name(&pdev->dev);
+	else
+		tmu->name = of_node_full_name(np);
+
+	if (IS_ENABLED(CONFIG_OF) && np) {
+		ret = sh_tmu_parse_dt(tmu, np);
 		if (ret < 0)
 			return ret;
 	} else if (pdev->dev.platform_data) {
@@ -531,14 +554,17 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 		tmu->model = id->driver_data;
 		tmu->num_channels = hweight8(cfg->channels_mask);
 	} else {
-		dev_err(&tmu->pdev->dev, "missing platform data\n");
+		pr_err("%s missing platform data\n", tmu->name);
 		return -ENXIO;
 	}
 
 	/* Get hold of clock. */
-	tmu->clk = clk_get(&tmu->pdev->dev, "fck");
+	if (pdev)
+		tmu->clk = clk_get(&tmu->pdev->dev, "fck");
+	else
+		tmu->clk = of_clk_get(np, 0);
 	if (IS_ERR(tmu->clk)) {
-		dev_err(&tmu->pdev->dev, "cannot get clock\n");
+		pr_err("%s: cannot get clock\n", tmu->name);
 		return PTR_ERR(tmu->clk);
 	}
 
@@ -555,9 +581,9 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	clk_disable(tmu->clk);
 
 	/* Map the memory resource. */
-	ret = sh_tmu_map_memory(tmu);
+	ret = sh_tmu_map_memory(tmu, np);
 	if (ret < 0) {
-		dev_err(&tmu->pdev->dev, "failed to remap I/O memory\n");
+		pr_err("%s: failed to remap I/O memory\n", tmu->name);
 		goto err_clk_unprepare;
 	}
 
@@ -575,12 +601,12 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	 */
 	for (i = 0; i < tmu->num_channels; ++i) {
 		ret = sh_tmu_channel_setup(&tmu->channels[i], i,
-					   i == 0, i == 1, tmu);
+					   i == 0, i == 1, tmu, np);
 		if (ret < 0)
 			goto err_unmap;
 	}
-
-	platform_set_drvdata(pdev, tmu);
+	if (pdev)
+		platform_set_drvdata(pdev, tmu);
 
 	return 0;
 
@@ -594,6 +620,7 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device *pdev)
 	return ret;
 }
 
+#ifndef CONFIG_SH_DEVICE_TREE
 static int sh_tmu_probe(struct platform_device *pdev)
 {
 	struct sh_tmu_device *tmu = platform_get_drvdata(pdev);
@@ -613,7 +640,7 @@ static int sh_tmu_probe(struct platform_device *pdev)
 	if (tmu == NULL)
 		return -ENOMEM;
 
-	ret = sh_tmu_setup(tmu, pdev);
+	ret = sh_tmu_setup(tmu, pdev, pdev->dev.of_node);
 	if (ret) {
 		kfree(tmu);
 		pm_runtime_idle(&pdev->dev);
@@ -631,7 +658,26 @@ static int sh_tmu_probe(struct platform_device *pdev)
 
 	return 0;
 }
+#else
+static int __init sh_tmu_of_register(struct device_node *np)
+{
+	struct sh_tmu_device *tmu;
+	int ret;
+
+	tmu = kzalloc(sizeof(*tmu), GFP_KERNEL);
+	if (tmu == NULL)
+		return -ENOMEM;
+
+	ret = sh_tmu_setup(tmu, NULL, np);
+	if (ret) {
+		kfree(tmu);
+		pr_warn("%pOF: Timer register failed (%d)", np, ret);
+	}
+	return ret;
+}
+#endif
 
+#ifndef CONFIG_SH_DEVICE_TREE
 static const struct platform_device_id sh_tmu_id_table[] = {
 	{ "sh-tmu", SH_TMU },
 	{ "sh-tmu-sh3", SH_TMU_SH3 },
@@ -665,12 +711,17 @@ static void __exit sh_tmu_exit(void)
 	platform_driver_unregister(&sh_tmu_device_driver);
 }
 
+subsys_initcall(sh_tmu_init);
+module_exit(sh_tmu_exit);
+#endif
+
 #ifdef CONFIG_SUPERH
+#ifdef CONFIG_SH_DEVICE_TREE
+TIMER_OF_DECLARE(sh_tmu, "renesas,tmu", sh_tmu_of_register);
+#else
 sh_early_platform_init("earlytimer", &sh_tmu_device_driver);
 #endif
-
-subsys_initcall(sh_tmu_init);
-module_exit(sh_tmu_exit);
+#endif
 
 MODULE_AUTHOR("Magnus Damm");
 MODULE_DESCRIPTION("SuperH TMU Timer Driver");
-- 
2.39.2


