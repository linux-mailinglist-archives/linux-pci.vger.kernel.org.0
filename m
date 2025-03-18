Return-Path: <linux-pci+bounces-24039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 093D1A67225
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 12:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 814EA176E95
	for <lists+linux-pci@lfdr.de>; Tue, 18 Mar 2025 11:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB6209F58;
	Tue, 18 Mar 2025 11:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KCHl1uMi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30040208978
	for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742295847; cv=none; b=BSdRDtNgU+SAfc9ZURJmirAo0u1BgpjZ6rG/igS/H4Ai68Hm74teIdatwhzfhaVbcINLCZK7AhoUk7QRfYTlws08mFiluaSdM989MCtwYDYy5Cj368xKqfsgJ4RsEDbZIrLHBzDQN5qNuNCr0ugUx6jMmKnl6B0Ql3dtnYNNvcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742295847; c=relaxed/simple;
	bh=4v+Fsi08Fwv3zu1k13Ka+W1n8gTUPuWDc5vnbr4NK+k=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U2DPzh51CX4dYyXFGjqUcdvmziaW/yTRMxJuigb4Sy23TlfupbS6Qt1H+lzG+uw32PmdosW1s0pIrdSTY9VZysmuK063KX8Evgajj/MpBRTdN4Fj7qnnxH/Zso5cgveiHPGSnxuOdxWIfZFsKbDhuSEB5fKe7+717uDOnyY/Qkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KCHl1uMi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac298c8fa50so1021269866b.1
        for <linux-pci@vger.kernel.org>; Tue, 18 Mar 2025 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742295840; x=1742900640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=is8WhR9m8WQE+4k9i/DT+FdMHQKk7RaZk/UQmejRp3g=;
        b=KCHl1uMi40c8cwKLuGWZ5TZVwXh8ppfgC3SmGQWDrjap53sf3ZBnVC7f9rd8KPckIC
         VXg/JL7lXs/3ABH+E+t5ZkN9vwCq/lAmp7CJnRfLWws2n9Ud49DkDEmn/tghKpc2pEc4
         WFdgcMO1JBzddJVqsFNKpmvNhqpY1YmzN3gbs76ZujwSGV6/4E9omSKS0/svpJhjygxd
         t/YUmPNytteNxWUN9GPBg5nzRkL+xemTGfjUvR/lUgMMnwCHpVciN6xSmNJOApA5FGp3
         CzykRdcrEFeBMsPjjsGlYwLC3/KjJgQ/ho+hYdT86w/CWynWved48KD0lrsXDibYWvu4
         9siQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742295840; x=1742900640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=is8WhR9m8WQE+4k9i/DT+FdMHQKk7RaZk/UQmejRp3g=;
        b=m2+9TRL/NDivEkayCRPVU19qmPBTJ+/dHyG2ujHcqr0/6JZRtsBhskCaHx8Ij99ozF
         kH5eKO93Ub5EvcL9Skp7rtev/582c9Qt2Xyfs/lqJYmMEzfvvx1zMBGpMBG4kM9GyoCa
         FKjXfY8zEbJD6J3ocgNRFUROng8Pcr/hEHeC0ntC/7PXRcM6Dw9c7/jxpPCztxW4+iOc
         apuwIVrOIu75RG/qt39t4u1N9B5qT6bClMIQOUkda9E6YqMqeAJkrYan8H2s4eSsjui6
         weqnxXLjyXs2mIQEZEostQeHsEv4H0Vxv+ItKQBqYkXIQZP1TAkq+kXaovmm3QYPL/8i
         74Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUICic0OEsWDasZNFSzQzmQDXSgDyExSf0jCSONa0OgBkyOYH9MW4QsC0tNvaKWUljh1WFiSbzqOEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvK/jXFMXUW+DS5jPoIdJwKRf58lYveuN0VCv3p3mTOwweVvQr
	SX9Wvm5REe5NDudg+THAehjJoCREpzpD4fGA1GVXfh2FDMy0t5LtYmXnYzty6Wk=
X-Gm-Gg: ASbGncuttyYE7SepL6TWxLFuZkjSnyMPRyqyDtGu8FbCtPBytI8DJNfDwAROOoq+kHm
	sF5fDDb2EJsiFSjpPrsdzZF5ihx4+EMrhQX7O6+CVd+WDDSwVIm+Qj/SJMsuA67WgQNc9Lx/uDG
	cSyGuihqYViYoxcZOsF6IGBt6LYjlrRhLGlBOnQqECaivja5KNxsvDwiCYJRZOIKkdO8UVdnfb2
	TWgY1w+chPU691XMh9Pn+IsezmF0CAg4DV8bIkypvwPqeZQtmhxHAc6mT4BDVomQaNe6qNLLSUg
	gdKkPC8Sg1tfvexUgdMpug2wYz91N/1Rfr8TLWlguuKhHBc7ki289EdX/cVE8ylWghIEVPxWzxV
	6bBBbe+FJsdbUfiE=
X-Google-Smtp-Source: AGHT+IHSFIas9nSr0GTvP8XDNoyPypRdkL0u01Zf6bNvQk2jQCXUoByUBqIy6f605R78yLU5u1JN+Q==
X-Received: by 2002:a17:907:3e0d:b0:ac1:de84:dec0 with SMTP id a640c23a62f3a-ac3302d3694mr1426644966b.26.1742295840401;
        Tue, 18 Mar 2025 04:04:00 -0700 (PDT)
Received: from localhost (host-80-117-53-131.retail.telecomitalia.it. [80.117.53.131])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aea4csm828388566b.33.2025.03.18.04.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 04:03:59 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Tue, 18 Mar 2025 12:05:12 +0100
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
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
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v7 08/11] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <Z9lTaKsbLND4i3Ir@apocalypse>
References: <cover.1738963156.git.andrea.porta@suse.com>
 <d1362766e3e966f78591129de918046a4b892c18.1738963156.git.andrea.porta@suse.com>
 <87525350-b432-40b3-927c-60cd74228ea4@gmx.net>
 <Z7dnnW4npJmfOVE0@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7dnnW4npJmfOVE0@apocalypse>

Hi Stefan,

On 18:34 Thu 20 Feb     , Andrea della Porta wrote:
> Hi Stefan,
> 
> On 15:21 Sat 08 Feb     , Stefan Wahren wrote:
> > Hi Andrea,
> > 
> > Am 07.02.25 um 22:31 schrieb Andrea della Porta:
> > > +		msix_cfg_set(rp1, hwirq, MSIX_CFG_IACK_EN);
> > > +		rp1->level_triggered_irq[hwirq] = true;
> > > +	break;
> > > +	case IRQ_TYPE_EDGE_RISING:
> > > +		msix_cfg_clr(rp1, hwirq, MSIX_CFG_IACK_EN);
> > > +		rp1->level_triggered_irq[hwirq] = false;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > It would be nice to document why only IRQ_TYPE_LEVEL_HIGH and
> > IRQ_TYPE_EDGE_RISING are supported. In case it's a software limitation,
> > this function would be a good place. In case this is a hardware
> > limitation this should be in the binding.
> 
> All ints are level-triggered. I guess I should add a short comment in
> the bindings.
> 

Quick errata: s/level-triggered/active high/

Thanks,
Andrea

