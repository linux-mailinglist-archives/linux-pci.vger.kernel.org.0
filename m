Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E27538E3
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jul 2023 12:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbjGNKzE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jul 2023 06:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjGNKzE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jul 2023 06:55:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AA130FA;
        Fri, 14 Jul 2023 03:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689332103; x=1720868103;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cL+iOP33aHs+u6cHLRGi+E0JMjOKGZJJ+7CXN6XHEtk=;
  b=EqtLJv3NR3mAlo1hFDhWVUPyBvVIeTHAqTQ9bFq4AC5K1k8fuORZXi4i
   dfVVIXLR3YMXegl4T3FChoFVd7lz97Fn4IbLlI9QtVn2H205ei8/Ukc2w
   tJSHg8ouAF9bdwnefIXlsDI9GAd3XyAvQ03CUBpJH6Jj3WHdha0daLO+P
   H2OsXuaocCi04BVoAMFYClJuXmzyeDKNTMQy4/jLwIUzdcniWIMTp7E5Y
   jcuwyLgUmHThzxXn1WVbqX+2759uwWX4D/CbNHmrfrWfkhge9palFGBx3
   k5gTHOjnueEI516jextlek5xf0/XCDheQNFci0XskzwlOHNwfaBrkd77O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364321106"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="364321106"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="722365344"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="722365344"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 03:54:59 -0700
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
Subject: [PATCH v2 00/15] PCI: Define Intel PCI IDs and use them in drivers
Date:   Fri, 14 Jul 2023 20:56:00 +0200
Message-Id: <20230714185615.370597-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes from v1:
 - Remove BXT-T PCI ID as it is not released (Andy)
 - Reorder macros to start from pci_match_id() (Andy)
 - Add comment about BXT->APL name change in commit messages (Andy)
 - Use SST as part of macro name for DSP only devices (Andy)
 - Add PCI IDs for all SST combinations (Andy)

Changes from RFC:
 - Sort Intel PCI IDs before adding new ones
 - Fix ordering of new PCI IDs (Andy)
 - Define all used Intel IDs (Andy)
 - Add macros for controller type detection (Andy/Bjorn)
 - Add set of patches changing to use above macro (Andy/Bjorn)
 - Use PCI_DEVICE_DATA for Intel IDs in sound/pci/hda/hda_intel.c (Andy)
 - Commit message wording (Andy)
 - Remove unnecessary tabs (Andy)

Amadeusz Sławiński (15):
  PCI: Sort Intel PCI IDs by number
  PCI: Add Intel Audio DSP devices to pci_ids.h
  ASoC: SOF: Remove unused Broxton PCI ID
  ALSA: Remove unused Broxton PCI ID
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

 include/linux/pci_ids.h                | 105 +++++--
 include/sound/hda_codec.h              |   3 -
 include/sound/hdaudio.h                |  26 ++
 sound/hda/hdac_i915.c                  |   7 +-
 sound/hda/intel-dsp-config.c           | 124 ++++----
 sound/pci/hda/hda_intel.c              | 373 ++++++++++---------------
 sound/soc/intel/atom/sst/sst.c         |   7 +-
 sound/soc/intel/atom/sst/sst.h         |   3 -
 sound/soc/intel/atom/sst/sst_pci.c     |   4 +-
 sound/soc/intel/avs/board_selection.c  |  10 +-
 sound/soc/intel/avs/core.c             |  16 +-
 sound/soc/intel/skylake/skl-messages.c |  16 +-
 sound/soc/intel/skylake/skl-pcm.c      |   3 +-
 sound/soc/intel/skylake/skl.c          |  36 +--
 sound/soc/sof/intel/pci-apl.c          |   8 +-
 sound/soc/sof/intel/pci-cnl.c          |  15 +-
 sound/soc/sof/intel/pci-icl.c          |  12 +-
 sound/soc/sof/intel/pci-mtl.c          |   3 +-
 sound/soc/sof/intel/pci-skl.c          |   6 +-
 sound/soc/sof/intel/pci-tgl.c          |  45 +--
 sound/soc/sof/intel/pci-tng.c          |   3 +-
 21 files changed, 383 insertions(+), 442 deletions(-)

-- 
2.34.1

