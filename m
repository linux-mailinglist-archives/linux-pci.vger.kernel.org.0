Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67707E098C
	for <lists+linux-pci@lfdr.de>; Fri,  3 Nov 2023 20:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbjKCTjM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Nov 2023 15:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjKCTjL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Nov 2023 15:39:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D032D5C
        for <linux-pci@vger.kernel.org>; Fri,  3 Nov 2023 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699040307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=18fxGFPyEfYX6zujRVQDCVGp1gVPnAg8xcOJqGUDNpU=;
        b=WEkItedecRds0qOcBxKgV+BlXanqPNvIhVM5BPB+KWD42h5LD+wCXlA7+0afMHD2HRzct6
        aw1oH+KuwFhmX5ToyHwMeCo/q/KLiUER6Ujmq6O+OslgxjzVLMGrjuMrAeY9wibNMVIyYB
        tK+yddk4hNYtAkEd+AB9NeOH7Z9pGw8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-8If76scKOZyNFMJv4V1nhw-1; Fri, 03 Nov 2023 15:38:26 -0400
X-MC-Unique: 8If76scKOZyNFMJv4V1nhw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9dd92b7cc4aso45131066b.0
        for <linux-pci@vger.kernel.org>; Fri, 03 Nov 2023 12:38:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699040305; x=1699645105;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=18fxGFPyEfYX6zujRVQDCVGp1gVPnAg8xcOJqGUDNpU=;
        b=riBiKGrg42dvZNIcB21o75jWZ+2AOIiiEFdTZm36+wIWtKdJ7p+aElv9HNSET1KTgS
         ouVZ0zebdgT2gGTAD9KxCPQZE2C8pgFd5gMxp1AQmm14lnymnHkDRo+MrRIGMNIHBmUh
         dM8F8TTFWWkTwxlKKxkH6LG/Za8CY9QOhDJDSaHuaiIAid2tSkltlLI330U6zuwIXyEO
         BnBVwtKpC7Gh+d8GvrSvnqPN0Ql5Ds0g6Js0qRFTk2j3O5S8MfTDviMllfC/MxShhgdZ
         WDs0xRmkQSnAu+ClmB1zejstcU3ahBPzasQvs/Qv0jIJXs1j83u+ycuqS+pDeI4hafmW
         9c4Q==
X-Gm-Message-State: AOJu0Yyz0aswd426Wr4whTMQ/V7cRKC5QsX11nP5h8Qg3n/DxtFAXGLd
        aA5e8SCrlUQaCCdlsnqd6onsR2s9Wnw1NieABoa7ZekM0jldhaguSjvkOtnBW1JLhA8yWlgMU/g
        bVLDq0FG4jR61fpl2gVdY
X-Received: by 2002:a17:907:3da1:b0:9b7:37de:6009 with SMTP id he33-20020a1709073da100b009b737de6009mr8119043ejc.3.1699040305117;
        Fri, 03 Nov 2023 12:38:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2EgYFYkxhAFVhtUcYX07z+ZAHa6gRCnHShMvlzepM1PxNvaeqEAxxrCtaSa8ojD2/gCJsUw==
X-Received: by 2002:a17:907:3da1:b0:9b7:37de:6009 with SMTP id he33-20020a1709073da100b009b737de6009mr8119007ejc.3.1699040304766;
        Fri, 03 Nov 2023 12:38:24 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? ([2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lk22-20020a170906cb1600b0099d804da2e9sm1220533ejb.225.2023.11.03.12.38.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Nov 2023 12:38:24 -0700 (PDT)
Message-ID: <d6466210-fdb7-e9e2-68bb-551b263f439d@redhat.com>
Date:   Fri, 3 Nov 2023 20:38:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 6/9] PCI: Rename is_thunderbolt to is_tunneled
Content-Language: en-US, nl
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>
Cc:     Danilo Krummrich <dakr@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xinhui Pan <Xinhui.Pan@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        =?UTF-8?Q?Marek_Beh=c3=ban?= <kabel@kernel.org>,
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
References: <20231103190758.82911-1-mario.limonciello@amd.com>
 <20231103190758.82911-7-mario.limonciello@amd.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231103190758.82911-7-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 11/3/23 20:07, Mario Limonciello wrote:
> The `is_thunderbolt` bit has been used to indicate that a PCIe device
> contained the Intel VSEC which is used by various parts of the kernel
> to change behavior. To later allow usage with USB4 controllers as well,
> rename this to `is_tunneled`.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Here is my ack for the trivial drivers/platform/x86/apple-gmux.c change:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Bjorn, feel free to route this through the PCI tree.

Regards,

Hans




> ---
>  drivers/pci/pci.c                 | 2 +-
>  drivers/pci/probe.c               | 2 +-
>  drivers/platform/x86/apple-gmux.c | 2 +-
>  include/linux/pci.h               | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 59c01d68c6d5..d9aa5a39f585 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3032,7 +3032,7 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
>  			return true;
>  
>  		/* Even the oldest 2010 Thunderbolt controller supports D3. */
> -		if (bridge->is_thunderbolt)
> +		if (bridge->is_tunneled)
>  			return true;
>  
>  		/* Platform might know better if the bridge supports D3 */
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 795534589b98..518413d15402 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1597,7 +1597,7 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  	/* Is the device part of a Thunderbolt controller? */
>  	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
>  	if (vsec)
> -		dev->is_thunderbolt = 1;
> +		dev->is_tunneled = 1;
>  }
>  
>  static void set_pcie_untrusted(struct pci_dev *dev)
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 1417e230edbd..20315aa4463a 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -774,7 +774,7 @@ static int gmux_resume(struct device *dev)
>  
>  static int is_thunderbolt(struct device *dev, void *data)
>  {
> -	return to_pci_dev(dev)->is_thunderbolt;
> +	return to_pci_dev(dev)->is_tunneled;
>  }
>  
>  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 439c2dac8a3e..b1724f25fb02 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -440,7 +440,7 @@ struct pci_dev {
>  	unsigned int	is_virtfn:1;
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
> -	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_tunneled:1;		/* Tunneled TBT or USB4 link */
>  	unsigned int	no_command_complete:1;	/* No command completion */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially

