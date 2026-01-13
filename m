Return-Path: <linux-pci+bounces-44679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7500D1B7A0
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 22:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A15973031CC4
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4EC322753;
	Tue, 13 Jan 2026 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6L4PimT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196681B3925
	for <linux-pci@vger.kernel.org>; Tue, 13 Jan 2026 21:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341017; cv=none; b=YC8/1A3LSIV+er6+xdgDZK6TM7STmus2DGB67Ut46iP5C7B8Jw6C8QX28eCvuA62N51MAWEv0q68XKY8B+oPdWeYEWg+tV0/BW8aYspCW2G59VoAXhjr23dJbBiEMDZL7H8/gaLaYDLPYx61tZVno+N956RfgGQ26zg4nUA8Jt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341017; c=relaxed/simple;
	bh=mHj/NEGaKckkGqOd3Bd4ppZNGpNvkNokTu/s5NsgQPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LuWQLvU5ivQf/NMhozBmpra0KELD6twbCkdRT8GtMWygpMybVWanjFvuHl/d40eDxIb66HsslzmRkxEpW9WgGzNB/vpQeniqo4Ao6zVunZyc4LnffgDmTPvf/NswLXc1MetEADvVhTFzqBEEUvpM7LcZq770xVqcu52cOgS3pl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6L4PimT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C458C116C6;
	Tue, 13 Jan 2026 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768341016;
	bh=mHj/NEGaKckkGqOd3Bd4ppZNGpNvkNokTu/s5NsgQPE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=W6L4PimTVf4gw2uiXO9cB2pnDKoTzZYjVJwXJEPnr7JbkqEIZm+c0V4bRGEbHaafW
	 KdyZ3FDEAWpbLh4iNCLsKzn9PHP6xINn4FS/wR9Mn4y8rqdiLFKiNh6i4FC7DxGJkp
	 pKM2a62w71xhBETb2G8K7r8ictp4+b05EgbWXZPew3Jka+BGSTzSZPc4E5dMTVlsyh
	 oem7Ar+lRq4ACt+z9Qw/gVnfvvYKUqDSRjpx8iogEMgcMOA8G+M8bS8DKy2XV1Xnq7
	 5cI4tjp9awswyNKzH+YGH0UXgSHq3Gxa23CReO+N+ajvTSEmSwqIPsR8vdiPwk1Rda
	 DQvW/GX5Ge7yw==
Date: Tue, 13 Jan 2026 15:50:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Jonathan Cameron <Jonthan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI/portdrv: Use bus-type functions
Message-ID: <20260113215015.GA781767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1764688034.git.u.kleine-koenig@baylibre.com>

On Tue, Dec 02, 2025 at 04:13:48PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> with the eventual goal to remore .probe(), .remove() and .shutdown()
> from struct device_driver convert pcie portdrv to use bus-type
> callbacks.
> 
> The first patch is a fix, but I think it's not relevant as I didn't find
> a pcie driver without a remove callback. Feel free to drop the Fixes
> line if you think it's not justified and decide yourself if you want it
> backported to stable. I have no strong opinion here.
> 
> For the complete series there is no intended change in behaviour (apart
> from the fix in the first patch :-).
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (6):
>   PCI/portdrv: Fix potential resource leak
>   PCI/portdrv: Drop empty shutdown callback
>   PCI/portdrv: Don't check for the driver's and device's bus
>   PCI/portdrv: Move pcie_port_bus_type to pcie source file
>   PCI/portdrv: Don't check for valid device and driver in bus callbacks
>   PCI/portdrv: Use bus-type functions
> 
>  drivers/pci/pci-driver.c   | 28 -------------------
>  drivers/pci/pcie/portdrv.c | 55 +++++++++++++++++++-------------------
>  2 files changed, 28 insertions(+), 55 deletions(-)

Applied to pci/portdrv for v6.20, thanks for doing this!

