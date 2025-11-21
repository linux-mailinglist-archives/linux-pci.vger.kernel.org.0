Return-Path: <linux-pci+bounces-41884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B36FC7ADCC
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 17:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 208CB3640B8
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9B0263F54;
	Fri, 21 Nov 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qSU1u2/6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7819846BF
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 16:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742678; cv=none; b=DrhZ1P5vrNEHkGghJ2BqYeAGLX/5mchh0j6uAl4kACy+z/z1dlvv1lPC7sgAldxwW4BPEvCA8A2+z8MKVEC4phHSVbviLTf6md4h6lG2uugkA8V8maA0oAnrwhjY3Gu3GqfgIzhXrsXTddYo+phbBnTeylPJnWu0lLum5qQTlWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742678; c=relaxed/simple;
	bh=cyjFZt5pBXnXq1dohzZ9h4FcHLsal8bFkRJaHhMWMaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L9IPvmcBUiwoKPK2ACquYMcSgtCeH3UtOv8Un/7zihPBax2rCLJMNwZ2xI9TCGQDLBkd2EHzeGGr3NH2bzbf8m09ygdc6rJU1SNvCrI00ov42TTiuAyGyLVqBfIRtvK7NoWyvEjMImJQCdY45Ag8emzAJ8+bFmOn/53FIaWoWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qSU1u2/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495CDC2BC9E
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763742678;
	bh=cyjFZt5pBXnXq1dohzZ9h4FcHLsal8bFkRJaHhMWMaY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qSU1u2/6ipckE+A/OsHbqAjCI7HauJiSh2s1S29Ie812amaZwjQ3D1uHEsNymui1D
	 WGmrl0EHTPa9Y1RvEF5u0THNmon9mI0hYPxTjjvl6zVdmZg+TDznwbNrL+cEb13ht5
	 GPOWRMw/8ZsekvhZPaMBnQ8+tlQVkoNj9q0tUoG8EQC8/MU45wwKg/1qcKNrNkLDd/
	 PBHk6omD2z2gPyjqDktFAJv9YCWCL8yUEhrPrZfp3hWVqmGnN5sjWnYhCzvFoloFwx
	 OcqRqeIQZLuYAl057xl/eddeQO7fMU/jVtb/7/QjsDeMebFjUwFfoml37ROnHu+nHc
	 BWyArk68dF2SA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-595819064cdso3123804e87.0
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 08:31:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVSc2oORIKQsB1R7vp/LvbczW8vcx4C9+8ZZosuLZrmKYAbB210sPqj+a9humqkzYfKBFg5mNCdyDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWWcmRuRtiAZQpMmWl/KImONSGkcJJ3/SQXCqg0dRCPMNagwJU
	nfewTJwRmmJxkhhElOfIbvtWRF8oheJIQbUsrddnsnh7QKYxKsS8NuKH3YuYtaI2Zbi4EbD6ADf
	wJoBW+VLSPY2kak+jJggs/4CrVNYSk6k=
X-Google-Smtp-Source: AGHT+IHv94YBPiEOZjVBTWao8a3/iUuQL5cnLW52Wc5H+gjJzlYuoPCzdcoJKR5m6QrcIhi6WOqHYr6zv5IgKHaKwNI=
X-Received: by 2002:a05:6512:1391:b0:594:2bd4:c856 with SMTP id
 2adb3069b0e04-596a374965amr995757e87.6.1763742676554; Fri, 21 Nov 2025
 08:31:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121135624.494768-1-tzimmermann@suse.de> <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
 <CAMj1kXF1Dh0RbuqYc0fhAPf-CM0mdYh8BhenM8-ugKVHfwnhBg@mail.gmail.com>
 <199e7538-5b4a-483b-8976-84e4a8a0f2fd@suse.de> <CAMj1kXE+mS1Sm5GaROU0P97J2w1pew0P_To4sKiw8h1iOMuLcg@mail.gmail.com>
 <d080729c-6586-4b9c-b234-470977849d3d@suse.de> <6dff8e7e-c99b-443d-a1d8-22650ca0b595@suse.de>
 <CAMj1kXGpC_162bFL65kQw=7qVP7ezYw77Q76y217dDs8pqHogw@mail.gmail.com> <8d0bc096-e346-462b-a274-f0cc1456eea3@suse.de>
