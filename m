Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA95630C05
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 11:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfEaJtd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 05:49:33 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52996 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfEaJtc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2019 05:49:32 -0400
Received: from 79.184.255.225.ipv4.supernova.orange.pl (79.184.255.225) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 812f32bff0215906; Fri, 31 May 2019 11:49:30 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: PM: Avoid resuming devices in D3hot during system suspend
Date:   Fri, 31 May 2019 11:49:30 +0200
Message-ID: <4561083.VtDMOnK5Me@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The current code resumes devices in D3hot during system suspend if
the target power state for them is D3cold, but that is not necessary
in general.  It only is necessary to do that if the platform firmware
requires the device to be resumed, but that should be covered by
the platform_pci_need_resume() check anyway, so rework
pci_dev_keep_suspended() to avoid returning 'false' for devices
in D3hot which need not be resumed due to platform firmware
requirements.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci.c |   15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -2474,10 +2474,19 @@ bool pci_dev_keep_suspended(struct pci_d
 {
 	struct device *dev = &pci_dev->dev;
 	bool wakeup = device_may_wakeup(dev);
+	pci_power_t target_state;
 
-	if (!pm_runtime_suspended(dev)
-	    || pci_target_state(pci_dev, wakeup) != pci_dev->current_state
-	    || platform_pci_need_resume(pci_dev))
+	if (!pm_runtime_suspended(dev) || platform_pci_need_resume(pci_dev))
+		return false;
+
+	target_state = pci_target_state(pci_dev, wakeup);
+	/*
+	 * If the earlier platform check has not triggered, D3cold is just power
+	 * removal on top of D3hot, so no need to resume the device in that
+	 * case.
+	 */
+	if (target_state != pci_dev->current_state &&
+	    target_state != PCI_D3cold && pci_dev->current_state != PCI_D3hot)
 		return false;
 
 	/*



