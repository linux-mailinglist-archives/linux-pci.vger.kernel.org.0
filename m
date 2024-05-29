Return-Path: <linux-pci+bounces-7977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBA8D2FE3
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 10:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB87F28BC17
	for <lists+linux-pci@lfdr.de>; Wed, 29 May 2024 08:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCAF181302;
	Wed, 29 May 2024 08:02:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B937180A8A;
	Wed, 29 May 2024 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716969734; cv=none; b=I6ee1/2Fjippu7I0X27csybvWL6zQ+wsj4pwHym65VJ98lEmTHI4L7DalCN96PCqNsOScawVf1gDrF6myb2X68YDclX72r+KGQT0Br6QYQMI555yPEthqQ9LOZnAT/cBACPbtCz95WLuxQtNShnRzBlYNZD2NvGAMN15g7HrUCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716969734; c=relaxed/simple;
	bh=rXJ3FIMjhLIJCYj9qzJ/Vj+aCVUa/aALbLHc5PmBo14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h/H+dQJ24UJc2l1Hp+hsrloOUUfJg/nLG+sNtjwWUC7APv1j0aS8MluKow3UXaPX6sA85wLYHAfn6k4P6sZZVoyGlF4RSzuPPzuz6lno4SXeawYgQvFYMf4//KYX9yOJk3xDkcmWkAH8gdv5DvKKprNWi88jkTU2L7UpI7GEfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id 7DFDE1C0FD1;
	Wed, 29 May 2024 17:02:09 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Neil Armstrong <neil.armstrong@linaro.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sam Ravnborg <sam@ravnborg.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
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
Subject: [DO NOT MERGE v8 23/36] mfd: sm501: Convert platform_data to OF property
Date: Wed, 29 May 2024 17:01:09 +0900
Message-Id: <c139d3a42c61d978296aa2e513de073c643e4fbe.1716965617.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1716965617.git.ysato@users.sourceforge.jp>
References: <cover.1716965617.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various parameters of SM501 can be set using platform_data,
so parameters cannot be passed in the DeviceTree target.
Expands the parameters set in platform_data so that they can be
specified using DeviceTree properties.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 drivers/mfd/sm501.c           | 238 ++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/sm501fb.c |  87 +++++++++++++
 2 files changed, 325 insertions(+)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index b3592982a83b..d373aded0c3b 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -20,6 +20,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/gpio/machine.h>
 #include <linux/slab.h>
+#include <linux/clk.h>
 
 #include <linux/sm501.h>
 #include <linux/sm501-regs.h>
@@ -82,6 +83,16 @@ struct sm501_devdata {
 	unsigned int			 rev;
 };
 
+struct sm501_config_props_uint {
+	char *name;
+	u32 shift;
+};
+
+struct sm501_config_props_flag {
+	char *clr_name;
+	char *set_name;
+	u32 bit;
+};
 
 #define MHZ (1000 * 1000)
 
@@ -1370,6 +1381,227 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 	return 0;
 }
 
