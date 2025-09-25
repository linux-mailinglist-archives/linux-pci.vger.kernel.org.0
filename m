Return-Path: <linux-pci+bounces-36984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED6BA0138
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 16:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A2E4C0EEF
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 14:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3CB2DECD2;
	Thu, 25 Sep 2025 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJ/3af5m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D39B2DCF77;
	Thu, 25 Sep 2025 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811967; cv=none; b=CEpiUAbpzZTVZLRhhjOi7zHt4hllbpG+FAIwaTxVM5J/UL6mIvcbdpaKsSdITxjBWbrJOWT2zIcTdxMW4DNYrwvPoBdWBm02DmMdTbWAukjC/9Seo04wr/j44QsPtGBgy1PkLF5CoUoStEXwxJd9f80tlLFnXEpEi2YFXW7bzu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811967; c=relaxed/simple;
	bh=LXq8HtGAU594S11XGd1rj37wwOjvDBuvwD1gQ+gWPVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brBE/t0JTijPhcLJV3VrY+xbMphgkHsrdqVB4c79hWXS9hKrb3C/qZyg4y+I2QQ0M5F7ehLA3wghWP9nu09feHtVr58IoqpXKqd5W8LWnwVl/U/cVWu/VaAX/AydSbsJExBZ5qcgN/SFfc1cncy6C2j9urA4El2yawlRampf+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJ/3af5m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16A2DC4CEF0;
	Thu, 25 Sep 2025 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811966;
	bh=LXq8HtGAU594S11XGd1rj37wwOjvDBuvwD1gQ+gWPVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DJ/3af5mp+DquibEWgvTF347o0EuFnNQEYO1CnZZn6lO7pETMHSegESQF6bzOR5I/
	 9wtrZQahcRSlu4n7GyzVjDw2dVHhqjgCLgkzHecWqg+rf6+vjNwSFjrju8KAGcHhN3
	 flx9nUlwdcP5ICCx7v2qou1iq1LHAkZjmpKkG3+7QEv4Z/MKyfijmd4y051l6LBe0W
	 9+oiK6dURTb8G5dLyeW7FuCnCZ3014kCcYaWuNsTrFzuhGwNEC67Xhw1H9mQxyBLD0
	 P+AL5bAPhKog3tBNzs17GqmNgEpp2vSX0yrmL+t3ssDS+5a8c9hPapDKABJeMabyl4
	 TQux7OQ/0+/cg==
Date: Thu, 25 Sep 2025 16:52:41 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	stable@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
	linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: tegra194: Fix broken
 tegra_pcie_ep_raise_msi_irq()
Message-ID: <aNVXOfP0fkdk0Svf@ryzen>
References: <20250922140822.519796-5-cassel@kernel.org>
 <20250922140822.519796-6-cassel@kernel.org>
 <va2vktobo5dwfh6mkl6emilsnkeleh6ubkbiylv4zoxr2cezpa@s7h3yuytcpv4>
 <u7xhhqz6pzfe2keqmlq5acbad5rydzsfw43puj6lugpvz47rtm@ua7zoenz5ivx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u7xhhqz6pzfe2keqmlq5acbad5rydzsfw43puj6lugpvz47rtm@ua7zoenz5ivx>

On Wed, Sep 24, 2025 at 09:58:20PM +0530, Manivannan Sadhasivam wrote:
> > > @@ -2012,6 +2012,7 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
> > >  
> > >  static const struct pci_epc_features tegra_pcie_epc_features = {
> > >  	.linkup_notifier = true,
> > > +	.msi_capable = true,
> > 
> > This change is unrelated to the above tegra_pcie_ep_raise_msi_irq() fix. So this
> > change should be in a separate patch.
> > 
> 
> I did the split and applied the series, thanks!

Thank you Mani!


Kind regards,
Niklas

