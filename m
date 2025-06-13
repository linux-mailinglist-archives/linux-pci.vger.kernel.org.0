Return-Path: <linux-pci+bounces-29779-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E841AD964C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC3617BBDD
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8D1E0DB0;
	Fri, 13 Jun 2025 20:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/lKuQzO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC9C148;
	Fri, 13 Jun 2025 20:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846781; cv=none; b=Vf2lNzAzmwcnVuQCl/3+2Bf86ZszXHizcg10Qtu6KKQxObSkFc3bBJDLEvVsLfvhqWXgFYKSN/tIy8KzWMH1Rw0J3e+opKeq/72w8vfkHSA+fMhHj808wWE5B+xs+drNj42xF20u0tDmviOcav+D6S8gp9HDxdHozvyOXMMatdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846781; c=relaxed/simple;
	bh=9v3ZlTT3uTG28Lb2pGd4rNu9RPW97DkH1ephQbQHVew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvI2Ir/faVNFvFiW33ncOag8DWiV4aCmp3pwt1oPotApDcbJyMcviRNHxmWYQQBMUAMWGobg2VOfS+k2dDQNKXBeev25Sk4+GKlxHH0S25DNsF1HSlp8YNeDfklph497SPph+NdT43pfFlQFLLy/gOIaLrI836aH9NcRIwOn4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/lKuQzO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311da0bef4aso2867727a91.3;
        Fri, 13 Jun 2025 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846779; x=1750451579; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MeqoJN1VtlXAfshyNe71l2zrQUFvyNq6mFSXz5PurIE=;
        b=b/lKuQzOKzvuC9O4ta1e420Tb5Bn/Z5K8ApbyxExnxJcYMcX6S0JTXaAmMQ2I8cCwH
         qHGjMTrAxuFnOOEaJQzV4UQICVlu6xcs+K5LELVjY2rTNR/z2QUyxneCipLYptb8NyG/
         vkTEzT8mbb1Gj/PrZWDoP1I8hsPejAxfEPjZL/Xw/dYxc2oTTzZNnjraIdrJ0EtLcSr2
         Cc7btaYA3ABz5ML2KiISl8WgchAoPfVuuMXWTKpQGVw8RcRqetAoINw8w9Zz4cZNVUW9
         mSlm0Jz/BJTYjthK5y3vfAByG8rSQxXxXdHBJrQG71N5xf8A08zjFclsMUCMr3r+Qfd7
         08zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846779; x=1750451579;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeqoJN1VtlXAfshyNe71l2zrQUFvyNq6mFSXz5PurIE=;
        b=oGL223DAkU/KBG4nDvPjo+90qWKLxYsl8L1o1ivpt4bmrYk2CA6RAVxZ04iAb2PDEm
         7FWj37+y+1wIUp/q3oiUwIf1AXoz9p7L2s4E6SmHqDP0EDxDGHKIY3xZWBMfd7TVwy3t
         Mh6Jy31/NXrTvOnW43hjTPr963MyFuPkushDRqNGN7UBvOqyYPlzkCzYOd3EdzST5HuT
         Tv6KE866+dJSLvAz+ZGGz4JpjbiglwOYEHO+TtfAAzZVckm2fm4fEmEvrWjsS0aND3Ez
         /bs7kR344hCq3U5QT5ZpRrvxElFd7Vh26GojoyCAX1xk4y7H+6+C43Qkk47NEWotfdO9
         LZXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPIUl4aPMMg+yhb3XrrHyEz4xRLJu8V1vsUNwkCWynYsUTK5y29SLSjKr7t9LajBsyUBdYBJs/i1yNVqc=@vger.kernel.org, AJvYcCUhmtr8FOBuCm17VPLtBYLz89QcW+3+WtYuWMo8S2I6xWR+jTc3787Sty8GyWM1i/bldcvCXi0K71CQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk5JgsLUZGYTKUSrlVXugaRhmeJejkksBLOt4dNCjoHyz/k0nf
	M3dYglC1t/a2qyWbZe21JyMmsxPtF/gKTRGHHU9Dlihq4xYAIr0EAtjK
X-Gm-Gg: ASbGnct9ROaKGpzCkW7OzplHGy5p/xUvkUYEuj5m7EworZIT6M96RWEX+4EkbngFtEk
	yXc3JFbMLSgaZSQOp3j2CSy8bDyOtqSQtln0lyjOnNOls29+80TLz5sfB2KUTRlnVs1NrH/OIgv
	Mv/ukUzj1whm0kvlqxLOTL2ezPVOhL3hMUrkiVGtJJMuT8+8R5gh9zViI67OFCNHKHFYiANZhu/
	4D11kkhn3McDoLT55+mAPstN/rRj7GcddhDry2DltqgCs0m1dbnft6PdvDDQq6xc9eR8xkro9bT
	GVmEtAc8Rfjfr2QPBveSQeVNkJ+Ty4rqsq4sdXpQvQSzugl2uA==
X-Google-Smtp-Source: AGHT+IF94BUUijNOoyBUX4URz+4YXCZAGHiqdCm6FPEJcMyBQe0H9exqeo272TTJAvxI2G2WRqOyNQ==
X-Received: by 2002:a17:90b:582f:b0:313:bf67:b354 with SMTP id 98e67ed59e1d1-313f1b87a40mr1776345a91.0.1749846779495;
        Fri, 13 Jun 2025 13:32:59 -0700 (PDT)
Received: from geday ([2804:7f2:800b:84a2::dead:c001])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1c5fd7esm3812515a91.37.2025.06.13.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:32:58 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:32:52 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 5/5] phy: rockchip-pcie: Adjust read mask
 and write
Message-ID: <aEyK9BcyZq1qiNQD@geday>
References: <b32c8e4e0e36c03ae72bff13926d8bdd9131c838.1749827015.git.geraldogabriel@gmail.com>
 <20250613202056.GA974155@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613202056.GA974155@bhelgaas>

On Fri, Jun 13, 2025 at 03:20:56PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 13, 2025 at 12:06:28PM -0300, Geraldo Nascimento wrote:
> > Section 17.6.10 of the RK3399 TRM "PCIe PIPE PHY registers Description"
> > defines asynchronous strobe TEST_WRITE which should be enabled then
> > disabled and seems to have been copy-pasted as of current. Adjust it.
> > While at it, adjust read mask which should be the same as write mask.
> 
> Not a PCI patch, but "adjust" doesn't tell us what's happening.
> 
> From reading the patch, I assume that since PHY_CFG_WR_ENABLE and
> PHY_CFG_WR_DISABLE were both defined to be 1, this code:
> 
>         regmap_write(rk_phy->reg_base, rk_phy->phy_data->pcie_conf,
>                      HIWORD_UPDATE(PHY_CFG_WR_DISABLE,
>                                    PHY_CFG_WR_MASK,
>                                    PHY_CFG_WR_SHIFT));
> 
> actually left something *enabled* when it meant to disable it.
> 
> Maybe the subject/commit log could say something about actually
> disabling whatever this is instead of leaving it enabled?
> 
> PHY_CFG_RD_MASK appears unused, so maybe it should be just removed.

Your line of reasoning is correct regarding the TEST_WRITE async strobe
register, and there's a picture of the flow in Section 17.5.3
(PCIe PHY Configuration) of the RK3399 TRM, Part 2.

I'll make sure to be more clear in the commit message.

Regarding PHY_CFG_RD_MASK, yes, it is unused AFAICT and can be removed.
It's leftover from BSP where the debugging function phy_rd_cfg exists.

Thanks,
Geraldo Nascimento

