Return-Path: <linux-pci+bounces-30752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4BEAE9D68
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D8D5A044A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAC21AC88B;
	Thu, 26 Jun 2025 12:25:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB44A0C;
	Thu, 26 Jun 2025 12:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750940715; cv=none; b=nu3QF4WUQ5jFJw8oxh8ifbFL7aMZ7rZAmR2UHrUQ+YRVbD52NNW5wfuuCFxZJEEol4/AzVfi25lGMZPZ+g0gXAM01Jel+srJCdKUziNFYDMG80s+bzSsffy4wjJrJNaWQKbEu3/h0pAKTO4kZ3sG6DoILE+qccdv/hB40FxF6/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750940715; c=relaxed/simple;
	bh=k9Ps0hISrCBk+jqItJuaOyUCLRiJtokFNVqTBuJTodQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZyep68CRgxnLENAr9lmBmgboPX9/7BdxLwkqtRVx4XSaVl0Zmf4mzaeY75hHVxHFV8fMrJm+xn7F3d1rmwTfyIj75Vfb8jg0Nv5dCKbE8+hFUZcuY8/Zb74OFyy+eYQ4Q6wwTQejZYs+w4O4d7aLGVVnsKZX4IfFYy8W2Y6oJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-531466622beso287504e0c.1;
        Thu, 26 Jun 2025 05:25:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750940712; x=1751545512;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JypkF6CCqlLIneqk76FBMfY8CtdemFDrG1hJLcGnvRo=;
        b=Ytr4NbcHqKf7d2auwnxPUYEOqVGM7y56JKMetTvNJmPGi/bosJZ+AImY41zo0s8qxQ
         nXrXz6q5KRuaTQ373JIoO/JuPv1gFpt62FuL1miMI05hxR6aeA4gz2KMHtVMa6H/qgaH
         1iUfhRguOXx15KJu3EZjYDMDn9/B8FTEnMs2k8K4OyVBP8SOmWMp41+takaztdyLK9AB
         bxVPeLI/PEw5tB6lCySEVVYgCVlAjA7qf+Ge+klrBznpxYaiZxj8kMl+0X18FfeUF7u0
         d++cfnqCl6cDNa3Z7ZPGYk3YcTwShJenRlh/mQrp3ILEjcCXzXSKVPmk3R/DArSWeim4
         R0uQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEmw7vHUjeUjrO+wn3suaLF2OJdGrNxC3xxB4IdPDk05b3XDoa7cp+cVs0dNdg/xGhBZdbobB61CfLrdE=@vger.kernel.org, AJvYcCWio+mIP4IjafqdEqJ6Lzs/mN2r+8qZjEUhguxm9Z7+JPS9NYHSwEDXj2UG7qreyv7xxrlHHZsTXW24@vger.kernel.org, AJvYcCX5mHOL5PPb0KLR5EVeHU6qUY1Va3aNNPOiNgCw9R8Hbrwfc5NKYqRR4p+eV4ofUL5K2QEOt7UeeraaGhqZy6zORH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcHmgEW4rMCv+tIYy/by0t8J/jvXpRgxWq0ICcnX4yyTxSOxUM
	nE9bEmLaFfm0GUtfuyIuklornUeLUu74VY7bNbGP3PFTskuTCnaT8HK63lo8xchl
X-Gm-Gg: ASbGncui3JFF3PtwZO1/HOSP69GgbC0tbbeYOqLkdS0UZBV+ucUJKVMH/nl//Srwosk
	NAe+6d9wZHVhJcU6m4pExgfiLxd0luVtdRHKYXwkm4T4/DkeX4OmYuTH6fK4xjgnVzROVRXvTd7
	A7znFbPN9I12h4wIsDO/lamVPvkZGn6C9xvWmmj53qfUNM6XsUWRf4rgIImVLFhLrKt0Vrs3JpW
	C9j2lOHbHiz2XpAvq/MT/NbXF7gUhT1CWiVJPyoZzdeUpGwhbNYpB7WnkttcC7luHqMqT/+s+jD
	z3utyo36P0eetc8mO9fC+Yf3ZUa/WycA/UQfz4390uh0JueVq3ujLvZ747+fL7tZhnzIvv0KgMA
	IytZxBzZLxEGgzxsDRjepFCK6iMMa
X-Google-Smtp-Source: AGHT+IHJ+EzsmBrs3yPUt/AAesFJUfHnxsB9mvM3MX9OOQQa6orcudHlaDColN2fW2KGplXXBsaLRQ==
X-Received: by 2002:a05:6122:7ce:b0:531:2d55:7f54 with SMTP id 71dfb90a1353d-532ef5a7e26mr5399955e0c.3.1750940712485;
        Thu, 26 Jun 2025 05:25:12 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-531ab37e3absm2296381e0c.39.2025.06.26.05.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jun 2025 05:25:12 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-532f9127978so290133e0c.3;
        Thu, 26 Jun 2025 05:25:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUMCWHHDQJkDZ6ccQspeFMtGB7DIUPMTt3GnPuKw4j4guJkFC/kBtQc6KyBWbmiaf+SptQ9AEWf0A+Zljo=@vger.kernel.org, AJvYcCUOcopdoKSpnvPVpfeNn4fmVTz39YXfCVam7L12FJAb2fjUBXhnpUvsicvxDmSStihuOzRzla8jKRPO+6J+NE2xn2c=@vger.kernel.org, AJvYcCVGLse9Rgtn9mSBplSmyGu2//ZcOTnxTlOHjapjeKoo9qFG52hivQ47TLS3bIpnkHh3AvzLIp5ZhWJ0@vger.kernel.org
X-Received: by 2002:a05:6122:489c:b0:530:6dc2:ba97 with SMTP id
 71dfb90a1353d-532ef58b74fmr6074193e0c.2.1750940711998; Thu, 26 Jun 2025
 05:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611234206.159695-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250611234206.159695-1-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Jun 2025 14:25:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWRwvp9U2ajV9_g=Q+iKmBO39sb1EcsWywAFo39dsgZqA@mail.gmail.com>
X-Gm-Features: Ac12FXz9JnRglxrjH1IEpK-pM5mVEdJaD3RL8Wjyi0TVzlr1BmT4ixLpR8UbtFM
Message-ID: <CAMuHMdWRwvp9U2ajV9_g=Q+iKmBO39sb1EcsWywAFo39dsgZqA@mail.gmail.com>
Subject: Re: [PATCH v2] schemas: pci: bridge: Document REFCLK slot clocks
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Jun 2025 at 01:42, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> The PCIe slot may have 'REFCLK' clocks which are explicitly
> controlled by the OS, describe the clocks property.
>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

