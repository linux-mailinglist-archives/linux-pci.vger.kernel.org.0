Return-Path: <linux-pci+bounces-10162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C4192EB9B
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 17:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 456971F22C5D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2024 15:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58E16B747;
	Thu, 11 Jul 2024 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="aqiA9ufA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD8A166317;
	Thu, 11 Jul 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711550; cv=none; b=jYBBXEgA3osbVhNLuaEFJbhguYi+NEKnuWFrCw1OKSDn/94xMuUEd4kw+Lw1mVntQy8z0pEc9EI4Uzk4v6+OPVSnMLQzlY7Zc3BknHkKfIX7IdtkBYVw7msfwcphhvDhyK3/vqTL9q1xwTKfSfdTcUo/hpipADyflVFHQ6hl2TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711550; c=relaxed/simple;
	bh=zZ7J6+mm32LlLjWxlIjEykH6hwYEPzq7Mm6VwSTr5FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=on/EaA0tzwNm03xYsPmjwHhrYQejynD9qQ3QVMwb2cGGC+mqTwU7ALrfpELc2UlgjOwpaVAN8XnU2CDFzzQCQXV3Wy/CQMTSKD3tWSONY++Ob4040sfX6NszknM3934wQkTRl+F9lrnlq2qY2QIpmwJOHoh+b7ZwwaVim7vT7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=aqiA9ufA; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 026BB1FE38;
	Thu, 11 Jul 2024 17:25:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1720711535;
	bh=YGIW/Vx8HzQ+wbnotFUYU6SkJgDBJDLpbLvh5NfbH1U=; h=From:To:Subject;
	b=aqiA9ufASPnH6b6V4P6BPI7AB+4uEnEMqaPoC0ArVsGTNSvRFxhySQnZ602RrPPvf
	 Dzu2CXVJVDeZ07XVJcyL0Acuu6pVSV4D07PqaqT8STbAAg7T1zR0IvzXyAoJXbKzTU
	 vnrT3supUY50qsvdN5fqHY41lghet08QeFgwL7pobq8oOILfGN0V1/Is+duFHOWIw3
	 7Xocx9RS+ehnRRPmAXIw0BGr+6kv4S6s0be11CPsy5pxXzPlIUxLrAzBbekJeY6+fE
	 fb5rOXCjVDlZzyWcpo5CnKI8WTBRRgBClUkHz8ecxeR/mRzcN/hfIC9qkBYxLkGwmV
	 ghvNkBLJWASEw==
Date: Thu, 11 Jul 2024 17:25:31 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Niklas Cassel <cassel@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
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
Message-ID: <20240711152531.GA35875@francesco-nb>
References: <20240703100036.17896-1-francesco@dolcini.it>
 <Zo_qbspq0vA_p8VC@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zo_qbspq0vA_p8VC@ryzen.lan>

Hello Niklas,

On Thu, Jul 11, 2024 at 04:21:34PM +0200, Niklas Cassel wrote:
> On Wed, Jul 03, 2024 at 12:00:34PM +0200, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Fix PCIe PERST# signal polarity in TI J721E used on TI K3 machines.
> > 
> > PCIe PERST# needs to be de-asserted for PCIe to work, however, the driver is
> > doing the opposite and the device tree files are defining the signal with the
> > wrong polarity to cope with that. Fix both the driver and the affected DT
> > files.
> 
> While I understand why you want to fix this,
> I'm not sure if you can actually do so without breaking device tree backwards
> compatibility.

I understand this, and at the same time I know that this was done in the
past for exactly the same reason, see for example commit 87620512681a
("PCI: apple: Fix PERST# polarity").

This patch was send not because the issue was noticed analyzing the
code, but because during a bring-up of a new platform (based on
k3-j784s4) using this PCIe controller driver the PCIe was not working
and this lead to some time consuming debugging on both the
hardware/software before finding this issue. That was worked around just
by describing the HW incorrectly in the DT (the device tree of this
board is not in mainline - yet).

With that said I cannot 100% judge the exact impact, I know most (but
not all) of the boards and I think that making the change is beneficial
despite what you correctly write.

Most of the boards affected are from Texas Instruments (eval boards),
plus one beagle and one board from Siemens. Let's see what these folks
think about this change, these boards are all relatively recent.

> Perhaps you could add a comment in the driver and the DTS files explaining
> that the DTS is actually wrong, but cannot be changed because of DT backwards
> compatibility.
As I wrote my concern is on new boards. 

BTW, the RS485 polarity for the UART used on all TI platform (including
the very old ones) have a similar bug [1], however this bug is so old and
deep into the code that we'll have to live with it.

[1] https://lore.kernel.org/all/ZBItlBhzo+YETcJO@francesco-nb.int.toradex.com/

Francesco


