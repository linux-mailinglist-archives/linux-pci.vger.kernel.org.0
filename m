Return-Path: <linux-pci+bounces-32994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 049A4B133F4
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 07:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1697C189078C
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 05:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3FF217F27;
	Mon, 28 Jul 2025 05:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DpvubSxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310851A0703;
	Mon, 28 Jul 2025 05:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679221; cv=none; b=r9ldt7GGU8q94ThmSq36hr3iR416NzMAcJcdfMxVYrWJ0dWUPwLtHiW/icoYPj+hzgHEBPnELnZeeNj54kjeJ9VCtQ9iSOcnCYvE8BPRJ6QNYLNvW49KKEh1HHVXQmvOdnnKK7ZZJIUXCj7wMgx3vqXD8xLI6BSz12IRg220Iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679221; c=relaxed/simple;
	bh=mXDTgW56+oa3ibd+SR18KplhSyv921iJH8Jkc1wnIzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyZ07oS2WPcwF96s5DMoYnYujL1QG2HUW+6sCwUouTHxCZCgTOfjBKNQCfa5StE3vspXrEXmUJcakhp+BplkcOOjZZYqYS2b7RipiqpPAbcXMl/fbkYhgUs54FONKs50aFFHKayphZlzTv0NWQuhW64v4UvLFKCJup3mTxKxjP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DpvubSxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995D7C4CEE7;
	Mon, 28 Jul 2025 05:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753679220;
	bh=mXDTgW56+oa3ibd+SR18KplhSyv921iJH8Jkc1wnIzI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DpvubSxlFTR7jzru77CCHZUgblbVYj5V6L3qD4PQJGBwFxfVRJP+tEEPjH+H+MAKd
	 jOfl2kWVCrjWpAl0jJXzi5cWDPkEWn1HjqVS+9peJ9Jibe+2G73XK/12JKv/A3nIZf
	 EEdcgwJH/VN9hZE5uueLL52lTP1udu3QOPPW8wNXBk/nkSUpSPNItoag9g+xFBd6K4
	 I+/bflhZ5e2m8j31nWGRbti6FbZKSB0nk3t0gZs6+9J8XiufjzTkSun4kJXtkNBQOs
	 W//4G4IZLJy6zlavxu1zd5DB1HbT+h9bfl7JjybbBIAoq1q615iglu3WKooVG1KfSf
	 3oqH5dP0uKuEQ==
Date: Mon, 28 Jul 2025 10:36:54 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 3/3] PCI: qcom: Allow pwrctrl framework to control
 PERST#
Message-ID: <fgwbvjfvchzbi4qx5l7stpehm7dd5f5v2l4wtdwss342lb6pgy@wsn5f5ojevwj>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-3-c3c7e513e312@kernel.org>
 <aHGhd3LLg8Dwk1qn@google.com>
 <qolpaorpkoyr5vzuowx3ml7uzwf4xc6atikrpilvbprc2ny5no@rcune7o57fuz>
 <aIPuruD6jdpIDujD@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIPuruD6jdpIDujD@google.com>

On Fri, Jul 25, 2025 at 01:53:02PM GMT, Brian Norris wrote:
> Hi Manivannan,
> 
> Sorry for some delay. Things get busy, and I don't get the time for
> proper review/reply sometimes...
> 
> On Sat, Jul 12, 2025 at 11:50:43AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jul 11, 2025 at 04:42:47PM GMT, Brian Norris wrote:
> > > Hi,
> > > 
> > > On Mon, Jul 07, 2025 at 11:48:40PM +0530, Manivannan Sadhasivam wrote:
> > > > Since the Qcom platforms rely on pwrctrl framework to control the power
> > > > supplies, allow it to control PERST# also. PERST# should be toggled during
> > > > the power-on and power-off scenarios.
> > > > 
> > > > But the controller driver still need to assert PERST# during the controller
> > > > initialization. So only skip the deassert if pwrctrl usage is detected. The
> > > > pwrctrl framework will deassert PERST# after turning on the supplies.
> > > > 
> > > > The usage of pwrctrl framework is detected based on the new DT binding
> > > > i.e., with the presence of PERST# and PHY properties in the Root Port node
> > > > instead of the host bridge node.
> > > 
> > > I just noticed what this paragraph means. IIUC, this implies that in
> > > your new binding, one *must* describe one or more *-supply in the port
> > > or endpoint device(s). Otherwise, no pwrctrl devices will be created,
> > > and no one will deassert PERST# for you. My understanding is that
> > > *-supply is optional, and so this is a poor requirement.
> > > 
> > 
> > Your understanding is correct. But the problem is, you thought that pwrctrl
> > would work across all platforms without any modifications, which unfortunately
> 
> I do not think this. Of course there's some modification needed on
> occasion, especially when drivers assume they can poll for the link to
> come up when power isn't ready, or if they want to get PERST# right
> (i.e., $subject).
> 
> OTOH, I don't think you can claim that platforms *don't* support
> pwrctrl. If a driver has a well-behaved start_link() behavior and
> doesn't otherwise manage slot/endpoint *-supply properties (a la
> pcie-brcmstb), it should mostly work without further involvement.
> 

