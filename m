Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C71174F340
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 17:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGKPYP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jul 2023 11:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjGKPYN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jul 2023 11:24:13 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62407133;
        Tue, 11 Jul 2023 08:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689089052; x=1720625052;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=la1QVq4HIgIr0eEz8hF9KkZUQTqFiyIfgzdHWOn/i40=;
  b=oJKaddIgrAjmy0070MOPtU21aJqaP+jghjsDCjOqlSV4qH9ImYbIoP7+
   xO/zf7U48GENOHTIjjCjfSIKqaq8ygw2SRoyfBo+ree2LQgmX8I9f/A0+
   Ay4VyoeZ6f+rS9PacyIAEQyXufPPXS4nd4hnaN2dJQFg8fCGgjg0TMMMV
   atgwbkwzpY/h2HytE3gap/nQNF13x3Z0JJcI2s9f0+GdXCWYkDDKT7ZTm
   0MLeC2R4YXOoFQz/1X+dP/s/hHW400VDY2RTkXEe8m95hCfAPC1rNPqcV
   rEY6gNuaBNWoeeu7cg8jdSAOts5magNR03++LAtgOIkeFM+VTKYiUqFKv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="344246898"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="344246898"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 08:24:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="791241368"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="791241368"
Received: from pratipro-mobl1.ger.corp.intel.com (HELO [10.252.44.140]) ([10.252.44.140])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 08:24:09 -0700
Message-ID: <bc2484ba-3bb2-7d74-fcd1-55c9ec253b9c@linux.intel.com>
Date:   Tue, 11 Jul 2023 17:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
Subject: Re: [PATCH 00/13] PCI: Define Intel PCI IDs and use them in drivers
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
References: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20230711125726.3509391-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 7/11/23 14:57, Amadeusz Sławiński wrote:
> PCI IDs for Intel HDA are duplicated across quite a few drivers, due to
> various configurations and historical reasons. Currently almost all uses
> of HDA PCI IDs have corresponding comment telling which platform it is.
> Additionally there are some inconsistencies between drivers about which
> ID corresponds to which device.
> 
> Simplify things, by adding PCI IDs to global header and make use of them
> in drivers. This allows for removal of comments by having IDs themselves
> being self explanatory. Additionally it allows for removal of existing
> inconsistencies by having one source of truth.

I'd like to hear from Takashi and Mark on how this would work, we have
to provide new PCI IDs for both trees using a common 'pci_ids.h' file.

It's not science fiction, we have new PCI IDs for ArrowLake and LunarLake:

https://github.com/thesofproject/linux/pull/4437
https://github.com/thesofproject/linux/pull/4425

> Changes from RFC:
>  - Sort Intel PCI IDs before adding new ones
>  - Fix ordering of new PCI IDs (Andy)
>  - Define all used Intel IDs (Andy)
>  - Add macros for controller type detection (Andy/Bjorn)
>  - Add set of patches changing to use above macro (Andy/Bjorn)
>  - Use PCI_DEVICE_DATA for Intel IDs in sound/pci/hda/hda_intel.c (Andy)
>  - Commit message wording (Andy)
>  - Remove unnecessary tabs (Andy)
> 
> Amadeusz Sławiński (13):
>   PCI: Sort Intel PCI IDs by number
>   PCI: Add Intel Audio DSP devices to pci_ids.h
>   ALSA: hda: Add controller matching macros
>   ALSA: hda: Use global PCI match macro
>   ALSA: hda/i915:  Use global PCI match macro
>   ASoC: Intel: Skylake: Use global PCI match macro
>   ALSA: intel-dsp-config: Convert to PCI device IDs defines
>   ALSA: hda: Convert to PCI device IDs defines
>   ASoC: Intel: avs: Convert to PCI device IDs defines
>   ASoC: Intel: avs: Convert to PCI device IDs defines
>   ASoC: Intel: Skylake: Convert to PCI device IDs defines
>   ASoC: SOF: Intel: Convert to PCI device IDs defines
>   ASoC: Intel: sst: Convert to PCI device IDs defines
> 
>  include/linux/pci_ids.h                | 104 +++++--
>  include/sound/hda_codec.h              |   3 -
>  include/sound/hdaudio.h                |  27 ++
>  sound/hda/hdac_i915.c                  |   7 +-
>  sound/hda/intel-dsp-config.c           | 119 ++++----
>  sound/pci/hda/hda_intel.c              | 373 ++++++++++---------------
>  sound/soc/intel/atom/sst/sst.c         |   3 +-
>  sound/soc/intel/atom/sst/sst.h         |   1 -
>  sound/soc/intel/atom/sst/sst_pci.c     |   4 +-
>  sound/soc/intel/avs/board_selection.c  |  10 +-
>  sound/soc/intel/avs/core.c             |  16 +-
>  sound/soc/intel/skylake/skl-messages.c |  16 +-
>  sound/soc/intel/skylake/skl-pcm.c      |   3 +-
>  sound/soc/intel/skylake/skl.c          |  36 +--
>  sound/soc/sof/intel/pci-apl.c          |   9 +-
>  sound/soc/sof/intel/pci-cnl.c          |  15 +-
>  sound/soc/sof/intel/pci-icl.c          |  12 +-
>  sound/soc/sof/intel/pci-mtl.c          |   3 +-
>  sound/soc/sof/intel/pci-skl.c          |   6 +-
>  sound/soc/sof/intel/pci-tgl.c          |  45 +--
>  sound/soc/sof/intel/pci-tng.c          |   3 +-
>  21 files changed, 384 insertions(+), 431 deletions(-)
> 
