Return-Path: <linux-pci+bounces-34479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7951B30080
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 18:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87203B819C
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 16:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F30A2E542F;
	Thu, 21 Aug 2025 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXAUBzTt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16C2E540B
	for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 16:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794897; cv=none; b=d7hsU83b/tB4mUyoM/Hpbtt0j3QXdTm786/ehrR43T+hlGfXLRtBqRDYIFZ/sz/we+5HLXfUpb3d6BGy2AicDWHLa2Je4m9EWsLvaUvHCDuOQs/7PmkjlWfLfFYZvEMh49MpARP0aUlW7nLF0JyKuMEkHH58DGg7vD+AKA2VeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794897; c=relaxed/simple;
	bh=JjgaMxWJ9qbUm0986PYJxcTgcZRuZyftO3FNY5Np63E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EXaIOKQThjaENggMoVUffx/J/K4E3c5QqTMYH1T4drlFj0PbiOnMPV/+mwpLJzZk7nNcIRMxDRZoJMTQiqlzesHP/hnmu+jpegijfoUOoR6hxi3D03qRkHY9f3JqLT+UWjKd2PlxwLu3Ju+DT0UuZY3WVqBJRjJI36Ody8sfr8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qXAUBzTt; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-333f8f9ace5so10015781fa.1
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2025 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755794893; x=1756399693; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjgaMxWJ9qbUm0986PYJxcTgcZRuZyftO3FNY5Np63E=;
        b=qXAUBzTty/1Y3VZQ8f+s0JBk9dZnF84hMLcKWS/ta/DGSYHXwPzAmzuyr5RURVS8jU
         NS/QUOLBZ+KmovR5FA3YWhXrlHzZIibRR/gMASYqtQVHsU6i+hDGSg6/mdkKreBI7lfs
         DC9tSc7b+xW0IRt5K9AWLwn61MDhIa5UOER8wTPwNd1+kD5d/1Jkmh/p9hopa4iUoBXM
         6G3sYULdSj0obmTvVkafQRDQMmHZKREJSZv3Y4J+lRLyRmyB6Vf5JlJvoTlaLgHORI+E
         so5LdAFQkTevhccS6NnikkMCawP50VIq5aJCGE0bY7lhqC0PWRd9nqXXUOKazATDY8SG
         Mpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755794893; x=1756399693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjgaMxWJ9qbUm0986PYJxcTgcZRuZyftO3FNY5Np63E=;
        b=ocUmcQND1JMr1Ck2TSrC8UlCqNz1/oAMCYrk36XG7Sf+Nnh2HhM+PmNoQ504FxGSpZ
         Y9s0T2ATv4LTCrlokPoxkuCgP3AcGAufMSJpBzG/qGPgtWKMonWAcTBV4iSPbH0pWIX2
         bfhEHpxVmG2uM1f4IBkCf5Ll777ECbBaaWAzqPqUF8P0YaSuguLtpZb5icxAtt6Sv4Kz
         X0/uZW1gpc7A5z3rlDRX8Pf/VAwpGnk5W4xj4RpznuVBQIj2wzs/gf0Ixx2W8WRxB0wt
         NIdRD6JX3Pqhw/3nDRIy4bsWLj7GhsUiU7hsOkvOVJkms0RuBAhaSOYAVFn3yyDU4eKz
         QXCw==
X-Forwarded-Encrypted: i=1; AJvYcCUjp6ZewJCmzbKN4fDCBA/QKKTaMa9sQ68VyJHY+qvuXc83b5MejH3zLeWnnV196JzaYRVORbZf+a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA3ouKY4ICuO0/h+F7ry/XoT6AKw/euA1EqdE/9qpFk7KshC6Y
	VTwJJ+9FOc8CkfkIiD9tdYvf9yFCkTZN1mYLuoblLy2LkddElsTM628DZRxk0rG0BJN22k8tMyQ
	CI2gxlwXuSQ7bdS+CxxDvYJnVcYlGZsyF4TOGBIXVXg==
X-Gm-Gg: ASbGncs+QplN0bN1DO3FRNlvXsoIZ2ETmBzaxkVauRariJum9in7SxutiJHRmRsPcP3
	zQhxhpZ/oviIv15wUR1L+LnjYPoG3vmE9aif0r8Als8uAUt7/wNJksAdlJAhHNKYaZEL1KQOqlo
	mc2bcdaprsyvejmG+XgIGBu+ShLbRPDv5ZJQ3fyQj0FGpJ/4aO8EUheKcst95YTfaLWP3BC5qqB
	E2oDp4=
X-Google-Smtp-Source: AGHT+IG+3TRj8voJKTnwJVWxrL5l1oYpH/bU0LUo3gd5FaJMEzvePfb3DMbpBjz0hjYrM3LeuxGGpWK2HuDJsMGa8c4=
X-Received: by 2002:a2e:b88b:0:b0:333:fa8c:9aae with SMTP id
 38308e7fff4ca-33549eb715emr9619641fa.18.1755794892780; Thu, 21 Aug 2025
 09:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821101902.626329-1-marcos@orca.pet> <20250821101902.626329-3-marcos@orca.pet>
In-Reply-To: <20250821101902.626329-3-marcos@orca.pet>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 21 Aug 2025 18:48:01 +0200
X-Gm-Features: Ac12FXyF_gVal52SyMhu7-iG4ESsRyyY1LZkPXX1dXgmWEJaBoPIOjMINHQJZMY
Message-ID: <CACRpkdbego5WMzPV=xixkfM1gfKoULxXLgfDiEXpz2dQUgw5ZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] gpio: vortex: add new GPIO device driver
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Michael Walle <mwalle@kernel.org>, Lee Jones <lee@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 12:19=E2=80=AFPM Marcos Del Sol Vives <marcos@orca.=
pet> wrote:

> Add a new simple GPIO device driver for Vortex86 lines of SoCs,
> implemented according to their programming reference manual [1].
>
> This is required for detecting the status of the poweroff button and
> performing the poweroff sequence on ICOP eBox computers.
>
> IRQs are not implemented, as they are only available for ports 0 and 1,
> none which are accessible on my test machine (an EBOX-3352-GLW).
>
> [1]:
> http://www.dmp.com.tw/tech/DMP_Vortex86_Series_Software_Programming_Refer=
ence_091216.pdf
>
> Signed-off-by: Marcos Del Sol Vives <marcos@orca.pet>

Wow this driver got really compact with gpio regmap!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

