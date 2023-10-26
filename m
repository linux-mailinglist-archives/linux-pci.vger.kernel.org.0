Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7C7D827A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Oct 2023 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjJZMTt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Oct 2023 08:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235056AbjJZMTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Oct 2023 08:19:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F538D56;
        Thu, 26 Oct 2023 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322785; x=1729858785;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDhZf15BV04eSn2K5282do0xuIjqvRY33xZ0d2grIHo=;
  b=L2e01mq+ShnoayCH1Cd6xJBwqHbR5u3uzB5T+tgeBHocPm642b7CPDDK
   CoFf9mPYkKbd5nKAK2nKApUmInJi/4n0qfPcXoQiMTOU8dTWSZYlGhkFV
   9H5i8OtKPC4C4qG5vHVTeRdR3EIu5JFewrXZexgq58NmtturQ4yhcIpNZ
   8iP0f1OttgOi7/HJxNK82Hc2g/x7zdWAr+A4aB5LfoK345Wbjgw2EmBW4
   aXi5aPLaO7wFWAQpgrL3VUrYRCYGJKMH65yH5jv+uYcM8WTjr7L4QVzOH
   rLDQCWpZj20baydmUNcq12SKOLg9ez8X4llSYdPNYd1EfVhjEj11XX8lv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="390390980"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="390390980"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:19:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="1090589468"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="1090589468"
Received: from ialvarez-mobl.ger.corp.intel.com (HELO localhost) ([10.252.33.120])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:19:42 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/2] PCI: Simplify pcie_capability_clear_and_set_word() to ..._clear_word()
Date:   Thu, 26 Oct 2023 15:19:24 +0300
Message-Id: <20231026121924.2164-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231026121924.2164-1-ilpo.jarvinen@linux.intel.com>
References: <20231026121924.2164-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When set parameter is 0, pcie_capability_clear_and_set_word() can be
turned into pcie_capability_clear_word() which makes the intent of the
code slightly more obvious.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/quirks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index eeec1d6f9023..180d01141e50 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4553,9 +4553,9 @@ static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
 
 	pci_info(root_port, "Disabling No Snoop/Relaxed Ordering Attributes to avoid PCIe Completion erratum in %s\n",
 		 dev_name(&pdev->dev));
-	pcie_capability_clear_and_set_word(root_port, PCI_EXP_DEVCTL,
-					   PCI_EXP_DEVCTL_RELAX_EN |
-					   PCI_EXP_DEVCTL_NOSNOOP_EN, 0);
+	pcie_capability_clear_word(root_port, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN |
+				   PCI_EXP_DEVCTL_NOSNOOP_EN);
 }
 
 /*
-- 
2.30.2

