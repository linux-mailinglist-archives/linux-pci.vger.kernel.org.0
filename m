Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211297200AE
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjFBLtF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbjFBLtB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9236F10C4;
        Fri,  2 Jun 2023 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706511; x=1717242511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuhMVA9R70dv8zCl7j+RyC0Woig16drv2hvDBVun3EM=;
  b=DgcC+AbPeVQgxvi1LkAlD+MrTdAIzshgbqVGX7aFN2aqv3DrgPCjEKnS
   M6D67aevqPUVi/4whyqDxL1u65kOfFZzxFUo2a57AjTzE5pkaDEbmkRJl
   xco3Mvyg3gu0XcCQfiQn9S3mWOfzmkYHJrSnWva+Mn/9acx/9XEaNfj88
   dmSYf/0VRwkd3tx5H8mKkggf+BRenPR2o7OKX68/dev4n8h1IRsotwB7U
   dmDh8seUY6sqxZNidcxl3Ib3evxKqQrrrJaEDn5QEghDLF+JZuhbmrbtV
   8j5gDlkAApxmge748cAvI2JCdLmqvrkB1NvflJiwGZmn5ewJSh3yKNcv6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279642"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279642"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819423"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819423"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:15 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 03/13] PCI/ASPM: Improve pci_set_default_link_state() kerneldoc
Date:   Fri,  2 Jun 2023 14:47:40 +0300
Message-Id: <20230602114751.19671-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Improve pci_set_default_link_state() documentation:

- Note the link state may get changed if the default policy is in use
- Better follow kerneldoc formatting guidelines (separate description
  block and return entries)

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 9fa8ab6eb7a4..33ee2b563a39 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1157,14 +1157,18 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 EXPORT_SYMBOL(pci_disable_link_state);
 
 /**
- * pci_set_default_link_state - Clear and set the default device link state so
- * that the link may be allowed to enter the specified states. Note that if the
- * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
- * touch the LNKCTL register. Also note that this does not enable states
- * disabled by pci_disable_link_state(). Return 0 or a negative errno.
- *
+ * pci_set_default_link_state - Set the default device link state
  * @pdev: PCI device
  * @state: Mask of ASPM link states to enable
+ *
+ * Clear and set the default device link state so that the link may be
+ * allowed to enter the specified states. If the default policy is in use,
+ * the link state may also be updated to reflect the new default link state.
+ * Note that if the BIOS didn't grant ASPM control to the OS, this does
+ * nothing because we can't touch the LNKCTL register. Also note that this
+ * does not enable states disabled by pci_disable_link_state().
+ *
+ * Return: 0 or a negative errno.
  */
 int pci_set_default_link_state(struct pci_dev *pdev, int state)
 {
-- 
2.30.2

