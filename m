Return-Path: <linux-pci+bounces-29836-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B954ADA964
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 09:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA4D7171011
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D95EAFA;
	Mon, 16 Jun 2025 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xy2Xmpb0"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08D91B4F0E
	for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750058692; cv=none; b=DT3Q6joL7KgPkzsDeKrZHBazdeNK4MzcgNKIlqgnBBGBUywtZ8UbW4B65e0eRhqP3wrwiW7vtmRq38haVQ5wZsGYoQTOgHvipP9dUJ4i0DlZKwk+xTwZMwpjgsrfiYdYDm6m7Ew98/HprIApcrdNWCE8JIBdBHkjWqZ21IjepOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750058692; c=relaxed/simple;
	bh=0wA7Jf9xStMD/26/NXvgwSjQnrapSWERlfTDaR+dg8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkd99FSnrPiFur3JF3sItAnYTSD4wF6jnbdafrMm9v2gtW2+lXDlb1Kh5iieyTBJD4HDwhB03OJcpPGumUWUP8LG1CYStl+Lx/mwJRggJpZs+YWkb+Kf6tVnaiwL5HgcJuySdv8II05vmGA7UlgMCxOPzyeFquyW2VFawnK2Bs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xy2Xmpb0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750058687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eznbk7cjAkzDktabtxARl/3wHMFHkgT8ypThfayrTGk=;
	b=Xy2Xmpb0Ddp1785CAyrLDPiGk6Nhf3NhYm0fvekfnBp0pU34kcgaC9rTqBaFf3dtRlyWt+
	j2PKwb5Y4HGLE3T+XBNf0MN8pNveWBNjfKI38OGQ2+lsNmki/v58Mmz2b5m51BhnutwTOP
	waPtlObX7Di8iWCKJsjjl6HKvnl8dYQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-3aqgTpdVPLytUMupDR54Iw-1; Mon, 16 Jun 2025 03:24:45 -0400
X-MC-Unique: 3aqgTpdVPLytUMupDR54Iw-1
X-Mimecast-MFC-AGG-ID: 3aqgTpdVPLytUMupDR54Iw_1750058685
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so6051084a91.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2025 00:24:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750058685; x=1750663485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eznbk7cjAkzDktabtxARl/3wHMFHkgT8ypThfayrTGk=;
        b=pws5oHrRXZ04+dwpYKgAWytra4gdedgRXKX2tO4yDiqcGxBLnuFciCRX94yGduuowA
         L5nsVsJYLmhSLIlSTY0qSryRGse7RYNzF8p3soSYyH+c79G6uA37Yp4ILQcIwIpF1h4B
         xJ9N7j8hWCObtG7EXXkMmxU+ohafaqIm/JUJgwRxusWDaoJsilI3lMqncqhv6YoL18GM
         WOy/7ugHijh2XQT7ytoX6qad06o0vBjmhqolipnSHmNtOP/19YX4g0QauABZ8jbqxKlt
         H83DfR06uVFMHGF6sTJLGdvgy57pBnUyTzfAEJi/PiliAz8YXJgOV0O6Smp8wuu9NjgR
         LY7A==
X-Forwarded-Encrypted: i=1; AJvYcCVQKq2NeWx0CXLurAjNXzUazK4RYQRa+xGMqJ32OzMX5GXd1ioSQCP3kP1CKjZow6e6mR4q3QVa5Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGgtPZX6dwlQs+Bf1QV5YqWTChrNEvnn8DE1CxbrUeqkqbPP2J
	b8ztyqK2olW1v6/kbkmaKh7DehEh29iYc9x8M/78UiBozZo4P7RikqyN4S5/M+43jmPQzr4Fwn0
	08tI9gb89mdOacQLU2/vw1EEbL7x5nfiEL6krLWCzkB89zpwkxhnBO2j3pJYZs99lOOiYNv0b6c
	67JTi1EbxJzksN5gfl357AyEu/Z/72L9pxUTio
X-Gm-Gg: ASbGncuMsljSF2yAuGHPYYT/fLTDyyTIL0i084DZtVTHbuX8Mqp3fbHdAtC3TZ0ZG6V
	mVvhPmVdM2ITz1/X/3wbxhgE2+8mQiZZ7uqIwpElnnUWDwGoSJfq9BTN87NZii6PcTMFNxyTr74
	xGAw==
