Return-Path: <linux-pci+bounces-29857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1202ADAFCA
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 14:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DABD173EC8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 12:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750BA285CA1;
	Mon, 16 Jun 2025 12:02:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5204285C84;
	Mon, 16 Jun 2025 12:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750075372; cv=none; b=luO96/XbZ2v7L9+gcbZVuVkT0v7APMxmFr7aQL2mEGY9VV9QBBTifywXN98GUIRaMI+6rgHMFeNDk3HEp635gq11w55i/3vOuT3/ZmqfzhoiRZRbc3u1GVaq/kimKy6rpvEw7VphjDrhs7aX1Tg2KxDu+/j6KNHSdKNQ/R+0tUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750075372; c=relaxed/simple;
	bh=vXBu7uwkxPOsvKdqrgHswhlxEEE0Wgvz5jbfmhZinlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V5rHDoT0DKLlKiN9ZPLbBL30XsDHuYZDeiMQk1Hp85B322pgzRyU5yxkalvr238mx8CHKRjvGVE50iRCY2I62BMvF0D97qN0a63mK+qDGeHKDJhxoXthicXHwLI+FofsAEJoqNIfZsI3ZUj94D/Bwj9k9g2e7gC9GHgy6Gh+Wqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6face1d58dcso71264276d6.2;
        Mon, 16 Jun 2025 05:02:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750075368; x=1750680168;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ploSucNH29V90v2689/j3svshD2BMkR3XA3gPmC2bbo=;
        b=riUuZmO9ufJc4MSveocOo8GmGmLfU0uuiUQ1uwnSpfCZTKAXFPx/baansQRtTdb2rJ
         A64CulxiJULe89sdLZwf3W0aN4DW4YrqhK2/MyNZQpDPLEmqWQ7KTZ3b5QJs1F7rir25
         Aokr996IoDzNe0GkciujQyt7SnrbO7wkaDKYJKQcJVndKJcO3SlHDvF+qt2JKT/haR5h
         uj/fIdHaXJdWPBHmjljLhrzPr0no1H2uzzjbpAVErpGNCU9K1HCWU16qRJyOTRLOP2ro
         AdD/AeF/WYQiAmmmvXMP8xriIQ4O0vcGso0PoMdTq+M5TuEcSM1KG+he4ipRb0GrcYu7
         DwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyiAxzoGGz9lAwOPoTvNt5lTW4Gzq9XPREOYbGniAKPPhTn4KolffL9bz+tqeIVH3UzHHNtz1cg5Gvs2Mp@vger.kernel.org, AJvYcCVqU/ylK5WXAKWQ8gQOK42dJJCuXlXSTBtVvX2L/SoMrMcl6zSu7I8DJFGaU1n8nZUtj07+BoheEk/6hJVtkbHFKyc=@vger.kernel.org, AJvYcCXHIaKAuHbNkMqfrbwLkw2o5MPDrfGMG21Jj62dQd+nBBkS1MqmmThjXM0hXEJLvVl6BG8yXdsqbWaS@vger.kernel.org, AJvYcCXLfLmWT2F7VM06HJY78LFWb7HDOXu3lYuW7zBzQCZJjdShzkCkvlYdfVWmZS8Gb/pt4lgTuVQG/MVO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgiud/7pIXtnzAb1TpltoFnGZtEOUWnv8pG4gD/b8zdjZAvKQh
	kQxqEdZeBuJXI82R3zpNIfV3ihiR/lCac3bNBdRDbOee4JOTGpJ/jSFepsoWB2bK
X-Gm-Gg: ASbGncsFmQSeMiGpa4j0dJ3ttoS6gRyQiSKSBBiqQFFc1Ay0iOfSkDTv9oliVbkBnAW
	rNZ86kumxvKhbg51M3Zj92NrhRPCZG5ng92tccZH8i0eOLIEq8T2yETZMPTqRZxfpwod4bdRbnM
	0c+IA/t9fimcJa+4YQyEOoygCDF5JXlzgo/KtXvFFw9Jcsm5Y+rZI2f8JR4U9hwAcZIqXKLRuHl
	GkHQ42y+wLBM+Z92OXSvHpubDPEZNefoNoMyudw97BF6qhoKGuYamZ/iDcxdbjEbTyMkqwrfhZT
	WvwxB4PzqYvaJxt/3oUz7tTncwbPZvw1bEYHdi/4zfPcxzVgQTZKDk8voRK3oHpOsB3OeORoqjV
	T45GiHYykd8aTDguhhMIRGqrlMvGR
