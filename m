Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9870D9EC3B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfH0PS1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 11:18:27 -0400
Received: from mga17.intel.com ([192.55.52.151]:63436 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfH0PS1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 11:18:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 08:18:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="209789081"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 08:18:24 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 169A8BB; Tue, 27 Aug 2019 18:18:24 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] PCI/AER: Update parameter descriptions to satisfy kernel-doc validator
Date:   Tue, 27 Aug 2019 18:18:23 +0300
Message-Id: <20190827151823.75312-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
References: <20190827151823.75312-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Kernel-doc validator complains:

aer.c:207: warning: Function parameter or member 'str' not described in 'pcie_ecrc_get_policy'
aer.c:1209: warning: Function parameter or member 'irq' not described in 'aer_isr'
aer.c:1209: warning: Function parameter or member 'context' not described in 'aer_isr'
aer.c:1209: warning: Excess function parameter 'work' description in 'aer_isr'

Fix the above accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f883f81d759a..6073eaab099d 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -202,6 +202,7 @@ void pcie_set_ecrc_checking(struct pci_dev *dev)
 
 /**
  * pcie_ecrc_get_policy - parse kernel command-line ecrc option
+ * @str: ECRC policy from kernel command line to use
  */
 void pcie_ecrc_get_policy(char *str)
 {
@@ -1201,7 +1202,8 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 
 /**
  * aer_isr - consume errors detected by root port
- * @work: definition of this work item
+ * @irq: IRQ assigned to Root Port
+ * @context: pointer to Root Port data structure
  *
  * Invoked, as DPC, when root port records new detected error
  */
-- 
2.23.0.rc1

