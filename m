Return-Path: <linux-pci+bounces-35622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3FCB48165
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 01:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979BB189C0A7
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8BE2264B2;
	Sun,  7 Sep 2025 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyFikpMj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C874A06;
	Sun,  7 Sep 2025 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757289219; cv=none; b=Q4IIYcGlR+7RbdyoEUoorcKT1GAH4HYTdit0PxWsu4Ohy5AFHjv/tcAjaLFMjChCy8lVUM/qfwHME0xvk2VxIOYYIn2aEh1S1RmJy0BedtQggyPXPNfQ43Mc7hvtdK0NPO91zW+06Blph2xMYy8VQEgG+H04hlFjFV3F2i1LJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757289219; c=relaxed/simple;
	bh=QdG+IhjF51xyq+3NpOpz1LeVBa0bkyTZQqopt66bZd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyKxAD3M3zJq4aMeDDJ0kMZ1+8NGKKRlTqQ5+Rry4IjZ9hDku57q73zfofRgPaM2045+tSyNMl0TyHlOzseoI+r4e350si4qtI8V8rJgzhl97+4YSuXuXSk4PTuu8VjwiCEdwg9EbINFxuVBcQtUPZF9y0bhJlcBcB6oD7JRaKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyFikpMj; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0449b1b56eso555130466b.1;
        Sun, 07 Sep 2025 16:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757289216; x=1757894016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eo0jWMvenzTcylQbtlD+TZFDQvY9IieO+xccEfDQfKU=;
        b=QyFikpMjtD1woqTYpPkQ97m+wBEnTvKMQDpvhh1PYc5hvOHVBPPlpn5tr6efmHujt5
         eaP2b5PT1qnTwBgQKF1oht2yf91nPMR0Le7D/+HWdqsOTzFS9O9a1BvnKPjBoTDVv6Xp
         bL9Z6NHo0P/MLHWOCH9yUXltLZv9kkmPm/vZIiYwywHyXDpgcfDqt2JROZ4sn9gYXWYK
         JVGZihf3Wc1Pef+4ljS/RCNYpNeAhWC6utF4RnW5O1ZwMcqJjKjUE2iRZG5S+SIpX/4K
         sVeFdh4+10Y9HEEM+fVHiYG/ODuHHnzUSocbBWAaEO/d2fXhablYjmzUNCLjDk51T+61
         E6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757289216; x=1757894016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eo0jWMvenzTcylQbtlD+TZFDQvY9IieO+xccEfDQfKU=;
        b=dXGPmpOPa2K0ndXHHyqp4mOXuF43Ejlag/E+xdroecgQ3VJ1M7MeaH/B78++98gXaO
         oDl68U7CI6ZZ/kVEehhKg+51ap9HdUTxKSOfuEsIme4l+CS/CjPwD4xvoogHtBfNGXgk
         zuxLJHpf+g6M6/ouKYnynEHxaBMUJxSNgg39U9hHN1f0ovDFhbzC18Je3okBc0yt1zN4
         oLviEsnRT7NsfIWeXd2SfIYrYARWmGYzu9xCQ0vbS9TwJ/+cHyX51ctXlZLxJkO1ag7p
         05JphOg0mW5Y6ORVKOhN+nhqK8GcvDcjs2o+HIWy3Dyky8aHDqhephURemUfXdM5nDNm
         gFtw==
X-Forwarded-Encrypted: i=1; AJvYcCWbCHZuQYrnuLUUEm9u/scp4bJMUn+Hx/EUcw8UoGqqghMS8Hnk69u7wLYzp0j2e0WdqxRtTkKXbO3z@vger.kernel.org, AJvYcCX4PaHaMQSv+IHD3CdV7QaBBN+oO70L7fGZkc4yvbp2LoFrK+4NOVtzVBclzWrwfoVibj3zYjTIQriRZ1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh82OugAIXkbUgyisPmLVCMtrnS/2QIkGtG7BroHFQ4ILVS0M2
	V3JQwKgCHyMNk0Dt1F2Z5SG8+LYXjtpli+GJ4WPdmVQSsTBQW5Mfcn1TTCkwRFm2HJshUPk4hs7
	b9mvWJgG/DZyRVOXmNn9HAZLUMhapgvn9yg==
