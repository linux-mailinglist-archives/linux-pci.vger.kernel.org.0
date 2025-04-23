Return-Path: <linux-pci+bounces-26517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B99E2A98632
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFBFE16A579
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AEF267B89;
	Wed, 23 Apr 2025 09:42:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960E91F0991;
	Wed, 23 Apr 2025 09:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401334; cv=none; b=ToVyOB1cvoDzEmYgo6+EfCuVDxnhOUeV/m0ATzlBXvq1JT7yh7iDiFYZ0lB/+49Jzd6TdAc5puJBwd5OXyBLhnm2Uai7ianaISYO6b0nLLil/AbqfDjj/HlKRZTH92BZNFIkVKe0IkiROJ1Hp/BQqvc5RTEw5B7cZlJjuYLapNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401334; c=relaxed/simple;
	bh=igo7g33sf8QdtAqAJ2QEeiPwn9a3rSfUn6H3GlRQRS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCpqXVJ2mEvkAmZx0s01fq8scOszPFR0J2TCLnEOKremDlXkWFADTy4utYZAg5TTyLSSk2CtTKkisoMT8KYj8g7oB+QENlrf/5CxiiwhlYv88AJ1DMVcjGLGy6I2buWXOz+fEPH30HGWIAsFmLwku0iqQISFwynHH8f6UhBey9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-86d3907524cso2280049241.0;
        Wed, 23 Apr 2025 02:42:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401329; x=1746006129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sexHOrDpbd/h7EZDwghhGaeo0X8cakgDd3Kmpze7Y0=;
        b=cnYpZW0nulYh4mcA+rgBxbrmVYLThxStbLHHmTrApqc7zP5irNsLborTEzjCcQj1Wr
         WpvxJFwI+egsG9YItndrYm+352rBVF0abFdcjuuNWBuweJlYrR3+PQ2JHdfnNij1YP1y
         3pCkXc7KcJANrW/u5clfPtIAqQsL7peezxs72HtxfSSrsuyLQYdf+KPM+XhvctunTM9b
         KvGA4GfohNl+XVTY3sVbQhjnz70Mxp72h+rf/fkdhLPluJ6Nr8wD3pE7d/I4vtj6WDiq
         B/NBA5M+Pnu0DbFsB05YvxfXBPZo7Mo+yQCBokHq2em4iMgB4W9nvIoc3RG2nEI4L6V9
         u8xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMehDWUKJFBsofoPcHkSLNiuuLDucMWOQXcG/8lindY7x+qQNjIXM5nDLSY130R/hqdhW1t0tgEBa+9UoD@vger.kernel.org, AJvYcCUnw3+uOjHk6xDwG3Rfi2PtW40q5OUXwX8R0XAOP+D/iAuhLDTvvKllU5ou5HiPgkbfSuvZJzPTCWmO@vger.kernel.org, AJvYcCWcBN8BmODGFlgOwnSdmyGb2dEgzkEl6DtvqgNdNAfFoYYZMh3CJiWqDPW2SBUGH47sxjwQwXPRvYvBDI6qm6qMync=@vger.kernel.org, AJvYcCXANRnScqDm+KISb1+/jlTyG7R/sAthNFIZOGXjgle6RSQ6w1VxXQkAuF4R92Da2YcEaf1Y7m4iq6UV@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc61BobFaSaxMxfgZj0z3unqi5cp+2/kT6UKKf+RSkT3rFkdw6
	UbN+Bh0HQ5hMgvKxTx/IcNuTbgmBBTczTS/Fg+oMwaF7/T2hauA2E+aCLEIA7pw=
X-Gm-Gg: ASbGncsGdzdqnA/amfYYGBETAMwoFq9IUKdrWSDUPQKbypeIE3H99HU17MCQzNL3E7Z
	l5+hDkWsDxnlDODlqJkRmz1ufIT1oBvW42yjV4bxRVdA/bB5SJZ/VTK3oNblqLQpcGpJzgbE7oJ
	HWwVgCWkQEzJ+nXYW3pra4mK9a6z8zutwm7rMKRUu+qsRwhtoJTXP4r8zyhJ2jIWAUc4eaV9L3E
	gNh2RnaJY9PvdF30H0PpmO1oa1Bp1r7JwPuwe+1O+fhcql5jOa+oxul+RSUuWjy6SbFSYd612SC
	qa+ToReA7faF35pr5+PQcICuso0s8ok8OeIfvislrCG56Tkx9zVt/wpYbVv+roiUVdBv3hLqLOP
	3s7MlrV0rF7dzLdEMfQ==
X-Google-Smtp-Source: AGHT+IG1P3r6lZGQpPS51ithSyQIBh/VWIs0U5pKnEveqzT6Pfa8KnmVhFcUh1qUjshRf55GgJ9BLg==
X-Received: by 2002:a05:6102:458b:b0:4bb:d062:430 with SMTP id ada2fe7eead31-4cb7ff26975mr11645408137.0.1745401329526;
        Wed, 23 Apr 2025 02:42:09 -0700 (PDT)
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com. [209.85.221.178])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4cb7ddb2143sm2666761137.7.2025.04.23.02.42.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 02:42:08 -0700 (PDT)
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-528ce9731dbso1791714e0c.0;
        Wed, 23 Apr 2025 02:42:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0eVSiUiWTwreBnYfjh9Rq/aeDvZkjxfFmIMCFPhy6OESJAk8ZQbhFAjnHmHqJVTCvSKh9WA6pmSgw@vger.kernel.org, AJvYcCU9sxniESFOjCgkInjLMjuCwRvnfK9ZGlYySvActLchTZgi7Dm2CqAFfLjBSZ3HNu1fjopO9AuJF2Ua@vger.kernel.org, AJvYcCWjmKtZOTDIjiRrTPED5TAc0iZvR9RPsXekbW3lNWsXGKPBUD2J9j0NaGZFf0QkdLFp+sNs6WZHq4Tr4KzOOigLDAI=@vger.kernel.org, AJvYcCWoDjABH2Y3FjFUUwT0xDMXPFUDEaHkmFb2uNc6b/UfFZ3/blpUEZUSbkl7z9ezw+Rj6VYkPuQTa2P5ysrU@vger.kernel.org
X-Received: by 2002:a05:6102:6b05:b0:4c5:1c2e:79f5 with SMTP id
 ada2fe7eead31-4cb8021c21bmr10743406137.16.1745401327693; Wed, 23 Apr 2025
 02:42:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org> <20250420173829.200553-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250420173829.200553-2-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 11:41:56 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVWu2TazTOE0voDkfYBsC=vvrCimPczQw3VYuJyvhV=1Q@mail.gmail.com>
X-Gm-Features: ATxdqUEuPwHtM8SgzzaD_wTTn04FsK7H3Ks6A19VPHk2n156ixPkKd_kaH6fcv8
Message-ID: <CAMuHMdVWu2TazTOE0voDkfYBsC=vvrCimPczQw3VYuJyvhV=1Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: vendor-prefixes: Add Retronix
 Technology Inc.
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 20 Apr 2025 at 19:39, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add vendor prefix for Retronix Technology Inc.
> https://www.retronix.com.tw/en/about.html
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks, will queue in renesas-devel for v6.16.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

