Return-Path: <linux-pci+bounces-13589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD458987EA0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 08:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B11DB20EF0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2024 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9901F171089;
	Fri, 27 Sep 2024 06:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QcRqs906"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7438B15E5C8
	for <linux-pci@vger.kernel.org>; Fri, 27 Sep 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419699; cv=none; b=ZRyt6fzA4uZuyoFAIImMUjJtPZx08jaqP1+ieGLgXGp7yJFozF+/YE/NHeCdUnYi7C+/J338fYAUUO+vJBF+AF2pODLQ6FP+frEqd2HeHalztsyNudKSxr9kKWm6QtHCITQTrUiOuKkdC7Ka+CABH3zNHeATHhjWwDVmH1wkouA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419699; c=relaxed/simple;
	bh=seoZJVVkae3s3IXICNZ9fMVHO4f0TO87iEurq5MP/xM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMqANpkM6NXSJ1lk1P7euxZClwvdL5tcxoAQ5wJw7ewgysMb3s6VK3munM1aYQA6aE+j92TpZTji8Z4wGERr/mpBY+j47PRwLlxqUg7+oBIUykxQGgHfeU6IQ/+TdULvetI9AyV4LcSrgkwrcdEga+F9Kbg3SN2YywoIpJAcN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QcRqs906; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a83562f9be9so166162266b.0
        for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1727419696; x=1728024496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vBJMtcLG7aQHBsMfuf0SnmVlujb00WcTg7o4/+0tb1U=;
        b=QcRqs906kEG4AOJd4M8ypDrdj2F7Nmar84H0DYraYjLszLCJ5eQcHrp9r3IRQKUsGU
         8Kp/MBCZx6IDm6LcAyBnCM9tf/lzbqp/0fgWz49c0aB9KaF9lj/JnKCBeTbbZ/4N0/ne
         o8+nWNeLPRaAZkq4stpvTHPU9CP7yDs7407FDueyaGYH09XAIs51p0VsaQRefuR+z5ti
         34apjIEAnL5QrI7enG5CLXENbyyD3/ANx0J/76IKxekr5PzUJecsLkv4erB2lfa5YF/Z
         q/8GwsBenU/tt9NgSC84WyrpWiQ7MAGaO+gPtSG1LaGvwbDuXY5LCpq3nbAYMf1qU1b2
         K1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727419696; x=1728024496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBJMtcLG7aQHBsMfuf0SnmVlujb00WcTg7o4/+0tb1U=;
        b=r7lu7imxnOtMCoH2LLyjoAe5iAZIgI+yO9DnSrAtaZdSD4JTiX6eOxwXJxA0yiqLqq
         Km7F1k5qk474wcQNJCboYDnPVmC/WaUvR4bO6Pfktk6I2YJsF6bYScY0k8cegNP392L4
         FyIROFSWW0D7sOi9m74YsH/mCX7Qx8yP/g24BU9MuZSoQoHf04k23nWM5WcCKzzGpmFY
         lTIi6ngaWG4j1dG6hNPj8HeqKLPC1JrE4Uuj/EcbmjkhGK1nU9/s7iSbb6RhcRxBynZu
         s7KkXOrIUTWGN/5w5+YJW4fMOQpUQWMWv6jzFI7swZzLcXBWr8EAy5QtS+9ENM/qp1n2
         zAGA==
X-Forwarded-Encrypted: i=1; AJvYcCWNn/IyvBWcQPIvzviM8XureyujHedLIe36rtmHTPfxv2sOrsOS6Q/TUw1+hzaSNN5od/MNzb3pLIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYLtQ98m+afppXypPWm89ZlHJLAopKMyt2kVXHLhHWx4STO9E7
	Py6WI3usUgx6Xo+mCuEBrKTFuaXJyjSOIQGaf7L+TGcv5bKOl3wBiIzPeg6/Jmw=
X-Google-Smtp-Source: AGHT+IGLDHBeNa6D6RZfpkGvMPVnCQ8ZzsxDN0YoVSie0mpImcNcS8+a9hjT0lBohBj3W/lmYOd11w==
X-Received: by 2002:a17:906:c113:b0:a8a:7d13:297e with SMTP id a640c23a62f3a-a93c4c284cfmr178037066b.55.1727419695753;
        Thu, 26 Sep 2024 23:48:15 -0700 (PDT)
