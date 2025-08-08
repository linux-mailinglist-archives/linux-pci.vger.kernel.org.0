Return-Path: <linux-pci+bounces-33630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27491B1E79F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6DE563E84
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE2275853;
	Fri,  8 Aug 2025 11:45:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE2273D9B;
	Fri,  8 Aug 2025 11:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754653525; cv=none; b=nwPGnyTUpl3j5Ry1b1VvGGGER1JwZ9WzCjVcZ6fHSCF7bhrSbBYtW/xrVr7F5NUshZdZp/0MkuuQAa54+LP+lzGHjD2vb8gsaVOVtWXwH+R59mAUOebxq9eOyHEDxPeQpB2Wu6XCdKe92l+X1fAMVUoMKUHNFUGrGyjYPdKXxkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754653525; c=relaxed/simple;
	bh=WBYg6Ly46TKn9kNUQszvbhlGgnkk5kuSW6Ll2fRZeXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AprMYmWtQvrPEWel5o8IJzTDyc1ZaoQKTEmEpDTX+BTHPE/6HgtagT9LcTnkKRYqn8IKyzkP6p1ahuSGexyU+VnoFBJIj2Phd9Kc9biUsOm/8tQ0yeut+HGtMv1jrpVLMGXmmHNmJvhiUSAYd+Eu6HTtrJjRkfqqF6pR3MiAbTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-53944f65481so658467e0c.2;
        Fri, 08 Aug 2025 04:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754653523; x=1755258323;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxO/wb5SjqYKhirNQ57pk715Lm2Z0cnx8YRmXgpwJPM=;
        b=Ci7XEkuDP9MarVNZuGjXPQj9c0b5SjZPUu0GoJXfzoOWDvKu357jOFCgy4c7TGT4jD
         XVsj39/qUsuAIWzJnlofoNEc+EYkzMPHMkVqkPmOgoUmMgYvm1Prmgd5TkSR9ueMX2MT
         2jNEvhzD+HHjfKcAS0FLiffhMjm82RrzKMrMT3ZqqKhJY8vdV9sTkvNUsrV57gWuINEg
         9IPZfFf7PTI6ddpM6EwDgOX2K9h2DerEIMQgD+jvzIq1UFJwJAPh3iKWq7ywQd4w3gvp
         LByJKTrkRA03urGj5IP3FGA82AIj9QutlmGDzYdkCOp5BJCRqjFjP+U+JTN7l7bU6ys4
         iq4w==
X-Forwarded-Encrypted: i=1; AJvYcCVRJEIJfwpklynRxSTxOaLUatumKFRoQPQBHOQqWFkjlSRQ2VDQcPLw9MBT/Y0ZtOBuluwRD/oKnqgA3qV5@vger.kernel.org, AJvYcCVcBczF0vys6zeULq0p+qnRzNFFOjV86INX+RAGe3OOxbJIbPWEFDSGPMP+EC81CGMk7YExqOxHWe15yJEiZTBINAo=@vger.kernel.org, AJvYcCViDx5AQxtKwz+n6urLffiKsawGQfVG+d+v/KsSrZEOIrENBFiOdjyV/vi3n0LNgfhuGCDeFLiPfJYK@vger.kernel.org, AJvYcCWwbZ52ZO77bT7RQ2hiFLrEM0NpgYR48q3Ew0oUzbkMg0pNqzmpbpmbOAxQvlMTpApzYF0NWosj/ZwU@vger.kernel.org, AJvYcCXGmFyREXJVBhJT/cwqmuuGzmJ9Dmg1SRReOp6j9F3rg28/ekB9aMqnmoQKHI3Qv/a9ocsDF36OsTS+@vger.kernel.org
X-Gm-Message-State: AOJu0YwW850hnkVGJGGprP56MRNAAFw6SRNiQ1Wb73480xOGMKOmrk3j
	82D9gO4QzAb7gWupJFzuhEYlzoaM5EBxs+p4LdBtwAXf2K5rolGvxoNSevnjE3ae
X-Gm-Gg: ASbGncvvlTGNsZwA298jAK6fJcRvgmvMlgBc8oG4X893HNjyE+goKKn+eOWoTjMeNjY
	/nbbgJkcq14pqVo2X/cYFdgrCAmrPPlkjLrr6sFWnkRE8zlf0kaW2Jpl6w0tY8x8zgjK702GjQM
	yrg2FYys8jNoedQKwKnWBBxnxUDOamGQWZGfj/3PsQVT4b1ABEh3aiv+FkFNJEdFlDgch5cyJrd
	IdpiFZq3EI/fkSip3MssI6uOodc6gtCgNf1PXcY+KkQYU4q0aOMK1GC3qnadYNZlKQzeiPaW1LA
	TEnLU7Gss7B1kjRRLH9+cMpGTARqBVhtPI3jYquswK+GE3/x8kYDgGY0u9C3uWym/240fo1T+8+
	NP4S/euYxTswAgs+DNude74LgFaFzPDo/3/k/2UbqOUQ11HUJYn91zDNh0MgE
