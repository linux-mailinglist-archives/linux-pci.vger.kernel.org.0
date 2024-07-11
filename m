Return-Path: <linux-pci+bounces-10157-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7692EA99
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94308281E47
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 14:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155C161B43;
	Thu, 11 Jul 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kG5dHIKQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F3015ECCA;
	Thu, 11 Jul 2024 14:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720707701; cv=none; b=b4uZ0IVaBcQjEJwh46z7iffzxMgTxMaCS+H1P+pDBgl3QwWv3FnHpEfnIuUBv+TWuLwnR481AQoHfFp5oNdIaUO0J03U2KwPv6Gl00Pa/WBARgTv4VumJBXqXiHGkkPXxjavTLYrS/aPPwyxKVoueccDyGimIxLb5Kopt1VGcdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720707701; c=relaxed/simple;
	bh=OFfgo+TtGVgSb9VZqT8NLJ9xp+qtpitkJFL8d+tpdrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YDNcCpNf629Q3EbpoMpL4lMbJ6sZR8YD0tp7p6UuOcA8eAhIj98J7ZT7K4LigjmPPGu7rb/4nPNO/92K6cuWT5SOt+9+rCZdnbqH7XcCEtFOCfntCOaiX0NhtKqXwFZy8lGb0vBMpXvLjFQ5oPUe6w7sdJno8UcEzEo+stm1wf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kG5dHIKQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80FBC32782;
	Thu, 11 Jul 2024 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720707701;
	bh=OFfgo+TtGVgSb9VZqT8NLJ9xp+qtpitkJFL8d+tpdrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kG5dHIKQy4zaAFULcBG6mIa0k+R7/V04a6hQOC7Ihi3uqvupF2HYF6k2e+PQ1haEc
	 iW89G6csdeGntpVYH5gbI0HCtEPgQt5G/CQplddsq6IBgxq1NCAbNHJARTupI1eQ3l
	 VEFDqz7pik/mrQn+BQ1I7pvO5/MQIp544p7HzoN5QCiI2LW2i7hAUysB3MKiB7txrO
	 L8VdEAfYJRnJx8aL4rSEZ/mvv/L9Ik8I6czHwPwc7BUvUCmC1ck3n+BdwsI423a+kW
	 oy3fZhacCZS7ysb/itUeEEnDkhRoRSN5D5NwWXncGmAxrNEshULSlj9q6PuFsSvwdQ
	 1EUTLPWPp4nRg==
Date: Thu, 11 Jul 2024 16:21:34 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 0/2] PCI: ti: k3: Fix TI J721E PERST# polarity
Message-ID: <Zo_qbspq0vA_p8VC@ryzen.lan>
References: <20240703100036.17896-1-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703100036.17896-1-francesco@dolcini.it>

On Wed, Jul 03, 2024 at 12:00:34PM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Fix PCIe PERST# signal polarity in TI J721E used on TI K3 machines.
> 
> PCIe PERST# needs to be de-asserted for PCIe to work, however, the driver is
> doing the opposite and the device tree files are defining the signal with the
> wrong polarity to cope with that. Fix both the driver and the affected DT
> files.

Hello there,

While I understand why you want to fix this,
I'm not sure if you can actually do so without breaking device tree backwards
compatibility.

Imagine e.g. a board that has the DTB in ROM.
The user upgrades the kernel, and the DTB that was working with the old
kernel will now no longer work with the new kernel (because of your driver
change).

Just because you update the DTS files, you cannot assume that all DTBs
out there in the wild will automatically be updated.

That is what the DT maintainers told me many years ago when I wanted to do a
similar change as yours, for another PCIe controller driver.

Perhaps you could add a comment in the driver and the DTS files explaining
that the DTS is actually wrong, but cannot be changed because of DT backwards
compatibility.


Kind regards,
Niklas