X-Gm-Gg: ASbGncs8diprl3+aiHz3P45dDWwPX8PBwQCl4pmkgkuQeLvwPDIS/qrJMaU5V0HdjWv
	jRp6WuWdlEdMMu1bxiojfyEB3UujX5E+302wvFfIcE1idon6h/Mrr4g9p0LbBnJs9RsJCT8Omlq
	4Cj/wdw3YW8miuGf3t6xN/5TxpWqlAO17PS93CI2lmkqJDBlagoc1LNFfVyWFTVtjNFI1cFRF/m
	o8hfURI
X-Google-Smtp-Source: AGHT+IFt+a9QpR4i38miW/0BfGqA0U2+iw8J9V2j5KOHtmH84Q/NYOsmq7iQFaAc9EGDka3m0a2cVbFdrj5qMnsEfOA=
X-Received: by 2002:a17:907:7202:b0:afe:23e9:2b4d with SMTP id
 a640c23a62f3a-b04b16f07camr535958666b.43.1757289215546; Sun, 07 Sep 2025
 16:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907102303.29735-1-klaus.kudielka@gmail.com> <to2mscnfphhypr3ml7hnkvedpw45fqoj4rnrmch2zfjre5i3qi@asawccwf2lgz>
In-Reply-To: <to2mscnfphhypr3ml7hnkvedpw45fqoj4rnrmch2zfjre5i3qi@asawccwf2lgz>
From: Tony Dinh <mibodhi@gmail.com>
Date: Sun, 7 Sep 2025 16:53:24 -0700
X-Gm-Features: AS18NWAc6vMudz21FKTD0SJAvjorxRi6NFkDGf4DA4tbyg0jkso42yHG7rMZMhs
Message-ID: <CAJaLiFwwTaok1JLTz=JCEhVacvL=ZB4X8TBDwR0NfhHrBp3YKg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: mvebu: Fix use of for_each_of_range() iterator
To: Jan Palus <jpalus@fastmail.com>
Cc: Klaus Kudielka <klaus.kudielka@gmail.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 4:42=E2=80=AFPM Jan Palus <jpalus@fastmail.com> wrot=
e:
>
> On 07.09.2025 12:21, Klaus Kudielka wrote:
> > The blamed commit simplifies code, by using the for_each_of_range()
> > iterator. But it results in no pci devices being detected anymore on
> > Turris Omnia (and probably other mvebu targets).
> >
> > Issue #1:
> >
> > To determine range.flags, of_pci_range_parser_one() uses bus->get_flags=
(),
> > which resolves to of_bus_pci_get_flags(). That function already returns=
 an
> > IORESOURCE bit field, and NOT the original flags from the "ranges"
> > resource.
> >
> > Then mvebu_get_tgt_attr() attempts the very same conversion again.
> > But this is a misinterpretation of range.flags.
> >
> > Remove the misinterpretation of range.flags in mvebu_get_tgt_attr(),
> > to restore the intended behavior.
> >
> > Issue #2:
> >
> > The driver needs target and attributes, which are encoded in the raw
> > address values of the "/soc/pcie/ranges" resource. According to
> > of_pci_range_parser_one(), the raw values are stored in range.bus_addr
> > and range.parent_bus_addr, respectively. range.cpu_addr is a translated
> > version of range.parent_bus_addr, and not relevant here.
> >
> > Use the correct range structure member, to extract target and attribute=
s.
> > This restores the intended behavior.
> >
> > Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>
> > Fixes: 5da3d94a23c6 ("PCI: mvebu: Use for_each_of_range() iterator for =
parsing "ranges"")
> > Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> > Closes: https://lore.kernel.org/r/20250820184603.GA633069@bhelgaas/
> > Reported-by: Jan Palus <jpalus@fastmail.com>
> > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220479
> > ---
> > v2: Fix issue #2, as well.
> >
> >  drivers/pci/controller/pci-mvebu.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
>
> Confirmed the patch applied on top of 6.16.5 fixes all the issues
> introduced with 5da3d94a23c6.
>
> Tested-by: Jan Palus <jpalus@fastmail.com>
>
Sorry, should have said:

Tested on these Marvell Kirkwood SoC boards: Cloudengine Pogoplug
Series 4 (88F6192), ZyXEL NAS325 (88F6282), and Synology DS112
(88F6282) running kernel 6.16.5.

All the best,
Tony

