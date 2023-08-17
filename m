Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33CD77F641
	for <lists+linux-pci@lfdr.de>; Thu, 17 Aug 2023 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350750AbjHQMSG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Aug 2023 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350772AbjHQMRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Aug 2023 08:17:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62857213F;
        Thu, 17 Aug 2023 05:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692274664; x=1723810664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R2VJcnjcfK/eQ/uaWOm7WoczVjjrVrOfIYGsXogFgxg=;
  b=H0k+VwQL5ciwhegiNyMnQI0m7WPgJh6W3qpEMVyDIrJuDcdEw7d1KeQy
   a9Mo9No58dmirEC5D/MqVAtVtyex+GjcQnQzdf2YNgpbGOCv/URFZdESS
   zHNqlwbJjz/8Cxbzu3I879XFI02bO2Mnyng1h8L5dbG688m8bWiaAuJhE
   73PR+JYtm1PSOjjt6Cvgpw9o1xxUtGjWIqhfKSBReuTUnCyyO+7meC8kC
   QehtMISKzAmju1fojFSdGS4SHZ0HTwjS0NIDDAEsaOEm1LanhNl3+rTJ8
   zUfjcp8Z0SRJgmtL63dllzs1ECpsaaTISjVo+zzpAHLa2ZqnyOjAr5tDx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436696615"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436696615"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848872897"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="848872897"
Received: from lababeix-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.212.52])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 05:17:20 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 01/10] PCI: Protect Link Control 2 Register with RMW locking
Date:   Thu, 17 Aug 2023 15:16:59 +0300
Message-Id: <20230817121708.53213-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
References: <20230817121708.53213-1-ilpo.jarvinen@linux.intel.com>
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

PCIe Bandwidth Controller performs RMW accesses the Link Control 2
Register which can occur concurrently to other sources of Link Control
2 Register writes. Therefore, add Link Control 2 Register among the PCI
Express Capability Registers that need RMW locking.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 include/linux/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7ee498cd1f37..7b2927a90ee0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1243,6 +1243,7 @@ static inline int pcie_capability_clear_and_set_word(struct pci_dev *dev,
 {
 	switch (pos) {
 	case PCI_EXP_LNKCTL:
+	case PCI_EXP_LNKCTL2:
 	case PCI_EXP_RTCTL:
 		return pcie_capability_clear_and_set_word_locked(dev, pos,
 								 clear, set);
-- 
2.30.2

