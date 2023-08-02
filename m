Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AFF76D12A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Aug 2023 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjHBPMk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Aug 2023 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbjHBPMk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Aug 2023 11:12:40 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529D626AD
        for <linux-pci@vger.kernel.org>; Wed,  2 Aug 2023 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690989156; x=1722525156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ak7u4/RSbAqkTh6GICrJIv3mH73UUyut/H4Rn5Lext4=;
  b=V90ZgmppRghrDyRvzFFv0xTYXoYH5a2i1Zn8R65UyAf6vAMl8Tt1qhVb
   1qqLCgYB0WtgyQYl9NKkWFRhsKM73k52iAOPJzgKgqiJqpu/8kdrxZrcc
   Tj6WhcGAvSebrGZz+pSlH9iBV9U7yuB6OF8gDHrj/QlmJpM1rxHbob4Sm
   Nt6/MfNeLbHuTxPXy5siswuQbWdZv2Bsc9n2zfZaFLb3mY7/qoRJE+c9A
   WZTApKvtGSkGN0eatDB2WY5mNYckaittF3Ith5UsYLmYVSHxHYRrSkd4X
   TXmgIAG+VPOwuNpnpuUs8uU13Twd1Me5rGtT2AQsypWFKubbb5SY38Nmm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369607240"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="369607240"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:01:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732428668"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="732428668"
Received: from rickylop-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.125.114])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 08:01:12 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/5] ALSA/PCI: hda: add ARL-S support, config for MTL/LNL
Date:   Wed,  2 Aug 2023 10:01:00 -0500
Message-Id: <20230802150105.24604-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
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

Add a new PCI ID and i915 connectivity check for ArrowLake-S, and
configuration updates for MTL/LNL.

Kai Vehmanen (2):
  ALSA: hda: add HD Audio PCI ID for Intel Arrow Lake-S
  ALSA: hda/i915: extend connectivity check to cover Intel ARL

Pierre-Louis Bossart (3):
  PCI: add ArrowLake-S PCI ID for Intel HDAudio subsystem.
  ALSA: hda: intel-dsp-cfg: use common include for MeteorLake
  ALSA: hda: intel-dsp-cfg: add LunarLake support

 include/linux/pci_ids.h      |  1 +
 sound/hda/hdac_i915.c        | 14 ++++++++++----
 sound/hda/intel-dsp-config.c | 10 +++++++++-
 sound/pci/hda/hda_intel.c    |  2 ++
 4 files changed, 22 insertions(+), 5 deletions(-)

-- 
2.39.2

