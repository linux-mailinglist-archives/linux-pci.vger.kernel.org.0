Return-Path: <linux-pci+bounces-10379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EED932E50
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 18:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D838B223CB
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 16:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4FC19E7D8;
	Tue, 16 Jul 2024 16:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xyUlONno"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7316319E7D0
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721147359; cv=none; b=APlV5YOowdDl9xuiBkGkbpnPpUtrqSxlfIH4gMNe2D2Gq87n+CZbvu15sR8jTgPoUyiJGJjMf7VIUH3ovJyn/kY8KTFh/phn+bCmyyuTNoW1f4/lBRh96QRGX87x5p8zpkbRgPXu02AC5LnX++oUBsAbrvGXjdJYjTowMeV2ETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721147359; c=relaxed/simple;
	bh=jaELMgsH3dwDaFt7EQM2pp+dxyHJV8grSRMCO/j51GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHRaB2M/t0Ss9xrzs1Adnlm5KMEjdB6aEPYOgid48jwzdvCNthgiJ/DOWeW9Rdcr/vGZiZg7LF0XdHF7pdccJVA1x7swN4ZjWvhUhbb0emICGnIFOFsceV+DUY8/vgMCK22/VxhDoXciP9mA6bgVELXY3s3vNl3pcyAlCSIUmsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xyUlONno; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2eaafda3b5cso61375231fa.3
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 09:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721147355; x=1721752155; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaELMgsH3dwDaFt7EQM2pp+dxyHJV8grSRMCO/j51GY=;
        b=xyUlONnouG0EZNNiIdE5iDSXnkABgXZwFh0RB+wA7Rte/e6gE4ad+F/B82lbt7YVhf
         yyGtQ381x69owuFBAWXHF69uT+rKsC9pTHfgkW7GaZeJzkryulfYryRq4WvepmsoAU3S
         z1ImnwovdYNvEJ+pZj/t8zTJzsbHhR+1k+ZkZhoCguFfQBX4ObR3fsygzZYCnw9LIqtn
         ogRsoNbbGtyHAgkVbW+R6nki+1LmdX0PcZsC03Qlg7TGBXjU8+E5LUwJ81f3Qa02pdyz
         hI6YtFgW7ZrtJB2YFn0vjhEHx/BXSoDiKoQfbzP8kxZBVcZjyf5hylc59Qg40gqRzjI5
         VCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721147355; x=1721752155;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaELMgsH3dwDaFt7EQM2pp+dxyHJV8grSRMCO/j51GY=;
        b=Ub/dYOrUq7zhu3EJ8bSyv32ZAf2fmrRELBAtnvCC1ZjGjmIgVoZi2tgzQrI+Mb9KRk
         aVWD8dAQhyfLnqSmpvQSu5VKmai0gXomQDsTgOCGufJ9VWcNOkvp1aGGZOFOD/7V/EHc
         fF0hJMLsMWuPKupxKhx5oF7SI6jZB9aG2GtCXc8dFlodPREusilIre9868h/71lQF2nH
         uhyR+eMcx+hNglvUA8N/Z1rdutdXdIPsPmQ9AonIvhMQIrnGqhgoaSZOBc4HCl3hGKVe
         ROlbrFUtGXbpgJnMkPxvzmjwNKmLm7T58oUj3pf7oruoOjG4GRzkAMg+7mpNc8CAAjJ0
         0NhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqmfJ/Wl6yn39RpgdI0IbOb4P/9/+4iYqptlGF0EV6RDp2tvqrX6qItc+H+s2AHHdAOCtWB3OBu83TwRa+qjYJUHNl4wKw3RRr
X-Gm-Message-State: AOJu0Yw2amipqReHKYGw3s6tGd+oNARo8PcVTt5ieoicAk1u7RvY6wwz
	IaTT5GnaAAqJv66KszdXaVy2zTj7tsCVpmPXOjS/N/Eg2f0k/4nU/injFtbXCw1IP0Vw+QxZdx0
	kWxxzfrW8VUg+KS/y1Nayjnfi3PUfrmyEyCegZQ==
X-Google-Smtp-Source: AGHT+IF8SDILOwF8rus+TVFHYwfHk25fVEqtCeF5iCh/e2abbWdCVtd8k0KCYLtTvI3BEyv+vV6eNO/gqJBcwvibr4E=
X-Received: by 2002:a2e:a306:0:b0:2ee:5ed4:792f with SMTP id
 38308e7fff4ca-2eef415b58fmr18866581fa.2.1721147355577; Tue, 16 Jul 2024
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <20240716155943.GM3446@thinkpad>
In-Reply-To: <20240716155943.GM3446@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Jul 2024 18:29:04 +0200
Message-ID: <CAMRc=McObC-+xPfZADQ2wEHO5c3htLbPZLU0Ng-VmgBPEN-2Yw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 5:59=E2=80=AFPM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Jul 16, 2024 at 05:23:18PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Kconfig will ask the user twice about power sequencing: once for the QC=
om
> > WCN power sequencing driver and then again for the PCI power control
> > driver using it.
> >
> > Let's remove the public menuconfig entry for PCI pwrctl and instead
> > default the relevant symbol to 'm' only for the architectures that
> > actually need it.
> >
>
> Why can't you put it in defconfig instead?
>

Only Qualcomm uses it right now. I don't think it's worth building it
for everyone just yet. Let's cross that bridge when we have more
platforms selecting it?

Bartosz

