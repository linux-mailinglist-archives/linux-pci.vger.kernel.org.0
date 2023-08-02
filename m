Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B8476D129
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjHBPMj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjHBPMj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:12:39 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A732130
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 08:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989155; x=1722525155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTpU3YPygDX+4cqxAGZDUye/uEWEAh28w5ZEcpcqEhE=;
  b=Q8XxTYKZ4WJZnpzHp7tb8iXcdvaUPKBA7KsTts8R1UsQZWCvqDRcyvOc
   iqCSigNutD8OYEmTHD465LX7w6GOjHkzXXdPYOAWl+Ajt0IqiHrKkojHC
   DghaEM17OLDeaYA+r59+CmYZHJhGqr+0vTcHTFvpXuuMAaGPQ6jLtA6ud
   b/wwqXmdFz03yzfvPZxxk07cE0gnlJqsXWpZqJY8Epycj0+LAgaUJg2M6
   xMNeTvsvQ4wseRm7ZkR5hUEMxfdCUnR+xXaCyuATuIWmNaJEkS6qvdAji
   NBal9hxcr8y3dRfThh5DPRzb/I+IpRYgbsKsxf5a0sQN2PQUs37/ROObL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369607251"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="369607251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:01:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732428672"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="732428672"
Received: from rickylop-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.125.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:01:13 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 1/5] PCI: add ArrowLake-S PCI ID for Intel HDAudio subsystem.
Date:   Wed,  2 Aug 2023 10:01:01 -0500
Message-Id: <20230802150105.24604-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
References: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add part ID to common include file

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 3066660cd39b..a6411aa4c331 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -3058,6 +3058,7 @@
 #define PCI_DEVICE_ID_INTEL_HDA_RPL_S	0x7a50
 #define PCI_DEVICE_ID_INTEL_HDA_ADL_S	0x7ad0
 #define PCI_DEVICE_ID_INTEL_HDA_MTL	0x7e28
+#define PCI_DEVICE_ID_INTEL_HDA_ARL_S	0x7f50
 #define PCI_DEVICE_ID_INTEL_SCH_LPC	0x8119
 #define PCI_DEVICE_ID_INTEL_SCH_IDE	0x811a
 #define PCI_DEVICE_ID_INTEL_HDA_POULSBO	0x811b
-- 
2.39.2

