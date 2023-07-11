Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4086C74EF87
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 14:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjGKM5K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 08:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGKM5J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 08:57:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C2018D;
        Tue, 11 Jul 2023 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689080229; x=1720616229;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jid2RuYbICnO2j6tUDkfKrrrf977lWFjcHoNG9Lge9A=;
  b=LQ5R8esKkntAkN2Y3MlQm0X86HPt3NmNGUsNBsFK142RZ/RgrwmGuMmq
   qV6nX3UOcZ8K7cm/GNOIfFDc2binvcbKQsdkQJhQ2z4FMipjrerLGfhga
   N8Lanu0QunDaZ22v5XegZbra2huOFDJVJg6XjLMXUCG00IDKpqJTRmHhj
   mRK0+USgsQMyTksih70PNNVD8tVnMMcWmOK4d7Nc77aMkJjkN70nz31Mk
   2HUlZkk0QX4qaNUt+81xVaP7gnMH61iwNbfZ9tAJQGnmmRshF5+0gzzkU
   5vUNVpqPQWjsn+aTN5f/PX8eqQIcmTRF4ietH2yfCgQ45sp9F/JAHpNpd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367187322"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="367187322"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 05:57:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="834666447"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="834666447"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2023 05:57:05 -0700
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
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 00/13] PCI: Define Intel PCI IDs and use them in drivers
Date:   Tue, 11 Jul 2023 14:57:13 +0200
Message-Id: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes from RFC:
 - Sort Intel PCI IDs before adding new ones
 - Fix ordering of new PCI IDs (Andy)
 - Define all used Intel IDs (Andy)
 - Add macros for controller type detection (Andy/Bjorn)
 - Add set of patches changing to use above macro (Andy/Bjorn)
 - Use PCI_DEVICE_DATA for Intel IDs in sound/pci/hda/hda_intel.c (Andy)
 - Commit message wording (Andy)
 - Remove unnecessary tabs (Andy)

Amadeusz Sławiński (13):
  PCI: Sort Intel PCI IDs by number
  PCI: Add Intel Audio DSP devices to pci_ids.h
  ALSA: hda: Add controller matching macros
  ALSA: hda: Use global PCI match macro
  ALSA: hda/i915:  Use global PCI match macro
  ASoC: Intel: Skylake: Use global PCI match macro
  ALSA: intel-dsp-config: Convert to PCI device IDs defines
  ALSA: hda: Convert to PCI device IDs defines
  ASoC: Intel: avs: Convert to PCI device IDs defines
  ASoC: Intel: avs: Convert to PCI device IDs defines
  ASoC: Intel: Skylake: Convert to PCI device IDs defines
  ASoC: SOF: Intel: Convert to PCI device IDs defines
  ASoC: Intel: sst: Convert to PCI device IDs defines

 include/linux/pci_ids.h                | 104 +++++--
 include/sound/hda_codec.h              |   3 -
 include/sound/hdaudio.h                |  27 ++
 sound/hda/hdac_i915.c                  |   7 +-
 sound/hda/intel-dsp-config.c           | 119 ++++----
 sound/pci/hda/hda_intel.c              | 373 ++++++++++---------------
 sound/soc/intel/atom/sst/sst.c         |   3 +-
 sound/soc/intel/atom/sst/sst.h         |   1 -
 sound/soc/intel/atom/sst/sst_pci.c     |   4 +-
 sound/soc/intel/avs/board_selection.c  |  10 +-
 sound/soc/intel/avs/core.c             |  16 +-
 sound/soc/intel/skylake/skl-messages.c |  16 +-
 sound/soc/intel/skylake/skl-pcm.c      |   3 +-
 sound/soc/intel/skylake/skl.c          |  36 +--
 sound/soc/sof/intel/pci-apl.c          |   9 +-
 sound/soc/sof/intel/pci-cnl.c          |  15 +-
 sound/soc/sof/intel/pci-icl.c          |  12 +-
 sound/soc/sof/intel/pci-mtl.c          |   3 +-
 sound/soc/sof/intel/pci-skl.c          |   6 +-
 sound/soc/sof/intel/pci-tgl.c          |  45 +--
 sound/soc/sof/intel/pci-tng.c          |   3 +-
 21 files changed, 384 insertions(+), 431 deletions(-)

-- 
2.34.1

