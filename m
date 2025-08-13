Return-Path: <linux-pci+bounces-33954-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C130CB24EAD
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 18:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AF41C263C4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 15:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C723D7E2;
	Wed, 13 Aug 2025 15:56:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474671D54D8;
	Wed, 13 Aug 2025 15:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100591; cv=none; b=I4hTgjmsjI6oKFFw9rKq3ORUttl5BPLODvY40tBul6X554dJw9k59d1DPEfCjvSN7F5bMom10wnBRGufwHxpSum6XLJvAPkyFu1EezoV6O35Qh9lucI8kmUaTyHYkDuGS9Xg5a7Zcf0r4oLVLeJEJbBAyRMYJcGeqeN+KlPvNl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100591; c=relaxed/simple;
	bh=KCcXnOzbpwKx4bDDi38YHUJKX43M5rzAEuIjn1wdJNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xa+n9LKMMDjwOc2Uzr1yihQeKrrCF6iebJdsfon0Q9RRNw541I9zTQSHg9EA16U6NS2scY1mjYyDG+9lepFA+7XouvCtlVj7P/tiL/T820Guklmqi4Q2bEZkSWh7zLXEb0L+jLFlOD6WmWlLn+8y1C8SfnTr39W/PywVVAhVebA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5A8C4CEEB;
	Wed, 13 Aug 2025 15:56:28 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v2] PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure
Date: Wed, 13 Aug 2025 17:56:25 +0200
Message-ID: <7b1386e6162e70e6d631c87f6323d2ab971bc1c5.1755100324.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When devm_add_action_or_reset() fails, it calls the passed cleanup
function.  Hence the caller must not repeat that cleanup.

Replace the "goto err_regulator_free" by the actual freeing, as there
will never be a need again for a second user of this label.

Fixes: 75996c92f4de309f ("PCI/pwrctrl: Add pwrctrl driver for PCI slots")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Tested-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # V4H Sparrow Hawk
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Compile-tested only.

v2:
  - Add Reviewed-by, Tested-by, Acked-by.
---
 drivers/pci/pwrctrl/slot.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 6e138310b45b9f7e..3320494b62d890ff 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -49,13 +49,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
-		goto err_regulator_free;
+		regulator_bulk_free(slot->num_supplies, slot->supplies);
+		return ret;
 	}
 
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_slot_power_off,
 				       slot);
 	if (ret)
-		goto err_regulator_disable;
+		return ret;
 
 	clk = devm_clk_get_optional_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
@@ -70,13 +71,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
 
 	return 0;
-
-err_regulator_disable:
-	regulator_bulk_disable(slot->num_supplies, slot->supplies);
-err_regulator_free:
-	regulator_bulk_free(slot->num_supplies, slot->supplies);
-
-	return ret;
 }
 
 static const struct of_device_id pci_pwrctrl_slot_of_match[] = {
-- 
2.43.0


