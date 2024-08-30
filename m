Return-Path: <linux-pci+bounces-12540-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A058966C87
	for <lists+linux-pci@lfdr.de>; Sat, 31 Aug 2024 00:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04A38B23420
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 22:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221311C1AC6;
	Fri, 30 Aug 2024 22:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Dp1v7+aW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339F1BD02E
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 22:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725057198; cv=none; b=Wr/J9D8i02DFvQeIzAZ0gB+nhY2pJ1sqchtUwY167ahbqY1dKPxI/RTn7WcaO+TCqx8RkpNFQ1IA0HAMKFJKPmoWf/55L3dFo649J0GaLtrLvkVOMqMsSr/1Pct4f4zI8Sj6oVRoAi1hTbJ8tXemJ9pICs6X8TR/e7Ny40UUts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725057198; c=relaxed/simple;
	bh=DqAVqqLfjpgjASo+CIfe1feDonNcG4Odo1DBuX7wdR4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxQjgPqeTM1ZNcUs2POOJabBdGO24q048EfNsoTHeJ3LmeDWU/8ehG42vpWj7PkFEjYc/X2M0d1eBtR5Rvg/UdZ0HsOQ4lKiLaWo8vbT8WbD4ED0CsFWGlHusWqU+qfJat1+Chr91QjpkKALDMoXHWT7ApffdYA4nc8ds3tHHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Dp1v7+aW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8682bb5e79so289270966b.2
        for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 15:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725057194; x=1725661994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oK95C0BSC1jzK2D55nrE90clLVhwEM+Y9bSdjRWpEd8=;
        b=Dp1v7+aWJz+A4cKaT17oli44/yP7f2EW22bHOILyblolzuTJO8ufFE9h6WAZImPwqB
         FvIP6MkS4VBTdglAlZrkkemaTnAP17V9CI7Akrcz6QU3vjSzMSyKleqKcmbnO9iwcdxH
         Qn/8Z6lagO/ez613Qk6hVmWoA3v/ETIgM4LbGNi9D4AGRabXoIsWYqWAV+onnKHYgcp1
         I55prglG9jD1jTFlh0ezT84sinyOk6ck64uOBbuXon4UejFLuYgRWMu7IAYy7EnTlKMF
         7BMHrMYhVM4xX+7bC3jEsBzlLskQRblwFvT0haTOTx2nwEi6YuL7AmptvwKLlBeKkwiA
         P+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725057194; x=1725661994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oK95C0BSC1jzK2D55nrE90clLVhwEM+Y9bSdjRWpEd8=;
        b=gRDAdkECKXqQ2AbmYp+3vYZfUYCuaqZiuGFRPpy1aiCouxD0ETIZCp+ljwf9jnt/HY
         y2abBr8FGa9i5sn5Y8fTSwFB90TtxDsqkU9m7EHjdezfeYIbzeuhQNBhVNg3BRsw57r+
         pksZ/8PZYHmkjDaF6ddTO2sY0FsR9FeFjfeQ4FHvu5h1o+YSSu1oYhXXb63vbHp88Dx6
         WI3fFVDIbiPbxMD8FjA3tIK3VOqrG71J/S3xpOobEN3ZHbKbsakSj5wrWV8gk7WH1WH4
         3E4Wn4UhUsNaakR+okjBrpvWa61Wi1BcYyA/jzaWhCvcgD+R22WSNlX+x9pxiQRQG+Dj
         iOOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUob/FzA3j3LMcAqCAuKXFTWL6ILphVDBAPeMjm3pkwQprx3BJOg8aiXoy1ubdwwU3VGn5ngDcB72w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkh75SL1uk1ZZjZaXz4L/Cr6k5nK17IZNtmNLF/DAxVvRsX+fX
	eypCXzkoKXmj8J5uYusURTWvkRVjwmXelsxPEE/t+QBFyxeOFM/giCFTBSqqJOQ=
X-Google-Smtp-Source: AGHT+IHqkz6MDPFM4AoearcdXDKhXOMUBNtVV9Zz1IeP9NcojNkgXiXqwILRRdgqIEEC3J1YsUnnqQ==
X-Received: by 2002:a17:907:2da2:b0:a7a:a5ae:11b7 with SMTP id a640c23a62f3a-a897fa63905mr698523966b.49.1725057193226;
        Fri, 30 Aug 2024 15:33:13 -0700 (PDT)
Received: from localhost (host-80-182-198-72.pool80182.interbusiness.it. [80.182.198.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989195e8csm260291966b.105.2024.08.30.15.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 15:33:12 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 31 Aug 2024 00:33:19 +0200
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 11/11] arm64: dts: rp1: Add support for MACB contained in
 RP1
Message-ID: <ZtJIr-PCWSQWWjaK@apocalypse>
References: <cover.1724159867.git.andrea.porta@suse.com>
 <a3fde99c2e522ef1fbf4e4bb125bc1d97a715eaf.1724159867.git.andrea.porta@suse.com>
 <c3cgkrwnwkrzr67viuvo66ckkxc4ehcye4zomcqdwy2h4dabol@wjp4cd4clm77>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3cgkrwnwkrzr67viuvo66ckkxc4ehcye4zomcqdwy2h4dabol@wjp4cd4clm77>

Hi Krzysztof,

On 10:43 Wed 21 Aug     , Krzysztof Kozlowski wrote:
> On Tue, Aug 20, 2024 at 04:36:13PM +0200, Andrea della Porta wrote:
> > RaspberryPi RP1 is multi function PCI endpoint device that
> > exposes several subperipherals via PCI BAR.
> > Add an ethernet node for Cadence MACB to the RP1 dtso
> > 
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  arch/arm64/boot/dts/broadcom/rp1.dtso | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/broadcom/rp1.dtso b/arch/arm64/boot/dts/broadcom/rp1.dtso
> > index d80178a278ee..b40e203c28d5 100644
> > --- a/arch/arm64/boot/dts/broadcom/rp1.dtso
> > +++ b/arch/arm64/boot/dts/broadcom/rp1.dtso
> > @@ -78,6 +78,29 @@ rp1_clocks: clocks@c040018000 {
> >  							       <50000000>;   // RP1_CLK_ETH_TSU
> >  				};
> >  
> > +				rp1_eth: ethernet@c040100000 {
> > +					reg = <0xc0 0x40100000  0x0 0x4000>;
> > +					compatible = "cdns,macb";
> 
> Please start using DTS coding style...

Ack.

Regards,
Andrea

> 
> Best regards,
> Krzysztof
> 

