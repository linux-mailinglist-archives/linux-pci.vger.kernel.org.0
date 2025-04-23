Return-Path: <linux-pci+bounces-26518-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00777A9863A
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17A0F188C836
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C7C2550A3;
	Wed, 23 Apr 2025 09:43:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C53725CC6D;
	Wed, 23 Apr 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745401404; cv=none; b=On0Bq8HG1RZhRLWwaczIgIrJFnNVgSsIKZkI3jER3pIrYfXfMbSSEByLVAy0OlOyCow+V7PvwGBA1x9G40JJLXrak1+4gU8lYDiAwXXqS5UY2WF3zEd/M9TcFI7J9i2Pl4xVG6mAXPEfowidT5H3IWnfEnXB4vaxrL7rOxdSQ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745401404; c=relaxed/simple;
	bh=BqaynC9jfZck/5x61yD8cHcPhiNvamZgAUqo2RawpZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGihYx0RHz1QcpdRI/8NNcMJAksV1Mm5ykWV3OaLL1TryfuSx6E9LBRqC9Ro89MgOOGfERN/3OSEmNrK2erw/eGwWBIpScYAxP5SxTebdx8Ak6e/6gYkTl3jsH5/6JPOH/9GK4pU+2M8Qj0ygV0HSiSCCJKAM8ejXarWu6wfHlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523de5611a3so2354108e0c.1;
        Wed, 23 Apr 2025 02:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745401401; x=1746006201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUPHvEQr5af6UuCYWSzNmMgziLtTTDpfYmDwyTH4f1c=;
        b=EBHm4HcgD/RDKl1xccFBPa0BaxTsrTTe9bQTsBqKrh2VkU1H6sd0Tl5aNDGKX5nrr3
         cgrhI9CSUHuveC5M/x2o1391d/hVkWKQrbnfZOlB7dcwvd3eEJF7v5p5qk9f7BalBRLP
         b4yxNuEvk2L0I9kXRWbL1jvwOrx0bJEfApNSgaxvr22VtAULKih3hCSLiNj4UPz1N0k0
         HwcJQvJ00oyTn/uMe9uwzHSLMxzgJPFTN0DXZ01o4v7WWuAc4Nl+0a2KXjHVHastruvi
         BrzcPvPJgH6rQAwqVT3lN6p7AbcKYbDNRKpipqukL24cVhLy14aZ2p+DFi39C2BigylR
         ZFhw==
X-Forwarded-Encrypted: i=1; AJvYcCUdwN90mi/3I3/7j+9FzRWpVw7ZLBuuKyIgT9sTNk0lyBBrDWESN30UlriQ9VZ5AUJTDih6oeY2Fzyp@vger.kernel.org, AJvYcCUmlQCq8AgHWRs/OEGQSeySmpIws8Rj/0aZyIQRAe9tyRRjo6ive8VeFAb2AeOCOOeOuMUCyaboArUI8Ou6@vger.kernel.org, AJvYcCVch11Y1RdozRFwANesVKWGDPusxdNw45kyMYbE+cM2Nuz9oCRXqS6ewW7Eg9SR2vP8mf17HmN+Tt+//zMAtKMo384=@vger.kernel.org, AJvYcCWR1m6kR3zFwAkKlH9Zj4bOEmcrhZJz40WV9rDFtOMSqiUSgKA1tuKfcwi+DsoausqPDQ/0YnizmDNf@vger.kernel.org
X-Gm-Message-State: AOJu0YzKlDtv54wUAY8jafzu4FTMQ5cJBJ7nchSbx7XVzv/tTvfbQUwx
	sD24q6v1P7dE0B3THMgNg8Iaam/lg0S/JVi8Wi7a7Cf0ZkNa1hMN6JqPkjYurdw=
X-Gm-Gg: ASbGncu5wEpjPo8pLNkW3KOCgSWeGiD5t1l4px/lvbWzXtzey3ln4qj6yNcOMIGLiS8
	G4VxWl4vh2ILb9bhgDZPmrCDuSqdrMOAoKrL5Vr8eTeg54OvEGdXTzrMXCougqA4+Q8VZ4h59uC
	BUBPiU0GKQ9mAEKfd1ITnH5/oVj+l27BWh9I95LQyHFxohsCn+Vn0Llhf5L44RaYtUh41V1Owjc
	PacCiv4Mbfk3+jdkVsL8mfEl++vJbCZQ4004fKBTP0Aqq9cb0I0lOj+uHsfZRkr/VmuJ23WiR3l
	vghUw7tFSrP1NJQOj3rINqOmKbvIDhvABLDcQfFmzrY0ixzPLl4pj739lraWLRFImKoCCQtaSF2
	P7c0=
X-Google-Smtp-Source: AGHT+IGVG2ZyAuC8fr6gZruBbaVg18IbdY7sKIPSUuAa0AOeFBM2TeZ28Bf09/3zG69htbE7mJwqAA==
X-Received: by 2002:a05:6122:8c7:b0:529:be0:8353 with SMTP id 71dfb90a1353d-529253ad84emr15885372e0c.2.1745401400791;
        Wed, 23 Apr 2025 02:43:20 -0700 (PDT)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52922bebd43sm2326659e0c.7.2025.04.23.02.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 02:43:20 -0700 (PDT)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-86b9d9b02cbso2446228241.1;
        Wed, 23 Apr 2025 02:43:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUhryUs6hwq5yZSbAZZ5Q8g4bHWUXo6fQi0Ch3n08ipbGnDvmIC6KRC+BLrEvw0pyzhNxDW4eIwhdGu@vger.kernel.org, AJvYcCVcBOm02DZOPbatQ5sxhNIBc5miJdahuwfl/Fn2A3s814EjFHaB996Vx6HtvZpJqaQa+tT89CF+9FRgQby1On9T9m4=@vger.kernel.org, AJvYcCXWOz417hnxENycQJVxLabpKPFFMGmrciHJc9ysAblA5Qchx6PEoTZuxF3Mbhx+4sibNfjGW5LNhzJkKO1h@vger.kernel.org, AJvYcCXaRooVMHv7kfTDTI6NGL1CkCqhBfQ23mJlQu6rbozhoRv7O2NGHl6iBOMJPz5hQ8OZtinchtlBsgai@vger.kernel.org
X-Received: by 2002:a05:6102:3139:b0:4c1:c10d:cf65 with SMTP id
 ada2fe7eead31-4cb80232571mr11121634137.25.1745401399791; Wed, 23 Apr 2025
 02:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420173829.200553-1-marek.vasut+renesas@mailbox.org> <20250420173829.200553-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250420173829.200553-3-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2025 11:43:08 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUahR_J9yHuLKVzZZzBJpC2ax-H+cBFXCPHVMN+_-ZNFQ@mail.gmail.com>
X-Gm-Features: ATxdqUFK-chPyKNsS2kRTD2K58MG9RMy218bkOrxSuRBq2YrjuvKQVL8N8mFPwA
Message-ID: <CAMuHMdUahR_J9yHuLKVzZZzBJpC2ax-H+cBFXCPHVMN+_-ZNFQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: soc: renesas: Document Retronix R-Car
 V4H Sparrow Hawk board support
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
> Document Retronix R-Car V4H Sparrow Hawk board based on Renesas R-Car V4H=
 ES3.0
> (R8A779G3) SoC. This is a single-board computer with single gigabit ether=
net,
> DSI-to-eDP bridge, DSI and two CSI2 interfaces, audio codec, two CANFD po=
rts,
> micro SD card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe=
 SSD,
> debug UART and JTAG.
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.16.

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

