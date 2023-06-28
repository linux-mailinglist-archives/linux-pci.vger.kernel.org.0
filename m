Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6565B7411A8
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jun 2023 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjF1Muf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jun 2023 08:50:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:59110 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230324AbjF1MuU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jun 2023 08:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687956620; x=1719492620;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FM06hAzUJYRZbdfF74LbkfHXkeBshKd+aj4zJ//1NoE=;
  b=U4sNzAeJUnHEFA6d+J84G1aXzy1p2HdRITlu6udaWH2BIvwwiIb6sqeb
   XGHezbe6t2+5Mw8vc6E3amO0Dj0aDtNcU70gPCVvw49Y+NoHISUeiLU+D
   j4+ZLRMWoIJQO+rWFnsZI70DcLKeDR7g/vtJUTpxdIaQyjewELglxUxz9
   Fro7DAMapmoXzLbCCVYIhx3w1a+CvMeoCnwj29FK18P05pUD3hPDOcKZj
   XZ9xHC0f+NABC9WZPZfvxwawdqw2mbqiuoLy5rjLUzFc1HuLx9KgLvHKF
   HXI5UXeZSDobNLtyrbCkIJPZavsFSr79nvTKuIJATWCbu0xl6c2aYtjIo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="361875550"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="361875550"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 05:50:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="891035024"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="891035024"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga005.jf.intel.com with ESMTP; 28 Jun 2023 05:50:15 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [RFC PATCH 0/8] PCI: Define Intel PCI IDs and use them in drivers
Date:   Wed, 28 Jun 2023 22:51:27 +0200
Message-Id: <20230628205135.517241-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
various configurations and historical reasons. Currently almost all uses
of HDA PCI IDs have corresponding comment telling which platform it is.
Additionally there are some inconsistencies between drivers about which
ID corresponds to which device.

Simplify things, by adding PCI IDs to global header and make use of them
in drivers. This allows for removal of comments by having IDs themselves
being self explanatory. Additionally it allows for removal of existing
inconsistencies by having one source of truth.

Amadeusz Sławiński (8):
  PCI: Add Intel Audio DSP devices to pci_ids.h
  ALSA: intel-dsp-config: Update PCI ID list
  ALSA: hda: Update PCI ID list
  ALSA: hda/i915: Update PCI IDs
  ASoC: Intel: avs: Update PCI ID list
  ASoC: Intel: avs: Update PCI ID list
  ASoC: Intel: Skylake: Update PCI ID list
  ASoC: SOF: Intel: Update PCI ID list

 include/linux/pci_ids.h                |  44 ++++
 sound/hda/hdac_i915.c                  |   8 +-
 sound/hda/intel-dsp-config.c           | 119 +++++-----
 sound/pci/hda/hda_intel.c              | 292 ++++++++++++-------------
 sound/soc/intel/avs/board_selection.c  |  10 +-
 sound/soc/intel/avs/core.c             |  16 +-
 sound/soc/intel/skylake/skl-messages.c |  16 +-
 sound/soc/intel/skylake/skl.c          |  36 +--
 sound/soc/sof/intel/pci-apl.c          |   9 +-
 sound/soc/sof/intel/pci-cnl.c          |  15 +-
 sound/soc/sof/intel/pci-icl.c          |  12 +-
 sound/soc/sof/intel/pci-mtl.c          |   3 +-
 sound/soc/sof/intel/pci-skl.c          |   6 +-
 sound/soc/sof/intel/pci-tgl.c          |  45 ++--
 sound/soc/sof/intel/pci-tng.c          |   3 +-
 15 files changed, 311 insertions(+), 323 deletions(-)

-- 
2.34.1

