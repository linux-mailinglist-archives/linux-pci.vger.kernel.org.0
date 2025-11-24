Return-Path: <linux-pci+bounces-41932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A50C7FA4B
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 10:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71CD3A34AC
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D222F5A2C;
	Mon, 24 Nov 2025 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cJl014zN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848532F6187
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763976628; cv=none; b=nx/wbcxidRr9f+wp8TMTUNqFWn5RDRS0+csn/nsnN/PXT15p+DqGxov8ObTLuy3BMvK8bGbeTOtJY5nC/6Dz5l9sGmUyZfHzg3ZjWjPOAa471Xsahtr/bZjc0IfKAVrT4lagKehI5e55SglR7Uh1FiswfacPuQA5stkuedt7Dcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763976628; c=relaxed/simple;
	bh=3JRxI+i0a92b181BOjWjFrS6RqKfjW8qAnaljkajltk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYcqcJ895JDblJqWPNs2VyB7h3Mh1b9CUR/+dCsEzs8IJz2EsJP1lgrKZ2U29WFaydkvI0rVtIv4QNxTauViaOl8HgCp/Uimr24/64mRYXw9E7VsmTcLSTh+DhWT6UUKdJ+NU2pMlIR0AejEFlis02YBBq2+fX9yQAklVqwoMQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cJl014zN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a219db05so24054475e9.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 01:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763976624; x=1764581424; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3aytJ2sZxSRYrfcuOc3im2xCWGoA/zkjwdoYJLrsf8=;
        b=cJl014zNZvccAiqtB06x5IzcCJDWpSM3W6D6ywD0yTw8MQUQss0PLy4U75XHoqTVvM
         /1wK/dXZbkycg8mbRLSldb+VLew653WKwQv+97uI5NnoMUFUsIH5ZhOXMbYLR8iL10AS
         wnQKq0rLxHHZSP/x80bFWJWqLxmkADxmX+XNNIZ0fMkTvVBrMNB1ODhXwc9pG6W3BmRr
         0aLVcYHk8k5O4UrfnQQWurk0F35i2R5V8D1qTFe17FOBBe9LI5KW0F6RwihTZWNswp+G
         hgn6Zn3bAPuTpNS2i38CSH2DvA+sPrGHjygXZxsHdlgj3B9h2XJfB2jmq7k+YPb7f2f8
         cIww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763976624; x=1764581424;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S3aytJ2sZxSRYrfcuOc3im2xCWGoA/zkjwdoYJLrsf8=;
        b=KppTrOoI+tF9O3d9nNxujRITqBpTXtJU6sPhQFQ7dSXHxgEizXbzLwwRYOrzV8zqmr
         4HaUw3UhDmvqyvdXfaxKsoZW3I6/CHEd1k7HvnMbEkOPg1rQ0nseMG8QWUwRT/hNiEs7
         Zi+AVbjNbj+uw/XQ+zZft8YlyxtOkBdKiK3zoDZxvc31ELqO0XgKnS5glMmh5AxR+ydO
         twaKzXUkGoku+j8xi8LfdbGFi7w96D3ae9PCoHPbZ6Iq5KtL3bvVz+FJWcwvwVtGgqeL
         VubRIBUzCtkZJLYppF7+QdYJaY6VdBOqJ0VUmrK7x2LPy6UmDpn0VpgGvGfUIAXZZMRC
         zUBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW8oD5ID5S8yw+pFYZHUICsP41j6i6qJhLxigB2r7yJ8zUla+0giC02nyRhkAzw3XMxqI2RCj4oCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YydAozROiQbGHgQgsjDhNahPqfeYw6rhSLEsNFOAz+P7/zjfoPK
	ftIRdHs/frHuwXC85S5k60lgHMRpQVOoPN1MN3jOpzXK3ux/uybOW9yhp7ZAfdiKbyA=
