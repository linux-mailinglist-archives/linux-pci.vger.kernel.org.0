Return-Path: <linux-pci+bounces-4048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE078867EA4
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 18:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0D3E1C2BD94
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 17:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7012D75F;
	Mon, 26 Feb 2024 17:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBTtGJne"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C460F12C520;
	Mon, 26 Feb 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708968809; cv=none; b=g7h4E0+XAnkrmLRHhZjNsNVYbAYgyDqX5GqFBTSRSeJyqqiw9/P3Kvj0A3k9wHf8K9HexBr47bi+/bzDbJlcl5GrS55RoFBX39/Pje7DY8KXHLr3tTG6UyJ5ZwYfc5RjtBSADQeKZv3M5cjF62r/WRzSzI3Ci8eUDMOFwLUhufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708968809; c=relaxed/simple;
	bh=L9Tf97QS/Z2NcZn7vpgB9d+a2GHv2SM+ZBIc4L1I76Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RixKa/4AN+8ZQfvhOK9SDVJ/QoMzWOddRAq9eBG5yJt/eKXu5xvBK42KMvz0PUeqFqK25eHIpuyKxG0z+CtoKChqwVtN0+NuKW9A+c/LeTxToqhxwlsAcHIx3BWruLaz7v7Fut4cJHfejaJIsYGiUoVHBNTd68HB7pmNbjKJepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBTtGJne; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d180d6bd32so49002791fa.1;
        Mon, 26 Feb 2024 09:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708968806; x=1709573606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=beWsM29gMRJcRF7iuTDVrHljWW5n6TmO03OyS7o80Zo=;
        b=CBTtGJneCLZjbstda3knsAtSVNehRACoEdhgbDgSvU6tvuNOo6OayCkiUcz0JxZhIA
         8QVJWTVQJQ+y8dzlkt+MciJ5ne6nMdGEsiJvqQ17yGF2gdWQOnUhr4UOZqItmfElm4/A
         mo27ozS9MTdnU7egyXy3cNJLsysRd2HfaRCmr+MN+kGZ0Gh8FQPjOTpxZR+nwTt4VXDh
         02erwD6IsSz8VZ0zj+cQCNAOJy1+dkKbINHtfu65ge1QaPDIH2BVQCMyknHoeIztSBr8
         r7kD27sBjBicZOe88OxG6LPw8uBpfDtVM5xb/9RL2WhpbedhLw7uvHXWNddnxb/wklGm
         bRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708968806; x=1709573606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=beWsM29gMRJcRF7iuTDVrHljWW5n6TmO03OyS7o80Zo=;
        b=qQ+Ggvl2mYOLRjwu/i+glOrtXEKuMJ094TRHalmZQ8D4iGwBPH3WTihAGD/RBmQIz4
         ejalt693Q9OU+AKxSTZFl/25UXIEf8A+DNz3tXb5BicWhpKRscTj0PHKDSW684qHo4HS
         gOCsaAKuygWLwG7m+iQUReLTmcAkDGiF8D4aXT20eYnqEZi9fHmM1I1nbbzGujhjgnJR
         ffMCifAg2ffS9qSwvUeIGFnd9MrW35LMEMvmubzh2SxJR6dl6lgBptWVbC/sraor2JTN
         pm6o5Yh3hm50+C8MfwZ7cubobdKuI2oa8W3smDvR4G3KRH5DDp+/gxagvSTOst3TlQm9
         fiJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqqQ/9QqaIi7XckL1DlsdL6ECO9+SN6aksS/tf2ihy7ZDhx75ZhRictIkSOj+7sgzy9sbH751woijbCwlU5qlFuy2lSu7ss1GeNjK9E0/Jm2lALj2v1LjmX0omlSSfbSDM0ewoABx3NihK6l1fT+e14/06LHYFWQ2M0CvMTUs=
X-Gm-Message-State: AOJu0YxYtxwy1qZwIgNobaTKFK0Bp9F2V9rZkM2UFIFgc4/AurSzjRYe
	OXiXuyuxOIf4q6DpBfozM1Z2pe+k5g9nH+aOYGSY1PCgKyJELolmYHEFArZ1CbHavPvUCCSC2AJ
	ZNumXhLCCat+Mgr5x6tznUTTRFlQ=
