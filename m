Return-Path: <linux-pci+bounces-36407-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1EFB83B18
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F08C721B5D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0182F6167;
	Thu, 18 Sep 2025 09:09:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60EC92FE592
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186569; cv=none; b=SFabdixYDMGJDlV+O05MdEzcwJCXZvLAeFLf02EmqjL0dTN+mOepizT5DPvxFy4e8pyWZ2e9SjyQAuSI8NUgeWKZY/giMDZFBRWNlrgpLagXfDDYZnQyZC5vh8+3cY8Tpef8lptO2iCpO71pV3uJe+MFmciTeLj8OykFHR3+C04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186569; c=relaxed/simple;
	bh=oA78+Hc2QsigW6eOAwWharYmhHBJia9T9YFq3+h/+4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfHJBqpoDpbd6dYyD6nPHdueJhD5og5YcOHgvXdsOnIZ7qWwL5+8R3KJFu4buMIZzeBypABrumxeUHQtfDWY7P8WhLSZC9FwKksWh5bez9pbtXnr2LEwc8zwEiPxdAegmntzZg7lVvcwxaZ4HcN0+PH3r05+LdPyKbHK1b2cNVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-54a786ed57cso386726e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 02:09:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758186566; x=1758791366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BUI3LMEUjKeaMro6VS1cwSeOA9TFMizFtGUUlwJmP8Y=;
        b=rkq2KBmJbKiOOx8Uin0+4BQQiWpyvUWw8ezWD8QnD2Guyt3q+AvzMmLZDrhEDrp8qY
         NpmaMTwro6VZkc2PGw4qayK01MigBtsaOjIM8Ktkxm+95NOuGIu1Kr0sZx9U/Jy3dhvc
         AhOChEGAxMe19waCpgeFnCkncN2iYWgdmwT60OpuCEb8KO83rZWTrX36S3MYGnTGdfnv
         is9NJmXlPNESzGke5us3XZP+mQhNe8/1LmrtRihdojknGjC/tWOd0+kgguQKJZcgxcUy
         ZtiA9yzQPxOabWuQyj6Hmrsh8EZppClrCYx7b61iMIVfIJFVCDYLb7WeAsC9IYxD0vEC
         PBqA==
X-Forwarded-Encrypted: i=1; AJvYcCVpJVnopk9mxdcAU33XMn6DTjVfZ++MBtLz/gpSt5uROD0c2jFZMowdSSGV7OJGZjbeJSnIvKihpos=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNCpO1i/iw7oVnucNHS5JfMETVkQR2xDuq0Bh9Bx7XqWCVs9WM
	IxnRgE4Ubvj744M1ZuYUnkira7at+WB9qIJRdBMXrix/mNGFxXObI0y4KGVDmC4p
X-Gm-Gg: ASbGncuoxlT/ny3WZp5PCwkv9DnsNSUNxpSFf+BbxsGTWclzsjTKQ5C0KltkVf/hybE
	puEorRwMhui55EZ7vm7pD3lVYhT9GViT4+gufbrh1TNQIOph7nK4BT1eXGqU6E1J7aSUZBUwxHS
	cw3lUXyqrOV1TiSn9O0J6ylPAJvCjsH2axli/qhzP8n8oAu96zeYsXl8fYPF9ygN89fCh1GpTYR
	vgMGEyiTkyivXNCMAMvbIqENFsh69sTlYJ7jMVzqm+r5/R/nM1D2fVajigyVki4w/ncaHJ326TW
	zWwK2OUJhpk/ySKg0x8OCmBr8Np4wUK7NMV1YFNnA9TUCcMzrBfYisd2k1c4LOHAyoh1jISA7Xq
	Pni40A30RNqCgQEmYDk6BaKrkAh2RcrraJXrVKcq1IpNGC+B5ODaaEneiAXev2cxbn4S/yuOnGW
	JGcZc=
X-Google-Smtp-Source: AGHT+IEwP7/FM4NjrYkL95e97j+uRUYhLAu4UOEAOwxG5FcJh8+sqM/3tNmqervRmXZFLIbLfqOfOA==
X-Received: by 2002:a05:6122:4698:b0:544:b2fb:d9f4 with SMTP id 71dfb90a1353d-54a608eb7fbmr2152931e0c.4.1758186566050;
        Thu, 18 Sep 2025 02:09:26 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a729744fbsm424305e0c.18.2025.09.18.02.09.25
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 02:09:25 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-552d3a17a26so219112137.2
        for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 02:09:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPRaxNIIK5VJx4SSCZjDBoYji9cX5GGt0zsOzFAt1ggfPgQQ8dP1ZW7n4i2JPPnUy0sYEW69TBXCA=@vger.kernel.org
X-Received: by 2002:a05:6102:6c7:b0:4fb:fc47:e8c2 with SMTP id
 ada2fe7eead31-56d5088a6e8mr1645890137.9.1758186565181; Thu, 18 Sep 2025
 02:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com> <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Sep 2025 11:09:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
X-Gm-Features: AS18NWCGAnZ0XCOYl-nrDkcvcpM1hNQPPeX1PmUWoRk02X3Ow_sZmQjL_oQhdiM
Message-ID: <CAMuHMdWP638eB_p9xMAqZmOnuc6n7=n31h6AqV+287uvqQEdww@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 12 Sept 2025 at 14:24, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The first 128MB of memory is reserved on this board for secure area.
> Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
> memory node (memory@48000000) excludes the secure area.
> Update the PCIe dma-ranges property to reflect this.
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> +++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
> @@ -214,6 +214,16 @@ &sdhi2 {
>  };
>  #endif
>
> +&pcie {
> +       /* First 128MB is reserved for secure area. */

Do you really have to take that into account here?  I believe that
128 MiB region will never be used anyway, as it is excluded from the
memory map (see memory@48000000).

> +       dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;

Hence shouldn't you add

    dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;

to the pcie node in arch/arm64/boot/dts/renesas/r9a08g045s33.dtsi
instead, like is done for all other Renesas SoCs that have PCIe?

> +};
> +
> +&pcie_port0 {
> +       clocks = <&versa3 5>;
> +       clock-names = "ref";
> +};

This is not related.

> +
>  &pinctrl {
>  #if SW_CONFIG3 == SW_ON
>         eth0-phy-irq-hog {

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

