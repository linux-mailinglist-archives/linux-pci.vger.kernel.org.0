Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABEA53D8EC
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 02:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiFEAvJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 20:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242561AbiFEAvI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 20:51:08 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA6C4C424;
        Sat,  4 Jun 2022 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390267; x=1685926267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSeFzVjUGMMS2b3un5o70kPyUOGxdQ04HzQxHShJ9+Q=;
  b=NG8y3DI4Uc0hgkhrtcL+mNz1PdjONgfAbh8KpU5d5RlKyGhx2J4uj+bi
   YR4uJb6ImeNJB9PdLDKXHQ5E4Y2GKgvEgZoiAFC6cs/IZ9vA+fVVnu0kp
   81/YaSkrkHqjoK3QUOySZC8PeJAHm3uCYnd2ZHr2kmYRaFgOPNZbODeQq
   AaXsSQ4r1LWEaBB3bhTefufO9SFPSQAd70Au5WPaXwPE2Giq26Wj9qCkr
   3QRaeV7ZmkYFTCs2X5Fpbw8r/xbPpY7OpvRKareC7ykCb2O16IxQICpWZ
   a/cyDH6DX7HnUCKSyU/O2JAlFE2mw42x7ASIPjRrAe/9PQphEipBCX10V
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="337177543"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="337177543"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="553856256"
Received: from aftome-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.107.207])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:06 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 1/9] PCI: Add vendor ID for the PCI SIG
Date:   Sat,  4 Jun 2022 17:50:41 -0700
Message-Id: <20220605005049.2155874-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605005049.2155874-1-ira.weiny@intel.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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

