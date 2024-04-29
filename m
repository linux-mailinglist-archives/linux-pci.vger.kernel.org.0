Return-Path: <linux-pci+bounces-6785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FDB8B5B80
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 16:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7021C20B01
	for <lists+linux-pci@lfdr.de>; Mon, 29 Apr 2024 14:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D247E0E9;
	Mon, 29 Apr 2024 14:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0WDksdeI"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624F47D417;
	Mon, 29 Apr 2024 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401518; cv=none; b=CLOgjyghHE6Ing3RH4t8fZN11BI+CqzlGY+fTvpt1mnlJjsjKqE5CGJtlKBZUrK+4CkCNDDnYqrTNgJsOyFEI4YZvZa8k/kwXQukdq9wKgdZgjI9DJCitHBxnZC7cqUGbgFrcDTeE0O3vrt6C6fMS/eecbP2+neIu02uQI4JDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401518; c=relaxed/simple;
	bh=t2BSfxgJvWgwaNrRX1ok6qCZPCyCIo+TTodKZJCdTV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7cgwNj0tfZwddL3Z0c2QGMVKxw+Rrp0bjrPUK2D2D2NXvhD6R6qvKEBqbwd24e2jzDF7qfhaRhyNJQXLqeMTOqjlIj9q//4H8o9d65N0Qnktk7xxolEUsegY9X6mfwiHp0oh6cMC5Jlo+d5FNM6iIJefGGB/obTIhf1EupsKek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0WDksdeI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=+aPhiAT0TTtlUBQ7CsIrdccUNliWqGD42g0ozUSk/gA=; b=0W
	DksdeIPRYWyyxCCemJR8IXcaUI86CRoAhNsNNpUfNwxglqmNfA9v45EifwIsZruZZdQU3Xq7+BQkK
	VywoUviucI2Yhe8ef9qKsiRuvG3OPfUJVLbmuFfh6NHJZ9dRI7qgUAn9pDtc0G+h52BBgD9QzaOY1
	ZABjZaHrwVzzbgg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1s1S9A-00EGAR-1d; Mon, 29 Apr 2024 16:38:24 +0200
Date: Mon, 29 Apr 2024 16:38:24 +0200
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
Message-ID: <1d3606e7-0cb5-4180-92ff-5b9cec7a64ad@lunn.ch>
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

Hi Ilpo

What branch do these apply to? I wanted to test them, but i get hunks
rejected:

git am < 20240429104633.11060-1-ilpo.jarvinen@linux.intel.com.mbx
Applying: ARM: orion5x: Rename PCI_CONF_{REG,FUNC}() out of the way
Applying: ARM: orion5x: Use generic PCI Conf Type 1 helper
error: patch failed: arch/arm/mach-orion5x/pci.c:276
error: arch/arm/mach-orion5x/pci.c: patch does not apply
Patch failed at 0002 ARM: orion5x: Use generic PCI Conf Type 1 helper

I tried linux-next, v6.9-rc6, pci:next

Thanks
	Andrew