I agree. As I dig more, there seems to be a gazellion of these combinations
exist. In the next version, I'll try to accomodate most of them.

> But crucially, that changes with PERST#. And I think you're making
> very narrow assumptions when you do that.
> 

This series does indeed. I wanted to start small, but I realized that going too
simplistic won't work for everyone.

> > is not true and is the main source of confusion. And I never claim anywhere that
> > pwrctrl is ready for all platforms. I just want platforms to start showing
> > interest towards it and we will collectively solve the issues. Or I'll be happy
> > to solve the issues if platform maintainers show interest towards it. This is
> > what currently happening with brcmstb. I signed up for the transition to
> > pwrctrl as their out-of-tree is breaking with pwrctrl.
> > 
> > Right now, we indeed create pwrctrl device based on the presence of power
> > supplies as that's how the sole user of pwrctrl (Qcom platforms) behave. But
> 
> I don't see how this is really Qualcomm specific, unless you simply
> require that all new Qcom DTs specify external *-supply. I don't see
> that in your Documentation/devicetree/bindings/pci/qcom*.yaml though,
> and I don't think that's reasonable.
> 
> > sure, for some other platforms we might have only 'reset-gpios'. When we have to
> > support those platforms, we will extend the logic.
> 
> The thing is, you don't have 100% control over this. You sound like you
> only want to support device trees that are shipped in the upstream
> kernel, but that's not how they work -- it's totally valid to ship
> non-upstream device trees, if you follow the DT bindings. And you've
> already hit that pitfall with brcmstb.
> 
> Suppose you have a Qcom platform today, with pwrctrl support, and:
> 
>  1. it has GPIO PERST#
>  2. some boards have external power controls for the endpoint. *-supply
>     nodes are described for the endpoint, and pwrctrl is in use.
>  3. some boards have hardwired power that is always-on / on at boot (no
>     *-supply node, no pwrctrl).
> 
> As you've written it today, #3 will no longer work, since you're
> deferring PERST# to pwrctrl, but pwrctrl never gets involved.
> 
> Crucially, you can't read the driver source to tell the difference
> between #2 and #3, and it's not even in the binding schema. Now magnify
> this across other drivers that might support this.
> 
> I have boards like #2 and #3, and I don't know how I'm supposed to
> develop my driver.
> 

pci_pwrctrl_create_device() should be really smart to figure out these
combinations. Let me see how smart it becomes.

> > > And even if all QCOM device trees manage to have external regulators
> > > described in their device trees, there are certainly other systems where
> > > the driver might (optionally) use pwrctrl for some devices, but others
> > > will establish power on their own (e.g., PCIe tied to some other system
> > > power rail).
> > > 
> > > I think you either need the PCI core to tell you whether pwrctrl is in
> > > use, or else you need to disconnect this PERST# support from pwrctrl.
> > > 
> > 
> > It is not straightforward for the PCI core to tell whether pwrctrl is in use or
> > not.
> 
> Yes, well this seems like a fundamental recurring problem at the root
> here. This agnostic design just causes more problems, IMO.
> 
> > pwrctrl has no devicetree representation as it is not a separate hardware
> > entity. It just reuses the PCI device DT node. So I used the -supply properties
> > to assume that the pwrctrl device will be used. And almost none of the upstream
> > DTS has -supply properties in the PCI child node (only exception is brcmstb
> > where they define -supply properties in the PCI child node, but only in the DT
> > binding). So that added up.
> 
> You gotta work off DT bindings and schema to make assertions. You can't
> just guess based on in-tree device trees, and so you can't prove
> non-existence, if it's not explicit in the bindings.
> 

This is the actual problem here. We cannot introduce any changes in the binding
for the sake of pwrctrl. Pwrctrl is just a kernel framework which is supposed to
work with the existing bindings and DTS. For sure we can ammend the binding to
make it strict. Like, mandating the -supply property even if it is always on as
the endpoint definitely needs atleast one supply from the host (well from the
system PMIC atleast). But nothing more.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

