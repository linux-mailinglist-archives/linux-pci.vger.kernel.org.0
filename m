Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC47988EB
	for <lists+linux-pci@lfdr.de>; Fri,  8 Sep 2023 16:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjIHOgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 Sep 2023 10:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239320AbjIHOgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 Sep 2023 10:36:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABBC1BEE
        for <linux-pci@vger.kernel.org>; Fri,  8 Sep 2023 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694183796; x=1725719796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MtTuYVzgAE32qQ+dMGHmZdRmqYxsCxNAw7Yoz3zIOeg=;
  b=Z1oz7ish8/NnIORJS/7M3lIHJfc6OPg6igiBklblDF1sXsOKScIEHC0n
   Ng0tyE5cZj5kF+uvHYQuUTexPdCYK2vkCru/R2Vn8NhnLjgYeMAgoOZRb
   QpZgMaQx5p7aVVXi4aiILF1YIWYJz2Yw1mWhgl2qdrTIHz4KXBd/eNikb
   LplPvi0jTcg6UIEHD+Xx0J242IOD5FaakJhxy1oac1vuxCdqIJIfUijH8
   /zzXkST6wbWnJSM6Z7llakVCKoSgKntUEvlhrBn4kZoJiOdIGt+97zxgU
   YTv3Fh1GpOC3feg/0QuPeOoAg5eNvHyons/qnmRvhPwqlGzqmHeWePbPj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="362719512"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="362719512"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:36:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="808037710"
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="808037710"
Received: from bartoszp-dev.igk.intel.com ([10.91.3.51])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 07:36:33 -0700
From:   Bartosz Pawlowski <bartosz.pawlowski@intel.com>
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     sheenamo@google.com, justai@google.com,
        andriy.shevchenko@intel.com, joel.a.gibson@intel.com,
        emil.s.tantilov@intel.com, gaurav.s.emmanuel@intel.com,
        mike.conover@intel.com, shaopeng.he@intel.com,
        anthony.l.nguyen@intel.com, pavan.kumar.linga@intel.com,
        Bartosz Pawlowski <bartosz.pawlowski@intel.com>
Subject: [PATCH v2 0/2] PCI: Disable ATS for specific Intel IPU E2000 devices
Date:   Fri,  8 Sep 2023 14:36:04 +0000
Message-ID: <20230908143606.685930-1-bartosz.pawlowski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series addresses the problem with A an B steppings of
Intel IPU E2000 which expects incorrect endianness in data field of ATS
invalidation request TLP by disabling ATS capability for vulnerable
devices.

v2:
- Removed reference to SW workaround in code comment

Bartosz Pawlowski (2):
  PCI: Extract ATS disabling to a helper function
  PCI: Disable ATS for specific Intel IPU E2000 devices

 drivers/pci/quirks.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

-- 
2.41.0

