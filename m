Return-Path: <linux-pci+bounces-30413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92537AE49BD
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319163BAEF3
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864C229B8E2;
	Mon, 23 Jun 2025 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="hJ5Aj3up"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5207429B233;
	Mon, 23 Jun 2025 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750694838; cv=pass; b=E9+w+nYMfQMHGsqlgidEAvqp1h6uOjM9jn30U9kZuI+enMbrLiRMxiWOfZ1r9p0TYgm67BE3O+fOesgRrdlx2fEX9Ms3e0s6cGnVkJryi5ArAAg0D8LkvkI6YUKw1ASwwWsHrvBrDRng70tSHQSMghCVW22VTkLfZR6OBo4N6nM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750694838; c=relaxed/simple;
	bh=U3dR7usceUoB1k3W9+wDecW/kRSYlS4inY/JHvz40oQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KabGEIgFqyntHft2PqaDY0PKreVLbdzRPTS73E8U2ScmDbSj6jr36ITgN20r5ESxGU7IdWfIg2pLg+W5i5gwh/j+bf552lTJ3mIWxR+h1zN8gAGoGVG6So9vqKSUsMp56E9px7MejFPbWHJ4L229CEdMYIW37inoMLOSGzk4x+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=hJ5Aj3up; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694764; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UVao7uPKb2Ut1L2cDmAKFM6EvbHFJRJRhzjSiR3OU7fc8TAq2vkP//x2lQ85ZKZBnrA5ZVgLn0N3WshR5q/SArOMQGYWDUh+5uE+KqBTfH47mg4GP792rXUg54EEPruBFGpfYaJtIVmWKsnRj2HVLVTg3QXutP9eReD31SSLnCw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694764; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iE9yh19l2ifejmMUwyg2PaFSbh+ZLdHsr2HyVG2JpXE=; 
	b=KLSor59+fk9LAZCaS55LP3NyjRaHTxa/zZqVL8VBobubkrK3iPBj+8+i37q6pajVRKlhi3lxhM1Is3yWSOO/ZS4q9s69QbpU+PqcDL+6vZjdfvgD60O/8oi73A08mIUV4s/Mep7meA3flPLRRZOgnOcOdmH3/ClxT+jsoZisD4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694764;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=iE9yh19l2ifejmMUwyg2PaFSbh+ZLdHsr2HyVG2JpXE=;
	b=hJ5Aj3uplpiKDx8h+ipBhfmJ8l1L4DLklGLaMyLb/OlN2IOCKfQ8V2EB2YYC1xmx
	RHZkF2ydgekMX00dHgsDxXb7edfllVicyUHvbDYeR0hHsX+RzanXWqULQArOhAGqzNf
	7Oo23uvk7asskBGSDtkVzpYxYSbtt7c2S/JbgwPE=
Received: by mx.zohomail.com with SMTPS id 1750694762676661.9667739946736;
	Mon, 23 Jun 2025 09:06:02 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:29 +0200
Subject: [PATCH v2 01/20] bitmap: introduce hardware-specific bitfield
 operations
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-1-cf1fc08a2e1f@collabora.com>
References: <20250623-byeword-update-v2-0-cf1fc08a2e1f@collabora.com>
In-Reply-To: <20250623-byeword-update-v2-0-cf1fc08a2e1f@collabora.com>
To: Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shreeya Patel <shreeya.patel@collabora.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Qin Jian <qinjian@cqplus1.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org, 
 linux-sound@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, linux-pci@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-clk@vger.kernel.org, llvm@lists.linux.dev, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.2

Hardware of various vendors, but very notably Rockchip, often uses
32-bit registers where the upper 16-bit half of the register is a
write-enable mask for the lower half.

This type of hardware setup allows for more granular concurrent register
write access.

Over the years, many drivers have hand-rolled their own version of this
macro, usually without any checks, often called something like
HIWORD_UPDATE or FIELD_PREP_HIWORD, commonly with slightly different
semantics between them.

Clearly there is a demand for such a macro, and thus the demand should
be satisfied in a common header file. As this is a convention that spans
across multiple vendors, and similar conventions may also have
cross-vendor adoption, it's best if it lives in a vendor-agnostic header
file that can be expanded over time.

Add hw_bitfield.h with two macros: FIELD_PREP_WM16, and
FIELD_PREP_WM16_CONST. The latter is a version that can be used in
initializers, like FIELD_PREP_CONST.

Suggested-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 MAINTAINERS                 |  1 +
 include/linux/hw_bitfield.h | 62 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41f13ccef4c84dcb1762c166553a2dc35704f211..8d2cf600d5cd722b5b08e81b6b24338fdc044240 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4187,6 +4187,7 @@ F:	include/linux/bits.h
 F:	include/linux/cpumask.h
 F:	include/linux/cpumask_types.h
 F:	include/linux/find.h
+F:	include/linux/hw_bitfield.h
 F:	include/linux/nodemask.h
 F:	include/linux/nodemask_types.h
 F:	include/vdso/bits.h
diff --git a/include/linux/hw_bitfield.h b/include/linux/hw_bitfield.h
new file mode 100644
index 0000000000000000000000000000000000000000..df202e167ce487122e4440962eacb2e44817ad9f
--- /dev/null
+++ b/include/linux/hw_bitfield.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025, Collabora Ltd.
+ */
+
+#ifndef _LINUX_HW_BITFIELD_H
+#define _LINUX_HW_BITFIELD_H
+
+#include <linux/bitfield.h>
+#include <linux/build_bug.h>
+#include <linux/limits.h>
+
+/**
+ * FIELD_PREP_WM16() - prepare a bitfield element with a mask in the upper half
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_WM16() masks and shifts up the value, as well as bitwise ORs the
+ * result with the mask shifted up by 16.
+ *
+ * This is useful for a common design of hardware registers where the upper
+ * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
+ * register, a bit in the lower half is only updated if the corresponding bit
+ * in the upper half is high.
+ */
+#define FIELD_PREP_WM16(_mask, _val)					     \
+	({								     \
+		typeof(_val) __val = _val;				     \
+		typeof(_mask) __mask = _mask;				     \
+		__BF_FIELD_CHECK(__mask, ((u16)0U), __val,		     \
+				 "HWORD_UPDATE: ");			     \
+		(((typeof(__mask))(__val) << __bf_shf(__mask)) & (__mask)) | \
+		((__mask) << 16);					     \
+	})
+
+/**
+ * FIELD_PREP_WM16_CONST() - prepare a constant bitfield element with a mask in
+ *                           the upper half
+ * @_mask: shifted mask defining the field's length and position
+ * @_val:  value to put in the field
+ *
+ * FIELD_PREP_WM16_CONST() masks and shifts up the value, as well as bitwise ORs
+ * the result with the mask shifted up by 16.
+ *
+ * This is useful for a common design of hardware registers where the upper
+ * 16-bit half of a 32-bit register is used as a write-enable mask. In such a
+ * register, a bit in the lower half is only updated if the corresponding bit
+ * in the upper half is high.
+ *
+ * Unlike FIELD_PREP_WM16(), this is a constant expression and can therefore
+ * be used in initializers. Error checking is less comfortable for this
+ * version.
+ */
+#define FIELD_PREP_WM16_CONST(_mask, _val)				 \
+	(								 \
+		FIELD_PREP_CONST(_mask, _val) |				 \
+		(BUILD_BUG_ON_ZERO(const_true((u64)(_mask) > U16_MAX)) + \
+		 ((_mask) << 16))					 \
+	)
+
+
+#endif /* _LINUX_HW_BITFIELD_H */

-- 
2.50.0


