Return-Path: <linux-pci+bounces-26112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807BBA91FCB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 16:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34F307ABEF4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 14:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E3D2517B9;
	Thu, 17 Apr 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzA0qzRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140A2517A3
	for <linux-pci@vger.kernel.org>; Thu, 17 Apr 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744900528; cv=none; b=mFPJuBSAaNZsf1vuaatbD/H9Rp7HX4gqOyUnMbma7qDZSAFKf7gjTnQhfKCkpMZAlbtchlGNaCg9Pf/IdwQJuEW3QgNu+pKlOCYNpxQIugsdfRjswskemI0IElfpDmSxNYT9qLRBGs3m5ysRJ74WdWbXHuMyhTYmeNMUFm5QSo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744900528; c=relaxed/simple;
	bh=wnrScLvNMWAdpvl0Ot+SMpbyDyceQMrcNClqUjt96MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbrGAx9PN8l8UegP/ue0Ix4DQxMMOiG4X36fwltmHds8nMW80GO7KwlRTazHx6Q/YW2aVSpfhZnxTm+I2yK7vQxMFQ2jjHgnAkvPyGiYDrZEJE2+ooNW7mOu40xQrwofLE4+dklkFUgm949zBgDL9XNeej69VrtjEHZ034LqxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzA0qzRC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935E9C4CEE4;
	Thu, 17 Apr 2025 14:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744900528;
	bh=wnrScLvNMWAdpvl0Ot+SMpbyDyceQMrcNClqUjt96MY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OzA0qzRCBUy5GF6fE5vGg1MbVEUMJpKgv4P3BDwDb9eN+jZigMFCncUKnqtmrvSmn
	 8VDaGwAa3Q7cxyM6nCj/uE3NwVMA5XZbkiWeUIOcylsplj8BLQWnwNlJciLKLgOfRP
	 ywsebgp6msX8SIwA49ZT4YqdAHwGkDfKecTDvhAfjJKkvRiB74JYVHVzTFcU5P7PL8
	 SbK5KN/RPszB62Xv1OVy2H+Zf16LAkEDfqMThdp3RIx8HbbsmBHAHeVg6ZmWxjr2HB
	 J7/eFFGRxF0U/gg2iRdQkaeEknYgdpTKEh9a7F5YvQw7/IUP6WhrCHemWx6Jc/8fQG
	 7tyWIDX1C7f4w==
Date: Thu, 17 Apr 2025 16:35:23 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add system PM support
Message-ID: <aAERqx6LNZpcv7KO@ryzen>
References: <1744352048-178994-1-git-send-email-shawn.lin@rock-chips.com>
 <Z_5aib0WGKfIANj_@ryzen>
 <8815983.T7Z3S40VBb@workhorse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8815983.T7Z3S40VBb@workhorse>

Hello Nicolas,

On Thu, Apr 17, 2025 at 03:24:34PM +0200, Nicolas Frattaroli wrote:
> On Tuesday, 15 April 2025 15:09:29 Central European Summer Time Niklas Cassel wrote:
> > On Fri, Apr 11, 2025 at 02:14:08PM +0800, Shawn Lin wrote:
> > > [...]
> > > +      rockchip_pcie_ltssm_enable_control_mode(rockchip, PCIE_CLIENT_RC_MODE);
> > 
> > Here you are setting PCIE_CLIENT_RC_MODE unconditionally.
> > 
> > I really don't think that you have tested these callbacks with EP mode.
> 
> Hi Niklas,
> 
> I may be reading too much into your tone here, but I think it'd be good if
> you didn't formulate this in such a passive-aggressive accusatory way. You
> can just express your concern as a question about whether this was tested
> with EP mode.

I provided a suggestion further down in the same email
(perhaps split the driver to RC and EP part like the qcom driver).

I also provided a further suggestion here:
https://lore.kernel.org/linux-pci/aADdI7ByEImYy3Pq@ryzen/
(perhaps do like the tegra driver and let the callback return -ENOTSUPP
if running in EP mode.)


> 
> After all, I'm giving you specifically the same benefit of the doubt with
> RC mode that has broken BAR resource mapping on RK3588 in timing-related
> ways in v6.15-rc that has already taken me about a day of unreliable
> bisects to try and track down, and may in fact end up bisecting to one of
> your recent commits touching that part.

It would have been nice if you waited until your bisect was done,
so you could have provided some facts, rather than speculation.

Nonetheless, may I suggest that you try with Shawn's recent patch:
https://lore.kernel.org/linux-pci/aACaupQvmiiBE29l@ryzen/T/#m5ec27d0ee4d2345dd4539385b3c7c8f6b98ee72e
which fixes the .link_up() callback.

The link_up() callback is used e.g. by dw_pcie_other_conf_map_bus():
https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/controller/dwc/pcie-designware-host.c#L622-L631

So bad things could happen if this callback is not implemented correctly.


Kind regards,
Niklas

