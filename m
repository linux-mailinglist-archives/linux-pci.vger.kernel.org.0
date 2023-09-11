Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F98479B42E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350397AbjIKVh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237213AbjIKMPg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:15:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E07CEB;
        Mon, 11 Sep 2023 05:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694434531; x=1725970531;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=toOyW9LlXxM3sJdhFIcQPxDfWTfs2UZORrP5iweYkcs=;
  b=c6HhtnDHBo/zdZ91MbPKjFkppwYatPgWYv1WJL+aK4R4r6RZmJiFOZfl
   mCEEINQ9DoS3dkIowkUXW9PuO+54Q0tX6QTPxXPtPSIt940Yub0nqDy3r
   guNH2ROHwfKFX8bt9LrzwNcx9JS0FRQH7S8bL9Q9Ajjk17EERFjskhZXO
   cdvbnPiSGvtAShGE1/S0Wu0rg4z1FSz7FrrY7HqRxR1pEAA5SU6/iKMjA
   NEtff8Vv0yJWK6sIeNv5h46BG+E5I6eOScrbQvlzInAecx4g0su5jW1gB
   vzR5D6AHdmGBe7uwHH4ZWidKJIvYPp0atvD4wLmWLnTNgBSGsfUIlRDjK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="381863554"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="381863554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746383313"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="746383313"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:15:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/8] PCI: mvebu: Use FIELD_PREP() with Link Width
Date:   Mon, 11 Sep 2023 15:14:58 +0300
Message-Id: <20230911121501.21910-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
References: <20230911121501.21910-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

mvebu_pcie_setup_hw() setups the Maximum Link Width field in the Link
Capabilities registers using an open-coded variant of FIELD_PREP() with
a literal in shift. Improve readability by using
FIELD_PREP(PCI_EXP_LNKCAP_MLW, ...).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-mvebu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-mvebu.c b/drivers/pci/controller/pci-mvebu.c
index 60810a1fbfb7..29fe09c99e7d 100644
--- a/drivers/pci/controller/pci-mvebu.c
+++ b/drivers/pci/controller/pci-mvebu.c
@@ -264,7 +264,7 @@ static void mvebu_pcie_setup_hw(struct mvebu_pcie_port *port)
 	 */
 	lnkcap = mvebu_readl(port, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 	lnkcap &= ~PCI_EXP_LNKCAP_MLW;
-	lnkcap |= (port->is_x4 ? 4 : 1) << 4;
+	lnkcap |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, port->is_x4 ? 4 : 1);
 	mvebu_writel(port, lnkcap, PCIE_CAP_PCIEXP + PCI_EXP_LNKCAP);
 
 	/* Disable Root Bridge I/O space, memory space and bus mastering. */
-- 
2.30.2

