Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ACE789F95
	for <lists+linux-pci@lfdr.de>; Sun, 27 Aug 2023 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjH0Ni2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Aug 2023 09:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjH0Nh5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 27 Aug 2023 09:37:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D364B6;
        Sun, 27 Aug 2023 06:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693143472; x=1724679472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XsgnyeH+vKrvqCa5oSfNV41+itOz4CsaFKKgFslGD+E=;
  b=MxqU1T2UJf5/r5VBZ7QO8LBLw/Xqnpgr8NCSpExOwnPnB9bs2HPurshm
   CW9YS82HkwktR1gxx6qDxqN0SCKR9CSnHZzuq+qrZ+8IwJiL549qoa/Yd
   k0ozldLnNNThTedMiQD054VKP36bToKt6vyQxI/SakLGCaDwOhQOHhkEC
   9oUpUBJwI4hL8DKd5lqVzSXQO4GUiENJhKUyVF7S/REf0I50xp5AaA99+
   z/8EIenUBmvHSMRD2Vy4E6zy+zwFetXsTeo/5U+5KfWmuwojTKjLHnq7E
   X8Rag/yjC9MwVfRIrs2lBB6XOIkUYAzm/qUltQWovVv1ISG98bgCybx6H
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="354471047"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="354471047"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:37:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="1068752191"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="1068752191"
Received: from dplotkin-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.41.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 06:37:48 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 7/8] PCI: xgene: Do PCI error check on own line
Date:   Sun, 27 Aug 2023 16:37:04 +0300
Message-Id: <20230827133705.12991-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com>
References: <20230827133705.12991-1-ilpo.jarvinen@linux.intel.com>
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

Instead of a if condition with a line split, use the usual error
handling pattern with a separate variable to improve readability.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-xgene.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 887b4941ff32..b7f338de160b 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -163,9 +163,10 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
 	struct xgene_pcie *port = pcie_bus_to_port(bus);
+	int ret;
 
-	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
-	    PCIBIOS_SUCCESSFUL)
+	ret = pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val);
+	if (ret != PCIBIOS_SUCCESSFUL)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
 	/*
-- 
2.30.2

