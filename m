Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA8F5958E0
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiHPKss (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234945AbiHPKsX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:48:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60681BA9DB
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644453; x=1692180453;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCQLidEJM0K7+j8DIvbZtOAx9fB9psFBgizZszFCegc=;
  b=INYqIDhn+RR5sCHg9OCg7oH9w71ngpgk4GpttDqOhlDS/m3VXW2fh3kV
   jCgqDE1/Jl1E4nR4vVJNfABBaHi7jggXHTxL71OaDtvH/V//uxxXMqctE
   pm5AVYP1uj69QuVk8K0MbRLakJiTrQFU/fc2kkO0Q/D86I7q/n2ksptyD
   i9vrYDgUtj1OQ9sdePl7ESOvhXm0OxAMOT+CUr65Es+Kg5VgfliISJX4m
   x6HqPPsWmMOzbT8FqG1lBmzfbaBBH7HzKbxr4L0oD8M0Ls6P9CHzbht1/
   qqaZJp1tX016r0VN8ToM0WQMOe4klNzPr1AYXh1Eiv0Mra8X26taRXizk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="318171494"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="318171494"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:07:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="603467763"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 16 Aug 2022 03:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4C011540; Tue, 16 Aug 2022 13:07:41 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Chris Chiu <chris.chiu@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 6/6] PCI: Fix indentation in pci_bridge_distribute_available_resources()
Date:   Tue, 16 Aug 2022 13:07:40 +0300
Message-Id: <20220816100740.68667-7-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
References: <20220816100740.68667-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Correct the indentation according the coding style.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index df9fc974b313..dc6a30ee6edf 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1919,7 +1919,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 }
 
 static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
-						     struct list_head *add_list)
+						      struct list_head *add_list)
 {
 	struct resource available_io, available_mmio, available_mmio_pref;
 
-- 
2.35.1

