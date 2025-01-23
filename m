Return-Path: <linux-pci+bounces-20293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED0A1A894
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 18:13:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587B93AFF9A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AEC1465AC;
	Thu, 23 Jan 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2XnKDfy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE604146D68;
	Thu, 23 Jan 2025 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652114; cv=none; b=ewLCYnNMUOhG1dNILjA2MBdpIvdI6xBUlVqo9Zw7fzbK2KqM+VvmOHdq/nA7AFyjPGcHjE+h7l3F7+iBNHpn82ZXNBPlDZXqGaA4GDdVe83yKErlJgqdeL2eIk4gI3EFm++swDG0/ILriTAuXx8xL4l0AjBZWaIWahoo1MA3Ezo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652114; c=relaxed/simple;
	bh=uHFdtvUKM686hJ26eLLLR7g1uzApYotr6QctL8dyTWw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HvP/DgTEJKDO8IflJXPFiaaRAWFVzugDODUElL9kyCtJH5y90exE50Eq2qI4Q3CcTC5tQh5xfhnj5rQwXaW6d/GW8Z/+7ilZkGD/QX5iP1NvFkhN9dIZnLr2DxnDnHSK4UCYof3zF1PF9vmxDpHKaMbeSkoLdiiPl+JknyoEQTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2XnKDfy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196BEC4CED3;
	Thu, 23 Jan 2025 17:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737652113;
	bh=uHFdtvUKM686hJ26eLLLR7g1uzApYotr6QctL8dyTWw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o2XnKDfy7GVZNK0NxKILSxbB6Z9ogFvlNBcVZ8WEMoD5iuWCVB3jANyh/4JcTylME
	 0nvhRplldtFJ+1y2gbgWDYIpbJpGmEAjFXAy0xzBdtgakUKiS2sYy8kbwmAaUy4kf3
	 R9KQhiqJB/bet6JusoLY9dvABQNZgrsTElY5lK1IHa3EgylBnpTNVEhKTvzjOAA4FQ
	 Lch4g/LYyPH8nrkJtxg1Z83Gnf0uhAaxmDbf8c1cJf43LGYqYq9Gxym2RztX+pClZ3
	 MkaAGAAqbNUUTF8+JN3eUsl15aKHCJEmBtPyxh5qOvkRFY0PZyFVoZCsv2iu6poO9k
	 n8yFzejdpJbBA==
Date: Thu, 23 Jan 2025 11:08:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, bwawrzyn@cisco.com, thomas.richard@bootlin.com,
	wojciech.jasko-EXT@continental-corporation.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND] PCI: cadence: Add configuration space capability search
 API
Message-ID: <20250123170831.GA1226684@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfd4827-4d9e-4bcd-b1d0-8f9e349a6be7@163.com>

On Thu, Jan 23, 2025 at 04:15:12PM +0800, Hans Zhang wrote:
> On 2025/1/23 15:40, Siddharth Vadapalli wrote:
> > On Thu, Jan 23, 2025 at 03:09:35PM +0800, Hans Zhang wrote:
> > > Add configuration space capability search API using struct cdns_pcie*
> > > pointer.
> > > 
> > > Similar patches below have been merged.
> > > commit 5b0841fa653f ("PCI: dwc: Add extended configuration space capability
> > > search API")
> > > commit 7a6854f6874f ("PCI: dwc: Move config space capability search API")
> > 
> > Similar patches being merged doesn't sound like a proper reason for
> > having a feature. Please provide details regarding why this is required.
> > Assuming that the intent for introducing this feature is to use it
> > later, it will be a good idea to post the patch for that as well in the
> > same series.
> 
> For our SOC platform, the offset of some capability needs to be found during
> the initialization process, which I think should be put into the cadence
> public code
> 
> eg:
> 
> For API: cdns_pcie_find_capability
> Need to find PCI Express, then set link speed, retrain link, MaxPayload,
> MaxReadReq, Enable Relaxed Ordering.
> 
> For API: cdns_pcie_find_ext_capability
> Need to find the Secondary PCIe Capability and set the GEN3 preset value.
> Find the Physical Layer 16.0 GT/s and set the GEN4 preset value.
> 
> Development board based on our SOC, Radxa Orinon O6.
> https://radxa.com/products/orion/o6/
> 
> Our controller driver currently has no plans for upstream and needs to wait
> for notification from the boss.

If/when you upstream code that needs this interface, include this
patch as part of the series.  As Siddharth pointed out, we avoid
merging code that has no upstream users.

Bjorn

