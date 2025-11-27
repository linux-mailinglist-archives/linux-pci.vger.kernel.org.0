Return-Path: <linux-pci+bounces-42204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE5C8E9BB
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 14:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6195C3A8C23
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D23123EA96;
	Thu, 27 Nov 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="i02WFtvh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EC27FD68
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251302; cv=none; b=LfY39dL5N8UfNQH6L+FD9acLiU/VXYHLdt/Zx4KmU6uCeBQnxq0+wPjnoAIFTOWRETD9m8h4xqlxW7OovRe47feyecqobMK1AzNpghwyinUPQHikbihIVyNQJurWWg9DW1yl5im3YhbrQ0iRYo9ncA+C5U7idtJnkLnimx/EkxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251302; c=relaxed/simple;
	bh=uaVm51pAfA+7BtceViMdoGw/achxdyKv4cZ8WrD61Jg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4a6j6Ii8H0Rz1I6ldOJ3mAtrPE0cJ33fURVb/tCjl5VkIyLvCgrw5wLua3BO0NMRNSne4kPDcicSPnTsCpGJ9VZKMe6N4aLfSLuW+xuI7LjspoCdpKLLRRV04qZzN+l3Le2swhhBw1P0rWvq4z1tnndn0/KLbhrL0Affjw/duQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=i02WFtvh; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-595819064cdso1222367e87.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 05:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764251298; x=1764856098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G07GekTGY4SC2iSrWnFuwKzI1N7AFmcaYb52fmGR7rY=;
        b=i02WFtvhCeLzn92sa9e6xhLxGCy5Sim19nT058tNigw8epvH/gu95hf6cLoCMwaNKY
         IqDKAGXh9dHQ/dGJmuBfIuL3x/3mQmdidgbmfcIKIjLBeAG7tUFDR0YBRsGW0Q1IIWCk
         8BuLjnJel7z1JJH+LbF6Le/w1hwgX1kygRLXlZuPD8EGkDB3tvxTix82fUhYx1k6zGAF
         WYPTVg29Fu6D0wGZWAe3AaCoPL1SrCyRd+L5F+8XRBLDTLLH+h0GNs9EAqP9xQuJU9hr
         2RtSX9K2ugisuqMpl+ZtNhMiLL6v8ebRDa+i7wN7d6DHi3DpAxXVwwbzJUy6U9og1UQx
         LF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251298; x=1764856098;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G07GekTGY4SC2iSrWnFuwKzI1N7AFmcaYb52fmGR7rY=;
        b=tDH8EGzUPjzZjdUbufH3+e1fmpe/kCNi+/uMNaEuHI2XCGhX6OIsn9wfVWZBOFgexd
         jD7oLIkRCdwmoJXOPQAfAAxCK9FkDJxg41Vw27dfJ9O4DwaimtWy4whBqOTxGoZPXtp3
         o02tM52Ku/Ri5gBNV1HMKWe7rZTO5qrNYq/aEqlAGQbQuA4haMX6+genkSbjsWAbak0l
         nJsmg904MuZ37MIJFZamqJCgX+D5H4dCi72Lw3Qh6rcXjA11FJyZb7aVYn+BJXbPA+2g
         q5nFH5xH1rJqlpEV97mWzPNVR8hAtRd5FNmaDX2S/eUm1EWAIm2nhJcvRTdZ/SteiFC6
         8c/g==
X-Forwarded-Encrypted: i=1; AJvYcCXfqavtNjgmtcOVkzxVKzotnjF+csMeXBehE+anepcySZNmSo8FBAWvc3TQl9Ovev/04DI/DMxhcwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKogGgorASXKLGPSA+KXM2ODW3Lt+DR4QauTqCsduQVvJD1oUN
	Sm2q/0QE/0aFQMIvawqyZ6AIg6aJ1Ry5FHhnh0I3YFuLlfhc6vBjztep7nCV1pi5hbP9sq+4zn0
	PuQliuOymtXP+PV1IhPT2z6WpmMZTCezPY1ydHZrV4w==
X-Gm-Gg: ASbGncuqoK7GyrGayOYQYHV1pwnMIX8h838//D07XbvHQyaafFsXz1+9iK5yxrE8H0l
	tIqpBscLX7G/Td1x/3qEOgFO+Nyfw++oyxI2EaYgl/FFf9IFXMsrqsjBbOXV0kShu+LBLo/Og5L
	g8fmJTcNsE7YcrAX1nZI9K90ZJnPYd689BzB7Uav26C3uES3cJxKsWNoWJ+mP90TUnoBVICT2Zp
	Wq7kF9HmVfqxqDtFf1ZH1z9sqYIULdOzkWeQ//vaFZ+Q9DeBFHeHJXsbr/Ps09eCPKGeskNxJ/1
	3UUSzMrrdRcIOmABtuJIo/pJrCo=
X-Google-Smtp-Source: AGHT+IGvFI8L5fGXcjZ+qNvP8EZkHInkEP3SOQcYofhj+ZFeXXcaPdCECdiTD+YtbO/uvB+N8tYFM9k+NWHSnM4EQ3k=
X-Received: by 2002:a05:6512:6d3:b0:594:37bc:f40c with SMTP id
 2adb3069b0e04-596a3749dfcmr8511591e87.10.1764251297792; Thu, 27 Nov 2025
 05:48:17 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 05:48:16 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 05:48:16 -0800
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251125-pci-m2-e-v2-7-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-7-32826de07cc5@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 05:48:16 -0800
X-Gm-Features: AWmQ_bk0-XCJTQ6PapzzNjyRg3LPIzKuWTKtDYqS86NfBbxq1eZ_R5ABgi6vUTk
Message-ID: <CAMRc=Mck-Vx6SSDSp4+jFWeobQ3fzf9P=zJa_bQoEe6T6R_VHQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] serdev: Do not return -ENODEV from
 of_serdev_register_devices() if external connector is used
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 15:45:11 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> If an external connector like M.2 is connected to the serdev controller
> in DT, then the serdev devices may be created dynamically by the connector
> driver. So do not return -ENODEV from of_serdev_register_devices() if the
> static nodes are not found and the graph node is used.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/tty/serdev/core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 8c2a40a537d9..fba7b98026bb 100644
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
> @@ -581,7 +582,13 @@ static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  		} else
>  			found = true;
>  	}
> -	if (!found)
> +
> +	/*
> +	 * When the serdev controller is connected to an external connector like
> +	 * M.2 in DT, then the serdev devices may be created dynamically by the
> +	 * connector driver.
> +	 */
> +	if (!found && !of_graph_is_present(ctrl->dev.of_node))
>  		return -ENODEV;
>
>  	return 0;
>
> --
> 2.48.1
>
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

