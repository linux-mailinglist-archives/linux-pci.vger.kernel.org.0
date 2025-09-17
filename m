Return-Path: <linux-pci+bounces-36337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C313EB7DC81
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055331BC4FA7
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 10:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F1B34A339;
	Wed, 17 Sep 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHISXXaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840E7274676;
	Wed, 17 Sep 2025 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103740; cv=none; b=PTRk+KCdksk9+cnqXI4MPIuXdqoGE3qMgOpsmnODUp245DBs5rjtGV2pPdeZXX0LSXejxvJDiKXwaEKYZ1hr0yWiRsjc9X2qAnbj2lrf/iXUtf74gvzLYMrNbeoUPntd9kg/fWKcTAKzjGDsXKZGpcs9/MBl+RTbjL0ItEcQIbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103740; c=relaxed/simple;
	bh=qopdOF4b1EoW6bbnf2cmA0S5LWM6jodQJY+YvdMAwng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdlSdgFvkPG6vR8NTmfFmPzvyCWVAcgHYFyfSITndwn2cRKZKwJGBbNRn3++T1rlME7pMdNr6kGDHguWnryBRW1kKj3UPnkbcsEC70aku6Xm6dBBy+fm16Fx9UlcUj5tP0uTM+R73BvSGvi6agC6dlsQl6Me9fsvixBQepgr5KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHISXXaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB680C4CEF0;
	Wed, 17 Sep 2025 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758103740;
	bh=qopdOF4b1EoW6bbnf2cmA0S5LWM6jodQJY+YvdMAwng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nHISXXaAek2TGr/JhG6fDI4s7XKikE24NWOExjRrHNln9zruEQSdgt4w90uLO+iuN
	 iIJcZ53pnABjoUiqk/E+tGDAypyDN1CRl/bEAqwmAMrILDpPxQxcUSyaoP4G7DYYAv
	 i7e3ZwQ6IXLMzk39lv5vFy8dKQl2I+RV3hSxFqnJApiFwgnI8fX0fy6LvDMzIZskQT
	 AEKwj6U0cI6J9EcQZ5pqO32js399COFHCVqgHCI4SKPobss+QI8R0wSIk+LhlMrOKU
	 ahrJKMznBmNW41vZBHPeVM/0JymLk5Tgeg8HlwwVHRg2xbKCbhetYtvjwV+wQH0Oiq
	 9qsECfQeZcEiA==
Date: Wed, 17 Sep 2025 15:38:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 3/4] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <vlpsaepw33ffv2mtenpkmsdtuf3aofxgi37utzqfxddervo32x@notmpwk44fej>
References: <blgpkdfx333h6vu25peatl3bbxffe5vuovgmae4osuoahuiryp@owrxkcv63kxb>
 <20250916194906.GA1738942@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250916194906.GA1738942@bhelgaas>

On Tue, Sep 16, 2025 at 02:49:06PM GMT, Bjorn Helgaas wrote:
> On Mon, Sep 15, 2025 at 06:23:45PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 12, 2025 at 06:28:11PM GMT, Bjorn Helgaas wrote:
> > > On Fri, Sep 12, 2025 at 02:05:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > 
> > > > Devicetree schema allows the PERST# GPIO to be present in all
> > > > PCIe bridge nodes, not just in Root Port node. But the current
> > > > logic parses PERST# only from the Root Port nodes. Though it is
> > > > not causing any issue on the current platforms, the upcoming
> > > > platforms will have PERST# in PCIe switch downstream ports also.
> > > > So this requires parsing all the PCIe bridge nodes for the
> > > > PERST# GPIO.
> > > > 
> > > > Hence, rework the parsing logic to extend to all PCIe bridge
> > > > nodes starting from the Root Port node. If the 'reset-gpios'
> > > > property is found for a PCI bridge node, the GPIO descriptor
> > > > will be stored in qcom_pcie_perst::desc and added to the
> > > > qcom_pcie_port::perst list.
> > > 
> > > The switch part doesn't seem qcom specific.  Aren't we going to
> > > end up with lots of drivers reimplementing something like the
> > > qcom_pcie_port.perst list?
> > 
> > If this kind of switch is attached to other platforms, then yes.
> > Right now, Qcom host is the only known DT based host platform that
> > has seen this requirement.
> 
> So I guess the issue here is that pwrctrl controls power to a slot
> below a Switch Downstream Port, and we want pwrctrl to also control
> PERST# to that same slot so that pwrctrl can power up the slot and
> then deassert PERST# to the slot later, e.g., after a T_PVPERL delay?
> 
> Seems like whatever parses the devicetree power regulator information
> for the slot should also parse the PERST# GPIO for the slot.
> 

Problem is, the controller driver also asserts PERST# during controller
initialization. So even if the power control driver parses PERST#, it still need
to share it with the controller driver somehow. I tried it in previous
iteration, but it turned out to be too complex. So settled with this version
where the controller driver parses PERST# as it used to, but not just from Root
Port and then asserts/deasserts PERST# through the callback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

