Return-Path: <linux-pci+bounces-2319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE15D831B56
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 15:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F0761F26D59
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jan 2024 14:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02909286B0;
	Thu, 18 Jan 2024 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsdvZXqg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA52C9D;
	Thu, 18 Jan 2024 14:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705588175; cv=none; b=u70VFdKdP4AofmIcGxfRPgoo4XFQzWjIAeKl4xbuQlONN9HYNZBnJ5SytTMa2PazJtvlFsqTUlPfgx4ZW2Zb7qKi2Z/Sg8UpwRVHvBVHgvQNx9LLTP8I6Np6qqtwoW6/TDYiQl5iXjh1QqFBvmaw3wH5jtPLwHmUEV6hIHDeWSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705588175; c=relaxed/simple;
	bh=iPGPVXXwyd5DFSfC8msMPU1CSz0Q7jm4kMOswDCGfn4=;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding; b=ip9Lb9o5+v/xopGfYyqJRx92WpEtbAG+CrCRt1RuFghv+Dgep6PKtKedvtyfUJyKifPt/25VlEbnfDlnlNiZuH/mP8/OP1NSc3wB9gdGVYW7EFeYtcs+ihvgPN8TtvTtactFfPYCk8w3+B3f/v9/yNK0BPGY76IEF9nW20RmQjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsdvZXqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F12C433F1;
	Thu, 18 Jan 2024 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705588175;
	bh=iPGPVXXwyd5DFSfC8msMPU1CSz0Q7jm4kMOswDCGfn4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VsdvZXqg71HEfgsj0TMAnjwKaNJMB8YfV6RHoZIdngwczm2R9BalAiS5dSBxF/NrL
	 erLZWbXItZ4BJ6n81aA/hPD0PYCZm6fEu12ayLT9FZfGysL7vb2J3y09rJV1X4911/
	 MBEXc9UdwGEo5F/NM5qneMKqNPWFdbpUWfna3Q/ATOmcFlFSvJ2ZCnK33394PoGWWK
	 0amzGNrDh/+luAUELiD7dijo+uyMJYTqc79GJ+76E/xh/UgqUBpv1lRLL3oqgVICPv
	 asLg/+x7hG0hL+vbHXy42so1VIPsEp6KBRMfkbqOXFA/Jh9AV/Vi2eFCKuWmkZUqoH
	 m8Kn5sBfqvM/Q==
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28f66dc7ffso150582166b.0;
        Thu, 18 Jan 2024 06:29:35 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7lQmVM/2uB32FZsOLjE6ponPfM/bNQEmtmqIkOCd2+SmISR63
	6RSy8Zea6NCZMIW1YPi39cIitzfw1Q4F9wadORGJWte8rkb9J4aX2EVxDFYWrC8/a957ZoHOYAY
	pJZJImWuYEM5jALqfFzTTmpBxIQ==
X-Google-Smtp-Source: AGHT+IFh30Wa29ABtnduwX0kE65ZA9bKjWTFtwY7A2f10u3apUDt/6uU2eD5vEaD6OSynYOp5n7MROLZi+0BQu7ZbM0=
X-Received: by 2002:a19:644a:0:b0:50e:e1c3:f97b with SMTP id
 b10-20020a19644a000000b0050ee1c3f97bmr1677678lfj.3.1705588153618; Thu, 18 Jan
 2024 06:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117160748.37682-1-brgl@bgdev.pl>
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 18 Jan 2024 08:29:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+0xb-otvjkbLqB8gNKadVqnigwGB_k+VGrj740Y6wxjg@mail.gmail.com>
Message-ID: <CAL_Jsq+0xb-otvjkbLqB8gNKadVqnigwGB_k+VGrj740Y6wxjg@mail.gmail.com>
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Chris Morgan <macromorgan@hotmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Arnd Bergmann <arnd@arndb.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
	Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Terry Bowman <terry.bowman@amd.com>, 
	Lukas Wunner <lukas@wunner.de>, Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Abel Vesa <abel.vesa@linaro.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:08=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> The responses to the RFC were rather positive so here's a proper series.

Thanks for tackling this.

> During last year's Linux Plumbers we had several discussions centered
> around the need to power-on PCI devices before they can be detected on
> the bus.
>
> The consensus during the conference was that we need to introduce a
> class of "PCI slot drivers" that would handle the power-sequencing.
>
> After some additional brain-storming with Manivannan and the realization
> that DT maintainers won't like adding any "fake" nodes not representing
> actual devices, we decided to reuse existing PCI infrastructure.

Thank you. :)

> The general idea is to instantiate platform devices for child nodes of
> the PCIe port DT node. For those nodes for which a power-sequencing
> driver exists, we bind it and let it probe. The driver then triggers a
> rescan of the PCI bus with the aim of detecting the now powered-on
> device. The device will consume the same DT node as the platform,
> power-sequencing device. We use device links to make the latter become
> the parent of the former.
>
> The main advantage of this approach is not modifying the existing DT in
> any way and especially not adding any "fake" platform devices.

Suspend/resume has been brought up already, but I disagree we can
worry about that later unless there is and always will be no power
sequencing during suspend/resume for all devices ever. Given the
supplies aren't standard, it wouldn't surprise me if standard PCI
power management isn't either. The primary issue I see with this
design is we will end up with 2 drivers doing the same power
sequencing: the platform driver for initial power on and the device's
PCI driver for suspend/resume.

Rob

