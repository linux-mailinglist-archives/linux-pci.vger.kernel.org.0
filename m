Return-Path: <linux-pci+bounces-23638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCFDA5F7E7
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 15:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B565D19C3D8B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B588267B9A;
	Thu, 13 Mar 2025 14:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ynl62L1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707711CA9;
	Thu, 13 Mar 2025 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875842; cv=none; b=kgGphikvM0McSxqh6p/k0Afsb5ibCQGqjlr6IwgTBeqZ5wslx5ZWmZa3R+ur/ybwg5TqRb7N0+BakrNwyLkK6HS0kKfs3ElTjSdabElbUgoDnwQqbDffmVHrAeksdfR0oLLwU9isFP9rcU2w7mLDqG445ZMLp9xE3stkHljQ4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875842; c=relaxed/simple;
	bh=NXrvr52QEd3dyKE2/9JNvYBGy5hL4EsZu3YzjUhsF18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwLZ3GzPDVjtePkh0MYfoLcMAOMr7tlpgPY7I1rjz2A2G/e7KoTVpFR5AdtpaXl2FiARs4n6GkbeKqGRj3KeAgcrYGkkeW8NqsK1WuINQK+VbcT3C6DxCaTkYEZaYaMigoWjfvu1Yvbn7yXrz5O47FOYZIIndh2EUcKRdAxZIC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ynl62L1E; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741875841; x=1773411841;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NXrvr52QEd3dyKE2/9JNvYBGy5hL4EsZu3YzjUhsF18=;
  b=Ynl62L1EIgO6BSaU4fpdYEIV0PNn2DGoHKxKmBlLU9m13XA9ig/57Wy6
   B8IN35RNtiKrEwYv8cyt+CiU8+sZxZMt3GwCopTn3GSM1APexqUgzZO2l
   qw54rmx0KPzvS2j4vvZ45vifsIGFfrbb2h4guPlfLQ+PebLAIKQ1a6LVU
   Fg5JRDKSOfFQyu6TB+iWkeXCqdzOBNRz9ujqys/1jXbl3uIA3ttm+ab/C
   Pr0zHZyQBnpcPopJuY42/Ct6RYEiZwJc5oO9/4mIHFe0RNcXgK05ysi6G
   vIpjqlpgh3Z4LzNN9BOMMhUVFGwyZLPrDraJf8uGMSP2yHmFS6GzVO9Z2
   Q==;
X-CSE-ConnectionGUID: bSwQb52TRFGtx2KyqkMfeg==
X-CSE-MsgGUID: kJcWo0FjS5eIKL+p259m2Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11372"; a="43173531"
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="43173531"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:24:00 -0700
X-CSE-ConnectionGUID: QyeUm5j9ScGBX6OqHrYN1A==
X-CSE-MsgGUID: voJxlvFeQKuZRkp8hdJhaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,244,1736841600"; 
   d="scan'208";a="126027318"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.195])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 07:23:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Guenter Roeck <groeck@juniper.net>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/4] PCI/hotplug: Disable HPIE over reset
Date: Thu, 13 Mar 2025 16:23:30 +0200
Message-Id: <20250313142333.5792-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
References: <20250313142333.5792-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pciehp_reset_slot() disables PDCE (Presence Detect Changed Enable) and
DLLSCE (Data Link Layer State Changed Enable) for the duration of reset
and clears the related status bits PDC and DLLSC from the Slot Status
register after the reset to avoid hotplug incorrectly assuming the card
was removed.

However, hotplug shares interrupt with PME and BW notifications both of
which can make pciehp_isr() to run despite PDCE and DLLSCE bits being
off. pciehp_isr() then picks PDC or DLLSC bits from the Slot Status
register due to the events that occur during reset and caches them into
->pending_events. Later, the IRQ thread in pciehp_ist() will process
the ->pending_events and will assume the Link went Down due to a card
change (in pciehp_handle_presence_or_link_change()).

Change pciehp_reset_slot() to also clear HPIE (Hot-Plug Interrupt
Enable) as pciehp_isr() will first check HPIE to see if the interrupt
is not for it. Then synchronize with the IRQ handling to ensure no
events are pending, before invoking the reset.

Similarly, if the poll mode is in use, park the poll thread over the
duration of the reset to stop handling events.

In order to not race irq_syncronize()/kthread_{,un}park() with the irq
/ poll_thread freeing from pciehp_remove(), take reset_lock in
pciehp_free_irq() and check the irq / poll_thread variable validity in
pciehp_reset_slot().

Fixes: 06a8d89af551 ("PCI: pciehp: Disable link notification across slot reset")
Fixes: 720d6a671a6e ("PCI: pciehp: Do not handle events if interrupts are masked")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219765
Suggested-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/hotplug/pciehp_hpc.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bb5a8d9f03ad..c487e274b282 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -77,10 +77,15 @@ static inline int pciehp_request_irq(struct controller *ctrl)
 
 static inline void pciehp_free_irq(struct controller *ctrl)
 {
-	if (pciehp_poll_mode)
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
+	if (pciehp_poll_mode) {
 		kthread_stop(ctrl->poll_thread);
-	else
+		ctrl->poll_thread = NULL;
+	} else {
 		free_irq(ctrl->pcie->irq, ctrl);
+		ctrl->pcie->irq = IRQ_NOTCONNECTED;
+	}
+	up_read(&ctrl->reset_lock);
 }
 
 static int pcie_poll_cmd(struct controller *ctrl, int timeout)
@@ -766,8 +771,9 @@ static int pciehp_poll(void *data)
 
 	while (!kthread_should_stop()) {
 		/* poll for interrupt events or user requests */
-		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
-		       atomic_read(&ctrl->pending_events))
+		while (!kthread_should_park() &&
+		       (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
+			atomic_read(&ctrl->pending_events)))
 			pciehp_ist(IRQ_NOTCONNECTED, ctrl);
 
 		if (pciehp_poll_time <= 0 || pciehp_poll_time > 60)
@@ -907,6 +913,8 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 
 	down_write_nested(&ctrl->reset_lock, ctrl->depth);
 
+	if (!pciehp_poll_mode)
+		ctrl_mask |= PCI_EXP_SLTCTL_HPIE;
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
@@ -918,9 +926,21 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, 0);
 
+	/* Make sure HPIE is no longer seen by the interrupt handler. */
+	if (pciehp_poll_mode) {
+		if (ctrl->poll_thread)
+			kthread_park(ctrl->poll_thread);
+	} else {
+		if (ctrl->pcie->irq != IRQ_NOTCONNECTED)
+			synchronize_irq(ctrl->pcie->irq);
+	}
+
 	rc = pci_bridge_secondary_bus_reset(ctrl->pcie->port);
 
 	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, stat_mask);
+	if (pciehp_poll_mode && ctrl->poll_thread)
+		kthread_unpark(ctrl->poll_thread);
+
 	pcie_write_cmd_nowait(ctrl, ctrl_mask, ctrl_mask);
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
-- 
2.39.5


