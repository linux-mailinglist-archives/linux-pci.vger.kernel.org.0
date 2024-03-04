Return-Path: <linux-pci+bounces-4454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 746B68707AB
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE9CD1F21E7A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30DD4D9FA;
	Mon,  4 Mar 2024 16:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9/2Wmkc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E1A20
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571150; cv=none; b=a8Vrd57DXZgxQ2s11wlObAbwAT8jJJ5yXixYn5/MUJy/QUNhKFzPnn3UH95Mqo86mmC8/A31LK8gCm1fwA3zYgog1euEeeOK1cj2UGHvDLj8RywT2l24XxPGH8VLUtGNqkK49VzSUtsLDv4SCkwP4L4YYp302ksPNc7qhDij2H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571150; c=relaxed/simple;
	bh=6mJJenTAuAPmRv04beNi8wfbIEkU3wKp27DVpqLUeEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aPiLEoYl/mjE7G6rOTr8bjG87N3fIEEmRvxEO723gy/iWr4hHupmos/M7Z5B56QVagkJo/HQiN+lOnu83utHe5SX1+tgu4PohAC5vM36Rby5F+nlkS/ErzjBMj1h7Xe3kf4pP5Qeyrv/ZrWW+h+/OmTgNdQ1XT8E3wpHlWxdY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9/2Wmkc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709571147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDZBx6b+sDral9amWV4nmduRo6EA43+ucC/adZNje+4=;
	b=a9/2WmkcQ9uGPdnO4hH1UgKRmfpxFMJ0SYg944yxUoP3No0nFuXnPHslltarq+IImDtSPw
	hzllcQMT13qET6gLFyFX+YpPzgKj9eYGtAgzACtAxnBw8+gZR9zA9XBvag79tiQ2gL9Fnz
	+EKCIRlJuWZGeILXu6o8spTHlYtGkII=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-0pJdkySHNGCV8O17GbJK-A-1; Mon, 04 Mar 2024 11:52:26 -0500
X-MC-Unique: 0pJdkySHNGCV8O17GbJK-A-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2d34662d6c0so29454061fa.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 08:52:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709570841; x=1710175641;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pDZBx6b+sDral9amWV4nmduRo6EA43+ucC/adZNje+4=;
        b=ZlQuDYrEYO0NvmBe0/p9t+WLhqTyKSs+W1GaD2PnM28uRP/E21gKpyzc4ILj3isc2R
         0aakiqsWXfEBQxrrzxFW6Mr3+qYGcu3Nge0+4dRcVNbMAqG6uHVtzGD5X8x+yFFKSBdf
         mVe14gGqtZVi4YVtBoVTefEMaH8tEWAHr/tEMH3GPq6v5SUK5VFD6x7YT+liuRquM1wq
         o+Vd2t13LFLcf8dDeZIJp3e5PGfLDshdQyPCPF30VGuHYEMUC5b2TP3SGAqiY9s1Wwfq
         XTSBpV/hjAvwAmU4WufifX+S0khqrM6k3FobK4bO14fOJlNDIDj7tIONaO4v9zhTq9FU
         ymjg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ3OgB+Wv469bDPn/1aOxJOEDbSCLDs7Frkfb73ExjEEzFK/zPYGCpSzouPxc+H+zx39mBitPTLohh10MY7xXh/AcR7oEWClIG
X-Gm-Message-State: AOJu0Yx12YP1fUvrln5cn5lR/H4MItCANWun5FrMBUeAaEysr+hqEC9t
	qrvJaXyS64eTX+JNUwkoBiQ8Yr3coYv9L5LrPcUl5Ym5QJDwJimM3kvsDqueOmwzfp9TBGA/yIx
	1EcItmn1m/VaJ00N2B39KUlPwnX5TEzHbvYbA5GjbLwHFkD0FzMTlI+6/og==
X-Received: by 2002:a2e:aaa7:0:b0:2d2:a3bc:b7d8 with SMTP id bj39-20020a2eaaa7000000b002d2a3bcb7d8mr6218043ljb.20.1709570841603;
        Mon, 04 Mar 2024 08:47:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNoe2ubGGjmxx+SlBiuqS124weoi57lX43Hf1non5XGMyOoScFbf3rF8AsIw/FBt3x9QwsMw==
