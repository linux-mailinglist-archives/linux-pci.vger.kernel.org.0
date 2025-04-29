Return-Path: <linux-pci+bounces-26967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF941A9FEB2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 03:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3393AAA59
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 01:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC802110E;
	Tue, 29 Apr 2025 01:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0XhVEK/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F864431;
	Tue, 29 Apr 2025 01:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745888601; cv=none; b=XeHDrwWY26XEQTTXKnVO7flFavjq5qnKqYzqWmq9Lq4H6dBgA0P4YYENlEP8a2ow0zabckhCydqw6Quew5qS77G4b1AlDLlcEOdsDf1Ch0pHPAiJeOlXP7OSZm6XSDF4D4Z5k7ciMioXnlC2HsuaD614TCD5if8uz7YHysEKLMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745888601; c=relaxed/simple;
	bh=D54LM1EokcBcWwb7zVXbLBkzjm55ZRE/8EqX6jjn0eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhrzfGHYlTzmSpMhPR8ejrBk92QStxCi759laQPhRDD3jlC3HHmbzXWZG78u946L1KAOBajyRewbiMv+IPNiCvmtRipt/B9OJDkbjFd8B+F9PAq4dkiCjEBHtOiewusWmoDSaiSTHBjbdiBao5d0E59k+U4NSdgsxStqguphr4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0XhVEK/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso56346571fa.0;
        Mon, 28 Apr 2025 18:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745888597; x=1746493397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D54LM1EokcBcWwb7zVXbLBkzjm55ZRE/8EqX6jjn0eM=;
        b=l0XhVEK/e86hAMA0mJIjUtjK511A66jta1gD4okBnOqwZmb+H7IuofIujqwONHGG6G
         ZtPuZ1g0hhGjVpNdq+7Ooyg5vG8BFgaL3mlRn96vlAAnvYG5uGlqwMMwNg5kT/aRjbBv
         QNHfVqyV5e12bZTsJnYYpc/gjVxmUDVh0y/JEnx9nf/I7HNyfm5Wle6ZV+DZTGUoxxJF
         zZC2lEhRVjzzrLm0lfQCRDOB4gIylcAxLgF2mEqa9IYv/52WXBn9V8HEzVeCoANVXiYA
         pzXuKAWjVmyLb2c5B+4D8zmQz0TiA5fyeN98jsjn9w4Nv6aExEWZPZ2ZTIgFZIHIH+34
         u28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745888597; x=1746493397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D54LM1EokcBcWwb7zVXbLBkzjm55ZRE/8EqX6jjn0eM=;
        b=gb175KL15FDjt8JKXjdfHHfZCvXNcDumBHjIza4bgcg/pB+/eL1Pd16+qAG68TDSxL
         4mMT8+ox8uoDnVmM7rSpY8OLL9Vc5wYSfQ9DkEcEzcWyZ6esOqYkPwbvRIo74KAO8m6B
         epY3MAAKiy6GfMK9Y5Z4g8WPzV0lopIhF0CO9xOZE+U0W5MQ5AKKSLSFuDtaNgyMNvqz
         FeITm0MEH0ThOeBlkj3RUCXkVZDvOKTVwdlLU39zZyyky7kNbYlSCh7u+CSvU099WDXC
         ROCjCzzmPfRySAwCu5RHQ629/gITnz3WrFUn6fFZf+4lYVebvkrFXURu7d686SjwpnMg
         GMdg==
X-Forwarded-Encrypted: i=1; AJvYcCU6No0QM4GWy54ntO9ZGj6545xVsVdDvQONvC9FIeJwJ8FcBmvq/iOHT7TNvTHhw5sf+0fEwunppRG9@vger.kernel.org, AJvYcCX+g/5LgKBTDR72pJhF5Bm1VyC9Bdl7Uf3h10AKTkFkIz/XTMEL+cLgtYwSWABNc148eztgEPCZTpkBjqc=@vger.kernel.org, AJvYcCXb2SQErjoUoCmll401aQp/DhEzaQAIbZUyJ5TRknEUCrPC2q0z/Lmw4mGibwYcz/BTBsJF3qNCipFqRVY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/KM1W/3mmzhl3CpUQ2apxzvD3a3oMvKUCjy9j/8XNHlkfYBKx
	4yNreMeeMVkTeXXIivKHPBVoss++TrqQNNb8GHVYWwBy6EdZ8yxUWtlm+WtOeSOlWapLja3Hl6I
	LLFzpmO/NYHHYT9EFDfcuNMmIePI=
X-Gm-Gg: ASbGncsuyNY8VW43b7S9t9ZqmGfRKrNXVN68k/KwMsWUxaim7EiePIucdr5GDewCXLG
	sOV/aSwWBEFfQSPmM/pNsfRfdSpnHLaHWiyBJGPsin7Bns7eidm2ckrZZKAaCkHj+NHPiMY6ZCL
	DusJXbQOsovNhhanbsW+SSpA==
X-Google-Smtp-Source: AGHT+IEjvJFHoey6ljQ/RgDq5h5qVMycmqh5UW/LDFkyx6BnXXkYO9IFfV0nlG5Ns7OT+ovEFe2p4f4Z7OTgA/kp81o=
X-Received: by 2002:a05:651c:30c1:b0:309:23ea:5919 with SMTP id
 38308e7fff4ca-319dd1c2311mr36732911fa.31.1745888596953; Mon, 28 Apr 2025
 18:03:16 -0700 (PDT)
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
 <CALHNRZ8gSzOVpN_au_ntSan7or=uRBrPSRFdbDqAHxitcEfs7g@mail.gmail.com>
 <ym5fy2svuukmoy7uvg4i4amsosjdzygxauytxoctjbjzxwqdng@o5tsy5irkgfl> <CALHNRZ-vVzNzfJRMM+i044qwvuv-bm0hB8fTZu0XQJA_qT9Mow@mail.gmail.com>
