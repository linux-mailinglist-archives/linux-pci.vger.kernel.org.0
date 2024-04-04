Return-Path: <linux-pci+bounces-5665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE3897F00
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 07:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEFC1C269A8
	for <lists+linux-pci@lfdr.de>; Thu,  4 Apr 2024 05:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6760745FA;
	Thu,  4 Apr 2024 05:01:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from sakura.ysato.name (ik1-413-38519.vs.sakura.ne.jp [153.127.30.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15024642A;
	Thu,  4 Apr 2024 05:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=153.127.30.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712206882; cv=none; b=pV+EtgDiCDuq0lj6MrPOoUfr4984T6rNyfO+GATs9Z0tF1ULAr6qArc9cSyaQQ8DyZ9LtEVYl6TPXU0lrrn9zn3Mx1kWo/2v8Ls2uQEq/fSe+P6WVeSXov70ompxZCTrbcAelpP5Gt6erOo0QDViSXoNtEwLQXorO/ZL1YCnurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712206882; c=relaxed/simple;
	bh=RfBIVerSVY5ro3iClkCuqoyBsbZfPpMYmGiZieoqKAU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RRk21OWuKexCZxDtqlzKiqDwdw9rsOwzqKIphxEFxJTjbWltrUch6Q8n83viHGFHE/Urd1aRo1O4FaZni45LPhy3/NwDJFqX/vGB1Vd2lzC+gAhsZLM83yDozF+GqTCMjqIUsc3W20Mj2gvlntLHtG1HLSLmTvX1pMyjYUheGVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp; spf=fail smtp.mailfrom=users.sourceforge.jp; arc=none smtp.client-ip=153.127.30.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=users.sourceforge.jp
Received: from SIOS1075.ysato.name (al128006.dynamic.ppp.asahi-net.or.jp [111.234.128.6])
	by sakura.ysato.name (Postfix) with ESMTPSA id AEDF81C0B3E;
	Thu,  4 Apr 2024 14:01:18 +0900 (JST)
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
Subject: [PATCH v7 23/37] dt-bindings: display: sm501 register definition helper
Date: Thu,  4 Apr 2024 14:00:02 +0900
Message-Id: <dac98a697c8e850054f984964af62a209f241c83.1712205900.git.ysato@users.sourceforge.jp>
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

Miscellaneous Timing and Miscellaneous Control registers definition.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/dt-bindings/display/sm501.h | 76 +++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)
 create mode 100644 include/dt-bindings/display/sm501.h

diff --git a/include/dt-bindings/display/sm501.h b/include/dt-bindings/display/sm501.h
new file mode 100644
index 000000000000..a6c6943642e4
--- /dev/null
+++ b/include/dt-bindings/display/sm501.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
+#ifndef __DT_BINDING_DISPALY_SM501__
+#define __DT_BINDING_DISPALY_SM501__
+
+/* Miscellaneous Conntrol */
+#define SM501_MISC_CONTROL_PAD_24	0
+#define SM501_MISC_CONTROL_PAD_12	1
+#define SM501_MISC_CONTROL_PAD_8	2
+
+#define SM501_MISC_CONTROL_USBCLK_XTAL	0
+#define SM501_MISC_CONTROL_USBCLK_96MHZ	1
+#define SM501_MISC_CONTROL_USBCLK_48MHZ	2
+
+#define SM501_MISC_CONTROL_RFSH_8US	0
+#define SM501_MISC_CONTROL_RFSH_16US	1
+#define SM501_MISC_CONTROL_RFSH_32US	2
+#define SM501_MISC_CONTROL_RFSH_64US	3
+
+#define SM501_MISC_CONTROL_HOLD_EMPTY	0
+#define SM501_MISC_CONTROL_HOLD_8TR	1
+#define SM501_MISC_CONTROL_HOLD_16TR	2
+#define SM501_MISC_CONTROL_HOLD_24TR	3
+#define SM501_MISC_CONTROL_HOLD_32TR	4
+
+/* Miscellaneous timing */
+#define SM501_MISC_TIMING_EX_HOLD_0	0
+#define SM501_MISC_TIMING_EX_HOLD_16	1
+#define SM501_MISC_TIMING_EX_HOLD_32	2
+#define SM501_MISC_TIMING_EX_HOLD_48	3
+#define SM501_MISC_TIMING_EX_HOLD_64	4
+#define SM501_MISC_TIMING_EX_HOLD_80	5
+#define SM501_MISC_TIMING_EX_HOLD_96	6
+#define SM501_MISC_TIMING_EX_HOLD_112	7
+#define SM501_MISC_TIMING_EX_HOLD_128	8
+#define SM501_MISC_TIMING_EX_HOLD_144	9
+#define SM501_MISC_TIMING_EX_HOLD_160	10
+#define SM501_MISC_TIMING_EX_HOLD_176	11
+#define SM501_MISC_TIMING_EX_HOLD_192	12
+#define SM501_MISC_TIMING_EX_HOLD_208	13
+#define SM501_MISC_TIMING_EX_HOLD_224	14
+#define SM501_MISC_TIMING_EX_HOLD_240	15
+
+#define SM501_MISC_TIMING_XC_INTERNAL	0
+#define SM501_MISC_TIMING_XC_HCLK	1
+#define SM501_MISC_TIMING_XC_GPIO	2
+
+#define SM501_MISC_TIMING_SM_DIV1	0
+#define SM501_MISC_TIMING_SM_DIV2	1
+#define SM501_MISC_TIMING_SM_DIV4	2
+#define SM501_MISC_TIMING_SM_DIV8	3
+#define SM501_MISC_TIMING_SM_DIV16	4
+#define SM501_MISC_TIMING_SM_DIV32	5
+#define SM501_MISC_TIMING_SM_DIV64	6
+#define SM501_MISC_TIMING_SM_DIV128	7
+#define SM501_MISC_TIMING_SM_DIV3	8
+#define SM501_MISC_TIMING_SM_DIV6	9
+#define SM501_MISC_TIMING_SM_DIV12	10
+#define SM501_MISC_TIMING_SM_DIV24	11
+#define SM501_MISC_TIMING_SM_DIV48	12
+#define SM501_MISC_TIMING_SM_DIV96	13
+#define SM501_MISC_TIMING_SM_DIV192	14
+#define SM501_MISC_TIMING_SM_DIV384	15
+
+#define SM501_MISC_TIMING_DIV336MHZ	0
+#define SM501_MISC_TIMING_DIV288MHZ	1
+#define SM501_MISC_TIMING_DIV240MHZ	2
+#define SM501_MISC_TIMING_DIV192MHZ	3
+
+#define SM501_MISC_TIMING_DELAY_NONE	0
+#define SM501_MISC_TIMING_DELAY_0_5	1
+#define SM501_MISC_TIMING_DELAY_1_0	2
+#define SM501_MISC_TIMING_DELAY_1_5	3
+#define SM501_MISC_TIMING_DELAY_2_0	4
+#define SM501_MISC_TIMING_DELAY_2_5	5
+
+#endif
-- 
2.39.2


