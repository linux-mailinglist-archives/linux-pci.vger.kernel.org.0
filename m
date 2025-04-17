Return-Path: <linux-pci+bounces-26080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D622AA91866
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48B8C3B2555
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9813F22A1CB;
	Thu, 17 Apr 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcHcbGbB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3322288CC;
	Thu, 17 Apr 2025 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883686; cv=none; b=JOeCtiCvKTV8VskwiZjEtpC9t1DGfvzvcfvYsdIdvUH55hD2waCAahyC5HiOQ7GnNTlA37nQzZuChhm0VTKWrnyBmOyNlzt1i+mjNjz+dHJxpg0L5eijp+iHGrByOlZK28smJPgVxZen9hNWN+AnOnhiPTLn7fwV5Jsz+yrfrS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883686; c=relaxed/simple;
	bh=vAhYR0DxNYTjOSzwAc2fvxm9d0b4bcwj8L5gWZR5QS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rAa9divgBB428DFfG8a5QjS313qMoWo6QWLjjwna9e/FxkmMTHKDd76f4a13u8cCPLTUSVxT5+qjww1cS/dVZX5lal7h9UFZ4cRDsnkch91KLBL4GJq+I/eXRGjv51ZZK9kwXHnYfi2iqV+n1EpPx7B3APQrUcpN5oQH+rH8eeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcHcbGbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D29C4CEE4;
	Thu, 17 Apr 2025 09:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744883685;
	bh=vAhYR0DxNYTjOSzwAc2fvxm9d0b4bcwj8L5gWZR5QS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcHcbGbBno1NM6VGd/kWkWEc0O9+cEg0+k7nrMTYrN1TpBGrPb3u5LPztWhYLn5bp
	 dvJ+8Hy4Gyz1nLpiyNAYO3nzeGmMYRBZtBTVQRfFJMwCPuphKiQg7KAIEwHBbmycdU
	 Z1DdujIfnC+zCPPj51MMTdviv8BNdzYeuqZPPydCdHj0QGRtJEptj+KUQjqWt4ZmCl
	 JK18Dwqr9xGceHLH5jI1GjPC2PvOLtfZ7vakGOgS/opSpbp764yjIyUuUSZ5TjRjHM
	 1L81SKYKL0QkGQ2UUbNyyJy1Sq4cIZXhBg5FG8UwUWGFI5n57GeD9wcmUDsXO2bdHW
	 rUP9UGK6Sl1WQ==
Date: Thu, 17 Apr 2025 11:54:40 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org,
	kw@linux.com, bhelgaas@google.com, heiko@sntech.de,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, thomas.richard@bootlin.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
Message-ID: <aADP4JZmSVACXKwd@ryzen>
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
 <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
 <aACsJPkSDOHbRAJM@ryzen>
 <ca283065-a48c-3b39-e70d-03d4c6c8a956@rock-chips.com>
 <aACyRp8S9c8azlw9@ryzen>
 <52a2f6dc-1e13-4473-80f2-989379df4e95@163.com>
 <aAC-VTqJpCqcz6NK@ryzen>
 <4c2a94b4-e483-426f-b7d8-ed98ac474c63@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c2a94b4-e483-426f-b7d8-ed98ac474c63@163.com>

On Thu, Apr 17, 2025 at 05:48:04PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/4/17 16:39, Niklas Cassel wrote:
> > On Thu, Apr 17, 2025 at 04:07:51PM +0800, Hans Zhang wrote:
> > > On 2025/4/17 15:48, Niklas Cassel wrote:
> > > 
> > > Hi Niklas and Shawn,
> > > 
> > > Thank you very much for your discussion and reply.
> > > 
> > > I tested it on RK3588 and our platform. By setting pci=pcie_bus_safe, the
> > > maximum MPS will be automatically matched in the end.
> > > 
> > > So is my patch no longer needed? For RK3588, does the customer have to
> > > configure CONFIG_PCIE_BUS_SAFE or pci=pcie_bus_safe?
> > > 
> > > Also, for pci-meson.c, can the meson_set_max_payload be deleted?
> > 
> > I think the only reason why this works is because
> > pcie_bus_configure_settings(), in the case of
> > pcie_bus_config == PCIE_BUS_SAFE, will walk the bus and set MPS in
> > the bridge to the lowest of the downstream devices:
> > https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/probe.c#L2994-L2999
> > 
> > 
> > So Hans, if you look at lspci for the other RCs/bridges that don't
> > have any downstream devices connected, do they also show DevCtl.MPS 256B
> > or do they still show 128B ?
> > 
> 
> Hi Niklas,
> 
> It will show DevCtl.MPS 256B.

Ok.

I guess that just means that the bridge itself is included in pci_walk_bus().

Let's wait and see what people think about my proposal earlier in the thread,
or if someone can think of something better.


Kind regards,
Niklas

