Return-Path: <linux-pci+bounces-44903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9D3D22D5A
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18480306E2F3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8285C32B9B7;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZEit5xpn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4873432AAD8;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=drJK/MYMPlTppWpgxQwxSKWHxBqxr3BE0RbxI7UFJC2ImJVjYSD60oXY3ESDBNSOgdeVGqKIhhRZCK9GHCbn/XdXAccBUJz/q1L3NirmB25vi9JdRCk3EAZk1ceORjDRQwa5Ltb2C7my5lJQvrcrHYQbU+n9EvQG2eARyefFIH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=01E+i9Us2E9ILdSDTiieQTUBKQo53xWamkscB0dm/mY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvxRgrWT0SU1Wxzi0gLEihroBAu+qHTnYThl3LEmuJUzQnFmJvrfa+JD4qPmA2YzEvfLsoeG0N0g/l/Y0y0VjSyP5VJPWtYbuzAoQpwsGoyCjkwUKHI9gOJdgrZAiD3R0k1wO4ViM8o93dx/yBPEkJyNGtah6+hdbl9i/PmHo+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZEit5xpn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE0C1C4AF61;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=01E+i9Us2E9ILdSDTiieQTUBKQo53xWamkscB0dm/mY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZEit5xpnbF96f94QlNDsMwkqjmdOd6Mf0hz4RXyb4TG0YxLYb96j3j+WUL0N8aAJ4
	 mehRv0XJdmi8uvhSYNH8SZTXTFhQ3KL+Mepi9+iQQWWjbrnMcs2s6JkddV9TzCFQ2D
	 /n7IbutPMS3ZA/pwU0Xzc2HAQE7NC7pqbHTe0xsn3+1r3sNeGy/JbhR3aobOFQaMWk
	 vtiKKT0E1q7BpQomIPdI4kFm9KdY7MiXfF2Qlixdyp2U5DSeg5YkUb8YEgttel38xH
	 h6PvF/WZ82plfAugHRoA9Tq7Aj49AVu3FFu7jycAWsoV+C9/oMkW/22Oq0Df+0aLwR
	 vAPmWIgEzO0kQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B9CD3CCB3;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:59:01 +0530
Subject: [PATCH v5 09/15] PCI/pwrctrl: Add 'struct
 pci_pwrctrl::power_{on/off}' callbacks
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-9-9d26da3ce903@oss.qualcomm.com>
References: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
In-Reply-To: <20260115-pci-pwrctrl-rework-v5-0-9d26da3ce903@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
 Niklas Cassel <cassel@kernel.org>, Alex Elder <elder@riscstar.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5551;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=cgHzIAEsgNpOwxTB3hHxgFQ6227n1CTcovLsMGKsXc0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdCbwbZM/FEGqymRB6MoAXpaH0pdHnNTUxeQ
 Uif4gdfT3KJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQgAKCRBVnxHm/pHO
 9bnJB/wLlc37LesynXGPEY5Ry+XMkojfF3H/PaxNUzuvl94aOx28ZpDzr129LG5bN5iAcAmHnlY
 y4f/PEgIih9L+ueK4E236iIOB7Y9Bew5LtOWTidP4YQ8YNXD4PsvDDygmDtnTfQdQPm2hRRApoM
 mHu9F/ZgVdhsdUIZNl2fGe92783XW9EFogjBbWSd7bXaAHoCm5ZrIib4drXQoE/nm/lizaIVN0N
 cNHSquxsyxJFhzv9gkTk7AYI+nWAS2cAH88Klc1fl+I6gyble1QrLajqM/mD9N90r6ReoNix3RY
 lwTnEb3jF3HNYxGN6G4S5rg9cRaJUMfrXirN7bQFJ7IJJGQ0
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

To allow the pwrctrl core to control the power on/off sequences of the
pwrctrl drivers, add the 'struct pci_pwrctrl::power_{on/off}' callbacks and
populate them in the respective pwrctrl drivers.

The pwrctrl drivers still power on the resources on their own now. So there
is no functional change.

Co-developed-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c |  3 +++
 drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c | 22 ++++++++++++++++------
 drivers/pci/pwrctrl/slot.c               |  3 +++
 include/linux/pci-pwrctrl.h              |  4 ++++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index d2c261b09030..2ee02edd55a3 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -111,6 +111,9 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pwrseq->pwrctrl.power_on = pci_pwrctrl_pwrseq_power_on;
