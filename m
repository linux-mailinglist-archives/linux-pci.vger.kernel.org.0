Return-Path: <linux-pci+bounces-5986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7EB89E64F
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 01:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B44141F21C0C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 23:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427801591E3;
	Tue,  9 Apr 2024 23:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="GKVRzTDu"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2237E15B133;
	Tue,  9 Apr 2024 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706160; cv=none; b=GRT+oT9dS9LgtvHcmWSTEe93MPxV/rEPQX61aX9PC+e162wJsWF4Mq2e9+TR27+3nKQoxobd6JooxnOkmQ+JZ05p93E+GPeRxm9BmT72FXmDrxXIoPM194w+kG7ogaJpkxh0RHPiM3/tBosloqto4wunsEq6aHKYI85lTJc8WBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706160; c=relaxed/simple;
	bh=5SHl765UVp7lpQw/JOqsR7FWnm3JFScry58Tw07OL2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/rVqGPzq/rLnW+lPbhmZLPjS2q9hcPsWCv85v4ohM6aWc8dIqlGrMFnhWlxL+Tx9CYdjVDNkAWKpVVQUykkhN30dGSgIKQ3x56diIzny8RljBVFzbeMcPMHCo4P7iIyicQ0SJJYvKMZ61cHjmbCQ/5bjBt5zt28fhtSf9P75Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=GKVRzTDu; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dQKAQgfqQ+ZMWDtruZ99hB2tH15xA/DemVS2riUBI0A=; b=GKVRzTDuHg6tqHI99LEoktdyKX
	UTzg60Cmf6b1liunnkbC9wlSWdcwLrt5b4TyliAuIbWSgMjffp0psFDLdh5HnonBCifLaWAVBnvjY
	h3cA5u6lshx6k3ncrWtg3mvr6HP1zcOx/WIMuMMiZsehuoZa4nkbrLdVp3hDHOQtnOgo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ruL6d-00CcD5-S7; Wed, 10 Apr 2024 01:42:23 +0200
Date: Wed, 10 Apr 2024 01:42:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Cc: pabeni@redhat.com, John Fastabend <john.fastabend@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net-next PATCH 00/15] eth: fbnic: Add network driver for Meta
 Platforms Host Network Interface
Message-ID: <44093329-f90e-41a6-a610-0f9dd88254eb@lunn.ch>
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <20240409135142.692ed5d9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409135142.692ed5d9@kernel.org>

> What is less clear to me is what do we do about uAPI / core changes.

I would differentiate between core change and core additions. If there
is very limited firmware on this device, i assume Linux is managing
the SFP cage, and to some extend the PCS. Extending the core to handle
these at higher speeds than currently supported would be one such core
addition. I've no problem with this. And i doubt it will be a single
NIC using such additions for too long. It looks like ClearFog CX LX2
could make use of such extensions as well, and there are probably
other boards and devices, maybe the Zynq 7000?

> Is my reading correct? Does anyone have an opinion on whether we should
> try to dig more into this question prior to merging the driver, and
> set some ground rules? Or proceed and learn by doing?

I'm not too keen on keeping potentially shareable code in the driver
just because of UEFI. It has long been the norm that you should not
have wrappers so you can reuse code in different OSes. And UEFI is
just another OS. So i really would like to see a Linux I2C bus master
driver, a linux GPIO driver if appropriate, and using phylink, just as
i've pushed wangxun to do that, and to some extend nvidia with their
GPIO controller embedded in their NIC. The nice thing is, the
developers for wangxun has mostly solved all this for a PCIe device,
so their code can be copied.

Do we need to set some ground rules? No. I can give similar feedback
as i gave the wangxun developers, if Linux subsystems are not used
appropriately.

       Andrew

