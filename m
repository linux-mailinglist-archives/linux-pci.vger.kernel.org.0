Return-Path: <linux-pci+bounces-45051-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E2CD326E1
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 15:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FA8030321D3
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 14:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F371529B8C7;
	Fri, 16 Jan 2026 14:14:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5E628C864;
	Fri, 16 Jan 2026 14:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768572843; cv=none; b=Zw1oa140jxTfngwehhywNG0WHz6k31YVKJYF5nIvPGQOpet8cFlpa4+7x64flz7HU5KOxm7f2u8lMbbiRCOwqZNoO4EKBrioZ5Qwnq0shEFGmIVqxnXbM42a3AZGWgY+ZsdHjP6pRQYPdJ5dYhfTmfPt0m8X2UYAF/9XcpVm42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768572843; c=relaxed/simple;
	bh=BzcSryxxNJ3TLp/seQBqaZQSUNN8rmk7+KJVw+M7lmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugCPrqUq25VfwvnkF3lAnsZbKOmdBA2FgY+oeIDNP+XTHMl+ke0CvENd0GJ77gHuiHgW35i2D8fIg172xUeMmd3XUOsdxMPN/UdZsTqZDggYq36nIMlfc/NPasLyeAkEkTjqXtGHUcZlLO1Cblr6T9cyEdBVTHpzawRflJcCgd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A63C116C6;
	Fri, 16 Jan 2026 14:13:57 +0000 (UTC)
Date: Fri, 16 Jan 2026 19:43:49 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Sean Anderson <sean.anderson@seco.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@kernel.org>, 
	Brian Norris <briannorris@chromium.org>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Alex Elder <elder@riscstar.com>, Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Chen-Yu Tsai <wenst@chromium.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 0/8] PCI/pwrctrl: Major rework to integrate pwrctrl
 devices with controller drivers
Message-ID: <apy6nr3imj74uy3w5zbfseazh6dxqmiv7k4w3hn2fkskmcsaw5@uzyddpmsmu7u>
References: <20260105-pci-pwrctrl-rework-v4-0-6d41a7a49789@oss.qualcomm.com>
 <0da0295a-4acb-430e-ae1a-e144f07418d0@seco.com>
 <6iqn3pmk7jb7j6cvmuv6ggs6xkd6ouz6klzhzdekrlzpbgxcua@ebskaj25jukl>
 <ef5d5fdc-be08-4859-a625-cdd1ae0c46c2@seco.com>
 <55cqkglbgji7tz34hk7aishyq3wal3oba5hy2yfvdbnkugadyg@56yh35kcgtwf>
 <aWo_kP170j7r4q1a@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWo_kP170j7r4q1a@ryzen>

On Fri, Jan 16, 2026 at 02:40:36PM +0100, Niklas Cassel wrote:
> On Fri, Jan 16, 2026 at 11:54:26AM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Jan 15, 2026 at 02:26:32PM -0500, Sean Anderson wrote:
> > > > 
> > > > Not at all. We cannot model PERST# as a GPIO in all the cases. Some drivers
> > > > implement PERST# as a set of MMIO operations in the Root Complex MMIO space and
> > > > that space belongs to the controller driver.
> > > 
> > > That's what I mean. Implement a GPIO driver with one GPIO and perform
> > > the MMIO operations as requested.
> > > 
> > > Or we can invert things and add a reset op to pci_ops. If present then
> > > call it, and if absent use the PERST GPIO on the bridge.
> > > 
> > 
> > Having a callback for controlling the PERST# will work for the addressing the
> > PERST# issue, but it won't solve the PCIe switch issue we were talking above.
> > And this API design will fix both the problems.
> > 
> > But even in this callback design, you need to have modifications in the existing
> > controller drivers to integrate pwrctrl. So how that is different from calling
> > just two (or one unified API for create/power_on)?
> 
> FWIW, I do think that it is a good idea to create a reset op to pci_ops
> that will implement PERST# assertion/deassertion.
> 
> Right now, it is a mess, with various drivers doing this at various
> different places.
> 
> Having a specific callback, the driver implement it however they want
> GPIO, MMIO, whatever, and it could even be called by (in case of DWC,
> the host_init, by pwrctrl, or potentially by the PCI core itself before
> enumerating the bus.
> 
> If we don't do something about it now, the problem will just get worse
> with time. Yes, it will take time before all drivers have migrated and
> been tested to have a dedicated PERST# reset op, but for the long term
> maintainability, I think it is something that we should do.
> 
> I also know that some drivers have some loops with retry logic, where
> they might go down in link speed, but right now I don't see why those
> drivers shouldn't be able to keep that retry logic just because we
> add a dedicated PERST# callback.
> 
> 
> All that said, that would be a separate endeavor and can be implemented
> later.
> 

Agree. Having unification always helps!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

