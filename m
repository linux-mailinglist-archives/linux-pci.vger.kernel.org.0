Return-Path: <linux-pci+bounces-30178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D4FAE05BC
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE91A4A1580
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 12:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A6B246774;
	Thu, 19 Jun 2025 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBhR6LBd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258052459EA;
	Thu, 19 Jun 2025 12:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750335954; cv=none; b=hd249MLLg1p7wQlaa7C5aEzpRqjbXUCJs0h3H0o80XSJ0CaCvxZu6k9GhXNXXNAjCzOImH0U4XipgcMfF1SRjwcPjJn7VtU/ks+J5lUjyA/2lchSVNpZmpmDSa6H5zr3C6t7pURHocz4SOrPojFizxHZng5q5avdqdIrXpe+vGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750335954; c=relaxed/simple;
	bh=kkhTTdSVV5+k/hxdi7N53JUhyduhidpUDduKQjOPZoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VK4Mos/xktgSxyERpuBSjYabhGRxv3SmRye8RIyaNYDqRwltAozMtkTWJTCeLF8tMNnExq5pONv2ON5VltLd1D3cppGexkC7NazqJFaTJXraUfJ/0kqIGfTfAXuNceO75aCe6FDLWy1i28N/GfqO5ng/1Th6i+8wM89trgzCPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QBhR6LBd; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6097de2852aso893435a12.0;
        Thu, 19 Jun 2025 05:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750335951; x=1750940751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUjVhDCukRCpVssyQqgdbhyj+mC/bn6jwO9V7utYui8=;
        b=QBhR6LBdkI8VumqMYAEDbIvd6oSWYa05iE1XDWaAkFy7FDCyKrLuB1g11kVYtiJvt6
         fnlGkjx1yUVQcwImwwGX5skGIl9cRCs1lsOOK0hmvRxznvo4WzvIg5K4otdQbmvHnrzy
         Ak6V/VbtEF6cO+EODxMNMgWgarN/oKA5DNbw2YO9V3g5UdZ3QKOt+5jRyWAGM2zOC0xV
         3iAVitXKk/s8aFd81arAEdxhkvEybEwpkUEKG/BHmzRuY3+AwPtsNUvoCt96hQ0e9fKT
         u1feSTaHqGjmdNVcxnBcgYyZlw6gokFfbNk+ABqvtcGYoysWH8Lvd+A0ZqXUESrarb4P
         MvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750335951; x=1750940751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUjVhDCukRCpVssyQqgdbhyj+mC/bn6jwO9V7utYui8=;
        b=EA5LR8C2llfmxRNZPt+Rcjj4yyKVpsU//lzgeDy02KUwkSISNHxNRQPQY+FRDixY2a
         B5IBIddJlOjzDjyAkSkBhgQfkgAISJRtqEeHDH8antB57gm0YAGzgsDIq9N5Ye9x92PE
         40mUL+lBUMFx0r6EOxs8xLIdXbdsiQnyetGn/VmKG9gMoQWkNTPaID6tmB4jmnV2HVDm
         rJT31gJ98oSdvMyjqO5LMYtRLqZqzhsqwJYA0q4NRCjvgXAHpQDoM3MFmAAh/4BqOMrN
         aakYf0ts8ElCO9tn/A98LMa06zcGWkhZ0KA5bGR1LNbuime4rp69vi36p8bjpp4jWKcP
         +/KA==
X-Forwarded-Encrypted: i=1; AJvYcCX1VhFPvzk8VLdysligL/Fm7CmOgKCvKFoD0ReJtnk90uMBMj6gHKJpjokbH7BNpnHnNOVH7AgIqTg=@vger.kernel.org, AJvYcCX3hNo+CEGTzDs2SAokAQCb3ZpxrrziEBAk5t/i2iVZ0xMsJjjutvZacQT9vWe/hK69NULSMiBv@vger.kernel.org
X-Gm-Message-State: AOJu0YztCctqTBnk7OsyyNyl5q4NraAB7VmVtyPYvo1ifzsG6T7griIN
	Oe2KVXJEkaEODSHqE2BCIoD/OL0Zz2uwBHYgju5K2XaNUhPt7ekjrdcAedKFzboEKyLIOgUq66S
	wfo6234wsQcLvsAK9dAqHjWfCjGI8TUY=
