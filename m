Return-Path: <linux-pci+bounces-1874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AB082807D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 09:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CFC281849
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 08:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1B1F601;
	Tue,  9 Jan 2024 08:23:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B947D22063;
	Tue,  9 Jan 2024 08:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 3009D1C0572;
	Tue,  9 Jan 2024 17:23:48 +0900 (JST)
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
Subject: [DO NOT MERGE v6 05/37] sh: GENERIC_IRQ_CHIP support for CONFIG_OF=y
Date: Tue,  9 Jan 2024 17:23:02 +0900
Message-Id: <4d01ae9b3c5881b79095e6d98e1bdf8a008e2658.1704788539.git.ysato@users.sourceforge.jp>
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

Remove unused function prototype.
Add helper update_sr_imask. use for SH7751 irq driver.
Add stub intc_finalize.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/include/asm/io.h       |  2 ++
 arch/sh/include/asm/irq.h      | 10 ++++++++--
 arch/sh/kernel/cpu/Makefile    |  5 +----
 arch/sh/kernel/cpu/irq/imask.c | 17 +++++++++++++++++
 include/linux/sh_intc.h        |  7 ++++++-
 5 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index ac521f287fa5..5429b4169dc8 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -121,7 +121,9 @@ __BUILD_MEMORY_STRING(__raw_, q, u64)
 
 #define ioport_map ioport_map
 #define ioport_unmap ioport_unmap
+#ifndef CONFIG_SH_DEVICE_TREE
 #define pci_iounmap pci_iounmap
+#endif
 
 #define ioread8 ioread8
 #define ioread16 ioread16
diff --git a/arch/sh/include/asm/irq.h b/arch/sh/include/asm/irq.h
index 0f384b1f45ca..3d897229dcc4 100644
--- a/arch/sh/include/asm/irq.h
+++ b/arch/sh/include/asm/irq.h
@@ -16,8 +16,8 @@
 /*
  * Simple Mask Register Support
  */
-extern void make_maskreg_irq(unsigned int irq);
-extern unsigned short *irq_mask_register;
+
+void update_sr_imask(unsigned int irq, bool enable);
 
 /*
  * PINT IRQs
@@ -54,4 +54,10 @@ extern void irq_finish(unsigned int irq);
 
 #include <asm-generic/irq.h>
 
+/* SH3/4 INTC stuff */
+/* IRL level 0 - 15 */
+#define NR_IRL 15
+/* IRL0 -> IRQ16 */
+#define IRL_BASE_IRQ	16
+
 #endif /* __ASM_SH_IRQ_H */
diff --git a/arch/sh/kernel/cpu/Makefile b/arch/sh/kernel/cpu/Makefile
index e00ebf134985..ad12807fae9c 100644
--- a/arch/sh/kernel/cpu/Makefile
+++ b/arch/sh/kernel/cpu/Makefile
@@ -20,7 +20,4 @@ ifndef CONFIG_COMMON_CLK
 obj-y += clock.o
 obj-$(CONFIG_SH_CLK_CPG_LEGACY)	+= clock-cpg.o
 endif
-ifndef CONFIG_GENERIC_IRQ_CHIP
-obj-y	+= irq/
-endif
-obj-y	+= init.o fpu.o pfc.o proc.o
+obj-y	+= init.o fpu.o pfc.o proc.o irq/
diff --git a/arch/sh/kernel/cpu/irq/imask.c b/arch/sh/kernel/cpu/irq/imask.c
index 572585c3f2fd..7589ca7c506c 100644
--- a/arch/sh/kernel/cpu/irq/imask.c
+++ b/arch/sh/kernel/cpu/irq/imask.c
@@ -51,6 +51,7 @@ static inline void set_interrupt_registers(int ip)
 		     : "t");
 }
 
+#ifndef CONFIG_GENERIC_IRQ_CHIP
 static void mask_imask_irq(struct irq_data *data)
 {
 	unsigned int irq = data->irq;
@@ -83,3 +84,19 @@ void make_imask_irq(unsigned int irq)
 	irq_set_chip_and_handler_name(irq, &imask_irq_chip, handle_level_irq,
 				      "level");
 }
+#else
+void update_sr_imask(unsigned int irq, bool enable)
+{
+	if (enable) {
+		set_bit(irq, imask_mask);
+		interrupt_priority = IMASK_PRIORITY -
+		  find_first_bit(imask_mask, IMASK_PRIORITY);
+	} else {
+		clear_bit(irq, imask_mask);
+		if (interrupt_priority < IMASK_PRIORITY - irq)
+			interrupt_priority = IMASK_PRIORITY - irq;
+	}
+	set_interrupt_registers(interrupt_priority);
+}
+EXPORT_SYMBOL(update_sr_imask);
+#endif
diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index 27ae79191bdc..994b5b05a0d7 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -139,8 +139,13 @@ struct intc_desc symbol __initdata = {					\
 int register_intc_controller(struct intc_desc *desc);
 int intc_set_priority(unsigned int irq, unsigned int prio);
 int intc_irq_lookup(const char *chipname, intc_enum enum_id);
+#ifndef CONFIG_SH_DEVICE_TREE
 void intc_finalize(void);
-
+#else
+static inline void intc_finalize(void)
+{
+}
+#endif
 #ifdef CONFIG_INTC_USERIMASK
 int register_intc_userimask(unsigned long addr);
 #else
-- 
2.39.2


