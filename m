Return-Path: <linux-pci+bounces-28942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35E8ACD9FC
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 10:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846113A3848
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 08:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C4F284B56;
	Wed,  4 Jun 2025 08:38:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB64E283FE5;
	Wed,  4 Jun 2025 08:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749026324; cv=none; b=UcmmDRXQPGX5rRNvKtLYjBOuoSBUXgB95KwDRVkm+QtzuOqchu1eY6jaUJf4OZTH7+NHEoJ87gJ6m/trbv3tE24YVEoJbrvP8RE8bG9DBCZBSyBQDpn7HOXy6K0kFLM9QuQtzDnd6GuIk5T5g3TciGkemYbVeYN3HBdx5iGAuwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749026324; c=relaxed/simple;
	bh=gqLEDFktIoSYIz8bzKPHMnziu/I9mkHrdvk28bBExfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p/LontZ70KfBF/eAz11w+IVAhaZjR7gqzgDYp/oX8oxEF3KaSq/eBLIQXnLrrt6FtnvgBVglf/VMJ2lJ25W4iiaKrYeO4mIvY3DVBRxtpJT3Re+WRfI9Gu/J2JvhWuRyk8ljHnHawHjFmmi92UKoQoqdcwOESKLFh7X82qqtcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 989DCC4CEE7;
	Wed,  4 Jun 2025 08:38:41 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure
Date: Wed,  4 Jun 2025 10:38:33 +0200
Message-ID: <f60c445e965ba309f08c33de78bd62f358e68cd0.1749025687.git.geert+renesas@glider.be>
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
---
Compile-tested only.
---
 drivers/pci/pwrctrl/slot.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 18becc144913e047..26b21746da50baa4 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -47,13 +47,14 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
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
 
 	pci_pwrctrl_init(&slot->ctx, dev);
 
@@ -62,13 +63,6 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
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


