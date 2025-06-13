Return-Path: <linux-pci+bounces-29776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF298AD963C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 22:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4941C7A7BC9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 20:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBD8231832;
	Fri, 13 Jun 2025 20:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2IWGEhL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC025291F;
	Fri, 13 Jun 2025 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846415; cv=none; b=LF6CynRnaEFVJcMLpgrf7vokfdS9qI576aZV6bzp6hzAE1UfvtlliZyANNgo6z2wnFO5AGi93Qa7p9VH20axQbQiSwmfyl1egFpQC7MpL0OKbkM1+8hTMCsYRRjvxmiWo9PctOTH/8+woCCV65uzqgqpqoVEEYIT7718pf+Fzsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846415; c=relaxed/simple;
	bh=jfwW+vYg9qynM2aoKF4Q9s0thfx+wKwgfpI1ZIAROeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skOULADFIwiFLBSbU/8AAKk85L72uQfgkwE2wBCgLZTadzY4krde2o2Tm0psurMUPJcwmnnHrTLRoavHcaF3f7jjjaoaRGZ6j6zPmCKTesNuvTygqn0s1VEwRwDJcCeXMfH6wJGP70t4e/HCu1rabs4w7NO066lzyrk7TSQCpvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2IWGEhL; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-23602481460so25361785ad.0;
        Fri, 13 Jun 2025 13:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846413; x=1750451213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GwN4Vlj9V/Si30XGhhYcfcrSEwd+tR4XQQLqO9MnNd0=;
        b=h2IWGEhLd6IfwxWZUebOIPcT0NkpUDkA+VQy8/WFlT/c28IfsHP/mn4uwfFFedNBuz
         /sETkS28MXMu+Y1ySlWqqA/ZmJPfYmJPni9t46iDMYXrvoc/GK6jup8dYD5WzENdNTba
         Eo3vYtpHOJ/f4mNotpPlnKUrTND3PPGSgzA2iYBgy6oSWAZvtyrATJQUYCSxFpDEduoT
         15U8oKq02DTMueO2c5O9uuUwuBO/T4NDawjtnSAAqeBpJuGdBekOmgmwS+mBugnPu2US
         ZsyaCot9rHf6N46Ggw/vxGiCamBzKx4HX6OX4HjVlkgJlcxm6JgT0/uHi+dGV/KXMC2z
         aZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846413; x=1750451213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwN4Vlj9V/Si30XGhhYcfcrSEwd+tR4XQQLqO9MnNd0=;
        b=V/07qNhjytGECAnMUCeRKnRBYPrSDnAc8ZBC9KHcsfas8yEm5ryRgygGHxQZPJc3/N
         Zoq5FYPR6ZDyzPUnEBSxeFQEqLCTbCk2z8cHtj+R40YjBoBntcxwabfs21h04m7V+7fA
         9LI2mf4xunAhU+CDjHqAOfjbyqHnWWbz8JDIMllaW5ok5qmZCI1QcHbL8hM4tVgKeLhw
         mocPZZOo4BjCBJCXrUc+lgcK0im8eL6JXIVknubah1qz1UTx0ETsi4QzEzRjq4w174h7
         XiefIkU/Vf15eQRpFywOr0mkzuzj+EvFg7LbmJxgZoea7A/c6/Yr1OdoJ5nKRqv3l1XY
         midQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIEcMM/9HfsM/TYVxYZyo5UHB2LH+Qgn+nuxFmpc4lLTPOXoAFVRhP2oUlTnGitg3uu0onO1+pvJZV@vger.kernel.org, AJvYcCVQaaduN4oNFb9C49XorQnAgW4ZJdsDY+3GV2ikzlqRSVYx64S2aULIwHuB8SPDtq1EtDlT014MgS3lX0M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7zUKwfNuyqnkEWermhS2SW1zs89BysTCmtYb3tGeYbwIHnsSd
	0o4dfy3Ms3/Svy2ccFq+HipxM+0iwoKf6AWxbx/OFvVO534PyFWHXHUj
X-Gm-Gg: ASbGncs4btThtu7Dp9lKpw5njIT6h6edybpQ2tH292OYg0W/hWZGQa6Y8rWQRLmXJ/E
	Y8+y8EPObsfvPR0EbkdrsdOo47Zge8HJC5zHBOryXpL8E6mfsGfFeHcMSnev9dlxK01duiNBtrF
	jOCJyUi/WvUnTRrMLRUQByp+11/WBU+ves/S86kQS0sBONSsC9HSt2aDNjTAM1BjG+jpLnRw5tE
	7cXnr+6yOMkbrum3XZiGoTT94/uHY4t/5Pj1qW1PypRt74n2e+2q5Hw60oFOyJlynfNp2nd0a+V
	E4cXUrbgoUA4+/OCTTgjpOYhpyOYWBKuiyoINcByGnzv9dM/Jw==
X-Google-Smtp-Source: AGHT+IFMYwG+tAQaxnOsOinKwBE/kqO0tD/aAkh1rN9LDtPDMa0ftPIDcZwR/F9qih5cAjFZot/vjg==
X-Received: by 2002:a17:902:c941:b0:231:ea68:4e2a with SMTP id d9443c01a7336-2366b12f867mr13009585ad.34.1749846413249;
        Fri, 13 Jun 2025 13:26:53 -0700 (PDT)
Received: from geday ([2804:7f2:800b:84a2::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d0b12sm18838725ad.253.2025.06.13.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:26:52 -0700 (PDT)
Date: Fri, 13 Jun 2025 17:26:46 -0300
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
Message-ID: <aEyJhoiPP0Ugm1t6@geday>
References: <992ab6278af59b8f2f82521bf4611f69a916bbe1.1749827015.git.geraldogabriel@gmail.com>
 <20250613201409.GA973486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613201409.GA973486@bhelgaas>

On Fri, Jun 13, 2025 at 03:14:09PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 13, 2025 at 12:05:31PM -0300, Geraldo Nascimento wrote:
> > -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> > +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> >  	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
> 
> It looks funny to write PCI_EXP_LNKCTL with bits from PCI_EXP_LNKSTA.
> I guess this is because rockchip_pcie_write() does 32-bit writes, but
> PCI_EXP_LNKCTL and PCI_EXP_LNKSTA are adjacent 16-bit registers.
> 
> If the hardware supports it, adding rockchip_pcie_readw() and
> rockchip_pcie_writew() for 16-bit accesses would make this read
> better.
> 
> Hopefully the hardware *does* support this (it's required per spec at
> least for config accesses, which would be a different path in the
> hardware).  Doing the 32-bit write of PCI_EXP_LNKCTL above is
> problematic because writes PCI_EXP_LNKSTA as well, and PCI_EXP_LNKSTA
> includes some RW1C bits that may be unintentionally cleared.

Hi Bjorn and thank you for the review,

while your rationale is correct per PCIe spec, per RK3399 TRM
those registers are indeed 32 bits in the Rockchip-IP PCIe, so
I'm forced to work with that, but without fear that other
registers get messed-up. (See for example Section 17.6.6.1.30
of RK3399 TRM, Part 2)

Regards,
Geraldo Nascimento