+#define FIELD_WIDTH 4
+struct dt_values {
+	char *name;
+	unsigned int offset;
+	unsigned int width;
+	char *val[(1 << FIELD_WIDTH) + 1];
+};
+
+#define fld(_name, _offset, _width, ...)	\
+	{ \
+		.name = _name, \
+		.offset = _offset, \
+		.width = _width,	\
+		.val = { __VA_ARGS__, NULL},	\
+	}
+
+static const struct dt_values misc_timing[] = {
+	fld("ex", 28, 4,
+	    "none", "16", "32", "48", "64", "80", "96", "112",
+	    "128", "144", "160", "176", "192", "208", "224", "240"),
+	fld("xc", 24, 2, "internal-pll", "hclk", "gpio30"),
+	fld("us", 23, 1, "disable", "enable"),
+	fld("ssm1", 20, 1, "288", "divider"),
+	fld("sm1", 16, 4,
+	    "1", "2", "4", "8", "16", "32", "64", "128",
+	    "3", "6", "12", "24", "48", "96", "192", "384"),
+	fld("ssm0", 12, 1, "288", "divider"),
+	fld("sm0", 8, 4,
+	    "1", "2", "4", "8", "16", "32", "64", "128",
+	    "3", "6", "12", "24", "48", "96", "192", "384"),
+	fld("deb", 7, 1, "input-reference", "output"),
+	fld("a", 6, 1, "no-acpi", "acpi"),
+	fld("divider", 4, 2, "336", "288", "240", "192"),
+	fld("u", 3, 1, "normal", "simulation"),
+	fld("delay", 0, 3, "none", "0.5", "1.0", "1.5", "2.0", "2.5"),
+	{ .name = NULL },
+};
+
+static const struct dt_values misc_control[] = {
+	fld("pad", 30, 2, "24", "12", "8"),
+	fld("usbclk", 28, 2, "xtal", "96", "48"),
+	fld("ssp", 27, 1, "uart1", "ssp1"),
+	fld("lat", 26, 1, "disable", "enable"),
+	fld("fp", 25, 1, "18", "24"),
+	fld("freq", 24, 1, "24", "12"),
+	fld("refresh", 21, 2, "8", "16", "32", "64"),
+	fld("hold", 18, 3, "fifo-empty", "8", "16", "24", "32"),
+	fld("sh", 17, 1, "active-low", "active-high"),
+	fld("ii", 16, 1, "normal", "inverted"),
+	fld("pll", 15, 1, "disable", "enable"),
+	fld("gap", 13, 2, "0"),
+	fld("dac", 12, 1, "enable", "disable"),
+	fld("mc", 11, 1, "cpu", "8051"),
+	fld("bl", 10, 8, "1"),
+	fld("usb", 9, 1, "master", "slave"),
+	fld("vr", 4, 1, "0x1e00000", "0x3e00000"),
+	{ .name = NULL },
+};
+
+/* Read configuration values */
+static void sm501_of_read_config(struct device *dev, struct device_node *np,
+				 const char *prefix,
+				 const struct dt_values *values,
+				 struct sm501_reg_init *ret)
+{
+	const char *name;
+	const char *val;
+	unsigned int i;
+	char key[64];
+	u32 shift;
+	u32 width;
+	u32 mask;
+
+	ret->mask = ~0;
+	ret->set = 0;
+
+	while (values->name) {
+		snprintf(key, sizeof(key), "%s-%s", prefix, values->name);
+		name = values->name;
+		shift = values->offset;
+		width = values->width;
+
+		if (of_property_read_string(np, key, &val) == 0) {
+			mask = (1 << width) - 1;
+			mask = ~(mask << shift);
+			ret->mask &= mask;
+			i = 0;
+			while (values->val[i]) {
+				if (strcmp(val, values->val[i]) == 0) {
+					ret->set |= i << shift;
+					break;
+				}
+				i++;
+			}
+		}
+		values++;
+	}
+}
+
+static void sm501_of_read_gpio(struct device *dev, struct device_node *np,
+			       struct sm501_reg_init *hi, struct sm501_reg_init *low)
+{
+	struct device_node *gpio_node;
+	struct property *prop;
+	unsigned int pin_no;
+	const char *s;
+	int mode;
+	u64 mask;
+	u64 set;
+
+	mask = ~0;
+	set = 0;
+	gpio_node = of_get_child_by_name(np, "gpio");
+	if (gpio_node) {
+		for (prop = gpio_node->properties; prop; prop = prop->next) {
+			mode = -1;
+			if (sscanf(prop->name, "pin-%u", &pin_no) == 1) {
+				of_property_read_string(gpio_node, prop->name, &s);
+				if (strcmp(s, "ioport")) {
+					mode = 0;
+				} else if (strcmp(s, "function")) {
+					mode = 1;
+				}
+			}
+			if (mode >= 0) {
+				mask &= ~(1 << pin_no);
+				set |= mode << pin_no;
+			}
+		}
+	}
+	/* Bit48 - 54 is reserved */
+	mask &= ~0x007f000000000000UL;
+	set &= ~0x007f000000000000UL;
+
+	hi->set = set >> 32;
+	low->set = set & 0xffffffff;
+	hi->mask = mask >> 32;
+	low->mask = mask & 0xffffffff;
+}
+
+/* Read device functions */
+static u32 sm501_read_devices(struct device *dev, struct device_node *np)
+{
+	static const char * const funcname[] = {
+		"usb-host", "usb-slave", "ssp0", "ssp1",
+		"uart0", "uart1", "fbaccel", "ac97",
+		"i2s",
+	};
+	struct property *prop;
+	unsigned int i;
+	const char *s;
+	u32 ret = 0;
+
+	of_property_for_each_string(np, "smi,devices", prop, s) {
+		for (i = 0; i < ARRAY_SIZE(funcname); i++) {
+			if (strcmp(s, funcname[i]) == 0) {
+				ret |= 1 << i;
+				goto next;
+			}
+		}
+		dev_warn(dev, "Unknown device function '%s'", s);
+next:
+	}
+	if (!ret)
+		dev_warn(dev, "devices not defined. disable all functions.");
+	return ret;
+}
+
+/* Build platform_data from OF property */
+struct plat_dt {
+	struct sm501_platdata plat;
+	struct sm501_initdata init;
+};
+
+static int mclk_get(struct device_node *np, int index, unsigned long *out)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	*out = clk_get_rate(clk);
+	clk_put(clk);
+	return 0;
+}
+
+static int sm501_parse_dt(struct sm501_devdata *sm, struct device_node *np)
+{
+	struct sm501_platdata *plat;
+	struct plat_dt *dt_p;
+	int ret;
+
+	dt_p = devm_kzalloc(sm->dev, sizeof(*dt_p), GFP_KERNEL);
+	if (!dt_p)
+		return -ENOMEM;
+
+	plat = &dt_p->plat;
+	plat->init = &dt_p->init;
+
+	plat->init->devices = sm501_read_devices(sm->dev, np);
+
+	ret = mclk_get(np, 0, &plat->init->mclk);
+	if (ret && ret != -ENOENT)
+		return ret;
+	ret = mclk_get(np, 0, &plat->init->m1xclk);
+	if (ret && ret != -ENOENT)
+		return ret;
+
+	sm501_of_read_config(sm->dev, np, "misc-timing",
+			     misc_timing, &plat->init->misc_timing);
+	sm501_of_read_config(sm->dev, np, "misc-control",
+			     misc_control, &plat->init->misc_control);
+	if (IS_ENABLED(CONFIG_MFD_SM501_GPIO)) {
+		sm501_of_read_gpio(sm->dev, np,
+				   &plat->init->gpio_high,
+				   &plat->init->gpio_low);
+	}
+	sm->platdata = plat;
+	return 0;
+}
+
 static int sm501_plat_probe(struct platform_device *dev)
 {
 	struct sm501_devdata *sm;
@@ -1406,6 +1638,12 @@ static int sm501_plat_probe(struct platform_device *dev)
 		goto err_res;
 	}
 
