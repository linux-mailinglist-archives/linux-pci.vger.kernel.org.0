Return-Path: <linux-pci+bounces-5624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D62897323
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 16:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7260C1C26C38
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 14:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93AA1494DF;
	Wed,  3 Apr 2024 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aKnImIsP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19B91494CB
	for <linux-pci@vger.kernel.org>; Wed,  3 Apr 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712156175; cv=none; b=qicDVG1y0qG2x+pTr3Ip6kkGqzAzfxg4QzEPA/LrphiFq1RLcaKTA/6+ZbvsG+Oq35BIrhPDlA3EmpDD4LNLI2mF7VifOQsgS8lxGfsKyNXElDMwnDQ2nZPjOQTqqoi1BGc3cntLxXXPWc8XQzjvWApUVbM200aPk3s148NL6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712156175; c=relaxed/simple;
	bh=qIMp/Bi43gG5OxVpu00ce21O5fSpFFXCTZkgJC0kaJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/e9igxKp1MV7GMwsRzeKIkEm6Xaki3rari/H7hABq/te6Jbi3bxNuWuPLFZ6Hf+Vh7YLyVIA+p/vyhA0nmChMgQvcKfzRkQjexqse0tnmX98IE+NWDvRzWg5vyELXsYd2yxM/gfapXq8Kc/7RDyrzZCIAVOLmU4AGy4dHUNQMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aKnImIsP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e134f73aso8523196e87.2
        for <linux-pci@vger.kernel.org>; Wed, 03 Apr 2024 07:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1712156172; x=1712760972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AEDPySL2e/8A7unRrzw52gMZQYQQOXlB4w/mt06n1w=;
        b=aKnImIsP8DZAEOQspUmW8LWc/9dXAMfFVzUOfjLRQsExSm+YC8ycRjE9jQg1o6dCoh
         5iCfqS8uDMWH8uO6lMAz2bXbEK1O0D1nYOBbq3XqtW79q/Cc7cVCG/R+muXrspBOhUUm
         wadCcstUMIMt3R/oSq96Xl2cpKgJiSVRjicPLlU31sGKvbVAKvjSD7hEZhM0KUek9PDj
         D9ZxTZrrn2A9yTFvjpckb3yAeEfUcfL7ftrnJfDZXwe2Sxq44SAu4rCtOAIHV/88Fhxr
         lrLYKerwj6Ig9SZ5Ouak9rn5oo6VaMzJgxH0mXFJBHIYX3GIlS7S/g+p7/JVK98F7huP
         C6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712156172; x=1712760972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AEDPySL2e/8A7unRrzw52gMZQYQQOXlB4w/mt06n1w=;
        b=cEJXlI6EJEGkpcSyGnDcPD8qiN4pb3BFZkUfcWfzdI9GZMRowp3rRfb+ahr1aKfHzE
         RYy8qR4m9Z04yNTmvWliKitt8lH+jJ6Oz+DJcQOo0IxmJult2aT8JvxJdMVBsohhK4wM
         1kVW2LaLX/0CUCnu9D+hK1Tye9R5AXgwDWYTqtjGFZGvDLJx/tNR2PG5mTBRDIuoOqh1
         1Sutx+LjqWV1ST5TSC2y/8UWz7Avw8m3dMaSui6X8WoqOqYBjd7t8vaoG6Mp7lY7xQMv
         IDExSZ08e12XFK9pLnUm19ilmKKGm4Y37Im5oW/nglKf26Sma+aBwr2SGT1VIDdEMVkA
         nzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSzGrdy6WM/Cw+r6p1KgzY2C92uHg6GVmSDIV7QT/gzagqteyqhSS0zULWXgXs8VfoFt5YMn1Knwg8q8kMfRRigNWQxlywNSJN
X-Gm-Message-State: AOJu0YwU0rYRD7pCXdBDnHaGOO9wquMQolAiIw0ioVpFAFiRH+FVSLUS
	op4BBLfveWEMb78Z/t4IfBttlRkSvnhNTGgRMIHIGO76fdHtSKVDakkbjSMyYQcfQklXJRrnRT5
	EF1yUGqAwnrM/uXB2M89r/fapOymgwusr6fyLwQ==
X-Google-Smtp-Source: AGHT+IH1uAqfWGiUk+RIbBgdGkD1xZiuVe0WG6sH6tI1B254BJw9nsHUMXBNKMkZlc7467jz/bVPfZDn3fzBPSidFbA=
X-Received: by 2002:a05:6512:36d2:b0:515:c17e:ddb1 with SMTP id
 e18-20020a05651236d200b00515c17eddb1mr11741487lfs.50.1712156171964; Wed, 03
 Apr 2024 07:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325131624.26023-1-brgl@bgdev.pl> <20240325131624.26023-6-brgl@bgdev.pl>
 <87msqm8l6q.fsf@kernel.org>
In-Reply-To: <87msqm8l6q.fsf@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Apr 2024 16:56:01 +0200
Message-ID: <CAMRc=MeCjNn7QdDrcQMuj32JFYoemQ6A8WOYcwKJo1YhDTfY+Q@mail.gmail.com>
Subject: Re: [PATCH v6 05/16] dt-bindings: net: wireless: describe the ath12k
 PCI module
To: Kalle Valo <kvalo@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Saravana Kannan <saravanak@google.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:01=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
>
> Bartosz Golaszewski <brgl@bgdev.pl> writes:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > +
> > +maintainers:
> > +  - Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> IMHO it would be better to have just driver maintainers listed here.
>

Why? What's wrong with having the author of the bindings in the Cc list?

> > +required:
> > +  - compatible
> > +  - reg
> > +  - vddaon-supply
> > +  - vddwlcx-supply
> > +  - vddwlmx-supply
> > +  - vddrfacmn-supply
> > +  - vddrfa0p8-supply
> > +  - vddrfa1p2-supply
> > +  - vddrfa1p8-supply
> > +  - vddpcie0p9-supply
> > +  - vddpcie1p8-supply
>
> Same comment here as in patch 4. There are also ath12k PCI devices which
> don't need DT at all. I don't know if that should be reflected in the
> bindings doc but I want to point out this.
>

But DT bindings don't apply to devices that don't have DT nodes. This
isn't an issue at all.

Bart

