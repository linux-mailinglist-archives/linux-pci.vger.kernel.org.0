Return-Path: <linux-pci+bounces-38190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A12BDDE3D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 11:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4DB534EDFF5
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 09:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9F31B12D;
	Wed, 15 Oct 2025 09:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="VeYXNLrz"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9402270553;
	Wed, 15 Oct 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760522270; cv=none; b=RyIeoUhpkwbaHYxnNyQeilPf95STZLXdm7hiGRgr8d4i60YgO5VUKHV0w85TwAqS307Eh20pPPx5XWIRhWlvA7dleF551oh6uqpVpoPDOYlYcoOdZPP5/FSCfQa61nD4uJJHTij/4m7EzZ5cbRyNPhz7L4lxVTnTZFhFt0lFoeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760522270; c=relaxed/simple;
	bh=cc7YOA0rngoBP/s8PsVA1VBPYCZzWTZjInfpWgZyoe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EKpWNg4K/HxfDS15lXsVmIbHYkgy/UlnSckDFuX52uScxwbhP+IlbOth52pqwJ86KbMDTDVbF/GFjfgU/R89p0i7NzUM1Fih8wSpXOSPG3WSWivY2EVkaZ9KtSy70kUvgwLKDpWuggFsIPCA8iwCHuElixIN2jW1nSkcXwvho9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=VeYXNLrz; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id CA9ED20EF2;
	Wed, 15 Oct 2025 11:57:39 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZ8LopMWWIaX; Wed, 15 Oct 2025 11:57:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760522259; bh=cc7YOA0rngoBP/s8PsVA1VBPYCZzWTZjInfpWgZyoe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VeYXNLrzNwy0w6vJ6neP6rFJA1f+Ka3YD3a3/ted7BVWlQbN1rW6VlfNNdoIyTfeC
	 4elNeREb0Q7hDpwwton1MwOOnoiAEcPS0bBoLg1C4jPWhot3OBBwGxyKfadjFoe7bv
	 5udbZsyBsY5tE3pxdkKxc4WYFDdyttzCtQR0iK5h6Nq2bxMHNtJzbA/gnrxM48xz33
	 c4sm+0FdZYhOs28dO4Tc2dfADYfQuzQuGX8SM2AXtc+k7qoX0dY8xxuuvuEPrF7Kpp
	 0sJEdbB1N99QUwuMz1C/RBOYxe8O1YqOdzsjQrEs5bdv8GX5OjkZYihc0otsHxn0c6
	 ywiF1EQa128Sw==
Date: Wed, 15 Oct 2025 09:57:20 +0000
From: Yao Zi <ziyao@disroot.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chen-Yu Tsai <wens@csie.org>, Jisheng Zhang <jszhang@kernel.org>,
	Furong Xu <0x1207@gmail.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next 1/4] PCI: Add vendor ID for Motorcomm Electronic
 Technology
Message-ID: <aO9wAGs_t0XK0brx@pie>
References: <20251014164746.50696-3-ziyao@disroot.org>
 <20251014204306.GA906144@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014204306.GA906144@bhelgaas>

On Tue, Oct 14, 2025 at 03:43:06PM -0500, Bjorn Helgaas wrote:
> On Tue, Oct 14, 2025 at 04:47:44PM +0000, Yao Zi wrote:
> > This company produces Ethernet controllers and PHYs. Add their vendor
> > ID, 0x1f0a[1], which is recorded by PCI-SIG and has been seen on their
> > PCI Ethernet cards.
> > 
> > Link: https://pcisig.com/membership/member-companies?combine=1f0a # [1]
> > Signed-off-by: Yao Zi <ziyao@disroot.org>
> > ---
> >  include/linux/pci_ids.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 92ffc4373f6d..0824a1a7663d 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2631,6 +2631,8 @@
> >  
> >  #define PCI_VENDOR_ID_CXL		0x1e98
> >  
> > +#define PCI_VENDOR_ID_MOTORCOMM		0x1f0a
> 
> If/when this is used by several drivers add it here.  Until then just
> define PCI_VENDOR_ID_MOTORCOMM in the driver that uses it (see the
> note at top of the file).

Oops, thanks for the hint. I didn't notice the note before, and will
switch to define the ID in driver.

Best regards,
Yao Zi

> >  #define PCI_VENDOR_ID_TEHUTI		0x1fc9
> >  #define PCI_DEVICE_ID_TEHUTI_3009	0x3009
> >  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
> > -- 
> > 2.50.1
> > 

