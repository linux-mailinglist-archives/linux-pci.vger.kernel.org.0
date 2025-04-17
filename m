Return-Path: <linux-pci+bounces-26075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A946A9169A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2295A0A5B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F9B2253FD;
	Thu, 17 Apr 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHW40nqI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A30E22424D;
	Thu, 17 Apr 2025 08:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744879194; cv=none; b=KTEFcX7PiwN3Wd1vGHVPsnUiq6uVfEBjsSk0xSRb1rG7pUWOi42UJFGa6fk41tpp2EWyRzb4naaeKwA9sfLRW36l/iZge3dcdlIPV6yYI5xatsNJmpiqbw1ITCsTdeaNiZdT0xlGLe49CN0nkQERnUbtS58TRKK5eOGQlBalDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744879194; c=relaxed/simple;
	bh=E2pUwIa3M2j8+TwNI8zdHacoOXOQYH/elMF2JStWijg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPJ4j5WLE5hXojK7It3DYer8VoU1kmP1FJthfAwEAfMkdtm1Vjdix5yMP3M7GCBAvwiXexvg7YKg0FoSQIPx1/AeaUP554obGjS60pDPDZ6ayF0iRlUpYY6UA/v9nMNvELeQ+fLSyKY0NmZ3tGVk8QW0zz+KvSWd7YO720BPiDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHW40nqI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DD9C4CEE4;
	Thu, 17 Apr 2025 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744879194;
	bh=E2pUwIa3M2j8+TwNI8zdHacoOXOQYH/elMF2JStWijg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fHW40nqIuGIijzpwiC5akHwMbGFOSJ1+jL/+ZngNMd+K4bT8s12plZRNkkJxe3Ye2
	 T8B6niULHBTtrEf6UmCUUM9/KWJyOZWnA/XdG7sNqBRJ8hbHfaWeoh+XiQ/vjjhlYm
	 rcXjSzZOhJ4M69YByAp+kWgKcOYvTxrXM987mgY5aldRHWUfVwHQRX5W/JVNON68vW
	 zxTzKQBI6cJGk9lvviHSrZuaAOoOLckcMA0zHmuqnS1jJxNrMWvODO86eQYnvmmcqN
	 n79/wMFaQsyb2BOlxWf8PPRZGH/6e2Kn9L7QppLIT6z7DEuM3T23odCLaNxggvv/8b
	 akXryhkCD7z7w==
Date: Thu, 17 Apr 2025 10:39:49 +0200
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
Message-ID: <aAC-VTqJpCqcz6NK@ryzen>
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
 <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
 <aACsJPkSDOHbRAJM@ryzen>
 <ca283065-a48c-3b39-e70d-03d4c6c8a956@rock-chips.com>
 <aACyRp8S9c8azlw9@ryzen>
 <52a2f6dc-1e13-4473-80f2-989379df4e95@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52a2f6dc-1e13-4473-80f2-989379df4e95@163.com>

On Thu, Apr 17, 2025 at 04:07:51PM +0800, Hans Zhang wrote:
> On 2025/4/17 15:48, Niklas Cassel wrote:
> 
> Hi Niklas and Shawn,
> 
> Thank you very much for your discussion and reply.
> 
> I tested it on RK3588 and our platform. By setting pci=pcie_bus_safe, the
> maximum MPS will be automatically matched in the end.
> 
> So is my patch no longer needed? For RK3588, does the customer have to
> configure CONFIG_PCIE_BUS_SAFE or pci=pcie_bus_safe?
> 
> Also, for pci-meson.c, can the meson_set_max_payload be deleted?

I think the only reason why this works is because
pcie_bus_configure_settings(), in the case of
pcie_bus_config == PCIE_BUS_SAFE, will walk the bus and set MPS in
the bridge to the lowest of the downstream devices:
https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/probe.c#L2994-L2999


So Hans, if you look at lspci for the other RCs/bridges that don't
have any downstream devices connected, do they also show DevCtl.MPS 256B
or do they still show 128B ?


One could argue that for all policies (execept for maybe PCIE_BUS_TUNE_OFF),
pcie_bus_configure_settings() should start off by initializing DevCtl.MPS to
DevCap.MPS (for the bridge itself), and after that pcie_bus_configure_settings()
can override it depending on policy, e.g. set MPS to 128B in case of
pcie_bus_config == PCIE_BUS_PEER2PEER, or walk the bus in case of
pcie_bus_config == PCIE_BUS_SAFE.

That way, we should be able to remove the setting for pci-meson.c as well.

Bjorn, thoughts?


Kind regards,
Niklas

