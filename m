Return-Path: <linux-pci+bounces-33632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0484B1E7EE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 14:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FBA47A2717
	for <lists+linux-pci@lfdr.de>; Fri,  8 Aug 2025 12:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E9026658F;
	Fri,  8 Aug 2025 12:04:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378B01DED4A;
	Fri,  8 Aug 2025 12:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754654648; cv=none; b=GzF0XC+Uc8/NokgtjOYChXlOBXcvMa6DRuw1MEDrIAReq5sDGbV78znZVPUsJGwLZFOtYTwUfj3pG/A5ENMtOqnTe/QOnJS5lGMjEy+taBlSf0TVP4EcAkETWBFxxndv8l5nZ6XykelEb99bjyOy48ZVMWylRLpgmJFQH6jAXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754654648; c=relaxed/simple;
	bh=7I705A2rjEbkZh1s5xJhalzN1XVTGWCWQjPtJ+3xe5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGRAG41m0Kqgmvgr2eJ7rkZ2CVB7lyjv+QIvJ+5H93ixZ5LS7ulo+RscBdZbrz/gQzeWfw6w5dMM8jAAZa8fvSoewUpuwjjUJ7wQpR/eWVM6GACEy3qTw4ugmANRDo6tL0slgSuBQA9taYk39flq+49iatmcEnz2F8zhMIM0SUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4fc10abc179so1401243137.3;
        Fri, 08 Aug 2025 05:04:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754654646; x=1755259446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CItPX3Nziwspy+DUPcMmH1OYCckJOPZ1VMD2rIXFTYo=;
        b=AFfIZFWlP+xnwoMyKkPgAvhAjIiSJFZ9H8f9qmQClgHmXWozeM3y0mUtI4S6QA2fA7
         2RhpkamUuHlEGDB9VeoQ6wIWrpDc8KqSXC3c7Du5OkQF0SzkVdwTSBW+wpwrv1kgxYFP
         Gkt97+u9mwWV0hB08LMbPAaFw90dViHW6pBSgvZg47ykt5zwFtutfSXDUScs5vvRyB+k
         vD23DBOquBVX1PBrEZupe5Hc2Ng/as2gbCXTo1vmrqxePp4U8W1SS7T8rKP33ufcVMaR
         xpuqAqoALRIOcX1v+eCMvbtqklkzK+31EVM/wE2bXNAa0Tc/Isu0Q9dTBzDEOTUjKrsO
         5SfA==
X-Forwarded-Encrypted: i=1; AJvYcCVrPb/4IBr39pW2C9fRsbpqiong0NtIakoBoc6x/DiSToXgswvWME6I1hhc28EBXn6bnt8MGu0Fu6/tYdVE6ZmunH0=@vger.kernel.org, AJvYcCWXvs6b2t31m26Tz/AG4Caf5c2u5uY7TVHpq7NmchV+OJmEGHCycPci0Y8JJ+rER9FvMmJb4KRQc1g4@vger.kernel.org, AJvYcCXU0cu4DjCQR3glNa1fO3ICWVAM/+LiEN7VxE8Rnxqhhp8/cG32H+XFl/pwz9tDG5Z16EZiHvHxJdh2@vger.kernel.org, AJvYcCXeQYKPP0eYQcnjg13Wahw6hNX+6BSriwoQl3KUrC3HnTb5hvmi5psQ1S2C2gLWOdvuIIBszVmpFx/F@vger.kernel.org, AJvYcCXm9b6ZMxhiyJLbaiScuaflyjbZunWAY2sE7WGZayYvrXo6Zl/MQp5MMcm8gxgwr3HoL2v2FZ5t3TpFz8O9@vger.kernel.org
X-Gm-Message-State: AOJu0YzJU7P16l2kV408/glsM43y4LdJY23gryOsIGu7+oIhC/k/yih8
	7pp54a3crK0l5c7obfoX+fEnGKI2SEZSTZjIEu351EMP/SUU0vj33kjRF1WzVtHg
