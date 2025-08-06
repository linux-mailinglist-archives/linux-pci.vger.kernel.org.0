Return-Path: <linux-pci+bounces-33487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD3AB1CE7E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 23:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112563A4E68
	for <lists+linux-pci@lfdr.de>; Wed,  6 Aug 2025 21:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4FD22A1E1;
	Wed,  6 Aug 2025 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ9MkMaD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CEA21C161;
	Wed,  6 Aug 2025 21:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754516051; cv=none; b=RJPBeV2lEJ8+Wjk3axCpWh2NIZvvdGnziCMwPH9bkxpeYpnY3IfGsVxlHUV45vzkoWMAvgdAs5yHuWMQe5VDihHYtI66iqfpj0/5/oeAaiOVNNreVkkX7yUQ/Eh4cAFPGer87WdkYYJvnC7O/iX5zz38hTeym+8sWEI3bppUI50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754516051; c=relaxed/simple;
	bh=uss7K+d/97COqJCqwYC+U7xTzgza8CHg+t+2/FaXkcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uv0d8aBwScJ0YFmxD9GIWkd0YX+ugSUKdGnIV5ybUcUWmWAEjb30KRl2GtK+QlefU5IXyvJ+LOiryTIkAQ0OqFKL7yy74b4D/dSL9TOcjFEjQ7R/9cm0DP54pkImObX8gHT/rQEzJUwOQ6UtJk4C/lVc3ksFefi8ioCsAhtBKTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ9MkMaD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204C1C4CEE7;
	Wed,  6 Aug 2025 21:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754516051;
	bh=uss7K+d/97COqJCqwYC+U7xTzgza8CHg+t+2/FaXkcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZQ9MkMaD3SurYVE4C5TtQbg4XczpUtqzDiZCKx2fOAxAuGN6h39Ba6k01BXs8TAf6
	 hfCuGENc785dHl4kpstCCDyBQO5B4hLWhuX1AeezldWB7nnpH0D3RbFkcSUu/ciBsa
	 R9VSmSzXva+V96bUxE7w8I2DjXuxhgkzUmdRo3ldKqGoSU8btjNg2JLpP3OhNHR1fS
	 G4AE3uyUVGFwC4AaqaDPEnOWhsU3NQ3v3oYSLQXtKBsizRdqh8CGRm8yi1W1VmR6fu
	 K7WhBDt2Cak+qNgkKuMp51b0nmuvgNg2jVQEGMV+lZpopYwYEfF7nuc8WegH5aTjOU
	 oH4y7nogCjopA==
Date: Wed, 6 Aug 2025 16:34:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Hongbo Yao <andy.xu@hj-micro.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	bhelgaas@google.com, mahesh@linux.ibm.com, oohall@gmail.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	jemma.zhang@hj-micro.com, peter.du@hj-micro.com
Subject: Re: [PATCH] PCI/DPC: Extend DPC recovery timeout
Message-ID: <20250806213409.GA19037@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHCPTU03s-SkAsPs@wunner.de>

On Fri, Jul 11, 2025 at 06:13:01AM +0200, Lukas Wunner wrote:
> On Fri, Jul 11, 2025 at 11:20:15AM +0800, Hongbo Yao wrote:
> > 2025/7/8 1:04, Sathyanarayanan Kuppuswamy:
> > > On 7/7/25 3:30 AM, Andy Xu wrote:
> > > > Setting timeout to 7s covers both devices with safety margin.
> > > 
> > > Instead of updating the recovery time, can you check why your device
> > > recovery takes
> > > such a long time and how to fix it from the device end?
> > 
> > I fully agree that ideally the root cause should be addressed on the
> > device side to reduce the DPC recovery latency, and that waiting longer
> > in the kernel is not a perfect solution.
> > 
> > However, the current 4 seconds timeout in pci_dpc_recovered() is indeed
> > an empirical value rather than a hard requirement from the PCIe
> > specification. In real-world scenarios, like with Mellanox ConnectX-5/7
> > adapters, we've observed that full DPC recovery can take more than 5-6
> > seconds, which leads to premature hotplug processing and device removal.
> 
> I think Sathya's point was:  Have you made an effort to talk to the
> vendor and ask them to root-cause and fix the issue e.g. with a firmware
> update.

Would definitely be great, but unless we have a number in the spec to
point to, they might just shrug and ask what the requirement is.

> > To improve robustness and maintain flexibility, I???m considering
> > introducing a module parameter to allow tuning the DPC recovery timeout
> > dynamically. Would you like me to prepare and submit such a patch for
> > review?
> 
> We try to avoid adding new module parameters.  Things should just work
> out of the box without the user having to adjust the kernel command
> line for their system.
> 
> So the solution is indeed to either adjust the delay for everyone
> (as you've done) or introduce an unsigned int to struct pci_dev
> which can be assigned the delay after reset for the device to be
> responsive.
> 
> For comparison, we're allowing up to 60 sec for devices to become
> available after a Fundamental Reset or Conventional Reset
> (PCIE_RESET_READY_POLL_MS).  That's how long we're waiting in
> dpc_reset_link() -> pci_bridge_wait_for_secondary_bus() and
> we're not consistent with that when we wait only 4 sec in
> pci_dpc_recovered().
> 
> I think the reason is that we weren't really sure whether this approach
> to synchronize hotplug with DPC works well and how to choose delays.
> But we've had this for a few years now and it seems to have worked nicely
> for people.  I think this is the first report where it's not been
> working out of the box.

Why would we wait less than PCIE_RESET_READY_POLL_MS?  DPC disables
the link, so that's basically a reset for the device.  Seems like we
should allow as much time as we do for any other kind of reset.

Bjorn

