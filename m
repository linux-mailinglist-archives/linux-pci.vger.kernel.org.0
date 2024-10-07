Return-Path: <linux-pci+bounces-13922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 041D999237A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 06:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789801F22942
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 04:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3795173501;
	Mon,  7 Oct 2024 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDm/Jb96"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102102AF1B;
	Mon,  7 Oct 2024 04:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728274368; cv=none; b=qw5eRXYHQk6BsfKt+Bky/AtrrZQ0/OFrOnEnS5+5lqV5ls0sgbeCKFycd8YQfBl5GmIcqyy5ZZX/Y4bvYzuqJUW3IFoIp6qmqh7XK9+lFBycTMJl4gIgF+8zQANLHwyRRrjGp7Ne7XGgIlVbLdxugr5OnTs2OHLcKo6hthZxNyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728274368; c=relaxed/simple;
	bh=mg7tQ5KHeQvXnXHQ9fqxsTpUTZBgoStFDRnvXossBYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuaokhRuWvFlDjYveRgh9qOzGE3bEVylP42iZDwxwjVdBhp+dYSWIxkM7rH+Tp2ortJzoBXGRT2q6TlN9/2rKafIDiAO6ICUyQcqKkQMWnSqm6CtrN9ATGWxCOGHfL7JQJCIE/Q6V7Sx/ILCPMOT33JQ4mLSAE+5AonHOgHVovI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDm/Jb96; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2051CC4CED0;
	Mon,  7 Oct 2024 04:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728274367;
	bh=mg7tQ5KHeQvXnXHQ9fqxsTpUTZBgoStFDRnvXossBYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDm/Jb96cY5akeCsymnQsrfII208DE8ciggBFC/LaNODBkjg6dCOUGIFGN7v60SSp
	 VXwvlE/xHnRSLlsuuXEvEhGZ6ye0MWmLz05dRTY71qX34VAM1J+ZtI4qWu36eYq8Ci
	 HbIcQSQG43ZkWhxtfCBh49mUQjH5bmbGzWom5TLzhWYuT2p0iv/kE32zuwB+dJ2vgQ
	 n1/Yob8NaeBegNOEAzyGkZlzYkiTloE5+Sg/9NE+EptO6T+ikb0LaWMhBg90nDkV/9
	 oVuX0qaL4VqUMNDuZIoME0Ey7koWVkGw7AaUOoTgcbLqvEoM2SvDRazW+cMa3aUUne
	 LcW+/vYMkzh/Q==
From: Damien Le Moal <dlemoal@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org
Cc: linux-rockchip@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH v3 12/12] PCI: rockchip-ep: Handle PERST# signal in endpoint mode
Date: Mon,  7 Oct 2024 13:12:18 +0900
Message-ID: <20241007041218.157516-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241007041218.157516-1-dlemoal@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the Rockchip PCIe endpoint controller driver does not handle
PERST# signal, which prevents detecting when link training should
actually be started or if the host reset the device. This however can
be supported using the controller ep_gpio, set as an input GPIO for
endpoint mode.

Modify the endpoint rockchip driver to get the ep_gpio and its
associated interrupt which is serviced using a threaded IRQ with the
function rockchip_pcie_ep_perst_irq_thread() as handler.

This handler function notifies a link down event corresponding to the RC
side asserting the PERST# signal using pci_epc_linkdown() when the gpio
is high. Once the gpio value goes down, corresponding to the RC
de-asserting the PERST# signal, link training is started. The polarity
of the gpio interrupt trigger is changed from high to low after the RC
asserted PERST#, and conversely changed from low to high after the RC
de-asserts PERST#.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/pci/controller/pcie-rockchip-ep.c | 118 +++++++++++++++++++++-
 drivers/pci/controller/pcie-rockchip.c    |  12 +--
 2 files changed, 122 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
index af50432525b4..c70a64c37a56 100644
--- a/drivers/pci/controller/pcie-rockchip-ep.c
+++ b/drivers/pci/controller/pcie-rockchip-ep.c
@@ -18,6 +18,7 @@
 #include <linux/sizes.h>
 #include <linux/workqueue.h>
 #include <linux/iopoll.h>
+#include <linux/gpio/consumer.h>
 
 #include "pcie-rockchip.h"
 
@@ -50,6 +51,9 @@ struct rockchip_pcie_ep {
 	u64			irq_pci_addr;
 	u8			irq_pci_fn;
 	u8			irq_pending;
+	int			perst_irq;
+	bool			perst_asserted;
+	bool			link_up;
 	struct delayed_work	link_training;
 };
 
@@ -462,13 +466,17 @@ static int rockchip_pcie_ep_start(struct pci_epc *epc)
 
 	rockchip_pcie_write(rockchip, cfg, PCIE_CORE_PHY_FUNC_CFG);
 
+	if (rockchip->ep_gpio)
+		enable_irq(ep->perst_irq);
+
 	/* Enable configuration and start link training */
 	rockchip_pcie_write(rockchip,
 			    PCIE_CLIENT_LINK_TRAIN_ENABLE |
 			    PCIE_CLIENT_CONF_ENABLE,
 			    PCIE_CLIENT_CONFIG);
 
