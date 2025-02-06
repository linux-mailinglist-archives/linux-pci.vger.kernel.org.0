Return-Path: <linux-pci+bounces-20839-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FC9A2B4C4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 23:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8ABC7A57CF
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2025 22:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584B422FF21;
	Thu,  6 Feb 2025 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTVyGaAB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF5222FF32
	for <linux-pci@vger.kernel.org>; Thu,  6 Feb 2025 22:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738879524; cv=none; b=Q2so+xitQRhgu6pCVcYfW3JvptJjWFtp4V1qGdavtbYmNGFV7+Lk6XU3H+sBnPI+LSjohS2RRIfHfmwC/b1HoEyD5wv2dqNvB8ImhZVxreCnYBT1bU1HfVc8g8MosyQPhys661lNV/fgL0eZxG6CdCY9/VC34pHW4Wml3uWcosg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738879524; c=relaxed/simple;
	bh=0M7JvaXwu5Q/u0qWGYRPcs3VVvrYUOZiDOQJvch8KD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bPLiPGRNz2d+FR7lGAuXcyaeXQ5yNw5BvRIqDAWyqW0dvwkCJ35vFmFhWzlI36HmXJd+DV5GMDN15Rpu0sa5zMXmyJwitVKakTTWRpsXtETA1/k3wttH70ecjxMTRkhCpHPLztQCEUAfSQOFNNMdJ66cSX1tz9l1Ao8thhZilCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTVyGaAB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639A4C4CEDD;
	Thu,  6 Feb 2025 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738879523;
	bh=0M7JvaXwu5Q/u0qWGYRPcs3VVvrYUOZiDOQJvch8KD0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nTVyGaABBy+yCoo/Ytk4cAkpTZZH7CC5OoykoVyEaS0NMtVQCpCemmFjjwKLbOpVz
	 WtvqIrte+SCAXqgb37WPlsg7te5WrpKG+Sbl+ocGy+Znhu36wLqF4ZhFZHnlWEYCdd
	 JtKeSUoD82nmvBlD6Gg1Nbkp9x1SZEkasFz3+g17UtKqTZA36Vy7lQs72IItHhWJPh
	 w1gbA/iT9U3GTbHdi5jf6xnh4hkJZkye/E/5LnMLQiQrxZs3CM7U983nC9FLTTkDP6
	 X9u1yoG1GJ94u2csCWDWk1I2CVVP7Cx1/A1zyfey8Dwh1x5bLAm9QUUX8annVL2t9a
	 pfS9Avh/Fnzhw==
Date: Thu, 6 Feb 2025 16:05:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: tasev.stefanoska@skynet.be,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jian-Hong Pan <jhp@endlessos.org>
Subject: Re: [Bug 219755] New: Wifi card intel 7265D not detected with kernel
 6.14-rc1
Message-ID: <20250206220521.GA1007958@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bug-219755-41252@https.bugzilla.kernel.org/>

For completeness, sending this to the list since most people don't
look at bugzilla.  I *think* this should be fixed by Ilpo's patch:
https://lore.kernel.org/r/20250131152913.2507-1-ilpo.jarvinen@linux.intel.com,
which I just asked Linus to pull for v6.14-rc2.

(Jian-Hong, my abject apologies because I think this whole mess was my
fault for editing your patch before applying it.  I also meant to cc
you on the pull request but obviously forgot.)

On Thu, Feb 06, 2025 at 06:47:21PM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219755
> 
> Created attachment 307580
>   --> https://bugzilla.kernel.org/attachment.cgi?id=307580&action=edit
> Dmesg from kernel 6.14-rc1
> 
> Hi
> 
> With kernel 6.14-rc1 my wifi card is not detected anymore on my Asus UX305FA
> after boot.
> 
> Boot dmesg 6.14-rc1:
> 
> dmesg | grep iwl
> [    4.006347] iwlwifi 0000:02:00.0: Unable to change power state from D3cold
> to D0, device inaccessible
> [    4.008072] iwlwifi 0000:02:00.0: HW_REV=0xFFFFFFFF, PCI issues?
> [    4.009912] iwlwifi 0000:02:00.0: probe with driver iwlwifi failed with
> error -5
> ...

> I start bisecting and the first bad commit is:
> 
> 1db806ec06b7c6e08e8af57088da067963ddf117 is the first bad commit
> commit 1db806ec06b7c6e08e8af57088da067963ddf117
> Author: Jian-Hong Pan <jhp@endlessos.org>
> Date:   Fri Nov 15 15:22:02 2024 +0800
> 
>     PCI/ASPM: Save parent L1SS config in pci_save_aspm_l1ss_state()
> 
>     After 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
>     suspend/resume"), pci_save_aspm_l1ss_state(dev) saves the L1SS state for
>     "dev", and pci_restore_aspm_l1ss_state(dev) restores the state for both
>     "dev" and its parent.
> 
>     The problem is that unless pci_save_state() has been used in some other
>     path and has already saved the parent L1SS state, we will restore junk to
>     the parent, which means the L1 Substates likely won't work correctly.
> 
>     Save the L1SS config for both the device and its parent in
>     pci_save_aspm_l1ss_state().  When restoring, we need both because L1SS must
>     be enabled at the parent (the Downstream Port) before being enabled at the
>     child (the Upstream Port).
> 
>     Link: https://lore.kernel.org/r/20241115072200.37509-3-jhp@endlessos.org
>     Fixes: 17423360a27a ("PCI/ASPM: Save L1 PM Substates Capability for
> suspend/resume")
>     Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218394
>     Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
>     Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
>     [bhelgaas: parallel save/restore structure, simplify commit log, patch at
>     https://lore.kernel.org/r/20241212230340.GA3267194@bhelgaas]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Tested-by: Jian-Hong Pan <jhp@endlessos.org> # Asus B1400CEAE
> 
>  drivers/pci/pcie/aspm.c | 33 ++++++++++++++++++++++++++++-----
>  1 file changed, 28 insertions(+), 5 deletions(-)
> 
> Reverting the patch and rebuild the 6.14-rc1 kernel fixed the problem for me,
> my wifi card is detected again.

