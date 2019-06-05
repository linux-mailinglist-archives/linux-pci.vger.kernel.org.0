Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 758FA35FBC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 16:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfFEO6Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jun 2019 10:58:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:16397 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbfFEO6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jun 2019 10:58:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 07:58:24 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 05 Jun 2019 07:58:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 5193C462; Wed,  5 Jun 2019 17:58:21 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 2/3] PCI: Do not poll for PME if the device is in D3cold
Date:   Wed,  5 Jun 2019 17:58:19 +0300
Message-Id: <20190605145820.37169-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
References: <20190605145820.37169-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PME polling does not take into account that a device that is directly
connected to the host bridge may go into D3cold as well. This leads to a
situation where the PME poll thread reads from a config space of a
device that is in D3cold and gets incorrect information because the
config space is not accessible.

Here is an example from Intel Ice Lake system where two PCIe root ports
are in D3cold (I've instrumented the kernel to log the PMCSR register
contents):

  [   62.971442] pcieport 0000:00:07.1: Check PME status, PMCSR=0xffff
  [   62.971504] pcieport 0000:00:07.0: Check PME status, PMCSR=0xffff

Since 0xffff is interpreted so that PME is pending, the root ports will
be runtime resumed. This repeats over and over again essentially
blocking all runtime power management.

Prevent this from happening by checking whether the device is in D3cold
before its PME status is read.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 87a1f902fa8e..720da09d4d73 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2060,6 +2060,13 @@ static void pci_pme_list_scan(struct work_struct *work)
 			 */
 			if (bridge && bridge->current_state != PCI_D0)
 				continue;
+			/*
+			 * If the device is in D3cold it should not be
+			 * polled either.
+			 */
+			if (pme_dev->dev->current_state == PCI_D3cold)
+				continue;
+
 			pci_pme_wakeup(pme_dev->dev, NULL);
 		} else {
 			list_del(&pme_dev->list);
-- 
2.20.1

