Return-Path: <linux-pci+bounces-39358-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A51D3C0BF9D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E4AF234AAF2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 06:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1403B2DC79C;
	Mon, 27 Oct 2025 06:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqvMEY1U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F302D5A01
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 06:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547339; cv=none; b=EV5RURGXYRrzG+9/uXcLSjbb62MqUPR9xue3NM7UWlkE8oZ747e0N3jn0MOVP8NLSJtzVZ4vSQkToml/IrEVs1m0ODVaedUrsD1wIPiC2UxLm7tsh5T+CXQrLkTLeKFlSPyzHjJ3aOSa3aTKlasqsDP4UD2GdE4fzOf56dIilfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547339; c=relaxed/simple;
	bh=oreL+ACETkIuRzK2D2r0xoY5Bjsmctzbdbz0anwCcIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWc25+ZZuhEnVqYVEJxAX+dX8AKmvIHBCzDAE5/0q4jOln/sR4OmrHxlvzqPJaTDTwVen5YZnDfWYUogoHCmZDcOSeZUwu9GV94CgvHAPnhvzWtJPzpOWtpVMUaaW9lHkyBznl/nk22j8N1tXykhYTeXjsDDrFvs/ZDVSPLVnVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqvMEY1U; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63e0abe71a1so8452553a12.1
        for <linux-pci@vger.kernel.org>; Sun, 26 Oct 2025 23:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761547335; x=1762152135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tID2O9rtuhA1HdKtwWUF8mN/hhDrcp/NLBhknx3DjcA=;
        b=cqvMEY1UN9AnTQnHTfUr1TJOPuYkbzDgTNCG8/jhuVLNh/NQD0UoJ5qrgQ8VLacRmf
         FEOitkfsT9yk0u1fF9Hzo6UtyoAiftygLxr/hyojgfFn1LTSxAYqkxy6FZfNteOYZzZm
         4BgsHt51yg7Ffl0f++m9FRdHVuLZRtXTwIJEx0J3BZvu1N0bG91eZJNAqbkzIttTriPr
         DmjtF4Ov2D0DKnzjRzalBmNuRVKOsWMguF7HNrYdDfw1GcAupXFQuUdUzCA9+Byrv9SU
         ekPHk022TkCjS3D0yuv0BzFVGHsz0Ld1G9TctW9IDdMASDr367Sic3Kbh+HcoolOiHbg
         QGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761547335; x=1762152135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tID2O9rtuhA1HdKtwWUF8mN/hhDrcp/NLBhknx3DjcA=;
        b=wiFUCcANVhljAaMXFQ8xtnR8ncWldLFkZ1g9o7nVTfMPpT30CPiVKFND00rkFjr+Hn
         ugFe36zNBzqwA3+b4V3RKC9TzWp2yxpZudMde5fyD7BNj7IW8FXIhxN7MvhCQLX97b0K
         UKEaw6nRtJoYYThmdINBIxY4xWWuzRb5Mgm3+tS7AwN5cRX//8n+WjAweo2pZdZNrqiQ
         /Pud5mrs3Lvm4Eji4bKov3bkD3t9RM980KWU8gAdoA7prJC0HfLwHIsyZbH3lBP1/+N/
         PO1ilzSK8wf3OUkEafdWkeMBCISWPMLCbzPVCb6CbsO+1XsFaakGmz3ZVqtPbpV/ziRV
         e4LA==
X-Forwarded-Encrypted: i=1; AJvYcCXiG47iDFR6iDScLRGJUogR6AXfhFLB5sCyn+dAKXngD4/SwtTewYztAJDOQiNkTImShD2iYhgZTP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyCFg6l0b4vOFY45oJVBcQ0+8Ptnd+5DL2tEFMYj3UMBjxQjiP
	vsLbMvdpiA7djYGff2QZcDsgGmhKm/vW3JtWctRB+XU2EBG8Pakzks5h77bU7kwC3jJOOBdX5Rx
	YpnZLa7ST3RwgzqIiQoBzWxYRXZbnefM=
X-Gm-Gg: ASbGnctRWnuget5IcMvKVPkQRzowQuugjWG6BGxwZ/PjQcX6WUsZgX74Hc6wRcFsOg8
	G57jgg9w61kyi4YHKtzZ38wVuenV44Ytj8pN+SDQDcSfhq1v8f5vM5Vp4MB5g4EZyjR/G1VoWCh
	mJxteWQXEesbNAB6vDFgqVInfMZOJGmtSBJibj3y0sSB1fbqEU8rYf0xF9MjJe27wjzBXSalhDr
	IKKJwH4NWRquR9RxSI6kizMf8hdvTWXHslkJihivWCUPgeO32LQcM8WCCY=
