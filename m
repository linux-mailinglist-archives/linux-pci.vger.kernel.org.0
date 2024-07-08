Return-Path: <linux-pci+bounces-9940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E370F92A618
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 987991F217B9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2A7144D3E;
	Mon,  8 Jul 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="egHv47s/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672CA143752
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453801; cv=none; b=g8fBCVjOqL0esbGKTFja8bVug3CeARbFNhusBCEBn6oPhtmdhAJ/zNApMaYSm2n824EfLIgK+6Pl475O4oM4cH9vtWuft2dOIUM+xnaAjJj5HrVZ0+KiMC7X2R/l5f8jSButihAzLZfV6rw4y46WsWYEoATUY5ywJG52LMe7oNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453801; c=relaxed/simple;
	bh=aMie6vsOILEgoY6g3H8AYCqCn9l3ZuNa+REvtFWGxCA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FD6KWMItQRTPHqzuO1s3ljo3j5Thm7/OxLKQSp5JRPn4tF/emkneGuIEKmicZvPN9eZGTdNpqR6H0/WB7oVhbWmEypS5O8H8Q4VBrP0cFTcsM41KzYDsOiGp+blaOcPbA7ZKJmigco4WMVeOALQIFwjHecn+WMweaC/LcMjazEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=egHv47s/; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52ea5765e75so4104950e87.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jul 2024 08:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1720453797; x=1721058597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAmkRYZgO1BlgPpfphuT9vbISnSlgIztX9vNgMJRHsY=;
        b=egHv47s/f8X3QZwYKoRaMJhTDt65gb7c6d2WOltxOjyODJnWx310E/oizD+pcT/29w
         wPxqJ7ZpHnmTSK7iukKlnj4isJPeqYChQ9IB0Z9AsQ2MaQMZlW07wfG4i87JefCTWlrU
         mYJ6v89Dj/LFFeFNFZmr0sWhFoq+qsUOm/ug7M/vwq063wEeTNWSuG+mTLVEFKqAr6Gb
         QeuRt6sjQ0EmMzf5wdQrDQoDepUcKWEceCyNU8w508vwDmfJxwpBBIzGVRenM3FfW6rm
         jLtRltc36WkamWXFKPJCwShuixeI0QBhKN402LtVhh3dP5cGLrTQ7ekWozEQoUd3e6oN
         zWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720453797; x=1721058597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iAmkRYZgO1BlgPpfphuT9vbISnSlgIztX9vNgMJRHsY=;
        b=hihRkSQJNntyJih0DdE25obndb685w96o7Pu7L062Laa4A5zMz8qa3sHL+RYN43kO9
         /otAzk4QNTtcrQVcgL1GVbGkZonrg6BEajnOSOMuZGU8x/lC6PYh72qtlyNlACTCxXY2
         mHh4egyagDiXzn5rpMY6VvN1v1vQC6O36LWz4EF/fspczEnikZd+ds4yqjZTOmv8hlap
         tRwkg1rFjHEz62DSWjhFDBl7WWaccx2cuz/nWa25UsEQl5++OtELkDpgRmGoPY0ivCL6
         +kAktYx1FLgRcQFI7ngOryz1PJyCUxz1Wo0LX1gc1fROdqzwIYHxRzhGk2Y67fMr+Z+x
         PKwA==
X-Forwarded-Encrypted: i=1; AJvYcCWl4yXG7PlJNnnEU1wlSahzkEoq9eu8Q+5hM2DbJGVpwhohbiR+HZ8O+NZnrqGhyj4dWxXi3MP2ztOtnTlg/rwcFxwYtae1atN0
X-Gm-Message-State: AOJu0YzVv4r6bgAbQotbIS7CfnZAfD4Pi1sFWx9db2rRHvRWayCi7gkm
	8ocrmTMHNVYn9tl1kSYq0YxWtUn25kJLta/a/YEHoPPRcYVCRjAnSXIzRbMvAL+8jAEQ//YDVF2
	3jbv7Ohxia3ir4Qm6nArNUt23STEJP6qG6Qt+Mg==
X-Google-Smtp-Source: AGHT+IEGhcFuXoK4GBF7SRfviyLeK/+pb4UqQkCdFeeIJdiqgPpQasP8HoS5kJFnaRqmVXhzj5v5dHa1juPpqcGX+g0=
X-Received: by 2002:a19:910b:0:b0:52c:c032:538d with SMTP id
 2adb3069b0e04-52ea062e3bbmr7370190e87.27.1720453797454; Mon, 08 Jul 2024
 08:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante> <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante> <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
 <20240708154401.GD5745@thinkpad> <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
In-Reply-To: <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 8 Jul 2024 17:49:46 +0200
Message-ID: <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Mario Limonciello <superm1@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, 
	bhelgaas@google.com, amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 5:46=E2=80=AFPM Mario Limonciello <superm1@kernel.or=
g> wrote:
>
> On 7/8/2024 10:44, Manivannan Sadhasivam wrote:
> > On Mon, Jul 08, 2024 at 05:34:29PM +0200, Bartosz Golaszewski wrote:
> >> On Mon, 8 Jul 2024 at 17:29, Mario Limonciello <superm1@kernel.org> wr=
ote:
> >>>
> >>> On 7/8/2024 3:33, Krzysztof Wilczy=C5=84ski wrote:
> >>>> [...]
> >>>>>> If there aren't any objections, I will take this via the PCI tree,=
 and add
> >>>>>> the missing tags.  So, no need to send a new version of this patch=
.
> >>>>>>
> >>>>>> Thank you for the work here!  Appreciated.
> >>>>>>
> >>>>>>           Krzysztof
> >>>>>
> >>>>> I don't think you can take it via the PCI tree as it depends on the
> >>>>> changes that went via the new pwrseq tree (with Bjorn's blessing).
> >>>>
> >>>> Aye.
> >>>>
> >>>>> Please leave your Ack here and I will take it with the other PCI
> >>>>> pwrctl changes.
> >>>>
> >>>> Sounds good!  With that...
> >>>>
> >>>> Acked-by: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> >>>>
> >>>>> After the upcoming merge window we should go back to normal.
> >>>>
> >>>> Thank you!
> >>>>
> >>>>        Krzysztof
> >>>
> >>> FWIW this other patch makes it quieter too.
> >>>
> >>> https://lore.kernel.org/linux-pci/20240702180839.71491-1-superm1@kern=
el.org/
> >>
> >> I had applied it previously but backed it out in favor of the new one.
> >>
> >
> > That sounds sensible. The patch referenced above still causes
> > of_platform_populate() to be called on non-OF platforms, which is not o=
ptimal.
>
> But couldn't I just as well have CONFIG_OF enabled in my kconfig and get
> the same new noise?
>

If you have CONFIG_OF enabled then of_platform_populate() will go the
normal path and actually try to populate sub-nodes of the host bridge
node. If there are no OF nodes (not a device-tree system) then it will
fail.

Bart

