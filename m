Return-Path: <linux-pci+bounces-4211-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B5686BA72
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 23:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB14B298BB
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 22:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E6776EE8;
	Wed, 28 Feb 2024 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSjD+Abf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5C97443C;
	Wed, 28 Feb 2024 22:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709157737; cv=none; b=iMQTqX0ledwy51TUvWow4iHwitZSt1cj8Nj5zPJWDhRTLZxYe7/9m2jEy534/GiA3tbrBbgHEmVGsZtGWOSzg67etAx/7PTjCuI47HR2ctrHytWCrqEdF+LzEZykamV+PG5hwIwwqkGHcktzMcom3Q+28336QPieYHufmO2ueCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709157737; c=relaxed/simple;
	bh=gPOdghli+9QBbrWalwVFo9yVmHQwrDvufi1/D3sjuJU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dwHUWGupJSIrr9j6MdQD7UpnUMBSSoc1xn1fGwQtN3cWIjxY7Yxi6wgO0/1H4NY3TvZAlILDCGkpg//KgWe2NvklJqdRSJ9mO2yFov+L9wLZgxSS8zcYes+1yYHJxL5Fd4o+Co+moqk5FMN6N7VvgYcziCUYdphxYhDziwtn/8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSjD+Abf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7408C433F1;
	Wed, 28 Feb 2024 22:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709157737;
	bh=gPOdghli+9QBbrWalwVFo9yVmHQwrDvufi1/D3sjuJU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mSjD+AbfYXIBYbQ4bhnujqShmhMYIuSgeohNkRNuEha5uRrMMtmh9NSmoiBkanSSH
	 pzx8U1uk4eCfRXmGj1u0D82Vr61lA7o1701VRvmrp5NAH7K15iRBqu2rPYVQnqKTKt
	 OF0S37fJftNMBe0q+Rbv6zdrP1F7B9TMwICmtuwKp0c3uhNactpNOtSwB0QRI17zTR
	 4083jOeCzOzVgFyWsK9i124ivPvp5QbClQ6grbp3rAyQXGLg9Z+oveKbkEnZNaiIzp
	 dS47NLmnygDe4Ue9p+AyQGTBEJtDVbdHv9G9TJ18ghN679o6bUt0+L6ugQWdZEvT0w
	 QTTfj64E6EjbA==
Date: Wed, 28 Feb 2024 16:02:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 04/12] PCI: qcom: Add support for disabling ASPM L0s
 in devicetree
Message-ID: <20240228220215.GA308296@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd3_y_jbY8Ic2F0Y@hovoldconsulting.com>

On Tue, Feb 27, 2024 at 04:29:15PM +0100, Johan Hovold wrote:
> On Fri, Feb 23, 2024 at 04:10:00PM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 23, 2024 at 04:21:16PM +0100, Johan Hovold wrote:
> > > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting
> > > 1.9.0 ops") started enabling ASPM unconditionally when the hardware
> > > claims to support it. This triggers Correctable Errors for some PCIe
> > > devices on machines like the Lenovo ThinkPad X13s, which could indicate
> > > an incomplete driver ASPM implementation or that the hardware does in
> > > fact not support L0s.
> > 
> > Are there any more details about this?  Do the errors occur around
> > suspend/resume, a power state transition, or some other event?  Might
> > other DWC-based devices be susceptible?  Is there a specific driver
> > you suspect might be incomplete?
> 
> I see these errors when the devices in question are active as well as
> idle (not during suspend/resume). For example, when running iperf3 or
> fio to test the wifi and nvme, but I also see this occasionally for a
> wifi device which is (supposedly) not active (e.g. a handful errors over
> night).
> 
> I skimmed Qualcomm's driver and noted that there are some registers
> related to ASPM which that driver updates, while the mainline driver
> leaves them at their default settings, but I essentially only mentioned
> that the ASPM implementation may be incomplete as a theoretical
> possibility. The somewhat erratic ASPM behaviour for one of the modems
> also suggests that some further tweak/quirk may be needed, and I was
> hoping to catch Mani's interest by reporting it.
> 
> But based on what I've since heard from Qualcomm, it seems like these
> correctable error may be a known issue with the hardware (e.g. seen
> also with Windows), which is also why we decided to disable it for all
> controllers on these two platforms where I've seen this in v2.
>  
> > Do you want the DT approach because the problem is believed to be
> > platform-specific?  Otherwise, maybe we should consider reverting
> > 9f4f3dfad8cf until the problem is understood?
> 
> Enabling ASPM gave a very significant improvement in battery life on the
> Lenovo ThinkPad X13s, from 10.5 h to 15 h, so reverting is not really an
> option there.

Ah, I missed that you're only disabling L0s, but leaving L1 enabled,
thanks!

And given that the v1.9.0 ops that enable ASPM are used on a bunch of
platforms, and L0s seems to work fine on most of them, we wouldn't
want to disable L0s for everybody, so this seems like the right
solution.

Bjorn

