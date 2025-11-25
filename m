Return-Path: <linux-pci+bounces-42005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8E3C83622
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:25:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 506CE4E059D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772F3233707;
	Tue, 25 Nov 2025 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCRQKFYe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D2C1D63D1;
	Tue, 25 Nov 2025 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764048325; cv=none; b=stCY/cTkNGBpL7Ki0zT2KvooETaMBoG+4Z06w/ntlnUxXAgJdYfGTiISjYWRBDf6QpMeWPTfB/6UpMcJkOrG8YLdsARdra79RkUX3TbjpiOs8Raya+1+dXsesZwe2J0VFCp8SucW7K1KjnXk10VoT+IARoxq1XzRDIW1Zra16cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764048325; c=relaxed/simple;
	bh=YHZk6TcZwXmXzYNfBZm7hYEmK00oZ2fzc7kALopA/iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0MO9BOJ1HO6FasfH8V0IoHQzJRN6BhBnqlowraNH2vp1O1ZJz1l/ofKYZoLpLnqchsw1XgwP5Jlc4tXFuEGdDjfhM0jVFCAshuBoPY4WZtknvBNRGfSkfCDjT3/G3vdG9tCvVgWlfz3pUt1WZtbyzmsxp5jW/qinJPBTsWH6IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCRQKFYe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B55C4CEF1;
	Tue, 25 Nov 2025 05:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764048324;
	bh=YHZk6TcZwXmXzYNfBZm7hYEmK00oZ2fzc7kALopA/iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NCRQKFYe4AGwbOGth+WonBD537brle2qfV23NP/0JbJqlNKIMy34lTEnbNZnsouqP
	 iGDQsNWg34Enf6PU6Mqn3gIs4luGiFY608RjtOWmTLeHgRjYX/OfmjnbRIWhVDBWc5
	 IFja6EOGJpovJUa6QxGzx6czN9OYxf1k99RH/PPAn4Lu8uZB1Zh7bfVxrpVHDJexKh
	 i4KbLJOncMBRudrHnQ8xQNvwjPNRnunAqaLE9WwUAohaSK8zynKgO/rdyYQqY/zMsG
	 DF5OhgOJ9mBs1TlZoj2BM/wJvkhKvT3SpXXKrBrNXkgYmuA73WF0UABBYvuAXaqF0k
	 oDFfjlwCNIDNg==
Date: Tue, 25 Nov 2025 10:55:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Kever Yang <kever.yang@rock-chips.com>, Simon Xue <xxm@rock-chips.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>, 
	FUKAUMI Naoki <naoki@radxa.com>, Diederik de Haas <diederik@cknow-tech.com>, 
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>, 
	Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, kernel@pengutronix.de, 
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 1/4] PCI: dwc: Advertise L1 PM Substates only if
 driver requests it
Message-ID: <swchohhrkhyuzukrtonu4f3bzx3h6mha23rt6twqict42we2za@pq5hwfa75fps>
References: <wja7vxtg7bqq2udepl5r3mvgg5swvuqtuzk6cnimgcbw2aegqs@hru6yzg4xx3o>
 <20251124211903.GA2712341@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251124211903.GA2712341@bhelgaas>

On Mon, Nov 24, 2025 at 03:19:03PM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 20, 2025 at 01:10:56PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Nov 18, 2025 at 03:42:15PM -0600, Bjorn Helgaas wrote:
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > L1 PM Substates require the CLKREQ# signal and may also require
> > > device-specific support.  If CLKREQ# is not supported or driver support is
> > > lacking, enabling L1.1 or L1.2 may cause errors when accessing devices,
> > > e.g.,
> > > 
> > >   nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> > > 
> > > If the kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users
> > > enable L1.x via sysfs, users may trip over these errors even if L1
> > > Substates haven't been enabled by firmware or the driver.
> > > 
> > > To prevent such errors, disable advertising the L1 PM Substates unless the
> > > driver sets "dw_pcie.l1ss_support" to indicate that it knows CLKREQ# is
> > > present and any device-specific configuration has been done.
> > 
> > Going by this reasoning, why can't we enable L1 PM Substates for
> > these platforms by default?
> 
> I think we can, in a separate series.  I don't have time to deal with
> this before the v6.19 merge window, but you can certainly do that.
> 

I will take it up. Not sure if I can do it for v6.19 though.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

