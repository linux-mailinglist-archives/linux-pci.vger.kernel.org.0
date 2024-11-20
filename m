Return-Path: <linux-pci+bounces-17126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C739D9D4364
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 22:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AE91F22257
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2024 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B810916C451;
	Wed, 20 Nov 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vh5Rswhl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BA82F2A
	for <linux-pci@vger.kernel.org>; Wed, 20 Nov 2024 21:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732136868; cv=none; b=b26bVp2V4cE0TDZ4JKHiaUKjlKK57yB5Fd0DFBoFiN5bm5jlWLFycWVS26aEdF33TjKV3lmaDCTj88yMYBjZ3UwyFXRbNwV+NteUX58AuZOTVsJtNhRLHM6UJJjuDNLV1jA9ymO+8cJfoPkGnxVJlqSNTJ18k9sp7ny63DprHUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732136868; c=relaxed/simple;
	bh=LBbdjy+TYOCJ9t+XX3uYFw4y+bCWX0vGoAICMMzs6eM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q/70sl9tpCg0524KZXZfuu+m4HRphVixWZ3mcB5MBjJiTxOhnzZ8AUJJooNcgRX2oCoTgSZn1S4u+813TW+V8AZ8kGywLJi9k8x1b2Xk6PSmu0PZSkBaZYqWpCwx9dtXqPrTOwaXPHpY/xI1JwF6+6dloAIDVqZrQ4AJcnBaaPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vh5Rswhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1060C4CECD;
	Wed, 20 Nov 2024 21:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732136868;
	bh=LBbdjy+TYOCJ9t+XX3uYFw4y+bCWX0vGoAICMMzs6eM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Vh5RswhlQ5CAz7lPYydTwIlBmeRw3kKZhMKM6LAch2wAKGdYHCxieSDYgx5GRxd5q
	 l9ekxI1+hrUpDTaZHJW4I//7GfQPcB0WydjN7KXErDtpwekXZiBED61IKceycB4plj
	 VVwntJpSHDga02HOqweVH9eLPlY1ggX+w1D1gYJG91jcUqPIVmvUY3aT6KCyP+Ivf9
	 9YfKLulmQz5jUjcpFmhjlZ+e3yfjSpNUO9X5oXmx4uPzt06fuE+3eFs/7fro4Rqbqt
	 h7ykS1bavTZX7eoULH2Wqmh1h7bZEnSuy3KXMXL5tzu1d6MjEdihXbJwE+0uC/zB4C
	 JZSHIprFWEK7w==
Date: Wed, 20 Nov 2024 15:07:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: Szymon Durawa <szymon.durawa@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>
Subject: Re: [PATCH v2 0/8] VMD add second rootbus support
Message-ID: <20241120210746.GA2353848@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120101021.00007003@linux.intel.com>

On Wed, Nov 20, 2024 at 10:10:21AM +0100, Mariusz Tkaczyk wrote:
> On Fri, 15 Nov 2024 11:48:55 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > The "BUS0" nomenclature seems heavily embedded in the vmd driver but
> > is really a misnomer.  Maybe that reflects similar terminology in an
> > internal spec?  Any hard-wiring of bus numbers reflects a property of
> > the way a *Root Port* works, so using the right name will make this
> > easier to understand, especially since there are other Root Ports with
> > the same hard wiring.
> 
> It is named as BUS_0 and BUS_1 because it refers to kernel's
> pci_create_root_bus()`, we simplified it for better code wrapping.
> 
> Looks like it confuses you, do you like ROOT_BUS0 and ROOT_BUS1 better?
> 
> I don't see better fit than "root bus" because we are creating new root buses
> accordingly.

I was trying to use standard PCIe spec terminology where possible, but
I misspoke above, sorry.  I think we should pretend I never wrote that
paragraph, and also ignore my suggestion about replacing "rootbus"
with "Root Port" in the 7/8 commit log (sorry to everybody who never
got the patches I was responding to).

A "root bus" is the *primary* bus of a Root Port, so the root bus
number is determined by the host bridge, which I guess would be
considered part of a PCIe Root Complex.

> Internally, it is called as "VMD domain" and each VMD Domain is presented as
> separate pci root bus.
> 
> The original naming is presented in the sysfs links:
> - "domain" -> root bus 0
> = "domain1" -> root bus 1
> 
> i.e:
> domain -> pci10000:e0/pci_bus/10000:e0
> domain1 -> pci10000:e1/pci_bus/10000:e1

That's fine, I'm not suggesting any sysfs change to this.

Bjorn

