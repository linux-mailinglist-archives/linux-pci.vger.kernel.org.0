Return-Path: <linux-pci+bounces-22944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C8EA4F71B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663393A8D20
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DB71DE2C1;
	Wed,  5 Mar 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FNBiiREh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870251DDC00;
	Wed,  5 Mar 2025 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741156158; cv=none; b=ANWcwQi/9o595PHFDh6iJ1T5d/7wOtxyEG/vmUsd8XqBDkrnHINXXRP60Gz2qusCav1B64F2+ho75dne4usje80txGVPhUzHL9iLm7uS/FCMDUFVKp3kCPBa50PW9iX9KW6gEPPb2ULh3LjpC4IgTL5BKjVnaDwKdYs91V1ulyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741156158; c=relaxed/simple;
	bh=QnNsAxAAPRtrdLLoNQzs0U4+euvNYFWn1D6cbxJcTc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlzoKutA+ShZHK1aymx/wfI0mHb7SzGCFCu1a5ogvKVajKtwmmIuj5rylwtgW+DlyMOJ7bOqPOwCAY929xm6gIruumlnuDdstc+zolBvHFWhQPSkikC9/pIxgU4cW7Xm1CYfF4JLfO7rkmNtLsOQbBZy6Uxs8FpZIEtOUgFI3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FNBiiREh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F3EC4CEEA;
	Wed,  5 Mar 2025 06:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741156157;
	bh=QnNsAxAAPRtrdLLoNQzs0U4+euvNYFWn1D6cbxJcTc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FNBiiREhKnNfvq/1JKt9X0ADJWCS5DyxtjUYE86KMC44qQ0xw2dIrYa/mU1ZrMdCb
	 detzbFtqM6wvD3l2oSHZ3CMi5Xm2SF3AGsjNME/wzSLw3XO/ZT+j44WiTS7b5gzaRx
	 tsVBEGR2+6jNdsiNeoOYmbz5Sgi6j7aeAPVQ7JLgqRWB5158HTXhIOQFKPO7NquJ8T
	 47F92xlT3pzLVtHs6SOizZpzUJBvEEzEXubjBsE6SDOBmmD4nzPSfpohiqg0OnJu+m
	 OTV+oaTuQ6O7NwsIarbgI6lv519V8cI2fxqiQQUN/lbCYoUNLX7uuIwtU64hVyBant
	 5CP8ErPQeASNg==
Date: Wed, 5 Mar 2025 11:59:10 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	lukas@wunner.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20250305062910.egasvrhhfqhgtkhn@thinkpad>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
 <20250228174509.GA58365@bhelgaas>
 <Z8IC_WDmix3YjOkv@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8IC_WDmix3YjOkv@google.com>

On Fri, Feb 28, 2025 at 10:39:57AM -0800, Brian Norris wrote:
> Hi Bjorn,
> 
> On Fri, Feb 28, 2025 at 11:45:09AM -0600, Bjorn Helgaas wrote:
> > On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> > > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > Unlike ACPI based platforms, there are no known issues with D3Hot for
> > > the PCI bridges in Device Tree based platforms. 
> > 
> > Can we elaborate on this a little bit?  Referring to "known issues
> > with ACPI-based platforms" depends on a lot of domain-specific history
> > that most readers (including me) don't know.
> 
> Well, to me, the background here is simply the surrounding code context,
> and the past discussions that I linked:
> 
> https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/
> 
> The whole reason we need this patch is that:
> (a) there's some vaguely specified reason this function (which prevents
>     standard-specified behavior) exists; and
> (b) that function includes a condition that allows all systems with a
>     DMI/BIOS newer than year 2015 to use this feature.
> 
> Digging a bit further, it seems like maybe the only reason this feature
> is prevented on DT systems is from commit ("9d26d3a8f1b0 PCI: Put PCIe
> ports into D3 during suspend"), where the subtext is that it was written
> by and for Intel in 2016, with an arbitrary time-based cutoff ("year
> this was being developed") that only works for DMI systems. DT systems
> do not tend to support DMI.
> 

I would say 'Majority of the DT systems' since there are exceptions like Qcom
compute platforms where developers put devicetree in an ACPI based laptop with a
BIOS/DMI (for a reason).

> If any of this is what you're looking for, I can try to
> copy/paste/summarize a few more of those bits, if it helps.
> 
> > I don't think "ACPI-based" or "devicetree-based" are good
> > justifications for changing the behavior because they don't identify
> > any specific reasons.  It's like saying "we can enable this feature
> > because the platform spec is written in French."
> 
> AIUI, It's involved because of the general strategy of this function
> (per its comments, "recent enough PCIe ports"). So far, it sounds like
> that reason (presumably, old BIOS with poor power management code)
> doesn't really apply to a system based on device tree, where the power
> management code is mostly/entirely in the OS.
> 
> But really, the original commit doesn't actually state reasons, so maybe
> the "known issues" phrasing could be weakened a bit, to avoid implying
> there were any stated reasons.
> 

Right. I guess the commit tried to be less invasive so the author decided to
limit it to DMI based systems. I couldn't think of any other reasons.

> > > Past discussions (Link [1]) determined the restrictions around D3
> > > should be relaxed for all Device Tree systems. 
> > 
> > This is far too generic a statement for me to sign up to, especially
> > since "all Device Tree systems" doesn't say anything at all about how
> > any particular hardware works or what behavior we're relying on.
> > 
> > We need to say something about what D3hot means (i.e., only message
> > and type 0 config requests accepted) and that we know anything below
> > the bridge is inaccessible in D3hot and why that's OK.  E.g., maybe we
> > only care about wakeup requests and we know those still work with the
> > bridge in D3hot because XYZ.
> 

This patch's main motive is to enable D3hot for bridges that was disabled for no
good reasons, other than the one mentioned above. Maybe adding a bit more about
bridge D3hot handling could be of help, but your comment sounds like you are
questioning why allowing D3hot is OK? But we already enable it for newer DMI
based systems. I think the question should be asked is, why PCI core decided to
not allow D3hot for DT based platforms without any user reported issues.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

