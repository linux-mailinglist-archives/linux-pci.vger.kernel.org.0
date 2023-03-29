Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB156CF428
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 22:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC2UNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 16:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2UNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 16:13:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD3430C7;
        Wed, 29 Mar 2023 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680120798; x=1711656798;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Aiobm3lfAotQcDFd97i7I7T/TYFzraaI742gzeFKiKY=;
  b=Rqa7lCIZ883QNssfP3BqGDkO9Ne5/pAcwP56+dtkSj8S9kC/vSUjMKHw
   /V6OL58LMts/sWZrDvL4+0DfX1o58J0rX/Nc+4KyB8cg+dsdbGA7kpPMI
   OD1SvgPPFYboHZQEdEuaYpMrDMP77F3RDDmS6v05ll0AJ29OFIDK454Nu
   HhorGyeIkcjfwF2EkA4G9H6tdE6YDFmaGDCca/nWss2sHHGgsDh1p46w8
   44ipZxp+8kTzKDbzQybv4Z31+Jygc2vTYBWad5RZ300nUjRBa3CgHgZyi
   lXTNkgirjLAQr/Bs1ShVCL4xIcNcO1HGcj/z5lxe5Cc5OXQJm18x3G8WS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="368764859"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="368764859"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="753738039"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="753738039"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 13:13:17 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     bhelgaas@google.com, nathan@kernel.org, ndesaulniers@google.com,
        trix@redhat.com, tglx@linutronix.de
Cc:     darwi@linutronix.de, kevin.tian@intel.com,
        reinette.chatre@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH] PCI/MSI: Provide missing stub for pci_msix_can_alloc_dyn()
Date:   Wed, 29 Mar 2023 13:13:11 -0700
Message-Id: <310ecc4815dae4174031062f525245f0755c70e2.1680119924.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_msix_can_alloc_dyn() is not declared when CONFIG_PCI_MSI
is disabled.

There is no existing user of pci_msix_can_alloc_dyn() but
work is in progress to change this. This work encounters
the following error when CONFIG_PCI_MSI is disabled:

drivers/vfio/pci/vfio_pci_intrs.c:427:21: error: implicit declaration \
	of function 'pci_msix_can_alloc_dyn' \
	[-Werror=implicit-function-declaration]

Provide definition for pci_msix_can_alloc_dyn() in preparation
for users that need to compile when CONFIG_PCI_MSI is disabled.

Fixes: 34026364df8e ("PCI/MSI: Provide post-enable dynamic allocation interfaces for MSI-X")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202303291000.PWFqGCxH-lkp@intel.com/
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
I missed this one in my previous fix. After this all the functions
in pci.h's #ifdef CONFIG_PCI_MSI portion have stubs when
CONFIG_PCI_MSI is disabled.

 include/linux/pci.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index b50e5c79f7e3..a5dda515fcd1 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1624,6 +1624,8 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 					      flags, NULL);
 }
 
+static inline bool pci_msix_can_alloc_dyn(struct pci_dev *dev)
+{ return false; }
 static inline struct msi_map pci_msix_alloc_irq_at(struct pci_dev *dev, unsigned int index,
 						   const struct irq_affinity_desc *affdesc)
 {
-- 
2.34.1

