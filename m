Return-Path: <linux-pci+bounces-19625-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DFFA0925A
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C837D1693F3
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860FA20E6F6;
	Fri, 10 Jan 2025 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CGHVal+M"
X-Original-To: linux-pci@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B3720E6FD;
	Fri, 10 Jan 2025 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736516678; cv=none; b=lpHoU53wjnSCEinfANwQkcpsk25eH5XmYzWynwQ592LDvQa4/Jo/ijMuKafTY6qeJNAeD5al1eYQ2b6mJGFf5qGFP0roi/1NzbXK1AIaiiodaWbfeFgLNk8bD/p/62C/D/FHwcOqCCdiPolQCtTCIP+POwhXmcPJfXGj1HozFlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736516678; c=relaxed/simple;
	bh=zcQi3cuOjY7oReka/rBrEqA89SqAZdFQ6huk/mtxaEQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=f0OI0NLvKVDSsgL/RUwt/SRrChD6TbwzOvtC/E81n3eM1ddQTDKVtNrF1NkiGLfiJUrEzW5kOfhMPxUA7eOsG23g3GtrCRL6lAHXCvl6b6Lb1odjLO1lTvvzuetdKXjbq4h74VuaAmdagFLFeILyE6rmkDcmuMl1lVOEjhXuH/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CGHVal+M; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736516652; bh=P6tCNUHde1VgBvC9lRDHDfls7Ec2MDCLShQjnJL9+A4=;
	h=From:To:Cc:Subject:Date;
	b=CGHVal+Mn5xZ+AFsWRMn2NB5S/yd67B6w+BDub/EhpWpEvVUGNB/vRYPali1GhmLK
	 KfQ7/g3sz73yCLs9qWxnRzRaZFQUxMag293lnfxR3kmO1QbtzgeElBYM8yBpJE6nK6
	 LpCWQ/8HCx/uaBQF1aO5JB5vQYGMx+cGSl93G8Xk=
Received: from jiwei-VirtualBox.lenovo.com ([120.244.62.107])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id B0917AA7; Fri, 10 Jan 2025 21:44:09 +0800
X-QQ-mid: xmsmtpt1736516649tiqcnmc0i
Message-ID: <tencent_B9290375427BDF73A2DC855F50397CC9FA08@qq.com>
X-QQ-XMAILINFO: NHgT31LhP5vDVpQVMa1QnVviXB6yxDexdxjEMrfVy/qUCxjbm/I8heaHhEWOP4
	 +Bj9y/FS18EVNdUBsNiTszpl8Y0rhWgUuVxJNewzD3kI7fGWR1917aY4EZ6RlVvPMbapiHToQDDY
	 2lclmMHcDHzJO9aLsNzLS/MfgxkWhLFTmaj3Artokq5VJfzJd3rQNgxio9j/6xygDrbLvoMXYJuf
	 xNY4RzlRzhTvboEqzSCH3UCRL0H2x/eMMU9muGBmqtUMog23+yiONs8t8v4mV2GnMYOjGQFGm0i9
	 U0oMn6VfLWxIRWlBgrsrxbUZ2Jzzhfi4RJaIL1zPt9i0iyGLPpuCHpQEvGFfpkMYRHHvxPEeJnRR
	 BzUSZ9xwY9IvRtidNIpsjyYh601VWvSmFwel5eOC75WoY+M1NwYJ9HjRHlrSmy+RhADVwHAhvPPW
	 MKGXDDYxQIeD4QVC03BYhnGzQQRZGqET3VE4BRjDHS+Snk8VM2YAGe93mF4O3Dv9u+wURgo4NjZH
	 7Kda7ZW3iATiFVQSeGA1hw4KTZsRgD5/VBampea6o27YNtuhUVry0x3TaQ+IEbrJyu5Z+woWeokZ
	 tzNbJHqbfIGYbPaOspmDNyra682+nHrsyRBik7+ZgErWNWQxSAS4vsXNweI47EBfknURy2BmqXEo
	 njRUVAXOt+MDiJ0/lFdIzsc2p9fJSnbKMN1+xrT6GUPs8EI9Vp8Z5HkJNbnkXL5kRVgtbnyc2LIo
	 H0mdVhKbNpO8NgITHn2jpEnL3KL2AYoD/sdsZ1YWGh8CTarWKXISqve0esYGIqCkhlPy+4buFhRm
	 7PzWqy9wQMgAYRRJRyMw5X28KZDKU9Ggg23jiHlAM3a4t9R9gFiRKuiLAFNt14Wa0Njp7U9HCyOO
	 r3CU2XJp7lpNFCDUqZE6C6xgBcBjHQ5QXbK4Jx7pwmbHjHx2qVopSmt9la5tCH/NcoWydTnpXBWp
	 YYCHygMHkscX9Y/sfNWL3bK4pJR3+1OFuYoTZ5N3A3rK5ZFrb0krSiInLhEa8e6d4/pYreplFeXk
	 TD07XAtqX+il3dpVmlsSwxszVozUZanSQpsdzii88wxi6dYtmvxPk7EiVsGGsvX0qSy4wvKWhtiz
	 ktIw0cGkIa8TNASM1IdVb8PdJj33VNwlIucHVL
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jiwei Sun <jiwei.sun.bj@qq.com>
To: macro@orcam.me.uk,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guojinhui.liam@bytedance.com,
	helgaas@kernel.org,
	lukas@wunner.de,
	ahuang12@lenovo.com,
	sunjw10@lenovo.com,
	jiwei.sun.bj@qq.com
