Return-Path: <linux-pci+bounces-30428-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1940AE4A7A
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 18:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4463A36DF
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 16:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1978F2BE7DF;
	Mon, 23 Jun 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="NZH84XRR"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFC32940F;
	Mon, 23 Jun 2025 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750695040; cv=pass; b=VYhuLn7Z8wJVNNcbLQgYPtgJJEpro55ZqEMxND9qTFpD5+XtRSEHk/sfcvLfDpKO3qm8FLz3HwBDYJbCJzEW4fy8ji3q7LdBgCR1F0KoWL/XkNbl0WWs36Z8C3zdsShZaPgieLB37trhjIuGldIA2WzifoHPiJfXxx42H8iYCFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750695040; c=relaxed/simple;
	bh=cKFkksLtqSRrinXP9bQSD9rzQokOdiFAjVlLGX5ZQ5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JykuxkUjRr0DeJRJFl/QxTrLQU21oLC0DMUTzF7XEz889ZEBV51gysaUFjHniwK3C/E//ZP0mBMaOWmzyOy3CZST1ygBqNdet2/BqT5JV+xQjz47B2b6uswYJsXUd9yF1Zv8TUkOrocaSHOrFGVlfK+dPcFTSaut7mRJPgqE2M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=NZH84XRR; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750694976; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TdtqpyLKGIU0iH5indVmh2kAVoKuVW20SmbBdb3gTL+JvDDcRRwqOEeLZibqbfPhce1RK57ZZhfhOaTv1/ffJitUNtfQurs6YudLXOh20DBjrheszGqrtdV9+huIbXqx9Fro8So4PLgNJLdKx/YsznLXGYuZEyoKqN0f5XSeY/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750694976; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=H0Y9An4GxqzQxNAql+oS+MUtP/pDTEf8Ub3+2gLIo4I=; 
	b=Qv1/+Z35xIqEVIeCHGYNiY40rWNyymjJd2jAn7VKKLMw8QQX+c1Ruc/ZZuDXjRZFk6pe6rigYx1N7hCVx0Vu1wSPR5vd8OND18+NBXFv/oV9dq0x7LgX568/a2xqOkdjEl9+yjU+0WPUK78TfoaGB4kxj0segP4QWIvSlNxtB60=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750694975;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=H0Y9An4GxqzQxNAql+oS+MUtP/pDTEf8Ub3+2gLIo4I=;
	b=NZH84XRRGzYxSPIEsQLnhKmZOFeRoCo8RG7Ip8J6aq70SoKYWlB8kSQO1aOyz9A4
	4xwarubI7us2u/OYBpyWDh3KfoGkJ8+fl84xZrCveHelvSeSu2FXhdamXUHlO/snR6o
	3kz8MtrQOtQYAcQAs9iJAkt6vdU3YCkc6qpS2r1Q=
Received: by mx.zohomail.com with SMTPS id 1750694973570312.5059402793495;
	Mon, 23 Jun 2025 09:09:33 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 23 Jun 2025 18:05:45 +0200
Subject: [PATCH v2 17/20] PCI: dw-rockchip: Switch to FIELD_PREP_WM16 macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-byeword-update-v2-17-cf1fc08a2e1f@collabora.com>
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

The era of hand-rolled HIWORD_UPDATE macros is over.

Like many other Rockchip drivers, pcie-dw-rockchip brings with it its
very own flavour of HIWORD_UPDATE. It's occasionally used without a
constant mask, which complicates matters. HIWORD_UPDATE_BIT is a
confusingly named addition, as it doesn't update the bit, it actually
sets all bits in the value to 1. HIWORD_DISABLE_BIT is similarly
confusing; it disables several bits at once by using the value as a mask
and the inverse of value as the value, and the "disabling only these"
effect comes from the hardware actually using the mask. The more obvious
approach would've been HIWORD_UPDATE(val, 0) in my opinion.

