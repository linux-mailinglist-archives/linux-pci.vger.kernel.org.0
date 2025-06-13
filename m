Return-Path: <linux-pci+bounces-29782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B68CCAD96C2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 23:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8152189DBF0
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 21:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75D122E3E8;
	Fri, 13 Jun 2025 21:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrmwyBBA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BD5226D0F;
	Fri, 13 Jun 2025 21:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749848502; cv=none; b=RQvOdmLK6XJ3FFpBSn2+IPuBsIHJeVU//jVEtH/nicX2awSaEWNw7x4Uuz8Z9hXQu2uKMH4ilkEgVBwS5KZo5See4OM+cKBvAmaJEfKLddoCcjj1AkfC8pywzmNOMJ8Fl4F8LgumhcKHQ13MVzcPl53aab4aHmE6gj+Uh6Lje5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749848502; c=relaxed/simple;
	bh=WSsEb8PQcuYS5aVeXGNEh761dSAbr4YH/Hi8Q64XgHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=guN2fAvxXEUvt93fCMANIZ5qfpMFYGFMa9lYGuAuiZ5ivnnekP4mbG+xUMaFAx8X2K+cBGPusGDGz+SCOsUoOvYScooLfNIUvlvfrYSEPV9aruxI4KNn0SG75XvfKqptgBvh9yigUIV2D+fj0JeG3ZBZVpg+gFGHFZkMaKalHsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrmwyBBA; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso2997446b3a.2;
        Fri, 13 Jun 2025 14:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749848500; x=1750453300; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ea/eTX+P8wMCNrPfmeI34ssYwADQCsaNDUn6KV6aWI=;
        b=PrmwyBBAwsHjiTsDlA7zReWzeCUVOP8pc83mmQpoGsNxN9FUOOO+Gs5ORLH1iDxXx+
         byN9Ac5OChvRxfXQOoKQbceDmHrpdoDaA8h6SiNRGTtbXBhyAt0gGOVhx+imh56/bq0G
         N6q/86hJC0uUFsu67mBSIHJYmE7vQv9AQmAWxlyRYbxJY4VprhmC5CU91OEX4achBUYG
         m/zO/FwM5UkiBKuI9xEv2ONOEytGiOTXgPJaZEfpvP3xWLtIbfIEOi4IQIiG10IBTIcr
         fO750U02pGhNNgCs3unoNXnFZacPuHIfNZZJCNlZzysoP1d0iS0s07O06b8KFm0FOugF
         I0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749848500; x=1750453300;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ea/eTX+P8wMCNrPfmeI34ssYwADQCsaNDUn6KV6aWI=;
        b=u3kR95kfr/3ZxPjYUmBb0jpgIGR2Za++5qUbmSKhlRJBqJAP6rhxCapm3WZ15ZYh+E
         7fiZwOPfUI63Cbf0O7ZiMnGHP4HF/FOm2SX2xJtKSRSuAGdRAv3jorNnxz3gcvtcZ+6e
         F+s7HNTv/WrL9wqi/IueaIZoci12vKWc4gpOMVAcjsc+wpzFPBFIsWEn4riIFajPq9Jp
         l+SS2vaM4NItI/xZHTVWnk1Wh+tkchd9ItI1U3wZ1k3J/YGnpCVDn2EsslcZdMfkOgBd
         /o6R0yv9TXZV2mul4uQhzipxwwNhUinb8oBX6qaP1LnR9KapAbn1cKMHaQ/CqoAEul86
         3Ngg==
X-Forwarded-Encrypted: i=1; AJvYcCUA1ZNVbyWG2pwPPHdN8moEgP3TISnCit0FcPe6KOXoSoWiAzXjuWxJnHu0RUUBZKtTfGpUFI9ATJHczlM=@vger.kernel.org, AJvYcCW+a/QKtaQl4Boomq99p7XYNdTOTZBeZV0X+DSFw2z9szr83lFMMBQfAC77+aypTW9kkBhx/T9nj76m@vger.kernel.org
X-Gm-Message-State: AOJu0YzmzqzqYjxLnpHSu+Zyr0+1HzF0SAkOdNMDOXGhjPGWwpsZeY1o
	aMiW3hL0jG1NEV9byJ9uz7aE8+MUuSMYorU7pf0cw7GoEB8kLbWiw0CA
X-Gm-Gg: ASbGnct+duS8tqRMU1mMFXFRbj5qI0N6fpe7s+/F5Y6ZF6GoUXDVphe0JDq0+fHnT2b
	NFjv+lgjpwPmeyZxTByNEFNx6uzEBCXt4IULhl+tAlnSzhtTpDxcLN5M4AKXig5vIpavUHuMxBg
	zbrmTIYx9bAI/yFnswGQ3yhCX5hcYKaUjwidkEN92QWSpDjcqN777b2zgF7uIXvINq8us9Yo/cr
	0/DfaIUdRaemY5p1a0WZWuPPOQ9g5pW/qLR96Yk6FB/isk08dNqPyEjB6x63RjFWwECDMniiZTQ
	b5k6EjQqQlufDQObn6ZolOqN2oZqsJ53evOH8QpZrIZCWyHQOgz2LFVw4enE
X-Google-Smtp-Source: AGHT+IEsJDU1mE5FbmCdQgmCN7qJMpOL0gk1MDx5GEVgrbcSEqjFwfTmcrPEttgVlM8tBhRjqtH0pg==
X-Received: by 2002:a05:6a00:a85:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-7489cffbb1emr1058801b3a.12.1749848500523;
        Fri, 13 Jun 2025 14:01:40 -0700 (PDT)
Received: from geday ([2804:7f2:800b:84a2::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900051a6sm2111176b3a.42.2025.06.13.14.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 14:01:39 -0700 (PDT)
Date: Fri, 13 Jun 2025 18:01:34 -0300
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
Subject: Re: [RESEND RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe
 defines
Message-ID: <aEyRrtMZ0LidhyOR@geday>
References: <aEyJhoiPP0Ugm1t6@geday>
 <20250613205023.GA975137@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613205023.GA975137@bhelgaas>

On Fri, Jun 13, 2025 at 03:50:23PM -0500, Bjorn Helgaas wrote:
> I don't have access to any of these TRMs, so I only know what's in the
> driver.
> 

They are not under NDA and can be obtained though Rockchip's
official site:
https://rockchip.fr/Rockchip%20RK3399%20TRM%20V1.3%20Part2.pdf

> When you say "without fear", are you saying there's a way to do that
> 32-bit write such that the LNKSTA bits are discarded by the hardware?
> Or just that the hardware forces us to accept this potential status
> register corruption?

I meant to say those registers themselves are defined in TRM as 32 bits.

> 
> Is this something that could be written using the config access path?
> I guess probably not, based on this:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-rockchip-host.c?id=v6.15#n141
> 

That certainly looks frightening.

> Bjorn

