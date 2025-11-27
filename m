Return-Path: <linux-pci+bounces-42203-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E15A5C8E937
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD5FF4E7999
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190B2C0271;
	Thu, 27 Nov 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mqi7wt8o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D57A28CF5E
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 13:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251248; cv=none; b=egJXLG9mpPjZzWRT5LebQTfYBpUdASszlvVUEEHMf1dizR5tFxn8s6dUa6CLZ9DA0WiR9O7P3z+a+YZxPo9PEz/Pdm77ZUd+Qe3M82eIm1MJh+rVBjH4NhkxP2KpZZiN4bxbs2ne2X9dm94CJQ+OY6ZpOSEEf/DtUaorxUF5ey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251248; c=relaxed/simple;
	bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IChJOKx1oUMxnzmqjS4zeRcAZFzrqjZz0/KlR7AiS8ksBDX+fRYkvyUKI9E9p2SwFakoEL39tEp8pZKcpxTmXGX4RCXm6CgcY1grbuTXXaC3TjL9muF9AQov2FRM5PyfMM9G6EukKiNkemodRS7oImDGMZCrom9nUs+pAX2/C9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mqi7wt8o; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5943b62c47dso816034e87.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764251243; x=1764856043; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
        b=Mqi7wt8oNrr+2+e4XNhQBFHjbbJlNk2prXtZZdeiWDpubDuSNPjtqVuc6fFI7gQTNW
         vlhDRF8Ikv07ZhquMqzkqlRbUqUBvhhznOF0yf+VzMxYMKnOLOCd6txDRXhkTGnAwFfn
         9q/AFxkcnrl71n9rhoZuu/08jdMh/RFnG0Cl63G8H+FblB9m8ujHai9LfGR+WngJj2Dd
         TjMLWQA1KgMyWpako1U/QHpPDjlp8y4V15h620/0cvt4YsBCRXEygHzP/Lbbhj6NIsYB
         DsZitljR6hDpZnbRH3U5UlgO5Ha0pWvDDCPBmOt/Z+Dos4I7Or/n2AinAFdgzuAfJvVY
         hiLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251243; x=1764856043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27yd/l6012XaQH/g8Ixa+D6cMcVdfn8d9/IVn2JOVCI=;
        b=s5L/DZ12pchSeb8ZnalLDBmKWKGY6+AtoqqllldzTTADJe1hueDE2Y+OO3veTTY4qw
         kt2gg2BYabMr8J/ImXbS5Sp0mk7Dr+VegsJJx4FerIQaA6TiZlVUsFXjgEeVfpQlDPJu
         WTqVexvTRr8uHGUBvRqVMpVI0dc9Nel1CzzHtBsqKwZcXuaKEEQHnNpd/ZvyCp1gfRW+
         NcQ3WzGlBMCEKTCVmrOMeypKZu+v+MH35mxoVrznvrySTDCGU5+dwzDLlQVfVdBxKWD8
         9jim5QPik0z8pAxnsngZG57+CsSBdG2+0Jfm9+hbsNMuEG56/bgOEUZXnIgdyAIb4ZHr
         4s2g==
X-Forwarded-Encrypted: i=1; AJvYcCWj37OhRgBK9ANiF8cWXtx57v3xlDz9J6OpET4ctV9oUWXr+noeFRge/iIowZbpZF/Hv/iAUlv1AXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX0a6nyA6kvW8eMp5bQm5GqghwgKcxrJ7J6W3hT9xIqZZSoVP3
	YSAAyTr1JZxggz/u2vl9fefSshZ57pUj/1mQqZP6SnGyC0SsZobxlv0FoVeyQnfgQAr/1vA0Bpv
	OU+5XgBGDku0z4VoHhYcZsr8A+4T5i6XBUu8kFc+H6g==
X-Gm-Gg: ASbGncvxkjCpGU9xY/5qXCwft50tze8t5j8nEALc76cszPC+VdkAHMM0LmlVB/VWFOK
	AYfm1vfRm85FpQ3qCXLFm4e5h/dkR2KcyOEd2LKX6FWIPt5/tarE0zRFWgJnE/66ZA1utGSiD2a
	dbIFF+pXLz4gw1/fpWJP9J7MCp9g/qb33+fYQ+jVXLfvHc5hk4wfv12M2yG/Ns2ENRXVQadgUgg
	quCSjH8tNEUYa6N2WeyDa9VqeXeA5Np4NVsCBDujcU/kZo0HrIftODntwszFNHxoYd37lUnpkxt
	4Nd5JimucfYUfqBCJoORq6Cnga4=
X-Google-Smtp-Source: AGHT+IHIByvzTN9XhwquV0dZ7CSOzT2wtZW2aRAexw9uGkGjWx9uXnsQQnkc0lHm6G8MnJ63g3o+AbKWIIpqZ/ETI6E=
X-Received: by 2002:a05:6512:2354:b0:594:36b3:d1f9 with SMTP id
 2adb3069b0e04-596a3ec4221mr8118131e87.25.1764251243268; Thu, 27 Nov 2025
 05:47:23 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 08:47:21 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 08:47:21 -0500
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-1-32826de07cc5@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 08:47:21 -0500
X-Gm-Features: AWmQ_blvAAM2uq578ciPVCG4M9rg3fVM1qAGhRvJTTtDZYm9qOnYz1mkG_i5iVY
Message-ID: <CAMRc=Me+mWYaa4ZKTmch-NtuvP-2ifbY1Zwi9E9KMyUgFSt0fA@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] serdev: Convert to_serdev_*() helpers to macros
 and use container_of_const()
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 25 Nov 2025 15:45:05 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If these helpers receive the 'const struct device' pointer, then the cons=
t
> qualifier will get dropped, leading to below warning:
>
> warning: passing argument 1 of =E2=80=98to_serdev_device_driver=E2=80=99 =
discards 'const'
> qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> This is not an issue as of now, but with the future commits adding serdev
> device based driver matching, this warning will get triggered. Hence,
> convert these helpers to macros so that the qualifier get preserved and
> also use container_of_const() as container_of() is deprecated.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

