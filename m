Return-Path: <linux-pci+bounces-43413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7249CCD1237
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3F3530B4960
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F48B28689A;
	Fri, 19 Dec 2025 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TENzGW2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C694033B6E4
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164989; cv=none; b=T/mO/OGeAWgHzNd6JUaQixf5AHoZyPwIt0xnVa2DqIzOL50SpifaAM0uxgJLCFSCMaNluPUmJHWwagZITP3CBCEJX98KOE/JVkEOhJbBe6wBXFgIFfBuv/ODn035/hTYtZLWVb1uYv0h5BUibI/SW8ApFIS+M3BrhTnyI+oX6PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164989; c=relaxed/simple;
	bh=UmOXR0V7KlTDGVT1DVPAyTxVyMFk1UfpgURmhro9K6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O6KkOtiDiC0jx3KJCfcg53FWA3r93lmMoQOlatrJ74XWuMbRnSp97ynwFQjaIVPhNRHVH7cNQX7/4yNhafxmvmbXsifLN8S+hZ2CgFYFVwemFCaP3SE5n4AjM7NcKBc90KP1a2IfaiXdm0slHcn0pG0ABTwsY5a7zGfaBa47ldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TENzGW2H; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766164978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RfCGsuhor+PCehZ1i9svCLDkgPc0siHPXWlS0C1CvUg=;
	b=TENzGW2HPKBpvPu7nqFGx7/4eq7Kiz45V1QBTzqZNdxdWdQAfsMteiZdkjhptzB8DPjOjN
	fkAz2FcSZAAgCyrIKLdX4eZb5IxXXM1X/Mi+mLFpn2rdoCtFHL1Aegd6UOtvsx91T2IV1X
	3QCJc5VxLeQo30wSzCEfpqT9BqGoHuI=
From: Sean Anderson <sean.anderson@linux.dev>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Brian Norris <briannorris@chromium.org>,
	Niklas Cassel <cassel@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Alex Elder <elder@riscstar.com>,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 3/3] PCI/pwrctrl: Support PERST GPIO in slot driver
Date: Fri, 19 Dec 2025 12:22:22 -0500
Message-Id: <20251219172222.2808195-3-sean.anderson@linux.dev>
In-Reply-To: <20251219172222.2808195-1-sean.anderson@linux.dev>
References: <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev>
 <20251219172222.2808195-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On many embedded platforms PERST is controlled by a GPIO. This was
traditionally handled by the host bridge. However, PERST may be released
before slot resources are initialized if there is a pwrctrl device. To
ensure we follow the power sequence, add support for controlling PERST
to the slot driver.

The host bridge could have already grabbed the GPIO. If this happens the
power sequence might be violated but there's really nothing we can do so
we just ignore the GPIO.

PERST must be asserted for at least T_PERST, such as when
entering/exiting S3/S4. As an optimization, we skip this delay when
PERST was already asserted, which may be the case when booting (such as
if the system has a pull-down on the line).

If the link is already up (e.g. the bootloader configured the power
supplies, clocks, and PERST) we will reset the link anyway. I don't
really know how to avoid this. I think we're OK because the root port
will be probed before we probe the endpoint so we shouldn't reset the
link while we're reading the configuration space.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pci/pwrctrl/slot.c | 52 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 1c56fcd49f2b..59dc92c4bc04 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/pci-pwrctrl.h>
@@ -18,6 +19,7 @@ struct pci_pwrctrl_slot_data {
 	struct pci_pwrctrl ctx;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
+	struct gpio_desc *perst;
 };
 
 static void devm_pci_pwrctrl_slot_power_off(void *data)
@@ -28,6 +30,13 @@ static void devm_pci_pwrctrl_slot_power_off(void *data)
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
+static void devm_pci_pwrctrl_slot_assert_perst(void *data)
+{
+	struct pci_pwrctrl_slot_data *slot = data;
+
+	gpiod_set_value_cansleep(slot->perst, 1);
+}
+
 static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot_data *slot;
@@ -66,6 +75,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 				     "Failed to enable slot clock\n");
 	}
 
+	slot->perst = devm_gpiod_get_optional(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(slot->perst)) {
+		/* The PCIe host bridge may have already grabbed the reset */
+		if (PTR_ERR(slot->perst) != -EBUSY)
+			return dev_err_probe(dev, ret, "failed to get PERST\n");
+		slot->perst = NULL;
+	}
+
 	if (slot->num_supplies)
 		/*
 		 * Delay for T_PVPERL. This could be reduced to 1 ms/50 ms
@@ -76,7 +93,40 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		/* Delay for T_PERST-CLK (100 us for all slot types) */
 		delay = 100;
 
-	fsleep(delay)
+	if (slot->perst) {
+		/*
+		 * If PERST is inactive, the following call to
+		 * gpiod_direction_output will be the first time we assert it
+		 * and we will need to delay for T_PERST.
+		 */
+		if (gpiod_get_value_cansleep(slot->perst) != 1)
+			delay = 100000;
+
+		ret = gpiod_direction_output(slot->perst, 1);
+		if (ret) {
+			dev_err(dev, "failed to assert PERST\n");
+			return ret;
+		}
+	}
+
+	fsleep(delay);
+	if (slot->perst) {
+		gpiod_set_value(slot->perst, 0);
+		ret = devm_add_action_or_reset(dev,
+					       devm_pci_pwrctrl_slot_assert_perst,
+					       slot);
+		if (ret)
+			return ret;
+
+		/*
+		 * PCIe section 6.6.1:
+		 * > ... software must wait a minimum of 100 ms before sending a
+		 * > Configuration Request to the device immediately below that
+		 * > Port.
+		 */
+		msleep(100);
+	}
+
 	pci_pwrctrl_init(&slot->ctx, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
-- 
2.35.1.1320.gc452695387.dirty