+	if (IS_ENABLED(CONFIG_OF) && dev->dev.of_node) {
+		ret = sm501_parse_dt(sm, dev->dev.of_node);
+		if (ret)
+			goto err_res;
+	}
+
 	platform_set_drvdata(dev, sm);
 
 	sm->regs = ioremap(sm->io_res->start, resource_size(sm->io_res));
diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index d6fdc1737cd2..4162e1322dd4 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -1932,6 +1932,87 @@ static int sm501fb_start_one(struct sm501fb_info *info,
 	return 0;
 }
 
+#if defined(CONFIG_OF)
+static u32 read_display_flags(struct device_node *np)
+{
+	static const char * const name[] = {
+		"use-init-done", "disable-at-exit", "use-hwcursor", "use-hwaccel",
+		"panel-no-fpen", "panel-no-vbiasen", "panel-inv-fpen", "panel-inv-vbiasen",
+	};
+
+	struct property *prop;
+	unsigned int i;
+	const char *s;
+	u32 ret = 0;
+
+	of_property_for_each_string(np, "smi,flags", prop, s) {
+		for (i = 0; i < ARRAY_SIZE(name); i++) {
+			if (strcmp(s, name[i]) == 0) {
+				ret |= 1 << i;
+				break;
+			}
+		}
+	}
+	return ret;
+}
+
+/* parse CRT / panel configuration */
+static struct sm501_platdata_fbsub *dt_fbsub(struct device *dev,
+					     struct device_node *np,
+					     const char *name)
+{
+	struct sm501_platdata_fbsub *fbsub = NULL;
+	struct device_node *child;
+	u32 flags = 0;
+	u32 bpp = 0;
+	int len;
+
+	child = of_get_child_by_name(np, name);
+	if (child == NULL)
+		return NULL;
+
+	of_property_read_u32(child, "bpp", &bpp);
+
+	/* If flags property is obtained, fbsub is returned. */
+	flags = read_display_flags(child);
+	if (flags) {
+		fbsub = devm_kzalloc(dev, sizeof(*fbsub), GFP_KERNEL);
+		if (fbsub) {
+			fbsub->def_bpp = bpp;
+			fbsub->flags = flags;
+		}
+	}
+	return fbsub;
+}
+
+/* Build platform_data from OF property */
+static struct sm501_platdata_fb *pdata_from_dt(struct device *dev, struct device_node *np)
+{
+	enum sm501_fb_routing fb_route = SM501_FB_OWN;
+	struct sm501_platdata_fb *pdata = NULL;
+	struct sm501_platdata_fbsub *fb_crt;
+	struct sm501_platdata_fbsub *fb_pnl;
+	unsigned int flags = 0;
+
+	if (of_property_read_bool(np, "route-crt-panel"))
+		fb_route = SM501_FB_CRT_PANEL;
+	if (of_property_read_bool(np, "swap-fb-endian"))
+		flags = SM501_FBPD_SWAP_FB_ENDIAN;
+	fb_crt = dt_fbsub(dev, np, "crt");
+	fb_pnl = dt_fbsub(dev, np, "panel");
+	if (fb_crt || fb_pnl) {
+		pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+		if (pdata) {
+			pdata->fb_route = fb_route;
+			pdata->flags = flags;
+			pdata->fb_crt = fb_crt;
+			pdata->fb_pnl = fb_pnl;
+		}
+	}
+	return pdata;
+}
+#endif
+
 static int sm501fb_probe(struct platform_device *pdev)
 {
 	struct sm501fb_info *info;
@@ -1974,6 +2055,12 @@ static int sm501fb_probe(struct platform_device *pdev)
 				if (info->edid_data)
 					found = 1;
 			}
+			/* Get platform data compatible configuration */
+			if (!found) {
+				info->pdata = pdata_from_dt(dev, np);
+				if (info->pdata)
+					found = 1;
+			}
 		}
 #endif
 		if (!found) {
-- 
2.39.2


