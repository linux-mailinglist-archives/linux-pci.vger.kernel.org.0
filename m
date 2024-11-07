Return-Path: <linux-pci+bounces-16269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933E9C0BE1
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 17:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BB6B20F32
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF455215F6C;
	Thu,  7 Nov 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PACSSb+f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A76A1BD007;
	Thu,  7 Nov 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997741; cv=none; b=qv2RjRZmrPZg9L/6dpLvwponwQuY+nQKI+HfwIcShaJWrGqpyFUClgIKB1PR0zaCHaLpR3e2np4MwVkN7Uhs9KGTY0r3ZxduPV3C7kkXiHj2HQU6vwHnZmdmIgnQFN0lcTerW4T1SNxskYLOhDslKZSyx60WtzjOLznsGA9nNqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997741; c=relaxed/simple;
	bh=WdyKJtb8azsZYUqpDghR52nsf2xjEriGSxLwMe1jM+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOElM6KrOSI4KaTsLjEKLodjH7pIHLJO/ebG1TtXTfq0l326D7neBZh6DxHI7uf/F+JOA17dCfadhACNvOxKr0dzSfP4YLm7m6ybnF3hXel9jIziVZS/f3B1SwDkB4pLwOY61QaduDKlZmDkRBHbOJvhHp8uNxYd8vPNdk4gjAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PACSSb+f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2188C4CECC;
	Thu,  7 Nov 2024 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730997741;
	bh=WdyKJtb8azsZYUqpDghR52nsf2xjEriGSxLwMe1jM+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PACSSb+fkWRl1il2twepV9lGk0DfomBOx8yQJfl8C+dbvcTbwd81LLg+GMQ06POoq
	 ll5wofgywYTaRdTplbtJTlrZM5TGL12Jo0XdF0qEjyxxz3NPAeOgG5ewqVbkY+yQnc
	 NDm6HvvJna0JwBNQuL6bBOFizP86JAudh9Txo/Hs0cPSfsPJeSH9MRFSmY2ibQkbjS
	 mqZ3aOkw7PF3Kl1A9ExApW/bOjmeNCQQLRTKsyKnIfBkhgcpRMzDpnTcMJP4yTeJS9
	 EhpbgDoTgBboKn8tUXhknXtZyWa1NscBKBTa+h9+UHB72ISRrcY0x6Va2r/LLKi4JS
	 MwIbf4felViAA==
Date: Thu, 7 Nov 2024 18:42:13 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>, Bjorn Helgaas <helgaas@kernel.org>,
	Sanman Pradhan <sanman.p211993@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org,
	alexanderduyck@fb.com, kernel-team@meta.com, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, mohsin.bashr@gmail.com, sanmanpradhan@meta.com,
	andrew+netdev@lunn.ch, jdamato@fastly.com, sdf@fomichev.me,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add PCIe hardware statistics
Message-ID: <20241107164213.GA189042@unreal>
References: <20241106122251.GC5006@unreal>
 <20241106171257.GA1529850@bhelgaas>
 <76fdd29a-c7fa-4b99-ae63-cce17c91dae9@lunn.ch>
 <20241106160958.6d287fd8@kernel.org>
 <20241107082327.GI5006@unreal>
 <b35f536e-1eb0-4b7b-85f4-df94d76927d6@linux.dev>
 <20241107120357.GL5006@unreal>
 <20241107074009.5712809a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107074009.5712809a@kernel.org>

On Thu, Nov 07, 2024 at 07:40:09AM -0800, Jakub Kicinski wrote:
> On Thu, 7 Nov 2024 14:03:57 +0200 Leon Romanovsky wrote:
> > > [root@host ~]# ethtool -i eth0 | grep driver
> > > driver: mlx5_core
> > > [root@host ~]# ethtool -S eth0 | grep pci
> > >      rx_pci_signal_integrity: 1
> > >      tx_pci_signal_integrity: 1471
> > >      outbound_pci_stalled_rd: 0
> > >      outbound_pci_stalled_wr: 0
> > >      outbound_pci_stalled_rd_events: 0
> > >      outbound_pci_stalled_wr_events: 0
> > > 
> > > Isn't it a PCIe statistics?  
> > 
> > I didn't do full archaeological research and stopped at 2017 there these
> > counters were updated to use new API, but it looks like they there from
> > stone age.
> > 
> > It was a mistake to put it there and they should be moved to PCI core
> > together with other hundreds debug counters which ConnectX devices have
> > but don't expose yet.
> 
> Whatever hand-waving you do now, it's impossible to take you seriously
> where the device driver of which you are a maintainer does the same
> thing. 

I said that it is a mistake and can add that we can move it to new infrastructure.

> And your direction going forward for PCIe debug, AFAIU, is the
> proprietary fwctl stuff. Please stop.

Nice, and we are returning back to the discussion of evil vendors vs.
good people who are working in cloud companies which produce hardware
for themselves but don't call themselves vendors.

The latter can do whatever they want, but vendors are doing only crap.

The patch author added these debug counters, and magically it is fine for you:
+   These counters indicate PCIe resource exhaustion events:
+        - pcie_ob_rd_no_tag: Read requests dropped due to tag unavailability
+        - pcie_ob_rd_no_cpl_cred: Read requests dropped due to completion credit exhaustion
+        - pcie_ob_rd_no_np_cred: Read requests dropped due to non-posted credit exhaustion

For example, mlx5 devices and Broadcom have two simple PCIe counters: rx_errors and tx_errors,
which have nothing to do with fwctl.

And the idea, what you can take mistakes from the past, ignore the
feedback and repeat these mistakes, fills me with amazement.

So why don't you allow module parameters? Many drivers have them, but
new are not allowed. If I claim that "vendor XXX has it, can I add it
too?", we all know the answer.

Thanks

