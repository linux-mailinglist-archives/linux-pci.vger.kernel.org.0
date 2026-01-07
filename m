Return-Path: <linux-pci+bounces-44192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 854C0CFE3CC
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 15:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 670D2302A39A
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 14:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE4331A76;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoKeSMyA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D7330B01;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795086; cv=none; b=QtyDE+H3dDduS9iIN8RPILydLxapXG6zuuZfajjUC6S3q5Eqc7mbj75/jQBQ/gGlcUhy7lJyxxxiPWXSXskgIlZWPOXJZqOdZ0tk5B0v+HGxDqt8RqWfIUF64gfqnFcuVgXx664gS9M322zec2TusFX3OAcs0Xsv5ZW/XiNLEBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795086; c=relaxed/simple;
	bh=eQscC/47e683ky/vp4OYTwJ7BRifRC0MU2/YX8vZom4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XAUIfKMmT6Wop65tXK+NjcI+PW24ATnawggGnOUU8jsnsPFzUkUhhVQ2EGjV5veH6aI20lytAtXOUuSY4Cq3i7EwIILAcWulxwd6py+rH11FxLCQoS6FfXrmC5C1t/zjLQZaqZCEleutxphBYVVXElPLwKeVrDhMl8E0p9JIgUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoKeSMyA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FAF5C4CEF7;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767795086;
	bh=eQscC/47e683ky/vp4OYTwJ7BRifRC0MU2/YX8vZom4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uoKeSMyAaGS/3M2UptxMcSZEk9d/RzsTw9ot9fIW1MmrQVFILPlO0zXsNYW7RSTmX
	 kHlExjt3BdqU13ZfMZ2q1PkOe7WcQXVOLiVb0gaju7Dbv2VMt1rwMagd8z9er5Kf3K
	 3/ZNbBTmtRef24hUn5UuwT1I7mB5D/6iwP5bRD820Dm1O/NuhNqeB5GnCrosTtHVKL
	 3UTpNclzn90UqE5EgzoPS5lQlF1zkBm/QsdTeN8SgnnMZmiUvfQ9HDmMzxg3pUMlci
	 2Oi0to4Jf3YueZPG9Lm6heAusxYkxg7V/9fvk7qwwhlJgRs+SAB/+OMwxJHdNIFUGN
	 i3+Fos9AVx/8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F7CFD648;
	Wed,  7 Jan 2026 14:11:26 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Wed, 07 Jan 2026 19:41:26 +0530
Subject: [PATCH v5 4/5] PCI/pwrctrl: Create pwrctrl device if the graph
 port is found
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-pci-m2-v5-4-8173d8a72641@oss.qualcomm.com>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
In-Reply-To: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1400;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z2MQcMtEDf0+MlOwlvmKClr02SMu0Uf8mDR8S4+Fr7o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpXmmLZq2kb6DM7zBcdz1FY3Cif3hxtq/XSQwI+
 02g1S1XVsOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaV5piwAKCRBVnxHm/pHO
 9YZGB/9hv+uW/q1uV59gnaGWSsqH2KwEbZM5xLBzYu0WLRnzXRK9tq6UiXt8lBZ1XflVAeHLJmO
 Kia1fraxxiXy5mAkL8eZzqT6+FaJ+YP5oh05CunSpjW/DZfmc3q+z1UC8PyHLYe1AZe99/R8/Of
 u2x241hLwkSil9GOKtHKBUZmmbBubq3j90Gcdwg8KpFUAwFLkofcsWdAuczj9QcFO6Y3Rz3+N2F
 9dv33xFcToBS2ijLzADdLDx0k4ciCNfcCRXs2zPUWHKTgTGP+BcdYNWTi4RsRDEf6GCAfEfEwF9
 9V4nuJmUyCQK+MLHwvMhqa9w1nd3udNHlJ/znauE2U7qdTLy
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reply-To: manivannan.sadhasivam@oss.qualcomm.com

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The devicetree node of the PCIe Root Port/Slot could have the graph port
to link the PCIe M.2 connector node. Since the M.2 connectors are modelled
as Power Sequencing devices, they need to be controlled by the pwrctrl
driver as like the Root Port/Slot supplies.

Hence, create the pwrctrl device if the graph port is found in the node.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 41183aed8f5d..cd7efd20a74a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/msi.h>
+#include <linux/of_graph.h>
 #include <linux/of_pci.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
@@ -2585,7 +2586,7 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	 * not. This is decided based on at least one of the power supplies
 	 * being defined in the devicetree node of the device.
 	 */
-	if (!of_pci_supply_present(np)) {
+	if (!of_pci_supply_present(np) && !of_graph_is_present(np)) {
 		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
 		goto err_put_of_node;
 	}

-- 
2.48.1



