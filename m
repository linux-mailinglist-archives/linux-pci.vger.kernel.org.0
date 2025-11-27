Return-Path: <linux-pci+bounces-42216-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2773BC8F4C4
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C75234418F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1775D336ED2;
	Thu, 27 Nov 2025 15:31:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5ED336ED1
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257507; cv=none; b=ioJt6eZcYGNeIhpKz1fmEBuf9vsMoqhgBfxGlei36V7X/8VhZ3FgoRQJ4xFllVfQrx4YJeilSYsADFQrEyYQZRFkSmx7IwfnkALmFF2VLU3OV6XbO6EsiaOZDydIKUTGegRe/6s0oMxHOlmggeA8W0THW7Gqn3Fcd30+/v9TfXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257507; c=relaxed/simple;
	bh=5LssjHCBdyOYX00Kp42YDjZkb/QKpvt2mnLjPvJZhgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUJ0iWF/SGc4uxWpvSPrYY21bAiPqWMYZHe3Hwh9Gp7y1soavRTV4zcAV/EAtK2A14eav0iHdn8lgD6wQT+A88GCrNNaEdk/wmNKTRBxVv39ignOMo/FhyAYs1+0XWu/Lacrwk2UyM8Wpd2YKMqY9nrLu/1/lUsnzWjGjHJ/+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-5dbd8bb36fcso789445137.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:31:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257504; x=1764862304;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reaaXQppM7aTNDTI1IEDn8WDBg5CASf/0DVLYYtxHDY=;
        b=rS9cRJiEKSfoAhoDzJh/vc1s4S4wB75HhFDPWWuQZQC7D7A9QCY116iYGnP/cfMMcp
         Aeg4CaXgcVEWhGZ5rzXElAWMLxtJAh8b4Of3b689stv8hieKC6njT7wccWGgI16nugU3
         OIIv4LG3d5mYkJgYqboZ7JYw90v7TzwAkVQinNOFxIhLPowtkJWrH8Dlfg2aOF3lAWFl
         2b3ggh7TGIS9im9RpXhFCC1oMkpAz8eqH0dTnLigzocgacT2WDEY94pitSpFWNHa9EgP
         M8SWBOphtV6pURR8VzMZ6j+Jub24Tf1mT0gthsIWr8q/HlaHD+IHxiwEICnrmv2Jx4s1
         f61g==
X-Forwarded-Encrypted: i=1; AJvYcCUJkGHpKXsRyj/v9pflg9VoDZlVUpoZ+jyNxV62qJyjWz4pL+RQj2HF/FOtukhg7oGEOiKvmP/zn4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdMfy+mt5G/mnflDonn8WgSk+DzHEuHejZozPeSGsp+ayE4Tlg
	AB2znIs1FpNnHo3GElEkcK2F+QJtaHtcQyXlPXEnUNXjVbauePtj8+jaSB1KheYp
X-Gm-Gg: ASbGncusif/s/rHR5F+iYbuwHDMtPhlQvbzcaQTTfxxdVcjyfjJ5q/5V34ef0Q5OoEg
	7Z+T0O+V69y5jqf7fNj/haKkLeWpNUcZHVIAm1NBRgrOOEmi8kjaLDeKDm5T4hIUfDYHGUaU+m/
	K6AxH2Edt+RfrzDHvxhZRskwfAFe5LbgJRh6xuZUPI36xG8zu/9I8+08LjZb8lFJ8krZKG/Kp21
	wpBTbH3ypNAoMDLkT5l6LaAlhi5NPuiIwxdATuwSHd1PJTf8QacKBGweaslMbFeUKHaFvmMUPLR
	8xDPHTP9LdudLOdh0adsFEGPcpAldC5++FhLCDvwYXLyd7b1IjJFygQZv5RdygTQyD4Ph02opPR
	wGddb3DgPtv8bcmf3ZD9bpbSgDCwBYSuO9ab/SZi1xUwTeMaN6Yu1AKFbRiT16MHMvnZRcfuABf
	LEYHXlqeQunsWQPOOdKhXUte+n51TbuP8lbSPdxIO8e9IvWmnThXZGUyvnG1w=
X-Google-Smtp-Source: AGHT+IH0C+ZRbc1xKV7RVEKx54UFYFFE7opLd5MFz2mOjksbxKtk3kPaGhmKO2TqaBo9cMvLe3htvw==
X-Received: by 2002:a05:6102:a49:b0:5db:f276:37a6 with SMTP id ada2fe7eead31-5e1dcd21850mr9030025137.8.1764257503941;
        Thu, 27 Nov 2025 07:31:43 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93cd6c6806esm703848241.1.2025.11.27.07.31.42
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:31:43 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so564659241.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:31:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUwAjrRJS+RT2VZSlaEjb9KJ1hS6Rwlztj+H6XT+cZwFSjnG0D4WypeWP/jkeMn/KoXvyDgn6Fsw2k=@vger.kernel.org
X-Received: by 2002:a05:6102:4b84:b0:5db:1e4e:6b04 with SMTP id
 ada2fe7eead31-5e1dcfac0a0mr9944783137.18.1764257502521; Thu, 27 Nov 2025
 07:31:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-6-claudiu.beznea.uj@bp.renesas.com> <vrtz6pumfpjyis5sez7iia37yyruizl2wz3vb4ojafww5hrjev@pmy5uiknetre>
In-Reply-To: <vrtz6pumfpjyis5sez7iia37yyruizl2wz3vb4ojafww5hrjev@pmy5uiknetre>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Nov 2025 16:31:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXSd1Bn0zU+nY8FW4XZQMeLyLQoNSdc6PdcFLq-7xVcqg@mail.gmail.com>
X-Gm-Features: AWmQ_bmQYBZvVFdH1jgBs9beHkHsNQ4PypBPAGFdHNRMUEACr9V2X_70026RVXA
Message-ID: <CAMuHMdXSd1Bn0zU+nY8FW4XZQMeLyLQoNSdc6PdcFLq-7xVcqg@mail.gmail.com>
Subject: Re: [PATCH v8 5/6] arm64: dts: renesas: rzg3s-smarc: Enable PCIe
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Claudiu <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com, 
	p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 at 06:55, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Wed, Nov 19, 2025 at 04:35:22PM +0200, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The RZ Smarc Carrier-II board has PCIe headers mounted on it. Enable PCIe
> > support.
> >
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
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

