Return-Path: <linux-pci+bounces-14717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEF9A1849
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994531C213D0
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 01:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BE236AF5;
	Thu, 17 Oct 2024 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gssfgivM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4632940F;
	Thu, 17 Oct 2024 01:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729130358; cv=none; b=DzG+YWA8cNfSC0K7HDxXa9t2ayqIG3/1E1WnQrQYslR9OvglXkp9zlLW0ycojaZQz6LoXHfGPSp74b4XJxlxH2PvVlRW+ZPTUsKSvJ+xFPzGhHwUj0g6U7zB1Gvnku8Z8UuLZz8e2cAzEBzb3qo2q7XseG6aPvF2YJGjtdUOV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729130358; c=relaxed/simple;
	bh=ueCDGH3nxJnYp5coBf9bjy2Kha4NZeZU4aWU9o3/8W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IZ6qDRNwFoe61DrsRkMFtIfu3w7YCqGEOPyeoJO4cq+nFiaqAlPQAjJEPiSY3Fiae/MkC1Krq5WIn7aqc4ZPPomfL3d/PytC9P+aRypIo5Sfnn+w6XjKa3FrFRIyr6z3iPMzRhXUj9rXza7JE22pHjYVAAgC7HsXm+nZSD4Cifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gssfgivM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F149C4CED0;
	Thu, 17 Oct 2024 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729130358;
	bh=ueCDGH3nxJnYp5coBf9bjy2Kha4NZeZU4aWU9o3/8W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gssfgivM4bDbm2A9irgS5VJIwPmQT2q87K6WLmlpCCPzlixtx3pqZQGtK/G+LsqJp
	 XDvzjYeJjBzwxTYnWOUTZOrG1SVZTxlLfWbMR3VqzvP4yCl7B9/6Jx2cfbbyiVw3X/
	 Hkqq2ZSmZ+jeUEHKjof4xnvFW0vyKOLiFdQj4EgA+V99YziCEwzO+FhkqIzibQRiFg
	 G3o1X4WmYtArLFQrHP21eASAmdvO0hE5J19Pb6cQCho0Xa9oXiqS1hU9gxKpouD3sA
	 ZpXPl+Zzc/THHYDpQAmWqimJm+BdC319vi6KCvD4ziuqGtFPs647+XDAkK+fVDIFAj
	 tsUq+CZ3tM7ng==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v5 13/14] PCI: rockchip-ep: Handle PERST# signal in endpoint mode
Date: Thu, 17 Oct 2024 10:58:48 +0900
Message-ID: <20241017015849.190271-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241017015849.190271-1-dlemoal@kernel.org>
References: <20241017015849.190271-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the Rockchip PCIe endpoint controller driver does not handle
the PERST# signal, which prevents detecting when link training should
actually be started or if the host resets the device. This however can
be supported using the controller reset_gpios property set as an input
GPIO for endpoint mode.

Modify the rockchip PCI endpoint controller driver to get the reset_gpio
and its associated interrupt which is serviced using a threaded IRQ with
the function rockchip_pcie_ep_perst_irq_thread() as handler.

This handler function notifies a link down event corresponding to the RC
side asserting the PERST# signal using pci_epc_linkdown() when the gpio
is high. Once the gpio value goes down, corresponding to the RC
de-asserting the PERST# signal, link training is started. The polarity
of the gpio interrupt trigger is changed from high to low after the RC
asserted PERST#, and conversely changed from low to high after the RC
de-asserts PERST#.

Also, given that the host mode controller and the endpoint mode
controller use two different property names for the same PERST# signal
(ep_gpios property and reset_gpios property respectively), for clarity,
rename the ep_gpio field of struct rockchip_pcie to perst_gpio.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c   | 124 +++++++++++++++++++-
 drivers/pci/controller/pcie-rockchip-host.c |   4 +-
 drivers/pci/controller/pcie-rockchip.c      |  16 +--
 drivers/pci/controller/pcie-rockchip.h      |   2 +-
 4 files changed, 133 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index 43480706b8f4..19cfba5230a2 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -10,6 +10,7 @@
 
 #include <linux/configfs.h>
 #include <linux/delay.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
@@ -50,6 +51,9 @@ struct rockchip_pcie_ep {
 	u64			irq_pci_addr;
 	u8			irq_pci_fn;
 	u8			irq_pending;
+	int			perst_irq;
+	bool			perst_asserted;
+	bool			link_up;
 	struct delayed_work	link_training;
 };
 
@@ -467,13 +471,17 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 
 	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
 
+	if (rockchip->perst_gpio)
+		enable_irq(ep->perst_irq);
+
 	/* Enable configuration and start link training */
 	rockchip_pcie_write(rockchip,
 			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
 			    PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	schedule_delayed_work(&ep->link_training, 0);
+	if (!rockchip->perst_gpio)
+		schedule_delayed_work(&ep->link_training, 0);
 
 	return 0;
 }
@@ -483,6 +491,11 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
+	if (rockchip->perst_gpio) {
+		ep->perst_asserted = true;
+		disable_irq(ep->perst_irq);
+	}
+
 	cancel_delayed_work_sync(&ep->link_training);
 
 	/* Stop link training and disable configuration */
@@ -548,6 +561,13 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 	if (!rockchip_pcie_ep_link_up(rockchip))
 		goto again;
 
+	/*
+	 * If PERST# was asserted while polling the link, do not notify
+	 * the function.
+	 */
+	if (ep->perst_asserted)
+		return;
+
 	val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS0);
 	dev_info(dev,
 		 "Link UP (Negotiated speed: %sGT/s, width: x%lu)\n",
@@ -557,6 +577,7 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 
 	/* Notify the function */
 	pci_epc_linkup(ep->epc);
+	ep->link_up = true;
 
 	return;
 
@@ -564,6 +585,97 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 	schedule_delayed_work(&ep->link_training, msecs_to_jiffies(5));
 }
 
