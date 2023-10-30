Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1EF7DB930
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 12:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjJ3Lm2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Oct 2023 07:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3Lm2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 07:42:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A53CB6;
        Mon, 30 Oct 2023 04:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698666146; x=1730202146;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wgjl1H5YZOAljBGcZUVinUUuvxtEN2OCmrNb2NgLeng=;
  b=doUKXhMNdagXxFYh3KG1aEdrhf3KRRvUpOWezGSMVOLVQY+wcZwZIOHg
   PdLrgxFAnpK2h/NieygqkFR7tJsQofvT4fW4nMlZP7B8ILYZmCem+SbXU
   c9yJudKin8MVFFF/uhdzEBwbfJpn+kWUW7rZNHDhpVajtL5oan1y0umwY
   n9nQb7AzXJMwAs+bgVGnKIpRrpYVp2DlAf1la5UdGYgfZ2dpmRdqWlQEt
   R52KvaZAdu+FPhZWMVCx0xci/diIf9scWl7SJi6vfBfAWnWG1Qb9wfdTW
   5Y1b7jEnXH1peHpawju2RdSAlpXtjZuZchEseWzvvdeYmiUcAr49yvPNU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="454519518"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="454519518"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 04:42:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="883836795"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="883836795"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2023 04:42:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6AFD02BF; Mon, 30 Oct 2023 13:42:22 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonas Gorski <jonas.gorski@gmail.com>
Subject: [PATCH v1 1/1] PCI: Avoid potential out-of-bounds read in pci_dev_for_each_resource()
Date:   Mon, 30 Oct 2023 13:42:18 +0200
Message-Id: <20231030114218.2752236-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Coverity complains that pointer in the pci_dev_for_each_resource()
may be wrong, i.e. mighe be used for the out-of-bounds read.

There is no actual issue right now, because we have another check
afterwards and the out-of-bounds read is not being performed. In any
case it's better code with this get fixed, hence the proposed change.

As Jonas pointed out "It probably makes the code slightly less
performant as res will now be checked for being not NULL (which will
always be true), but I doubt it will be significant (or in any hot
paths)."

Fixes: 09cc90063240 ("PCI: Introduce pci_dev_for_each_resource()")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Closes: https://lore.kernel.org/r/20230509182122.GA1259567@bhelgaas
Suggested-by: Jonas Gorski <jonas.gorski@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/pci.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 60ca768bc867..19adad23a204 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2127,14 +2127,14 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma);
 	(pci_resource_end((dev), (bar)) ? 				\
 	 resource_size(pci_resource_n((dev), (bar))) : 0)
 
-#define __pci_dev_for_each_res0(dev, res, ...)				\
-	for (unsigned int __b = 0;					\
-	     res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;	\
+#define __pci_dev_for_each_res0(dev, res, ...)					\
+	for (unsigned int __b = 0;						\
+	     __b < PCI_NUM_RESOURCES && (res = pci_resource_n(dev, __b));	\
 	     __b++)
 
-#define __pci_dev_for_each_res1(dev, res, __b)				\
-	for (__b = 0;							\
-	     res = pci_resource_n(dev, __b), __b < PCI_NUM_RESOURCES;	\
+#define __pci_dev_for_each_res1(dev, res, __b)					\
+	for (__b = 0;								\
+	     __b < PCI_NUM_RESOURCES && (res = pci_resource_n(dev, __b));	\
 	     __b++)
 
 #define pci_dev_for_each_resource(dev, res, ...)			\
-- 
2.40.0.1.gaa8946217a0b

