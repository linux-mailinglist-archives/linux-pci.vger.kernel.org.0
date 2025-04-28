Return-Path: <linux-pci+bounces-26966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE59A9FD1C
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 00:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0B23A7125
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 22:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5DE20E706;
	Mon, 28 Apr 2025 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="De9DHTTz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5D20B7FD;
	Mon, 28 Apr 2025 22:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745879980; cv=none; b=fJqX52qbrPI3MmeMjajpFAxoHRqZ+2Uzcx41Vf2w0bEv8NOTJZqVmNNyiQqGYg/kd0J/Qr6sgco9yAkUoy61yvaD+bkddeVhmLk0q27c3eskueyHKB1DIpeWn0VLwrTgUpCQnoATE3fFzEmLckzBrADNXNgOgckR/H3FwSGwU/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745879980; c=relaxed/simple;
	bh=8kijEYLCWz6PW7HEQrKNd0RhweHY8H7pf4r3gg5DYqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sFzawNiC8S9pKxSv+zekQsn7srpI9zTjfuJEXnrRWXcFdrpznwqKPuhIVOXiNBpdrOQUBBxSSg/VqnHPlHXzW5K3kgY/ahNmuO6SynmIPQImgRUECyxstwMn/lEhPAlYllcMF8Hx3vYfB3IQWsgjDePUONvNA7ALQ09TtFSL9Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=De9DHTTz; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54993c68ba0so6386614e87.2;
        Mon, 28 Apr 2025 15:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745879975; x=1746484775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kijEYLCWz6PW7HEQrKNd0RhweHY8H7pf4r3gg5DYqk=;
        b=De9DHTTzTBL5O21Rz4MiyID2FIOFuode+oQO26pUQXPa84QwBw5zSu/ViOZgJTasLp
         hnQ6JpncroSfS3eFhBRi6SvXF/G9X9Fvxlm9As9KJC9v01EEXB2kAvdpWD2xvRB76Qww
         DQ6bj1q2s+yb2EBf1MNU/V/YgHcHYcYfh01rte1uzOFkzixAaE+gOB0WMXpPNAssuPCS
         Vd1vTWFi2kOxF/xp51OYK0B+R3H5ZGhB8wHKioThooP7efLgwkSWAZ+MW7G1qI4tpLA3
         1gdEHQhthX4KjJEJpgIFlpuCesCy2MJ1W10MXcYx2sf/7W0l9Ezx06P3KzxIaOVWBJgv
         oEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745879975; x=1746484775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8kijEYLCWz6PW7HEQrKNd0RhweHY8H7pf4r3gg5DYqk=;
        b=jXiaP3QslrTAV/8O9VMGc5Y+TpcPLkKN+W+ZrKTwheqhi4doCLpbzirSChqr6ip9U6
         WuyNTIvVlM8Cocdj1QvOOPLSrowtXr6N2erpEAjq+5nRfDksF/ZTdz5FtIL6KPtqpnLF
         JlFKD9/pf0ZX+uXN6KBYM1VhJrKAMzD5oyANLFfCqAWQYit5RR9rTdB9glBCKcgQRSP7
         /f3ZCtVwzjkmmGkTnq0cNbBJpsvqNLFjmQVQuTgeR00YnLWBy4FfEZ2GIWOCcLRtQsOy
         SyGgGUMat4+uUvMxf/8NRncGzMbDRa/Da9ux2RLs9Ucy7Xavh2fnByuVuUe13+xZuRU7
         lFIA==
X-Forwarded-Encrypted: i=1; AJvYcCXaNvoS9Kc1uDvvmB7o8gj35qFPO3FwBZhXiys7XD+VpLPKmPtoQo1ReidNyCDdHQXYjP+ieHQAVNG89Lc=@vger.kernel.org, AJvYcCXpisqHT/bNmY3Y5NH863rTIrlpyVVizNifDLHOLKlaxwo/Y4bUMYWLU/1rn3iiBePe2cGR+oIAfuQP@vger.kernel.org, AJvYcCXq1vOcxb3qGQaWDxSA7bmN55W7T4aMvJZcHdc2WQ3tnXBKwTkLE6MiYrggaRn8D9RiqObten3O1oJkk8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/+Jtx3cGsInGAUrowevrAkhoWMH60NEBJ1MZnbFlroobYYVcB
	kZsemYylhbn0b1SCdUAUSYm3M/j2cWgtxt6ho3RMpOxlamHvwFp4F7AX/se4S2qwHAOLFn6zVqN
	cqj0+6feTgUZqePqcveluJ3Rn8yo=
X-Gm-Gg: ASbGncupxE1qSvL3A81WAWs3VbicvKclJVgSaqkk7pvszg18DukEE15Ig6pc5nyTvF6
	2+3PM/nmPEH/Dvh0CgFxWiKVVxgb0wt5mISlVwErhpj89B54NrkofS7/mV9aQtMh7oJuYx3cHNn
	F5V1YKAyY+X/UGFHOxxaQ94g==
