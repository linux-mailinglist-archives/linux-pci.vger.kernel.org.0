Return-Path: <linux-pci+bounces-41877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C68EC7AB1F
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 16:59:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5763F3A236E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Nov 2025 15:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF3934029E;
	Fri, 21 Nov 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIGPz/iT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A123321C6
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 15:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763740620; cv=none; b=hQTFFvvRrm4FLIjBESIW1kKW3fOiYhHY352YqDgM0Y9GeoIVJ8Yz9l+xfj9hqIZe4YrgXqk43oAQXxCzLIVOxKBbXRWI8978Uh0PmTF1Z8IJclzns+qjLLa7YLFESnIFjubjnjhx98I3WCWxvmThSxG+F9f1M8bNqkO5NIPyO3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763740620; c=relaxed/simple;
	bh=PxN1kKcbmsayKjAbhYkIf5ei+/f87NdEWIzkcYKf1rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfM77XG7n1Ts//Qo+CHIqMWEaqyP+yDHWnz6VPS6iv96Q8f5SauWs5MzbkurkBJhmgnDs4Hx+XWcR6c/elnAE8Xz/7Mbl8kK/fext8JGRNWNbs0lZU4DObgsakTfIS4v7HTygnh49DYvb91ne32jhs8EdNll17d3HZND4yWcm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIGPz/iT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC85DC19422
	for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763740619;
	bh=PxN1kKcbmsayKjAbhYkIf5ei+/f87NdEWIzkcYKf1rA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DIGPz/iTjd1rrI+oKDc0x8sgQ+7u2JmiLppyKdFpsqEuxu/zZGukGjD0jWkrIk9NN
	 Q5hCO/wduxP89YcoAVd65lmLHSK6jmTR+XKr31pIuiSrrI2USJa5ArYRaGm9PFyRN0
	 xdv+BaKnam4katXkC/DPgjd6G12gVzV0GPmNI3jQpp1dvRTyUwV4pw3Fs/PV3bp7gR
	 CfLOisDVuTp8n9p+gXFteSs1MW5aIq8nsYl8CK73Cw6TivYgBzaw8OQrb9EZTGSzi2
	 ZlIzym4LPBtOPZ+QVNK/d8LpJwvUL05c9MYMaL0xFLbvK3VF8/y6Coe6xboh30nkFO
	 lq4Bu1UNXqoEA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5942b58ac81so1526293e87.2
        for <linux-pci@vger.kernel.org>; Fri, 21 Nov 2025 07:56:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUFAm9hHZgi26j2ODbUnczT3GSSUTADYiTQUVnK7uHpZdPYz4WzdPIPPhlhr3ORPgpQVeG+2T99si4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4gIkNuKfNiE0qvaIBPbAlFwvFOrVEZhhcSr/F+9Rjq8eR+d3x
	iwFY7V0oWwE7z1dokT2lLyTeJ3ikwnDW5sDzJ4Bsrq9cXGJrBPN18FvfCe4IrnQqvWHBF2riT27
	X4E3I5NcSGZvfFOlKSW0U5eBeNmKvvcc=
X-Google-Smtp-Source: AGHT+IFc07wm23hRt5x6E5vt9dWJKlKV7r/oPKbOUgisqHzxDRZC6hX2KMiXOjZbJFYb9IW5F8q//Vmfp5+N+9MSM5I=
X-Received: by 2002:a05:6512:224e:b0:593:f74:90c1 with SMTP id
 2adb3069b0e04-596a3eddddemr1011328e87.42.1763740618060; Fri, 21 Nov 2025
 07:56:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121135624.494768-1-tzimmermann@suse.de> <96a8d591-29d5-4764-94f9-6042252e53ff@app.fastmail.com>
 <CAMj1kXF1Dh0RbuqYc0fhAPf-CM0mdYh8BhenM8-ugKVHfwnhBg@mail.gmail.com> <199e7538-5b4a-483b-8976-84e4a8a0f2fd@suse.de>
In-Reply-To: <199e7538-5b4a-483b-8976-84e4a8a0f2fd@suse.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 21 Nov 2025 16:56:45 +0100
X-Gmail-Original-Message-ID: <CAMj1kXE+mS1Sm5GaROU0P97J2w1pew0P_To4sKiw8h1iOMuLcg@mail.gmail.com>
X-Gm-Features: AWmQ_blY0LARqXnA2mx39E1yO5MH1W25KbCHBoidZ2MUQVLTBxhVpSWsyYxPQP4
Message-ID: <CAMj1kXE+mS1Sm5GaROU0P97J2w1pew0P_To4sKiw8h1iOMuLcg@mail.gmail.com>
Subject: Re: [PATCH 0/6] arch, sysfb: Move screen and edid info into single place
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Javier Martinez Canillas <javierm@redhat.com>, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-efi@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-riscv@lists.infradead.org, dri-devel@lists.freedesktop.org, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Nov 2025 at 16:53, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 21.11.25 um 16:16 schrieb Ard Biesheuvel:
> > On Fri, 21 Nov 2025 at 16:10, Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Fri, Nov 21, 2025, at 14:36, Thomas Zimmermann wrote:
> >>> Replace screen_info and edid_info with sysfb_primary_device of type
> >>> struct sysfb_display_info. Update all users.
> >>>
> >>> Sysfb DRM drivers currently fetch the global edid_info directly, when
> >>> they should get that information together with the screen_info from their
> >>> device. Wrapping screen_info and edid_info in sysfb_primary_display and
> >>> passing this to drivers enables this.
> >>>
> >>> Replacing both with sysfb_primary_display has been motivate by the EFI
> >>> stub. EFI wants to transfer EDID via config table in a single entry.
> >>> Using struct sysfb_display_info this will become easily possible. Hence
> >>> accept some churn in architecture code for the long-term improvements.
> >> This all looks good to me,
> >>
> >> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks
>
> >>
> >> It should also bring us one step closer to eventually
> >> disconnecting the x86 boot ABI from the kernel-internal
> >> sysfb_primary_display.
> >>
> > Agreed
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
>
> Thanks
>
> >
> > I can take patches 1-2 right away, if that helps during the next cycle.
>
>  From my sysfb-focused POV, these patches would ideally all go through
> the same tree, say efi or generic arch, or whatever fits best. Most of
> the other code is only renames anyway.
>

I don't mind queueing all of it, but I did get a conflict on
drivers/pci/vgaarb.c

