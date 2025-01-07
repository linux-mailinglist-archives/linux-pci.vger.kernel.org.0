Return-Path: <linux-pci+bounces-19422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0228A04282
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 15:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6924518872C9
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4EF1F2368;
	Tue,  7 Jan 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0C0Lu+D"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39F1F2362;
	Tue,  7 Jan 2025 14:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736260082; cv=none; b=cgtmp7q8frk/fyVnRP4daxkyU8oli1qiMbSKSJHxepjpm8NrFfzRFxuOj2unvrRd0BDYfRc7s1Kz9lQ1Wfsn4ym3FvotTlXjpU0B+6bRcu0KRNz9Ep0Ak8Ke/K/Ng2z1/T+JUmguLitctkqeDV7ZO+z+PJoZZMd7CSWEGzR+PU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736260082; c=relaxed/simple;
	bh=qbthodxnfjHpalPSA26aJ84BEH9hLqyRK1lkEMuUG40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCcXlLeNHoP60PTcSpQ08Akv55CV3na9VIq++2h/IcqGWmXBRF1yrRFWY/ZDYmrUkT0gRQ9Quck7aizfGwhLRrEQa9/Gbj+y/3ak20QwM5CgFkrTGpMH7DwqKTNVfk26f9LX8iHvKVd2hhFFoCrYNvovduGFNQ5n6IMYFK0lqrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0C0Lu+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5660C4CEE1;
	Tue,  7 Jan 2025 14:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736260081;
	bh=qbthodxnfjHpalPSA26aJ84BEH9hLqyRK1lkEMuUG40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f0C0Lu+DBZ4IPTD/BPEF7JJsohuVLUDumI9MJedOPIyfZ02A5Jh/tmBiZXgEXRzmU
	 ImhSvUQOXpWEXua8th+El/AC2NhzvCxHAnTqjzyQNrorr4nzbJ1W1txWjLVQYzRWod
	 aGu0zI8f2iIVKyIRRbIqeHRihYQxm7eQPhJO//3a80CpPTNFyoS66b7bG0Zstpvlfn
	 J5zYtgBHfPmepsPLkCGFOF3Hf+RhXbn9dAxBd7SwjjMuDo2dfmN+nMW3JeLaqjRjWU
	 EnM3B4yXQ2bIcaT2lEpPljT86SvgZnEsb8hCDipSD3xVU6B/8t4h40PbwC2DAgkm1f
	 n0w7K5wdFoQdg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tVAYp-000000000uo-3MuU;
	Tue, 07 Jan 2025 15:28:00 +0100
Date: Tue, 7 Jan 2025 15:27:59 +0100
From: Johan Hovold <johan@kernel.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Markus.Elfring@web.de, quic_mrana@quicinc.com, rafael@kernel.org,
	m.szyprowski@samsung.com, linux-pm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Message-ID: <Z3057yuNjnn0NPqk@hovoldconsulting.com>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
 <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
 <Z30p2Etwf3F2AUvD@hovoldconsulting.com>
 <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7882105f-93a3-fab9-70a2-2dc55d6becfc@quicinc.com>

On Tue, Jan 07, 2025 at 07:40:39PM +0530, Krishna Chaitanya Chundru wrote:
> On 1/7/2025 6:49 PM, Johan Hovold wrote:

> >> @@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
> >>   		pcie_bus_configure_settings(child);
> >>   
> >>   	pci_bus_add_devices(bus);
> >> +
> >> +	/*
> >> +	 * Ensure pm_runtime_enable() is called for the controller drivers,
> >> +	 * before calling pci_host_probe() as pm frameworks expects if the
> >> +	 * parent device supports runtime pm then it needs to enabled before
> >> +	 * child runtime pm.
> >> +	 */
> >> +	pm_runtime_set_active(&bridge->dev);
> >> +	pm_runtime_no_callbacks(&bridge->dev);
> >> +	devm_pm_runtime_enable(&bridge->dev);
> >> +
> >>   	return 0;
> >>   }
> >>   EXPORT_SYMBOL_GPL(pci_host_probe);
> > 
> > I just noticed that this change in 6.13-rc1 is causing the following
> > warning on resume from suspend on machines like the Lenovo ThinkPad
> > X13s:

> Can you confirm if you are seeing this issue is seen in the boot-up
> case also. As this part of the code executes only at the boot time and
> will not have effect in resume from suspend.

No, I only see it during resume. And enabling runtime PM can (and in
this case, obviously does) impact system suspend as well. 

> > 	pci0004:00: pcie4: Enabling runtime PM for inactive device with active children

> I believe this is not causing any functional issues.

It still needs to be fixed.

> > which may have unpopulated ports (this laptop SKU does not have a modem).

> Can you confirm if this warning goes away if there is some endpoint
> connected to it.

I don't have anything to connect to the slot in this machine, but this
seems to be the case as I do not see this warning for the populated
slots, nor on the CRD reference design which has a modem on PCIe4.

Johan