X-Google-Smtp-Source: AGHT+IGpUU0Dr0j69ZA43/sVTpHzX+UlOHTGI9+6U92xp3Xaam4yUKm6LCwuXZkWvHHEBkYoRFB8tLHhw7Kp4fLsTjM=
X-Received: by 2002:a05:6512:3f12:b0:54b:117b:b54d with SMTP id
 2adb3069b0e04-54e9e568194mr150477e87.56.1745879974899; Mon, 28 Apr 2025
 15:39:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420-pci-tegra-module-v1-0-c0a1f831354a@gmail.com>
 <20250420-pci-tegra-module-v1-2-c0a1f831354a@gmail.com> <pgp3cdksefn2z4n2hlyhftbdlfwyx7gbol7q6wdj5j4brux3cw@thts2qcahdw3>
 <CALHNRZ9R4SWtzAYocY9X7D9hm4mXeWKhdo_rk5UmRPVGD-vbBQ@mail.gmail.com>
 <lk37wtb25pr2rj3zhct5udaykr7joqw2mpgtupjq33of2xhesi@rmdgucbzxmgz>
 <CALHNRZ8gSzOVpN_au_ntSan7or=uRBrPSRFdbDqAHxitcEfs7g@mail.gmail.com> <ym5fy2svuukmoy7uvg4i4amsosjdzygxauytxoctjbjzxwqdng@o5tsy5irkgfl>
In-Reply-To: <ym5fy2svuukmoy7uvg4i4amsosjdzygxauytxoctjbjzxwqdng@o5tsy5irkgfl>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 28 Apr 2025 17:39:23 -0500
X-Gm-Features: ATxdqUH3PvKTZWXJSIROsnb_Oqs6Z73ioWcRg9tAM4X2zDrHkmm1o-UaBnHoPx4
Message-ID: <CALHNRZ-vVzNzfJRMM+i044qwvuv-bm0hB8fTZu0XQJA_qT9Mow@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI: tegra: Allow building as a module
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 27, 2025 at 10:57=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Apr 21, 2025 at 11:33:01AM -0500, Aaron Kling wrote:
> > On Mon, Apr 21, 2025 at 3:54=E2=80=AFAM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 03:09:42AM -0500, Aaron Kling wrote:
> > > > On Mon, Apr 21, 2025 at 2:52=E2=80=AFAM Manivannan Sadhasivam
> > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > >
> > > > > On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Rela=
y wrote:
> > > > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > > > >
> > > > > > The driver works fine as a module, so allow building as such.
> > > > > >
> > > > >
> > > > > In the past, the former irqchip maintainer raised concerns for al=
lowing the
> > > > > irqchip drivers to be removed from the kernel. The concern was mo=
stly (afaik)
> > > > > due to not disposing all IRQs before removing the irq_domain.
> > > > >
> > > > > So Marek submitted a series [1] that added a new API for that. Bu=
t that series
> > > > > didn't progress further. So if you want to make this driver a mod=
ule, you need
> > > > > to do 2 things:
> > > > >
> > > > > 1. Make sure the cited series gets merged and this driver uses th=
e new API.
> > > > > 2. Get an Ack from Thomas (who is the only irqchip maintainer now=
).
> > > >
> > > > Should this be a hard blocker for building this one driver as a
> > > > module? I did a quick grep of drivers/pci/controller for irq_domain=
,
> > > > then compared several of the hits to the Kconfig. And every single =
one
> > > > is tristate. Tegra is by far not a unique offender here.
> > > >
> > >
> > > Not 'unique', yes. But the situation is a bit worse atm. Some of the =
patches
> > > (making the driver as a module) were merged in the past without addre=
ssing the
> > > mapping issue.
> > >
> > > Please take a look at the reply from Marc:
> > > https://lkml.iu.edu/hypermail/linux/kernel/2207.2/08367.html
> > >
> > > Even though Marc said that disposing IRQs is not enough to make sure =
there are
> > > no dangling pointers of the IRQs in the client drivers, I'm inclined =
to atleast
> > > allow modular drivers if they could dispose all the mappings with the=
 new API.
> > > This doesn't mean that I'm not cared about the potential issue, but t=
he removing
> > > of modules is always an 'experimental' feature in the kernel. So user=
s should be
> > > aware of what they are doing. Also, we have not seen any reported iss=
ues after
> > > disposing the IRQs from the controller drivers. That also adds to my =
view on
> > > this issue.
> > >
> > > That being said, the safest option would be to get rid of the remove =
callback
> > > and make the module modular. This will allow the driver to be built a=
s a module
> > > but never getting removed (make sure .suppress_bind_attrs is also set=
).
> > .suppress_bind_attrs is already set in this driver. But what happens
> > cleanup on shutdown if the remove is dropped? Would it be better to
> > move remove to shutdown for this case?
> >
>
> remove() won't be called on shutdown path, you need to populate the shutd=
own()
> callback for that. But do note that both remove() and shutdown() serves
> different purpose, so do not just rename the function.

I did some more looking into this today and came across 662b94c3195654
[0]. That commit stated to add support to the driver to be built as a
module, but didn't touch the Kconfig, so I'm unsure how that ever
worked. But Manivannan, can you please take a look at that commit and
its message? I'm not familiar with pcie and what is required for
proper de-initialization. That commit added the remove method for the
stated purpose of making the driver a module. Implying that none of
that was needed on shutdown when built-in. So if the intent is to make
a permanent module which cannot be unloaded, as you're asking for,
does that mean it's safe to just fully revert that commit?

Sincerely,
Aaron

[0] https://github.com/torvalds/linux/commit/662b94c3195654c225174c68009455=
5c0d750d41