+	pwrseq->pwrctrl.power_off = pci_pwrctrl_pwrseq_power_off;
+
 	pci_pwrctrl_init(&pwrseq->pwrctrl, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &pwrseq->pwrctrl);
diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
index 8ae27abdf362..a71d7ef2d4b8 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
@@ -450,15 +450,22 @@ static int tc9563_pwrctrl_parse_device_dt(struct pci_pwrctrl_tc9563 *tc9563,
 	return 0;
 }
 
-static void tc9563_pwrctrl_power_off(struct pci_pwrctrl_tc9563 *tc9563)
+static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
 {
+	struct pci_pwrctrl_tc9563 *tc9563 = container_of(pwrctrl,
+					struct pci_pwrctrl_tc9563, pwrctrl);
+
 	gpiod_set_value(tc9563->reset_gpio, 1);
 
 	regulator_bulk_disable(ARRAY_SIZE(tc9563->supplies), tc9563->supplies);
+
+	return 0;
 }
 
-static int tc9563_pwrctrl_bring_up(struct pci_pwrctrl_tc9563 *tc9563)
+static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
 {
+	struct pci_pwrctrl_tc9563 *tc9563 = container_of(pwrctrl,
+					struct pci_pwrctrl_tc9563, pwrctrl);
 	struct device *dev = tc9563->pwrctrl.dev;
 	struct tc9563_pwrctrl_cfg *cfg;
 	int ret, i;
@@ -520,7 +527,7 @@ static int tc9563_pwrctrl_bring_up(struct pci_pwrctrl_tc9563 *tc9563)
 		return 0;
 
 power_off:
-	tc9563_pwrctrl_power_off(tc9563);
+	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 	return ret;
 }
 
@@ -613,7 +620,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			goto remove_i2c;
 	}
 
-	ret = tc9563_pwrctrl_bring_up(tc9563);
+	ret = tc9563_pwrctrl_power_on(&tc9563->pwrctrl);
 	if (ret)
 		goto remove_i2c;
 
@@ -623,6 +630,9 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 			goto power_off;
 	}
 
+	tc9563->pwrctrl.power_on = tc9563_pwrctrl_power_on;
+	tc9563->pwrctrl.power_off = tc9563_pwrctrl_power_off;
+
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &tc9563->pwrctrl);
 	if (ret)
 		goto power_off;
@@ -632,7 +642,7 @@ static int tc9563_pwrctrl_probe(struct platform_device *pdev)
 	return 0;
 
 power_off:
-	tc9563_pwrctrl_power_off(tc9563);
+	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 remove_i2c:
 	i2c_unregister_device(tc9563->client);
 	put_device(&tc9563->adapter->dev);
@@ -643,7 +653,7 @@ static void tc9563_pwrctrl_remove(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_tc9563 *tc9563 = platform_get_drvdata(pdev);
 
-	tc9563_pwrctrl_power_off(tc9563);
+	tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
 	i2c_unregister_device(tc9563->client);
 	put_device(&tc9563->adapter->dev);
 }
diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 5d0ec880c0ec..55828aec2486 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -85,6 +85,9 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 
 	pci_pwrctrl_slot_power_on(&slot->pwrctrl);
 
+	slot->pwrctrl.power_on = pci_pwrctrl_slot_power_on;
+	slot->pwrctrl.power_off = pci_pwrctrl_slot_power_off;
+
 	pci_pwrctrl_init(&slot->pwrctrl, dev);
 
 	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->pwrctrl);
diff --git a/include/linux/pci-pwrctrl.h b/include/linux/pci-pwrctrl.h
index 4aefc7901cd1..435b822c841e 100644
--- a/include/linux/pci-pwrctrl.h
+++ b/include/linux/pci-pwrctrl.h
@@ -31,6 +31,8 @@ struct device_link;
 /**
  * struct pci_pwrctrl - PCI device power control context.
  * @dev: Address of the power controlling device.
+ * @power_on: Callback to power on the power controlling device.
+ * @power_off: Callback to power off the power controlling device.
  *
  * An object of this type must be allocated by the PCI power control device and
  * passed to the pwrctrl subsystem to trigger a bus rescan and setup a device
@@ -38,6 +40,8 @@ struct device_link;
  */
 struct pci_pwrctrl {
 	struct device *dev;
+	int (*power_on)(struct pci_pwrctrl *pwrctrl);
+	int (*power_off)(struct pci_pwrctrl *pwrctrl);
 
 	/* private: internal use only */
 	struct notifier_block nb;

-- 
2.48.1



