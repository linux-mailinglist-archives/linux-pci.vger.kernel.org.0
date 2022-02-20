Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBDF4BD109
	for <lists+linux-pci@lfdr.de>; Sun, 20 Feb 2022 20:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244647AbiBTTe4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Feb 2022 14:34:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244649AbiBTTez (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Feb 2022 14:34:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DA6522EE
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 11:34:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05580B80DBE
        for <linux-pci@vger.kernel.org>; Sun, 20 Feb 2022 19:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BF8C340F4;
        Sun, 20 Feb 2022 19:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645385671;
        bh=rWN+zuCR+QaLyNXILzPI7B6HtbipzlDCeGNmUfj9SqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiUXC22uH9eP/yGCkvyXjld9Mkvn2uBOkLrlbBPgdeo/h+1afA6E4PiQndo7uGrQl
         08wBiTDQndfwjn+U10xyiZRuScTrAUzkn9x2SCAWqByDqWwmnX+EndGGRBqkYcZI0U
         0e1iUJv/gy9pQHuH1c4i0kl9h2gv2PV0eeBGhOyaiJMnAKvKiLMz48lA0XMJ9rKYBo
         IxQPvQ36KgByFtUnVxLbURaibRtddxZtHA06UgY4nhoNoG3iDetKaLorrGI0Hn4j+T
         66RIh80pZMqf9SLnTpVAwck47wRpPMTssi39nUV1v04VYjKJ2KZ4rsanjM01Jmgy1x
         jkc5f3RXRvT+A==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, pali@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 17/18] PCI: aardvark: Run link training in separate worker
Date:   Sun, 20 Feb 2022 20:33:45 +0100
Message-Id: <20220220193346.23789-18-kabel@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220220193346.23789-1-kabel@kernel.org>
References: <20220220193346.23789-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Link training and PCIe card reset routines in Aardvark contain several
delays, resulting in rather slow PCIe card probing. The worst case is
when there is no card connected: the driver tries link training at all
possible speeds and waits until all timers expire.

Since probe methods for all system devices are called sequentially, this
results in noticeably longer boot time.

Move card reset and link training code from driver probe function into
a separate worker, so that kernel can do something different while the
driver is waiting during reset or training.

On ESPRESSObin and Turris MOX this decreases boot time by 0.4s with
plugged PCIe card and by 2.2s if no card is connected.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
---
 drivers/pci/controller/pci-aardvark.c | 42 ++++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 8c9ac7766ac7..056f49d0e3a4 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -26,6 +26,7 @@
 #include <linux/of_gpio.h>
 #include <linux/of_pci.h>
 #include <linux/timer.h>
+#include <linux/workqueue.h>
 
 #include "../pci.h"
 #include "../pci-bridge-emul.h"
@@ -296,6 +297,8 @@ struct advk_pcie {
 	int link_gen;
 	bool link_was_up;
 	struct timer_list link_irq_timer;
+	struct delayed_work probe_card_work;
+	bool host_bridge_probed;
 	struct pci_bridge_emul bridge;
 	struct gpio_desc *reset_gpio;
 	struct clk *clk;
@@ -497,6 +500,21 @@ static void advk_pcie_train_link(struct advk_pcie *pcie)
 		dev_err(dev, "link never came up\n");
 }
 
+static void advk_pcie_probe_card_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = container_of(work, struct delayed_work,
+						  work);
+	struct advk_pcie *pcie = container_of(dwork, struct advk_pcie,
+					      probe_card_work);
+	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
+	int ret;
+
+	advk_pcie_train_link(pcie);
+	ret = pci_host_probe(bridge);
+	if (!ret)
+		pcie->host_bridge_probed = true;
+}
+
 /*
  * Set PCIe address window register which could be used for memory
  * mapping.
@@ -701,8 +719,6 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
 	/* Disable remaining PCIe outbound windows */
 	for (i = pcie->wins_count; i < OB_WIN_COUNT; i++)
 		advk_pcie_disable_ob_win(pcie, i);
-
-	advk_pcie_train_link(pcie);
 }
 
 static int advk_pcie_check_pio_status(struct advk_pcie *pcie, bool allow_crs, u32 *val)
@@ -2112,14 +2128,8 @@ static int advk_pcie_probe(struct platform_device *pdev)
 	bridge->ops = &advk_pcie_ops;
 	bridge->map_irq = advk_pcie_map_irq;
 
-	ret = pci_host_probe(bridge);
-	if (ret < 0) {
-		irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
-		advk_pcie_remove_rp_irq_domain(pcie);
-		advk_pcie_remove_msi_irq_domain(pcie);
-		advk_pcie_remove_irq_domain(pcie);
-		return ret;
-	}
+	INIT_DELAYED_WORK(&pcie->probe_card_work, advk_pcie_probe_card_work);
+	schedule_delayed_work(&pcie->probe_card_work, 1);
 
 	return 0;
 }
@@ -2131,11 +2141,15 @@ static int advk_pcie_remove(struct platform_device *pdev)
 	u32 val;
 	int i;
 
+	cancel_delayed_work_sync(&pcie->probe_card_work);
+
 	/* Remove PCI bus with all devices */
-	pci_lock_rescan_remove();
-	pci_stop_root_bus(bridge->bus);
-	pci_remove_root_bus(bridge->bus);
-	pci_unlock_rescan_remove();
+	if (pcie->host_bridge_probed) {
+		pci_lock_rescan_remove();
+		pci_stop_root_bus(bridge->bus);
+		pci_remove_root_bus(bridge->bus);
+		pci_unlock_rescan_remove();
+	}
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering */
 	val = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
-- 
2.34.1

