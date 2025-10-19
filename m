Return-Path: <linux-pci+bounces-38673-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25D5BEE2E4
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 12:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33C83B3764
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 10:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB912E2850;
	Sun, 19 Oct 2025 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOCDcxVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC02DFA3E
	for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760869186; cv=none; b=MMwpDjBeVwVAqjXIjKLnPciraIF2nAZeOdMn9O15+9vjz6di9qkXkYU2NkWy/uyBOJX0seb0g6AWlT3rlf+USGFbsxsznM9jeHr/LSpqiKzUnI8e4OxToF6p1Sz9O7ElqN0JK96RILh/dsrOHZrZx0lF3y6xdxEMG9lcqObaMUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760869186; c=relaxed/simple;
	bh=AvSMkWBk2P+bf9T9tvFUkUXa08IIJOiWTUuacIDeoek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I1cmUaZ3Zjyh3uXUbsIarVxE93vtzgYLO74EpundH6Qf9fd+9089f22JRdlo3Dx/yGEH+ViGzcEqE3iMiqWfNW+SP2//O5ivxuJ4cldNv96z4ei81hQJAOKIvNmO3Y87G62ebWOvPTveP+i9PwcFJS8gwT4wh2ETeB4XDAhE2jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOCDcxVb; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so6447399a12.3
        for <linux-pci@vger.kernel.org>; Sun, 19 Oct 2025 03:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760869183; x=1761473983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AvSMkWBk2P+bf9T9tvFUkUXa08IIJOiWTUuacIDeoek=;
        b=hOCDcxVbWlR+j2joArLp3enyz2A3go+Zq6vCnX7gJs1YVRl4rOlRSyUY17Um5JUy3n
         XNGtPNq2Ys8IaSluyuNZt8eIqse2TSFHq6deSlTUiKDyRbq+IhELanpPCLJEt5kA9nBG
         sm/dIJTlLRaWfn7Y+dUoYdWJdTg62VRgXUQikrrDcI+OslQVn+FPpsHasnzL/pkSQYEH
         grbnsQWsHmuH/IBrjErGF13Zpuqzc/8c6ucNxdsksyCHV6Bljwd45gpYJ8mu6BRvX3vQ
         B5O8SdxC78oMTjdGaqaSWzzudVqcyGUna8eWUagrzENye7SglKgLWlsyzHg7FW/JawFv
         fOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760869183; x=1761473983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvSMkWBk2P+bf9T9tvFUkUXa08IIJOiWTUuacIDeoek=;
        b=pyB+Mh4SbLYCdkrUXdWpE2gSSdljYWr5p1J2aD13silLVdCvFwo8x1oJBXOVQPPqG6
         r5QSSAw3gHa1lRJl+O3aVZLqpJOAb9EJjXQbSbuOKP8gerSFBQEkM0Mm7dz/uVXSMBd4
         6s9PieVWMVUX8WCG4zAiqY1B0R79jzp6Scwc7P+LgQs+O79Z9R47jv20ofYikQ2nq4by
         UhHif2rH8dWZoGooneKKF6IAZk43zorOBhlRwq7m6DIeK9Ps63YD0RntjvEmYxA/xOkJ
         suVT0v6EBYe4YpczOFFpQpErHP8UB+Rmlo8lzOIkKzKNGKYoT55g0PPnPlDzNgsVgvqL
         WS6Q==
X-Forwarded-Encrypted: i=1; AJvYcCX0lH5XE+z3FDY3Luy8WKzk1wEVV7ScwuNFT2mIN5TNRZqUfnrncriEt85I/3dvPfPu184MWUaJvOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXiAxMld+v1JA0rooF8bTa51SbG0uG1iFBqBuHVWL3LglgQGMg
	93U9rISUfYlXgtO/Y302BLm2B1VPW89NdEVOt9El+9xoV8AAomjaQpXia+B3UwnmUkiz18FeWx3
	MbH68M+Hjj+wB/FQchSAAUVFwtHh4PEw=
X-Gm-Gg: ASbGncsiO1jFcy7UWTY1JPuNShaVkgohC5LWCDNZ2MDlB0XXszT5WGf8gQs4ChRgaYz
	LkshekoSrrRAEdToYh7wEFYoNx4b6uNz43yt5dlTDodoFD7DJybhzhYuQruBfajkaAIghGuDOnU
	yThuOadV7xtg9h8CEZqf7EoqJQcWLtPwa0ZPzlm3zi3EBQXAAvHOrnNlrHIiRtru5+fxX9sAm+E
	W9pSm+tIJxCpQEwygxfFNiPwZVNmaVes4hprxAVn2QehTkCs6q2mFhFTwmadBcLDu+0fg==
X-Google-Smtp-Source: AGHT+IHJ1tnb98CMoVnwt5Oq2sMdy3alKsHrj5KesBOi1LOMklAyV4xT7dnJUZXb8MKel/MUWFEzehg9HP3NPFtujCE=
X-Received: by 2002:a05:6402:1e95:b0:63b:f3a9:f5f1 with SMTP id
 4fb4d7f45d1cf-63c1f633eebmr9023808a12.14.1760869182751; Sun, 19 Oct 2025
 03:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr>
 <03a8fd58-cce5-4b84-adef-6cec235c582b@web.de> <CANAwSgRv6J864HF4Qqab_6qq96=8oKn0aHT5WjypUykgTJFmzw@mail.gmail.com>
 <e88cb990-bf11-40f7-9c71-b14614fe53bf@web.de>
In-Reply-To: <e88cb990-bf11-40f7-9c71-b14614fe53bf@web.de>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 19 Oct 2025 15:49:28 +0530
X-Gm-Features: AS18NWC9ThuvYuttzm6oV6rgSMF7z_2qt5iRg3jbf-_Yb9XXNlpi814XZb8xxY0
Message-ID: <CANAwSgQmpJGo1SYDOmDQ39Fx5UH3_v857qiJpVCcxqUK=_V0Gg@mail.gmail.com>
Subject: Re: PCI/pwrctrl: Propagate dev_err_probe return value
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Markus,

On Sun, 19 Oct 2025 at 14:26, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >> How does this view fit to the commit ab81f2f79c683c94bac622aafafbe8232e547159
> >> ("PCI/pwrctrl: Fix double cleanup on devm_add_action_or_reset() failure")
> >> from 2025-08-13?
> >>
> > Thank you for your guidance. My previous understanding was incorrect.
>
> Will an adjusted software understanding influence further collateral evolutions?
>
I will try to be more correct and improve myself.
Sorry for the inconvenience,

> Regards,
> Markus

Thanks
-Anand

