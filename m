Return-Path: <linux-pci+bounces-22726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E469DA4B627
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 03:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05B1F16C058
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 02:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067F017CA17;
	Mon,  3 Mar 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bGOhlaWD"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447DF156F3C;
	Mon,  3 Mar 2025 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740969403; cv=none; b=b/Bm23s4kIPxBk+mNHUbAeLZvYGwMuszRBTbEMFP5immDqnwU3oerEDXbQNHVEXq71TIz3o+T5vF5jh2FhpvqpoZPvCOHtYZ/VdktZvC3wa78VlngthiaQIFQhXD0oZ6NL19MurT0/bayRFZvWG/EkbwPTwj181gUu6cRWzjTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740969403; c=relaxed/simple;
	bh=M56HOdbk7fOvLcwr6VtdIdQR9HW/dzPBnuWRCD+7DxU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AYpDV3gE/yUcnojmTX7yG8l20+OJWPY97rPtw4hLSXq63sar7pllzOGnxyWg+D0+yaSdFdpEHj8R7M+pmlWtMPcDTVLONZuvpfG4aJrZ7QNkEZpGcTyruk4JpZYbjvomw0/QeaUy07P12n36qi0QyOq4fx1YTmrpQdygZQ0c0yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bGOhlaWD; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740969392; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OXCxkZx+mt9AWYAA7LJCJ64FJAxPbj3evdXmzH2nEWs=;
	b=bGOhlaWDpyoeAHFjDZMgL73cPJIfu1SdrK5vrDUi1snn8pRj6z6IVty3+o8FrJaGUeCgZy4ANlSXnyD3WsOESzeHvV1Ce7ymYp4nldn1ULNKCp6q2qJ301oA1bh/uqalq7qFYhwCrXU+Ck900lchli4yYHMNfRMz3vRMAgH2RuI=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WQWfs.u_1740969391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 03 Mar 2025 10:36:31 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Liguang Zhang <zhangliguang@linux.alibaba.com>,
	Guanghui Feng <guanghuifeng@linux.alibaba.com>,
	rafael@kernel.org
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v4] PCI/portdrv: Only disable hotplug interrupts early when needed.
Date: Mon,  3 Mar 2025 10:36:30 +0800
Message-Id: <20250303023630.78397-1-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was problem reported by firmware developers that they received
two PCIe hotplug commands in very short intervals on an ARM server,
which doesn't comply with PCIe spec, and broke their state machine and
work flow. According to PCIe 6.1 spec, section 6.7.3.2, software needs
to wait at least 1 second for the command-complete event, before
resending the command or sending a new command.

In the failure case, the first PCIe hotplug command firmware received
is from get_port_device_capability(), which sends command to disable
PCIe hotplug interrupts without waiting for its completion, and the
second command comes from pcie_enable_notification() of pciehp driver,
which enables hotplug interrupts again.

One solution is to add the necessary delay after the first command [1],
while Lukas proposed an optimization that if the pciehp driver will be
loaded soon and handle the interrupts, then the hotplug and the wait
are not needed and can be saved, for every root port.

So fix it by only disabling the hotplug interrupts when pciehp driver
is not enabled.

[1]. https://lore.kernel.org/lkml/20250224034500.23024-1-feng.tang@linux.alibaba.com/t/#u

Fixes: 2bd50dd800b5 ("PCI: PCIe: Disable PCIe port services during port initialization")
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
---
Changelog:

  since v3:
    * Separate this patch from patches dealing with irq storm in nomsi case
    * Take Lukas's suggestion (Lukas Wunner)  

  since v2:
    * Add patch 0001, which move the waiting logic of pcie_poll_cmd from pciehp
      driver to PCIe port driver for code reuse (Bjorn Helgaas)
    * Separate Lucas' suggestion out as patch 0003 (Bjorn and Sathyanarayanan)  
    * Avoid hotplug command waiting for HW without command-complete
      event support (Bjorn Helgaas)
    * Fix spell issue in commit log (Bjorn and Markus)
    * Add cover-letter for whole patchset (Markus Elfring)
    * Handle a set-but-unused build warning (0Day lkp bot)

  since v1:
    * Add the Originally-by for Liguang for patch 0002. The issue was found on
      a 5.10 kernel, then 6.6. I was initially given a 5.10 kernel tar ball
      without git info to debug the issue, and made the patch. Thanks to Guanghui
      who recently pointed me to tree https://gitee.com/anolis/cloud-kernel which
      show the wait logic in 5.10 was originally from Liguang, and never hit
      mainline.
    * Make the irq disabling not dependent on wthether pciehp service driver
      will be loaded (Lukas Wunner) 
    * Use read_poll_timeout() API to simply the waiting logic (Sathyanarayanan
      Kuppuswamy)
    * Fix wrong email address (Markus Elfring)
    * Add logic to skip irq disabling if it is already disabled.


 drivers/pci/pcie/portdrv.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 02e73099bad0..e8318fd5f6ed 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -228,10 +228,12 @@ static int get_port_device_capability(struct pci_dev *dev)
 
 		/*
 		 * Disable hot-plug interrupts in case they have been enabled
-		 * by the BIOS and the hot-plug service driver is not loaded.
+		 * by the BIOS and the hot-plug service driver won't be loaded
+		 * to handle them.
 		 */
-		pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
-			  PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
+		if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
+			pcie_capability_clear_word(dev, PCI_EXP_SLTCTL,
+				PCI_EXP_SLTCTL_CCIE | PCI_EXP_SLTCTL_HPIE);
 	}
 
 #ifdef CONFIG_PCIEAER
-- 
2.43.5