Received: from localhost (host-79-32-222-228.retail.telecomitalia.it. [79.32.222.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c2997e64sm87199066b.190.2024.09.26.23.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 23:48:15 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 27 Sep 2024 08:48:28 +0200
To: Bjorn Helgaas <helgaas@kernel.org>
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
	Stefan Wahren <wahrenst@gmx.net>, Lizhi Hou <lizhi.hou@amd.com>
Subject: Re: [PATCH 03/11] PCI: of_property: Sanitize 32 bit PCI address
 parsed from DT
Message-ID: <ZvZVPA6ov5XgScpz@apocalypse>
References: <Ztnft3p3tb_kP1jc@apocalypse>
 <20240905201656.GA391855@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905201656.GA391855@bhelgaas>

Hi Bjorn,

On 15:16 Thu 05 Sep     , Bjorn Helgaas wrote:
> [+cc Lizhi]
> 
> On Thu, Sep 05, 2024 at 06:43:35PM +0200, Andrea della Porta wrote:
> > On 17:26 Tue 03 Sep     , Bjorn Helgaas wrote:
> > > On Mon, Aug 26, 2024 at 09:51:02PM +0200, Andrea della Porta wrote:
> > > > On 10:24 Wed 21 Aug     , Bjorn Helgaas wrote:
> > > > > On Tue, Aug 20, 2024 at 04:36:05PM +0200, Andrea della Porta wrote:
> > > > > > The of_pci_set_address() function parses devicetree PCI range
> > > > > > specifier assuming the address is 'sanitized' at the origin,
> > > > > > i.e. without checking whether the incoming address is 32 or 64
> > > > > > bit has specified in the flags.  In this way an address with no
> > > > > > OF_PCI_ADDR_SPACE_MEM64 set in the flags could leak through and
> > > > > > the upper 32 bits of the address will be set too, and this
> > > > > > violates the PCI specs stating that in 32 bit address the upper
> > > > > > bit should be zero.
> > > 
> > > > > I don't understand this code, so I'm probably missing something.  It
> > > > > looks like the interesting path here is:
> > > > > 
> > > > >   of_pci_prop_ranges
> > > > >     res = &pdev->resource[...];
> > > > >     for (j = 0; j < num; j++) {
> > > > >       val64 = res[j].start;
> > > > >       of_pci_set_address(..., val64, 0, flags, false);
> > > > >  +      if (OF_PCI_ADDR_SPACE_MEM64)
> > > > >  +        prop[1] = upper_32_bits(val64);
> > > > >  +      else
> > > > >  +        prop[1] = 0;
> > ...
> > > However, the CPU physical address space and the PCI bus address are
> > > not the same.  Generic code paths should account for that different by
> > > applying an offset (the offset will be zero on many platforms where
> > > CPU and PCI bus addresses *look* the same).
> > > 
> > > So a generic code path like of_pci_prop_ranges() that basically copies
> > > a CPU physical address to a PCI bus address looks broken to me.
> > 
> > Hmmm, I'd say that a translation from one bus type to the other is
> > going on nonetheless, and this is done in the current upstream function
> > as well. This patch of course does not add the translation (which is
> > already in place), just to do it avoiding generating inconsistent address.
> 
> I think I was looking at this backwards.  I assumed we were *parsing"
> a "ranges" property, but I think in fact we're *building* a "ranges"
> property to describe an existing PCI device (either a PCI-to-PCI
> bridge or an endpoint).  For such devices there is no address
> translation.
> 
> Any address translation would only occur at a PCI host bridge that has
> CPU address space on the upstream side and PCI address space on the
> downstream side.
> 
> Since (IIUC), we're building "ranges" for a device in the interior of
> a PCI hierarchy where address translation doesn't happen, I think both
> the parent and child addresses in "ranges" should be in the PCI
> address space.
> 
> But right now, I think they're both in the CPU address space, and we
> basically do this:
> 
>   of_pci_prop_ranges(struct pci_dev *pdev, ...)
>     res = &pdev->resource[...];
>     for (j = 0; j < num; j++) {   # iterate through BARs or windows
>       val64 = res[j].start;       # CPU physical address
>       # <convert to PCI address space>
>       of_pci_set_address(..., rp[i].parent_addr, val64, ...)
>         rp[i].parent_addr = val64
>       if (pci_is_bridge(pdev))
>         memcpy(rp[i].child_addr, rp[i].parent_addr)
>       else
>         rp[i].child_addr[0] = j   # child addr unset/unused
> 
> Here "res" is a PCI BAR or bridge window, and it contains CPU physical
> addresses, so "val64" is a CPU physical address.  It looks to me like
> we should convert to a PCI bus address at the point noted above, based
> on any translation described by the PCI host bridge.  That *should*
> naturally result in a 32-bit value if OF_PCI_ADDR_SPACE_MEM64 is not
> set.

That's exactly the point, ecxept that right now a 64 bit address would
"unnaturally" pass through even if OF_PCI_ADDR_SPACE_MEM64 is not set.
Hence the purpose of this patch.

Many thanks,
Andrea

> 
> > > Maybe my expectation of this being described in DT is mistaken.
> > 
> > Not sure what you mean here, the address being translated are coming from
> > DT, in fact they are described by "ranges" properties.
> 
> Right, for my own future reference since I couldn't find a generic
> description of "ranges" in Documentation/devicetree/:
> 
> [1] https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#ranges

