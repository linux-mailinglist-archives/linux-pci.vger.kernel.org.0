Return-Path: <linux-pci+bounces-32138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693E3B05668
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402734E6972
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513E52D46AB;
	Tue, 15 Jul 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhBh2y9f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEAB2D3A94;
	Tue, 15 Jul 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572002; cv=none; b=BurFIublRjYagQZYn4PUGbcF8ykYne3gILcZSg4whGqa3diXxFG89bWXu7639T8/lhycUAwyWbaM2HN7TK9Yty2fmnO4gIOxluNvREUchWOkDd3LlIo2BECUh48xlNFWgD5fv2FMfqQeTx0yEA/XJfE1M1UEtKO1fkUsGnaGz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572002; c=relaxed/simple;
	bh=BlcupBeSsh92/FfhWpUNDaryykYxRcQiXUK/F5U4CyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZpVr4bcyaqcVi5wuL8y7z4M66WFT8FVP5+4oqT6pCV6h3qQHFrkpeIsL7DC+nEAVJqgOn8QpRYnAjtuZHTMxLuKxY4p/TMKvUYl30xz8+owN3pBSgsXU0FwUj36lvzsGoOhKLQO7ljAJvIXMl1Wj3l7psRr64Gt6IVlzE8DxJGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhBh2y9f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A412FC4CEF5;
	Tue, 15 Jul 2025 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572001;
	bh=BlcupBeSsh92/FfhWpUNDaryykYxRcQiXUK/F5U4CyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhBh2y9f/nDa5e3qp5QxcXni7wXiF4BLiGuCaggDyyUj6k/qLCswJX4zZqY8nVxCk
	 vHpfCjvF24Z5biBmaO8DpyGKNNTFNquzq3PHTMPHpLQg2MiIsz9EASKHbtp55jMyQq
	 EB2pjiNnL1OAe07yBfwL0sSvM3l06a0U9eUcBl4OeRijw7o+9+NCCi+nOmUqYwaFVB
	 rM0ZrX/bxFHqQy7eUm1D6PWXE/Pp30Tk1v1Usfn0kI+1MYdRLSRy+0N8M16eUE+ZLn
	 gXZjQDnyqxYJ3mSTlYMLdNaZtZT6vGH5EwvtsM9x+EHP7vs/v0kJhXycIGfJI9zaOQ
	 zTlsA3zw6qZ0A==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1ubc2G-000000005TI-20mU;
	Tue, 15 Jul 2025 11:33:17 +0200
Date: Tue, 15 Jul 2025 11:33:16 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <aHYgXKkoYbdIYCOE@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
 <aHYHzrl0DE2HV86S@hovoldconsulting.com>
 <yqot334mqik74bb7rmoj27kfppwfb4fvfk2ziuczwsylsff4ll@oqaozypwpwa2>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yqot334mqik74bb7rmoj27kfppwfb4fvfk2ziuczwsylsff4ll@oqaozypwpwa2>

On Tue, Jul 15, 2025 at 02:41:23PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 15, 2025 at 09:48:30AM GMT, Johan Hovold wrote:
> > On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:

> > > Obviously, it is the pwrctrl change that caused regression, but it
> > > ultimately uncovered a flaw in the ASPM enablement logic of the controller
> > > driver. So to address the actual issue, switch to the bus notifier for
> > > enabling ASPM of the PCI devices. The notifier will notify the controller
> > > driver when a PCI device is attached to the bus, thereby allowing it to
> > > enable ASPM more reliably. It should be noted that the
> > > 'pci_dev::link_state', which is required for enabling ASPM by the
> > > pci_enable_link_state_locked() API, is only set by the time of
> > > BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
> > > during BUS_NOTIFY_ADD_DEVICE stage.
> > 
> > A problem with this approach is that ASPM will never be enabled (and
> > power consumption will be higher) in case an endpoint driver is missing.
> 
> I'm aware of this limiation. But I don't think we should really worry about that
> scenario. No one is going to run an OS intentionally with a PCI device and
> without the relevant driver. If that happens, it might be due to some issue in
> driver loading or the user is doing it intentionally. Such scenarios are short
> lived IMO.

There may not even be a driver (yet). A user could plug in whatever
device in a free slot. I can also imagine someone wanting to blacklist
a driver temporarily for whatever reason.

How would this work on x86? Would the BIOS typically enable ASPM for
each EP? Then that's what we should do here too, even if the EP driver
happens to be disabled.

> > Note that the patch fails to apply to 6.16-rc6 due to changes in
> > linux-next. Depending on how fast we can come up with a fix it may be
> > better to target 6.16.
> 
> I rebased this series on top of pci/controller/qcom branch, where we have some
> dependency. But I could spin an independent fix if Bjorn is OK to take it for
> the 6.16-rcS.

Or we can just backport manually as we are indeed already at rc6.

Johan

