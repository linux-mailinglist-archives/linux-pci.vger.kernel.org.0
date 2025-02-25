Return-Path: <linux-pci+bounces-22388-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A8AA44EC2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 22:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A843A3F5A
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 21:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 907FD20E31E;
	Tue, 25 Feb 2025 21:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DMDrhvL5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81491A9B46
	for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740518715; cv=none; b=qfFMitAslTvX4VSasHV/5FyQ9BBdPQTA4PPOA+164Dc5xbLKq33g8A3JR2+ZqnnbvLtEawm1CrolNG0KWkIA9SiCCKT9wG9S51J6e/4sqhAjtaOhw1e628f+YtRi7iTD4oI7BZZjOLQXszIWkLdGF44hsY61a1pCarM5wtdoqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740518715; c=relaxed/simple;
	bh=/vRSuHy/MB9RlaMV0AzRys+6Fkmzrnt3K/gEdJxjiII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JFWLPKoyzqbHalvJBLtMa6ZP9ybX/NnDGnts+X1DDx0MtWGhH2mhnADP/YX/jfkzsnzB+BCYxTokrkvmiBAACoja3f6I+8/DYbH04x0hUk4f+FQRN8hjuyBMCTUOa1w0RITUWO/na4nls8beHTyoDXAHSEkXyaCbV1nAmF/rv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DMDrhvL5; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5452efeb87aso6107051e87.3
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2025 13:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740518712; x=1741123512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vRSuHy/MB9RlaMV0AzRys+6Fkmzrnt3K/gEdJxjiII=;
        b=DMDrhvL5DQeEdUzS/WqjMdIJeBSmpmgNROXnxrutW2/u+Y8+Uc3WZ+hx+RRi9AyJY5
         3kFKsgqrPEEuXXdHs8aSCdI+JZqSJryYdStzncj4N8wNON1RuEnMrgS6i12ufeNpqbU6
         aZ57Jkz5OIPErLkWSWxSLh53aj5FJhv2gIOUfevqWRJ2L+Fa4WxYWgYFajSGT7Pm5quj
         nKro6inJQE34uPd0TuBlDjSDol6r5F2Iqqpa7mO4Xfb233M2nW5WJqSfV3+1foSkwcJg
         1VqtDrPWgx94yshWDnZTqRsJ+q4uIE7autBJQqNFUx5yK2MHOP9FljiP73vDtj5vTzPw
         VK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740518712; x=1741123512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vRSuHy/MB9RlaMV0AzRys+6Fkmzrnt3K/gEdJxjiII=;
        b=qgIbdplucD1A/HVn9F6GI8QYeSIV7FNkqVeE6SZfdt4hZFXASMiRF1iZS2LnDaTauZ
         RlUflokN9Os8wpQ1FpNoMsgyJqUgjWtHIuC5dKb2/L3R39EznYrYalV+YG88UrIVuDy0
         ZXPbCygGH8HFrKRi+odYIbCOeylMrYuJ2MoPTB8LANJtyL80wgb0mmR9aWgj3XQGybP8
         vyINnsMWgs0E+Ag49G7D3odle0dAkaPbx925h74KItP290nPU/GNASG48bjREBLPCq/n
         89m57YLj2Q2XjRXCBD/aEV486zdnWikt2HenGVY2QrErCTZF4SoqdRrCAMI5fHLtHiCP
         NIjg==
X-Forwarded-Encrypted: i=1; AJvYcCXCmgiUV/MMyJXSA6cS/0GPYUabEZ9rn77R4AkPIrMAUbM1VFCq6m18INu2IJ1DREfOHVwrRdPrcJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd8De+fUD6XDROQG5agm15/nIMpvrbYxly73MzrhTJD4NOL0U9
	cYAMmn8TJ/VCp4h3pyTVVSNXZwZOKvm7tcKYwCD8P5BtfmLmNZn1GPShBTRfL4G/E2DcUaLDBHZ
	fet/xbWfIe8RpgbbB+4egaHXw7kXziOqXVn5Q/CLFiQjr7RZ8
X-Gm-Gg: ASbGncsWOSdjm9WfuLc6Axs37gum3L8gjGQ5tQKNTchvbj5DugtASpBrfsZMXPW+hFA
	PIWf9Op3XdjdBt0ut3YW8sLXv5BSXuKX2xk3nkT160J4+X/W7vpe09hw1RRLhRR14SuV8O+YE/F
	aXlYZ9TLs=
X-Google-Smtp-Source: AGHT+IF3ruZ628pBl6inkD8sS/QNk1YiGKVIu9y3PQfjbqSfBuCZZhhr7tnwuzfKq3rBfnyExymhHSh/RSe22mil/wk=
X-Received: by 2002:a05:6512:3e17:b0:545:5d:a5cd with SMTP id
 2adb3069b0e04-5493c570908mr788055e87.6.1740518711634; Tue, 25 Feb 2025
 13:25:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de> <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de> <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
In-Reply-To: <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 22:25:00 +0100
X-Gm-Features: AWEUYZnAhHxOSjeQsA9Hvi6qL2kbj-epkwY6Lo47qumj0GmjgfH9AG5WnY1exP8
Message-ID: <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
Subject: Re: Linux logs new warning `gpio gpiochip0: gpiochip_add_data_with_key:
 get_direction failed: -22`
To: brgl@bgdev.pl, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:51=E2=80=AFAM <brgl@bgdev.pl> wrote:

> In any case: Linus: what should be our policy here? There are some pinctr=
l
> drivers which return EINVAL if the pin in question is not in GPIO mode. I=
 don't
> think this is an error. Returning errors should be reserved for read fail=
ures
> and so on. Are you fine with changing the logic here to explicitly defaul=
t to
> INPUT as until recently all errors would be interpreted as such anyway?

Oh hm I guess. There was no defined semantic until now anyway. Maybe
Andy has something to say about it though, it's very much his pin controlle=
r.

Yours,
Linus Walleij