This is part of the motivation why this patch uses hw_bitfield.h's
FIELD_PREP_WM16 instead, where possible. FIELD_PREP_WM16 requires a
constant bit mask, which isn't possible where the irq number is used to
generate a bit mask. For that purpose, we replace it with a more robust
macro than what was there but that should also bring close to zero
runtime overhead: we actually mask the IRQ number to make sure we're not
writing garbage.

For the remaining bits, there also are some caveats. For starters, the
PCIE_CLIENT_ENABLE_LTSSM and PCIE_CLIENT_DISABLE_LTSSM were named in a
manner that isn't quite truthful to what they do. Their modification
actually spans not just the LTSSM bit but also another bit, flipping
only the LTSSM one, but keeping the other (which according to the TRM
has a reset value of 0) always enabled. This other bit is reserved as of
the IP version RK3588 uses at least, and I have my doubts as to whether
it was meant to be set, and whether it was meant to be set in that code
path. Either way, it's confusing.

Replace it with just writing either 1 or 0 to the LTSSM bit, using the
new FIELD_PREP_WM16 macro from hw_bitfield.h, which grants us the
benefit of better compile-time error checking.

The change of no longer setting the reserved bit doesn't appear to
change the behaviour on RK3568 in RC mode, where it's not marked as
reserved.

PCIE_CLIENT_RC_MODE/PCIE_CLIENT_EP_MODE was another field that wasn't
super clear on what the bit field modification actually is. As far as I
can tell, switching to RC mode doesn't actually write the correct value
to the field if any of its bits have been set previously, as it only
updates one bit of a 4 bit field.

Replace it by actually writing the full values to the field, using the
new FIELD_PREP_WM16 macro, which grants us the benefit of better
compile-time error checking.

This patch was tested on RK3588 (PCIe3 x4 controller), RK3576 (PCIe2 x1
controller) and RK3568 (PCIe x2 controller), all in RC mode.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/pci/controller/dwc/pcie-dw-rockchip.c | 42 +++++++++++++++++----------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
index cd1e9352b21fcabca0bb241366012f9bd716e17b..9ac959fac795505e926eb64f67c67dffd1bd7df2 100644
--- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
+++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
@@ -11,6 +11,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hw_bitfield.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/mfd/syscon.h>
@@ -29,18 +30,18 @@
  * The upper 16 bits of PCIE_CLIENT_CONFIG are a write
  * mask for the lower 16 bits.
  */
-#define HIWORD_UPDATE(mask, val) (((mask) << 16) | (val))
-#define HIWORD_UPDATE_BIT(val)	HIWORD_UPDATE(val, val)
-#define HIWORD_DISABLE_BIT(val)	HIWORD_UPDATE(val, ~val)
 
 #define to_rockchip_pcie(x) dev_get_drvdata((x)->dev)
 
 /* General Control Register */
 #define PCIE_CLIENT_GENERAL_CON		0x0
-#define  PCIE_CLIENT_RC_MODE		HIWORD_UPDATE_BIT(0x40)
-#define  PCIE_CLIENT_EP_MODE		HIWORD_UPDATE(0xf0, 0x0)
-#define  PCIE_CLIENT_ENABLE_LTSSM	HIWORD_UPDATE_BIT(0xc)
-#define  PCIE_CLIENT_DISABLE_LTSSM	HIWORD_UPDATE(0x0c, 0x8)
+#define  PCIE_CLIENT_MODE_MASK		GENMASK(7, 4)
+#define  PCIE_CLIENT_MODE_EP		0x0UL
+#define  PCIE_CLIENT_MODE_RC		0x4UL
+#define  PCIE_CLIENT_SET_MODE(x)	FIELD_PREP_WM16(PCIE_CLIENT_MODE_MASK, (x))
+#define  PCIE_CLIENT_LD_RQ_RST_GRT	FIELD_PREP_WM16(BIT(3), 1)
+#define  PCIE_CLIENT_ENABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 1)
+#define  PCIE_CLIENT_DISABLE_LTSSM	FIELD_PREP_WM16(BIT(2), 0)
 
 /* Interrupt Status Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_STATUS_LEGACY	0x8
@@ -52,6 +53,11 @@
 
 /* Interrupt Mask Register Related to Legacy Interrupt */
 #define PCIE_CLIENT_INTR_MASK_LEGACY	0x1c
