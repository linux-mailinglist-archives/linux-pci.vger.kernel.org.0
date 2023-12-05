Return-Path: <linux-pci+bounces-453-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F7804EDE
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 10:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB571F2129A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15094D10D;
	Tue,  5 Dec 2023 09:55:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 502A1AA;
	Tue,  5 Dec 2023 01:55:32 -0800 (PST)
Received: from SIOS1075.ysato.name (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by sakura.ysato.name (Postfix) with ESMTPSA id 164F21C04FD;
	Tue,  5 Dec 2023 18:46:13 +0900 (JST)
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
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
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
	Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Baoquan He <bhe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Guo Ren <guoren@kernel.org>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Bin Meng <bmeng@tinylab.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Tom Rix <trix@redhat.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
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
Subject: [DO NOT MERGE v5 06/37] sh: kernel/setup Update DT support.
Date: Tue,  5 Dec 2023 18:45:25 +0900
Message-Id: <76bbd45b22ef6cc1fa69369aff908c9c4e366860.1701768028.git.ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1701768028.git.ysato@users.sourceforge.jp>
References: <cover.1701768028.git.ysato@users.sourceforge.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix extrnal fdt initialize and bootargs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/kernel/setup.c | 51 ++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 3d80515298d2..b299abff68e0 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -30,6 +30,7 @@
 #include <linux/memblock.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
+#include <linux/libfdt.h>
 #include <linux/uaccess.h>
 #include <uapi/linux/mount.h>
 #include <asm/io.h>
@@ -74,7 +75,13 @@ extern int root_mountflags;
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
+#if defined(CONFIG_OF) && !defined(CONFIG_USE_BUILTIN_DTB)
+#define CHOSEN_BOOTARGS
+#endif
+
+#ifndef CHOSEN_BOOTARGS
 static char __initdata command_line[COMMAND_LINE_SIZE] = { 0, };
+#endif
 
 static struct resource code_resource = {
 	.name = "Kernel code",
@@ -244,18 +251,18 @@ void __init __weak plat_early_device_setup(void)
 void __ref sh_fdt_init(phys_addr_t dt_phys)
 {
 	static int done = 0;
-	void *dt_virt;
+	void *fdt;
 
 	/* Avoid calling an __init function on secondary cpus. */
 	if (done) return;
 
 #ifdef CONFIG_USE_BUILTIN_DTB
-	dt_virt = __dtb_start;
+	fdt = __dtb_start;
 #else
-	dt_virt = phys_to_virt(dt_phys);
+	fdt = phys_to_virt(dt_phys);
 #endif
 
-	if (!dt_virt || !early_init_dt_scan(dt_virt)) {
+	if (!fdt || !early_init_dt_scan(fdt)) {
 		pr_crit("Error: invalid device tree blob"
 			" at physical address %p\n", (void *)dt_phys);
 
@@ -269,8 +276,20 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
 void __init setup_arch(char **cmdline_p)
 {
+#ifdef CONFIG_OF_EARLY_FLATTREE
+	if (IS_ENABLED(CONFIG_USE_BUILTIN_DTB)) {
+		/* Relocate Embedded DTB */
+		unflatten_and_copy_device_tree();
+	} else if (initial_boot_params) {
+		/* Reserve external DTB area */
+		memblock_reserve(__pa(initial_boot_params),
+				 fdt_totalsize(initial_boot_params));
+		unflatten_device_tree();
+	}
+#endif
 	enable_mmu();
 
+#ifndef CONFIG_OF
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
 
 	printk(KERN_NOTICE "Boot params:\n"
@@ -299,19 +318,25 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = virt_to_phys(__bss_start);
 	bss_resource.end = virt_to_phys(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_OVERWRITE
-	strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
-#else
+#endif
+
+#ifndef CHOSEN_BOOTARGS
+#ifndef CONFIG_CMDLINE_OVERWRITE
 	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
 #ifdef CONFIG_CMDLINE_EXTEND
 	strlcat(command_line, " ", sizeof(command_line));
 	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));
 #endif
-#endif
-
+#else   /* !CONFIG_CMDLINE_OVERWRITE*/
+	strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
+#endif  /* CONFIG_CMDLINE_OVERWRITE */
 	/* Save unparsed command line copy for /proc/cmdline */
 	memcpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
+#else	/* CHOSEN_BOOTARGS */
+	/* Use "/chosen/bootargs" specified in devicetree. */
+	*cmdline_p = boot_command_line;
+#endif
 
 	parse_early_param();
 
@@ -322,14 +347,6 @@ void __init setup_arch(char **cmdline_p)
 	/* Let earlyprintk output early console messages */
 	sh_early_platform_driver_probe("earlyprintk", 1, 1);
 
-#ifdef CONFIG_OF_EARLY_FLATTREE
-#ifdef CONFIG_USE_BUILTIN_DTB
-	unflatten_and_copy_device_tree();
-#else
-	unflatten_device_tree();
-#endif
-#endif
-
 	paging_init();
 
 	/* Perform the machine specific initialisation */
-- 
2.39.2


