Return-Path: <linux-pci+bounces-10389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033EB9331AA
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 21:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 366B11C22350
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jul 2024 19:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD901A08B0;
	Tue, 16 Jul 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DjC3DG1s"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD511A08AB
	for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156545; cv=none; b=n1zo05aBqf37bTHgfBYJUmq1ThYWwVnqGiAeqiELXgRJfOetbV0tsSEBbFjxSs86wQuRIhXcDYkgRJRQCrEUN2IZVsc5IQGPW24rFClPk2ErYce0kG7rpFuF2Alfen77hH81PaAP9lY8LoN8X6sqxtW3B/Pd0mm1P1Z+hqk1fbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156545; c=relaxed/simple;
	bh=IcvoyPAiBWsnUIXDnUolardaawkNmtHP8hBYcpNxiyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGId/eMpzNzIypvuGfYSGXHNQZiJ8a8mvwZcNePkY0LfYT3Wmvy2OEgWn+3lp6rUC+eIJ5bKU1OT290AdokQzrqpBZ4YlcXyYsvCUafKAhxI8O9jWlAWy0ETuhnrwsAyIK95BTthqV5ZFAzT85FIrUvfiCdHNLb1EsSKdiFSgHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DjC3DG1s; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e97e5a84bso8468712e87.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721156541; x=1721761341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jlb1twGtDgpkIuFqjFEwx2dSO55N1dWs34CngBK1sSM=;
        b=DjC3DG1syj+8WSO1pxFbqFTP+TOp+lIH0IWW+wDZL5r8mvx0s3kLYLacdRyQfVHrfM
         fSpfvbcJDRlqjRFXakdba/0DLKI/m9W3MLpsvOsRZa15cEUl26zZ2zbGNvwhUzyKvIQy
         GcX4Dz7UdalhsxLEfukx90CkMyF6zeqXqbMAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721156541; x=1721761341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jlb1twGtDgpkIuFqjFEwx2dSO55N1dWs34CngBK1sSM=;
        b=qOAA/S15TgYSoahQL8ZMFJCGjR9dNlcON+xjfRBGYoemrL/bwafprAGMNkq26icx7U
         lfqc/PShLs5kAgbE1yApYQ0ecpakHM564/iOxBz+MZu7Fs4vJjBdMm+6VV1QNmGFcJAp
         DRo3HOcf7izWsySsklQww/ZpHl3l0jmp8Qh7bWJTPfOALIdBNNZqx0ACgGGRowQdcuYs
         iMcxNgjb4wdcDXDNV1Zr/VgghGXRDPQj03IcS7YGtzmTF/0jHW9kFGvD6EYHMYVVoqpp
         uXNfDOWLCUXw4H1C4GmoA/f1vma6LbEfBS32tOWP7KXt+P8LQy5ZAQ0PYMGfwXioWYH7
         otSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHPXjtwvYxGu6Dm1GXvVTy19MNEVTnAVcjPAQyzQcrgdZDZjqUEsR0JF50d8EVGatzmBPVYp7APtYB1AMK7wDHOevPrqp1pYbV
X-Gm-Message-State: AOJu0Yw9ZICrF42AQxJsPKbSAwa2mKwiABw2bKACY9NFaodVecPtCGTo
	TWbu7l4EF4/uYON2mG4gtLbx7CCuBD3BCNQXuL754MbWYcyl5VAIqQyEfOcNlmOk1NzqlBTMgtm
	C7/La1A==
X-Google-Smtp-Source: AGHT+IFJvTM8Tm3xHIIthBQR0uSwstqZXVGTbL809Ng3cEHW4+5vBAVo7E0MiujhgVItUmh9/2pWPw==
X-Received: by 2002:a05:6512:1088:b0:52e:9904:71e with SMTP id 2adb3069b0e04-52edf0192f4mr2634877e87.28.1721156541385;
        Tue, 16 Jul 2024 12:02:21 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7ff91esm352391166b.168.2024.07.16.12.02.20
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 12:02:20 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4257d5fc9b7so46950335e9.2
        for <linux-pci@vger.kernel.org>; Tue, 16 Jul 2024 12:02:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMjjvL1CofAo4lVPH+T9FOIWl+JnT7nCy80bUyUg6sIzNM/YE/fQX1KtftsKJpeCjp4EO3bDiaYlY1ZhJ/oj/I0ey/Cv9xHBOY
X-Received: by 2002:a05:6000:1848:b0:367:434f:cab8 with SMTP id
 ffacd0b85a97d-368261eda5cmr3359220f8f.43.1721156540333; Tue, 16 Jul 2024
 12:02:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716152318.207178-1-brgl@bgdev.pl> <CAHk-=wj+4yA5jtzbTjctrk7Xu+88H=it2m5a-bpnnFeCQP7r=A@mail.gmail.com>
 <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
In-Reply-To: <CAMRc=MemuOOrEwN6U3usY+d0y2=Pof1dC=xE2P=23d2n5xZHLw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 12:02:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
Message-ID: <CAHk-=wg-L1K6N+0zZ-bcU7kGZMMDbXj4Z8smrsi1gvbi5U-GiQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: reduce the amount of Kconfig noise
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 11:48, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> But this patch does it. PCI_PWRCTL_PWRSEQ becomes a hidden symbol and
> the entire submenu for PCI_PWRCTL disappears. There's no question in
> Kconfig anymore.

Yes, but look here:

        default m if ((ATH11K_PCI || ATH12K) && ARCH_QCOM)

That has at least two issues:

 - what if ATH11K_PCI or ATH12K is built-in and needs this driver?
"default m" is *NOT* valid.

 - what happens when you add new drivers? You keep making this line
longer and more complicated?

See why I say "use select" instead? It means that the drivers that
need it can select it, and you avoid complicated "list X drivers"
things, but you can also get the *right* selection criteria, so that a
built-in driver will select a built-in PCI_PWRCTL_PWRSEQ option.

           Linus

