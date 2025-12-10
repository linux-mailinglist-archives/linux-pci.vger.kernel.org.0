Return-Path: <linux-pci+bounces-42898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62124CB3558
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 16:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76D01303B2C5
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45BE275844;
	Wed, 10 Dec 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJHpKEVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75092242D6C;
	Wed, 10 Dec 2025 15:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765381126; cv=none; b=cI/Xi7bkmNwoAF0Dd55Xz4hGht4FgN7IjZOYzN3iZ4reOphryjNYmA74G74o7qOqJ44/uWIB4zsY/PNK88CYSXHV+tFKn+Bc/w7Mt+x2dJjsuZQWTuI2AcpztpvOQ+MraL+P8esCOtrUN3C+kxREMOfr612TkoMm56NCXn+jYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765381126; c=relaxed/simple;
	bh=GOmDtZENW6EKkY01HzNCs2/Yhr5b1s1awjq3kaU+9QU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NFvLH8e5nNSHKsBhu9Q5wHB1CkccUb7okfP+FbztIBvsTCqeV0ia+0HJ0xk9p8xgYYG5SsL3VW5mZC3V+sF9LC4gZz50KW9w4XRM0CJuDqcJpunzC1EsV/pxLPhmwZap8aG3ccoxrYQ9IIiGsFtngT2V3M1++1Ed6u1FbXG8dYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJHpKEVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AFBC4CEF1;
	Wed, 10 Dec 2025 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765381126;
	bh=GOmDtZENW6EKkY01HzNCs2/Yhr5b1s1awjq3kaU+9QU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MJHpKEVvXqdQSzbaBLxJMU/i2W2fQnRjoJYwlyPC+HuDkDPKA/p5LfjRCRqq1GG67
	 8AbCo57Zl+uhaPtwXJNANYQr5zY18ht2XBnk1gaQLgr0vQGO6qw6u2Q2e4R9E6hEfM
	 86u6AWO72saCEz8fJz5Ti3J+jlu4BQ/gAPod+hst7pNO25LuN2V9NjMZ4q1md5YDO7
	 PfhauqdsIsMoM/DTjQ+xY1ir6jiCFH8Fa8xYBP7uarYshsz+iv2MtI8aWSUyRz/HCw
	 GWl+qRlnsTSs44sHDQ27LiKEz65rlC/zdsXt96s6aExERwdwq38SpyLJJiIVZ6xbl+
	 su0FllNSzUlFg==
Date: Wed, 10 Dec 2025 09:38:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	Mark Brown <broonie@kernel.org>,
	Amadeusz =?utf-8?B?U8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v1 1/1] ASoC: Fix acronym for Intel Gemini Lake
Message-ID: <20251210153844.GA3526399@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210115545.3028551-1-andriy.shevchenko@linux.intel.com>

On Wed, Dec 10, 2025 at 12:55:44PM +0100, Andy Shevchenko wrote:
> While the used GML is consistent with the pattern for other Intel * Lake
> SoCs, the de facto use is GLK. Update the acronym and users accordingly.
> 
> Note, a handful of the drivers for Gemini Lake in the Linux kernel use
> GLK already (LPC, MEI, pin control, SDHCI, ...) and even some in ASoC.
> The only ones in this patch used the inconsistent one.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com> # pci_ids.h

> ---
>  include/linux/pci_ids.h               | 2 +-
>  sound/hda/controllers/intel.c         | 2 +-
>  sound/hda/core/intel-dsp-config.c     | 4 ++--
>  sound/soc/intel/avs/board_selection.c | 4 ++--
>  sound/soc/intel/avs/core.c            | 2 +-
>  sound/soc/sof/intel/pci-apl.c         | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index a9a089566b7c..22b8cfc11add 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2950,7 +2950,7 @@
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_ADDR_REV2  0x2db1
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_RANK_REV2  0x2db2
>  #define PCI_DEVICE_ID_INTEL_LYNNFIELD_MC_CH2_TC_REV2    0x2db3
> -#define PCI_DEVICE_ID_INTEL_HDA_GML	0x3198
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
> index c401c0658421..948fd468d2fe 100644
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
> index 52e6266a7cb8..46723618d458 100644
> --- a/sound/soc/intel/avs/board_selection.c
> +++ b/sound/soc/intel/avs/board_selection.c
> @@ -227,7 +227,7 @@ static struct snd_soc_acpi_mach avs_apl_i2s_machines[] = {
>  	{},
>  };
>  
> -static struct snd_soc_acpi_mach avs_gml_i2s_machines[] = {
> +static struct snd_soc_acpi_mach avs_glk_i2s_machines[] = {
>  	{
>  		.id = "INT343A",
>  		.drv_name = "avs_rt298",
> @@ -367,7 +367,7 @@ static const struct avs_acpi_boards i2s_boards[] = {
>  	AVS_MACH_ENTRY(HDA_SKL_LP,	avs_skl_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_KBL_LP,	avs_kbl_i2s_machines),
>  	AVS_MACH_ENTRY(HDA_APL,		avs_apl_i2s_machines),
> -	AVS_MACH_ENTRY(HDA_GML,		avs_gml_i2s_machines),
> +	AVS_MACH_ENTRY(HDA_GLK,		avs_glk_i2s_machines),
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
> -- 
> 2.50.1
> 