+static void rockchip_pcie_ep_perst_assert(struct rockchip_pcie_ep *ep)
+{
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+
+	dev_dbg(rockchip->dev, "PERST# asserted, link down\n");
+
+	if (ep->perst_asserted)
+		return;
+
+	ep->perst_asserted = true;
+
+	cancel_delayed_work_sync(&ep->link_training);
+
+	if (ep->link_up) {
+		pci_epc_linkdown(ep->epc);
+		ep->link_up = false;
+	}
+}
+
+static void rockchip_pcie_ep_perst_deassert(struct rockchip_pcie_ep *ep)
+{
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+
+	dev_dbg(rockchip->dev, "PERST# de-asserted, starting link training\n");
+
+	if (!ep->perst_asserted)
+		return;
+
+	ep->perst_asserted = false;
+
+	/* Enable link re-training */
+	rockchip_pcie_ep_retrain_link(rockchip);
+
+	/* Start link training */
+	schedule_delayed_work(&ep->link_training, 0);
+}
+
+static irqreturn_t rockchip_pcie_ep_perst_irq_thread(int irq, void *data)
+{
+	struct pci_epc *epc = data;
+	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+	u32 perst = gpiod_get_value(rockchip->perst_gpio);
+
+	if (perst)
+		rockchip_pcie_ep_perst_assert(ep);
+	else
+		rockchip_pcie_ep_perst_deassert(ep);
+
+	irq_set_irq_type(ep->perst_irq,
+			 (perst ? IRQF_TRIGGER_HIGH : IRQF_TRIGGER_LOW));
+
+	return IRQ_HANDLED;
+}
+
+static int rockchip_pcie_ep_setup_irq(struct pci_epc *epc)
+{
+	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+	struct device *dev = rockchip->dev;
+	int ret;
+
+	if (!rockchip->perst_gpio)
+		return 0;
+
+	/* PCIe reset interrupt */
+	ep->perst_irq = gpiod_to_irq(rockchip->perst_gpio);
+	if (ep->perst_irq < 0) {
+		dev_err(dev, "No IRQ for PERST# GPIO\n");
+		return ep->perst_irq;
+	}
+
+	/*
+	 * The perst_gpio is active low, so when it is inactive on start, it
+	 * is high and will trigger the perst_irq handler. So treat this initial
+	 * IRQ as a dummy one by faking the host asserting PERST#.
+	 */
+	ep->perst_asserted = true;
+	irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
+					rockchip_pcie_ep_perst_irq_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"pcie-ep-perst", epc);
+	if (ret) {
+		dev_err(dev, "Request PERST# GPIO IRQ failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
@@ -757,11 +869,17 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	pci_epc_init_notify(epc);
 
+	err = rockchip_pcie_ep_setup_irq(epc);
+	if (err < 0)
+		goto err_uninit_port;
+
 	return 0;
-err_exit_ob_mem:
-	rockchip_pcie_ep_exit_ob_mem(ep);
+err_uninit_port:
+	rockchip_pcie_deinit_phys(rockchip);
 err_disable_clocks:
 	rockchip_pcie_disable_clocks(rockchip);
+err_exit_ob_mem:
+	rockchip_pcie_ep_exit_ob_mem(ep);
 	return err;
 }
 
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index cbec71114825..7471d9fd18bc 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -294,7 +294,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 	int err, i = MAX_LANE_NUM;
 	u32 status;
 
-	gpiod_set_value_cansleep(rockchip->ep_gpio, 0);
+	gpiod_set_value_cansleep(rockchip->perst_gpio, 0);
 
 	err = rockchip_pcie_init_port(rockchip);
 	if (err)
@@ -323,7 +323,7 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 			    PCIE_CLIENT_CONFIG);
 
 	msleep(PCIE_T_PVPERL_MS);
-	gpiod_set_value_cansleep(rockchip->ep_gpio, 1);
+	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_T_RRS_READY_MS);
 
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 154e78819e6e..b9ade7632e11 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -119,13 +119,15 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return PTR_ERR(rockchip->aclk_rst);
 	}
 
-	if (rockchip->is_rc) {
-		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
-							    GPIOD_OUT_LOW);
-		if (IS_ERR(rockchip->ep_gpio))
-			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
-					     "failed to get ep GPIO\n");
-	}
+	if (rockchip->is_rc)
+		rockchip->perst_gpio = devm_gpiod_get_optional(dev, "ep",
+							       GPIOD_OUT_LOW);
+	else
+		rockchip->perst_gpio = devm_gpiod_get_optional(dev, "reset",
+							       GPIOD_IN);
+	if (IS_ERR(rockchip->perst_gpio))
+		return dev_err_probe(dev, PTR_ERR(rockchip->perst_gpio),
+				     "failed to get PERST# GPIO\n");
 
 	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
 	if (IS_ERR(rockchip->aclk_pcie)) {
diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
index 24796176f658..a51b087ce878 100644
--- a/drivers/pci/controller/pcie-rockchip.h
+++ b/drivers/pci/controller/pcie-rockchip.h
@@ -329,7 +329,7 @@ struct rockchip_pcie {
 	struct	regulator *vpcie3v3; /* 3.3V power supply */
 	struct	regulator *vpcie1v8; /* 1.8V power supply */
 	struct	regulator *vpcie0v9; /* 0.9V power supply */
-	struct	gpio_desc *ep_gpio;
+	struct	gpio_desc *perst_gpio;
 	u32	lanes;
 	u8      lanes_map;
 	int	link_gen;
-- 
2.47.0


