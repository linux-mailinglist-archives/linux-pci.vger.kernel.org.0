Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA4479BF25
	for <lists+linux-pci@lfdr.de>; Tue, 12 Sep 2023 02:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbjIKVjj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Sep 2023 17:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbjIKMyw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Sep 2023 08:54:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4ECEB;
        Mon, 11 Sep 2023 05:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694436887; x=1725972887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=icV8SsP9lTlQT1/vuwPuhc7cV1t/gtJOjQvxjYnKJJc=;
  b=G1dIvOTBrgSZFWWxpdmDDMeOvD/nX0RlC8BmwQlHsZFJmBslmWlZT9jL
   qifbA/mQj1FPCYf7JWpHatLZYeH5X8BB7V3zLAFFN3g5wwL8uq/BY9D2Y
   v6xsjuPuBA/SJ/9u+mEl07764CV+zomKs9nZmq0UX5p2RrC1tc7BL+619
   T1DjvDDChLfvvGhW8htgM1YqcYpamab+gU2mmo1ipcdiACxhwBpJX39qP
   SmcI/e05KSMXZlOaKmpMnyBtHlRxNne+3XQCjwex2UylOIp2MP5Vf3bPR
   Y3X9gQ0/GbmE/7cju0aqLLVJQXqaF57qzdHVxdG6hQyIU0d9RgRl/WFIL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="357511278"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="357511278"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="858304475"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="858304475"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:54:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org, Toan Le <toan@os.amperecomputing.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     3chas3@gmail.com, brking@us.ibm.com, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, ink@jurassic.park.msu.ru,
        jejb@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net,
        linux-scsi@vger.kernel.org, linux-sh@vger.kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com,
        netdev@vger.kernel.org, richard.henderson@linaro.org,
        ysato@users.sourceforge.jp,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 5/6] PCI: xgene: Do PCI error check on own line & keep return value
Date:   Mon, 11 Sep 2023 15:53:53 +0300
Message-Id: <20230911125354.25501-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
References: <20230911125354.25501-1-ilpo.jarvinen@linux.intel.com>
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

pci_generic_config_read32() already returns either PCIBIOS_SUCCESSFUL
or PCIBIOS_DEVICE_NOT_FOUND so it is enough to simply return its
return value when ret != PCIBIOS_SUCCESSFUL.

No functional changes intended.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/controller/pci-xgene.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/pci-xgene.c
index 887b4941ff32..8e457fa450a2 100644
--- a/drivers/pci/controller/pci-xgene.c
+++ b/drivers/pci/controller/pci-xgene.c
@@ -163,10 +163,11 @@ static int xgene_pcie_config_read32(struct pci_bus *bus, unsigned int devfn,
 				    int where, int size, u32 *val)
 {
 	struct xgene_pcie *port = pcie_bus_to_port(bus);
+	int ret;
 
-	if (pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val) !=
-	    PCIBIOS_SUCCESSFUL)
-		return PCIBIOS_DEVICE_NOT_FOUND;
+	ret = pci_generic_config_read32(bus, devfn, where & ~0x3, 4, val);
+	if (ret != PCIBIOS_SUCCESSFUL)
+		return ret;
 
 	/*
 	 * The v1 controller has a bug in its Configuration Request Retry
-- 
2.30.2

