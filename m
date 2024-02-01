Return-Path: <linux-pci+bounces-2963-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A2D3846356
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 23:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1B1EB23A76
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C3F13FB2E;
	Thu,  1 Feb 2024 22:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PSjkloBh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480A3D3BC;
	Thu,  1 Feb 2024 22:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825919; cv=none; b=JtBJV/njwMR565kVgNCmdq0EFquM3kcB2zjmegnByIMpzxUU6F73FC3tIRqZ6Ogpaoh2QAe6EhqvXP3022mz6Iss6QoQfq55xbd5PxNdyPYKlZi1DZWJVGzfDK6FIKufzwJ0GSwAR5oHeB/AtTzS3JHzFuK7yk3y4T8RVXEpnPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825919; c=relaxed/simple;
	bh=Z9TgWie7YtgminwtE1RQnQvs7QaguyVm5XFk23DKB/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHaC5cdRknts0gOP9h9c+pM0SVeFJQlWqRtvhs5+xpWG6hvEZTlsnxIOkGkcsdWNUfxE7oiHBnM/BT27JT26W4q+Tk4Dzg7WXBk8QAfP47F0swSeS9dhNvOd7+urgC96YVKBzbkW9apc0lLQw74U1a7fXVnT18LV/tlxAuccXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PSjkloBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0C4C433B1;
	Thu,  1 Feb 2024 22:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825918;
	bh=Z9TgWie7YtgminwtE1RQnQvs7QaguyVm5XFk23DKB/k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PSjkloBhZZM5akBe3/QG1foc9zj4RKsnA/d+vvX5VeXMeN7ItAzAkUbCEfGGLPOK0
	 4D6eqqK3CaAlvn0wdzqZIBF5mu05SXLXn6Ao1/zN4I2m3+wN7qLqmJnusSEo3W/Eox
	 stTPLCdN2CkdxexOTQja5+l2+sWP/WhyvMuEqJz/SxiM8NLU02ueGN0smD8YsWMZgb
	 U5phZraJpISvmNXCS18B2LnNLOxxj++ULSp+nqN+gIXuQlSI5tExzvbZEfnh8EkKKC
	 VwjZb3vxkrgsAFA+Qu+wHrY6o36e+0tIDnjq5c4Zduw4Ojc7kbdIq4fTaiqtl6cfEA
	 4ISfV4hP7d7LQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51032058f17so1752451e87.3;
        Thu, 01 Feb 2024 14:18:38 -0800 (PST)
X-Gm-Message-State: AOJu0YxiRvE5/xE1VvJXSr1hK1Qrnb/W6ybcpqJlTIE5TAoxH5DyccoG
	iJsiNl6wHxaXaDOBqPXIPxX//WKqwwUGx36SHnzefZk9KgGhGxGPj9tUI6yC1OLddfVGI+qPyPz
	qQ8VGnb372KsneXjinPpYEHtmCQ==
X-Google-Smtp-Source: AGHT+IFo8Hgkp4E9JaVZd7NvXDQ6NzE7A6q7dh+4rpUrgLAaizZQtSJrrCMWBPjJ3KvcXFi8lfBzxbHQ7bxFDm5HUkM=
X-Received: by 2002:a05:6512:3b0:b0:511:21e4:5a69 with SMTP id
 v16-20020a05651203b000b0051121e45a69mr2802815lfp.40.1706825916680; Thu, 01
 Feb 2024 14:18:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201155532.49707-1-brgl@bgdev.pl> <20240201155532.49707-2-brgl@bgdev.pl>
In-Reply-To: <20240201155532.49707-2-brgl@bgdev.pl>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Feb 2024 16:18:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKq8AngeC7ohsbYB0w70uALD+PX-df53cswTDUY-Rrdgw@mail.gmail.com>
Message-ID: <CAL_JsqKq8AngeC7ohsbYB0w70uALD+PX-df53cswTDUY-Rrdgw@mail.gmail.com>
Subject: Re: [RFC 1/9] of: provide a cleanup helper for OF nodes
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
> Allow to use __free() to automatically put references to OF nodes.

Jonathan has already been working on this[1].

Rob

[1] https://lore.kernel.org/all/20240128160542.178315-1-jic23@kernel.org/

