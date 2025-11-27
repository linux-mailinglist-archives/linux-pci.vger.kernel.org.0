Return-Path: <linux-pci+bounces-42211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0211AC8F461
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 16:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F2A744E21B0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 15:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62F230BD9;
	Thu, 27 Nov 2025 15:30:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA6E336ED6
	for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764257439; cv=none; b=I4n9d7t2ZSd1BlmDscqSDaJiKldH6RNlxQWjYSD+4zAqHU2NExMTYn2PAYH7eQCrtZOM1TvKoc4uVHDqGar5yiqPHdx7n0zdPHPmJxEAlYy52ll/6gwryfpqVHA0r7AV3+zirt3XLPnRMB4gfSyoy8KlpCAv+VNTJJ+AxeYxhXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764257439; c=relaxed/simple;
	bh=4/tUrL7XhTX2DALHlvFkiLf3U7EgVhD8OVH3jfZBq/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSDjXfxoFgdYuYTVgj//rTZm43nzQpY5iG3dg6ab2B8iBP/N5ICTOiabGjYBOH1/1C2cUF7ZpbfEg33gIgMJ/deeluPmClGGrARXrcgclxhrxRoIvDn1IVbYNAF8xIhd66WaciPWH76HsPXWBUJ49zMsSHCgcXpF1IGye33/JCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so615843e0c.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:30:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764257436; x=1764862236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8yl7Z3fG1uBR+uZ4dtJjq9rOuGFg7ujtUeNUk7sXRY=;
        b=bXXMlX8CZQcmFIiTXoAYXFkolysn08m6YUloriTZx5mPmKUGOEF50UgnsDO3+fX5kh
         mHXyXtFohe9pvCpDNQHT0xYgy/J3Qk2bWlXsDbL0gZElbrtVsQZiOi2TxWFPBQU6fyWZ
         eu0zyawsrJ5LTzKVgqPLmxz1wc4OkqQiPIOQsxHOmMQOnhpf/TJ9Pnlz0fZLnjtfrZMx
         sE3RP9tRsKDE2EuSqoUWpVtZRB6KJIhS2ycijVsKDE291ex6n7MDMFqHDQkI/tBQFy22
         5lvtx9f6uWWV4Oiiolnk7gFGVBiFRtmcOuNECrFVC2mvNyrowNJFOvkcl9/bJ2tPJRfN
         BQWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHdu2ESJk1I7CpKymCcZeJoP8mLvjr7EQB0vZ+cyMOz3o05Ptl7Tmu5g45tb5NIKozhGeEXudobu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq1hzuT0jeZ6rKw6kjAOiC6VL0T/iLwm1eWc4P4aDoH/A0x/wH
	XvK3lGAfxytHaq8UyZJLjxhWKyxfW/VfbIjz7rIg7B5jEutm+y5EfEGztkGwQL5p
X-Gm-Gg: ASbGnctWLxROrRDFKasZcBeECf7m0iBfnn1KWvXr5NEwxOCizFx9s4nOxr0CQuPPpBJ
	fqI8JCWsBqQtGL3mTRa43iMGiEuLCoXRUQlEm/kQGTDdP4T5ir1WTqnK0hbGE+IyakZQwu0aate
	n37O/ESrmJOtegqW/qE7h9C38QA9HSfWWUuNfBpbVCwcBRZXbKB+ll4QlQcv7XutnPktGyVxAFF
	iY8W4yGkWU5RUP4rQiCAnHIO1QEWPY1T46BvxkPTYOitzy6gwXNziq0qoN0a8XLGw2jMqnsxmTW
	44CUu0SzJXqsC3NhqqPpkCJ3kzPUJ1aacIBMBrO1D2rskWQ/Zzts0+UfBeXiuVTPnK0kPnW53HV
	wwex05dXHrZXncChF+IO88HOQcIkFE2PIyaLyF2OtpSAF0DmsRdMevBYKgE6rENCpkMixEuxbcH
	D57XTHwj5c/PLlu9R1swaUA3Cs7HN6i8dDd4byudhXvOdaCj3p
X-Google-Smtp-Source: AGHT+IFikx3N5NkXGdKvm+HANAHEU9L1X8KcWj0D5znAYqLNTV4gYsHYwxZxQWWkfcpxCD/LxzSoIQ==
X-Received: by 2002:a05:6122:8007:b0:55b:9bf6:da7d with SMTP id 71dfb90a1353d-55b9bf6db38mr6076102e0c.2.1764257435994;
        Thu, 27 Nov 2025 07:30:35 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf5141678sm678194e0c.13.2025.11.27.07.30.35
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 07:30:35 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-93539c5e2b5so564040241.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Nov 2025 07:30:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXN22NWt8poSM6QldYvoQC/GHFwIuk88Jt6MH2ubtZqONuv8SwukWeVqy8xfVPmhD/6w8rB4aHFkw4=@vger.kernel.org
X-Received: by 2002:a05:6102:6a96:b0:5db:e2f8:cf35 with SMTP id
 ada2fe7eead31-5e1c3bb9727mr11967961137.3.1764257435486; Thu, 27 Nov 2025
 07:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-4-claudiu.beznea.uj@bp.renesas.com> <2gumxdloes2zpzbyfmva2vhibxzevk2bqspj5ufl4pldrnyzkh@bhcvz5g6kka5>
In-Reply-To: <2gumxdloes2zpzbyfmva2vhibxzevk2bqspj5ufl4pldrnyzkh@bhcvz5g6kka5>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Nov 2025 16:30:24 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUPnJUFT86j8JrmintS0Uxsopn2xp5DhqaodE7tcvt6XA@mail.gmail.com>
X-Gm-Features: AWmQ_blf9gCFJkJVJH4m5BOzOxhNSZcQ6HkuvGQZnhOH5OXCRl3qaE50jdnbaQ8
Message-ID: <CAMuHMdUPnJUFT86j8JrmintS0Uxsopn2xp5DhqaodE7tcvt6XA@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] arm64: dts: renesas: r9a08g045: Add PCIe node
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

On Tue, 25 Nov 2025 at 06:53, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Wed, Nov 19, 2025 at 04:35:20PM +0200, Claudiu wrote:
> > From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > The RZ/G3S SoC has a variant (R9A08G045S33) which supports PCIe. Add the
> > PCIe node.
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