X-Google-Smtp-Source: AGHT+IFYyZXaxe+78PDzeedHWs3RAFG6tJ/BOlzbjZKOPUVztXY1AhNbupmOsYKoQaqvdewKBvyACvqak2464exO6W0=
X-Received: by 2002:a05:6402:40c8:b0:63e:1354:d9ab with SMTP id
 4fb4d7f45d1cf-63e3dff6f32mr13460304a12.8.1761547334887; Sun, 26 Oct 2025
 23:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025074336.26743-1-linux.amoon@gmail.com> <20251025074336.26743-2-linux.amoon@gmail.com>
 <e6f4f3c93cfc2f18c36da10d3f86c1a50ab2bbf5.camel@ti.com> <CANAwSgQ2PH1TJLEBVPFJ-RdaNFxn=eTzRYfEmbjx=EYq_YOeQw@mail.gmail.com>
 <bef3d7015012c4004d21cd829892ca942496a6dd.camel@ti.com>
In-Reply-To: <bef3d7015012c4004d21cd829892ca942496a6dd.camel@ti.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 27 Oct 2025 12:11:57 +0530
X-Gm-Features: AWmQ_blmB6e4uKlIUktX-y8N5PH8rT71hGdHJ3kVMKE8HEWamdNJJ_ocuOBGSVs
Message-ID: <CANAwSgSTncwug+nUpm1pc2H8L0Abvumh8x09AW5p0nr8ufz-Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to
 get the clock
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-omap@vger.kernel.org>, 
	"open list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-pci@vger.kernel.org>, 
	"moderated list:PCI DRIVER FOR TI DRA7XX/J721E" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Siddharth,

On Mon, 27 Oct 2025 at 10:42, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
>
> On Sat, 2025-10-25 at 14:07 +0530, Anand Moon wrote:
> > Hi Siddharth,
> >
> > Thanks for your review comments,
> >
> > On Sat, 25 Oct 2025 at 13:20, Siddharth Vadapalli <s-vadapalli@ti.com> wrote:
> > >
> > > On Sat, 2025-10-25 at 13:13 +0530, Anand Moon wrote:
> > > > Use devm_clk_get_optional_enabled() helper instead of calling
> > > > devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
> > > > the clk_prepare_enable() and clk_disable_unprepare() with proper error
> > > > handling and makes the code more compact.
> > > > The result of devm_clk_get_optional_enabled() is now assigned directly
> > > > to pcie->refclk. This removes a superfluous local clk variable,
> > > > improving code readability and compactness. The functionality
> > > > remains unchanged, but the code is now more streamlined.
> > > >
> > > > Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > v2: Rephase the commit message and use proper error pointer
> > > >     PTR_ERR(pcie->refclk) to return error.
> > > > v1: Drop explicit clk_disable_unprepare as it handled by
> > > >     devm_clk_get_optional_enabled, Since devm_clk_get_optional_enabled
> > > >     internally manages clk_prepare_enable and clk_disable_unprepare
> > > >     as part of its lifecycle, the explicit call to clk_disable_unprepare
> > > >     is redundant and can be safely removed.
> > > > ---
> > > >  drivers/pci/controller/cadence/pci-j721e.c | 21 +++++----------------
> > > >  1 file changed, 5 insertions(+), 16 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
> > > > index 5bc5ab20aa6d..b678f7d48206 100644
> > > > --- a/drivers/pci/controller/cadence/pci-j721e.c
> > > > +++ b/drivers/pci/controller/cadence/pci-j721e.c
> > >
> > > [TRIMMED]
> > >
> > > > @@ -692,7 +682,6 @@ static int j721e_pcie_suspend_noirq(struct device *dev)
> > > >
> > > >       if (pcie->mode == PCI_MODE_RC) {
> > > >               gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > > > -             clk_disable_unprepare(pcie->refclk);
> > >
> > > j721e_pcie_resume_noirq() contains clk_enable_prepare().
> > Ok I will drop the clk_prepare_enable and clk_disable_unprepare in
> > this function?
>
> The clock needs to be disabled on Suspend and enabled on Resume.
>
> The reasoning behind replacing:
> devm_clk_get_optional()  + clk_prepare_enable()
> with:
> devm_clk_get_optional_enabled()
> is clear to me, but the removal of the 'clk_disable_unprepare()' on the
> Suspend path isn't.
>
> Removing 'clk_disable_unprepare()' in the driver's remove path makes sense
> because the
> devm() API will automatically disable and unprepare the clock when the
> device is "unbound".
> However, to the best of my understanding, the device is not "unbound"
> during Suspend.
Thanks for clarifying my doubt. That part makes sense.
> Can you clarify why 'clk_disable_unprepare()' should be removed in
> j721e_pcie_suspend_noirq()?
It happened by mistake.
> Regards,
> Siddharth.
Thanks
-Anand

