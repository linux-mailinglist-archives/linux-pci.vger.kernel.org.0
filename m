Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6332CEFB52
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 11:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfKEKcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 05:32:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:44576 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388703AbfKEKca (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2019 05:32:30 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 0ec36c7f3c6dcade; Tue, 5 Nov 2019 11:32:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/5] PCI: PM: Move power state update away from pci_power_up()
Date:   Tue, 05 Nov 2019 11:13:43 +0100
Message-ID: <37482337.udjOGdOKNb@kreacher>
In-Reply-To: <2771503.n70vfTtcVb@kreacher>
References: <2771503.n70vfTtcVb@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Move the invocation of pci_update_current_state() from pci_power_up()
to pci_pm_default_resume_early(), which is the only caller of that
function.

Preparatory change, no functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-driver.c |    1 +
 drivers/pci/pci.c        |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/drivers/pci/pci-driver.c
===================================================================
--- linux-pm.orig/drivers/pci/pci-driver.c
+++ linux-pm/drivers/pci/pci-driver.c
@@ -524,6 +524,7 @@ static int pci_restore_standard_config(s
 static void pci_pm_default_resume_early(struct pci_dev *pci_dev)
 {
 	pci_power_up(pci_dev);
+	pci_update_current_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev);
 	pci_pme_restore(pci_dev);
 }
Index: linux-pm/drivers/pci/pci.c
===================================================================
--- linux-pm.orig/drivers/pci/pci.c
+++ linux-pm/drivers/pci/pci.c
@@ -1148,7 +1148,6 @@ void pci_power_up(struct pci_dev *dev)
 {
 	__pci_start_power_transition(dev, PCI_D0);
 	pci_raw_set_power_state(dev, PCI_D0);
-	pci_update_current_state(dev, PCI_D0);
 }
 
 /**



