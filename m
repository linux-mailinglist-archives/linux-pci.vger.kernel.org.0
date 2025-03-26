Return-Path: <linux-pci+bounces-24791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB137A71F96
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 20:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7529E174B71
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 19:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16531F6664;
	Wed, 26 Mar 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJSadGsS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917131DD539;
	Wed, 26 Mar 2025 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018681; cv=none; b=pugztLsKHNSWAivks0V1+vgGOGU9KnyZMeiROYD9cWvJW8qy2peX6nUg5FEUH2wFqxFffflIHwyRVK09S9DLXvBIXw0JY1FvaboADUixL3bwDhkjtpZ7hKuIjYIiKxisSUWPH+UZQvtB454+cyDtl60Gvmjgx1Bo+h+DRwcbU4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018681; c=relaxed/simple;
	bh=vpNjfjV9EyxkTqodYw2+3oCIshfkkDgO9rKwFnzprFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZcnO6DUCbO/Wlvh4h8+2LRBOAq3Y7K4f+vR29Uzmq2yyZutu/RmiDgYofNAuRw2mpQYIpAPXC6yWqQFQFrTIycZNB3jZxKVaKbQv5sKYKmsRpM6OnNtakTDSGIVncxgHoefn1T9raWvpcA8PEGGHs0zBovrPiaw5AGmYB0iuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJSadGsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17007C4CEED;
	Wed, 26 Mar 2025 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743018681;
	bh=vpNjfjV9EyxkTqodYw2+3oCIshfkkDgO9rKwFnzprFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hJSadGsSW0/H3IdFtLu1Ffm9kEt+mXwvCGfXmTNmN0KNyA2IE3BjoBwpf0l6m9oH7
	 H9AuoevFkWOyO8SNjPEkyO4hZZbtZnXaXvIpl+Sl2zgkTWS9uj6hkQu12nKzGyTNqy
	 VtksHZo79lgMLVmab+I94xG1woJ3SHBr83zLjh/TdHG06ywgL7+haooEF+qDgHRhRr
	 nxkN38fBC6tFI+aB7GPl7ku+PR70i16/e0oDTAycXFLOrSOkR+vV18aZe0YatPpaZ1
	 0mp3+oofRdRde6wV6yytnbBJhXErHFYVstEzO1RRRN27AFWTrYbEPv9Ji9koR5tojw
	 GP7XLVfTBfYXA==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so318360a12.1;
        Wed, 26 Mar 2025 12:51:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUAlA1hDNbaInbNJfD0Pl3l1L2c+PNst7QvJY8mGDTufCmqm0MBmILIvhOdLy5mESd+TKFsD51JqOcQ@vger.kernel.org, AJvYcCWYQGYf4CDTSJgl9s6WBcAIofF6EOGtRoakpoKG5GVakKxZwx4TRIDUGs0S63+1Y6ig4C6xz9F6HfbA@vger.kernel.org, AJvYcCXebRG4+FPfICz8GEuxI99OWd3GvawoAf8q7MgMO2JR99pLD6SgbFhIJQNpWHXYAdFA3MHWpYShHTZhFPRe@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl5kWQtJiYp05Mb4di4WMZfgTis+WmrcNEUEfR/fPd0PziwPFZ
	VAcaMoO44lH1VAkMDZgpH4nOFTzHwbxY0cxZ0DIlgSanCN1UelEZGR+wzrqz5hfMpTkhzVZLg5I
	Am+R5JArGzc+Ch2y7ZfyzXOtPzA==
X-Google-Smtp-Source: AGHT+IErvamND+/bzF17Qvrj3EVovyzy2vc413tQ0D0dRY5KJx2kQCEC00XuxHxUOJAIkhyZqX/VrQo5NNwLV7Sr5Hk=
X-Received: by 2002:a05:6402:4304:b0:5e7:b081:8b2f with SMTP id
 4fb4d7f45d1cf-5ed8e28bba0mr700492a12.8.1743018679628; Wed, 26 Mar 2025
 12:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250325102610.2073863-1-maz@kernel.org> <20250325102610.2073863-2-maz@kernel.org>
 <87iknx75at.fsf@bloch.sibelius.xs4all.nl> <864izhmkzd.wl-maz@kernel.org>
 <87ecyl6rtw.fsf@bloch.sibelius.xs4all.nl> <87a599qcne.wl-maz@kernel.org>
In-Reply-To: <87a599qcne.wl-maz@kernel.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 26 Mar 2025 14:51:08 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+6B7dL9j+31kAhZ_n0HEQyU8KPHv8W9_RXHfZpC9iwxw@mail.gmail.com>
X-Gm-Features: AQ5f1JqWuCb_FqGMc9ODy56dgNx98tFm3EJA04WKZS1ueKCtpmKEHZhRYL5yOAg
Message-ID: <CAL_Jsq+6B7dL9j+31kAhZ_n0HEQyU8KPHv8W9_RXHfZpC9iwxw@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] dt-bindings: pci: apple,pcie: Add t6020
 compatible string
To: Marc Zyngier <maz@kernel.org>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev, alyssa@rosenzweig.io, 
	j@jannau.net, marcan@marcan.st, sven@svenpeter.dev, bhelgaas@google.com, 
	lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, 
	krzk+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 11:49=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrot=
e:
>
> On Tue, 25 Mar 2025 15:41:15 +0000,
> Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Tue, 25 Mar 2025 11:02:30 +0000
> > > From: Marc Zyngier <maz@kernel.org>
> >
> > Hi Marc,
> >
> > > Hi Mark,
> > >
> > > On Tue, 25 Mar 2025 10:50:18 +0000,
> > > Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> > > >
> > > > > From: Marc Zyngier <maz@kernel.org>
> > > > > Date: Tue, 25 Mar 2025 10:25:58 +0000
> > > >
> > > > > @@ -50,6 +55,10 @@ properties:
> > > > >        - const: port1
> > > > >        - const: port2
> > > > >        - const: port3
> > > > > +      - const: phy0
> > > > > +      - const: phy1
> > > > > +      - const: phy2
> > > > > +      - const: phy3
> > >
> > > Do we need to make this t6020 specific?
> > >
> > > Obviously, separate PHY registers do not make much sense before t6020=
,
> > > but I couldn't find a way to describe that. I don't even know if
> > > that's a desirable outcome.
> >
> > I don't think there is a way to do that other than creating a separate
> > binding for t6020.  But I'm far from a dt-schema expert.  Maybe robh
> > has some advice here.
>
> Huh, I'd rather not create another binding. The only thing this would
> buy us is a stricter checking of the register ranges.  But it isn't
> like this block is going to find its way in random HW, and this is
> only described in a handful of core dtsi files anyway.
>
> Unless someone screams (and provides a reasonable alternative), I will
> leave it as is.

The simplest thing to do here is (under the 'allOf'):

if:
  properties:
    compatible:
      contains:
        const: apple,t6020-pcie
then:
  properties:
    reg-names:
      minItems: 10

If/when we start having different number of ports with phy entries,
then it gets messy and each variant has to list out the names or we
give up on defining the order.

Rob

