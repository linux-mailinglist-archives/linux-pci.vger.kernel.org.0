Return-Path: <linux-pci+bounces-28477-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7994AC5C1B
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 23:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38AFA9E2C6D
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 21:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C57C212D7D;
	Tue, 27 May 2025 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H69psyHK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECE320966B
	for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 21:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748380971; cv=none; b=XRWhcmqRldzNIFguSo69QAzSWLRcA2CrQCEOXfZl+/d8Is4pQbAiL/qnCTIy2Ms8bf3B5HrYNHI0JZCA69rT6uwbpvWLTPMDBDjCWPY+Biiers0f+mhPlJ80jHfw1xunnccQITpIYXK1igsbbGXnKxblkc80PHmQHmFBkY9t+eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748380971; c=relaxed/simple;
	bh=CmXNjfU2YBa1jt2Z+F/46nl2cI2JRC7z389h5i3eWiA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nShUVUwKLqgNe0PN8bxs7tC+bsxoR1auoWN/sWpX4V2FeCKI5XSqhcfQJF/G3oNqQy7/W+P4v7rP0mdBvB4hB2k2ceAGv+SYGEuxR+zSLqmp2CnE6Vx+yoat+vQ9h9+Xl6iD+aH0BVrql6N3140e1gZcQxRrDc6h8iT/ux3cLCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H69psyHK; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6045a3a2c5eso3976918a12.2
        for <linux-pci@vger.kernel.org>; Tue, 27 May 2025 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748380967; x=1748985767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rf03yAgQQGBhErkrSSaEFDElj+fjBRlARFLOXQZblAk=;
        b=H69psyHKbQd+b1T7e2t1AoZ7tFyB8lK5HSQmjuD4D/7k4SnwZHcfu1urhxpPqWYzwc
         qw3Da9W98rPjPC8ZszP9Mcd5P2DBqssZl30GNyhWM66Yb/IdMXGAQXObQO1lNdzTw7zu
         yLWwhTGy04iCD04EUbey1mHl7vQs8uiYqk+b+VEatSNwgPTfVN+XHTWFz5wHHdQf6t78
         PfPNlOGGSo3fYrlwSkDTATULV6VvjZ7Vjd6ezZOhT3c3ch9kFOIPjD4Zyk5hAsXvZEjY
         FU2Gda7Cf1knFTS16k5nMmS7BMg/rG2zpr5I7z8D3yy+na7KjrTQRVXitX4ZsZLNHJO0
         BFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748380967; x=1748985767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rf03yAgQQGBhErkrSSaEFDElj+fjBRlARFLOXQZblAk=;
        b=JtxSTsbz7qcHcpazpoQWQ3yJw32KQvBDjVLMqbqLQdU41/iRMHrKG26uXIp2h6My9G
         In57YR3gPQEqJTEkmBet2s4PO11EK4sAiIdaMK7dVB26GV0iK+1QAl+6YxsuhMoNykaJ
         wfnpdBwHFSYwXRWetxRHZiIiqb+YI9lzksf0oFPdwnG6fgov7KH+7vQ2+xIX6keHPUD5
         jLLKun2hzB/HhdGJEaXvu6yDD/WBKG8nJlh0rfZFCH0pIR5tJFtjBrw9mFyrlXHNTQ7n
         WsrtFRQuYpJ0XXEi5rcT3+OTeuMMuzr26qssR+d/ktYQFG8fVZzlQ1Md4HwcewoWuf0R
         n0dA==
X-Forwarded-Encrypted: i=1; AJvYcCXqHM+334vycJtp+xyGMPtANA2k02TnCksKs2ABDqaFEXOEhtALAjKzhpN4UtA4jpX3R62V0ZWnMeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUThQxiFJS5/XdcdNQ0b1JF5tWdSDl1g0+xAbM85IzLplD2qdZ
	iyRk51Op6sHMbuR8Q3VoT0JgW0raY48JQgOalQSr6PHsTIN0qze63PYKYDcrNPO3/8A=
X-Gm-Gg: ASbGncvKiINj5GJycIyNewTAflGSnal2thKWNiVwb3wvMyuYP+D2GtRfJ5h7C1ly/hC
	46C9ndodQFEwPsPZUyUumBZZUhbXof2G1q4FFLPy0lsnVQ8jI1wD2ADbZxoogU7QJoOgbeWl7H0
	w7Iop/hoE/FX6hAKWg/hzqPN5t8KF4MEpFPz/2/gbYGWi23zcwyFv3w0vy1LuRDkRTE8s0PMBrG
	ha8h2Kr61T5cpvRHRyHPM4ICPK/n+YLBUZbrRELpLA3KRumtNBEFn2xTsfnlb1w1G0fB3FOjTIM
	eLy/Kve4BEZ4eEF/LhbqfUAht9lQGk2Jv5NokmNkep7K+3K3vyld9QtsTHNx6QZB+hgZfwaKgrp
	BGahCGFj8Lcsdn1hPe3hfvSG/HwcSdUID
