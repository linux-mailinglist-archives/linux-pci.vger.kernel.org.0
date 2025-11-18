Return-Path: <linux-pci+bounces-41501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7DC69865
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 14:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id CA39E2B500
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 13:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07051309F1D;
	Tue, 18 Nov 2025 13:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSfEQeAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BE23090CF
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763471048; cv=none; b=ieYFKDrjFhMMIBDOL26Vr0ajK3XUxqohEW2qusqFBxRcKaOky8C7LbBmKWc9FO5JohBOCYC/GH2+zWcSDXuyYmF3F1EYQ8vaFLwhre+CRTbuFFDHH1xF7UM6FaeohDlqpYf90DKQN/a4rQMNhi20NCv4Q8qBg7eQOSFdfsVP6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763471048; c=relaxed/simple;
	bh=QY1OIrfV7wJNhoLm6jftQrdDzbys+UOJ7sTIBabxKQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yc6ayQPAy/wNhyFNtFWvW9myCbTDCghtH/A8NfhHnvg9WvcxpAqE3pehzMrH8bBqcZq9MRWjwZRgZXU/a2NsYqUCH0xnAJnzXwdG49mgzw8RnKGMFbVNoIXqi2fJk/kn7YUk2oCdUHm9c2W8pagJ3reS4EiRBfHSRD9xIWZm/NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSfEQeAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57ACEC4CEFB
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763471048;
	bh=QY1OIrfV7wJNhoLm6jftQrdDzbys+UOJ7sTIBabxKQU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BSfEQeABbwnLjR4Vdrpji2a0ltLUBfFx8Ci/+czx+NTxX11c4PvRHAuWY1gfGbXYV
	 lU0apMgZ71ZfpXPERdNXc8jyS0NkgG5SOVVd8IvuJbzrajPwvsRVbOXt6bvUgqSx+8
	 BItroIpA7lumTKBlytgaBEaXRkNV/Qe6hiRHYd3kKn3frl2xCNy6xGhVO+ofRnXFG+
	 MB7Ds3Z2l02mFQKMPEC5gKHASaT047gylPDlPf7sH/dhQCTG3/RRUGK7xprpTgnIr9
	 18zlOxNeSED1Qekqgers87b1DeXt2kpSicXUUSMCNJSyIiTdAa8nQT2JaxmFj/VRfM
	 /14tF7RRPRjVg==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso8761230a12.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 05:04:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd5q6pXDDdo2iynDPEuCZE0RCKCoIa/mGSTwjpj9fyVCBx9KloB80osGXsf/mIYSPZZnyFyoYYkBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKGhxBwz40JkwX344smo12x5TJVGPTxYASVYN7/GSyA9aTaLx
	QoyXVkAdaTDQRIxHKaLPA85bE//3EJ4Ncz5G9BsDXAxe9b0u5Hf47PSN09VDVl26SF6n0dZTbBQ
	7vm0Z0DD1NJGsgOQcXGSMh5IBxmn+mw==
X-Google-Smtp-Source: AGHT+IGzaPWs9CO2/QqJ2lcK3lJrPrwRYsH8Qm8HjBS/YlxbWZYRORJiSB2uoxSx80hvbGBnIei2bDGhcwM4UJKc8fE=
X-Received: by 2002:a05:6402:2809:b0:63c:2d72:56e3 with SMTP id
 4fb4d7f45d1cf-64350e8e003mr14781379a12.23.1763471043426; Tue, 18 Nov 2025
 05:04:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com> <20251112-pci-m2-e-v1-6-97413d6bf824@oss.qualcomm.com>
In-Reply-To: <20251112-pci-m2-e-v1-6-97413d6bf824@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 18 Nov 2025 07:03:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBcXH0EWguto3EFY2cJ5p=8VUZczMHz1u5fNFocv-AmA@mail.gmail.com>
X-Gm-Features: AWmQ_blGP-_XDvdtj3MDVFdTuQEWnKJrtZXKQUPHlGxcSMsdX4Hk0jJFpfTnlMY
Message-ID: <CAL_JsqKBcXH0EWguto3EFY2cJ5p=8VUZczMHz1u5fNFocv-AmA@mail.gmail.com>
Subject: Re: [PATCH 6/9] serdev: Skip registering serdev devices from DT is
 external connector is used
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 8:45=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If an external connector like M.2 is connected to the serdev controller
> in DT, then the serdev devices will be created dynamically by the connect=
or
> driver. So skip registering devices from DT node as there will be no
> statically defined devices.

You could still have statically defined devices. You are just choosing
to probe them later from the connector driver.

>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>
> ---
>  drivers/tty/serdev/core.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 8c2a40a537d93f4b9353a2f128cdf51b521929b1..1378587d386356ca4415fa455=
b2ee722b5e44d3e 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -12,6 +12,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_graph.h>
>  #include <linux/of_device.h>
>  #include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
> @@ -560,6 +561,15 @@ static int of_serdev_register_devices(struct serdev_=
controller *ctrl)
>         int err;
>         bool found =3D false;
>
> +       /*
> +        * When the serdev controller is connected to an external connect=
or like
> +        * M.2 in DT, then the serdev devices will be created dynamically=
 by the
> +        * connector driver. So skip looking for devices in DT node as th=
ere will
> +        * be no statically defined devices.
> +        */
> +       if (of_graph_is_present(ctrl->dev.of_node))
> +               return 0;

Where's the schema that allows graph nodes?

Rob

