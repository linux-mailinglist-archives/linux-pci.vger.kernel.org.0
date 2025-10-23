Return-Path: <linux-pci+bounces-39175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50029C02AB2
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54081569202
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09A833EAFD;
	Thu, 23 Oct 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Z5KU8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC49B33DEFF
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238798; cv=none; b=DabxwYwOoNETcqKXDM7ESyHKMhgenX70+VdOj/RcxPi5oHdJj0PmYzCF5xsFGvYwB3Jrp6QyLV7whR/crYrLqRpJlH6rGjqAGAvU0ckKWPDd1E8ff28zguk4ux7kNadXjAX8qGlhtSDByENyGIh8YQySQTRh9ld7q9Gz1iW92U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238798; c=relaxed/simple;
	bh=h+icO936JD9teEQbZE1rnc5+Nmq3sJLtLM81uIp43hM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HYWa2D+/d0wZgQJH+PYp21ey1tVh3kOFor6VWk2Td1noyjUa89dcp4fw8voL4FdMGVdM4adXYtQMvYGEhoLzqlDiybVno/CDUum+Bb8F0ISkZMTGL9t17NC6UJi7nOsWMYA28xKO3L3OTcqS+3Y4Wnek1sAP1knZm75xjR/dgJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Z5KU8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AE3EC4CEE7;
	Thu, 23 Oct 2025 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238798;
	bh=h+icO936JD9teEQbZE1rnc5+Nmq3sJLtLM81uIp43hM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=C8Z5KU8kW8hHnaNrJcD9NZD9rWQ57hwrWE5Nve4fckneiMxuMuRDT3eVA7hS00i9c
	 IyaM4bt8tJZdImwRykswdO3VpPybfnqMrFlwjDU5zVAnwfuVgup10Oa7irEOrNSJIN
	 8pZXE4dqX9R722uFPdss03F7mPIQOsUt7T0JoDacpRFC1pvMAAxeFVYVIDoBMjkB+A
	 U8cqUh1K3UuWUKhI6rXt0cZ80HJ5LXdp6Wq151H9GNqEQo2YceLRfYAkTkZ7XJg2x8
	 p8pz4kEcnrNSSWCA8VdIdZxvyuil2XKmq/apcgmpONlFxjj6JSmlwoYXHhsVEuoZkc
	 HoFWECHsp6zcw==
Date: Thu, 23 Oct 2025 11:59:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Lukas Wunner <lukas@wunner.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	debian-powerpc@lists.debian.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251023165957.GA1300574@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023111947.6e960216@bootlin.com>

On Thu, Oct 23, 2025 at 11:19:47AM +0200, Herve Codina wrote:
> On Thu, 23 Oct 2025 14:19:46 +0530
> Manivannan Sadhasivam <mani@kernel.org> wrote:
> > On Thu, Oct 23, 2025 at 09:38:13AM +0200, Herve Codina wrote:
> > > On Wed, 15 Oct 2025 18:20:22 +0530
> > > Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > > On Wed, Oct 15, 2025 at 01:58:11PM +0200, Herve Codina wrote:  
> > > > > On Wed, 15 Oct 2025 13:30:44 +0200
> > > > > Christian Zigotzky <chzigotzky@xenosoft.de> wrote:
> > > > > > > On 15 October 2025 at 10:39 am, Herve Codina <herve.codina@bootlin.com> wrote:
> > > > > > > I also observed issues with the commit f3ac2ff14834
> > > > > > > ("PCI/ASPM: Enable all ClockPM and ASPM states for
> > > > > > > devicetree platforms")      

> > > I did tests and here are the results:
> > > 
> > >   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_ALL)
> > >     Issue not present
> > > 
> > >   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L1_1 | PCIE_LINK_STATE_L1_2)
> > >     Issue present, timings similar to timings already reported
> > >     (hundreds of ms).
> > > 
> > >   - quirk pci_disable_link_state(dev, PCIE_LINK_STATE_L0S);
> > >     Issue present, timings still incorrect but lower
> > >       64 bytes from 192.168.32.100: seq=10 ttl=64 time=16.738 ms
> > >       64 bytes from 192.168.32.100: seq=11 ttl=64 time=39.500 ms
> > >       64 bytes from 192.168.32.100: seq=12 ttl=64 time=62.178 ms
> > >       64 bytes from 192.168.32.100: seq=13 ttl=64 time=84.709 ms
> > >       64 bytes from 192.168.32.100: seq=14 ttl=64 time=107.484 ms
> > 
> > This is weird. Looks like all ASPM states (L0s, L1ss) are
> > contributing to the increased latency, which is more than what
> > should occur. This makes me ignore inspecting the L0s/L1 exit
> > latency fields :/
> > 
> > Bjorn sent out a patch [1] that enables only L0s and L1 by
> > default. But it might not help you. I don't honestly know how you
> > are seeing this much of the latency. This could the due to an
> > issue in the PCI component (host or endpoint), or even the board
> > routing. Identifying which one is causing the issue is going to be
> > tricky as it would require some experimentation.
> 
> I've just tested the patch from Bjorn and I confirm that it doesn't
> fix my issue.

You should be able to control ASPM at runtime via sysfs:

  What:           /sys/bus/pci/devices/.../link/clkpm
		  /sys/bus/pci/devices/.../link/l0s_aspm
		  /sys/bus/pci/devices/.../link/l1_aspm
		  /sys/bus/pci/devices/.../link/l1_1_aspm
		  /sys/bus/pci/devices/.../link/l1_2_aspm
		  /sys/bus/pci/devices/.../link/l1_1_pcipm
		  /sys/bus/pci/devices/.../link/l1_2_pcipm
  Date:           October 2019
  Contact:        Heiner Kallweit <hkallweit1@gmail.com>
  Description:    If ASPM is supported for an endpoint, these files can be
		  used to disable or enable the individual power management
		  states. Write y/1/on to enable, n/0/off to disable.

I assume you're using CONFIG_PCIEASPM_DEFAULT=y, and if you're using
v6.18-rc1 plus the patch at [1], we should be enabling l0s_aspm and
l1_aspm at most.

If the sysfs knobs work correctly, maybe we can isolate the slowdown
to either L0s or L1?

[1] https://lore.kernel.org/linux-pci/20251020221217.1164153-1-helgaas@kernel.org/

