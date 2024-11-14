Return-Path: <linux-pci+bounces-16761-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE7D9C8CC0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 15:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541622870E2
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2024 14:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D045F2EAE5;
	Thu, 14 Nov 2024 14:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8rxRcd5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAF11D6AA;
	Thu, 14 Nov 2024 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594057; cv=none; b=J7T9JtAQfpRRBwyf1wI/diwdINaCEBJHEs0pTIEPeLAumhzhDps1kjfu6uW78UagNdCjSG9qDLT+t+W5ROwlNDR2vpZMJGgyFzwfLUQRfbYuAw9Veu7UC1/Y31tbz53zBz91vHvJGf0et3pvqTANwjHjemoDsSRdc/crjVIuFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594057; c=relaxed/simple;
	bh=6yIvZ0pCo5aclXx1uWNQvdqp1zKxk9m+lFaAMtMPHFU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rvmJcywyW5yF2jmRRntDsjzdSKcHQ+7av5wsOqKoIqXrKXqrWpevmqiytbifTnpUFIABTwnbz2xT/zSHKDAl3Q3vdXNwMZuQlqpOXjKLszgrummtCebEXImfHDE9UqTuxEetb5mOc7q5cob1kUZ1ZItSS7WBDbYmJHvulVj+Z7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8rxRcd5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731594051; x=1763130051;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6yIvZ0pCo5aclXx1uWNQvdqp1zKxk9m+lFaAMtMPHFU=;
  b=X8rxRcd5psfKNlMV87FRVhisOiH97aYF3itADOvxHxvWfl3o+CJ2kdSx
   yDVKmuhqAgQkWG/3g4Aj9TzUQP4hBLFMSkT4s3aWFxirQkg/ZpbQS1vTH
   aB+GVD4ReL4yYAzYv6it4k4N3OkivfcCm5QZB6c+XIhyuYd24sddaAzTq
   QGO7nY5gwOWl+0+VAu4NOXL7tpY34dwqlUqNF4XyG9WCpJkVOY+lCcRpm
   cOPYe8t41vNDlySnNSnmP1D7ebSUSwZQLBHiGyiBRb54LGfs3FKwtzhIy
   ss1xj+XQsQGJ3yv11dd46m+CP2R3Uy3yLjNqDxeR5pbE0AGDANYi+1sUz
   A==;
X-CSE-ConnectionGUID: 8PSWhxnbTQGRK5qsl2UOzw==
X-CSE-MsgGUID: +utuqENSRVuvzXVAbM/f9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="42921023"
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="42921023"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:20:49 -0800
X-CSE-ConnectionGUID: pzrmDZIVSL25KYVnv+9KxQ==
X-CSE-MsgGUID: CJcl3d2pR3qwVVEtwRMkZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,154,1728975600"; 
   d="scan'208";a="92279339"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 06:20:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Stefan Wahren <wahrenst@gmx.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI/PME+pciehp: Request IRQF_ONESHOT because bwctrl shares IRQ
Date: Thu, 14 Nov 2024 16:20:34 +0200
Message-Id: <20241114142034.4388-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

PCIe BW controller uses IRQF_ONESHOT to solve the problem fixed by the
commit 3e82a7f9031f ("PCI/LINK: Supply IRQ handler so level-triggered
IRQs are acked"). The IRQ is shared with PME and PCIe hotplug. Due to
probe order, PME and hotplug can request IRQ first without IRQF_ONESHOT
and when BW controller requests IRQ later with IRQF_ONESHOT, the IRQ
request fails. The problem is seen at least on Rasperry Pi 4:

pcieport 0000:00:00.0: PME: Signaling with IRQ 39
pcieport 0000:00:00.0: AER: enabled with IRQ 39
genirq: Flags mismatch irq 39. 00002084 (PCIe bwctrl) vs.00200084 (PCIe PME)
pcie_bwctrl 0000:00:00.0:pcie010: probe with driver pcie_bwctrl failed with error -16

BW controller is always enabled so change PME and pciehp too to use
IRQF_ONESHOT.

Fixes: 470b218c2bdf ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Reported-by: Stefan Wahren <wahrenst@gmx.net>
Link: https://lore.kernel.org/linux-pci/dcd660fd-a265-4f47-8696-776a85e097a0@gmx.net/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 3 ++-
 drivers/pci/pcie/pme.c           | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 736ad8baa2a5..0778305cff9d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -68,7 +68,8 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 
 	/* Installs the interrupt handler */
 	retval = request_threaded_irq(irq, pciehp_isr, pciehp_ist,
-				      IRQF_SHARED, "pciehp", ctrl);
+				      IRQF_SHARED | IRQF_ONESHOT,
+				      "pciehp", ctrl);
 	if (retval)
 		ctrl_err(ctrl, "Cannot get irq %d for the hotplug controller\n",
 			 irq);
diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
index a2daebd9806c..04f0e5a7b74c 100644
--- a/drivers/pci/pcie/pme.c
+++ b/drivers/pci/pcie/pme.c
@@ -347,7 +347,8 @@ static int pcie_pme_probe(struct pcie_device *srv)
 	pcie_pme_interrupt_enable(port, false);
 	pcie_clear_root_pme_status(port);
 
-	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
+	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED | IRQF_ONESHOT,
+			  "PCIe PME", srv);
 	if (ret) {
 		kfree(data);
 		return ret;
-- 
2.39.5


