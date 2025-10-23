Return-Path: <linux-pci+bounces-39123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75067BFFC16
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 10:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEB4B351BC0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667C82E719E;
	Thu, 23 Oct 2025 08:00:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F352E5D2A
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 08:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206437; cv=none; b=UP1C4KzcVD0q+SG7ixxNtVpvLewhOLYcpYU124xmITtfqquKZ9B8EXYfJq92BQ79OiWCrkHNiIG7Q4/FxE/dM9Slm7jBxYKJ4m/IDLt0svMjORURAbOjBhkBOdS+Yizhk7CZzAtUHo1aX5j8AMG63/UkgxNFTlwZrp2DzobacgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206437; c=relaxed/simple;
	bh=KpSaMjSEZziIYn4V8EA3oAQHYYGym/G8ks3Kmoko+Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbOyhwOGN5xt5ifho9x6T9GpHo/L2l6MQdMZ9V6feViZGy/VTGgZK6pfPpo8IeOEvJoHxmkOoBKGLwESWagZ/fQnfN5T2x4NBDUJcxJEolfXzCt9G3nMF7YZi1DwdGPy3emm/ls+5X+IS1GWrt82+xTOdINLQUW1zdYF+usGvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-557c26c5d43so75355e0c.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 01:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206434; x=1761811234;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XF9ym20BXQJuQdpG7CWrlv8nMa2KXEsJ8BzTyt5Bosk=;
        b=OBqx+q4hUJjjfPeQ1kIdkF9AxsR2OYb1r3mbTqJoKZ/7r+W4i7zc2s8h1lv6ag7A1K
         48PInXH+cYaIFeDMq2K3z88SnY7LERy5njEPxbvnCOWxUEI76vUggvU6WddmERHD6SB8
         KjuQG3eFxregRL5KZYYagNDI9Iudf3qdTr3C5OhXgZEQK03GezrbzGcQb9r4PiuL79MS
         Via0bErppTyS+KD3/eYnZz8bLziso6ADKiLKtvm9U3PwxEqhN38RVEurKbyQTo0dCOJI
         ELTHY5RRN0nB6ERhJJhPomqznNQkeR1jV+I9EkaGJnZdigd7bQA6Gpd3XQm50aTCNPx+
         R/JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyUO5PfUttZZzURIvOYlGJ53vg0HqzOeuOiLqyp6TKT9dk73Y7Nfb+fh0Si60f8yz662B0fd5TAzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEWEm5JYSxb8lK/rSPoo6UVYXKa2SDSJUvb7pcRYz8elnmmWNF
	5OxC3CkQbk/zazMF/wt8bQ2rVyPvMya+uHPN8kwl9Z9PgMYMDVMsCBRCZ4dnx/Rm
X-Gm-Gg: ASbGncudoeJDwHQT9J41Q85c5zONDan8x9OCp3dAUzTpDAv7EX7eUFaMrJEtkI/4wi5
	R7Kbw4qsEbxMMSM3Gzm1Wm+Wwwjs9FExyl4X4bKw667WIekVzRoZBVHjEPgZEZ9De2HOrnWlEjK
	rI5yoGY65cX2rqnBt6lcAHzcUXaACaL1SiFnEuif5S60sGXFutEq99/kjFBoAlNeAXQAIcfOT6U
	Szt1lLfSwtBu+XDtQR/ceavHVeJlrmJgao4TKUeiP8wn4dXQMUz3weuf5FcyLTcGK7JAcRk2RMv
	LzE1UiG6xk5ZigU/NvobtJA+ySDSI/P69DoG8JyuJSHVrL5WzYU+UdF/MRDuaHJus9/fvabi3H8
	LVGsLCdiLSZzsReqK+5YsQlREKcieKvIWh3gWYeIDGvx2FCrjXh2VpBcSqpbPSVgvgPbaLoV26I
	MiBmYNcWnHX0E7za9gJanETs9SLwvDg6JQm/I7xLMjAaKRclLD
X-Google-Smtp-Source: AGHT+IESl1oR9LWkZBhlNdEAmvNfY23M5jqlP19OtJKmWUQMt2B8Z6aOtI51sGSFbWNLRrOLQMhjZQ==
X-Received: by 2002:a05:6122:3412:b0:556:745f:6a06 with SMTP id 71dfb90a1353d-556745f6b89mr3890327e0c.10.1761206434412;
        Thu, 23 Oct 2025 01:00:34 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bd8e11a3sm537444e0c.10.2025.10.23.01.00.33
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 01:00:33 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5a3511312d6so231463137.3
        for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 01:00:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVIewO6maY2GQJSzk1ztm1GulTZspgk1/v9dD9rbW/OybqtDE9OwxdTYNcKq8ncXpPcwZp3SUl5Kgo=@vger.kernel.org
X-Received: by 2002:a05:6102:32d3:b0:5d5:f40a:4cf1 with SMTP id
 ada2fe7eead31-5d7dd6a4e59mr6656672137.24.1761206432910; Thu, 23 Oct 2025
 01:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com> <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20251007133657.390523-3-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2025 10:00:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
X-Gm-Features: AS18NWB9_OOBrClG3W5gj81JVaeCg1e2FLiq_rBpovw0Id2oH40EKE5zSy4p5SM
Message-ID: <CAMuHMdXF14x68Wk5YdOBS2D2N6LtnQjfGzrsMdSJegX-gc3faQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, p.zabel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Tue, 7 Oct 2025 at 15:37, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> only as a root complex, with a single-lane (x1) configuration. The
> controller includes Type 1 configuration registers, as well as IP
> specific registers (called AXI registers) required for various adjustments.
>
> Hardware manual can be downloaded from the address in the "Link" section.
> The following steps should be followed to access the manual:
> 1/ Click the "User Manual" button
> 2/ Click "Confirm"; this will start downloading an archive
> 3/ Open the downloaded archive
> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> 5/ Open the file r01uh1014ej*-rzg3s.pdf
>
> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

> +static void rzg3s_pcie_irq_compose_msi_msg(struct irq_data *data,
> +                                          struct msi_msg *msg)
> +{
> +       struct rzg3s_pcie_msi *msi = irq_data_get_irq_chip_data(data);
> +       struct rzg3s_pcie_host *host = rzg3s_msi_to_host(msi);
> +       u32 drop_mask = RZG3S_PCI_MSIRCVWADRL_ENA |
> +                       RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA;

This should include bit 2 (which is hardwired to zero (for now)),
so I think you better add

    #define RZG3S_PCI_MSIRCVWADRL_ADDR  GENMASK(31, 3)

> +       u32 lo, hi;
> +
> +       /*
> +        * Enable and msg data enable bits are part of the address lo. Drop
> +        * them.
> +        */
> +       lo = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRL) & ~drop_mask;

... and use FIELD_GET() with the new definition here.

> +       hi = readl_relaxed(host->axi + RZG3S_PCI_MSIRCVWADRU);
> +
> +       msg->address_lo = lo;
> +       msg->address_hi = hi;
> +       msg->data = data->hwirq;
> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