X-Google-Smtp-Source: AGHT+IHBm8/EhEZtraF6A4Q/6qmzcdQI2gDgwOqaPrnwSVO+QmnX5oleXYC68/yzuyfi8/OyE85M5w==
X-Received: by 2002:a05:6122:1acb:b0:530:5996:63a2 with SMTP id 71dfb90a1353d-53a52eb02d9mr820826e0c.7.1754653522656;
        Fri, 08 Aug 2025 04:45:22 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-539b018968asm1032185e0c.3.2025.08.08.04.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 04:45:22 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-504dd871d70so647452137.0;
        Fri, 08 Aug 2025 04:45:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgs8NBwzJpVWKDN1AkBLX6PNxnpd0F/dSRk7fh0N0GtWlTx27zglnyf+jAQomk/z19vTyTBqvwQskbk0mO4d2SA0A=@vger.kernel.org, AJvYcCVqJ8s7JBgmVIs0XTIK3KgSc7LG2v+5Bf5TpPRyMX0qzml4AugmwSZfJeF5Oxzco+VYrNnMgiVWj8LVBl2R@vger.kernel.org, AJvYcCW5/siLmiC0TFpwsPufqpH1Es6c3MexWx8N5YoKL2fhqt2bJnwGy6B68lKZPZcOvcROMcfeDwrZ8toJ@vger.kernel.org, AJvYcCXSHciOpWspGB38ii7336FVI6PoUUT7D7HSvHEesWsc6wOncI+O9G27VHBfY9Odb3YD+AnRH0DDFl0A@vger.kernel.org, AJvYcCXXkJ3ob2750dHd1Fazyeia+Q9a2/Zehl8A2qiaYS1SLsMvok4h6TKBZ3S4YsiDWw52w2vaq2FvGXd4@vger.kernel.org
X-Received: by 2002:a05:6102:5ccc:b0:4cb:5d6c:9946 with SMTP id
 ada2fe7eead31-5060d2a74damr861831137.10.1754653521602; Fri, 08 Aug 2025
 04:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-8-claudiu.beznea.uj@bp.renesas.com>
 <TY3PR01MB113464920ECAC2C3CB89DE2D5864FA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <7c8c7a25-c373-452a-9fe8-8b2d92ddd885@tuxon.dev> <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB113467C09DF7D3D0D7833A6598649A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Aug 2025 13:45:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXmOaMo-2JfMmi7fOJxpVhL86U4PsWewrjk1z6hX6agaw@mail.gmail.com>
X-Gm-Features: Ac12FXz7HpF5HU5dBXnxnL240s782w9rEqQwz4F0XZ8wdldivob67uVHXOAVnQM
Message-ID: <CAMuHMdXmOaMo-2JfMmi7fOJxpVhL86U4PsWewrjk1z6hX6agaw@mail.gmail.com>
Subject: Re: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
 dma-ranges for PCIe
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "Claudiu.Beznea" <claudiu.beznea@tuxon.dev>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"geert+renesas@glider.be" <geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, 
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, 
	"mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, 
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "lizhi.hou@amd.com" <lizhi.hou@amd.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Jul 2025 at 07:05, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> > On 07.07.2025 11:18, Biju Das wrote:
> > >> From: Claudiu <claudiu.beznea@tuxon.dev>
> > >> Sent: 04 July 2025 17:14
> > >> Subject: [PATCH v3 7/9] arm64: dts: renesas: rzg3s-smarc-som: Update
> > >> dma-ranges for PCIe
> > >>
> > >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > >>
> > >> The first 128MB of memory is reserved on this board for secure area.
> > >> Update the PCIe dma-ranges property to reflect this.
> > >
> > > I see R-Car PCIe dma-ranges[1] and [2] maps all possible DDR area supported by the SoC?
> > > Do we need to make board specific as well there?
> >
> > I'm not familiar with R-Car, but if there are ranges reserved for other purposes, I think we should
> > reflect it in board specific device trees.
>
> Already Linux has this DDR info[1]. Linux provides DMA memory only from this region.
>
> In your testing, have you faced any issue like system allocated DMA region other than [1]
> and you don't want to use it, then the changes are ok??

Exactly.  PCI memory must be located in the intersection of
dma-ranges in r9a08g045s33.dtsi and the various memory nodes in
rzg3s-smarc-som.dtsi.  The latter already excludes the secure area.

> Not sure, PCIe can work on internal memory such as SRAM?

If that is the case, it should be reflected in r9a08g045s33.dtsi.

> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi?h=next-20250708#n31

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

