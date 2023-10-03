Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7777B697C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Oct 2023 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjJCMxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Oct 2023 08:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjJCMxd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Oct 2023 08:53:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A675BF;
        Tue,  3 Oct 2023 05:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696337611; x=1727873611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ColEi8Bgy84f92KFXrjvKWg7/PjGY+5N1fWbadVJ1hM=;
  b=NZU5PvXIqaUSGd5JFftfypJjvWLxU8ykj9ufeWIirf+zh/FRbPpPiopF
   9QwLXEKwZAxKpJ2pyfiOnUK5BlLAhYKaSFdgn1ShZaIBSWU5u51bKNOcu
   C+xQW4Xv7cRH5SWCElgrMe+OpQDaNF7w1h0RB0cOwpewFfP1VK8Mquoed
   zxMgwIZBkhu/CMN4r0myEA2z2GiokcP5xtLUlQ+bW1UpE23SP9+triAaQ
   Ke0m7EG1SFZR3hS5L6mQRK0C4QgdSXogwdLB2QxQmYA2bf0HzwRuaKJfv
   IOtrI110Ecq8YBtdrX1M8e7P7/i9gyHMCuZnFJcvl4qAnJHvSQ4d0qU4k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="447022379"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="447022379"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="998006040"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="998006040"
Received: from bmihaile-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.222.64])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 05:53:22 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        bcm-kernel-feedback-list@broadcom.com, jonathan.derrick@linux.dev,
        kw@linux.com, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        lpieralisi@kernel.org, marek.vasut+renesas@gmail.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        m.karthikeyan@mobiveil.co.in, nirmal.patel@linux.intel.com,
        rjui@broadcom.com, robh@kernel.org, roy.zang@nxp.com,
        sbranden@broadcom.com, yoshihiro.shimoda.uh@renesas.com,
        Zhiqiang.Hou@nxp.com, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/3] PCI: vmd: Correct PCI Header Type Register's MFD bit check
Date:   Tue,  3 Oct 2023 15:52:58 +0300
Message-Id: <20231003125300.5541-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
References: <20231003125300.5541-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

vmd_domain_reset() attempts to find whether the device may contain
multiple functions by checking 0x80 (Multi-Function Device), however,
the hdr_type variable has already been masked with PCI_HEADER_TYPE_MASK
so the check can never true.

To fix the issue, don't mask the read with PCI_HEADER_TYPE_MASK.

Fixes: 6aab5622296b ("PCI: vmd: Clean up domain before enumeration")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Nirmal Patel <nirmal.patel@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e718a816d481..d5b97a6aae56 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -525,8 +525,7 @@ static void vmd_domain_reset(struct vmd_dev *vmd)
 			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
 						PCI_DEVFN(dev, 0), 0);
 
-			hdr_type = readb(base + PCI_HEADER_TYPE) &
-					 PCI_HEADER_TYPE_MASK;
+			hdr_type = readb(base + PCI_HEADER_TYPE);
 
 			functions = (hdr_type & 0x80) ? 8 : 1;
 			for (fn = 0; fn < functions; fn++) {
-- 
2.30.2

