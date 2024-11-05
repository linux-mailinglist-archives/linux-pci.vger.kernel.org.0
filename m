Return-Path: <linux-pci+bounces-16046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD5B9BCF70
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 15:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AC2286344
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 14:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAF1D88D4;
	Tue,  5 Nov 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU7hKjL0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5172D1D4173
	for <linux-pci@vger.kernel.org>; Tue,  5 Nov 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817245; cv=none; b=TRYSa06XvNFh8cSjbMCzMf+xMaa8ORpnKETcmlyLOV8s6uRSFwxvvJdeUhWgh/oE8/rWZmDWsksfJ1FYBJUaotJa1nJEcwYQZZQwmzHoPYVXFuZaxdmVZkhVk/Lxx5OiMsQY4iUBYhf1VCOz0xz577afrNF35JNWWnkwZ+8yfbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817245; c=relaxed/simple;
	bh=mDc/MmkLg6pdhlDQ0V8ugVv2OewYAgmAPafOBZpbKwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Yg5aAxY96EhSdyN9SmNBCcpKNx4A3DTDJ9bIn54ZSOF6AFepMrSxlWD/zgWIkNp1nmqM9okeUH0lMyqIx4yXYK7kPvXMw16LvWJAMvbYEU5SsOl7W6NAS9ECht2Lic6vofn3IBdKKT6ALH0LGp8i2C1kjcbnR9YXrmhwwSR+0rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU7hKjL0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D9CC4CED0;
	Tue,  5 Nov 2024 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730817244;
	bh=mDc/MmkLg6pdhlDQ0V8ugVv2OewYAgmAPafOBZpbKwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QU7hKjL0vtt014Q/WjER2Mc1Ze0WolADLphkmdfSUh2Ue8EisK4teJA5cCXApbQIa
	 Y2bXsMmcV5NrGRRlU7tGG130Swdqwb+XLYajrYN6/7P+eII2KCKCf+/KmXYty3LPtB
	 4q4HhnGmPUft0ZAOW6mIPlZdf0EegwXGwYXMWoBcLiy3OU1FZErgNkeNh25n5/FbnI
	 yY9yNYr/qx1f9FMqCWO7XcVwB9UH33bKmoXdTJT+08yCErPC7DFfSnd9sydQeaqSCq
	 nkP5GB2utoUzVCoG2yvS2ifxl6J4hyQIKooRpnTz4hCUNM+FgGdE8Aa8D4mJr6QBFQ
	 JQTE0NfdTNpvQ==
Date: Tue, 5 Nov 2024 08:34:03 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan =?utf-8?B?xaDDrWRsbw==?= <me@xoores.cz>
Cc: linux-pci@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: IWL errors when reading PCI config through /sys
Message-ID: <20241105143403.GA1470196@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ec705d88869e774ea18b46fe7f2bb5d0378c808.camel@xoores.cz>

On Tue, Nov 05, 2024 at 01:24:59AM +0100, Jan Šídlo wrote:
> On Mon, 2024-11-04 at 17:33 -0600, Bjorn Helgaas wrote:
> > It *should* be safe to read "config" from sysfs at any time, and
> > also to write to the ASPM "policy" module parameter file at any
> > time, but there could be bugs there.
> > 
> > When you say "crash", I guess you mean all the iwlwifi error
> > logging and the WARN_ON() stacktraces, right?   I don't see an
> > actual oops or panic in the logs yet.
> 
> There is no crash in form of an oops from the kernel fortunately :)
> But the WLAN card stops talking & IWL driver is not able to recover.
> Only shutdown fixes the issue. I did not try just reboot to be
> honest as I thought that full powercycle is necessary to properly
> reset the device - but I can try tomorrow if necessary.
> 
> > I assume none of these happen unless you are running your script
> > or writing the "policy" parameter?  Does the problem happen if you
> > *only* run your script to scrape the info from "config"?  What
> > about if you *only* update the "policy" parameter?
> 
> The error does not happen if I read the config - I tested that
> properly. Without touching the ASPM policy the script is able to run
> without any problems. And also I can trigger the bug immediately
> when I write "powersave" to the ASPM policy without the script.

Perfect, thanks for narrowing that down!

> > Emmanuel is right; the iwlwifi logging (e.g., "iwlwifi
> > 0000:04:00.0: 0xFFFFFFFF | ADVANCED_SYSASSERT") sure looks like
> > reads from the device are failing so we get ~0 data.  I'm guessing
> > those come from a BAR, so the BAR could be disabled or the device
> > might not be responding e.g., if it is in a low-power state (D1,
> > D2, D3hot, D3cold) or being reset.
> 
> Device is reported being in D0 through the sysfs, but I'm not sure
> if that is really correct, because if I do echo 1 > remove and
> rescan, the kernel complains about not being able to talk to the
> device. I can get the exact error tomorrow if you'd like.

It's unavoidably racy to read the current state from config space.
But since you've identified the write to "policy" in
pcie_aspm_set_policy() as the critical item, I think that's the place
to look.

We had some recent issues related to configuring ASPM while the device
was in a low-power state, e.g.,
https://lore.kernel.org/linux-pci/20240130163519.GA521777@bhelgaas/

While pcie_config_aspm_link() does check dev->current_state, I don't
see anything that would prevent the power management framework from
changing the power state while we're configuring devices to match the
new ASPM state.

Bjorn

