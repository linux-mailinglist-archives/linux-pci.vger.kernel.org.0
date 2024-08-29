Return-Path: <linux-pci+bounces-12462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 539CD9652CB
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 00:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A63B284A09
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 22:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EAD18C009;
	Thu, 29 Aug 2024 22:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="aa2Uv5b8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7287418B479
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724970090; cv=none; b=iOT67rDi42cp7VmZ0ulnon57lBonBw/V4VrTyskj3DrShKqYj2nz9akLMBf6WETm6/42S7nNvwvmbY+H5c0AndG8NpL0ALYr9rahsWTnyoS09YUr6bMSpDrvMlkV9zUzox3WkbD1DVnpjrQDOblJzclhMwHS0K+B4I416Oe5rWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724970090; c=relaxed/simple;
	bh=hDXXfgSzcBVLRFNJCdo0qpNRK4cTXtvKfXqqK4IgeLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rbIRfmEeeFDReHS6qSXD7RcILwFyt7kgWWvC4bYstKFFzStJWx2k2o+sbDHOhJw4ja17Do1Sgta2L5shIlZPN0okegqucg4bOd4HqdQAAYshlKzXGDXb1mXnYPEZ3jAxIKMXkNVOWuhhq5LlMZqxUGatJG8gK+lpRCilIlHzanE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=aa2Uv5b8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8679f534c3so129730266b.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 15:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1724970087; x=1725574887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QECDMdJ+lHOgQ9efmHZ8bnkzPO30uxGiYqu1KLc8bfk=;
        b=aa2Uv5b8Nn/LNoU+vcdpFr0pTuuNjLCl3OS6LN9s4QoXXGwrZUYk4cifsBugHIREhf
         b6fRQJ+is7iy+WD5g8iki/EY/S9DHrY1ji2o21yVOZfSmT14zxU/bHIrDAGM0ky0NWuE
         Ia4JfoaTwMvdb0FjS32rHTVTQX9KkL+SzzL3Ut/eLeXIbCxLqPOKOK8B/+ryX6GZSDqK
         y9TVI7zfwUwtvIsBVOqRwHDHEr3J/P9jYSBSwtLSB335i05kFPDdtNAx8e8LoRFFxsNu
         EtMdNN6gien4PdKmBrFKL87hfa02ZZTpB9edUTr1YHPYUPakuFYvJejs6q7o1lTYLBvV
         NU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724970087; x=1725574887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QECDMdJ+lHOgQ9efmHZ8bnkzPO30uxGiYqu1KLc8bfk=;
        b=c3VEd17uIoiOrBHqBRZczZf8nRHex8PdVdBlE/tViG0KSPQyK4msYn49RON80Paw9i
         /WJ+OY7mb3J6XXiI/4YRW4ShoAZ7tbxu0EbdaBdjWXMdYtMZQhC2lZ8hARGaT5UB6jdC
         u84zPJbVHWAXWIzM5/mvmLvXNtgE7LIVxOXiAf7M04DXbLhNjttC6BfeXvxaE1/zcC1r
         5bt26Ajk45xLUaQA2qjrlXsRkz1VE72jRf3Zt9v8TNGCAKkC38e8znFZoMHNgo2mmwE8
         WTn/9zzqzBiYrlO1s+ok8apuUzpvqOS53009jgi8h3UwfHOc4jfILU/y3x6bUMrlPdp9
         Y/Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW8sXnV7uFwrwHSPU3EclimNfjvjXWKXTRB/rw+2G+toDT3SG898ytWIxrUJC3YGWJhteZgf1f2nA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdzBru8aAgmgN1+/bw26XDmYD4HD5ojdRiSzas3hpNzd9O1N50
	wIoqu96twhvHkLC9uIGR0zDjUJOnSK+i7rtRBJCk0SuLQAUolM8+NkagOZQ8B/FPbM+WV4Tc1bw
	G8bJ+nomYjeUQ42W72FgweAvNS0RTXjLaxcswQA==
X-Google-Smtp-Source: AGHT+IH/93yes96vCW4TS8ZZfhhFB1ipyDYhEMVHylyuce6VRmAFe4ybjoXooO5Oq2RAnyN85c16nsh1uamui6Dkcdc=
X-Received: by 2002:a17:907:e92:b0:a80:7193:bd88 with SMTP id
 a640c23a62f3a-a897f8f78a4mr341486266b.36.1724970086051; Thu, 29 Aug 2024
 15:21:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZtDrjl3b8yhumk+A@lizhi-Precision-Tower-5810> <20240829220005.GA81596@bhelgaas>
In-Reply-To: <20240829220005.GA81596@bhelgaas>
From: Tim Harvey <tharvey@gateworks.com>
Date: Thu, 29 Aug 2024 15:21:13 -0700
Message-ID: <CAJ+vNU0taRj3PgP1tgcK68C++x93XO-aitvn42Pmk3EoWuj7OA@mail.gmail.com>
Subject: Re: legacy PCI device behind a bridge not getting a valid IRQ on imx
 host controller
To: Bjorn Helgaas <helgaas@kernel.org>, Frank Li <frank.li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:00=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Thu, Aug 29, 2024 at 05:43:42PM -0400, Frank Li wrote:
> > On Thu, Aug 29, 2024 at 04:22:35PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 28, 2024 at 02:40:33PM -0700, Tim Harvey wrote:
> > > > Greetings,
> > > >
> > > > I have a user that is using an IMX8MM SoC (dwc controller) with a
> > > > miniPCIe card that has a PEX8112 PCI-to-PCIe bridge to a legacy PCI
> > > > device and the device is not getting a valid interrupt.
> > >
> > > Does pci-imx6.c support INTx at all?
> >
> > Yes, dwc controller map INTx message to 4 irq lines, which connect to G=
IC.
> > we tested it by add nomsi in kernel command line.
>
> Thanks, Frank.  Can you point me to the dwc code where this happens?
> Maybe I can remember this for next time or add a comment to help
> people find it.
>
> Bjorn

Bjorn and Frank,

I provided some misinformation regarding IMX6 - my original testing
was flawed. When testing the IMX6DL linked to a XIO2001 with a legacy
PCI device behind it the device driver is given an appropriate legacy
IRQ.

Regarding IMX8MM linked to a PEX8112 bridge with a legacy PCI device
behind it; the user gets a -28 (ENOSPC) when requesting an IRQ from
the driver but I don't have the hardware or the driver for that in
hand so I need to wait for more details. I don't see any reason why
this case would not work as it works on an IMX6DL.

Best Regards,

Tim

