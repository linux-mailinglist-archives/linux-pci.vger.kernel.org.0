Return-Path: <linux-pci+bounces-43034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6099CBD27A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 10:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BC6FE30006C5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 09:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D9E32AAAB;
	Mon, 15 Dec 2025 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wg1W9/5q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99302227B95;
	Mon, 15 Dec 2025 09:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765790639; cv=none; b=sYWHt5nL32SQsai7/N+Bpaf/Fgf5kz0xwoHiqSkYfWkhdC6zHCFDMLltxR/yWmNzn4hLgHtKy2uNmlhxeFuaLtEpuFS1zsVfwAbJ/kQMD3adaQdhRc8my/af40l2YbybZY1Fb3nntzFb6vk04ypAl3m9T5PB++j6fwyP3x9lNLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765790639; c=relaxed/simple;
	bh=uEYPyaHoEB2Eb2eC1eG54sqkW5lWByTj6rN0DOD2uTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewFMl0yQBAMr469QHnL0qrj85w3YSjJZ5IV1R7hxx883pJXWpr/Q6ZVNrm+3xFw0awA7bOXC6kJPXWBYv0ssVBM19jWyOTnbXpVrR3eZbA69apz/rKZMEjs1AuqDnsk/BBBfQs0rTwfe55hTYloYQLlOPk+pwlnCSk+O5m52hhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wg1W9/5q; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765790637; x=1797326637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uEYPyaHoEB2Eb2eC1eG54sqkW5lWByTj6rN0DOD2uTU=;
  b=Wg1W9/5qzFeqRvbYSBgvqi1Gvk+FuDab2/jvubgDZcsIjO1sJtGRSv8e
   2BdLFGUdQSRz4rN6JvPlMGD9TXRv3D33RDAYIAnWVp5WVuEeykpe3DpH/
   QO9rOFANtYiErLgkOeWjO4J48XdQ3ma64iZXJfUEgoSr8Q6V3ouC3xVPj
   f1g0mEAaUL3xmYMyg7veRsmdz4rp+Gu3kLt/sjc1KUhFz4kc+8GUEgojz
   TyIrMGhHgfqtBElmCw7heTcoM3+WaI6F4OY0caXvPnSypX1MYwmrN/1NM
   MGHIcQQCpNX/tjSR/YD/xRQcs1TmQg13y2R44ahDi9C2jGqMeVeA9h/70
   w==;
X-CSE-ConnectionGUID: pG3gTkDcRp6pMtIn0M1utA==
X-CSE-MsgGUID: W8WSxC93R8eaa+J39dLkiQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="78804026"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="78804026"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 01:23:56 -0800
X-CSE-ConnectionGUID: LfnxrILlRhyTqjKfXvyH6g==
X-CSE-MsgGUID: hZMjoEI/Suaq8RLwCVIraQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; 
   d="scan'208";a="202782192"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO [10.245.246.95]) ([10.245.246.95])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2025 01:23:52 -0800
Message-ID: <5b228a44-d421-46ac-8c93-31b95984bdad@linux.intel.com>
Date: Mon, 15 Dec 2025 11:24:16 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] ASoC: Fix acronym for Intel Gemini Lake
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Takashi Iwai <tiwai@suse.de>, Cezary Rojewski <cezary.rojewski@intel.com>,
 Mark Brown <broonie@kernel.org>,
 =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 sound-open-firmware@alsa-project.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Daniel Baluta <daniel.baluta@nxp.com>