X-Received: by 2002:a2e:aaa7:0:b0:2d2:a3bc:b7d8 with SMTP id bj39-20020a2eaaa7000000b002d2a3bcb7d8mr6218036ljb.20.1709570841264;
        Mon, 04 Mar 2024 08:47:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id 2-20020a05651c00c200b002d0acb57c89sm1722974ljr.64.2024.03.04.08.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 08:47:20 -0800 (PST)
Message-ID: <be1c9329-1d24-4f49-b200-c8ac551b1fe2@redhat.com>
Date: Mon, 4 Mar 2024 17:47:19 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/1] platform/x86: p2sb: On Goldmont only cache P2SB and SPI
 devfn BAR
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: danilrybakov249@gmail.com, Lukas Wunner <lukas@wunner.de>,
 Klara Modin <klarasmodin@gmail.com>, linux-pci@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20240304134356.305375-1-hdegoede@redhat.com>
 <20240304134356.305375-2-hdegoede@redhat.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240304134356.305375-2-hdegoede@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

On 3/4/24 14:43, Hans de Goede wrote:
> On Goldmont p2sb_bar() only ever gets called for 2 devices, the actual P2SB
> devfn 13,0 and the SPI controller which is part of the P2SB, devfn 13,2.
> 
> But the current p2sb code tries to cache BAR0 info for all of
> devfn 13,0 to 13,7 . This involves calling pci_scan_single_device()
> for device 13 functions 0-7 and the hw does not seem to like
> pci_scan_single_device() getting called for some of the other hidden
> devices. E.g. on an ASUS VivoBook D540NV-GQ065T this leads to continuous
> ACPI errors leading to high CPU usage.
> 
> Fix this by only caching BAR0 info and thus only calling
> pci_scan_single_device() for the P2SB and the SPI controller.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218531 [1]
> Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Good news Danil Rybakov has just confirmed in bugzilla
that simple patch fixes things. So IMHO this is the way
to move forward to fix this.

Shin'ichiro, any objections from you against this fix ?

Danil, is it ok if I credit you for all your testing by adding:

Reported-by: Danil Rybakov <danilrybakov249@gmail.com>
Tested-by: Danil Rybakov <danilrybakov249@gmail.com>

to the commit message for the patch while merging it ?

Regards,

Hans






> ---
>  drivers/platform/x86/p2sb.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
> index 6bd14d0132db..3d66e1d4eb1f 100644
> --- a/drivers/platform/x86/p2sb.c
> +++ b/drivers/platform/x86/p2sb.c
> @@ -20,9 +20,11 @@
>  #define P2SBC_HIDE		BIT(8)
>  
>  #define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
> +#define P2SB_DEVFN_GOLDMONT	PCI_DEVFN(13, 0)
> +#define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
>  
>  static const struct x86_cpu_id p2sb_cpu_ids[] = {
> -	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
> +	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
>  	{}
>  };
>  
> @@ -98,21 +100,12 @@ static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
>  
>  static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
>  {
> -	unsigned int slot, fn;
> +	/* Scan the P2SB device and cache its BAR0 */
> +	p2sb_scan_and_cache_devfn(bus, devfn);
>  
> -	if (PCI_FUNC(devfn) == 0) {
> -		/*
> -		 * When function number of the P2SB device is zero, scan it and
> -		 * other function numbers, and if devices are available, cache
> -		 * their BAR0s.
> -		 */
> -		slot = PCI_SLOT(devfn);
> -		for (fn = 0; fn < NR_P2SB_RES_CACHE; fn++)
> -			p2sb_scan_and_cache_devfn(bus, PCI_DEVFN(slot, fn));
> -	} else {
> -		/* Scan the P2SB device and cache its BAR0 */
> -		p2sb_scan_and_cache_devfn(bus, devfn);
> -	}
> +	/* On Goldmont p2sb_bar() also gets called for the SPI controller */
> +	if (devfn == P2SB_DEVFN_GOLDMONT)
> +		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
>  
>  	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
>  		return -ENOENT;


