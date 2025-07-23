Return-Path: <linux-pci+bounces-32790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA66B0F115
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35497176D3A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 11:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621E2E425B;
	Wed, 23 Jul 2025 11:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vI/7kfJv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98B2E0408
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 11:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269806; cv=none; b=S/z6OJIBH+O92336uMvlnIkvwLsBPIRdZg52XajTMUABJ6aHR0zG5z7QjVJbWUldeh/NANu6+4qs/HlZBMcuNxpnSHxAwaRsLrvZCPU31No5Wd9WjHdifnrd+/yecofd9GgyTWU9buFzPCvugFri3JZApoelELEsKU/CrQX/Ypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269806; c=relaxed/simple;
	bh=ZPCDtPuwf8qirJAt3wlVNDagGbR60GfYw4v1OF3Stm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGFRrAythn/Pn0npwv9wcau+uwt8dI59zBFms+ufRS5K/lati/lNIJclyyS5JNbP9NT6qBmLh0ckARxJAqXCHWQF5pc0giAD6JBRVes14tNfwq9ksUEBOqX8ie7drWS1QiYOVsX+Bu4SCSyAIAvTzMKhZUQMMkG/Y/KxjRvp2Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vI/7kfJv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b43c5c04fso8656261fa.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 04:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753269803; x=1753874603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
        b=vI/7kfJvLVIhMRxJkH+UdR7qp267BJ7blx0UaHBH/T7eb9+4Lm4ksSTJpdupgKDzJU
         FK4p3ATdZRRklT3nKhnSmw83IqlofIfsO3ErzyCMf4Q3VLc+ZlWnsnaJELiAHLvmhgvv
         08RlALSSq2K82Fg+xcIyuyFtmQvNC+iGFAqyExXVrnWmi8zGfuhuV4WXpi8GNJNP7zUr
         uZ3U1FeQbExtGk3vlQSKmkMmFw/7isxUaAypccIGWOzcqh8HEh4smqeuC2A/YWh4K6XC
         HYSgIAUDYtqAyvh3bgCHfOBknVgmsGj+CEfFrxdeDHI9Zi4mckq3VOKtKlg8gddxf2W+
         odDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753269803; x=1753874603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1YmU1ykvA77GIulXJEMJLdju3jM88FFVo/Kazht9VA=;
        b=MGB5yhFTve22YtBcP7J8PECUwoTqjcFeZz5GSsVn3rX0zcE4hDk5LI1elweSgkJi2K
         UteQk5MEK4m3CiR6t7WbHzJb/TTk8CHaR+9/zlADTSOaxAnugvX5/+VsGgVWeeDK8eIu
         4dice3nI22xnmgGUS7h9XGbVjahY6ERKGmdH5yp1ASp5bR2VVYVW7aXSQ7d7v3OZiygx
         xRI2ry5EMhGNBLHaXsVgMoq5N0kPKBjTj7epsysvik9DcuRok9aybFu0bnGJybF/qkIy
         SqrihA33MLxzojVXeT4wKC4JZbrXvOpjvRBE4Urjlic+ViA4LLkPIuSEl1gvD7o2AkQU
         TgsA==
X-Forwarded-Encrypted: i=1; AJvYcCX8avFRz5B7OjVAC2GjarHxaNJTt8IXX7h834QUydovAFGgrhZuOU+ah2IoW6zM0fxD0kruEnBZxiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyamrbA5NhPfsLrHU0PPBUFx2ZxqpVXv1aYPRdGwj8Jx7dnHFA4
	wcFrjb7XcaWnnhElDxWFoc2rdT2wT9KygbXnPhR9qXW7LZsRRrFrW8Lzn93e0FNWs8pG/Xvy89M
	kv7pCxg21FMHLrr79v4LdZVM+BMd42wcmkzoGFIZktg==
X-Gm-Gg: ASbGncsu50UoJBHl4NOP+xwhlQVgfwXDuZMBaBYvxOxT4dUgnVry1ts9t+A4ECvaDj6
	ev8ZKOVRa04qA7vgmDUig/Sl6T9ToVuF566fptYKvZjwBwWsmLGgh5pjvW8LBwbmHjBJRI9Hi/T
	HsbHZpKWq8w9XYCB8h1mv5jh9rCt5zxDwtQKdmNPvLMmbJsJWvbRAbJimXMLji6GTMeJDj5g2eW
	bbJhNI=
X-Google-Smtp-Source: AGHT+IGJe5Uxr9HPFMmzv6FKaMGGq0DeXYb8MEs6LCeEdkH2Ux3eyASfDB2156qvlMRtXLw+FwseABeguK4wIAj2U48=
X-Received: by 2002:a2e:bc1c:0:b0:32b:4441:e1d0 with SMTP id
 38308e7fff4ca-330dfb33727mr8322611fa.6.1753269802839; Wed, 23 Jul 2025
 04:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715034320.2553837-1-jacky_chou@aspeedtech.com> <20250715034320.2553837-8-jacky_chou@aspeedtech.com>
In-Reply-To: <20250715034320.2553837-8-jacky_chou@aspeedtech.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 Jul 2025 13:23:11 +0200
X-Gm-Features: Ac12FXzMES-g3RTrhXb0FNTMk2mTyN5VcSrw3I_gOJGbbpbB-aPDVFXKwi-6bIg
Message-ID: <CACRpkdarn16N9637dL=Qo8X8o==7T=wBfHdXPczU=Rv3b270KQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/10] pinctrl: aspeed-g6: Add PCIe RC PERST pin group
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joel@jms.id.au, andrew@codeconstruct.com.au, linux-aspeed@lists.ozlabs.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org, p.zabel@pengutronix.de, 
	BMC-SW@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 5:43=E2=80=AFAM Jacky Chou <jacky_chou@aspeedtech.c=
om> wrote:

> The PCIe RC PERST uses SSPRST# as PERST#  and enable this pin
> to output.
>
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

This patch 7/10 applied to the pinctrl tree, why not.

Yours,
Linus Walleij

