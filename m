Return-Path: <linux-pci+bounces-44607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84554D193F2
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 15:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD4743065E2B
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 13:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F853921FE;
	Tue, 13 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJssWIJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17A3921EC
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312523; cv=none; b=IiZXxhSVKQOUUXuJ6GGe35Ou8A8umg0TiDh9KeHQ7bOOKZ0hB6xxX86LXWm0E6oVZVpmpEXITRG+SID2ktlqWqScx4fbz0VpDD0ZTzqqXARR5Ntsk9A/ArksA4dcuJLtC5GR0Z6PGGp+As/ZnVv96WRDvkPRcGy0wsB6yvd8Jro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312523; c=relaxed/simple;
	bh=iLREQcr8AOJJPI4nhHRn0wcJb9P6X/HtFceJ0HsrlR4=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AK9ItmrH9EzgvqEVadcRSDuenvAx6rz0+aPjX8RYWPJycR5xlPKxojzCix+bax73vFxWdKkG1FCqFnvrYSr2KCwCmPI6PR8d2fFH7KtNqqdgoq19+T+SHyanpxc0Dae/UzOZovSRvFLiWMHHM5dzUImnD70rf2nH1AAjU7Bb4kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJssWIJm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F877C2BCB4
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768312523;
	bh=iLREQcr8AOJJPI4nhHRn0wcJb9P6X/HtFceJ0HsrlR4=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=kJssWIJm8hOOTtHXHjuSXutfSGpwO/qFtxB8hbqzBNN4KfBCVpMxM73WZI7/0AE21
	 a4FLyzIP1OhG3TIaok74TRVyVER4XlFvSY2LlVpw53Pc0A8DkwF8OnJxbSD18tjp1T
	 wTm8RERdmnKRNriAO5OCY5uAl2IeXcaimvEXAyCfYiP3vSLfr+bc/xT8NowAXrqC5F
	 Jtda5J646/g07xf73M4BOQYqR99CERLpBVTHR2iUSiwF08eDa53P5l0vTQO1z3yoX8
	 1QLYmt3WXUS/PpyPI8B3Ye9h3+l6VKZgzgdMvpQk4nLEXomLVoNgmK30B8LwtVCCnt
	 xedzOdss5Au8w==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59b6c905a46so6128877e87.1
        for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 05:55:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXviVmNVUPYaPRk9FPLjk+7HbgKhEfqFUCZ+uEEAcip0bH7EqdOYWBqhDIqZPWhiZwFrkbnr9rtd18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/HC2TjI8riwtKuioK+rtNbfOsBuTVfHDUnXP8xVNJlbwm9mu
	9GewuN1D9IoBs0Vg6eUCP8VhNlsIK1xoeArRouXCq/33CaPEJbohuTgoT38S3LGw3Zfb7Gvh6MW
	ElkEKugih0nHXZ1aE6x894LROuQPn7IDMV+lR4sBPnA==
X-Google-Smtp-Source: AGHT+IGRISJOek8wwqrOikMc6zjCM3OoG5Ad3poEaIcf/4m/HRBQAVDPnfjTRdIXnHL4HJJiaPyY8v4Vau4dG3HnJz4=
X-Received: by 2002:a05:6512:3da7:b0:594:26cb:fce6 with SMTP id
 2adb3069b0e04-59b6f036acdmr7500109e87.34.1768312522136; Tue, 13 Jan 2026
 05:55:22 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 05:55:21 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 13 Jan 2026 05:55:21 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260112-pci-m2-e-v4-4-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com> <20260112-pci-m2-e-v4-4-eff84d2c6d26@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 05:55:21 -0800
X-Gmail-Original-Message-ID: <CAMRc=MdYkKy006T86_3UvLJeBx+4oyO42i7KLte8tLkba5JpnQ@mail.gmail.com>
X-Gm-Features: AZwV_QiEJpzuYxN-UuI1u4M13WvmWpqn3HjY-V2NE9meWjO7RHFj8hbfkSV_Wi8
Message-ID: <CAMRc=MdYkKy006T86_3UvLJeBx+4oyO42i7KLte8tLkba5JpnQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] dt-bindings: serial: Document the graph port
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 Jan 2026 17:26:03 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> A serial controller could be connected to an external connector like PCIe
> M.2 for controlling the serial interface of the card. Hence, document the
> OF graph port.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/serial.yaml b/Documentation/devicetree/bindings/serial/serial.yaml
> index 6aa9cfae417b..96eb1de8771e 100644
> --- a/Documentation/devicetree/bindings/serial/serial.yaml
> +++ b/Documentation/devicetree/bindings/serial/serial.yaml
> @@ -87,6 +87,9 @@ properties:
>      description:
>        TX FIFO threshold configuration (in bytes).
>
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +
>  patternProperties:
>    "^(bluetooth|bluetooth-gnss|embedded-controller|gnss|gps|mcu|onewire)$":
>      if:
>
> --
> 2.48.1
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

