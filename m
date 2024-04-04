Return-Path: <linux-pci+bounces-5648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F0897E55
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFAF31F2561A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0CD43ABF;
	Thu,  4 Apr 2024 05:00:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 722991CFA0;
	Thu,  4 Apr 2024 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206850; cv=none; b=bjMswcDdcfDLugt4moes0qxAlOgE3Fil13/nTXvxCgAUvtxSLQIQF9ufT2PI8p/ThvGL5L0st2maW+sDj8pwPIeJpkWxHuAWO1JfydlNtgzDbVuTbz/Lg9dz8KMrpR2JOXHMpwIt8MN8ud//flWIqjdnw61LaUaSi64ShEgGbwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206850; c=relaxed/simple;
	bh=YdVR5VR9Dwt1XuaGLTGtEYBwDqKsBqzuokkPY3rn9Qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VUI3zR09usuDM4atXJzSZfFN9QIzBtPTnM8/bIv/cxdbmDzJHWpqavTbk/6tDQ8BckmnSdbCfQQ0MEGaGxGQqJsfm6oYj+o6OPekRvbVQufl6WdCjR9ZSNfRB8LlH/K0+JWthtLh5Dm+o2IBKawdWVnmjMeXMJUEzCN/8UwlbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id A98A31C04AD;
	Thu,  4 Apr 2024 14:00:45 +0900 (JST)
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
Subject: [PATCH v7 06/37] sh: kernel/setup Update DT support.
Date: Thu,  4 Apr 2024 13:59:31 +0900
Message-Id: <a4ce7771faec761b9bbb91ff6694a99e5bc293b6.1712205900.git.ysato@users.sourceforge.jp>
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

Fix extrnal fdt initialize and bootargs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/Kconfig             | 23 +++++++++++------------
 arch/sh/include/asm/setup.h |  1 +
 arch/sh/kernel/setup.c      | 36 +++++++++++++++++++++++-------------
 3 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 6711cde0d973..242cf30e704d 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -708,17 +708,22 @@ config ROMIMAGE_MMCIF
 	  first part of the romImage which in turn loads the rest the kernel
 	  image to RAM using the MMCIF hardware block.
 
+config CMDLINE
+	string "Kernel command line arguments string"
+	default "console=ttySC1,115200"
+
 choice
 	prompt "Kernel command line"
-	optional
-	default CMDLINE_OVERWRITE
-	depends on !OF || USE_BUILTIN_DTB
+	default CMDLINE_BOOTLOADER
+
+config CMDLINE_BOOTLOADER
+	bool "Use bootloader kernel arguments"
 	help
-	  Setting this option allows the kernel command line arguments
-	  to be set.
+	  Uses the command-line options passed by the boot loader.
+	  If boot loader dosen't provide kernel argments, Use built-in argments.
 
 config CMDLINE_OVERWRITE
-	bool "Overwrite bootloader kernel arguments"
+	bool "Overwrite built-in kernel arguments"
 	help
 	  Given string will overwrite any arguments passed in by
 	  a bootloader.
@@ -730,12 +735,6 @@ config CMDLINE_EXTEND
 	  by a bootloader.
 
 endchoice
-
-config CMDLINE
-	string "Kernel command line arguments string"
-	depends on CMDLINE_OVERWRITE || CMDLINE_EXTEND
-	default "console=ttySC1,115200"
-
 endmenu
 
 menu "Bus options"
diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.h
index fc807011187f..84bb23a771f3 100644
--- a/arch/sh/include/asm/setup.h
+++ b/arch/sh/include/asm/setup.h
@@ -21,5 +21,6 @@
 void sh_mv_setup(void);
 void check_for_initrd(void);
 void per_cpu_trap_init(void);
+void sh_fdt_init(phys_addr_t dt_phys);
 
 #endif /* _SH_SETUP_H */
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 620e5cf8ae1e..42e6292a40cf 100644
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
@@ -269,8 +270,22 @@ void __ref sh_fdt_init(phys_addr_t dt_phys)
 
 void __init setup_arch(char **cmdline_p)
 {
+#if defined(CONFIG_OF) && defined(CONFIG_OF_EARLY_FLATTREE)
+	if (IS_ENABLED(CONFIG_USE_BUILTIN_DTB)) {
+		/* Relocate Embedded DTB */
+		unflatten_and_copy_device_tree();
+	} else if (initial_boot_params) {
+		/* Reserve external DTB area */
+		memblock_reserve(__pa(initial_boot_params),
+				 fdt_totalsize(initial_boot_params));
+		unflatten_device_tree();
+	}
+	/* copy from /chosen/bootargs */
+	strscpy(command_line, boot_command_line, COMMAND_LINE_SIZE);
+#endif
 	enable_mmu();
 
+#ifndef CONFIG_OF
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
 
 	printk(KERN_NOTICE "Boot params:\n"
@@ -299,14 +314,17 @@ void __init setup_arch(char **cmdline_p)
 	bss_resource.start = virt_to_phys(__bss_start);
 	bss_resource.end = virt_to_phys(__bss_stop)-1;
 
-#ifdef CONFIG_CMDLINE_OVERWRITE
-	strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
-#else
-	strscpy(command_line, COMMAND_LINE, sizeof(command_line));
+#endif
+#if !defined(CONFIG_OF) || defined(CONFIG_USE_BUILTIN_DTB)
+	if (*COMMAND_LINE)
+		strscpy(command_line, COMMAND_LINE, sizeof(command_line));
+#endif
+	if (*command_line == '\0' || IS_ENABLED(CONFIG_CMDLINE_OVERWRITE))
+		/* Use built-in parameter */
+		strscpy(command_line, CONFIG_CMDLINE, sizeof(command_line));
 #ifdef CONFIG_CMDLINE_EXTEND
 	strlcat(command_line, " ", sizeof(command_line));
 	strlcat(command_line, CONFIG_CMDLINE, sizeof(command_line));
-#endif
 #endif
 
 	/* Save unparsed command line copy for /proc/cmdline */
@@ -322,14 +340,6 @@ void __init setup_arch(char **cmdline_p)
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


