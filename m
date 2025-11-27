Return-Path: <linux-pci+bounces-42213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D88C8F479
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81A7A3A8E09
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CF31A07C;
	Thu, 27 Nov 2025 15:31:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E04336EFB
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257483; cv=none; b=L4JBvv6XlDwLZ5T2/jn+RhyEEFS9g8Q2paL3DPKtKX5DuWaiCURkWvNkGI0IeWyNpE+Ah1g+3fzJs9lBcnri7+47i/TFgcNxN3i6NMF8i+QIMiJdp7v0ErXUcSsDcTnNKb0FLOxiM00n5ACFYoi7koTetAlmplC3DaAWrOc2HsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257483; c=relaxed/simple;
	bh=0Ms3nh6UST62nZ5f2gQbl1TP9z1Cw0CPLTAwI1ISOn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ImIwXmhxTs3PJbucXbe8VBKvwIV8KVDpfbVjryTq2AMCdwDCOZNvvRFcqZ4WgBYzfysfJ+93RT4A6DEn7WEbFvZpZG8/351UKNNcyVL3oWIZSfYp0GLOlTpX7kLcsvQTAuREj0eblkh1BvKcz+Vg1pZH4m82LXl0TzOD8vsUcdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-5d758dba570so406632137.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257480; x=1764862280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMGm1buzaIw6yaiLwd7+ag/+onuunyVRgfQz7fJY0H8=;
        b=ImnU7tFFnKWoYEUH3fy1lbCTKt3DtIJcPmBJZDeObnmHe/Y1ymFqGJChWAUecMkF9z
         xK1kb79addb1lfl/oCeb6Po7cz0Om1HD8spSY/EtEoYVRxTsFszos9snrGbXsE4NOGDr
         eEO5p01cESS3+FX9TEJgI1FOj9a/jm97RSZ6E9IvloNJp+MvyS/wxcgSsHVsjjepmhKS
         9Adz+xh/l6Kn7RUWJeXvrcfzdauywL2+Ky+Ja31ZtTiOyzKOEYXzRHfbL3zSl17hZOsD
         r9xlaJq4K/S0yPLbiFPnyfYO7Gi0MKkJ5ILBTH9iiVBTIhczg5/LQ/yK3wYVx0lZK6KF
         I/3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXyaXzwM/w/5BXz3CFAAS292Iy8iffkALMO3FBIdFlAvW5GsXD5Q+Igqxp+WRj55bHbAQhK/bKe/dE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIo2FLjZMESNP/weGFkNE3imV00vylXtbJz8xlWkTWA/pAJO3M
	CVYuJ86s9pUrthrj9lDgiBWXm78essatWKLvJgntU0qTIbcH6ZYM1vnFkEAyx6X8
X-Gm-Gg: ASbGnctdydxEcGfY3/IdF0E+l3Wkq9YUvDjr/nswwRC6/A/EG0VVnL95JzJun8myQme
	HAO3C13Tpcw5wgzp9sFzyR1D7piC/8Bvlkig6VfU53+RUmrCFNaWBSzZTvo9a6lPSFkmznhvNGg
	IOOaI2WlrvNz2KtmixeiVA/N8szOwnsX7zh55PE/FcY7XlFTrM6y4BJ72bhyW7i89o7LZ+ONedC
	k+MlCt2z1bL5sPdTLy5xeAN31Vqf0IwHTjuVKOF18vFyNn8bQKmFkt8mOPVbKBIj5gxfomuBhNp
	mmD1N10V4SG/kYI+UUMHy2sfL/V8yDPOY1DBc3cbVO+T6Qj/cLXsUs6gimLNQmt0EXU6N2HodwC
	562Wj3Wzr8tDdDYCpLXF+3+kWPBlUHJSkWVWFSWmT3Z+S6x5hT4JG2yuQURKEYXj+P7+HZyOqC+
	Xn6pWvEcSxPBOR27qFP+iyKPZs0/a8xbVwbpkruAHTVYrS2nii
X-Google-Smtp-Source: AGHT+IFPD5uEkelzfciCdmtuY62d+0dLFWIdlEAwRYYuwTtHKd2rPNmmbfVyOWJDW5vbBg3xWVC1SQ==
X-Received: by 2002:a05:6102:50a2:b0:5df:af0f:308e with SMTP id ada2fe7eead31-5e223f4ba7amr3850526137.0.1764257480426;
        Thu, 27 Nov 2025 07:31:20 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6e62cb4sm697527241.8.2025.11.27.07.31.19
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:31:19 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-93a9f700a8cso224157241.2
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:31:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjS0dJLLCecjsGjd0FZu0fuJewXyNgZOhS0ZOd2LTkYX4rq8J5MdgYdXkjfQ8R7T5WfdC4uZpIAk0=@vger.kernel.org
X-Received: by 2002:a05:6102:943:b0:5e1:ef48:271f with SMTP id
 ada2fe7eead31-5e2243b0ae6mr3428187137.24.1764257479536; Thu, 27 Nov 2025
 07:31:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-5-claudiu.beznea.uj@bp.renesas.com> <6hvsrtdxpm2ywwk7whaala3ynfdy4lo76epigxvn345ymormqf@bp3au24dwwud>
In-Reply-To: <6hvsrtdxpm2ywwk7whaala3ynfdy4lo76epigxvn345ymormqf@bp3au24dwwud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Nov 2025 16:31:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVgWcEFa+=XEQRTM4ZiJCBJnv6f8FD6CyKuO7cnB2QQcw@mail.gmail.com>
X-Gm-Features: AWmQ_bmuHs8omtOnus2gS0alfoG90XbZ5XLzzwu1zc-9nISSqEQTG2vuN7RDHuI
Message-ID: <CAMuHMdVgWcEFa+=XEQRTM4ZiJCBJnv6f8FD6CyKuO7cnB2QQcw@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe
 reference clock
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 06:54, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Wed, Nov 19, 2025 at 04:35:21PM +0200, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > Versa3 clock generator available on RZ/G3S SMARC Module provides the
> > reference clock for SoC PCIe interface. Update the device tree to reflect
> > this connection.
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thx, will queue in renesas-devel for v6.20.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

