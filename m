Return-Path: <linux-pci+bounces-44901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8410BD22D4D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA4F5303A3AE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7812232B98D;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibrOAMTI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25729329C7E;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462152; cv=none; b=loY0fozE+9spgtcVFwmo/1iKZs8GXKdAWGiK7mOBZQl4f3txzbqLgvuGcDnAP2CGmOoMhFLWmmkJ/reKt8bB1EmO694THyuxMKUpW6eY2B4yxybL30BlTn093YB3I8eQ7VKURz+ozkOeGHg71N8hW/VlKPPS4ZbxZ/gQKjuxqDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462152; c=relaxed/simple;
	bh=uCZyGA2rj51LYEQkiiY324zDGBhUBjiiDmOIm8qk0+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ssDQ2hznrGodbAp+6RkzUZ1me2bkyWOGS668Uz3OtluqQguviL4FC3KVKfIrirJKrh5m8UgXIGyrq2+a4X9BcapxUQ1BHqD28YGWQwpxWf2s6yoHyqgv+zwmneh1PbLfP+PnctGzgc2N8naYkG/m1gTxqthGZnEEr1nXbtYkFCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibrOAMTI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFACCC2BCAF;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=uCZyGA2rj51LYEQkiiY324zDGBhUBjiiDmOIm8qk0+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ibrOAMTIk1GNu4YnTMg0P/MI5Dhqr8LoKF+kV2E8LvWduQ8Gj+wojkruumjAVp+RC
	 7jVh+V+/Ckm0j5hw7ZGED4LxU6eMn8Cb1eFPTmYfk907zmG2vf3IigaZTUS/aMoJN9
	 EW/9YP9ORqN9c1224NcJ+FRy8Y8qfTTO3tOOscqo2GPcdfW0v9lWZ4dHcfIZxX55mD
	 YtQWPaTr8gGt1NCbR1CJ1pZTicLjZiheGSryUyz4Tc+mQgV2Xhi6f5AJZf0fwaLpvc
	 5ihAe5g0U4pB9RPaN8GteMdmioea+tZBN/UI8s8PU2tIWzaXg3kwTprSOO6pSJqUkq
	 Ye2MfPfwpkSIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C35D3CCBE;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:59 +0530
Subject: [PATCH v5 07/15] PCI/pwrctrl: slot: Factor out power on/off code
 to helpers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-7-9d26da3ce903@oss.qualcomm.com>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2990;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=07P0XaSjsiTGjrvp6TvDoXT8i9vHCPaPhJUm8tU3mqw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdBfKkjKhqbNYu+PfvSiPL+Tf7KgumdswJHu
 afvm0WDU9+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9VezB/0dkWi9FcYkQhbWq9qAYA64hxZsy6mDqFh7ROFgS04OVk5s4WYR3jGxqDjwtR9XO1brYym
 yK83n+EV7t62tZC/ojYWggCrz2uqRgGPwQVC3xPJiw970kVvZJbGAICJx32vqKbAcjJRK2rA130
 PPmHn1Aw5w/ky/hjBYKnNj19fDRZZVvwRiu9UJqCAbI6z3lrlzwYOx92/OeEBNpbV3y41LmrT53
 uyNi3BPmPqS85UcEHGApNcIVUiFtRm5B9Pvi1BLNWxf9B729O/HfNXcpEzcik+9aGdBKZe3cMrR
 39JhKzaeGciYGgcyQDfr8SfztQQFh3H/wcP9fKpZygtCIqYD
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

In order to allow the pwrctrl core to control the power on/off logic of the
pwrctrl slot driver, move the power on/off code to
pci_pwrctrl_slot_power_{off/on} helper functions.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/slot.c | 49 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 5ddae4ae3431..5d0ec880c0ec 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -17,13 +17,40 @@ struct pci_pwrctrl_slot {
 	struct pci_pwrctrl pwrctrl;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
+	struct clk *clk;
 };
 
-static void devm_pci_pwrctrl_slot_power_off(void *data)
+static int pci_pwrctrl_slot_power_on(struct pci_pwrctrl *pwrctrl)
 {
-	struct pci_pwrctrl_slot *slot = data;
+	struct pci_pwrctrl_slot *slot = container_of(pwrctrl,
+					    struct pci_pwrctrl_slot, pwrctrl);
+	int ret;
+
+	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
+	if (ret < 0) {
+		dev_err(slot->pwrctrl.dev, "Failed to enable slot regulators\n");
+		return ret;
+	}
+
+	return clk_prepare_enable(slot->clk);
+}
+
+static int pci_pwrctrl_slot_power_off(struct pci_pwrctrl *pwrctrl)
+{
+	struct pci_pwrctrl_slot *slot = container_of(pwrctrl,
+					    struct pci_pwrctrl_slot, pwrctrl);
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
+	clk_disable_unprepare(slot->clk);
+
+	return 0;
+}
+
+static void devm_pci_pwrctrl_slot_release(void *data)
+{
+	struct pci_pwrctrl_slot *slot = data;
+
+	pci_pwrctrl_slot_power_off(&slot->pwrctrl);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
 }
 
@@ -31,7 +58,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
 	struct pci_pwrctrl_slot *slot;
 	struct device *dev = &pdev->dev;
-	struct clk *clk;
 	int ret;
 
 	slot = devm_kzalloc(dev, sizeof(*slot), GFP_KERNEL);
@@ -46,23 +72,18 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	}
 
 	slot->num_supplies = ret;
-	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
-		regulator_bulk_free(slot->num_supplies, slot->supplies);
-		return ret;
-	}
 
-	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
+	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_release,
 				       slot);
 	if (ret)
 		return ret;
 
-	clk = devm_clk_get_optional_enabled(dev, NULL);
-	if (IS_ERR(clk)) {
-		return dev_err_probe(dev, PTR_ERR(clk),
+	slot->clk = devm_clk_get_optional(dev, NULL);
+	if (IS_ERR(slot->clk))
+		return dev_err_probe(dev, PTR_ERR(slot->clk),
 				     "Failed to enable slot clock\n");
-	}
+
+	pci_pwrctrl_slot_power_on(&slot->pwrctrl);
 
 	pci_pwrctrl_init(&slot->pwrctrl, dev);
 

-- 
2.48.1



