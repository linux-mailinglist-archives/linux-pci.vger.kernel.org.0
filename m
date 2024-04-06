Return-Path: <linux-pci+bounces-5822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9951B89AC57
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 18:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55A1D2828D6
	for <lists+linux-pci@lfdr.de>; Sat,  6 Apr 2024 16:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A8640BFE;
	Sat,  6 Apr 2024 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="i41hjGON"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD2446A0;
	Sat,  6 Apr 2024 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712422162; cv=none; b=J//4l1yjy5MUJSIMrBK4vwQmFnXE6sVQuC0w168t7UPjEvVDAvrMLOz0kef2+QqHKOCPV0eqT2boD6x4P3OW94CANTCHlIOEhy0jjCvRCSbbEkE2wi648AlXG4DrruUzqDBW2PbBl6p4sncp17fyqA6odl9xdTcBy4Tqst/k6Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712422162; c=relaxed/simple;
	bh=o6rCWrkCCMKhbDFNWKnJwxzIkPZg6rzq6G5ccjUP0lA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxX5KBO8w+Y5rzHi6jKVXnelBfIK0I2Eu2ur5arefyOmpV1wMfntY6VT7yqOM5bEyG1zETEp6RLf+qwm1uY4UY7SQzRvWQh0vT3px5BYkR4H3KvxdQhccb6DaFUHvg829X2/tX7x7RWBmpRg+t420+Lb1h4AUVgwnmQPjvPQwpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=i41hjGON; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NsVJhybXoNm2BAjNEOwJVpEfmnbtHnO9dO+eB6wnYTA=; b=i41hjGON5R2dL4M0o2quPirnCB
	/o5ptgm/sDZQkc164TtFTFyfr3S68WaDKJdH4N7MFcw/YgOvhiStzNB27gDYzGaE+KejDnbw9QjLZ
	Qn5q2dEZSbsOK4+OR6p5hlpdxPYdjdf5P+ptr8EzlKO8v5RBHGt+r5b2wNZbwwHFVKLo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rt9E5-00CNkT-3i; Sat, 06 Apr 2024 18:49:09 +0200
Date: Sat, 6 Apr 2024 18:49:09 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, davem@davemloft.net,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <b3183aab-4071-460d-acf0-1b5caa8c67a5@lunn.ch>
References: <660f22c56a0a2_442282088b@john.notmuch>
 <20240404165000.47ce17e6@kernel.org>
 <CAKgT0UcmE_cr2F0drUtUjd+RY-==s-Veu_kWLKw8yrds1ACgnw@mail.gmail.com>
 <678f49b06a06d4f6b5d8ee37ad1f4de804c7751d.camel@redhat.com>
 <20240405122646.GA166551@nvidia.com>
 <CAKgT0UeBCBfeq5TxTjND6G_S=CWYZsArxQxVb-2paK_smfcn2w@mail.gmail.com>
 <20240405151703.GF5383@nvidia.com>
 <CAKgT0UeK=KdCJN3BX7+Lvy1vC2hXvucpj5CPs6A0F7ekx59qeg@mail.gmail.com>
 <20240405190209.GJ5383@nvidia.com>
 <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UdZz3fKpkTRnq5ZO2nW3NQcQ_DWahHMyddODjmNDLSaZQ@mail.gmail.com>

> I'm assuming it is some sort of firmware functionality that is needed
> to enable it? One thing with our design is that the firmware actually
> has minimal functionality. Basically it is the liaison between the
> BMC, Host, and the MAC. Otherwise it has no role to play in the
> control path so when the driver is loaded it is running the show.

Which i personally feel is great. In an odd way, this to me indicates
this is a commodity product, or at least, leading the way towards
commodity 100G products. Looking at the embedded SoC NIC market, which
pretty is much about commodity, few 1G Ethernet NICs have firmware.
Most 10G NICs also have no firmware. Linux is driving the hardware.

Much of the current Linux infrastructure is limited to 10G, because
currently everything faster than that hides away in firmware, Linux
does not get to driver it. This driver could help push Linux
controlling the hardware forward, to be benefit of us all. It would be
great if this driver used phylink to manage the PCS and the SFP cage,
that the PCS code is moved into drivers/net/pcs, etc. Assuming this
PCS follows the standards, it would be great to add helpers like we
have for clause 37, clause 73, to help support other future PCS
drivers which will appear. 100G in SoCs is probably not going to
appear too soon, but single channel 25G is probably the next step
after 10G. And what is added for this device will probably also work
for 25G. 40G via 4 channels is probably not too far away either.

Our Linux SFP driver is also currently limited to 10G. It would be
great if this driver could push that forwards to support faster SFP
cages and devices, support splitting and merging, etc.

None of this requires new kAPIs, they all already exist. There is
nothing controversial here. Everything follows standards. So if Meta
were to abandon the MAC driver, it would not matter, its not dead
infrastructure code, future drivers would make use of it, as this
technology becomes more and more commodity.

	Andrew

	   

