Return-Path: <linux-pci+bounces-16013-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C47229BC179
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 00:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AE2F1F22B59
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 23:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D071FE0E0;
	Mon,  4 Nov 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJ4KvM1R"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01041F755C
	for <linux-pci@vger.kernel.org>; Mon,  4 Nov 2024 23:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763184; cv=none; b=PelPAonGIw6Q3JY0wrRuctfqpAIzXdLApJ8TLqfhMjJfAO1dv0Z55O+ukGihul+to2o8KI7jXTdA6diFP7g4Fu4SLx6vh0MSlk7kLZ230OSb1LbUncWoc5mEiAk/V1160HApWYR0exrjPtBxm6Z0LdCuzrGxJCTXi7ra/8ZWn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763184; c=relaxed/simple;
	bh=gwS5zhaEjDCdFfATJEjxiQpcjfhwcKtQFdSHCA6e8FA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dRhUMFJNmL1/3u2J+f5ar/ImuO0r36wm+aiK3Nnw7f4A7T7Jl1gWg/r0TgqSdfGAeRZosfsJS0NNtPJ6xnDbg7rhB7XDZmbx8hlOsRy5x3NiJ0pVj6N5DyL70dd9xtwSzFIvkZoaFdcZTHyEWiRimpkw8maaHGKcY8YGm8KJZVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJ4KvM1R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A019C4CECE;
	Mon,  4 Nov 2024 23:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730763184;
	bh=gwS5zhaEjDCdFfATJEjxiQpcjfhwcKtQFdSHCA6e8FA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CJ4KvM1RJhr/4ALuiHSjkxEwhGc0uJAN3aoeNom4WZ39KjyE4tFo9+XEza/ML/OeH
	 DdE5zWmX7qVGJH+ZLgxWKf3Ns9BLT2bFSvGjHwyTtmZAOpUGDYgSv+DIYnAUA7jSVm
	 P5MAgQmwhymA+sOIrYf5ZUG6fKi9Ppcea+HCyde54GQkR5A1+VoTg4lvCvogI2inL5
	 rbL7SD2IdhBu6LZvBENFc5195CjTKJ2fHLzI36h0Fnzz9gCh4vDJreU/Oko7qkeOQc
	 47R7PJYzoAphmTZ4ZccXaxp5z91tX+Hf3D2Bug0Lnc0tM9G0ZCTikT9qrItWPgTDmu
	 VqpZOT5ZAnU8g==
Date: Mon, 4 Nov 2024 17:33:01 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jan =?utf-8?B?xaDDrWRsbw==?= <me@xoores.cz>
Cc: linux-pci@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: Re: IWL errors when reading PCI config through /sys
Message-ID: <20241104233301.GA1433525@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <117b71d187214442cbcec407a618ff546e5d4386.camel@xoores.cz>

[+cc Emmanuel]

On Sun, Nov 03, 2024 at 01:52:24PM +0100, Jan Šídlo wrote:
> ...

Thanks for the report!  Also, thanks for mentioning the bugzilla
report here on the mailing list, since most subsystems don't actively
monitor bugzilla.

> I'm trying to hunt down few issues with my new-ish HP ZBook not
> wanting to go to deeper C-stsates, which is kind of painful for a
> laptop (battery drain is ~5-10%/hour). For this I created a little
> python script that gathers all the info about all the components
> from the system and periodically reports the status (every 3s or so)
> including PCI and USB devices. To gather some information
> (specifically about ASPM) I'm reading /config file for each PCI
> device in /sys device tree and parsing it. I'm not reading only
> /config but it is a prime suspect, because I excluded WLAN card from
> this reading routine and the crash took much longer to occur - hours
> instead of minutes.
> 
> When I run this script, the IWL subsystem crashes after some time
> (minutes to hours). There is clearly something going on the PCI bus
> that I don't really understand. Since the error I get from IWL is
> changing, I suspect there is some kind of race condition that is
> triggered by my script. I opened a bug [1] and after some back and
> forth with Emmanuel Grumbach, he said that this kind of error is
> caused by IWL not being able to talk to the WLAN device (at all) and
> to try to get your opinion on the matter :)

It *should* be safe to read "config" from sysfs at any time, and also
to write to the ASPM "policy" module parameter file at any time, but
there could be bugs there.

When you say "crash", I guess you mean all the iwlwifi error logging
and the WARN_ON() stacktraces, right?   I don't see an actual oops or
panic in the logs yet.

I assume none of these happen unless you are running your script or
writing the "policy" parameter?  Does the problem happen if you *only*
run your script to scrape the info from "config"?  What about if you
*only* update the "policy" parameter?

Emmanuel is right; the iwlwifi logging (e.g., "iwlwifi 0000:04:00.0:
0xFFFFFFFF | ADVANCED_SYSASSERT") sure looks like reads from the
device are failing so we get ~0 data.  I'm guessing those come from a
BAR, so the BAR could be disabled or the device might not be
responding e.g., if it is in a low-power state (D1, D2, D3hot, D3cold)
or being reset.

I don't know whether iwlwifi checks for any PCIe failures like this.
I see iwl_trans_is_hw_error_value(), but that must be for some
iwlwifi-specific error thing, not for PCIe errors, because it checks
for things like 0xa5a5a5a0.  For PCIe errors, we would see ~0
(0xffffffff).

My guess is that all the other WARN()s and stacktraces are just a
consequence of trying to do things to a device that isn't responding.

> I have tried two different kernel versions (6.11.5 and 6.10.10), two
> different WLAN cards (BE200NGW and AX211NGW) and multiple versions
> of firmware for the cards. The error is still present, so I would
> say I'd need to dig deeper, but I'm not really familiar with PCI
> subsystem and how to debug it efficiently given the amount of data
> going through.
> 
> What can I do to debug this issue further?
>
> 1 - https://bugzilla.kernel.org/show_bug.cgi?id=219457

Any clue if this is a regression?  Seems like a common device and we
should have lots of reports.  That would suggest something related to
scraping the "config" file or updating ASPM "policy" at runtime.  So
I'd say the first step is to confirm that one or both of those is
implicated.

Bjorn

