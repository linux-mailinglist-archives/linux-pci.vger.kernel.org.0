Return-Path: <linux-pci+bounces-12604-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8659680C9
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 09:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D03181C22047
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 07:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDD6178CCA;
	Mon,  2 Sep 2024 07:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WRRy/5Et"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A152178CC5
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 07:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725262702; cv=none; b=sblICb1DsdL8UoWe/k0w0d4IzH8ChwLMHb2gzLQlqaMQ15s0uO90sMlRTDd7gSfWpZnz2ZN97BrTqYC7KwwF33xAZSDR0qEaBYBgOIw6kOBW536ws2Xi9EpRWLT4KWZrye9EyacEVh7meGWreY0DYUo/TZ9j4jtPzub/CGV/qaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725262702; c=relaxed/simple;
	bh=BEJNUtN7GcPC4B29NBJfhJaZCRGwXQGoQMbbCrX/D1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFCANKc76hgc2mfeH5mtlmWUgEz9XqAIbVZWyGuF+un3U/jhDOXIRHOZ0PFliDnOyITW3bADFy10ySZT7i07xrb7tzoRn4zMS6mpIjEtXi1JAuIV0YB0meOVU2KF+vY7ZTzH5DcLA/WrWTpdLj3sVZqN2qmwm5yGypEau+ZFBNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=WRRy/5Et; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f3eabcd293so43846981fa.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725262698; x=1725867498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEJNUtN7GcPC4B29NBJfhJaZCRGwXQGoQMbbCrX/D1o=;
        b=WRRy/5Et6fJUJ9WcibB5EUFNtV+02YuY+n97E4hNbEQegIxU8vwyiZAeWdUTjm03md
         4ioW3M9feDwLJfasU3V719eiwTx8lVP6dxEXER6igl9vHWWoCHt9/CvM4vef+JGLIl7s
         +D7nicbBvMmDYLVTvz4IlpAPIiEnXNUHwS2DmLkcF5TqZC43QErAxF/5FaeGKaMlwWv0
         RPcQZcKdBhudrhCa2hMv9vUP+6Ee/vr1AakRtwNpBgN8GuyP+hSIlSFvBltLPs4j8nZA
         BC7pOUXGiO0mfhRbG39Qgwk33yccsHjz3fT7ox76Dm+LMcHRKAGa0qA1LQmryP/fG2ef
         iayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725262698; x=1725867498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEJNUtN7GcPC4B29NBJfhJaZCRGwXQGoQMbbCrX/D1o=;
        b=ZsHFiwDbp+cvmSmJv6Pxf89G+roGxFKrHO3D7oyVvXiFOIGHJ9JkVTdatCOhtSXGZO
         ZMTK593iPjdLa8fYi9sQ7OTvMnoZn3dgCZGGSUdKqudcGdKXpYI3hzx78+TQ6c8foLFg
         OgDqE9jgYlO4EE0maIWgGSSnv33Zej4akafGZBgFsGYkeIuj1bj1Ikx46KG8mqyCFnO4
         i9Y24xlWouZWBb/uylrdbbXahOEpQvtnw52HQPA0VIVan9DLgC0YOwjJ7MmQgPQtRSV+
         imBFF0tIVjscexzXtlVzJ7KmkAtqNnzkLvL360SAqPze0EvwrzO9GXtV9OPPJTi7x2Bd
         IuBA==
X-Forwarded-Encrypted: i=1; AJvYcCUHEwSeYPAfMOSAbzvg6MJmFhhBgISq1H81b1+T+KYuD7tGw47T0AS2twSkF1+g4sMBzyuNSToolmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPqnJTI/HsElo+BUg3C8KjM14M7Grpce7qslnziZdeTyAKc7IG
	js84Qc1iNWlfnQRhICOHxJbmBD1bY4AKpROlDELnbz0cWT4558ic8MQ7U5tkKqtZCMFLl9FpSXZ
	NfEvMGvVI7mm5e3qMyJ2CZK7KTvfXKLxTmZs4jA==
X-Google-Smtp-Source: AGHT+IE8LxJ1afSAwx5C9D5PQjgzUX3XGwHYEYKFDcxs4wtkzGPBFg49KkuRHnK41bo9t+wmHpZ/kD5AUiN78RL72xA=
X-Received: by 2002:a05:6512:e99:b0:535:3d08:5844 with SMTP id
 2adb3069b0e04-53546afaee4mr6546170e87.6.1725262697439; Mon, 02 Sep 2024
 00:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823093323.33450-1-brgl@bgdev.pl> <20240823093323.33450-3-brgl@bgdev.pl>
 <20240827085616.v3xzrgyojxd746bv@thinkpad>
In-Reply-To: <20240827085616.v3xzrgyojxd746bv@thinkpad>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 09:38:06 +0200
Message-ID: <CAMRc=MdCfrYdMUTOpFLsGSJY6wa2bzVegq8V=KAePAuFF1TR9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/pwrctl: put the bus rescan on a different thread
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:56=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Aug 23, 2024 at 11:33:23AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > If we trigger the bus rescan from sysfs, we'll try to lock the PCI
>
> I think the first 'we' is user and second 'we' is PCI and pwrctl drivers.=
 If so,
> it should be spelled out to make it clear.
>
> > rescan mutex recursively and deadlock - the platform device will be
> > populated and probed on the same thread that handles the sysfs write.
> >
>
> A little bit rewording could help here:
>
> 'When a user triggers a rescan from sysfs, sysfs code acquires the
> pci_rescan_remove_lock during the start of the rescan. Then if a platform
> device is created, pwrctl driver may get probed to control the power to t=
he
> device and it will also try to acquire the same lock to do the rescan aft=
er
> powering up the device. And this will cause a deadlock.'
>
> > Add a workqueue to the pwrctl code on which we schedule the rescan for
> > controlled PCI devices. While at it: add a new interface for
> > initializing the pwrctl context where we'd now assign the parent device
> > address and initialize the workqueue.
> >
> > Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
> > Reported-by: Konrad Dybcio <konradybcio@kernel.org>
>
> Don't we need 'Closes' link these days? I hope this is reported in ML.
>

Nope, unfortunately on IRC. But the tag is unformally optional it seems.

Bart

> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With above changes,
>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

