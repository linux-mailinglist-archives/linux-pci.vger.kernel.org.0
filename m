Return-Path: <linux-pci+bounces-31308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B2AF62F5
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 22:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B191F4E7B0E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 20:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ABD2BE63A;
	Wed,  2 Jul 2025 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHDh0QYL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419282343B6;
	Wed,  2 Jul 2025 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751486664; cv=none; b=uMB72tU+n7wXOP2A0VlYY2HZAGJdNkj4me024780O5tZ4UFiGeVjoc426uzkjcthAmWxThqs+1j5bmhMW3cqaFdN6b9B9E4LXh38yFvvLg7aJ93l6EjcVZE3GOhOfPKFapmPxBJtYOBx2OTPhrp1RyM1JHTK3mIOGR06xbTEBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751486664; c=relaxed/simple;
	bh=WtL15z/06BTvuw/hjfjPh8ZKbOQ24/jgbn4hckbcBKs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lgha90818OeFhHAJqNcLmjXUW3jOm/RrX485P1IuDB3fHGTmJ9MZsV1HlwU+Hs3Jg0vwzEuTzjMfAcWNE/xNVYrdwR6pYzdBcuOR6rLJSm5ktRuqaZJqS5pH6tIGuYaQM+ADBzEebeCUCxn/+HgUKRQX1ft8M/BE8tFVyFDiDN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHDh0QYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D372DC4CEE7;
	Wed,  2 Jul 2025 20:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751486664;
	bh=WtL15z/06BTvuw/hjfjPh8ZKbOQ24/jgbn4hckbcBKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZHDh0QYLt++G4xHziVB11juv4/NaxWBHSVboXGRE40bJIm3YHM1TIdS7y3bjIgN+N
	 dd1yfPNwlGdG1xe0V6WKvawqbbGwJoS82r4TYMcxzqc+aXpIsWFBccqxTJXB+IYDa7
	 xN9YmRLIOUoDJlhXt7m05WC9QBGJTpJfeQF3Rojx9KSLwBqy74qSjGNFBvLIdoiTiF
	 AWAwuey3p0XTz0JlKNC38a3Ui1/1BHFEjqJlytrr7UPMlCDigLV/scZs6YaRNYqDnL
	 9sj8MfD1xAtI7EF+MSh9uKYvE3Kl7xI9u2uHLl9PV0QItbiRvInU3mcSCxgShk1rDU
	 Gy57bkNBRdqPQ==
Date: Wed, 2 Jul 2025 15:04:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <20250702200422.GA1897177@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ezlr2xqy5bnq6cnrrjltlim7oiorcy2xrsoclj6fnu5jcymie5@xfatlrts6vod>

On Thu, Jul 03, 2025 at 12:00:43AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jul 02, 2025 at 12:53:07PM GMT, Bjorn Helgaas wrote:
> > On Wed, Jul 02, 2025 at 12:17:00PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jul 01, 2025 at 03:35:26PM -0500, Bjorn Helgaas wrote:
> > > > [+cc Bart]
> > > > 
> > > > On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > > > > If devicetree describes power supplies related to a PCI device, we
> > > > > previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> > > > > not enabled.
> > > > > 
> > > > > When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> > > > > pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> > > > > core will rescan the bus after turning on the power. However, if
> > > > > CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> > > > 
> > > > Separate from this patch, can we refine the comment in
> > > > pci_scan_device() to explain *why* we should skip scanning if a
> > > > pwrctrl device was created?  The current comment leaves me with two
> > > > questions:
> > > > 
> > > >   1) How do we know the pwrctrl device is currently off?  If it is
> > > >      already on, why should we defer enumerating the device?
> > > 
> > > I believe you meant to ask "how do we know the PCI device is
> > > currently off". If the pwrctrl device is created, then we for sure
> > > know that the pwrctrl driver will power on the PCI device at some
> > > point (depending on when the driver gets loaded). Even if the device
> > > was already powered on, we do not want to probe the client driver
> > > because, we have seen race between pwrctrl driver and PCI client
> > > driver probing in parallel. So I had imposed a devlink dependency
> > > (see b458ff7e8176) that makes sure that the PCI client driver
> > > wouldn't get probed until the pwrctrl driver (if the pwrctrl device
> > > was created) is probed. This will ensure that the PCI device state
> > > is reset and initialized by the pwrctrl driver before the client
> > > driver probes.
> > 
> > I'm confused about this.  Assume there is a pwrctrl device and the
> > related PCI device is already powered on when Linux boots.  Apparently
> > we do NOT want to enumerate the PCI device?  We want to wait for the
> > pwrctrl driver to claim the pwrctrl device and do a rescan?  Even
> > though the pwrctrl driver may be a loadable module and may not even be
> > available at all?
> > 
> > It seems to me that a PCI device that is already powered on should be
> > enumerated and made available.  If there's a pwrctrl device for it,
> > and we decide to load pwrctrl, then we also get the ability to turn
> > the PCI device off and on again as needed.  But if we *don't* load
> > pwrctrl, it seems like we should still be able to use a PCI device
> > that's already powered on.
> 
> The problem with enumerating the PCI device which was already
> powered on is that the pwrctrl driver cannot reliably know whether
> the device is powered on or not.  So by the time the pwrctrl driver
> probes, the client driver might also be probing. For the case of
> WLAN chipsets, the pwrctrl driver used to sample the EN (Enable)
> GPIO pin to know whether the device is powered on or not (see
> a9aaf1ff88a8), but that also turned out to be racy and people were
> complaining.
> 
> So to simplify things, we enforced this dependency.

Oh, thank you!  This inability of pwrctrl to determine the current
device power state is a critical missing piece in understanding the
race.

Although d8b762070c3f ("power: sequencing: qcom-wcn: set the
wlan-enable GPIO to output") suggests that gpiod_get_value_cansleep()
*does* read the current GPIO state, i.e., the current device power
state.

29da3e8748f9 ("power: sequencing: qcom-wcn: explain why we need the
WLAN_EN GPIO hack") adds a comment that we *should* use GPIOD_OUT_LOW
(which would toggle WLAN power) but can't until the qcom controller
driver implements link-down handling.

Is power-cycling the PCI device when pwrctrl loads a requirement of
the pwrctrl design?  A power cycle adds significant latency, so it
seems a little aggressive to me unless it is absolutely required.

29da3e8748f9 also mentions some platforms that still fail to probe
WLAN due to some unspecified qcom issue that needs a workaround, so I
guess this is still an open issue?

So I wonder if this inability to determine the current power state is
real or just an artifact of the various workarounds so far.

> > > >   2) If the pwrctrl device is currently off, won't the Vendor ID read
> > > >      just fail like it does for every other non-existent device?  If
> > > >      so, why can't we just let that happen?
> > > 
> > > Again, it is not the pwrctrl device that is off, it is the PCI
> > > device. If it is not turned on, yes VID read will fail, but why do
> > > we need to read the VID in the first place if we know that the PCI
> > > device requires pwrctrl and the pwrctrl driver is going to be probed
> > > later.
> > 
> > I was assuming pwrctrl is only required if we want to turn the PCI
> > device power on or off.  Maybe that's not true?
> 
> Pretty much so, but we will also use it to do D3Cold (during system
> suspend) in the near future.

Turning main power on and off is exactly what D3cold is about.  I
expected this kind of use for suspend, which is why I asked about
overlap with ACPI, which also provides ways to control main power.

Bjorn

