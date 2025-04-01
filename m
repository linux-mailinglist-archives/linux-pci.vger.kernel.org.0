Return-Path: <linux-pci+bounces-25057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A55B1A77826
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA219188F376
	for <lists+linux-pci@lfdr.de>; Tue,  1 Apr 2025 09:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4791EFFA3;
	Tue,  1 Apr 2025 09:49:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A291EF394;
	Tue,  1 Apr 2025 09:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743500989; cv=none; b=YbocYjCJTQ85j8kdqO03pMqrWcu/7I0rvHWxytpODgLvsjNS9pqG7Y41gdYbwchgiafIZw2XfLsg5G0bGPmCOB8UsEV+RJj584w/BhZ5M/KKGgYpb7nv8Q54tBJ69QX2j8+vLiq0Q3r5qrS5K86X8hfmOov2fLXYbsMOIlrcRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743500989; c=relaxed/simple;
	bh=c0/2Il+HKMHe/1KYQsOXrQrqmLFvTc+vMlTSyj4HAAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvMv25j46cIlJlL12SAmpjMiqvuH+wmEXZBdPu8vpLMg5Rdy4NF4oGuD6fVH9E4CbtnvVIK+g63YVZXRBdYNUn1MP1ek+KSL0r601ly72uD1rQP5gWjggmzKZB6YXhPtFE7NtFqsrNgMdTX7wm4oUg2GBtytdP8nbaf3F3cU+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-523dc190f95so2658689e0c.1;
        Tue, 01 Apr 2025 02:49:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743500985; x=1744105785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y1zyMwtR40qQQhixsawu3/3AN+ghiZjIje47Qoy6I1M=;
        b=oZvJ9Fjv40X1s/MMKjJ8Diqr+jgsvji/gGTa0muG/8JMayWID8fjagF6kvx4NdD0WF
         koSjjAP5zROZHRADDphgkKaNYy5r4a55x8aBzwho5pCR1DAXm8yI/4C5xwcuhSSeuDMF
         hjebH/QA1QrQpKWAGOU1G0GZAad2alWnCL1n1Z1foG5Wbw2X+NdcSaJCmQhmu4qdaPMN
         V1afdcf26dp82yBeIqavMGbrQsjFDwyL/II5qRt1WR+t+QxkG+pipqUGzm0PZ0Y+iWeN
         GPiO55z+E0VTSw1C0nKEmaNs1cuNjcnixhzIzPNVyocmapSx+VSHi2aP0P+jEEAja47d
         fk6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWJYExMEXuDPagURBiBvJKHrj5WcCZWUnC8pw69ziuapdfUOiX56eIQZvsELrMo9XsXSm9BQg+3ruKGtfo@vger.kernel.org, AJvYcCUvvyulFnfgp3CH79ufB79Ma73B0cm4KZv6FLJ0IJJKRznO3gCA8YFJzZcMFD6ACaBZSTA7rwMLOC4y@vger.kernel.org, AJvYcCV9sc0wf3HsON5U/QUlCMNvsjVTij5YigQFvu8pWguB6NQdfgz6TTtlTtMfEbuQtabys7qRFX5g728a@vger.kernel.org, AJvYcCWfYqP0dGxVBQB9SB036kef5FAAwvMw4tGESCraM6M9XnFfWTc8lGprWZarHsKpLpd1ZG5x5YukwwGm7oWq8IzSoow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF4wMR1mlJyEqloTsX3+aVQfs1AWWrpIgea9Sd+xod50OGj+sp
	x1L2d1AccvdpXGjF1BbRMUAAfX//Bcvfwwp70hFLjZX/EBAlxMlfYy/N49in
X-Gm-Gg: ASbGncsJg7aHI2osM8d8wU38X587otOxSjkm29ppYH03YOMAofXcLRrCRNAAtDJP8zR
	uf1XhWB1i2EQDrs4iqbqExF038SKg7GPed+AiIff37Ck9C6qUEVCgN9rQguKrU3uU1aDJpMIHUx
	dh26TA94uAAoKW6KvzvcOa+gxIPTYwBUggY/Xi2+iLx/uoWI+pGKNICTdEJgHmuX2A+hp5umrm0
	lBHBJbqXgr2PJnSjYOGti+Ea9wqR2UIBndzSLhgtwqt76j6/jQWdblWcjPzsnurIv2AnyGx17gU
	oJiRB/4OasAZupmqG4lGpUL4WLHes3iSrQ0J0w1WAEpNMDo02/YTp2c8w3s7c85LaJ5PrpGDyFi
	z8ib1xT7UxYM=