In-Reply-To: <CALHNRZ-vVzNzfJRMM+i044qwvuv-bm0hB8fTZu0XQJA_qT9Mow@mail.gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Mon, 28 Apr 2025 20:03:05 -0500
X-Gm-Features: ATxdqUE0jyuMTNibzBiFUb9mGsP1YqtWOSwv5NGthnoGhA0qliD6ylNHeZyUi9Q
Message-ID: <CALHNRZ_r4H=QY8K9L8vWSzDCoym8O9DBmeTnQi5LeVVb+6Vn=w@mail.gmail.com>
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

On Mon, Apr 28, 2025 at 5:39=E2=80=AFPM Aaron Kling <webgeek1234@gmail.com>=
 wrote:
>
> On Sun, Apr 27, 2025 at 10:57=E2=80=AFAM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Mon, Apr 21, 2025 at 11:33:01AM -0500, Aaron Kling wrote:
> > > On Mon, Apr 21, 2025 at 3:54=E2=80=AFAM Manivannan Sadhasivam
> > > <manivannan.sadhasivam@linaro.org> wrote:
> > > >
> > > > On Mon, Apr 21, 2025 at 03:09:42AM -0500, Aaron Kling wrote:
> > > > > On Mon, Apr 21, 2025 at 2:52=E2=80=AFAM Manivannan Sadhasivam
> > > > > <manivannan.sadhasivam@linaro.org> wrote:
> > > > > >
> > > > > > On Sun, Apr 20, 2025 at 09:59:06PM -0500, Aaron Kling via B4 Re=
lay wrote:
> > > > > > > From: Aaron Kling <webgeek1234@gmail.com>
> > > > > > >
> > > > > > > The driver works fine as a module, so allow building as such.
> > > > > > >
> > > > > >
> > > > > > In the past, the former irqchip maintainer raised concerns for =
allowing the
> > > > > > irqchip drivers to be removed from the kernel. The concern was =
mostly (afaik)
> > > > > > due to not disposing all IRQs before removing the irq_domain.
> > > > > >
> > > > > > So Marek submitted a series [1] that added a new API for that. =
But that series
> > > > > > didn't progress further. So if you want to make this driver a m=
odule, you need
> > > > > > to do 2 things:
> > > > > >
> > > > > > 1. Make sure the cited series gets merged and this driver uses =
the new API.
> > > > > > 2. Get an Ack from Thomas (who is the only irqchip maintainer n=
ow).
> > > > >
> > > > > Should this be a hard blocker for building this one driver as a
> > > > > module? I did a quick grep of drivers/pci/controller for irq_doma=
in,
> > > > > then compared several of the hits to the Kconfig. And every singl=
e one
> > > > > is tristate. Tegra is by far not a unique offender here.
> > > > >
> > > >
> > > > Not 'unique', yes. But the situation is a bit worse atm. Some of th=
e patches
> > > > (making the driver as a module) were merged in the past without add=
ressing the
> > > > mapping issue.
> > > >
> > > > Please take a look at the reply from Marc:
> > > > https://lkml.iu.edu/hypermail/linux/kernel/2207.2/08367.html
> > > >
> > > > Even though Marc said that disposing IRQs is not enough to make sur=
e there are
> > > > no dangling pointers of the IRQs in the client drivers, I'm incline=
d to atleast
> > > > allow modular drivers if they could dispose all the mappings with t=
he new API.
> > > > This doesn't mean that I'm not cared about the potential issue, but=
 the removing
> > > > of modules is always an 'experimental' feature in the kernel. So us=
ers should be
> > > > aware of what they are doing. Also, we have not seen any reported i=
ssues after
> > > > disposing the IRQs from the controller drivers. That also adds to m=
y view on
> > > > this issue.
> > > >
> > > > That being said, the safest option would be to get rid of the remov=
e callback
> > > > and make the module modular. This will allow the driver to be built=
 as a module
> > > > but never getting removed (make sure .suppress_bind_attrs is also s=
et).
> > > .suppress_bind_attrs is already set in this driver. But what happens
> > > cleanup on shutdown if the remove is dropped? Would it be better to
> > > move remove to shutdown for this case?
> > >
> >
> > remove() won't be called on shutdown path, you need to populate the shu=
tdown()
> > callback for that. But do note that both remove() and shutdown() serves
> > different purpose, so do not just rename the function.
>
> I did some more looking into this today and came across 662b94c3195654
> [0]. That commit stated to add support to the driver to be built as a
> module, but didn't touch the Kconfig, so I'm unsure how that ever
> worked. But Manivannan, can you please take a look at that commit and
> its message? I'm not familiar with pcie and what is required for
> proper de-initialization. That commit added the remove method for the
> stated purpose of making the driver a module. Implying that none of
> that was needed on shutdown when built-in. So if the intent is to make
> a permanent module which cannot be unloaded, as you're asking for,
> does that mean it's safe to just fully revert that commit?

After some actual testing, I note that dropping the remove callback
does not affect whether a module can be unloaded. However, dropping
the module exit routine does. So I've folded that into the v2 that I'm
pushing shortly.

Sincerely,
Aaron

