Return-Path: <linux-pci+bounces-19559-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E4ABA06595
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 20:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC4747A1215
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jan 2025 19:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8974F1AA1DA;
	Wed,  8 Jan 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSy2zfQT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5425922611;
	Wed,  8 Jan 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736365872; cv=none; b=GffSGi3v90g5+qUeW3SbsjS41iN5oTaXzJJlnuWgSLS9mJ32Z1BpG0Ae2sMC7fdISUmU4dFTwe9mcUPRr2j8M2555RTHUZHxjddeAP+h7c21T2mW94OKb3p3zYFMPS1KC13HN6LYxJnYm5LJn3u7tYaDvAggKD26in5faq4fPsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736365872; c=relaxed/simple;
	bh=3XOtlTs/hzd4lsseZnXoaXETrVytDww/rNaH/CWFCHg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tYxTpnhCh3Kbuz1zM5TeE9/Vy+kPCW7kYLfLtjoocLmue2UloFi7LzJ0Nyxt7uSP9xUPtBO/Z4m/oqiKQIc0XkeVTDqtb/684yV/3NXyq7EsZbxkzqKH/V+1Bri/PPopG6SRkKPU2wQ4GkuIU3yf7rVYUYWZ7zPci3H1hg36qOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSy2zfQT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD64CC4CED3;
	Wed,  8 Jan 2025 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736365871;
	bh=3XOtlTs/hzd4lsseZnXoaXETrVytDww/rNaH/CWFCHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=eSy2zfQTnz2eDskYMtxlTfY3C4bnkL9u7/WUKe/6zfE+dgMFAojOF9IfkFG63R25Z
	 dgz871Tre+p2ebJXxcCZt7OZxuVnDh6doOjeDeSYJcf+s2Xlr6K1aC5vW1//RaqELF
	 32n3NV1UJ5FK/Ag/0fIq1Ax8eULCg6RKCNMY4EB1Tqo+sBojINI5fR/TyClQck+RHR
	 Foq9UE/uwonxzjyM99M2iKW9QtxLpcTAr3KqnOGFkffNGkJzyWwf94zMEmdLHrbmUr
	 S0/pAHCJlRL1nAUEDOg7j9MtbSCLnYwFSWxL53ev1YY0YAGlYNtPYjaP/72FmUrqio
	 lVfA80Ebgj/8w==
Date: Wed, 8 Jan 2025 13:51:09 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
	M Chetan Kumar <m.chetan.kumar@intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2] net: wwan: iosm: Fix hibernation by re-binding the
 driver around it
Message-ID: <20250108195109.GA224965@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c634d5bc-7a60-436a-94d8-c8a4fb0e0c26@gmail.com>

[+cc Rafael, linux-pm because they *are* PM experts :)]

On Wed, Jan 08, 2025 at 02:15:28AM +0200, Sergey Ryazanov wrote:
> On 08.01.2025 01:45, Bjorn Helgaas wrote:
> > On Wed, Jan 08, 2025 at 01:13:41AM +0200, Sergey Ryazanov wrote:
> > > On 05.01.2025 19:39, Maciej S. Szmigiero wrote:
> > > > Currently, the driver is seriously broken with respect to the
> > > > hibernation (S4): after image restore the device is back into
> > > > IPC_MEM_EXEC_STAGE_BOOT (which AFAIK means bootloader stage) and needs
> > > > full re-launch of the rest of its firmware, but the driver restore
> > > > handler treats the device as merely sleeping and just sends it a
> > > > wake-up command.
> > > > 
> > > > This wake-up command times out but device nodes (/dev/wwan*) remain
> > > > accessible.
> > > > However attempting to use them causes the bootloader to crash and
> > > > enter IPC_MEM_EXEC_STAGE_CD_READY stage (which apparently means "a crash
> > > > dump is ready").
> > > > 
> > > > It seems that the device cannot be re-initialized from this crashed
> > > > stage without toggling some reset pin (on my test platform that's
> > > > apparently what the device _RST ACPI method does).
> > > > 
> > > > While it would theoretically be possible to rewrite the driver to tear
> > > > down the whole MUX / IPC layers on hibernation (so the bootloader does
> > > > not crash from improper access) and then re-launch the device on
> > > > restore this would require significant refactoring of the driver
> > > > (believe me, I've tried), since there are quite a few assumptions
> > > > hard-coded in the driver about the device never being partially
> > > > de-initialized (like channels other than devlink cannot be closed,
> > > > for example).
> > > > Probably this would also need some programming guide for this hardware.
> > > > 
> > > > Considering that the driver seems orphaned [1] and other people are
> > > > hitting this issue too [2] fix it by simply unbinding the PCI driver
> > > > before hibernation and re-binding it after restore, much like
> > > > USB_QUIRK_RESET_RESUME does for USB devices that exhibit a similar
> > > > problem.
> > > > 
> > > > Tested on XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses
> > > > the existing suspend / resume handlers) and S4 (which uses the new code).
> > > > 
> > > > [1]: https://lore.kernel.org/all/c248f0b4-2114-4c61-905f-466a786bdebb@leemhuis.info/
> > > > [2]:
> > > > https://github.com/xmm7360/xmm7360-pci/issues/211#issuecomment-1804139413
> > > > 
> > > > Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> > > 
> > > Generally looks good to me. Lets wait for approval from PCI
> > > maintainers to be sure that there no unexpected side effects.
> > 
> > I have nothing useful to contribute here.  Seems like kind of a
> > mess.  But Intel claims to maintain this, so it would be nice if
> > they would step up and make this work nicely.
> 
> Suddenly, Intel lost their interest in the modems market and, as
> Maciej mentioned, the driver was abandon for a quite time now. The
> author no more works for Intel. You will see the bounce.

Well, that's unfortunate :)  Maybe step 0 is to remove the Intel
entry from MAINTAINERS for this driver.

> Bjorn, could you suggest how to deal easily with the device that is
> incapable to seamlessly recover from hibernation? I am totally
> hopeless regarding the PM topic. Or is the deep driver rework the
> only option?

I'm pretty PM-illiterate myself.  Based on
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/pm/sleep-states.rst?id=v6.12#n109,
I assume that when we resume after hibernate, devices are in the same
state as after a fresh boot, i.e., the state driver .probe() methods
see.

So I assume that some combination of dev_pm_ops methods must be able
to do basically the same as .probe() to get the device usable again
after it was completely powered off and back on.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/pm/devices.rst?id=v6.12#n506
mentions .freeze(), .thaw(), .restore(), etc, but the fact that few
drivers set those pointers and all the nice macros for setting pm ops
(SYSTEM_SLEEP_PM_OPS, NOIRQ_SYSTEM_SLEEP_PM_OPS, etc) only take
suspend and resume functions makes me think most drivers must handle
hibernation in the same .suspend() and .resume() functions they use
for non-hibernate transitions.

Since all drivers have to cope with devices needing to be
reinitialized after hibernate, I would look around to see how other
drivers do it and see if you can do it similarly.

Sorry this is still really a non-answer.

Bjorn