References: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20251212181742.3944789-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/12/2025 20:16, Andy Shevchenko wrote:
> While the used GML is consistent with the pattern for other Intel * Lake
> SoCs, the de facto use is GLK. Update the acronym and users accordingly.
> 
> Note, a handful of the drivers for Gemini Lake in the Linux kernel use
> GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
> The only ones in this patch used the inconsistent one.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci_ids.h
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> v2: added tag (Bjorn), left variable name as is (Cezary), added comment (Cezary)

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
>  include/linux/pci_ids.h               | 3 ++-
>  sound/hda/controllers/intel.c         | 2 +-
>  sound/hda/core/intel-dsp-config.c     | 4 ++--
>  sound/soc/intel/avs/board_selection.c | 2 +-
>  sound/soc/intel/avs/core.c            | 2 +-
>  sound/soc/sof/intel/pci-apl.c         | 2 +-
>  6 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a9a089566b7c..84b830036fb4 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2950,7 +2950,8 @@
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
> -#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
> +/* In a few of the Intel documents the GML acronym is used for Gemini Lake */
> +#define PCI_DEVICE_ID_INTEL_HDA_GLK	0x3198
>  #define PCI_DEVICE_ID_INTEL_82855PM_HB	0x3340
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG4	0x3429
>  #define PCI_DEVICE_ID_INTEL_IOAT_TBG5	0x342a
> diff --git a/sound/hda/controllers/intel.c b/sound/hda/controllers/intel.c
> index 1e8e3d61291a..bb9a64d41580 100644
> --- a/sound/hda/controllers/intel.c
> +++ b/sound/hda/controllers/intel.c
> @@ -2555,7 +2555,7 @@ static const struct pci_device_id azx_ids[] = {
>  	/* Apollolake (Broxton-P) */
>  	{ PCI_DEVICE_DATA(INTEL, HDA_APL, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>  	/* Gemini-Lake */
> -	{ PCI_DEVICE_DATA(INTEL, HDA_GML, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, AZX_DRIVER_SKL | AZX_DCAPS_INTEL_BROXTON) },
>  	/* Haswell */
>  	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_0, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
>  	{ PCI_DEVICE_DATA(INTEL, HDA_HSW_2, AZX_DRIVER_HDMI | AZX_DCAPS_INTEL_HASWELL) },
> diff --git a/sound/hda/core/intel-dsp-config.c b/sound/hda/core/intel-dsp-config.c
> index 0c25e87408de..ddb8db3e8e39 100644
> --- a/sound/hda/core/intel-dsp-config.c
> +++ b/sound/hda/core/intel-dsp-config.c
> @@ -154,7 +154,7 @@ static const struct config_entry config_table[] = {
>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_GEMINILAKE)
>  	{
>  		.flags = FLAG_SOF,
> -		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
> +		.device = PCI_DEVICE_ID_INTEL_HDA_GLK,
>  		.dmi_table = (const struct dmi_system_id []) {
>  			{
>  				.ident = "Google Chromebooks",
> @@ -167,7 +167,7 @@ static const struct config_entry config_table[] = {
>  	},
>  	{
>  		.flags = FLAG_SOF,
> -		.device = PCI_DEVICE_ID_INTEL_HDA_GML,
> +		.device = PCI_DEVICE_ID_INTEL_HDA_GLK,
>  		.codec_hid =  &essx_83x6,
>  	},
>  #endif
> diff --git a/sound/soc/intel/avs/board_selection.c b/sound/soc/intel/avs/board_selection.c
> index 52e6266a7cb8..8a46285181fa 100644
> --- a/sound/soc/intel/avs/board_selection.c
> +++ b/sound/soc/intel/avs/board_selection.c
> @@ -367,7 +367,7 @@ static const struct avs_acpi_boards i2s_boards[] = {
>  	AVS_MACH_ENTRY(HDA_SKL_LP,	avs_skl_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_KBL_LP,	avs_kbl_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_APL,		avs_apl_i2s_machines),
> -	AVS_MACH_ENTRY(HDA_GML,		avs_gml_i2s_machines),
> +	AVS_MACH_ENTRY(HDA_GLK,		avs_gml_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_CNL_LP,	avs_cnl_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_CNL_H,	avs_cnl_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_CML_LP,	avs_cnl_i2s_machines),
> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
> index 6e0e65584c7f..1a53856c2ffb 100644
> --- a/sound/soc/intel/avs/core.c
> +++ b/sound/soc/intel/avs/core.c
> @@ -897,7 +897,7 @@ static const struct pci_device_id avs_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, HDA_KBL_H, &skl_desc) },
>  	{ PCI_DEVICE_DATA(INTEL, HDA_CML_S, &skl_desc) },
>  	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &apl_desc) },
> -	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &apl_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, &apl_desc) },
>  	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_LP,	&cnl_desc) },
>  	{ PCI_DEVICE_DATA(INTEL, HDA_CNL_H,	&cnl_desc) },
>  	{ PCI_DEVICE_DATA(INTEL, HDA_CML_LP,	&cnl_desc) },
> diff --git a/sound/soc/sof/intel/pci-apl.c b/sound/soc/sof/intel/pci-apl.c
> index 0bf7ee753bc3..3241403efa60 100644
> --- a/sound/soc/sof/intel/pci-apl.c
> +++ b/sound/soc/sof/intel/pci-apl.c
> @@ -86,7 +86,7 @@ static const struct sof_dev_desc glk_desc = {
>  /* PCI IDs */
>  static const struct pci_device_id sof_pci_ids[] = {
>  	{ PCI_DEVICE_DATA(INTEL, HDA_APL, &bxt_desc) },
> -	{ PCI_DEVICE_DATA(INTEL, HDA_GML, &glk_desc) },
> +	{ PCI_DEVICE_DATA(INTEL, HDA_GLK, &glk_desc) },
>  	{ 0, }
>  };
>  MODULE_DEVICE_TABLE(pci, sof_pci_ids);

-- 
Péter