X-Received: by 2002:a17:90b:6c6:b0:311:f684:d3cd with SMTP id 98e67ed59e1d1-313f1cd67c8mr16020626a91.12.1750058684721;
        Mon, 16 Jun 2025 00:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNQhWn0yeAsD531ia8JZxKFoRmcixmLUXZgjnDzvKNJdTd49mQoNfz7Irg5MiOjSGcYRvb/PrM4TgHJ0eQaJg=
X-Received: by 2002:a17:90b:6c6:b0:311:f684:d3cd with SMTP id
 98e67ed59e1d1-313f1cd67c8mr16020589a91.12.1750058684367; Mon, 16 Jun 2025
 00:24:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613190718.GA968774@bhelgaas> <3a0a7aeb-436d-442a-bede-9e760a69fa47@kernel.org>
 <20250613151929.3c944c3c.alex.williamson@redhat.com> <7d491f5f-5af6-47ce-9950-975e33f706bb@kernel.org>
 <bc0a3ac2-c86c-43b8-b83f-edfdfa5ee184@suse.de> <CAMwc25oTD8+75NB1mo_93-14U_ZsEEMoUaKZLpu-MBszusFRBw@mail.gmail.com>
 <a5196c49-2c4c-40ab-950d-0180ebd983d4@suse.de>
In-Reply-To: <a5196c49-2c4c-40ab-950d-0180ebd983d4@suse.de>
From: David Airlie <airlied@redhat.com>
Date: Mon, 16 Jun 2025 17:24:31 +1000
X-Gm-Features: AX0GCFsZpoRiU1v0Y9qk-VCPUXK36q1tBStS_xaaJCo-9HULTqG5sG-NkUW0RVo
Message-ID: <CAMwc25o9Qv21tc3RbDEG-tigVgkG8fiytfLiMKJpYmPGdx0YQA@mail.gmail.com>
Subject: Re: [PATCH] PCI/VGA: Look at all PCI display devices in VGA arbiter
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mario Limonciello <superm1@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Bjorn Helgaas <helgaas@kernel.org>, mario.limonciello@amd.com, bhelgaas@google.com, 
	linux-pci@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 5:21=E2=80=AFPM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Hi
>
> Am 16.06.25 um 08:50 schrieb David Airlie:
> [...]
> >>>>
> >>>> It's also a bit concerning that we're making a policy decision here
> >>>> that the integrated graphics is the "boot VGA" device, among two
> >>>> non-VGA devices.  I think vgaarb has a similar legacy policy decisio=
n
> >>>> for VGA devices that it's stuck with, but it's not clear to me that
> >>>> reiterating the policy selection here is still correct.  Thanks,
> >>>>
> >>>> Alex
> >>> I'm with you there. That's actually exactly why the first swing at
> >>> this was with a patch to userspace.
> >>>
> >>> https://gitlab.freedesktop.org/xorg/lib/libpciaccess/-/merge_requests=
/37
> >> I second Alex' point. I acked the patch purely on my understanding of
> >> how it does this, but as I noted, I'd also prefer to solve this in use=
r
> >> space. I think we should push back on this change.
> >>
> > If we are solving this in userspace I think fixing it in libpciaccess
> > is probably also the wrong place, which leaves open where is the right
> > place?
>
> Why is libpciaccess the wrong place? I see that the boot display is not
> necessarily on the PCI bus. But if its not handled in libpciaccess,
> should it rather go into Xorg directly?

Because this isn't generally a PCI problem, and it involves accessing
ACPI stuff, who says it won't need DT stuff on other hardware?

Just seems like libpciaccess is convenient but so is the kernel, I
don't think userspace is right at all. The kernel should abstract the
hardware.

> > To be honest the what GPU is driving the display at boot hint should
> > come from the kernel, since it knows already, whether boot_vga is the
> > best method of doing that is open to questions.
>
> The proposed user-space patch looks way less intrusive than the kernel
> change.

I don't care for intrusive, I care for correct.
>
> >
> > It might be better to have a bit somewhere on the drm device that shows=
 this.
> >
> > hello new UAPI.
>
> In the kernel, there's already video_is_primary_device. [1] On x86, it
> looks at vga_default_device(), on other architectures, it looks at
> firmware settings. If there's no default vga on x86, it could do more
> heuristics to figure out the boot display. The result can be exported by
> a boot_display file via sysfs. video_is_primary_device() is currently
> used by fbcon. Any changes to the helper would likely benefit fbcon as we=
ll.
>

We should work on that then, since fbcon also needs this info to be
correct, it should go in the kernel.

Dave.


