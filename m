Return-Path: <linux-pci+bounces-30656-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E36AE8F58
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 22:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2933C1C269D7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 20:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13052DAFDE;
	Wed, 25 Jun 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAJzgcGE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F85F2DA759;
	Wed, 25 Jun 2025 20:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750882816; cv=none; b=FqmkoduLmR0qnR2lvzfsnECxJwIogJAViQvwohKu8XA3+AnpJalu0ZqbrSbQmrJW33xo9srcVJ3asJ98CqOiuPHOtXRLBkefMqdMLkA3MtkypyeAnXnSU+V72nYeUUCnf291l1Vg2Ex52Ob+t9/vwvMhNXMswz63ql3uYGtj2l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750882816; c=relaxed/simple;
	bh=Y5XeuJC6rpa9lv1GCVSFtD2ahPsD5739O5u959VDBjw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DgRy03dGhCwUIt33X7GMG1kzhR0vBHsoZwetfOKWJ4HSrxGnWdheF4yboVXwAllY8hhhEwlJzIvEpZ1XztNcE2bTJ0/XHL9LEI5REagaTR+YasaQkoUO7PcDfdbMrAhbBXstLHitQ8G1GN6KV9SOsBiL8pb2YmLedTcmaCGS1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAJzgcGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C909AC4CEEA;
	Wed, 25 Jun 2025 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750882816;
	bh=Y5XeuJC6rpa9lv1GCVSFtD2ahPsD5739O5u959VDBjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hAJzgcGEIqm5RXo2voZazqw/D5dbut5+GT5ItUc6w1ViuU4OhtRtBojPkTa3y5qej
	 7Bjl2uvopVhLETQbvBqwn1x+ZCyTy4kb307WCDylqAAWDcn/D7bFLqAJzmQUVS+jtk
	 IjeB2PKSglCumfF6AXnZnBJQI2t13soShhHdOCkm1vBAfBovv1+GywcwOC7soD9XMk
	 YQ53rOZAZe+SEgdHSNh3lNmwbxB0KjkxDcJQ2/TGzPvJrxlfcIH9IYnX2iqe2uwgiu
	 jRa2rvzb3I3bNrDH5/pKKt4jI1yBAzQHQ39/4TLfazXkk6pwHboqNaXUOxfOox7RKs
	 oR26qpugCqkwA==
Date: Wed, 25 Jun 2025 15:20:14 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>,
	Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
	ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
Message-ID: <20250625202014.GA1585022@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com>

[+cc Jeff, ath10k maintainer]

On Thu, Jun 26, 2025 at 12:47:49AM +0530, Bandhan Pramanik wrote:
> Hello,
> 
> The following is the original thread, where a bug was reported to the
> linux-wireless and ath10k mailing lists. The specific bug has been
> detailed clearly here.
> 
> https://lore.kernel.org/linux-wireless/690B1DB2-C9DC-4FAD-8063-4CED659B1701@gmail.com/T/#t
> 
> There is also a Bugzilla report by me, which was opened later:
> https://bugzilla.kernel.org/show_bug.cgi?id=220264
> 
> As stated, it is highly encouraged to check out all the logs,
> especially the line of IRQ #16 in /proc/interrupts.
> 
> Here is where all the logs are:
> https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180
> (these logs are taken from an Arch liveboot)
> 
> On my daily driver, I found these on my IRQ #16:
> 
>   16:     173210          0          0          0 IR-IO-APIC
> 16-fasteoi   i2c_designware.0, idma64.0, i801_smbus
> 
> The fixes stated on the Reddit post for this Wi-Fi card didn't quite
> work. (But git-cloning the firmware files did give me some more time
> to have stable internet)
> 
> This time, I had to go for the GRUB kernel parameters.
> 
> Right now, I'm using "irqpoll" to curb the errors caused.
> "intel_iommu=off" did not work, and the Wi-Fi was constantly crashing
> even then. Did not try out "pci=noaer" this time.
> 
> If it's of any concern, there is a very weird error in Chromium-based
> browsers which has only happened after I started using irqpoll. When I
> Google something, the background of the individual result boxes shows
> as pure black, while the surrounding space is the usual
> greyish-blackish, like we see in Dark Mode. Here is a picture of the
> exact thing I'm experiencing: https://files.catbox.moe/mjew6g.png
> 
> If you notice anything in my logs/bug reports, please let me know.
> (Because it seems like Wi-Fi errors are just a red herring, there are
> some ACPI or PCIe-related errors in the computers of this model - just
> a naive speculation, though.)

Your dmesg log is incomplete, and we would need to see the entire
thing.  It should start with something like this:

  Linux version 6.8.0-60-generic (buildd@lcy02-amd64-054) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #63-Ubuntu SMP PREEMPT_DYNAMIC Tue Apr 15 19:04:15 UTC 2025 (Ubuntu 6.8.0-60.63-generic 6.8.12)

Your lspci output doesn't include the necessary PCI details; collect
it with "sudo lspci -vv".

We should pick the most serious problem and focus on that instead of
trying to solve everything at once.

It sounds like the ath10k issue might be the biggest problem?  If
"options ath10k_core skip_otp=y" is a workaround for this problem, it
looks like some ath10k firmware thing, probably unrelated to the PCI
core.

Bjorn


