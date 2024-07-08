Return-Path: <linux-pci+bounces-9906-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E335929C86
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 08:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCAF51C212CF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 06:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF45182AE;
	Mon,  8 Jul 2024 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ss7ef+kK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A0200DB
	for <linux-pci@vger.kernel.org>; Mon,  8 Jul 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421554; cv=none; b=nzXDpzIHT5Va2C2Rcf+iAdNafGn6RJ1sFPN5dL8N3wdxPZwbNAEGmxY5halRC8lVS6u21+Bd9lFWyMtiYtMhQm1wKHUutwdiwe5dKtoTkjpNuSWsmeRGFOyUTJVHABy8B4LicW3G/8dEuf/o1PPQrWzLye2fOT+P6kSvHXNhksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421554; c=relaxed/simple;
	bh=zRhlyuXhTQjaOFUBRx80GzQFpflKwVW3Y87pwAN2x3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/HvY6NK/OQN0rPolVfXUs2HR0d7rg7eOqM+tv96FCeaRO9LXePdQGmIAt9+5buUkqqlInVH3or9IBIs8NpWmFpD3ZcwJ0+Zalo7NJGVUaWLVlthCTpbNaClDIwI2tzeD66xZY5gKvYAlPWlesnrX1cBJQYBSOQshy0DhKvzgUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ss7ef+kK; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e03a8955ae3so3433143276.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Jul 2024 23:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720421551; x=1721026351; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rOg2mJdaYN11tN/PM3G1aLLpFsk8ehaLevbZnEx35NM=;
        b=ss7ef+kKW1dghDs05dKvIR3bZGP7tTxOSy1X+Bwv4JRIFVp1tCqAJvQSz2QK8O8Xm3
         MQRUv0BVExaeQkL7kH0HMTty7Jg6OJYG49fxSOjxM/FbUhgPRkfpYImb8AOTNk7AHAPo
         D8vUnTfobWqvQegK6RU4R6oa3J51zMCSUhs40IGpzjWbl6wo229+9ltIozDySnJPo0Cr
         PtKUKNdOBdp3ZKuH0+Go/BGFboG32JyuMourOyuLzvMUujOtT6tVdRGtO80C3+aCa5Ta
         WtpkGodObblgL1oC7yyN9IXsUFul9n0o6RLW0U/8oDXEB79Vz11XqLbOMDG4LRdcE4vr
         VD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421551; x=1721026351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rOg2mJdaYN11tN/PM3G1aLLpFsk8ehaLevbZnEx35NM=;
        b=UPUQigwIv9n76PTmXjCopJURLlKc6wZczm8XJagRxQTm56yOJVV6tLJ1OsMMbXLFrn
         L9zM11s0JjDsbfI8jbFXQO4Ixleep34IwiiSZ/kW7PaMBCgvR1EJOQMJkJXru5qMnW7R
         AnQVmVEHenW8YrgL3pQDXFMfSRopKnwP+XuindH7HS+HGEItBRLjnUKxPEATEVAEul2U
         GW/Q+CMEP5vDLCb6QBAGwpckJC26BOsJjOBXMkddYR/Gaf8wcYmVKUkdSqchryftprPX
         eXvde91PtB/0u5EYGjXUOxFkx7r9agQLBg+f5EeDr+URqpNYE6T7hDd74ufl9D9tIo+7
         42tA==
X-Forwarded-Encrypted: i=1; AJvYcCU4Kmcy+TP0wT9NysnRNp70ma3wgwTh/uvSJRm9qFmhsg8B6qebQETC3Y/J/ngUZhbH9XL6w1KjclCNIrDiGZKmATF946+tstSu
X-Gm-Message-State: AOJu0YzZikPQlJr0q02V4H7p87ltrKdshtddbG9kNp5LlQBiJFogTztP
	1dUvchmMUaaN0rvSBixtdtMBcgoOz2ozkNbeVO6NZKQ6URzUBmCbjC4uz8i9QY/5GWARrLgGw/8
	vB9A9HJ5/MRB0RKm4w0zVAsC62GuLtkgL0S0Xjg==
X-Google-Smtp-Source: AGHT+IGsjN2ISvHbQJ0hEWcsn2gnbHHG74Niwgiq79T+e158g02IMIphzJrwCDT8Hh+wIKqGqtAOcVpq23jRxFShnUg=
X-Received: by 2002:a05:690c:f03:b0:64a:7379:eb53 with SMTP id
 00721157ae682-652d853536dmr142990527b3.43.1720421551421; Sun, 07 Jul 2024
 23:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240707183829.41519-1-spasswolf@web.de> <Zoriz1XDMiGX_Gr5@wunner.de>
 <20240708003730.GA586698@rocinante>
In-Reply-To: <20240708003730.GA586698@rocinante>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 8 Jul 2024 08:52:20 +0200
Message-ID: <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>, caleb.connolly@linaro.org, 
	bhelgaas@google.com, amit.pundir@linaro.org, neil.armstrong@linaro.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Praveenkumar Patil <PraveenKumar.Patil@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024 at 02:37, Krzysztof Wilczy=C5=84ski <kw@linux.com> wrote=
:
>
> Hello,
>
> > > If of_platform_populate() is called when CONFIG_OF is not defined thi=
s
> > > leads to spurious error messages of the following type:
> > >  pci 0000:00:01.1: failed to populate child OF nodes (-19)
> > >  pci 0000:00:02.1: failed to populate child OF nodes (-19)
> > >
> > > Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child O=
F nodes of the port node")
> > >
> > > Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> >
> > Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
> > Closes: https://lore.kernel.org/all/20240702173255.39932-1-superm1@kern=
el.org/
> > Reviewed-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
>
> If there aren't any objections, I will take this via the PCI tree, and ad=
d
> the missing tags.  So, no need to send a new version of this patch.
>
> Thank you for the work here!  Appreciated.
>
>         Krzysztof

I don't think you can take it via the PCI tree as it depends on the
changes that went via the new pwrseq tree (with Bjorn's blessing).
Please leave your Ack here and I will take it with the other PCI
pwrctl changes.

After the upcoming merge window we should go back to normal.

Bart