X-Gm-Gg: ASbGncs7MpblKZ5A9iq7wyncXi0zPVMpJSComZZv/44eA95Pdzl4ct5Kw3tFk/sR+VM
	H7u122usEFirR0xezjG0uA3w3uGWrSgEsswZDPlCvMljrgzNFP4QdRxQd/Xl3PXLcebtku+eowS
	zZ76RuF5jnc2rIaXO82H4FLI39Vy6DHVvDU/VO0MOAfg==
X-Google-Smtp-Source: AGHT+IEpyK/ndgolPgSKQaxrtcm+/GpMItLdmhLyIy/bcyqQOMgP7pOp9jibfJGBc8oBoFLxrx0ykJy/TXaOtX1LPeA=
X-Received: by 2002:a05:6402:5186:b0:602:1216:fdde with SMTP id
 4fb4d7f45d1cf-608d08b6bc1mr18729944a12.14.1750335951240; Thu, 19 Jun 2025
 05:25:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250511083413.3326421-1-chenhuacai@loongson.cn>
 <20250511083413.3326421-2-chenhuacai@loongson.cn> <r6qqyt7dqa32hlpvn63ajxc6rcwkwtjkpcro3zdiwtoiuglz5s@ed5v3ytdcgs4>
In-Reply-To: <r6qqyt7dqa32hlpvn63ajxc6rcwkwtjkpcro3zdiwtoiuglz5s@ed5v3ytdcgs4>
From: Huacai Chen <chenhuacai@gmail.com>
Date: Thu, 19 Jun 2025 20:25:39 +0800
X-Gm-Features: AX0GCFvj-MwD-n5EPk4HKRH8niPDSonPNMCI8Dbm_eE4Y24Pr3x9p7P6CWCsWDM
Message-ID: <CAAhV-H4yxmR-yOGsTgbe8KX4ce9T=XRcdLu2eyi7bh5=L_+odQ@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] PCI: Use local_pci_probe() when best selected cpu
 is offline
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	Jianmin Lv <lvjianmin@loongson.cn>, Xuefeng Li <lixuefeng@loongson.cn>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Hongchen Zhang <zhanghongchen@loongson.cn>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Manivannan,

Sorry for the late reply.

On Fri, Jun 13, 2025 at 3:11=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Sun, May 11, 2025 at 04:34:12PM +0800, Huacai Chen wrote:
> > From: Hongchen Zhang <zhanghongchen@loongson.cn>
> >
> > When the best selected CPU is offline, work_on_cpu() will stuck forever=
.
> > This can be happen if a node is online while all its CPUs are offline
> > (we can use "maxcpus=3D1" without "nr_cpus=3D1" to reproduce it), There=
fore,
> > in this case, we should call local_pci_probe() instead of work_on_cpu()=
.
> >
>
> Just curious, did you encounter this problem in a real world usecase or j=
ust
> found the issue while playing with maxcpus/nr_cpus parameters?
When we debug kdump we tried to use different maxcpus/nr_cpus
combinations, and we found this problem.

>
> > Cc: <stable@vger.kernel.org>
>
> I believe the fixes tag for this patch is 873392ca514f8.
Yes, but the code has changed many times, this patch cannot be applied
as early as 873392ca514f8.


Huacai

>
> - Mani
>
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> > ---
> >  drivers/pci/pci-driver.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index c8bd71a739f7..602838416e6a 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, s=
truct pci_dev *dev,
> >               free_cpumask_var(wq_domain_mask);
> >       }
> >
> > -     if (cpu < nr_cpu_ids)
> > +     if ((cpu < nr_cpu_ids) && cpu_online(cpu))
> >               error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
> >       else
> >               error =3D local_pci_probe(&ddi);
> > --
> > 2.47.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D