X-Google-Smtp-Source: AGHT+IGaSL4wf+lxi6xehLxilhn3urHlQbpFxBdgSiB38NiFFpsSt7fAX/o6XZC56+FVfkSeFjm/UQ==
X-Received: by 2002:a05:6214:2b9b:b0:6fa:fe27:a249 with SMTP id 6a1803df08f44-6fb478103b0mr102407926d6.43.1750075367839;
        Mon, 16 Jun 2025 05:02:47 -0700 (PDT)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com. [209.85.222.181])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb569796e2sm8847296d6.80.2025.06.16.05.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 05:02:47 -0700 (PDT)
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d2107eb668so716716785a.1;
        Mon, 16 Jun 2025 05:02:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVc4QZxFF/bIDhVOXu8rIrL8/cuZ0hwVmmA61TcFErKUP+CVoyfe020UMUk8wfhuu8lq8OjEVDsd8SLOGC+cOdcj/8=@vger.kernel.org, AJvYcCVygQWqJ6baCDpylKTIKNhz+gImxkXn6d6ykjSwNSKa7vK+KjMVYSsq2KL3Z2ZnOdKdcLyAUTgmOP2F@vger.kernel.org, AJvYcCW5HoseMoeOuraGAg0V2WN5WddH/Na1pCNUgzbjNOz52JmJnR58v8yA+fhugWgdOdamoUdldlKqJ/f6@vger.kernel.org, AJvYcCWvpzKz3fJwnwGGUQNZ2dKw++FhHh4QpCJNWi3cpq5EgJQUE9bzXhaRG1rTCbuURL0gYrjcBW+B+/cZC9If@vger.kernel.org
X-Received: by 2002:a05:620a:2a03:b0:7d3:8df8:cc04 with SMTP id
 af79cd13be357-7d3c6cc98efmr1411274185a.35.1750075366742; Mon, 16 Jun 2025
 05:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuHMdW_89naftFMo881zp=7QGJDznFzzqLQ-kLEuyJ=KJWQnA@mail.gmail.com>
 <20250613220104.GA986309@bhelgaas>
In-Reply-To: <20250613220104.GA986309@bhelgaas>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Jun 2025 14:02:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU=+Hxz09DJeVOhZ1N5yS=UJgMsr5R40KBeu=ftoq4zrw@mail.gmail.com>
X-Gm-Features: AX0GCFvGpF0UKvY33FJrsFmSliyEKvidiVPDSH8oJwCDkQnKl_S7otDQDQqSNxs
Message-ID: <CAMuHMdU=+Hxz09DJeVOhZ1N5yS=UJgMsr5R40KBeu=ftoq4zrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] PCI/pwrctrl: Add optional slot clock to pwrctrl
 driver for PCI slots
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-arm-kernel@lists.infradead.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Anand Moon <linux.amoon@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh@kernel.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

On Sat, 14 Jun 2025 at 00:01, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Jun 12, 2025 at 03:16:45PM +0200, Geert Uytterhoeven wrote:
> > On Sat, 7 Jun 2025 at 21:46, Marek Vasut
> > <marek.vasut+renesas@mailbox.org> wrote:
> > > Add the ability to enable optional slot clock into the pwrctrl driver.
> > > This is used to enable slot clock in split-clock topologies, where the
> > > PCIe host/controller supply and PCIe slot supply are not provided by
> > > the same clock. The PCIe host/controller clock should be described in
> > > the controller node as the controller clock, while the slot clock should
> > > be described in controller bridge/slot subnode.
> > >
> > > Example DT snippet:
> > > &pcicontroller {
> > >     clocks = <&clk_dif 0>;             /* PCIe controller clock */
> > >
> > >     pci@0,0 {
> > >         #address-cells = <3>;
> > >         #size-cells = <2>;
> > >         reg = <0x0 0x0 0x0 0x0 0x0>;
> > >         compatible = "pciclass,0604";
> > >         device_type = "pci";
> > >         clocks = <&clk_dif 1>;         /* PCIe slot clock */
> > >         vpcie3v3-supply = <&reg_3p3v>;
> > >         ranges;
> > >     };
> > > };
> > >
> > > Example clock topology:
> > >  ____________                    ____________
> > > |  PCIe host |                  | PCIe slot  |
> > > |            |                  |            |
> > > |    PCIe RX<|==================|>PCIe TX    |
> > > |    PCIe TX<|==================|>PCIe RX    |
> > > |            |                  |            |
> > > |   PCIe CLK<|======..  ..======|>PCIe CLK   |
> > > '------------'      ||  ||      '------------'
> > >                     ||  ||
> > >  ____________       ||  ||
> > > |  9FGV0441  |      ||  ||
> > > |            |      ||  ||
> > > |   CLK DIF0<|======''  ||
> > > |   CLK DIF1<|==========''
> > > |   CLK DIF2<|
> > > |   CLK DIF3<|
> > > '------------'
> > >
> > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > Reviewed-by: Anand Moon <linux.amoon@gmail.com>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Bartosz: Any chance you can apply this patch to an immutable branch,
> > so I can merge that before taking the other two patches?
> > The alternative is to postpone the DTS patches for one cycle.
>
> I applied this patch only to pci/pwrctrl for v6.17 and made a note
> that the commit should be immutable:
>
>   66db1d3cbdb0 ("PCI/pwrctrl: Add optional slot clock for PCI slots")
>
> We will likely add other pwrctrl patches to this branch during this
> cycle; I assume that will be OK as long as 66db1d3cbdb0 remains
> untouched, right?

Great, I will merge that branch, and will apply the DTS patches on top.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

