Return-Path: <linux-pci+bounces-9122-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434E913512
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 18:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5B201C20FE3
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2024 16:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B316FF2A;
	Sat, 22 Jun 2024 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJIYs7Yt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AE61DDC5;
	Sat, 22 Jun 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719074070; cv=none; b=aR28hSGHqnrsr/dnUu6XmQ6+WeJWv3xiZx4Na8WUvLw3dsZtpUBTrQ+B9P4PnC1VegldBy1/dpSkseuZP5d6znmSbWzVNoiH+1rqDCvwhxbBqkGFvKPGsmiicD3Ln3E2FY3yM+Q1TkHiSwH63EG7QZP7ag/Hly6CkUlVndBKbeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719074070; c=relaxed/simple;
	bh=t2xrxpY7g42zaDbzrTJjSd8KnoDUVB/HebWYFWAP4o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c53Z4xUGUI077+8oRMZiHrUj4M5zXBJBEhXbb6X6nAXDH9HiaNiZvqI2iucPdbUtB4CKoAgwzxf/FfgYt3YDHsVCZU+SwLXi9W3Ahf7wy/30YqnXh1ek30C8Oir/lYkFMGPf0BzCDz6QC23xuh01NeZuzNOGFdvW2xlePrilZ7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJIYs7Yt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E24FC3277B;
	Sat, 22 Jun 2024 16:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719074069;
	bh=t2xrxpY7g42zaDbzrTJjSd8KnoDUVB/HebWYFWAP4o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JJIYs7YtCwIYcOwlFMs3woKlHviODVXAHA1Xgb+VD+qZrJjrdWN8V59kY6vwlH9AJ
	 MJ6vhkIu56Pf1u2OLb2hkg3Gdz6UFFw/bKJIxOlxYq62N+IlQjinp9U4Mpxlkg8say
	 gLNXiUKllAHSKTU0CZG3uwOqcDyIZpoUnn+1XEpZ/fWeQI+axvbYEo9QMXJDgmHImm
	 vzXM27JSmHk2knHUop8ec00x5+CB32fTzLu+uipn/6X9dO0cm3sdV4Ym1kH1130+Ma
	 UxNv1f0RDw1Gc61CcAKWJ0f69Xc9fdrtZWhaXCqVnZgfwoUlI6A7v2rG0ZSN4SF/Sk
	 DyrxuU+jmKd2A==
Date: Sat, 22 Jun 2024 18:34:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 00/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <Znb9D7AouKxaqiFW@ryzen.lan>
References: <20240607-rockchip-pcie-ep-v1-v5-0-0a042d6b0049@kernel.org>
 <Zm_tGknJe5Ttj9mC@ryzen.lan>
 <20240621193937.GB3008482@rocinante>
 <ZnbUHI5GEMCmaK2V@ryzen.lan>
 <20240622154324.GA391376@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240622154324.GA391376@rocinante>

On Sun, Jun 23, 2024 at 12:43:24AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > Could you possibly include the commit:
> > 3d2e425263e2 ("PCI: dwc: ep: Add a generic dw_pcie_ep_linkdown() API to handle Link Down event")
> > from the controller/dwc branch in the controller/rockchip as well,
> > or rebase the controller/rockchip branch on top of the controller/dwc branch,
> > or merge the controller/dwc branch to the controller/rockchip branch?
> > 
> 
> Done.
> 
> > Additionally, since you picked up Mani's series which removes
> > dw_pcie_ep_init_notify() on the controller/dwc branch:
> > 9eba2f70362f ("PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper")
> > 
> > You will need to pick up this patch as well:
> > https://lore.kernel.org/linux-pci/20240622132024.2927799-2-cassel@kernel.org/T/#u
> > Otherwise there will be a build error when merging the controller/dwc
> > and the controller/rockchip branch to for-next.
> > The patch that I sent out can be picked up to the controller/rockchip right
> > now (since the API that Mani is switching to already exists in Linus's tree).
> 
> Done.
> 
> Hopefully, this settles things for a bit.

Everything looks good! :)

I'm glad that we got this sorted quickly, thank you Krzysztof!


Kind regards,
Niklas