X-Gm-Gg: ASbGncsVY5dPKcvcXDxyeejvrOBbtubdlJkCeIKIfqozbzNqxdtayH0PWap/8HQYxAa
	3gQEN8iZtL2LDxSqwlvWGzHtg+I7HPKRb77K0S6f0/ty3D7KzlKd2K2QantDgtYqY0uAgXz5zcf
	yTUVm0DkL1vnFgu+OFrAOZtL2Qebs6GBKWVpo9pr5/6k0VOy8vkrk4ftIPD9pR/SFkE3lxEj/ai
	uAilC4vac8lOH8zq8nBgRdhjfaZLSEj0yKaVwqlKb5bkiqaOlXbjg0u9Y0d+/OtIGHmlaof2g/3
	EwgYDtsVmT5NgFUqZMODPEKZE1Xds0u4J6v+s0OpjjMM3cvhyLAxiDojcTaos2JNozHrdq8UWvs
	KUuDPmuN+o7HL6BaUbhbrxITFnDJn+ieN+4wmj3+J1y7hbV5A7wox51rSUsCKDxuGHxf8tqsq/t
	w9746YGOI2719uZtxy7L8IrqZP7O0LF3dqnfs5VhKvHLZLgQQtIas=
X-Google-Smtp-Source: AGHT+IGVswGY/a4pp84AoicemWlC3EeMp/CJWZpQbwJ08GptGBtnpFm9nq439AWBsTFVAzH/O3MyVA==
X-Received: by 2002:a05:600c:4591:b0:477:7925:f7f3 with SMTP id 5b1f17b1804b1-477c10e1cacmr102371425e9.14.1763976623630;
        Mon, 24 Nov 2025 01:30:23 -0800 (PST)
Received: from r1chard (220-129-146-231.dynamic-ip.hinet.net. [220.129.146.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed470ff6sm13929073b3a.19.2025.11.24.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 01:30:23 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Mon, 24 Nov 2025 17:30:17 +0800
To: Thomas Zimmermann <tzimmermann@suse.de>, ardb@kernel.org,
	javierm@redhat.com, arnd@arndb.de
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
	dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/6] efi: sysfb_efi: Reduce number of references to
 global screen_info
Message-ID: <aSQlqZPTAXHvTnrG@r1chard>
References: <20251121135624.494768-1-tzimmermann@suse.de>
 <20251121135624.494768-3-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121135624.494768-3-tzimmermann@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)

Reviewed-by: Richard Lyu <richard.lyu@suse.com>