-	schedule_delayed_work(&ep->link_training, 0);
+	if (!rockchip->ep_gpio)
+		schedule_delayed_work(&ep->link_training, 0);
 
 	return 0;
 }
@@ -478,6 +486,11 @@ static void rockchip_pcie_ep_stop(struct pci_epc *epc)
 	struct rockchip_pcie_ep *ep = epc_get_drvdata(epc);
 	struct rockchip_pcie *rockchip = &ep->rockchip;
 
+	if (rockchip->ep_gpio) {
+		ep->perst_asserted = true;
+		disable_irq(ep->perst_irq);
+	}
+
 	cancel_delayed_work_sync(&ep->link_training);
 
 	/* Stop link training and disable configuration */
@@ -540,6 +553,13 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 	if (!rockchip_pcie_ep_link_up(rockchip))
 		goto again;
 
+	/*
+	 * If PERST was asserted while polling the link, do not notify
+	 * the function.
+	 */
+	if (ep->perst_asserted)
+		return;
+
 	val = rockchip_pcie_read(rockchip, PCIE_CLIENT_BASIC_STATUS0);
 	dev_info(dev,
 		 "Link UP (Negociated speed: %sGT/s, width: x%lu)\n",
@@ -549,6 +569,7 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 
 	/* Notify the function */
 	pci_epc_linkup(ep->epc);
+	ep->link_up = true;
 
 	return;
 
@@ -556,6 +577,94 @@ static void rockchip_pcie_ep_link_training(struct work_struct *work)
 	schedule_delayed_work(&ep->link_training, msecs_to_jiffies(5));
 }
 
+static void rockchip_pcie_ep_perst_assert(struct rockchip_pcie_ep *ep)
+{
+	struct rockchip_pcie *rockchip = &ep->rockchip;
+	struct device *dev = rockchip->dev;
+
+	dev_dbg(dev, "PERST asserted, link down\n");
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
+	struct device *dev = rockchip->dev;
+
+	dev_dbg(dev, "PERST de-asserted, starting link training\n");
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
+	u32 perst = gpiod_get_value(rockchip->ep_gpio);
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
+	if (!rockchip->ep_gpio)
+		return 0;
+
+	/* PCIe reset interrupt */
+	ep->perst_irq = gpiod_to_irq(rockchip->ep_gpio);
+	if (ep->perst_irq < 0) {
+		dev_err(dev, "No corresponding IRQ for PERST GPIO\n");
+		return ep->perst_irq;
+	}
+
+	ep->perst_asserted = true;
+	irq_set_status_flags(ep->perst_irq, IRQ_NOAUTOEN);
+	ret = devm_request_threaded_irq(dev, ep->perst_irq, NULL,
+					rockchip_pcie_ep_perst_irq_thread,
+					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					"pcie-ep-perst", epc);
+	if (ret) {
+		dev_err(dev, "Request PERST GPIO IRQ failed %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static const struct pci_epc_features rockchip_pcie_epc_features = {
 	.linkup_notifier = true,
 	.msi_capable = true,
@@ -719,6 +828,7 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 	rockchip->is_rc = false;
 	rockchip->dev = dev;
 	INIT_DELAYED_WORK(&ep->link_training, rockchip_pcie_ep_link_training);
+	ep->link_up = false;
 
 	epc = devm_pci_epc_create(dev, &rockchip_pcie_epc_ops);
 	if (IS_ERR(epc)) {
@@ -751,7 +861,13 @@ static int rockchip_pcie_ep_probe(struct platform_device *pdev)
 
 	pci_epc_init_notify(epc);
 
+	err = rockchip_pcie_ep_setup_irq(epc);
+	if (err < 0)
+		goto err_uninit_port;
+
 	return 0;
+err_uninit_port:
+	rockchip_pcie_deinit_phys(rockchip);
 err_release_resources:
 	rockchip_pcie_ep_release_resources(ep);
 err_disable_clocks:
diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
index 154e78819e6e..bcb1c9266c56 100644
--- a/drivers/pci/controller/pcie-rockchip.c
+++ b/drivers/pci/controller/pcie-rockchip.c
@@ -119,13 +119,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
 		return PTR_ERR(rockchip->aclk_rst);
 	}
 
-	if (rockchip->is_rc) {
-		rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
-							    GPIOD_OUT_LOW);
-		if (IS_ERR(rockchip->ep_gpio))
-			return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
-					     "failed to get ep GPIO\n");
-	}
+	rockchip->ep_gpio = devm_gpiod_get_optional(dev, "ep",
+				rockchip->is_rc ? GPIOD_OUT_LOW : GPIOD_IN);
+	if (IS_ERR(rockchip->ep_gpio))
+		return dev_err_probe(dev, PTR_ERR(rockchip->ep_gpio),
+				     "failed to get ep GPIO\n");
 
 	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
 	if (IS_ERR(rockchip->aclk_pcie)) {
-- 
2.46.2


