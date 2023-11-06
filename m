Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4361F7E2251
	for <lists+linux-pci@lfdr.de>; Mon,  6 Nov 2023 13:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFMwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Nov 2023 07:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjKFMwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Nov 2023 07:52:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555C8B6;
        Mon,  6 Nov 2023 04:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699275161; x=1730811161;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ksjO7REBXQEKPi1wlrbUj9HrMuDV2WJEcaQRc/T5UtQ=;
  b=EeqJmeW0NpYB3Dhhp7Kqa4mlWCI2b9N/SKDf2e3jyXSXYrWWvqduxbLJ
   sJgrueSb+hi8FAI7G4VnEI/YcJpxHEnTvLM5MIXw6tXJmiF6oScVKORoL
   m9LzvyYc7VMsCyxfdczsLngrUro0OBY2ApyeRZHcCc5z5qny2FOFRKVbV
   mtX5f8vIvzl64PPkQaTcm98ScquMwyAW9lJ4zHxJIzUFw2oN0Pdc4b68K
   PK6/E90PBz+IvuauWBqmwtUdoaZ9JeaGA1D5aEzLDV0fS59LFW/idbuHB
   4jbCMWz5QGvyW72JBIB93ryQSS2NjGMKNGd8g0sygu1fo3Gitlh8oBNTh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="2176887"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="2176887"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:52:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="852989745"
X-IronPort-AV: E=Sophos;i="6.03,281,1694761200"; 
   d="scan'208";a="852989745"
Received: from rmstoi-mobl.ger.corp.intel.com ([10.251.216.76])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 04:52:33 -0800
Date:   Mon, 6 Nov 2023 14:52:31 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
cc:     Karol Herbst <kherbst@redhat.com>, Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        =?ISO-8859-15?Q?Pali_Roh=E1r?= <pali@kernel.org>,
        =?ISO-8859-15?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 8/9] PCI: Exclude PCIe ports used for tunneling in
 pcie_bandwidth_available()
In-Reply-To: <20231103190758.82911-9-mario.limonciello@amd.com>
Message-ID: <bdae1a8-d62-6af6-316d-1e3a5ac15bc@linux.intel.com>
References: <20231103190758.82911-1-mario.limonciello@amd.com> <20231103190758.82911-9-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 3 Nov 2023, Mario Limonciello wrote:

> The USB4 spec specifies that PCIe ports that are used for tunneling
> PCIe traffic over USB4 fabric will be hardcoded to advertise 2.5GT/s and
> behave as a PCIe Gen1 device. The actual performance of these ports is
> controlled by the fabric implementation.
> 
> Downstream drivers such as amdgpu which utilize pcie_bandwidth_available()
> to program the device will always find the PCIe ports used for
> tunneling as a limiting factor potentially leading to incorrect
> performance decisions.
> 
> To prevent problems in downstream drivers check explicitly for ports
> being used for PCIe tunneling and skip them when looking for bandwidth
> limitations of the hierarchy. If the only device connected is a root port
> used for tunneling then report that device.
> 
> Downstream drivers could make this change on their own but then they
> wouldn't be able to detect other potential speed bottlenecks from the
> hierarchy without duplicating pcie_bandwidth_available() logic.
> 
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2925#note_2145860
> Link: https://www.usb.org/document-library/usb4r-specification-v20
>       USB4 V2 with Errata and ECN through June 2023
>       Section 11.2.1
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pci.c | 74 +++++++++++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d9aa5a39f585..15e37164ce56 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6223,6 +6223,35 @@ int pcie_set_mps(struct pci_dev *dev, int mps)
>  }
>  EXPORT_SYMBOL(pcie_set_mps);
>  
> +static u32 pcie_calc_bw_limits(struct pci_dev *dev, u32 bw,
> +			       struct pci_dev **limiting_dev,
> +			       enum pci_bus_speed *speed,
> +			       enum pcie_link_width *width)
> +{
> +	enum pcie_link_width next_width;
> +	enum pci_bus_speed next_speed;
> +	u32 next_bw;
> +	u16 lnksta;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> +	next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> +	next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >> PCI_EXP_LNKSTA_NLW_SHIFT;
> +	next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
> +
> +	/* Check if current device limits the total bandwidth */
> +	if (!bw || next_bw <= bw) {
> +		bw = next_bw;
> +		if (limiting_dev)
> +			*limiting_dev = dev;
> +		if (speed)
> +			*speed = next_speed;
> +		if (width)
> +			*width = next_width;
> +	}
> +
> +	return bw;
> +}
> +
>  /**
>   * pcie_bandwidth_available - determine minimum link settings of a PCIe
>   *			      device and its bandwidth limitation
> @@ -6236,47 +6265,42 @@ EXPORT_SYMBOL(pcie_set_mps);
>   * limiting_dev, speed, and width pointers are supplied) information about
>   * that point.  The bandwidth returned is in Mb/s, i.e., megabits/second of
>   * raw bandwidth.
> + *
> + * This excludes the bandwidth calculation that has been returned from a
> + * PCIe device used for transmitting tunneled PCIe traffic over a Thunderbolt
> + * or USB4 link that is part of larger hierarchy. The calculation is excluded
> + * because the USB4 specification specifies that the max speed returned from
> + * PCIe configuration registers for the tunneling link is always PCI 1x 2.5 GT/s.
> + * When only tunneled devices are present, the bandwidth returned is the
> + * bandwidth available from the first tunneled device.
>   */
>  u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
>  			     enum pci_bus_speed *speed,
>  			     enum pcie_link_width *width)
>  {
> -	u16 lnksta;
> -	enum pci_bus_speed next_speed;
> -	enum pcie_link_width next_width;
> -	u32 bw, next_bw;
> +	struct pci_dev *tdev = NULL;
> +	u32 bw = 0;
>  
>  	if (speed)
>  		*speed = PCI_SPEED_UNKNOWN;
>  	if (width)
>  		*width = PCIE_LNK_WIDTH_UNKNOWN;
>  
> -	bw = 0;
> -
>  	while (dev) {
> -		pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
> -
> -		next_speed = pcie_link_speed[lnksta & PCI_EXP_LNKSTA_CLS];
> -		next_width = (lnksta & PCI_EXP_LNKSTA_NLW) >>
> -			PCI_EXP_LNKSTA_NLW_SHIFT;
> -
> -		next_bw = next_width * PCIE_SPEED2MBS_ENC(next_speed);
> -
> -		/* Check if current device limits the total bandwidth */
> -		if (!bw || next_bw <= bw) {
> -			bw = next_bw;
> -
> -			if (limiting_dev)
> -				*limiting_dev = dev;
> -			if (speed)
> -				*speed = next_speed;
> -			if (width)
> -				*width = next_width;
> +		if (dev->is_tunneled) {
> +			if (!tdev)
> +				tdev = dev;
> +			goto skip;
>  		}
> -
> +		bw = pcie_calc_bw_limits(dev, bw, limiting_dev, speed, width);
> +skip:
>  		dev = pci_upstream_bridge(dev);
>  	}
>  
> +	/* If nothing "faster" found on link, limit to first tunneled device */
> +	if (tdev && !bw)
> +		bw = pcie_calc_bw_limits(tdev, bw, limiting_dev, speed, width);
> +
>  	return bw;
>  }
>  EXPORT_SYMBOL(pcie_bandwidth_available);
> 

This patch should be split into two, where one just moves the code to the 
new function.

Also note that this will conflict with the FIELD_GET() changes (try to 
not reintroduce non-FIELD_GET() code when you rebase this on top of 
v6.7-rc1 :-)).

-- 
 i.

