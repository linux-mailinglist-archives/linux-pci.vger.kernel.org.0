Return-Path: <linux-pci+bounces-38645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DBFBEDDF2
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 05:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8597D3E6A1D
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 03:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7422B1E766E;
	Sun, 19 Oct 2025 03:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="XJIOxvrb"
X-Original-To: linux-pci@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF07354AFF;
	Sun, 19 Oct 2025 03:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760843135; cv=none; b=rx89sG+L7mkYEQ/ioJHV52uzSBjkMj+OzPYHRaB6hYtNf3cX/U+Z+CVlyCC9lb++0Tc/IZjT7sFOW7KapiBq/s/8qpGE3RC6ccvP3y/72Y2FOF6SyXkxuDc6XzQWxgfow4zcuvmNbf0GAtQMiC/DnI/MOnFYbiD9OqvyJbarPXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760843135; c=relaxed/simple;
	bh=+uOoL1vlxxpS/45krQtIWa2qVyqOXUtLHu9Rd543pCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifh429jFYyk/qzd9BZ/7gJbOScAa3jz0223dkfRHYoU882z0rCYy+NmKJIfUX1+KrPiVjbsF3RAdPVy3dIUnafPpsF8q/Hf6z4TGy85S4OKNdy8G0u+v9mlB/s3T0b9rWuMcETGHjMWD96MHCRDdPd6oBawimiro+lieyFsE/ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=XJIOxvrb; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 66EAB2609F;
	Sun, 19 Oct 2025 05:05:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gSLwu857owtb; Sun, 19 Oct 2025 05:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760843123; bh=+uOoL1vlxxpS/45krQtIWa2qVyqOXUtLHu9Rd543pCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJIOxvrb8FBUhmDA92mtUgGu+jh3ZgHMJcM0byW1uWAcZkv5fb6cjr7aOz8iwUIEQ
	 Qi8Omcvm8FzH8NyUoZ277tMoZbdBSy8U/EWv3g8+lgbGlocdxJUVlo3Yj4VXisGVIj
	 eaF+tmwIKvEBhSjgA9TQ0hmB2lZWio44IRT8QVHeuoPS6dQUIaM2ELK3MCZNljnUBp
	 DCpmQjXhd3k1QyiPdXKhJFzL8Wg8i55hBLmKid2GddR5AO2JnwUlyJAAkmRMhfGvqx
	 OmRv4Vw4ShrOp2Bx1AsVjdPdt3fe2DJqBwl/AZUON3x0D+SaL2J9sxx5jRl0Mm6F/V
	 KLX7151SP580w==
Date: Sun, 19 Oct 2025 03:05:03 +0000
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew@lunn.ch>
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
Subject: Re: [PATCH net-next 3/4] net: stmmac: Add glue driver for Motorcomm
 YT6801 ethernet controller
Message-ID: <aPRVTvANvwLPrBnG@pie>
References: <20251014164746.50696-2-ziyao@disroot.org>
 <20251014164746.50696-5-ziyao@disroot.org>
 <f1de6600-4de9-4914-95e6-8cdb3481e364@lunn.ch>
 <aPJMsNKwBYyrr-W-@pie>
 <81124574-48ab-4297-9a74-bba7df68b973@lunn.ch>
 <aPNM1jeKfMPNsO4N@pie>
 <cc564a19-7236-40d4-bf3c-6a24f7d00bec@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc564a19-7236-40d4-bf3c-6a24f7d00bec@lunn.ch>

On Sat, Oct 18, 2025 at 04:53:04PM +0200, Andrew Lunn wrote:
> > > I was also wondering about all the other parameters you set. Why have
> > > i not seen any other glue driver with similar code? What makes this
> > > glue driver different?
> > 
> > Most glue drivers are for SoC-integrated IPs, for which
> > stmmac_pltfr_probe() helper could be used to retrieve configuration
> > arguments from devicetree to fill plat_stmmacenet_data. However, YT6801
> > is a PCIe-based controller, and we couldn't rely on devicetree to carry
> > these parameters.
> > 
> > You could find similar parameter setup code in stmmac_pltfr_probe(), and
> > also other glue drivers for PCIe-based controllers, like dwmac-intel.c
> > (intel_mgbe_common_data) and dwmac-loongson.c (loongson_default_data).
> 
> Is there anything common with these two drivers? One of the problems
> stmmac has had in the past is that glue driver writers just
> copy/paste, rather than refactor other glue drivers to share code.  If
> there is shared code, maybe move it into stmmac_pci.c as helpers?

I don't think there's code that could be shared. Parameters configured
in plat(.{dma_cfg,axi}) are mostly hardware-details and dependent on
synthesis parameters, making them repeat less across drivers, e.g.
dwmac-loongson.c configures no AXI parameter, while
intel_mgbe_common_data() configures axi_blen as up to 16, but the
motorcomm controller is capable of burst length up to 32.

Another example is the rx/tx queue number (plat.{rx,tx}_queues_to_use),
which even varies among different controllers supported by dwmac-intel.c

Maybe the most common part among these argument setup routines is the
allocation of plat_stmmacenet_data and its members, but I doubt whether
extracting this part out as a routine helps much for maintenance.

But outside of plat_stmmacenet_data setup code, there is some code
duplicated across PCIe controller drivers and could be effectively
re-used. dwmac-intel.c, dwmac-loongson.c and stmmac_pci.c have the
same implementation for platform suspend/resume routines
(plat_stmmacenet_data.{suspend,resume}). I could send a series to
extract this part out, and re-use the common routine in the motorcomm
glue driver as well, though we still need to define a new function to
addtionally deassert EPHY_RESET.

> 	Andrew

Best regards.
Yao Zi

