Return-Path: <linux-pci+bounces-2965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4C4846364
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 23:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6961F24D1E
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABFB3FE4C;
	Thu,  1 Feb 2024 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xxpg1ylp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509083FE24;
	Thu,  1 Feb 2024 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826319; cv=none; b=nQ8rvRE08UL9uWmMkI7E9zaiXr+OoqV68yROFihFaUIi4WhGudKpXcHLje5j1u4lJDhsG4XjQ04e4ygmpa1aB6D9Li/gOlKw0kd6g7MpCioWvShj1V/4RMXn/7KUus3CeYc/O497oNVJhi8rW7NbZxSa2vjSU/9jUZZK777b6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826319; c=relaxed/simple;
	bh=Hj4d6tN880SUXjND3akJlhPUopmSpfbUPijmcRAWHYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=soJ0Jz8T2BwJRtF8P6HKOaeReYXE4XrmnoBtl30zxeJYdHX+z9AR53NMY80DBAq2X2QLODcM0cf/9Nqp/hN3dD0WwTQTCisq3P1RO1uyFqY7FC9yOsVLTYrMx2lTOhq6FN8OUI7WxnUlPK1qom55weM/46fnNsK0i2Bryl2OEYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xxpg1ylp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A150FC433F1;
	Thu,  1 Feb 2024 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706826318;
	bh=Hj4d6tN880SUXjND3akJlhPUopmSpfbUPijmcRAWHYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Xxpg1ylppvjDGiJJEtcytqf1u4ejPPuK5J07pbr3BADGVTo/qTSyRQZcN5kJwQoHj
	 1B6JRsIR2+4dbuvaw//cRSwMIg/pmizdahVxp5I4twMy/hVBPvVyJdJvHwD9vyv+5/
	 SuAnGViWMHubN1I1cB6nqJOaD+Y/Su2BhyyMBKSxod0Kfr9jmzGE8DL20g32vXh/Ul
	 IDAWKX+cJ+n8hX+b38tPR+t4zXXlmNNsRHIBXnd0KFc6xQv2EwYGYhAIpNEv1oRZ7K
	 h4A3PAfdTjsK9r2TM7FFqNgdiubue8JZmUihY0wrSf7ziXh9cjeIas8+oRjkrhwmWs
	 pLEABPoFrUacg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-510322d5363so2289940e87.1;
        Thu, 01 Feb 2024 14:25:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyRyamhkZjXYwBfckJuvlRuMMyMd48H0MoKmMVbmiqmDhgNyuuy
	SqhVehVmKhYIdon/jPrcPXGz9PY8biIleTS+MQu36Ied3S5noDnEi9Mur6RuEkd5QivC9gmsZLr
	TRs5VS1pu25FtqlLIFrlfxUhCew==
X-Google-Smtp-Source: AGHT+IGC041DLcAtPTvGVodFo3zQTW46kSgTDcCXUZXpug1NyyDWiMZCMKTeZC7ZZ9y013U1fjsI3yyBvKhZeLZD3M4=
X-Received: by 2002:a05:6512:25e:b0:511:33ca:ac47 with SMTP id
 b30-20020a056512025e00b0051133caac47mr533077lfo.9.1706826316861; Thu, 01 Feb
 2024 14:25:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-4-brgl@bgdev.pl>
In-Reply-To: <20240201155532.49707-4-brgl@bgdev.pl>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Feb 2024 16:25:04 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6E9aBd4QMOJ62HuRSiR8BMtrS3tBUDBhPcb1iCGeyfQ@mail.gmail.com>
Message-ID: <CAL_JsqJ6E9aBd4QMOJ62HuRSiR8BMtrS3tBUDBhPcb1iCGeyfQ@mail.gmail.com>
Subject: Re: [RFC 3/9] power: sequencing: new subsystem
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 9:55=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Implement the power sequencing subsystem allowing devices to share
> complex powering-up and down procedures. It's split into the consumer
> and provider parts but does not implement any new DT bindings so that
> the actual power sequencing is never revealed in the DT representation.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

> +++ b/drivers/power/sequencing/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only


> diff --git a/drivers/power/sequencing/Makefile b/drivers/power/sequencing=
/Makefile
> new file mode 100644
> index 000000000000..dcdf8c0c159e
> --- /dev/null
> +++ b/drivers/power/sequencing/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0

GPL-2.0-only to be consistent.

> +
> +obj-$(CONFIG_POWER_SEQUENCING)         +=3D pwrseq-core.o
> +pwrseq-core-y                          :=3D core.o
> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> new file mode 100644
> index 000000000000..f035caed0e4e
> --- /dev/null
> +++ b/drivers/power/sequencing/core.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Why the deviation from the kernel's default license?

Rob

