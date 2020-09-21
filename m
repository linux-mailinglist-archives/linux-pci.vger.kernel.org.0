Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F39271ED4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Sep 2020 11:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIUJWf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Sep 2020 05:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIUJWf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2020 05:22:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A55C061755
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 02:22:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so8755237pfk.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2020 02:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=Txi3hhtu4bbqP/4p/rhA/pNktb+VNJW7dX19v2MTkjU=;
        b=YMR63Tf2c1iVnH5EscYMcJY7J5nLaeJpB4cXlebi7RPrqt4fW97q7z/4/sB4Fi/DCG
         hf/sogP5qzyzKBHJLjBvMVJPhbiUBR0rfNJ1wPNUmU0XrMOh1kxLgmsux2Or9Q+sGKUF
         unBskccIAWIH06iqgDTjbsNfsol4Zjq0AkWvRv9hnYjIzJqodoWF3XIkrMxBoFUicCxw
         ofZH8C8MZ4gaufqIttQf/v9lhoaMlYUtylqi+jCMjpfvgofD4xC1wS72/ltsJRt7M+LW
         Lqad2VOOWS2IxM5QVgndUzNLY3p174bAL94ssp/FVP8wnPFq3QoZmsmeDMKwk8XZKNAg
         7F+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=Txi3hhtu4bbqP/4p/rhA/pNktb+VNJW7dX19v2MTkjU=;
        b=d9ZdKuO3qJ3J5UsPQ7bthMOfxBSllsVpPaXwpgWyaoC2YuTvQHXR6NAUMAmFEVosa7
         +ORxdVwtISqVzV6rgoBS1HvnV7CadBS5vsJLFToDdCLtEwiFKKfx17wHN6RIUsHMvPnn
         lFWqUmTnB4BtlD+K3vjFIv34NMQ73SqcpXdb1toziT0ANkcoze82MqfflxfnZ6Ss/SLe
         IVB5mbGhbUb7kQ/tXdqDJmEbrQBDgHzncr/oSs6tNSHPdjz59X+hiwkbtFTH7s5NQOcz
         zg1TaUdqnFhPd/KoIIWge4tQhFObVWeBJQOzowXllSfpUj2Ir1jt1yNttC70PA8ol0l1
         GRgg==
X-Gm-Message-State: AOAM532gmet1ZuF6JcQh+JZOnxSoPLmPKas6K+iJakrTx26s29kVRowD
        eAvl3pUNWzgKD09sksfQ7AA1mBMHXcCSsw==
X-Google-Smtp-Source: ABdhPJwLbQW3CJpWRt4FrRNOaGp/ca3gapripSpdAVWrO7wtqBjzAJtntljw4N/6iOm8djfr5CsCEw==
X-Received: by 2002:a17:902:7889:b029:d2:26da:7c13 with SMTP id q9-20020a1709027889b02900d226da7c13mr3073568pll.38.1600680154679;
        Mon, 21 Sep 2020 02:22:34 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
        by smtp.gmail.com with ESMTPSA id c24sm11520991pfd.24.2020.09.21.02.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 02:22:34 -0700 (PDT)
Sender: Huacai Chen <chenhuacai@gmail.com>
From:   Huacai Chen <chenhc@lemote.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH] PCI/portdrv: Don't disable pci device during shutdown
Date:   Mon, 21 Sep 2020 17:22:18 +0800
Message-Id: <1600680138-10949-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use separate remove()/shutdown() callback, and don't disable pci device
during shutdown. This can avoid some poweroff/reboot failures.

The poweroff/reboot failures can easily reproduce on Loongson platforms.
I think this is not a Loongson-specific problem, instead, is a problem
related to some specific PCI hosts. On some x86 platforms, radeon/amdgpu
devices can cause the same problem, and commit faefba95c9e8ca3a523831c2e
("drm/amdgpu: just suspend the hw on pci shutdown") can resolve it.

As Tiezhu said, this occasionally shutdown or reboot failure is due to
clear PCI_COMMAND_MASTER on the device in do_pci_disable_device().

drivers/pci/pci.c
static void do_pci_disable_device(struct pci_dev *dev)
{
        u16 pci_command;

        pci_read_config_word(dev, PCI_COMMAND, &pci_command);
        if (pci_command & PCI_COMMAND_MASTER) {
                pci_command &= ~PCI_COMMAND_MASTER;
                pci_write_config_word(dev, PCI_COMMAND, pci_command);
        }

        pcibios_disable_device(dev);
}

When remove "pci_command &= ~PCI_COMMAND_MASTER;", it can work well when
shutdown or reboot. This may implies that there are DMA activities on the
device while shutdown.

Radeon driver is more difficult than amdgpu due to its confusing symbol
names, and I have maintained an out-of-tree patch for a long time [1].
Recently, we found more and more devices can cause the same problem, and
it is very difficult to modify all problematic drivers as radeon/amdgpu
does (the .shutdown callback should make sure there is no DMA activity).
So, I think modify the PCIe port driver is a simple and effective way.
And as early discussed, kexec can still work after this patch.

[1] https://github.com/chenhuacai/linux/commit/6612f9c1fc290d42a14618ce9a7d03014d8ebb1a

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 drivers/pci/pcie/portdrv.h      |  2 +-
 drivers/pci/pcie/portdrv_core.c |  6 ++++--
 drivers/pci/pcie/portdrv_pci.c  | 15 +++++++++++++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index af7cf23..22ba7b9 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -123,7 +123,7 @@ int pcie_port_device_resume(struct device *dev);
 int pcie_port_device_runtime_suspend(struct device *dev);
 int pcie_port_device_runtime_resume(struct device *dev);
 #endif
-void pcie_port_device_remove(struct pci_dev *dev);
+void pcie_port_device_remove(struct pci_dev *dev, bool disable);
 int __must_check pcie_port_bus_register(void);
 void pcie_port_bus_unregister(void);
 
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522..aa165be 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -487,11 +487,13 @@ EXPORT_SYMBOL_GPL(pcie_port_find_device);
  * Remove PCI Express port service devices associated with given port and
  * disable MSI-X or MSI for the port.
  */
-void pcie_port_device_remove(struct pci_dev *dev)
+void pcie_port_device_remove(struct pci_dev *dev, bool disable)
 {
 	device_for_each_child(&dev->dev, NULL, remove_iter);
 	pci_free_irq_vectors(dev);
-	pci_disable_device(dev);
+
+	if (disable)
+		pci_disable_device(dev);
 }
 
 /**
diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3a3ce40..e95c474 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -142,7 +142,18 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
 		pm_runtime_dont_use_autosuspend(&dev->dev);
 	}
 
-	pcie_port_device_remove(dev);
+	pcie_port_device_remove(dev, true);
+}
+
+static void pcie_portdrv_shutdown(struct pci_dev *dev)
+{
+	if (pci_bridge_d3_possible(dev)) {
+		pm_runtime_forbid(&dev->dev);
+		pm_runtime_get_noresume(&dev->dev);
+		pm_runtime_dont_use_autosuspend(&dev->dev);
+	}
+
+	pcie_port_device_remove(dev, false);
 }
 
 static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
@@ -211,7 +222,7 @@ static struct pci_driver pcie_portdriver = {
 
 	.probe		= pcie_portdrv_probe,
 	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.7.0

