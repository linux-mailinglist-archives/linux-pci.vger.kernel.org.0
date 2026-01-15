Return-Path: <linux-pci+bounces-44897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC0D22CF7
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 08:29:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAEEC301EA27
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 07:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D9C32863B;
	Thu, 15 Jan 2026 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXiTE/RL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE8327C0C;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768462151; cv=none; b=OE6zDWaUs7F4Q4Juqdrc4fkNL/NHY1PIHGODA4bpzwxTGmPKA7YuxmP5einE2Nemu2M0ZyiiK2t/ZHJ3ITtYyE2SrzJ0wV5YWC3nWetST6CI+4T4pEJodVLYjrW0mU5GEJEoVK+fL7IB7AhlKXBoU/VUurbWIjmWLsDPLJ1TMRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768462151; c=relaxed/simple;
	bh=MgclwFgqGDcrh+VR4Ax+lEszi4KoIefWcrVpxysOj1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QjnELQw4CzKHOci3eYVvHVrnLXk3j+L8XcVqaVAXD4jzDgSR31prBktlaP3RW/cxtHWdl8VmJNLBSNrH+gzWvPvGLa5LPxjyn+ovlk2eIm5mpJLLTNJgRRxoYrvEt/HEGyS9F9gYAzqTuOC+x0tJqpZ8ptHKU6Gwu03pxOLILZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXiTE/RL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7865AC19423;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768462151;
	bh=MgclwFgqGDcrh+VR4Ax+lEszi4KoIefWcrVpxysOj1A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rXiTE/RL/nEccYL26vxCOYryvIrH1vZYHbhrX91W4VQywKnpzi9jZIDvnvwC7Tnq/
	 vYIWuwwVazIvhDprmFXtfxFsIoTld6SoKgyscV2RbbphClZeNgNyrBK9xBvn+h6ZsE
	 Th3NwO4SQoTDMXLLF+lwREGoDHfBryAaztjJ7QZuVOTONew8FwfIxM06HMToOSUhNQ
	 5kzT+1/sSTxcZuJVK1rO9MREGCVauZlh4iDERIh50eGlPhjf0Z38oWYGsfABAFnAu2
	 JnYk7+SVQns8JnjXqwIGU7jW8aqhCdZe+1ILUgtRTyEvftBPqGK6eQIjEBL2P+deFK
	 axS/5O0vsbujg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AFCD3CCB9;
	Thu, 15 Jan 2026 07:29:11 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Thu, 15 Jan 2026 12:58:54 +0530
Subject: [PATCH v5 02/15] PCI/pwrctrl: slot: Rename private struct and
 pointers for consistency
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pci-pwrctrl-rework-v5-2-9d26da3ce903@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2784;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=44NVPWUXPuZjfLmJawVYZKHEmFFDsDqRXpz45pIkiiE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpaJdBuIQNE5ifaCycNCiMPUkxX8+/GtEeFUCk1
 l5byjks6keJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaWiXQQAKCRBVnxHm/pHO
 9ZR/B/46p6o8wAxDjXi2SM97q9/E2HUBtSnn7zcX4kUMv/K8lHL4AcAN9IqScIvsv3FH0coTVpX
 YST09swQHNq9GRC+U48qNKlXB8AWPU4GBNjXMDM9CuqQGnthgu5CLdvq7bjQJYLvH5G+rGbZtyt
 Pyrr6+cYYVlORSUZQrdlTiEat4r5NeyHJXQi7GZ88mrcVQzXKtJGRqYgqX42iUQo5rUptIERpg6
 1pKuJ62+cx5ylqg+xQaxFf1O+mNFiItwYYw+h7ae/aiNPyj+hffz5qur2mDMBYwl6bvlc3+MH+P
 amHiXxjdYqdMWBC/XwWIqTRnABJpzgc18A58ftXPcHIFzpY/
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

Rename "struct pci_pwrctrl_slot_data" to "struct pci_pwrctrl_slot".

Rename the "struct pci_pwrctrl ctx" member to "struct pci_pwrctrl pwrctrl".

No functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pwrctrl/slot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
index 3320494b62d8..5ddae4ae3431 100644
--- a/drivers/pci/pwrctrl/slot.c
+++ b/drivers/pci/pwrctrl/slot.c
@@ -13,15 +13,15 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 
-struct pci_pwrctrl_slot_data {
-	struct pci_pwrctrl ctx;
+struct pci_pwrctrl_slot {
+	struct pci_pwrctrl pwrctrl;
 	struct regulator_bulk_data *supplies;
 	int num_supplies;
 };
 
 static void devm_pci_pwrctrl_slot_power_off(void *data)
 {
-	struct pci_pwrctrl_slot_data *slot = data;
+	struct pci_pwrctrl_slot *slot = data;
 
 	regulator_bulk_disable(slot->num_supplies, slot->supplies);
 	regulator_bulk_free(slot->num_supplies, slot->supplies);
@@ -29,7 +29,7 @@ static void devm_pci_pwrctrl_slot_power_off(void *data)
 
 static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 {
-	struct pci_pwrctrl_slot_data *slot;
+	struct pci_pwrctrl_slot *slot;
 	struct device *dev = &pdev->dev;
 	struct clk *clk;
 	int ret;
@@ -64,9 +64,9 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
 				     "Failed to enable slot clock\n");
 	}
 
-	pci_pwrctrl_init(&slot->ctx, dev);
+	pci_pwrctrl_init(&slot->pwrctrl, dev);
 
-	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->ctx);
+	ret = devm_pci_pwrctrl_device_set_ready(dev, &slot->pwrctrl);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to register pwrctrl driver\n");
 

-- 
2.48.1



