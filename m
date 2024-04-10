Return-Path: <linux-pci+bounces-6078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB068A00F6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 22:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4106DB24A84
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 20:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E07181305;
	Wed, 10 Apr 2024 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oV1VEBNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E858E28FD;
	Wed, 10 Apr 2024 20:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712779310; cv=none; b=pC0exwqrIUsgSksO0KiJILeGopQzdpM6pFe5WvXF0wyXmCBl2stHnfmo8C4jYLdrFdIWCZCD3VAtzGp7u3ssCoajdJuM0eFe6/5uBuQKVHvfByEzJlo1QoEr2I/IrDer+NyZI+uYDkPoSLgWoTpyda7pp2NNT04z2kYqy/bnU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712779310; c=relaxed/simple;
	bh=PlbRE0plJ17S1yMslUNWUHHm+hpzWR0/FI1Ir+nDCQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdfZZSkDcSF3S0z3ZebSeRbqtkqnvh2sGCqB9uA9hwBhjjmPOrq1kRgZYKkJVrqJ6pwX7U0Z53Za/XFeY2lyd1IdZ6FptiKcrljHuCY5KAa4a8/s7f838GVUpHSOFLffWeiXl8saeH41TKDgqlziZbiQeqQTg36B6QmNy4g2t3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oV1VEBNv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=q2uZY5anmk4dC1owI6zZObdhGeH9uP04+O3JfrU/Xj0=; b=oV
	1VEBNv6294yFzGzmdGKQepe6PORtFJwA/jvD2kzq4IBDK9w8gGPIggPg+mgpp2vc0uL3+KA0nv9HO
	sVJQigj73/6d3GlSXkkFW8sPSiqS1/yOcMPkFhiijEmEKKeo+S5Y7z2FSh5e4WTCwnfzjNf2uCwgn
	JpnGlDcoQhHo0PM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rue8R-00ChWw-P6; Wed, 10 Apr 2024 22:01:31 +0200
Date: Wed, 10 Apr 2024 22:01:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, pabeni@redhat.com,
	John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <c820695d-bda7-4452-a563-170700baf958@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
 <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
 <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgT0UcVnhgmXNU2FGcy6hbzUQZwNBZw0EKbFF3DsKDc8r452A@mail.gmail.com>

On Wed, Apr 10, 2024 at 08:56:31AM -0700, Alexander Duyck wrote:
> On Tue, Apr 9, 2024 at 4:42 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > What is less clear to me is what do we do about uAPI / core changes.
> >
> > I would differentiate between core change and core additions. If there
> > is very limited firmware on this device, i assume Linux is managing
> > the SFP cage, and to some extend the PCS. Extending the core to handle
> > these at higher speeds than currently supported would be one such core
> > addition. I've no problem with this. And i doubt it will be a single
> > NIC using such additions for too long. It looks like ClearFog CX LX2
> > could make use of such extensions as well, and there are probably
> > other boards and devices, maybe the Zynq 7000?
> 
> The driver on this device doesn't have full access over the PHY.
> Basically we control everything from the PCS north, and the firmware
> controls everything from the PMA south as the physical connection is
> MUXed between 4 slices. So this means the firmware also controls all
> the I2C and the QSFP and EEPROM. The main reason for this is that
> those blocks are shared resources between the slices, as such the
> firmware acts as the arbitrator for 4 slices and the BMC.

Ah, shame. You took what is probably the least valuable intellectual
property, and most shareable with the community and locked it up in
firmware where nobody can use it.

You should probably stop saying there is not much firmware with this
device, and that Linux controls it. It clearly does not...

	Andrew