In-Reply-To: <8d0bc096-e346-462b-a274-f0cc1456eea3@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Nov 2025 17:31:05 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFdethf2sb1tm1V4wRW1SyPt-OnCmaAXc5cHNKuLJMXWA@mail.gmail.com>
X-Gm-Features: AWmQ_bn8zhFEK816tkr85kGEYNB_leVhAjJQxQ75BwMURzs3nYpX4WL_zzKYI_Q
Message-ID: <CAMj1kXFdethf2sb1tm1V4wRW1SyPt-OnCmaAXc5cHNKuLJMXWA@mail.gmail.com>
Subject: Re: [PATCH 0/6] arch, sysfb: Move screen and edid info into single place
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Javier Martinez Canillas <javierm@redhat.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 17:26, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 21.11.25 um 17:19 schrieb Ard Biesheuvel:
> > On Fri, 21 Nov 2025 at 17:09, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >>
> >> Am 21.11.25 um 17:08 schrieb Thomas Zimmermann:
> >>> Hi
> >>>
> >>> Am 21.11.25 um 16:56 schrieb Ard Biesheuvel:
> >>>> On Fri, 21 Nov 2025 at 16:53, Thomas Zimmermann <tzimmermann@suse.de>
> >>>> wrote:
> >>>>> Hi
> >>>>>
> >>>>> Am 21.11.25 um 16:16 schrieb Ard Biesheuvel:
> >>>>>> On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>>>>> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
> >>>>>>>> Replace screen_info and edid_info with sysfb_primary_device of type
> >>>>>>>> struct sysfb_display_info. Update all users.
> >>>>>>>>
> >>>>>>>> Sysfb DRM drivers currently fetch the global edid_info directly,
> >>>>>>>> when
> >>>>>>>> they should get that information together with the screen_info
> >>>>>>>> from their
> >>>>>>>> device. Wrapping screen_info and edid_info in
> >>>>>>>> sysfb_primary_display and
> >>>>>>>> passing this to drivers enables this.
> >>>>>>>>
> >>>>>>>> Replacing both with sysfb_primary_display has been motivate by
> >>>>>>>> the EFI
> >>>>>>>> stub. EFI wants to transfer EDID via config table in a single entry.
> >>>>>>>> Using struct sysfb_display_info this will become easily possible.
> >>>>>>>> Hence
> >>>>>>>> accept some churn in architecture code for the long-term
> >>>>>>>> improvements.
> >>>>>>> This all looks good to me,
> >>>>>>>
> >>>>>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
> >>>>> Thanks
> >>>>>
> >>>>>>> It should also bring us one step closer to eventually
> >>>>>>> disconnecting the x86 boot ABI from the kernel-internal
> >>>>>>> sysfb_primary_display.
> >>>>>>>
> >>>>>> Agreed
> >>>>>>
> >>>>>> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >>>>> Thanks
> >>>>>
> >>>>>> I can take patches 1-2 right away, if that helps during the next
> >>>>>> cycle.
> >>>>>    From my sysfb-focused POV, these patches would ideally all go through
> >>>>> the same tree, say efi or generic arch, or whatever fits best. Most of
> >>>>> the other code is only renames anyway.
> >>>>>
> >>>> I don't mind queueing all of it, but I did get a conflict on
> >>>> drivers/pci/vgaarb.c
> >>> Probably from a78835b86a44 ("PCI/VGA: Select SCREEN_INFO on X86")
> >> https://lore.kernel.org/all/20251013220829.1536292-1-superm1@kernel.org/
> >>
> > Yes, if I merge back -rc2 first, I can apply patches 1-5 onto my
> > efi/next tree. But then I hit
> >
> > Applying: sysfb: Move edid_info into sysfb_primary_display
> > error: sha1 information is lacking or useless (drivers/gpu/drm/sysfb/efidrm.c).
> > error: could not build fake ancestor
> > Patch failed at 0006 sysfb: Move edid_info into sysfb_primary_display
> >
> > If you prefer, you can take the whole lot via the sysfb tree instead,
> > assuming it does not depend on the EDID changes I already queued up?
>
> Sure, I can also add it to the drm-misc tree. ETA in upstream would be
> v6.20-rc1.
>

But does that mean the EDID firmware on non-x86 will have to wait for
6.21? I was trying to avoid making this a 6 month effort.

