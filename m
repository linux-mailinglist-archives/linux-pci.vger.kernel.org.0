Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC66B5393EE
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 17:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345657AbiEaP05 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 11:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345649AbiEaP0y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 11:26:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDAF248C4;
        Tue, 31 May 2022 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010813; x=1685546813;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3gyDazsOshz3oeahlbhDyK1bPrO6GOsAq/G6LeDMe1I=;
  b=Ge5n3bAUAmGT3ZED2VyvLaJ04sLe6dd9l3Li2I2iMMHiwU0MLYzM6wMh
   yVqjTZ9zIkitMoaVGFXQiuP4r7jqLYUQ4GJqGzNzwCbynRcCvBbRDqYw9
   2L/tbUdF0uIehMcL7jhZJqYYQN+CKtl4IBvFM1+56jJ7EPnHg3Zh/66R8
   D0zuB2PpjKE6Fbq8bm2w2BS32F+h9UbchQTFtCAvxnskK5/06h/tU3gmC
   9F8kV0DpxLow67FUWwaOdN3xMmihgZ33MupdTb7Mg+m8dm6ql8X+B76wx
   IC6KHI2IvU7w8xpcJzjV26uPM1rwShQUTipXLiBX8bb1LyFHGYQ6JkMVn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="255770018"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="255770018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:26:53 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="823323681"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:26:52 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V9 1/9] PCI: Add vendor ID for the PCI SIG
Date:   Tue, 31 May 2022 08:26:24 -0700
Message-Id: <20220531152632.1397976-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531152632.1397976-1-ira.weiny@intel.com>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This ID is used in DOE headers to identify protocols that are defined
within the PCI Express Base Specification, PCIe r6.0, sec 6.30.1.1 table
6-32.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0178823ce8c2..8af3b86206b1 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -151,6 +151,7 @@
 #define PCI_CLASS_OTHERS		0xff
 
 /* Vendors and devices.  Sort key: vendor first, device next. */
+#define PCI_VENDOR_ID_PCI_SIG		0x0001
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
-- 
2.35.1

