Return-Path: <linux-pci+bounces-4820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC60B87BDDF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 14:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DC46B20E06
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 13:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34F59168;
	Thu, 14 Mar 2024 13:39:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48F94691;
	Thu, 14 Mar 2024 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423581; cv=none; b=kuYrZfmgnVtWYtoK6ZqPWxdHvlNx430gGLLncekB0/IvzrJw2jI4lEHOydGtZXXEy+42c/Dkexh+IrXBXCfYmt6UcKe9givSLpBLFLiv4iS9sbXjy0FQrlLEiYwzDYpjmI5/Hq4AKNjIdaesAH3fejOT+vaPNX6fWsMpQDOVwow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423581; c=relaxed/simple;
	bh=62bZHF9vxKaZTjbLz1C228V+7eZtAI2IjBIOgTxAJ4Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/P6PFk3VXGscfLJzV1B9K+63KfUwitW+aoruaYtoIPamZ/y47JLjXYp721zXUv/GTgH8xWj7Giwp7wx5qKZooov3JZmkKOgehw2is7S0Dmqij1vWft8apExiA7GaPYCvo+0tQ2MMBw8a3d+eX/YsftuIOxXFp2C5HZ2IVwVsPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a0a1bd04eso10704537b3.1;
        Thu, 14 Mar 2024 06:39:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710423577; x=1711028377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vnp7xMYV1yB90s/lAAUhIyi8Fm75SLbVfVCN35lpvaA=;
        b=sOGI99KIRUA5LN7jH+gnSwYWiPzSeVT+9MMtekj9gqxFwVTv88nYGIp98u5nZQA16S
         k9yjQCFRljIY6BZsuQ0fhlyowKhVqhpbRtRiDLmZdN3cS7A2YD9wo+9vdBKEbF/rr2SN
         CiLQ8HPOW/9Lk7SRMegHK4wc143QwW0yE8yuRsvvuFn/C+6SpQ/6bvwwsfw3cn6q3xjX
         7uq5Iz0CFMZxyjFEbfNf5K0cvkbsckLPlTEsI13Md6Th0Zx4iRuSP2HeCBvFXFAMHKbh
         iY28jB2ejNVcW/nZNhgX20KKI3wFlhzA0x/CXVCPrVdO6usEgzEXBwZdiIm9YtrRYRF9
         UV3A==
X-Forwarded-Encrypted: i=1; AJvYcCWC34y0xHtLMe9xTkeld7B1zueXS2QgFZmk4JK+L/uVICBBvQJgh66kLSJh2EX8FQrxStkQ0583gfk+oWgGZxvd/c/bhZSLYV5GZlTD6gqob5V6OlTRGFB2795UUpx8n7z70W/BveSXdzN0DwSI9mJ134YiH519Og6m7xS4d03LTCXVlJxC8/tC
X-Gm-Message-State: AOJu0Yzppp7j7UAuNRm1Mw/uqpef7mds8XRipOOPbjRSgorq5We37EVS
	n/NgENhiP4lVSU1uonS+1K3ijrokTdPFoKdCQllLzJnxjGQDXMPLzzF4rXneKRg=
X-Google-Smtp-Source: AGHT+IGP4vhktbwcK3XVZSFip+D8iXku4IzBtZZVmrM00fNFDKflBVt66ep3HdeG6/jbwlZbgNHitQ==
X-Received: by 2002:a0d:e8ca:0:b0:60c:bc77:9ba0 with SMTP id r193-20020a0de8ca000000b0060cbc779ba0mr823444ywe.40.1710423577246;
        Thu, 14 Mar 2024 06:39:37 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id l5-20020a814005000000b0060784b3bba8sm269209ywn.35.2024.03.14.06.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:39:36 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc238cb1b17so911997276.0;
        Thu, 14 Mar 2024 06:39:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWjvHZCOyc2z8pJ8zIZCYlbN3fB0xaMByVkd3H1jKya2SuE8GOR2MOKqC/ZrxuN+OyFBH4Z30AnevozX5nxvEiTCtWp35k6j4kJrDBVQudwi/tTsM/3tZk/7nilcIitWOE966TyKhqHsnaaeHihrp2ptT7JBunu2njHMCN1D3gsLkce6cDkP3EC
X-Received: by 2002:a25:aa29:0:b0:dcd:72f7:15b8 with SMTP id
 s38-20020a25aa29000000b00dcd72f715b8mr1764734ybi.11.1710423575899; Thu, 14
 Mar 2024 06:39:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com> <20240229120719.2553638-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240229120719.2553638-2-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 14:39:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4s8+4qaapci+FBwWfh8E4RkHadziV9HgWjGYoHCihFw@mail.gmail.com>
Message-ID: <CAMuHMdX4s8+4qaapci+FBwWfh8E4RkHadziV9HgWjGYoHCihFw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4H compatible
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, mani@kernel.org, marek.vasut+renesas@gmail.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:08=E2=80=AFPM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for R-Car V4H (R8A779G0) PCIe host module.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

