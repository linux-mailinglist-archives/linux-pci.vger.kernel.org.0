Return-Path: <linux-pci+bounces-43412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A32FFCD1222
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 29B6630966BA
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168E33A023;
	Fri, 19 Dec 2025 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DnNiYVsG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721A233B6DC
	for <linux-pci@vger.kernel.org>; Fri, 19 Dec 2025 17:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766164980; cv=none; b=WYiXvjqy8FUscxafE5KHRKPbc0mN8E30uYBNoMKwdvw7pp3fIg9OU7Aw9KUtBTEMB3kTC0TbG5GjDlyEC2AS+huL2KL/KwMMw6Xkl8TUpLGP/p65tP4kOoyX6PHGpZm0npQZuwsYKLGYA549kpOYb39CqFH+iNWFdmOQAxjjpws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766164980; c=relaxed/simple;
	bh=TYzNQ0isiTWkokeom4SbhziOp8ml3d5CiaE+CSoVQFY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmbMwi8adBsOwTj/Wi5Yrwc4+QFjjVQHNXQAmzocZamhlwH6oaENhnk/NeejNsLoYnWeEHYiZVY1IBXZACFWlQXBS49vESLjz7fMayspOcgVfI1Y/9nzcMJ8VpR54pGprC6w2edkjaQAxHKqaac3XgiSgCBWbRyBffPHxRB9vDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DnNiYVsG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766164971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0lJL/SNLjbeVra6hhUj+h/q0KnBWqBFK5+UFeVFEuI=;
	b=DnNiYVsGky7iooT3a3nbKu5co/4qCd4S7rqhODuK5kCpnBQh5UpnE1ScWokGbVRhrIIpis
	/FzlGEtu/lAmJr7Bz95Nys0lrCiaI1RBhR+ZZ2HahYqCE1ay3xkO0Cbd7TIfxWGdUuF2xn
	N5kxIKAWf4layWeXsM+9hoy0/G1ZJ4M=
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
Subject: [PATCH 2/3] PCI/pwrctrl: Add appropriate delays for slot power/clocks
Date: Fri, 19 Dec 2025 12:22:21 -0500
Message-Id: <20251219172222.2808195-2-sean.anderson@linux.dev>
In-Reply-To: <20251219172222.2808195-1-sean.anderson@linux.dev>
References: <39e025bd-50f4-407d-8fd4-e254dbed46b2@linux.dev>
 <20251219172222.2808195-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Each of the PCIe electromechanical specifications requires a delay
between when power and clocks are stable and when PERST is released.
Delay for the specified time before continuing with initialization. If
there are no power supplies/clock, skip the associated delay as we
assume that they have been initialized by the bootloader (and that
booting up to this point has taken longer than the delay).

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/pci/pwrctrl/slot.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..1c56fcd49f2b 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -31,6 +32,7 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot_data *slot;
 	struct device *dev = &pdev->dev;
+	unsigned long delay = 0;
 	struct clk *clk;
 	int ret;
 
@@ -64,6 +66,17 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 				     "Failed to enable slot clock\n");
 	}
 
+	if (slot->num_supplies)
+		/*
+		 * Delay for T_PVPERL. This could be reduced to 1 ms/50 ms
+		 * (T_PVPGL) for Mini/M.2 slots.
+		 */
+		delay = 100000;
+	else if (clk)
+		/* Delay for T_PERST-CLK (100 us for all slot types) */
+		delay = 100;
+
+	fsleep(delay)
 	pci_pwrctrl_init(&slot->ctx, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
-- 
2.35.1.1320.gc452695387.dirty