X-Gm-Gg: ASbGncuK8/f4aYXIhy2Qk+mph3Zrvqr1rg9YSkhztzrA1z4Q4uEoX6fMFCP9f+vdual
	1iLOUwS8HvVetrUkgtgDLEDzWbTHNSb5I9RED3wCTvSvY3Zsjk5NLc+4ZGowx7Bo8+IxS/+SYWc
	KAvGZyIWpfJWR6pDzrsys6qVShuegCRel/Wq6xxXp8WQjB+LMzjiqV2XonetLe3kIfhBnI5ZGUN
	maLtdtOqCDPwTqpCP/gDajmZYyUQeStN3CBYCs0cbAUFCaTqUZvAxfZnyeHwnpU8poJZpUxRFy5
	per9A+YHvjgsBGomsAIt375RmXERN9XGZt8yTTVNz9T6q3PcVSTffbUjM8cy6XRGHBjn1FNPw8P
	J+ThSjm3lO+96znRMJN2d+6D/kbkySeFYf66AtYnuo9PiSyYsi3wuNTJQx1eG
X-Google-Smtp-Source: AGHT+IHgiuZeffo98aCoUXOZpexzc1b5rd8j4hiUiFmZzm9YSRS/saZh49KNvVQiqKng0ugLNuEYTQ==
X-Received: by 2002:a05:6102:508a:b0:4e5:ade7:eb7c with SMTP id ada2fe7eead31-5060d4a71d5mr1024625137.12.1754654645670;
        Fri, 08 Aug 2025 05:04:05 -0700 (PDT)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-506290ef371sm314407137.5.2025.08.08.05.04.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 05:04:05 -0700 (PDT)
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-50307b67169so1707076137.1;
        Fri, 08 Aug 2025 05:04:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUJOmr/bSpucsYDmPtIj5BMgnv1BYj40K4jIYCpArWRauF/fxDu6gRsx51gxHlWqXCedJkgEkNyv3/LUrI3@vger.kernel.org, AJvYcCUdsmSwV5UurRyJjuooCCl1mPDvRiahxqNffUusOlFZ1BhLlxTYWzclQupE4HSyddhbDnZu5f0olRFE@vger.kernel.org, AJvYcCV+T/I0BUNntHWtEhgeH5GheZ7wumr4uTN4LyD9XxWletLTQskMtGyL2K77WVY1wvyeMKSCEp0JxeaF@vger.kernel.org, AJvYcCWOJ5zaR+1BusaAuih1DL9xdLZfJpgszeIood06B6XwYG3Dns4TSFXoAowfA+8jzme9aUjbDfl8Y6DMV1Irn+4c0vg=@vger.kernel.org, AJvYcCX9We9JB1eznnnf+E+CVAHs3Ef9ih/2KwG4rlrFBmvZfnG6mkN7U5R9rUthvNOyrzrMwQHnj2bZRx8O@vger.kernel.org
X-Received: by 2002:a05:6102:c89:b0:4fb:df6d:61e9 with SMTP id
 ada2fe7eead31-5060cc8f424mr967777137.1.1754654644981; Fri, 08 Aug 2025
 05:04:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709132449.GA2193594@bhelgaas> <2e0d815a-774a-4e31-92f1-71e0772294c7@kernel.org>
 <0addc570-a3c6-4d7e-9cbd-06eedd2447bb@tuxon.dev>
In-Reply-To: <0addc570-a3c6-4d7e-9cbd-06eedd2447bb@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 8 Aug 2025 14:03:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVS7VRBj3Neh7P1FDfaG7uPfpny4tFsDTk6tsmiYu3S+g@mail.gmail.com>
X-Gm-Features: Ac12FXxvhlSsjlxIyp9wLVrjxx1brBJSnSBO2bel6v02fDMzhy9BrWS7nxQ7HtU
Message-ID: <CAMuHMdVS7VRBj3Neh7P1FDfaG7uPfpny4tFsDTk6tsmiYu3S+g@mail.gmail.com>
Subject: Re: [PATCH v3 4/9] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add
 documentation for the PCIe IP on Renesas RZ/G3S
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, bhelgaas@google.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, catalin.marinas@arm.com, 
	will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Fri, 8 Aug 2025 at 13:44, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 09.07.2025 16:43, Krzysztof Kozlowski wrote:
> > On 09/07/2025 15:24, Bjorn Helgaas wrote:
> >> On Wed, Jul 09, 2025 at 08:47:05AM +0200, Krzysztof Kozlowski wrote:
> >>> On 08/07/2025 18:34, Bjorn Helgaas wrote:
> >>>> On Fri, Jul 04, 2025 at 07:14:04PM +0300, Claudiu wrote:
> >>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>>>>
> >>>>> The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
> >>>>> Base Specification 4.0. It is designed for root complex applications and
> >>>>> features a single-lane (x1) implementation. Add documentation for it.
> >>>>
> >>>>> +++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
> >>>>
> >>>> The "r9a08g045s33" in the filename seems oddly specific.  Does it
> >>>> leave room for descendants of the current chip that will inevitably be
> >>>> added in the future?  Most bindings are named with a fairly generic
> >>>> family name, e.g., "fsl,layerscape", "hisilicon,kirin", "intel,
> >>>> keembay", "samsung,exynos", etc.
> >>>>
> >>>
> >>> Bindings should be named by compatible, not in a generic way, so name is
> >>> correct. It can always grow with new compatibles even if name matches
> >>> old one, it's not a problem.
> >>
> >> Ok, thanks!
> >>
> >> I guess that means I'm casting shade on the "r9a08g045s33" compatible.
> >> I suppose it means something to somebody.
> >
> > Well, I hope it matches the name of the SoC, from which the compatible
> > should come :)
>
> The r9a08g45s33 is the part number of a device from the RZ/G3S group. This
> particular device from RZ/G3S group supports PCIe.
>
> In the RZ/G3S group there are more SoC variants (each with its own part
> number). Not all support PCIe. To differentiate b/w PCIe and non-PCIe
> variants it has been chosen to use the full part number here.
>
> The available RZ/G3S part numbers are listed in Table 1.1 Product Lineup at [1]
>
> (The following steps should be followed to access the manual:
> 1/ Click the "User Manual" button
> 2/ Click "Confirm"; this will start downloading an archive
> 3/ Open the downloaded archive
> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> 5/ Open the file r01uh1014ej*-rzg3s.pdf)
>
> We use a similar compatible scheme in other drivers.
>
> Geert, I may be wrong. Please correct me otherwise, as I don't have the
> full picture of this.
>
> Maybe, the other variant would be to use "renesas,rzg3s-pcie", or maybe a
> more generic one "renesas,rz-pcie" (though I think this last one is too
> generic).

Both would be too generic for the myriad of RZ devices.

AFAIU, the R9A08G045Sxx variants are really the same SoC, with some
hardware modules disabled/nonfunctional.  This is typically handled by:
  1. Using the base part number (r9a08g045) in the compatible value,
  2. Having the device node in the base .dtsi,
  3. Deleting nodes in the variant-specific .dtsi file when needed
     (see e.g. arch/arm64/boot/dts/renesas/r9a09g047{,e[35]7}.dtsi)

Hence as R9A08G045S13, R9A08G045S17, R9A08G045S33, and
R9A08G045S37 all have PCIe, I think it is more appropriate
to use "renesas,r9a08g045-pcie" as the compatible value than
"renesas,r9a08g045s33-pcie".

> Geert, please let us know if you have some suggestions here with regards to
> the compatible. The IP on RZ/G3S is compatible also with the one in RZ/V2H,
> RZ/G3E.

RZ/V2H and RZ/G3E can use "renesas,r9a09g057-pcie" resp.
"renesas,r9a09g047-pcie", with "renesas,r9a08g045-pcie" as a fallback.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

