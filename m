Return-Path: <linux-pci+bounces-16253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA3E9C0A3C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E4961C222A2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97755213158;
	Thu,  7 Nov 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8OygeYW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6693D212D07;
	Thu,  7 Nov 2024 15:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994011; cv=none; b=KnWWGVnSR0sqPVFCUWDTx3frKscrBcyUJvnTVeLn/aipQDttKPX8Vxtw69wLOnWCjW/aEMI7ymMukg94d3XA0yXu4QxeO/jzG3PrNhnVpw6Gkzz1FT5X05XRfrJM6Ekx4vONCW4eM2uCLJhLtd1XUjvxViu2d6GfDGSfgsUxddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994011; c=relaxed/simple;
	bh=4mNcq5bxe/B1imMtBKo7PPWWV8oFe9lVfq2c+lrrWi0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BeWLguEmvX22gzUrI3+OW6iKihShQMlBH2kzlBRpWA7aMRHHQHZW5T87x8+dpEg4kyDyy2OIXL8HaN+YzRtcLoZT5ncbepyn3Hla1Kg+zyMukobmttx7Fkvwy4nJDDx1SaWkauEGi9JlY8fg+3FsmfQapYGgkWMtJmdb/uWx4F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8OygeYW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD9AC4CECC;
	Thu,  7 Nov 2024 15:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730994011;
	bh=4mNcq5bxe/B1imMtBKo7PPWWV8oFe9lVfq2c+lrrWi0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r8OygeYWHMa4jja8L56AsQoum+wZOfwW6xNLzomrXmGB8Iv91roEUdhxhcBxsNhtl
	 ZFHMH9TIyLOk2CBOwSmmcoFzfmml7i26SpL+NxEedMo/YdKoHsiu11BKRDJTRnHzRD
	 juE5kH72Nup/Ne64juga8TKK7nuIx8jx7kHhR6D4TycEQQWRKk1RcO3ZHhad0DnA5T
	 jYBxLw42JCy4HHbT1U1Dcu+N10eU1ZPxeyj4R18O7+au0obnAVmX7cwOPlxgnJSRwW
	 DGjydckI0HtAzEaQPqo+RgU066c7g2uSsdeh2Q5Kjc3x1W+DinA7ucLkU+y+h6bg+d
	 XyPBfxHrm1b8g==
Date: Thu, 7 Nov 2024 07:40:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Andrew Lunn
 <andrew@lunn.ch>, Bjorn Helgaas <helgaas@kernel.org>, Sanman Pradhan
 <sanman.p211993@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 netdev@vger.kernel.org, alexanderduyck@fb.com, kernel-team@meta.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, mohsin.bashr@gmail.com,
 sanmanpradhan@meta.com, andrew+netdev@lunn.ch, jdamato@fastly.com,
 sdf@fomichev.me, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241107074009.5712809a@kernel.org>
In-Reply-To: <20241107120357.GL5006@unreal>
References: <20241106122251.GC5006@unreal>
	<20241106171257.GA1529850@bhelgaas>
	<76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
	<20241106160958.6d287fd8@kernel.org>
	<20241107082327.GI5006@unreal>
	<b35f536e-1eb0-4b7b-85f4-df94d76927d6@linux.dev>
	<20241107120357.GL5006@unreal>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Nov 2024 14:03:57 +0200 Leon Romanovsky wrote:
> > [root@host ~]# ethtool -i eth0 | grep driver
> > driver: mlx5_core
> > [root@host ~]# ethtool -S eth0 | grep pci
> >      rx_pci_signal_integrity: 1
> >      tx_pci_signal_integrity: 1471
> >      outbound_pci_stalled_rd: 0
> >      outbound_pci_stalled_wr: 0
> >      outbound_pci_stalled_rd_events: 0
> >      outbound_pci_stalled_wr_events: 0
> > 
> > Isn't it a PCIe statistics?  
> 
> I didn't do full archaeological research and stopped at 2017 there these
> counters were updated to use new API, but it looks like they there from
> stone age.
> 
> It was a mistake to put it there and they should be moved to PCI core
> together with other hundreds debug counters which ConnectX devices have
> but don't expose yet.

Whatever hand-waving you do now, it's impossible to take you seriously
where the device driver of which you are a maintainer does the same
thing. And your direction going forward for PCIe debug, AFAIU, is the
proprietary fwctl stuff. Please stop.

