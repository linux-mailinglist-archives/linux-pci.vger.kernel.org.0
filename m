Return-Path: <linux-pci+bounces-6783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9E58B5AFC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 16:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB351B22CF4
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 14:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83437640E;
	Mon, 29 Apr 2024 14:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SI9Vr1qH"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518EC9468;
	Mon, 29 Apr 2024 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714399748; cv=none; b=K5/IW+FUVQ+m3IJoEYooa8XdpSIvl5t3pCCl1BMjzmL6YkXIjt6OjBwaE+K8pgUakY4/xFJjx6zY4BOlxAjJXcIhJxdXJxcO1ApV7OVKw3jitupK0nRhBE6+q327XnwMo27bQI86oBmfQchNblWDvzL8w2eGw47adhx/+s/brd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714399748; c=relaxed/simple;
	bh=vA75/zFWpkErrewBXuJkOdlmx+Yz8j0uhWIhQIud5P0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=btlXqFP7icaYSDE2hWr/HGiKVIzZhEbK+rm1UHxz8xEgJ6CZ5eu2ktrH/L1hAHDZv+/pBV7jEO8xpHFBnXHJ1mgE1Hx7pBi5hrjsI4N9gxZIXNeXT6jds9EDyt89UAHyYnm+wvN3CyQI7596CG+EP74OAi0ginWAq67lHcedHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SI9Vr1qH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=Ma/lOIsOjn5MOqTJBU1zrEvCux3uZ9sv7GB+cMtUSm0=; b=SI
	9Vr1qHq2ikrTl41E0ygAJMaUtCwCGTUWAgkFqUCFJqoYXXVUaRYKrNA1Ek+Oi0ksj8Ky1/DYX03AW
	F0ZRkZ1WXo3ZkxlNFPT75pTRLjHFl+E05Wx+WI2H9z9Tv6xqjK+TGFqhQi5g7QsbgSh1sVv2g3vSX
	zF+6ahSYXCIsNUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1RgZ-00EG3f-1w; Mon, 29 Apr 2024 16:08:51 +0200
Date: Mon, 29 Apr 2024 16:08:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of
 the way
Message-ID: <980ae9cd-2adf-4a8c-9c0e-de002840daf9@lunn.ch>
References: <20240429104633.11060-1-ilpo.jarvinen@linux.intel.com>
 <20240429104633.11060-2-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429104633.11060-2-ilpo.jarvinen@linux.intel.com>

On Mon, Apr 29, 2024 at 01:46:24PM +0300, Ilpo Järvinen wrote:
> orion5x defines PCI_CONF_REG() and PCI_CONF_FUNC() that are problematic
> because PCI core is going to introduce defines with the same names.
> 
> Add ORION5X prefix to those defines to avoid name conflicts.
> 
> Note: as this is part of series that replaces the code in question
> anyway, only bare minimum renaming is done and other similarly named
> macros are not touched.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

