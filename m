Return-Path: <linux-pci+bounces-44895-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 408F3D22CF6
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B34153017E7D
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA501327C1D;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coxmmZnX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F30327BE7;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462151; cv=none; b=rNkaGIczbmvECwHFBnGlOzJPDj5Lc0oNx1vK2Q0xD88f2yGn6Q4zycSACy9SZmhs37vjRea9vpB9AScAymsA609fRjWdjIGMfl3QI7MoE71BDlCAEqPncYwvOkIVuGGqIbnOf3HwmddUawyMmQmxli4wGWdeX+KSCg7zlzph7zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462151; c=relaxed/simple;
	bh=3nA72EkIdmKC4EC0a7ioMlai7D1RlpRo3JaSNfWCI+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ISe3qbA5o4GaaUjsKFbzRbC+uQOXOUyrneK7uRx/91MyEgj112fDTEXVdKXsUY0EELtQwvcgz4c8HWSZN3TQJ2QHGKM/zg3cTBBAIZU9ZhqGmxa2fZwqkLj1VVQVwYf0csXeE6fzZ1009Fkq8cJuRv3A/BXHW47cZayZc3aFaCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coxmmZnX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6AD2CC116D0;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=3nA72EkIdmKC4EC0a7ioMlai7D1RlpRo3JaSNfWCI+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=coxmmZnX/Ufzl6IrgZFQfUJlsE/LgSL3ez+FMHzMV9yBLYFxIxUiBbG2tYRuUdpxX
	 /kHmFNGs1Oolm0Bh1NdVoZaBEv/xpudQBQlRsGuDe4S3JR3JE4OieZuHmEpbf8vpxC
	 ywM7OnWF2PlB4kytQRuZDp2zU4g1WbKK5q3bBIP76Fe3uq0w1jeWio61ewEe6MWHTB
	 28rgm1WNqGfv/L3YOd1ErlL98lfwGM7UZaBZtvOV7Gf20kY3aClqHVwkGK8epIavSK
	 7OBw2XZSq/l3qZim1CwJMZ+nV9tQ54M3NKjWkhSVSLxXlo8wShZU2KPnRSS6D7idgj
	 r0kPFnKtdjZAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF4D3CCB8;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:53 +0530
Subject: [PATCH v5 01/15] PCI/pwrctrl: pwrseq: Rename private struct and
 pointers for consistency
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-1-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jpzQnoVwEdcn0ySCaLexwQnNRM8TDWqV0v+/dcDxcw4=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdByf+xDF+rD4QxhDJvBJM/UiPjdQLykBm8t
 VjC+ErqS9CJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9UrPB/9loC6Qt69PW7yqKbaGOnFNC6qSQUxzzSF9zCvCMbCLVADduO5EnZOJ02KdqPefthtD8uX
 +nXOmsZ+AH/Z47dgQY2nUy34ETJpulIaP7kB5zvxnW8H2Fr+DOzHAZRc930H4aV/sY6Wi7LjCQz
 tSnZMbB8uCnL2K82/dBUxfQnJysUUzw6fglcRyJOK9Df3X6zjV0Ny+TUaUDhp38/B1QInE0RaFU
 16Xrl3okhmBLQ6PYHq12KVxOpMolY5fIhSWTMOh/cvRXmPFrC7m3a1WW7Q7G9F4q4DnccmIVDAw
 GTPcjkB50vxtPOBQ+8ZWU92UaP+BpJx09yg4KRG/WBBWTrvH
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the pwrseq, tc9563, and slot pwrctrl drivers used different
naming conventions for their private data structs and pointers to them,
which makes patches hard to read:

  Previous names                         New names
  ------------------------------------   ----------------------------------
  struct pci_pwrctrl_pwrseq_data {       struct pci_pwrctrl_pwrseq {
    struct pci_pwrctrl ctx;                struct pci_pwrctrl pwrctrl;
  struct pci_pwrctrl_pwrseq_data *data   struct pci_pwrctrl_pwrseq *pwrseq

  struct tc9563_pwrctrl_ctx {            struct pci_pwrctrl_tc9563 {
  struct tc9563_pwrctrl_ctx *ctx         struct pci_pwrctrl_tc9563 *tc9563

  struct pci_pwrctrl_slot_data {         struct pci_pwrctrl_slot {
    struct pci_pwrctrl ctx;                struct pci_pwrctrl pwrctrl;
  struct pci_pwrctrl_slot_data *slot     struct pci_pwrctrl_slot *slot

Rename "struct pci_pwrctrl_pwrseq_data" to "pci_pwrctrl_pwrseq".

Rename the "struct pci_pwrctrl ctx" member to "struct pci_pwrctrl pwrctrl".

Rename pointers from "struct pci_pwrctrl_pwrseq_data *data" to
"struct pci_pwrctrl_pwrseq *pwrseq".

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
index 4e664e7b8dd2..c0d22dc3a856 100644
--- a/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
+++ b/drivers/pci/pwrctrl/pci-pwrctrl-pwrseq.c
@@ -13,8 +13,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-struct pci_pwrctrl_pwrseq_data {
-	struct pci_pwrctrl ctx;
+struct pci_pwrctrl_pwrseq {
+	struct pci_pwrctrl pwrctrl;
 	struct pwrseq_desc *pwrseq;
 };
 
@@ -62,7 +62,7 @@ static void devm_pci_pwrctrl_pwrseq_power_off(void *data)
 static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 {
 	const struct pci_pwrctrl_pwrseq_pdata *pdata;
-	struct pci_pwrctrl_pwrseq_data *data;
+	struct pci_pwrctrl_pwrseq *pwrseq;
 	struct device *dev = &pdev->dev;
 	int ret;
 
@@ -76,28 +76,28 @@ static int pci_pwrctrl_pwrseq_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
+	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
+	if (!pwrseq)
 		return -ENOMEM;
 
-	data->pwrseq = devm_pwrseq_get(dev, pdata->target);
-	if (IS_ERR(data->pwrseq))
-		return dev_err_probe(dev, PTR_ERR(data->pwrseq),
+	pwrseq->pwrseq = devm_pwrseq_get(dev, pdata->target);
+	if (IS_ERR(pwrseq->pwrseq))
+		return dev_err_probe(dev, PTR_ERR(pwrseq->pwrseq),
 				     "Failed to get the power sequencer\n");
 
-	ret = pwrseq_power_on(data->pwrseq);
+	ret = pwrseq_power_on(pwrseq->pwrseq);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to power-on the device\n");
 
 	ret = devm_add_action_or_reset(dev, devm_pci_pwrctrl_pwrseq_power_off,
-				       data->pwrseq);
+				       pwrseq->pwrseq);
 	if (ret)
 		return ret;
 
-	pci_pwrctrl_init(&data->ctx, dev);
+	pci_pwrctrl_init(&pwrseq->pwrctrl, dev);
 
-	ret = devm_pci_pwrctrl_device_set_ready(dev, &data->ctx);
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &pwrseq->pwrctrl);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed to register the pwrctrl wrapper\n");

-- 
2.48.1



