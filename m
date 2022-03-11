Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 272FD4D587F
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 03:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbiCKC7o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 21:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239337AbiCKC7n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 21:59:43 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32F3506CC;
        Thu, 10 Mar 2022 18:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646967521; x=1678503521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UJTpyFGEbvemu6dDdKBT6cEZiQLRbmMy45pgsMr9KBM=;
  b=A3ywew/LVIfD4YBcEWevO4kw+vHpCMXapnLaXTU38v1/Gd7mqRX96Kkf
   zGShDtIk45p4KAkus0lpJwGCtA9tx5DumrO/CduwpOyIYEsdl6sSBQhAV
   B5BvUy5ItDwHkRvIPJobj+oA1s77ZPletF6aK08O5D7nBzTdnUjGxKD0T
   e+YvHfZmjdRA3AZDzWDv3IYt2wMzEleFuKveNX9KuUPWzTc7q1eJKY9YC
   xHQsReA45gZTC7H+0D1s9jkZhOflJzFr8Zp99kK6GUXjaVhtzOm9fqiHv
   EVLtOvbfHqoKDD9t6DcjXUtTFr9XHS0PNl6TwTjPwVyxtNVTxuQrAqQSy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255433978"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255433978"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:58:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="644784512"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 18:58:20 -0800
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver OHalloran <oohall@gmail.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Eric Badger <ebadger@purestorage.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: [PATCH v1] PCI/AER: Handle Multi UnCorrectable/Correctable errors properly
Date:   Fri, 11 Mar 2022 02:58:07 +0000
Message-Id: <20220311025807.14664-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently the aer_irq() handler returns IRQ_NONE for cases without bits
PCI_ERR_ROOT_UNCOR_RCV or PCI_ERR_ROOT_COR_RCV are set. But this
assumption is incorrect.

Consider a scenario where aer_irq() is triggered for a correctable
error, and while we process the error and before we clear the error
status in "Root Error Status" register, if the same kind of error
is triggered again, since aer_irq() only clears events it saw, the
multi-bit error is left in tact. This will cause the interrupt to fire
again, resulting in entering aer_irq() with just the multi-bit error
logged in the "Root Error Status" register.

Repeated AER recovery test has revealed this condition does happen
and this prevents any new interrupt from being triggered. Allow to
process interrupt even if only multi-correctable (BIT 1) or
multi-uncorrectable bit (BIT 3) is set.

Reported-by: Eric Badger <ebadger@purestorage.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/aer.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..7952e5efd6cf 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -101,6 +101,11 @@ struct aer_stats {
 #define ERR_COR_ID(d)			(d & 0xffff)
 #define ERR_UNCOR_ID(d)			(d >> 16)
 
+#define AER_ERR_STATUS_MASK		(PCI_ERR_ROOT_UNCOR_RCV |	\
+					PCI_ERR_ROOT_COR_RCV |		\
+					PCI_ERR_ROOT_MULTI_COR_RCV |	\
+					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
+
 static int pcie_aer_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
@@ -1196,7 +1201,7 @@ static irqreturn_t aer_irq(int irq, void *context)
 	struct aer_err_source e_src = {};
 
 	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_STATUS, &e_src.status);
-	if (!(e_src.status & (PCI_ERR_ROOT_UNCOR_RCV|PCI_ERR_ROOT_COR_RCV)))
+	if (!(e_src.status & AER_ERR_STATUS_MASK))
 		return IRQ_NONE;
 
 	pci_read_config_dword(rp, aer + PCI_ERR_ROOT_ERR_SRC, &e_src.id);
-- 
2.25.1