+#define  PCIE_INTR_MASK			GENMASK(7, 0)
+#define  PCIE_INTR_CLAMP(_x)		((BIT((_x)) & PCIE_INTR_MASK))
+#define  PCIE_INTR_LEGACY_MASK(x)	(PCIE_INTR_CLAMP((x)) | \
+					 (PCIE_INTR_CLAMP((x)) << 16))
+#define  PCIE_INTR_LEGACY_UNMASK(x)	(PCIE_INTR_CLAMP((x)) << 16)
 
 /* Interrupt Mask Register Related to Miscellaneous Operation */
 #define PCIE_CLIENT_INTR_MASK_MISC	0x24
@@ -116,14 +122,14 @@ static void rockchip_pcie_intx_handler(struct irq_desc *desc)
 static void rockchip_intx_mask(struct irq_data *data)
 {
 	rockchip_pcie_writel_apb(irq_data_get_irq_chip_data(data),
-				 HIWORD_UPDATE_BIT(BIT(data->hwirq)),
+				 PCIE_INTR_LEGACY_MASK(data->hwirq),
 				 PCIE_CLIENT_INTR_MASK_LEGACY);
 };
 
 static void rockchip_intx_unmask(struct irq_data *data)
 {
 	rockchip_pcie_writel_apb(irq_data_get_irq_chip_data(data),
-				 HIWORD_DISABLE_BIT(BIT(data->hwirq)),
+				 PCIE_INTR_LEGACY_UNMASK(data->hwirq),
 				 PCIE_CLIENT_INTR_MASK_LEGACY);
 };
 
@@ -488,7 +494,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
 		dev_dbg(dev, "hot reset or link-down reset\n");
 		dw_pcie_ep_linkdown(&pci->ep);
 		/* Stop delaying link training. */
-		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
+		val = FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_DONE, 1);
 		rockchip_pcie_writel_apb(rockchip, val,
 					 PCIE_CLIENT_HOT_RESET_CTRL);
 	}
@@ -527,10 +533,11 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	}
 
 	/* LTSSM enable control mode */
-	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
-	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_RC_MODE,
+	rockchip_pcie_writel_apb(rockchip,
+				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_RC),
 				 PCIE_CLIENT_GENERAL_CON);
 
 	pp = &rockchip->pci.pp;
@@ -544,7 +551,7 @@ static int rockchip_pcie_configure_rc(struct platform_device *pdev,
 	}
 
 	/* unmask DLL up/down indicator */
-	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED, 0);
+	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
 	return ret;
@@ -576,10 +583,12 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	 * LTSSM enable control mode, and automatically delay link training on
 	 * hot reset/link-down reset.
 	 */
-	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN);
+	val = FIELD_PREP_WM16(PCIE_LTSSM_ENABLE_ENHANCE, 1) |
+	      FIELD_PREP_WM16(PCIE_LTSSM_APP_DLY2_EN, 1);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
 
-	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
+	rockchip_pcie_writel_apb(rockchip,
+				 PCIE_CLIENT_SET_MODE(PCIE_CLIENT_MODE_EP),
 				 PCIE_CLIENT_GENERAL_CON);
 
 	rockchip->pci.ep.ops = &rockchip_pcie_ep_ops;
@@ -603,7 +612,8 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
 	pci_epc_init_notify(rockchip->pci.ep.epc);
 
 	/* unmask DLL up/down indicator and hot reset/link-down reset */
-	val = HIWORD_UPDATE(PCIE_RDLH_LINK_UP_CHGED | PCIE_LINK_REQ_RST_NOT_INT, 0);
+	val = FIELD_PREP_WM16(PCIE_RDLH_LINK_UP_CHGED, 0) |
+	      FIELD_PREP_WM16(PCIE_LINK_REQ_RST_NOT_INT, 0);
 	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_INTR_MASK_MISC);
 
 	return ret;

-- 
2.50.0


