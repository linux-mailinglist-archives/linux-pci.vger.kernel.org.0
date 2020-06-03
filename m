Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099291ECEEF
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 13:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgFCLsm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 07:48:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:46727 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCLsm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jun 2020 07:48:42 -0400
IronPort-SDR: Um5sXVn3rqmRnqzoXxxbFWtFsWaBxyozStog0NnVF73pJMJuTQHFU6y219Mbi4A+xeoQpyUjRY
 0l5gJuEE5ScQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 04:48:41 -0700
IronPort-SDR: G53dfnvycYuAA60K16f4d1tOhax14fDJGEd42Qcg6LMFPqNVIbJH7JYEVDQBfs0WtOoPhGsnq4
 ZaZd1fMSlJjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="471047916"
Received: from gklab-125-110.igk.intel.com ([10.91.125.110])
  by fmsmga006.fm.intel.com with ESMTP; 03 Jun 2020 04:48:39 -0700
From:   Piotr Stankiewicz <piotr.stankiewicz@intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/15] media: ddbridge: Use PCI_IRQ_MSI_TYPES where appropriate
Date:   Wed,  3 Jun 2020 13:48:36 +0200
Message-Id: <20200603114837.13460-1-piotr.stankiewicz@intel.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
References: <20200603114212.12525-1-piotr.stankiewicz@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Seeing as there is shorthand available to use when asking for any type
of interrupt, or any type of message signalled interrupt, leverage it.

Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 03dc9924fa2c..ff5c33d7a736 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -106,7 +106,7 @@ static void ddb_irq_msi(struct ddb *dev, int nr)
 
 	if (msi && pci_msi_enabled()) {
 		stat = pci_alloc_irq_vectors(dev->pdev, 1, nr,
-					     PCI_IRQ_MSI | PCI_IRQ_MSIX);
+					     PCI_IRQ_MSI_TYPES);
 		if (stat >= 1) {
 			dev->msi = stat;
 			dev_info(dev->dev, "using %d MSI interrupt(s)\n",
-- 
2.17.2

