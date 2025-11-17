Return-Path: <linux-pci+bounces-41384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2C4C6378D
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 11:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3F4E4EA891
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF99430C344;
	Mon, 17 Nov 2025 10:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMZhENjs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD7C27EC7C;
	Mon, 17 Nov 2025 10:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374271; cv=none; b=YapocsBCydWC39WgrRXnZzIF7M64DSkgNFifnXO+jlhDKMIU+flXvsLYLfF7bCpO6HgU9Q+TLKq68Ftow7rJtWTNw6um/1TaSUYyG+q14VWMTjKCcyBJCp8j7Id102iGsZ1sDu2OwPMxNe3feDGHIkBC9mcO3scVbEvmxbURPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374271; c=relaxed/simple;
	bh=oystiFFADSBJrwHDOWMJYGh8vuB+lAQYHlGZBn4zu7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WT5a0ZA5CjNPigpQxT7jVYSbSXJU8snD0BHW4ZXfUn+TtSUa2LcllSfXbD5KAjU6IAJEV0Sx1M6R++g2KTa2HX3u3pX+LBD2VoNcekn6DayVk6HBDUiMOv/bbR16SMN36nKSkxxlCjnOWJkA77qOStb0KFvnjwghRBKF3WjMhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMZhENjs; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763374270; x=1794910270;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=oystiFFADSBJrwHDOWMJYGh8vuB+lAQYHlGZBn4zu7k=;
  b=QMZhENjsUDsxuzXfsXEyvgh1gdBUQhwrwWTv3k9ObceeUHNHwT5vo5Fz
   XTV5H/LSxd5sj9VdwmexCHvNsHfYuG5iH5NPndYgiiMzNiMoUw0xb81J6
   rLzQKAu+Gr+k++wtg56+NJs3PdL6PrRN1Io362gI0G/Inq/1Yul6FAe6X
   ekuLJ9PyW6t1z1LQ8fVE0Z2E8Lg8q5XkB6h+fFVBVxEskKH1bBW0Q61zH
   ACDW/m+5nMaMnyOvFBBH+TJrGP43M/yFA7Xu9vQBvYIVsv8fVkm00aYbw
   DTRmC/jfrUlauDCMTa18xu8UGSZO/qCrPzv+wDecICBtS4+BETnrejWgg
   A==;
X-CSE-ConnectionGUID: TEQ1IiyGQdulaaKc6ejeTA==
X-CSE-MsgGUID: LBHWlJeuR6SRMpb6KMdKVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="90846864"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="90846864"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 02:11:09 -0800
X-CSE-ConnectionGUID: /wxsWJyJTQKf1VdkuxclVA==
X-CSE-MsgGUID: XUcjzIMvQiW+iXksmqxQ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; 
   d="scan'208";a="190426357"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO [10.245.246.29]) ([10.245.246.29])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 02:11:06 -0800
Message-ID: <19a3db41-0d39-40eb-948f-3288fbe3cac8@linux.intel.com>
Date: Mon, 17 Nov 2025 12:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] ASoC/SOF/PCI/Intel: Support for Nova Lake S
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com,
 pierre-louis.bossart@linux.dev, bhelgaas@google.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kw@linux.com
References: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20251104121650.21872-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Takashi,

On 04/11/2025 14:16, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Add information for the users of the PCI ID
> - Add Acked-by tag for the pci_ids.h from Bjorn
> - Add Acked-by tags from Mark for the ASoC patches
> 
> This series adds initial support for NVL-S from the Nova Lake family.
> NVL-S includes ACE4 audio subsystem, it has 2 DSP cores.

Would you consider to pick up this series for 6.19?

> 
> Regards,
> Peter
> ---
> Bard Liao (1):
>   ASoC: Intel: soc-acpi-intel-nvl-match: add rt722 l3 support
> 
> Peter Ujfalusi (6):
>   PCI: Add Intel Nova Lake S audio Device ID
>   ALSA: hda/hdmi: intelhdmi: add HDMI codec ID for Intel NVL
>   ASoC: Intel: soc-acpi: add NVL match tables
>   ASoC: SOF: Intel: add initial support for NVL-S
>   ALSA: hda: core: intel-dsp-config: Add support for NVL-S
>   ALSA: hda: controllers: intel: add support for Nova Lake S
> 
>  include/linux/pci_ids.h                       |  1 +
>  include/sound/soc-acpi-intel-match.h          |  2 +
>  sound/hda/codecs/hdmi/intelhdmi.c             |  1 +
>  sound/hda/controllers/intel.c                 |  2 +
>  sound/hda/core/intel-dsp-config.c             |  8 ++
>  sound/soc/intel/common/Makefile               |  1 +
>  .../intel/common/soc-acpi-intel-nvl-match.c   | 90 +++++++++++++++++++
>  sound/soc/sof/intel/Kconfig                   | 17 ++++
>  sound/soc/sof/intel/Makefile                  |  2 +
>  sound/soc/sof/intel/hda-dsp.c                 |  1 +
>  sound/soc/sof/intel/hda.h                     |  1 +
>  sound/soc/sof/intel/nvl.c                     | 55 ++++++++++++
>  sound/soc/sof/intel/nvl.h                     | 14 +++
>  sound/soc/sof/intel/pci-nvl.c                 | 82 +++++++++++++++++
>  sound/soc/sof/intel/shim.h                    |  1 +
>  15 files changed, 278 insertions(+)
>  create mode 100644 sound/soc/intel/common/soc-acpi-intel-nvl-match.c
>  create mode 100644 sound/soc/sof/intel/nvl.c
>  create mode 100644 sound/soc/sof/intel/nvl.h
>  create mode 100644 sound/soc/sof/intel/pci-nvl.c
> 

-- 
Péter