X-Google-Smtp-Source: AGHT+IFERg8h0M0q68ymhrrsY3ViILpvzLyzrWuNOWeP4SVGe1Wg+ZNpOzN/Rnmv7ShgttQHfLkmmw==
X-Received: by 2002:a05:6402:1d4b:b0:601:f185:fc2 with SMTP id 4fb4d7f45d1cf-602d8e5e352mr13569888a12.3.1748380967163;
        Tue, 27 May 2025 14:22:47 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60517a7f920sm128296a12.53.2025.05.27.14.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 14:22:46 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 27 May 2025 23:24:20 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Matthias Brugger <mbrugger@suse.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com
Subject: Re: [PATCH v9 -next 08/12] arm64: dts: bcm2712: Add external clock
 for RP1 chipset on Rpi5
Message-ID: <aDYthG54Wz3khQ88@apocalypse>
References: <cover.1745347417.git.andrea.porta@suse.com>
 <38514415df9c174be49e72b88410d56c8de586c5.1745347417.git.andrea.porta@suse.com>
 <aBp1wye0L7swfe1H@apocalypse>
 <96272e42-855c-4acc-ac18-1ae9c5d4617f@broadcom.com>
 <CAO50JKVF6x_=MUuzjhdK0QotcdUgHysMb9v1g0UvWjaJF2fjDA@mail.gmail.com>
 <48AFA657-5683-42A4-888E-3E98A515F3B1@broadcom.com>
 <aCIk40642nXZ3arz@apocalypse>
 <3899c82c-d6a7-4daf-889b-b4d7f3185909@suse.com>
 <6953caf0-0fef-4bd6-898c-4f86ee738f30@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6953caf0-0fef-4bd6-898c-4f86ee738f30@broadcom.com>

Hi Florian,

On 09:18 Tue 27 May     , Florian Fainelli wrote:
> On 5/26/25 07:06, Matthias Brugger wrote:
> > 
> > 
> > On 12/05/2025 18:42, Andrea della Porta wrote:
> > > Hi Florian,
> > > 
> > > On 15:02 Mon 12 May     , Florian Fainelli wrote:
> > > > On May 7, 2025 5:01:05 PM GMT+02:00, Andrea della Porta
> > > > <andrea.porta@suse.com> wrote:
> > > > > Hi Florian, to accept the patches, what would work best for you?
> > > > > 
> > > > > 1) Send only the relevant updated patches (maybe as an entirely new
> > > > > patchset with
> > > > >    only those specific patches)
> > > > 
> > > > Only the updated patches work for me. I don't think there is
> > > > that much coupling between the DT changes and the non-DT changes
> > > > (other than without DT entries nothing is activated)
> > > 
> > > It's a little bit more involved than that:
> > > 
> > > - Patch 7 (misc driver) depends on 6 (RP1 common dts) which in turn
> > >    depends on 1 (clock binding header). Should be taken by Greg.
> > 
> > Greg gave an Acked-by so I think Florian is good to take that patch.
> > Which leaves us to the clock patches (driver + dt-bindings).
> > 
> > > 
> > > - Patch 9 and 10 (board dts) depends on 6 (RP1 common dts) which again
> > >    depends on 1 (clock binding header). Should be taken by Florian.
> > > 
> > > - Patch 4 (clock driver) depends on 1 (clock binding header) and
> > >    should be taken by Stephen.
> > > 
> > 
> > Steven reviewed the patches (driver + dt-binding) so he is waiting for a
> > new version which addresses the review. He offered to either take them
> > and provide a branch that Florian can merge into his branch or provide a
> > Acked-by tag.
> > 
> > @Florian what would you prefer?
> 
> I am fine either way, it's definitively simpler if I can take all of the
> patches in the respective Broadcom ARM SoC branches, but pulling a branch
> from another maintainer's tree works just as well.
> 
> Andrea, sorry to ask you this, can you post a v10 and we aim to get that
> version applied?

No problem, just to avoid any confusion I'll summarize what-goes-where with
respect to branches in your repo broadcom/stblinux, so I can adapt each patch
to the relevant branch:

- dt-binding/DTS (patch 1,2,3,6,8,9,10) -> devicetree/next
- defconfig (patch 11,12) -> defconfig/next
- drivers (patch 4,5,7) -> drivers/next or soc/next?

Also, should I split any patches that have MAINTAINERS changes so you can apply
them to your maintainers/next branch? Those are patches 4,5,6,7.

Many thanks,
Andrea

> Thanks!
> -- 
> Florian

