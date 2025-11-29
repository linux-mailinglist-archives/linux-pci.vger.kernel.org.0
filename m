Return-Path: <linux-pci+bounces-42317-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 325B9C9479F
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAB713443F4
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 20:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8DB423185E;
	Sat, 29 Nov 2025 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U2Balel9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2120F067
	for <linux-pci@vger.kernel.org>; Sat, 29 Nov 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764447072; cv=none; b=nKRnEeJPDLsWZ31fKP6N/CIsAtg27cKLYFC6QcpYWusQzBsCr1SP4Q24HesPTG7RNPB40Pa5YnoJSiQwesPP8L7zK6Z4+RWcJm3P/7aYVOad4OTao7Q601K9fngZXwMxSv6ccQ1cAG0j62Nuq3hZPRcAPRowT7hrr3HjvtExNCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764447072; c=relaxed/simple;
	bh=t/8ojYtN43APFVXUgeZtgjQpo6ZQD7a+4YqnemHNdKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/QTcWohKhTvn1/daaisvnbpBCWJXmSola2eGNBjrhMonN2MZCENHFyIdKAETbK4CFiyIdEXJnwueGLtGz0Lh/RdE3sQ3xYc8TBy8RatPAXM+kGx81ZQM6xaKy8VToxP/3dn39jXOnGS7l9n/jma9N4vhd1ga6DWkv1/0OOYzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U2Balel9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-640bd9039fbso5796456a12.2
        for <linux-pci@vger.kernel.org>; Sat, 29 Nov 2025 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764447069; x=1765051869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZa6k0PKfgjuZ8pfDrzuD9zGRDxJ6a2EfWlnw/BZUSM=;
        b=U2Balel9CourAs+rrT7WpCbeqL7ZFiZTTVA1VmSXhkeTe1Z0sSrWbnvdPlwGbdIBq4
         Nr5f0aEQ1owkTw/Wou3ywznBpWmZkQHcOI0Y9B+uWvVldh4oO5KLoMBlurnePhb+ZPZR
         UUw5amttv0UBzVeBNI6nB7CrYL0clfbF0tnpg6eFieAjVCHT+fO7pbXFHR/fwalt9urm
         aEqLniQqytdDltjkO9x3/3UX02hVAWuCiN819ZMcIVS6dHjebqvth8gNP/VR3308yWri
         qR+WQWPfaMAjP+RUFbo2S4WC9kprXypLUMt0TIoWJY/8yHvMiywGEeGQ0GE6mAFpqK1v
         65qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764447069; x=1765051869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZa6k0PKfgjuZ8pfDrzuD9zGRDxJ6a2EfWlnw/BZUSM=;
        b=NElnNSsBeHAGxWSel4gaD/fouw3CBZmolM/DC0IKJR+/Sl/zKAGdT4R5/Zuc/YjcuV
         Zrkd0nAz2OS8/T0GIDprZjrZYSiNnSd4xm1+7CHJdHEbXBTrt0UGLvfb5v4qEc9b83XV
         S+kBMuLkMArrTh+/7/ofHTK7thrCI35OZdJgSTL5gysrQNzV87ihTgvbTiDO2Y1qmpRZ
         wPvxVMvhmanvUHtwkedoXXwHyY7o9n9JCmRHFSNwF7hJ2xhzeqhfRns5kVqMNvMKM2N6
         cvlP3xYSLgHpPjGGQwuSPqh5M9cCwuo/GW2glu9ss7i7zgWS4coymHBybsCihIwF+0mv
         ezuw==
X-Forwarded-Encrypted: i=1; AJvYcCX+MyeZhy3kQfhbAiAYJG+MTBGnfgGNuZBhU13versz3I5cWeYDjUmg1O3WpQ6GYjCeo2ip1TBfzMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRTbW6FWdAyFXeXLfm80mEEzjrazGHo5K66+cUkzII9QvyWVcL
	EuxGLy5OgRfNbk2BAtBZ1hMvNRbji6mfEP91I28iwB26POYEjfs7Q6Uo9dg5miYlU4txiPtZcy+
	4EerFIv7c66m3csnJzMYLWUMGWod9r18SP0baH5xMfg==
