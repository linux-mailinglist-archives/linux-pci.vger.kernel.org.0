Return-Path: <linux-pci+bounces-32142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A98B057BC
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 12:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1201E3B1482
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870A26D4C0;
	Tue, 15 Jul 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="te+v2f++"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998332E370F;
	Tue, 15 Jul 2025 10:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752575242; cv=none; b=hjuV8XIC5uuEerkvcbvhd310qIhoSpcPbnWtQDE650JacK/0/djnyxwjHoqaPVCdSxdfTKNr7wB2XiUZ4eTlQs4vM/dRZqCUwifYNoNaj4pQ3QUHyFt1SiW753/C3zL29vwU+M9u0Mr7r/HhlFqNg0FbrrbtrfzsCiqyTM0t20Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752575242; c=relaxed/simple;
	bh=0wa00danfxhilqqW7ORhpic0CJmnGdelkPvBsuXWTeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gzFeGaprIeQLS9fOsy1vLDbvvFNgvyI+RCxvinJRRdMokUZ/kuvkkAwJ6tSwCt9dxJgga5qT14fxpR85LYslAO6eXQJ65Mu9VSluwNGxtMNDxm3dlhKN9fpeItYspQNHhF/Z3cM5C9yWALw5Ye1W3Y3xFOMHNIn2jrvL2zWxJ3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=te+v2f++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082DBC4CEF1;
	Tue, 15 Jul 2025 10:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752575242;
	bh=0wa00danfxhilqqW7ORhpic0CJmnGdelkPvBsuXWTeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=te+v2f++OblDnKdezVznEeZqlcQCmodlkynonZlbsHD0BZ7xZESJVqHQ1cvOGCqf2
	 YC3OFuFsOroFCDiTpTB3WA3J52NmwIRTse0TfGfo1QvvphQ8a6L5WSNFNVl802toVy
	 rpVo82yCx8lwCOjFq+UdGwI9Sw3zWbCLeOTTiJF3+3f9ux/wCVNTOT6lTWqRz+6Sh9
	 qiNhqO16ElmJ/Pv67UAk4DySZzPf12OaPAOqvPve0KE9rZR4HgFZi6Es3QUybpJcVT
	 SRxfs4kilN5IzqYAa2H5D9/zCWSxTFYAy5DNCU/RrNreLvr+tLTnEMwgYP3DbrXWsw
	 AEhrdSRGJUzhQ==
Date: Tue, 15 Jul 2025 15:57:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <jmj2aeuguitas75xxos4wbhqjoaniur7psoccfxqniask7yxcu@3azibftfflch>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
 <aHYHzrl0DE2HV86S@hovoldconsulting.com>
 <yqot334mqik74bb7rmoj27kfppwfb4fvfk2ziuczwsylsff4ll@oqaozypwpwa2>
 <aHYgXKkoYbdIYCOE@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHYgXKkoYbdIYCOE@hovoldconsulting.com>

On Tue, Jul 15, 2025 at 11:33:16AM GMT, Johan Hovold wrote:
> On Tue, Jul 15, 2025 at 02:41:23PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jul 15, 2025 at 09:48:30AM GMT, Johan Hovold wrote:
> > > On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:
> 
> > > > Obviously, it is the pwrctrl change that caused regression, but it
> > > > ultimately uncovered a flaw in the ASPM enablement logic of the controller
> > > > driver. So to address the actual issue, switch to the bus notifier for
> > > > enabling ASPM of the PCI devices. The notifier will notify the controller
> > > > driver when a PCI device is attached to the bus, thereby allowing it to
> > > > enable ASPM more reliably. It should be noted that the
> > > > 'pci_dev::link_state', which is required for enabling ASPM by the
> > > > pci_enable_link_state_locked() API, is only set by the time of
> > > > BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
> > > > during BUS_NOTIFY_ADD_DEVICE stage.
> > > 
> > > A problem with this approach is that ASPM will never be enabled (and
> > > power consumption will be higher) in case an endpoint driver is missing.
> > 
> > I'm aware of this limiation. But I don't think we should really worry about that
> > scenario. No one is going to run an OS intentionally with a PCI device and
> > without the relevant driver. If that happens, it might be due to some issue in
> > driver loading or the user is doing it intentionally. Such scenarios are short
> > lived IMO.
> 
> There may not even be a driver (yet). A user could plug in whatever
> device in a free slot. I can also imagine someone wanting to blacklist
> a driver temporarily for whatever reason.
> 

Yes, that's why I said these scenarios are 'shortlived'.

> How would this work on x86? Would the BIOS typically enable ASPM for
> each EP? Then that's what we should do here too, even if the EP driver
> happens to be disabled.
> 

There is no guarantee that BIOS would enable ASPM for all the devices in x86
world. Usually, BIOS would enable ASPM for devices that it makes use of (like
NVMe SSD or WLAN) and don't touch the rest, AFAIK.

> > > Note that the patch fails to apply to 6.16-rc6 due to changes in
> > > linux-next. Depending on how fast we can come up with a fix it may be
> > > better to target 6.16.
> > 
> > I rebased this series on top of pci/controller/qcom branch, where we have some
> > dependency. But I could spin an independent fix if Bjorn is OK to take it for
> > the 6.16-rcS.
> 
> Or we can just backport manually as we are indeed already at rc6.
> 

I'll leave it up to Bjorn to decide.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

