Return-Path: <linux-pci+bounces-5691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC3389805D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08991C25D42
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28C21272A3;
	Thu,  4 Apr 2024 05:15:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D87C8662A;
	Thu,  4 Apr 2024 05:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712207734; cv=none; b=FotAleyCsQ7j5yiix5VQBxAdkpkfCQ20YDJFmyh7pYfyDetsZpsCmFhei0YrvyfgHgNm1ixYcL0WGLPm3bO/PtA0mIp3IHPZqZZZsgnba0T2O6dB33a4n/3T6OOoeZ4QTtjL0R8sS7j+q86mw1X21wQKgZ1XdiMiIvKSE/fDlX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712207734; c=relaxed/simple;
	bh=/SVwW82/qqoafDX5rrWInlnHjQYhzm2Ysf1xX40RPDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p/kGHjN/8D0Ra1ZstV6hBOD6ZPLUFlrjVP1Xd8h9TDR5IS1BQJlcV7mMvLWQvcBiDdY/eVkAtBBjXBYJuaW4qVWuvAQjAZaOl9m2mWJ3PO9UntLtEmbCGOfdD615askx/KN8Dh7y/bhEauO2+7OKGN8/ayJjOt9Bzo/cwhNI40w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id A1CCF1C0FFA;
	Thu,  4 Apr 2024 14:15:30 +0900 (JST)
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
Subject: [RESEND v7 20/37] serial: sh-sci: fix SH4 OF support.
Date: Thu,  4 Apr 2024 14:14:31 +0900
Message-Id: <38f5834918e7e9dff023e8db970bc3c0160583ec.1712207606.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1712207606.git.ysato@users.sourceforge.jp>
References: <cover.1712207606.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- fix earlycon name.
- fix earlyprintk hung (NULL pointer reference).
- fix SERIAL_SH_SCI_EARLYCON enablement

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/Kconfig  | 2 +-
 drivers/tty/serial/sh-sci.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index ffcf4882b25f..dfe5fd436816 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -661,7 +661,7 @@ config SERIAL_SH_SCI_EARLYCON
 	depends on SERIAL_SH_SCI=y
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
-	default ARCH_RENESAS
+	default ARCH_RENESAS || SUPERH
 
 config SERIAL_SH_SCI_DMA
 	bool "DMA support" if EXPERT
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e512eaa57ed5..46466fb5a637 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2717,7 +2717,7 @@ static int sci_remap_port(struct uart_port *port)
 	if (port->membase)
 		return 0;
 
-	if (port->dev->of_node || (port->flags & UPF_IOREMAP)) {
+	if ((port->dev && port->dev->of_node) || (port->flags & UPF_IOREMAP)) {
 		port->membase = ioremap(port->mapbase, sport->reg_size);
 		if (unlikely(!port->membase)) {
 			dev_err(port->dev, "can't remap port#%d\n", port->line);
@@ -3545,8 +3545,8 @@ static int __init hscif_early_console_setup(struct earlycon_device *device,
 
 OF_EARLYCON_DECLARE(sci, "renesas,sci", sci_early_console_setup);
 OF_EARLYCON_DECLARE(scif, "renesas,scif", scif_early_console_setup);
-OF_EARLYCON_DECLARE(scif, "renesas,scif-r7s9210", rzscifa_early_console_setup);
-OF_EARLYCON_DECLARE(scif, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(rzscifa, "renesas,scif-r7s9210", rzscifa_early_console_setup);
+OF_EARLYCON_DECLARE(rzscifa, "renesas,scif-r9a07g044", rzscifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifa, "renesas,scifa", scifa_early_console_setup);
 OF_EARLYCON_DECLARE(scifb, "renesas,scifb", scifb_early_console_setup);
 OF_EARLYCON_DECLARE(hscif, "renesas,hscif", hscif_early_console_setup);
-- 
2.39.2


