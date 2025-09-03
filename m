Return-Path: <linux-pci+bounces-35344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B187B411FC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 03:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7941F207B58
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 01:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F781D54E3;
	Wed,  3 Sep 2025 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lf4dDe7+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10E01ADC7E
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 01:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756863327; cv=none; b=VgKyTn1U1sBR9+znSR1Gljtesk8GpVaoJhilyWm2JMIdEY2gMxijClf8GEZru9cbTmUcIXDo1w2TUe21NZUMCUlG59aXdPeuWRmUI9vBtBK+JzKKtfWtkKUxgsJzo6MZGlQqYd1AOvgldq+Gbe3wep9N2ePz+Ukmw09ozrWY15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756863327; c=relaxed/simple;
	bh=kS0eRVrXMVdTSsrinzwyl4LziFG+Xfgo2McFxCw9UeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zt3mUSPK02IscB+1EcG5bXLcGy2vjYNOoTFIdEvpCp4XqKBdjdtWSxv6VVQKghRVEUipJFWA/pGO+Zn3Ua7PWhmt1XioT1lolXzagAZe/Y6/2iVa4Ny3wwP/URSuQeacvU8pnUgYEAzl1bN6ERVxstuHmwDceRGuCHmjJWO/YWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lf4dDe7+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B040C4CEED
	for <linux-pci@vger.kernel.org>; Wed,  3 Sep 2025 01:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756863327;
	bh=kS0eRVrXMVdTSsrinzwyl4LziFG+Xfgo2McFxCw9UeI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Lf4dDe7+J6l0yXw95iXWOF/wm1WdfTiWEELwC53Zh8PYlfuBOfrQXRBxUxHrbVlkS
	 djiA9qcwzo04PZpEwbgNv9IozvADQ9WJHdY96vAYNYFDWOGL9D19mFAEil56iwp9HD
	 9J4LUeW6A34CCKRuN5rOwZ2clprEPCEFwtncogfwQQUqBZaheBfsqnJsaSbgK4HVIZ
	 p8kvIO6WbzGNo8Y6Goi+AJtP6m3KC3/SwNcoc6UXP9CCOWqGD8GGSYWzxgrDr+K02V
	 Mb7d/X7N1FPMlCcfYNo1m3Vu7j5qTfMC7ENTgoHd7/O0zN9d9Vdl2Pc2AC1AU6rL+R
	 HjA620BWFbrHA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b00a9989633so101266266b.0
        for <linux-pci@vger.kernel.org>; Tue, 02 Sep 2025 18:35:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVigj/SwjtAirn72D1jp5ePHurBdxG4hASkj5lgF6WT4bWMbhsZFZ9D6plvieMxweBUc6XPul5FHsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEctgqsZdrI9JCF72DnWR6+utS7aNaXxGvTRpcfzA/CT8Bu4T
	1SKlx8GP6F0+1HHNRC4oBG2XP8Bq8o5/FbTTwnPIrWFTOhDTtx4LSw8snTL3YFhweQUvqUiL8q8
	Tu61db6bD0pNOWBN3O7K3kb+y6B2MCQ==
X-Google-Smtp-Source: AGHT+IEyXujD35HTtCO9FAM4YHy4q5+2GF7J4I60L81qqYnXOHcmZ+uGWkffKxS4WQb6DcbLXVDv7SM4I97Y1At2C48=
X-Received: by 2002:a17:907:3e06:b0:b04:5bb5:2745 with SMTP id
 a640c23a62f3a-b045bb52c9fmr290922166b.21.1756863325754; Tue, 02 Sep 2025
 18:35:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <bug-220479-41252@https.bugzilla.kernel.org/> <20250820184603.GA633069@bhelgaas>
 <20250902203226.u4i43vygl4bl2dqa@pali>
In-Reply-To: <20250902203226.u4i43vygl4bl2dqa@pali>
From: Rob Herring <robh@kernel.org>
Date: Tue, 2 Sep 2025 20:35:14 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+cytAQAtSB7VjR8oKrXJJSSrOouKQZYQAWNvu+tStTnA@mail.gmail.com>
X-Gm-Features: Ac12FXw30tgPmSSwJF2Zx6uteBTHUpxo3W52x3Ym0Mw_DjEpBw5DBBVaxiwsK_w
Message-ID: <CAL_Jsq+cytAQAtSB7VjR8oKrXJJSSrOouKQZYQAWNvu+tStTnA@mail.gmail.com>
Subject: Re: [Bug 220479] New: [regression 6.16] mvebu: no pci devices
 detected on turris omnia
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Jan Palus <jpalus@fastmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-pci@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:32=E2=80=AFPM Pali Roh=C3=A1r <pali@kernel.org> wr=
ote:
>
> These issues have been discussed more times for last 3 years.
> Tested changes which are fixing real bugs and are improving the
> pci-mvebu.c driver from people listed as M: in MAINTAINERS are being
> rejected or silently ignored. And untested changes which are not going
> to fix any bug are being accepted and causing new regressions. People
> then reporting bug reports to M: people who cannot do anything with it.
> The only advice which they can get is to not use mainline kernel.
> This pci-mvebu.c driver in mainline kernel is broken and nobody wanted
> to do anything with this situation for last 3 years, I was pointing for
> it more times. Due to this I'm ignoring bug reports for pci-mvebu.c
> driver for mainline kernel.

This makes no sense. Mainline is broken, but yet there's a regression
in mainline breaking the driver. The pci-mvebu.c maintainers have the
ability to test patches, but refuse to test any submitted patches
other than their own. I guess the only solution here is just remove
the driver...

Rob

