Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316257C8449
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 13:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjJMLU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 07:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjJMLU2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 07:20:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2DDBE;
        Fri, 13 Oct 2023 04:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697196026; x=1728732026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QwX1T56kKdECyvfzzcVMEAXl3q0v/TRtKY7Rk2vHDQI=;
  b=OmBRORpkUcT8849p4rgpyrwSolSKmu9OK0onSSYNYZzKA15+7MPRbU+L
   y3RFlwPZYOOpB9fncv60zpB4y/GFmZKkXK5xLV3AG7naKGCcwe5i8R8km
   JzPhvFbdkmSzxPyikWZ7+5yIIPlfKSUJh/pRbOp2XrIdRfXhj1TFORoYv
   39AQX6e0NInVpykBWVFZVXz93qLe2FEv/OrdfqmDXJkDZgdgm5UG+G8ac
   z0I3mKHT582i31yjIAVaovh3g7oeOipofzDi9dAmagVuyZFTbo0izHf57
   wrnn7tbYxbhuXkLclhf7Q70WMPbPycp8lEgWQTnQJsVOndC2zbC156KOj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="3758931"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3758931"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:20:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="1086104454"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="1086104454"
Received: from rhaeussl-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.47])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 04:20:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/2] PCI: Add PCI_EXP_DPC_* field details
Date:   Fri, 13 Oct 2023 14:20:03 +0300
Message-Id: <20231013112004.4239-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231013112004.4239-1-ilpo.jarvinen@linux.intel.com>
References: <20231013112004.4239-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCI_EXP_DPC_RP_PIO_FEP and PCI_EXP_DPC_STATUS_TRIGGER_RSN_*
to be able to replace literals with them.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/uapi/linux/pci_regs.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d96493..ce4512147ee7 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1042,9 +1042,16 @@
 #define PCI_EXP_DPC_STATUS		0x08	/* DPC Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER	    0x0001 /* Trigger Status */
 #define  PCI_EXP_DPC_STATUS_TRIGGER_RSN	    0x0006 /* Trigger Reason */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR  0x0000 /* DPC due to unmasked uncorrectable error */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_NFE    0x0002 /* DPC due to receiving ERR_NONFATAL */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_FE     0x0004 /* DPC due to receiving ERR_FATAL */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_IN_EXT 0x0006 /* Reason in Trig Reason Extension field */
 #define  PCI_EXP_DPC_STATUS_INTERRUPT	    0x0008 /* Interrupt Status */
 #define  PCI_EXP_DPC_RP_BUSY		    0x0010 /* Root Port Busy */
 #define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_EXT 0x0060 /* Trig Reason Extension */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_RP_PIO		0x0000	/* DPC due to RP PIO error */
+#define  PCI_EXP_DPC_STATUS_TRIGGER_RSN_SW_TRIGGER	0x0020	/* DPC due to DPC SW Trigger bit */
+#define  PCI_EXP_DPC_RP_PIO_FEP		    0x1f00 /* Root Port PIO First Error Pointer */
 
 #define PCI_EXP_DPC_SOURCE_ID		 0x0A	/* DPC Source Identifier */
 
-- 
2.30.2