On 2025/11/21 14:36, Thomas Zimmermann wrote:
> Replace usage of global screen_info with local pointers. This will
> later reduce churn when screen_info is being moved.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
>  drivers/firmware/efi/sysfb_efi.c  | 81 ++++++++++++++++---------------
>  drivers/firmware/sysfb.c          |  4 +-
>  drivers/firmware/sysfb_simplefb.c |  2 +-
>  include/linux/sysfb.h             |  9 ++--
>  4 files changed, 51 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/firmware/efi/sysfb_efi.c b/drivers/firmware/efi/sysfb_efi.c
> index 1e509595ac03..8e0f9d08397f 100644
> --- a/drivers/firmware/efi/sysfb_efi.c
> +++ b/drivers/firmware/efi/sysfb_efi.c
> @@ -92,7 +92,7 @@ void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
>  	})
>  
>  #ifdef CONFIG_EFI
> -static int __init efifb_set_system(const struct dmi_system_id *id)
> +static int __init efifb_set_system(struct screen_info *si, const struct dmi_system_id *id)
>  {
>  	struct efifb_dmi_info *info = id->driver_data;
>  
> @@ -101,14 +101,14 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
>  		return 0;
>  
>  	/* Trust the bootloader over the DMI tables */
> -	if (screen_info.lfb_base == 0) {
> +	if (si->lfb_base == 0) {
>  #if defined(CONFIG_PCI)
>  		struct pci_dev *dev = NULL;
>  		int found_bar = 0;
>  #endif
>  		if (info->base) {
> -			screen_info.lfb_base = choose_value(info->base,
> -				screen_info.lfb_base, OVERRIDE_BASE,
> +			si->lfb_base = choose_value(info->base,
> +				si->lfb_base, OVERRIDE_BASE,
>  				info->flags);
>  
>  #if defined(CONFIG_PCI)
> @@ -135,49 +135,53 @@ static int __init efifb_set_system(const struct dmi_system_id *id)
>  
>  					start = pci_resource_start(dev, i);
>  					end = pci_resource_end(dev, i);
> -					if (screen_info.lfb_base >= start &&
> -					    screen_info.lfb_base < end) {
> +					if (si->lfb_base >= start && si->lfb_base < end) {
>  						found_bar = 1;
>  						break;
>  					}
>  				}
>  			}
>  			if (!found_bar)
> -				screen_info.lfb_base = 0;
> +				si->lfb_base = 0;
>  #endif
>  		}
>  	}
> -	if (screen_info.lfb_base) {
> -		screen_info.lfb_linelength = choose_value(info->stride,
> -			screen_info.lfb_linelength, OVERRIDE_STRIDE,
> +	if (si->lfb_base) {
> +		si->lfb_linelength = choose_value(info->stride,
> +			si->lfb_linelength, OVERRIDE_STRIDE,
>  			info->flags);
> -		screen_info.lfb_width = choose_value(info->width,
> -			screen_info.lfb_width, OVERRIDE_WIDTH,
> +		si->lfb_width = choose_value(info->width,
> +			si->lfb_width, OVERRIDE_WIDTH,
>  			info->flags);
> -		screen_info.lfb_height = choose_value(info->height,
> -			screen_info.lfb_height, OVERRIDE_HEIGHT,
> +		si->lfb_height = choose_value(info->height,
> +			si->lfb_height, OVERRIDE_HEIGHT,
>  			info->flags);
> -		if (screen_info.orig_video_isVGA == 0)
> -			screen_info.orig_video_isVGA = VIDEO_TYPE_EFI;
> +		if (si->orig_video_isVGA == 0)
> +			si->orig_video_isVGA = VIDEO_TYPE_EFI;
>  	} else {
> -		screen_info.lfb_linelength = 0;
> -		screen_info.lfb_width = 0;
> -		screen_info.lfb_height = 0;
> -		screen_info.orig_video_isVGA = 0;
> +		si->lfb_linelength = 0;
> +		si->lfb_width = 0;
> +		si->lfb_height = 0;
> +		si->orig_video_isVGA = 0;
>  		return 0;
>  	}
>  
>  	printk(KERN_INFO "efifb: dmi detected %s - framebuffer at 0x%08x "
>  			 "(%dx%d, stride %d)\n", id->ident,
> -			 screen_info.lfb_base, screen_info.lfb_width,
> -			 screen_info.lfb_height, screen_info.lfb_linelength);
> +			 si->lfb_base, si->lfb_width,
> +			 si->lfb_height, si->lfb_linelength);
>  
>  	return 1;
>  }
>  
> +static int __init efifb_set_system_callback(const struct dmi_system_id *id)
> +{
> +	return efifb_set_system(&screen_info, id);
> +}
> +
>  #define EFIFB_DMI_SYSTEM_ID(vendor, name, enumid)		\
>  	{							\
> -		efifb_set_system,				\
> +		efifb_set_system_callback,			\
>  		name,						\
>  		{						\
>  			DMI_MATCH(DMI_BIOS_VENDOR, vendor),	\
> @@ -284,12 +288,13 @@ static const struct dmi_system_id efifb_dmi_swap_width_height[] __initconst = {
>  	{},
>  };
>  
> -static bool efifb_overlaps_pci_range(const struct of_pci_range *range)
> +static bool efifb_overlaps_pci_range(const struct screen_info *si,
> +				     const struct of_pci_range *range)
>  {
> -	u64 fb_base = screen_info.lfb_base;
> +	u64 fb_base = si->lfb_base;
>  
> -	if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> -		fb_base |= (u64)(unsigned long)screen_info.ext_lfb_base << 32;
> +	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> +		fb_base |= (u64)(unsigned long)si->ext_lfb_base << 32;
>  
>  	return fb_base >= range->cpu_addr &&
>  	       fb_base < (range->cpu_addr + range->size);
> @@ -311,7 +316,7 @@ static struct device_node *find_pci_overlap_node(void)
>  		}
>  
>  		for_each_of_pci_range(&parser, &range)
> -			if (efifb_overlaps_pci_range(&range))
> +			if (efifb_overlaps_pci_range(&screen_info, &range))
>  				return np;
>  	}
>  	return NULL;
> @@ -349,25 +354,25 @@ static const struct fwnode_operations efifb_fwnode_ops = {
>  
>  static struct fwnode_handle efifb_fwnode;
>  
> -__init void sysfb_apply_efi_quirks(void)
> +__init void sysfb_apply_efi_quirks(struct screen_info *si)
>  {
> -	if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI ||
> -	    !(screen_info.capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
> +	if (si->orig_video_isVGA != VIDEO_TYPE_EFI ||
> +	    !(si->capabilities & VIDEO_CAPABILITY_SKIP_QUIRKS))
>  		dmi_check_system(efifb_dmi_system_table);
>  
> -	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI &&
> +	if (si->orig_video_isVGA == VIDEO_TYPE_EFI &&
>  	    dmi_check_system(efifb_dmi_swap_width_height)) {
> -		u16 temp = screen_info.lfb_width;
> +		u16 temp = si->lfb_width;
>  
> -		screen_info.lfb_width = screen_info.lfb_height;
> -		screen_info.lfb_height = temp;
> -		screen_info.lfb_linelength = 4 * screen_info.lfb_width;
> +		si->lfb_width = si->lfb_height;
> +		si->lfb_height = temp;
> +		si->lfb_linelength = 4 * si->lfb_width;
>  	}
>  }
>  
> -__init void sysfb_set_efifb_fwnode(struct platform_device *pd)
> +__init void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd)
>  {
> -	if (screen_info.orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
> +	if (si->orig_video_isVGA == VIDEO_TYPE_EFI && IS_ENABLED(CONFIG_PCI)) {
>  		fwnode_init(&efifb_fwnode, &efifb_fwnode_ops);
>  		pd->dev.fwnode = &efifb_fwnode;
>  	}
> diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
> index 889e5b05c739..916b28538a29 100644
> --- a/drivers/firmware/sysfb.c
> +++ b/drivers/firmware/sysfb.c
> @@ -155,7 +155,7 @@ static __init int sysfb_init(void)
>  	if (disabled)
>  		goto unlock_mutex;
>  
> -	sysfb_apply_efi_quirks();
> +	sysfb_apply_efi_quirks(si);
>  
>  	parent = sysfb_parent_dev(si);
>  	if (IS_ERR(parent)) {
> @@ -200,7 +200,7 @@ static __init int sysfb_init(void)
>  
>  	pd->dev.parent = parent;
>  
> -	sysfb_set_efifb_fwnode(pd);
> +	sysfb_set_efifb_fwnode(si, pd);
>  
>  	ret = platform_device_add_data(pd, si, sizeof(*si));
>  	if (ret)
> diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
> index 592d8a644619..71f542e37732 100644
> --- a/drivers/firmware/sysfb_simplefb.c
> +++ b/drivers/firmware/sysfb_simplefb.c
> @@ -117,7 +117,7 @@ __init struct platform_device *sysfb_create_simplefb(const struct screen_info *s
>  
>  	pd->dev.parent = parent;
>  
> -	sysfb_set_efifb_fwnode(pd);
> +	sysfb_set_efifb_fwnode(si, pd);
>  
>  	ret = platform_device_add_resources(pd, &res, 1);
>  	if (ret)
> diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
> index b449665c686a..8527a50a5290 100644
> --- a/include/linux/sysfb.h
> +++ b/include/linux/sysfb.h
> @@ -82,16 +82,17 @@ static inline bool sysfb_handles_screen_info(void)
>  #ifdef CONFIG_EFI
>  
>  extern struct efifb_dmi_info efifb_dmi_list[];
> -void sysfb_apply_efi_quirks(void);
> -void sysfb_set_efifb_fwnode(struct platform_device *pd);
> +void sysfb_apply_efi_quirks(struct screen_info *si);
> +void sysfb_set_efifb_fwnode(const struct screen_info *si, struct platform_device *pd);
>  
>  #else /* CONFIG_EFI */
>  
> -static inline void sysfb_apply_efi_quirks(void)
> +static inline void sysfb_apply_efi_quirks(struct screen_info *si)
>  {
>  }
>  
> -static inline void sysfb_set_efifb_fwnode(struct platform_device *pd)
> +static inline void sysfb_set_efifb_fwnode(const struct screen_info *si,
> +					  struct platform_device *pd)
>  {
>  }
>  
> -- 
> 2.51.1
> 
> 