X-Gm-Gg: ASbGncti+u0RPHhu3JTZCxt4WH71xhhBaZOweLTvH2b3GErYd2yFxuo8Siabqahyw0X
	jX4m1xQTIT0mgOeZFdE8ufCEdae2YWTE7rTVByymLN0m+Tg5nyOfwhzpYVQDDUg0f3WZgjkUY/e
	XLWqMc9Ii0W40dNxYpsiJExzOrDKrgzez04DM5zAOEwhUVyGdCRYFqn5wvLjVwDnLC5mpoAackd
	EeJWviB96CqBnz3QslA6LIC3c4iAZ9zfY7g/afLLSap4f1soc5ZfrlmPIHaLHbE/mdCKUqFiBS9
	Mpc=
X-Google-Smtp-Source: AGHT+IHmGvqMVyl4rj98MA1twPtvmDHtcpowzE6HXyAxrQtASfb0JCVB7nMu8XDRMWnr6peumysO83SbSCcH9ytUjKw=
X-Received: by 2002:a05:6402:4619:20b0:647:5214:bfce with SMTP id
 4fb4d7f45d1cf-6475214c067mr9741525a12.15.1764447069176; Sat, 29 Nov 2025
 12:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
In-Reply-To: <aSrMSRd8RJn2IKF4@wunner.de>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 29 Nov 2025 15:10:32 -0500
X-Gm-Features: AWmQ_bnWje606xogMzP8vkRzY53oeIh6Saq4e_wxmZyuQtFXjbPOM9XHqy2umYQ
Message-ID: <CA+CK2bDm5bpEgtw5U_ENkAsh28QJ+hQC+YF95zKKV0+ugTVMOQ@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: Lukas Wunner <lukas@wunner.de>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 5:34=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > Add an API to enable the PCI subsystem to track all devices that are
> > preserved across a Live Update, including both incoming devices (passed
> > from the previous kernel) and outgoing devices (passed to the next
> > kernel).
> >
> > Use PCI segment number and BDF to keep track of devices across Live
> > Update. This means the kernel must keep both identifiers constant acros=
s
> > a Live Update for any preserved device.
>
> While bus numbers will *usually* stay the same across next and previous
> kernel, there are exceptions.  E.g. if "pci=3Dassign-busses" is specified
> on the command line, the kernel will re-assign bus numbers on every boot.
>
> The most portable way to identify PCI devices across kernels is to
> store their path from the root down the hierarchy.  Because the bus
> number might change but the device/function number on each bus stays
> the same.
>
> This is what EFI does with device paths:
> https://uefi.org/specs/UEFI/2.10/10_Protocols_Device_Path_Protocol.html
>
> Example:
> Acpi(PNP0A03,0)/Pci(1E|0)/Pci(0|0)
>
> Source:
> https://raw.githubusercontent.com/tianocore-docs/edk2-UefiDriverWritersGu=
ide/main/3_foundation/39_uefi_device_paths/README.9.md
>
> We've got a device path *parser* in drivers/firmware/efi/dev-path-parser.=
c,
> but we don't have a *generator* for device paths in the kernel yet.

Hi Lukas,

Thanks for the input.

You are right that bus numbers can change in standard boot scenarios.
However, for Live Update, we skip firmware, and we would likely list
pci=3Dassign-busses as an unsupported parameter. So, BDF should be
sufficient.

That said, if there is a better method using a stable hierarchical
path, and more importantly, if that method can be extended to other
bus types, we are open to considering it. The main hurdle is that we
would need a way to generate this stable path in the kernel and also
parse it during early boot.

Thanks,
Pasha

