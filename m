Return-Path: <linux-pci+bounces-4821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC287BDE4
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 14:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D3B20FCB
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9314B1E874;
	Thu, 14 Mar 2024 13:40:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF44691;
	Thu, 14 Mar 2024 13:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710423603; cv=none; b=ZbCul4Lq4evGdV6ogyV97ob0DIOcnzzglkS6XyvsbZKEjFKicP8NpNX2MhjK4L25l6TF60rgoW6n8vZHhlx2mVs0x9LamasCMLmjJTCkEl6FNTkoSQVnFYSvB3QTtv7pLR5kgXOsUZWUp6bSJp/l1wXP6/mythFNKRkF/Xd2msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710423603; c=relaxed/simple;
	bh=foU5bTr8/NI7LLEWH950dmktmJ4zIYJ5zCFNJwwzN6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKLWttTsh/Je5oyiwjYXmx0qpbUCR1ETwGlapeC0iz82aiVngQoGCZPV9GQq3y0/mzlF9qhyJtavYcXcZQpBDtYEV8XbhQmui8pD1rPwmvzWdWMvLaJiZJtR1H+vqjvo9AA2PydfYshMzPHzgIIJcxXJfGAFygOfog5Q1TbSNpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-60a046c5262so9797407b3.2;
        Thu, 14 Mar 2024 06:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710423600; x=1711028400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEVCgzaLqtEAvJhOeUEvPpJvusYSfAszA4qwCizVmJY=;
        b=b6iFstE4tAjavMswuaqveSZSxV/KKwQmGeo8lpO/9se+gZqPoK4/ksfXvj/nJTTdQy
         MtTu/qEbMnYPtNHEhLdOR06tcTQPL48mIybVjb0TJKLOjJErRkGxD8hgzrrtXlzUr9iB
         1i5waUe8r34N1c2HCgAkY4yr5lXToEBzf+hzSHa1pxqSMnXC0LFcC+TyyyTOXSFCHJT0
         4ajaD1tCGK96sSrsSPa9Vf0Dfol5GFb6r4DMElAFEtp2Cs29UcKzl2dMc/w2Tc1FdHng
         N/Repi9dpgRtrD1/BWcp4rlistTE9Pssqx6eagvQzEFvS9aVjJ4PdbNvzA4gQDm6eWMg
         l70Q==
X-Forwarded-Encrypted: i=1; AJvYcCXGsdJiy496CeLBgTiqyqFVglFY31v9a94Ecti+5289x2/HK7oVCjmnWohVrkpnHeAhzRFlIxUoTFmdxUKddRnuQhMhafVA52oDRJpRY5mltMa62+kDzodAdqMFPBrkosIOVycHFN1DURqr0ENPaGNc+fz/+qatgQGDtBMfBUz4wKNylRbETb5q
X-Gm-Message-State: AOJu0YwJuTcLLpQYf18BentIxzmLxupIk+0GKaYYkMIQisMPg7BBPpBE
	EVLl4GyBNwiuicRx93yxwr28oQIgzo6qdGSITIQtoQfB/Dfoj/MeVomlgaYD3/8=
X-Google-Smtp-Source: AGHT+IGU2g1g3MvDkWNyLd5qqXWq2i6aDsI5aAPhR8vpH0Jy3xul5n9yLzcZkj/gIb8LQbyyyc7jjA==
X-Received: by 2002:a0d:c9c6:0:b0:604:eb7f:30f4 with SMTP id l189-20020a0dc9c6000000b00604eb7f30f4mr1945708ywd.31.1710423600432;
        Thu, 14 Mar 2024 06:40:00 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id u65-20020a0deb44000000b0060cd58ad606sm33361ywe.70.2024.03.14.06.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:40:00 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso824883276.0;
        Thu, 14 Mar 2024 06:40:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVn8xVNeULiTWzowgOQGUJoKzq11vC7k17mVg76JE2OD6Pk0RJqPz1Woi0+cC7kzo8HESa48wP+lwaTvIAFp5q4SUfZMc9RVcWlIerSvFVQI4Hsj6G6TZRVLOr5TMV50xDCMV4cux8hNEPFSusmugGXFwwhBbslu7vXrINZTPrmO/Hx6ly7eqAk
X-Received: by 2002:a25:a264:0:b0:dcd:38f9:f78 with SMTP id
 b91-20020a25a264000000b00dcd38f90f78mr1587621ybi.29.1710423599773; Thu, 14
 Mar 2024 06:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com> <20240229120719.2553638-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240229120719.2553638-3-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2024 14:39:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXVm5SgAtKwHbiX5+wN2K61ntO87-tpGPbqj6HuAt=zcA@mail.gmail.com>
Message-ID: <CAMuHMdXVm5SgAtKwHbiX5+wN2K61ntO87-tpGPbqj6HuAt=zcA@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4H compatible
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, mani@kernel.org, marek.vasut+renesas@gmail.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:07=E2=80=AFPM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document bindings for R-Car V4H (R8A779G0) PCIe endpoint module.
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

