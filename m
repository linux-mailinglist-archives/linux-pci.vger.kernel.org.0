Return-Path: <linux-pci+bounces-8745-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA7E90788F
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6E22B21B14
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6B1494AB;
	Thu, 13 Jun 2024 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpXgMwNi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEFB12F386;
	Thu, 13 Jun 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297092; cv=none; b=ckpawPa113kicHXl5PisOa3RxK+/h2AtV6HYfwMWlvqfagOtwXcdVbKkVO4hIXc78YVLuVrNmzukn0Ov9iMarKGgOR7NFj2TBBLmrmt9slSU3TKa74vOOVjtcShmbw/cFhlSP7v6NeyvUoQyawoW9aJ+olCtsJzWBVWQWBKOf+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297092; c=relaxed/simple;
	bh=XritPzwaYxeYxC5f9JxbIYb9KuNoPNbdU//mOZmejCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvvxEVouE5pfG8nMGFxZ41H2QQH7Sx3dPMsaUo/QUp4D2jlmO2w4Vb5i1PO7uMCv2Y1SpTpPS2T0XfslZH92NJYtIqxYAyuRcnWWE0A+d9LiEtTdUmPhhLsBvzijPXyY6BTa7FCYEod1vdWl9QZhpYkGR6jdzH2mGJ3cdhCUoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpXgMwNi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so1460709e87.3;
        Thu, 13 Jun 2024 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718297089; x=1718901889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XritPzwaYxeYxC5f9JxbIYb9KuNoPNbdU//mOZmejCg=;
        b=UpXgMwNi5Tcq1RXZfh2MVAI6Fom9W8o5Pl1q5hUolYlioscklMkTvzJ2NhNUara67E
         hzIYIwPhZ/q9E2/cURN0q58uEr+99pQnHLdGhG2fD2f0SX4eflhWJQS9d1FNNug3pRcX
         etOJZw2VWvY2hiGdfNp3IxF6f9cfrQHfmu071xXiR3JHdvSAL6FTWQSVF1StZ8lkPtLe
         Im1ptO82XRq6ylP5yQNw4PBUmKOX1I1sCXrd2sa0B6RAWoAwawsKkfkx4Is+qfJr9PE3
         pV//F18hATbKhBTrGExrsQcIJEKqBP5M/H/Q3MJgsvUj2F1t4HY5xDmRRfArAeVVSGOd
         cIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297089; x=1718901889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XritPzwaYxeYxC5f9JxbIYb9KuNoPNbdU//mOZmejCg=;
        b=ClxgIv/4AekjHo5th7OZpy/+RplnVbEwNa2To+Fv32Gzlq3Osa8/t2FnaKb0UxbICI
         Sopl5412L/g9aj+6Lkb1YESli3GKGyfBR24VNvsbU1LZCMQNtLXTqcp+dO6h6T8XoMC0
         2KHUtLMz95fuFlp+W2IgFYZpfFNpDE5HKViafNOnoVhXpzRS1j0o7tIydDcUhCEW8Vg2
         KBcoaBl7bUU5GtFw1XSkG0LXH838l1blZ72MTQrOXOq6PBbeNs0/iVJ7Pkv+8KwL9k7X
         pW2j2jeSqlQURrI9+oflBBRD/xpuw6IM4PWk8372zgRwC2FwRfWa+3uHUPIWGvBp+gSO
         4EQA==
X-Forwarded-Encrypted: i=1; AJvYcCVB+rXnMk/5VRGQ7XxYEuXTy1fgjUiR8o1Ofk9S5BpL4Bszqirlc1XRrZ70CL4wVbTcVx2s+YG0Eg9swCZgThWRJCqYYGMauHajcqvX
X-Gm-Message-State: AOJu0Yybbyg1DmxAiCn+0YXaH9trjIAxDdmurAdzmPsWilSTmuJHndDB
	EHunfoh42QS8P1ibArsK0MW+zH9qr/e2ZaHwowbYk4BtNkCR4mi/i3Y43urGcBHuquzAgZb5dkk
	PR0ADFRoB7AKJdnMzRm3c8WdpbDc=
X-Google-Smtp-Source: AGHT+IFVgmbe/tBoklkDRijH/gjK5r0xcpaKid7FUWjBb3PNSWjsBdpQo56ITJorAjETY0Jlv/aBMuV2ngbUe2rSAq8=
X-Received: by 2002:a2e:9e59:0:b0:2ea:e26d:c9b9 with SMTP id
 38308e7fff4ca-2ec0e5b5142mr2856361fa.10.1718297088682; Thu, 13 Jun 2024
 09:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613082449.197397-1-ubizjak@gmail.com> <20240613155134.GA1062951@bhelgaas>
In-Reply-To: <20240613155134.GA1062951@bhelgaas>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 13 Jun 2024 18:44:36 +0200
Message-ID: <CAFULd4YmckrG1RBzSnhtNCWmmLmU4JhXOxwBGOLdrOu=FWLOuA@mail.gmail.com>
Subject: Re: [PATCH] PCI: hotplug: Use atomic_{fetch_}andnot() where appropriate
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:51=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+cc Lukas, Ilpo]
>
> On Thu, Jun 13, 2024 at 10:24:24AM +0200, Uros Bizjak wrote:
> > Use atomic_{fetch_}andnot(i, v) instead of atomic_{fetch_}and(~i, v).
>
> If the purpose is to improve readability, let's mention that here.
> Since this only touches pciehp, make the subject line "PCI: pciehp:
> ..." as was done in the past.
>
> It looks like every use of atomic_and() uses a ~value and is hence a
> candidate for a similar change, but I'm not sure that converting to
> "andnot" and removing the explicit bitwise NOT is really a readability
> benefit.
>
> If it were named something like "atomic_clear_bits", I'd be totally in
> favor since that's a little higher-level description, but that ship
> has long since sailed.

FYI, the set of atomic primitives and their corresponding names have
quite a long history. These are based on IA-64 psABI [1, section 7.4]
when this particular primitive was named
__sync_nand_and_fetch/__sync_fetch_and_nand. Even GCC got the and-not
part wrong (it implemented it as not-and in some ancient version), so
luckily the kernel named it atomic_{fetch_}andnot.

As far as the patch is concerned, some architectures emit atomic
andnot instruction. In the proposed patch, we have a constant argument
to atomic_and, and the compiler is smart enough to apply the bitwise
not to the argument and emits an inverted constant argument. So, in
reality, the same code is produced.

x86 with BMI1 ISA extension provides ANDN instruction, but it can't be
used with LOCK prefix.

So, if there is no readability benefit, it is OK with me to drop the patch.

[1] https://refspecs.linuxfoundation.org/elf/IA64-SysV-psABI.pdf

Thanks,
Uros.