X-Google-Smtp-Source: AGHT+IH31MtTwEUy6Sj9tAhyj3bsRTSR/sK9B29+yGr3THhtU70h34iDwk+FjGtm0fNvN8lXzleXAw==
X-Received: by 2002:a05:6122:2a4c:b0:50d:a31c:678c with SMTP id 71dfb90a1353d-5261d357a48mr7733493e0c.2.1743500984732;
        Tue, 01 Apr 2025 02:49:44 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5260e6a0afcsm1939593e0c.6.2025.04.01.02.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Apr 2025 02:49:44 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-523dc190f95so2658679e0c.1;
        Tue, 01 Apr 2025 02:49:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUvmYzg31/a0xdzzctdsd4enlaH5dXhJb/gIMO7kRXpH7IufWIlw2Ei2jPo5x0SuAEYzIxQDLXiiZLr@vger.kernel.org, AJvYcCVbowwVgfKh7xJao6XC359jGDimY0cDaX0jz4cvLHYtCNYJcbO0nNkzLmYT2dOw5YpuT2/6qZqwc+nxqRk6WGCg5/w=@vger.kernel.org, AJvYcCVdYhtN9R1fFQMxteHCy4J/Tfw59xiJYlktKFlA9IFxWj/adviM/H8KJkkLNegpUOPeEj1c/wOozaNJ@vger.kernel.org, AJvYcCWHcj/U5hzDm/lmEGRuvQUT9+klTuJ/ldCUCGe21gOt77c/GJF6btyAMWRkFw3n7ZztFk1PDkHwx2UOg6LW@vger.kernel.org
X-Received: by 2002:a05:6102:14a8:b0:4c5:1bea:1c29 with SMTP id
 ada2fe7eead31-4c6d39af686mr8115053137.19.1743500983709; Tue, 01 Apr 2025
 02:49:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org> <20250330195715.332106-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250330195715.332106-5-marek.vasut+renesas@mailbox.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 1 Apr 2025 11:49:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUx31WHW+fUP0Qbfs-Si2+cLmxC=YRUKWvSudn7CBZ4Fg@mail.gmail.com>
X-Gm-Features: AQ5f1JoeIvYp6dxZPMkSZCvf_rs3MuLZLQfoBSTfTx3w9rvwfJ19pgmFQ3EdrXU
Message-ID: <CAMuHMdUx31WHW+fUP0Qbfs-Si2+cLmxC=YRUKWvSudn7CBZ4Fg@mail.gmail.com>
Subject: Re: [PATCH 4/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H
 Sparrow Hawk board support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-arm-kernel@lists.infradead.org, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Heiko Stuebner <heiko@sntech.de>, Junhao Xie <bigfoot@classfun.cn>, 
	Kever Yang <kever.yang@rock-chips.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Marek,

Thanks for your patch!

On Sun, 30 Mar 2025 at 21:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
> Add Renesas R-Car V4H Sparrow Hawk board based on R-Car V4H ES3.0 (R8A779G3)

Retronix

> SoC. This is a single-board computer with single gigabit ethernet, DSI-to-eDP
> bridge, DSI and two CSI2 interfaces, audio codec, two CANFD ports, micro SD
> card slot, USB PD supply, USB 3.0 ports, M.2 Key-M slot for NVMe SSD, debug
> UART and JTAG.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a779g3-sparrow-hawk.dts
> @@ -0,0 +1,671 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +/*
> + * Device Tree Source for the R-Car V4H ES3.0 Sparrow Hawk board
> + *
> + * Copyright (C) 2025 Marek Vasut <marek.vasut+renesas@mailbox.org>
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "r8a779g3.dtsi"
> +
> +/ {
> +       model = "Retronix Sparrow Hawk board based on r8a779g3";
> +       compatible = "retronix,sparrow-hawk", "renesas,r8a779g3",
> +                    "renesas,r8a779g0";
> +
> +       aliases {
> +               ethernet0 = &avb0;
> +               i2c0 = &i2c0;
> +               i2c1 = &i2c1;
> +               i2c2 = &i2c2;
> +               i2c3 = &i2c3;
> +               i2c4 = &i2c4;
> +               i2c5 = &i2c5;
> +               serial0 = &hscif0;

This assumes HSCIF0 is the main console.

As you also have a second debug console on USB:

    serial1 = &hscif1;

And the serial port on the RPI I/O connector:

    serial2 = &hscif3;

> +               spi0 = &rpc;

Do you need the spi0 alias?

> +&pfc {
> +       pinctrl-0 = <&scif_clk_pins>;
> +       pinctrl-names = "default";
> +
> +       /* Page 22 / Ether_AVB0 */
> +       avb0_pins: avb0 {
> +               mux {
> +                       groups = "avb0_link", "avb0_mdio", "avb0_rgmii",
> +                                "avb0_txcrefclk";
> +                       function = "avb0";
> +               };
> +
> +               pins_mdio {

Please no underscores in node names (everywhere).

The rest LGTM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

