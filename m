Return-Path: <linux-pci+bounces-39264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A06BC064C9
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 14:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A54451C06123
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 12:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F73195FE;
	Fri, 24 Oct 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfCVHAVo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFB3195E7
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761309830; cv=none; b=rmH+VzvX9CrfaCCgFtN45o+Iwuoy5VD8R6FBTIK9XG/QvE6UOqrNQoSWtOiOV5/Tajw8z1WN9kMs24wJ/Hab10wNwfajbAF1gwfzLzx9AEUv3GWLS0I1/z22/8Nc4Bt3q4rFafOfmh1khGoEgpHsm7AAe0fcD55jRRanxj1rZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761309830; c=relaxed/simple;
	bh=OQJRTxbLkUJSG6Hfj2aAMLp/CQvFmEMNU2nFsDW8/O8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CxQoZh2lwOxyXvR3PxblxKU+c5jnHrhJMmfPkYJSrEAHJeO9unH+3+66Q9O5/0IuAfbgxdvrZ11D4xFIvQTwvCQBQpARyQAwO4rQVFwij4iqo8rV77u+MzrnnSZ67uY/pW7doMOylEyVNbkBoUSqZJ8j7goOJh3DmTHRShnRkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfCVHAVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B787C4CEF1
	for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 12:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761309830;
	bh=OQJRTxbLkUJSG6Hfj2aAMLp/CQvFmEMNU2nFsDW8/O8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mfCVHAVopZMSe5zGbZ7DqcXCJxa26UWCs9cnJYJIS8/ZfVKoEmbITymqnbZp13Rmb
	 SKXsOkiuvT2pufWs0wyCCT10nrtYmnr8bn0WAbXaibCgDVgaWxpTYsrOOlXyIutW/Y
	 BDFd0r9LXGWVDCYMPoQl4B8oBfqOP+Tpbv9bGDjZEbjcfZTpvlS3RpvhBtyKAkWPrL
	 vtdTPyXUqe+wpqbRyE2JiEXzYUmsjfa2Fyjlu4YA1XURxLE2vSCBaukH2D3211hZyS
	 pQ3EREfiU0k2d+Uxh5Ae8DrczsY6IUqrC3KlTS8BNgwZIKifHR/klhFJAlhFwqbdyH
	 9EcaMn7voKNdA==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so409701166b.0
        for <linux-pci@vger.kernel.org>; Fri, 24 Oct 2025 05:43:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUVzWAKs423LQ/TSvOAaGPVjSJlp5SuDbsAa3fpaI0VSEPZszwUg02kHzHq48iXRG/WNFgVwYFL9/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQ0fUs3uuSyw1b2Nj5ICba3LyPU+7KNqwX3pfrW24HsIV7EOy
	HVYqSGoUi5R4vtPf36eA5eZAKHqCdbaRQDXHPxm2RSDoa1QV6+rVizL/2kPbmGNJJfGUf6aExau
	RODuxbk9wVUafR9Oeky4COsv82DjCrg==
X-Google-Smtp-Source: AGHT+IGaCIdcHozNq55y6tCOTnaSA8JKLNglQntYyplKKBr4Kfb/fniPDz4m4msgsNYHeZxxULr+Js+tkAFFxxxkJ0s=
X-Received: by 2002:a17:907:9701:b0:b3c:a161:6843 with SMTP id
 a640c23a62f3a-b6d6fe01905mr270557266b.4.1761309828886; Fri, 24 Oct 2025
 05:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021124103.198419-1-lpieralisi@kernel.org>
 <20251022140545.GB3390144-robh@kernel.org> <87v7k4ws58.ffs@tglx>
In-Reply-To: <87v7k4ws58.ffs@tglx>
From: Rob Herring <robh@kernel.org>
Date: Fri, 24 Oct 2025 07:43:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL5f4_qQ=YmQcYpaxsUx8vZDkuquK=G3YTw9qC1QibVrg@mail.gmail.com>
X-Gm-Features: AWmQ_bms1S4lGlWI8WRswebTFx9muu0IxPjIPVEgFBEKLoJV1JkaFYbmMfNU7gQ
Message-ID: <CAL_JsqL5f4_qQ=YmQcYpaxsUx8vZDkuquK=G3YTw9qC1QibVrg@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] of/irq: Misc msi-parent handling fixes/clean-ups
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pci@vger.kernel.org, Sascha Bischoff <sascha.bischoff@arm.com>, 
	Scott Branden <sbranden@broadcom.com>, Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>, 
	Frank Li <Frank.Li@nxp.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 4:44=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> Rob!
>
> On Wed, Oct 22 2025 at 09:05, Rob Herring wrote:
> > On Tue, Oct 21, 2025 at 02:40:58PM +0200, Lorenzo Pieralisi wrote:
> >> Lorenzo Pieralisi (5):
> >>   of/irq: Add msi-parent check to of_msi_xlate()
> >>   of/irq: Fix OF node refcount in of_msi_get_domain()
> >
> > I've applied these 2 for 6.18.
>
> The rest of this depends on those two.
>
> >>   of/irq: Export of_msi_xlate() for module usage
>
> Can you pick the three of/irq ones up and put them into a seperate
> branch based on rc1 so that I can pull that and apply the rest:

Yes. This series is the only thing I have queued for 6.18 fixes so
far, so I'll add the 3rd patch and Cc you on my PR to Linus.

Rob