X-Google-Smtp-Source: AGHT+IHiJbdfFHQ/BZKnrZSYBSDiKtY7SKjNcV5qa/oMXNaxzf738m1BTOuRymI2x4+iOrVhHsr5qt0VFgzS/i+ceoc=
X-Received: by 2002:a05:6512:2e8:b0:512:b25a:dfdb with SMTP id
 m8-20020a05651202e800b00512b25adfdbmr4557141lfq.27.1708968805600; Mon, 26 Feb
 2024 09:33:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKfmkPKW=cD88D-cYJUaoN0A6i91C5ukiy6AYYWpNbW8VBQaGA@mail.gmail.com>
 <20240225233117.GA182018@bhelgaas> <CAKfmkPK+T0887-uQORxOzbcz-ZxBY+wKLYPRoiQiUfNhffQBEg@mail.gmail.com>
 <0aa430ff-c60d-b2c6-bb1c-e352ae7be020@linux.intel.com>
In-Reply-To: <0aa430ff-c60d-b2c6-bb1c-e352ae7be020@linux.intel.com>
From: Mathias De Weerdt <mathias.de.weerdt@gmail.com>
Date: Mon, 26 Feb 2024 18:33:11 +0100
Message-ID: <CAKfmkPJUSVZgGSrD4qNnxHDK7zE-S119L-HR2asDSGhnsCEU6Q@mail.gmail.com>
Subject: Re: Bug Report: Delayed Wake from Suspend with Genesys Logic GL9755
 SD Host Controller
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ben.chuang@genesyslogic.com.tw, johnsonm@danlj.org, 
	linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-pm@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo

That worked! I can now wake almost instantly from suspension.

Thanks for the quick responses!

On Mon, 26 Feb 2024 at 12:49, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 26 Feb 2024, Mathias De Weerdt wrote:
>
> > Hi Bjorn
> >
> > This has indeed never worked. I have even tried plenty of older
> > kernels and now also the latest mainline.
> >
> > I collected the data you requested on the following kernel (Latest
> > mainline as of yesterday)
> > Linux core-arch 6.8.0-rc5-1-mainline #1 SMP PREEMPT_DYNAMIC Sun, 25
> > Feb 2024 21:59:28 +0000 x86_64 GNU/Linux
> >
> > After booting the laptop I put it to sleep and woke it up and
> > collected the dmesg and lspci logs. (They have been attached)
> >
> > Thanks for your quick response.
> > If you need anything else please let me know.
> >
> > Kinds regards
> > Mathias
> >
> > On Mon, 26 Feb 2024 at 00:31, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > On Sun, Feb 25, 2024 at 11:38:35PM +0100, Mathias De Weerdt wrote:
> > > > Hi
> > > >
> > > > I am writing to report a potential bug in the Linux kernel related =
to
> > > > waking from suspend on a system(Laptop) with a Genesys Logic GL9755=
 SD
> > > > Host Controller. Below are the details of the issue:
> > >
> > > Hi Mathias, thanks very much for this report.  A few questions below.
> > >
> > > > Issue Description:
> > > > After suspending the system, waking it up takes an extended amount =
of
> > > > time, typically 1 to 2 minutes. The delay occurs consistently and i=
s
> > > > observed in the dmesg logs.
> > > >
> > > >
> > > > System Information:
> > > > - OS: Arch Linux x86_64
> > > > - Kernel: 6.7.5-arch1-1 and 6.7.6-arch1-1
> > > > - SD Host Controller: Genesys Logic GL9755 SD Host Controller (PCI =
ID:
> > > > 17a0:9755)
> > > >
> > > > Observed Logs (dmesg):
> > > > [ 642.483972] sdhci-pci 0000:2f:00.0: not ready 1023ms after resume=
; waiting
> > > > [ 643.537370] sdhci-pci 0000:2f:00.0: not ready 2047ms after resume=
; waiting
> > > > [ 645.724028] sdhci-pci 0000:2f:00.0: not ready 4095ms after resume=
; waiting
> > > > [ 649.990655] sdhci-pci 0000:2f:00.0: not ready 8191ms after resume=
; waiting
> > > > [ 658.310658] sdhci-pci 0000:2f:00.0: not ready 16383ms after resum=
e; waiting
> > > > [ 675.590673] sdhci-pci 0000:2f:00.0: not ready 32767ms after resum=
e; waiting
> > > > [ 709.723965] sdhci-pci 0000:2f:00.0: not ready 65535ms after resum=
e; giving up
> > > > [ 709.724183] sdhci-pci 0000:2f:00.0: Unable to change power state
> > > > from D3cold to D0, device inaccessible
>
> Hi Mathias,
>
> In your dmesg, there's the Target Speed quirk triggering. Please try thes=
e
> two patches, they should fix the logic bug that causes the long delay you
> see:
>
> https://lore.kernel.org/linux-pci/alpine.DEB.2.21.2402092125070.2376@angi=
e.orcam.me.uk/T/#t
>
> (They won't help to the link not coming up issue though).
>
> --
>  i.