Subject: [PATCH 2/2] PCI: Fix the PCIe bridge decreasing to Gen 1 during hotplug testing
Date: Fri, 10 Jan 2025 21:44:01 +0800
X-OQ-MSGID: <20250110134401.34536-1-jiwei.sun.bj@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiwei Sun <sunjw10@lenovo.com>

When we do the quick hot-add/hot-remove test (within 1 second) with a PCIE
Gen 5 NVMe disk, there is a possibility that the PCIe bridge will decrease
to 2.5GT/s from 32GT/s

pcieport 10002:00:04.0: pciehp: Slot(75): Link Down
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
...
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: broken device, retraining non-functional downstream link at 2.5GT/s
pcieport 10002:00:04.0: pciehp: Slot(75): No link
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): Link Up
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pcieport 10002:00:04.0: pciehp: Slot(75): No device found
pcieport 10002:00:04.0: pciehp: Slot(75): Card present
pci 10002:02:00.0: [144d:a826] type 00 class 0x010802 PCIe Endpoint
pci 10002:02:00.0: BAR 0 [mem 0x00000000-0x00007fff 64bit]
pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x00007fff 64bit]
pci 10002:02:00.0: VF BAR 0 [mem 0x00000000-0x001fffff 64bit]: contains BAR 0 for 64 VFs
pci 10002:02:00.0: 8.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x4 link at 10002:00:04.0 (capable of 126.028 Gb/s with 32.0 GT/s PCIe x4 link)

If a NVMe disk is hot removed, the pciehp interrupt will be triggered, and
the kernel thread pciehp_ist will be woken up, the
pcie_failed_link_retrain() will be called as the following call trace.

   irq/87-pciehp-2524    [121] ..... 152046.006765: pcie_failed_link_retrain <-pcie_wait_for_link
   irq/87-pciehp-2524    [121] ..... 152046.006782: <stack trace>
 => [FTRACE TRAMPOLINE]
 => pcie_failed_link_retrain
 => pcie_wait_for_link
 => pciehp_check_link_status
 => pciehp_enable_slot
 => pciehp_handle_presence_or_link_change
 => pciehp_ist
 => irq_thread_fn
 => irq_thread
 => kthread
 => ret_from_fork
 => ret_from_fork_asm

Accorind to investigation, the issue is caused by the following scenerios,

NVMe disk	pciehp hardirq
hot-remove 	top-half		pciehp irq kernel thread
======================================================================
pciehp hardirq
will be triggered
	    	cpu handle pciehp
		hardirq
		pciehp irq kthread will
		be woken up
					pciehp_ist
					...
					  pcie_failed_link_retrain
					    read PCI_EXP_LNKCTL2 register
					    read PCI_EXP_LNKSTA register
If NVMe disk
hot-add before
calling pcie_retrain_link()
					    set target speed to 2_5GT
					      pcie_bwctrl_change_speed
	  				        pcie_retrain_link
						: the retrain work will be
						  successful, because
						  pci_match_id() will be
						  0 in
						  pcie_failed_link_retrain()
						  the target link speed
						  field of the Link Control
						  2 Register will keep 0x1.

In order to fix the issue, don't do the retraining work except ASMedia
ASM2824.

Fixes: a89c82249c37 ("PCI: Work around PCIe link training failures")
Reported-by: Adrian Huang <ahuang12@lenovo.com>
Signed-off-by: Jiwei Sun <sunjw10@lenovo.com>
---
 drivers/pci/quirks.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 605628c810a5..ff04ebd9ae16 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -104,6 +104,9 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	u16 lnksta, lnkctl2;
 	int ret = -ENOTTY;
 
+	if (!pci_match_id(ids, dev))
+		return 0;
+
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
 		return ret;
@@ -129,8 +132,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	}
 
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
+	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		u32 lnkcap;
 
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-- 
2.34.1


