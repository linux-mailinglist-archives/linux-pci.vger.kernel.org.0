Return-Path: <linux-pci+bounces-38289-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67041BE10CD
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 01:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ED5E188025E
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 23:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6364431690D;
	Wed, 15 Oct 2025 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3+qsstL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E43161BC
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 23:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760571661; cv=none; b=K0pbl3a/g3vmC9tD2s940aQgD18IWkUJF1FJRPkEso8cul7w84ovAuUIKpdYtDDEBLlVb/YkAz1bgpk3zueFTaV9dxdfLUuExYCLWpke7ELtrvbm/G3hxOIyLCSYRljXd83k12wXD6M8uu1/J6Wzq+SQyn6IUCcLm3wepkbvgbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760571661; c=relaxed/simple;
	bh=7ZVXV77W0d05bk/8gSWIHFEpHIZsQ9H36dwcXGXNqro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Zf21aPn/H3itNnbOwZQQ0LpQImOP2f/tojWub2Fq5Zekem4QsoZMQdmFfBEee7yO/U8ZMR1Upp9Hd+1bgtA694niAXitUKB+LAc/XxdzAcc8liUQeiSsgrbx8f0DDFlH4XVjwdwjcaabPk2Bopvdjpbcg94grsN+RbbspPPsYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3+qsstL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89F1C4CEF8;
	Wed, 15 Oct 2025 23:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760571661;
	bh=7ZVXV77W0d05bk/8gSWIHFEpHIZsQ9H36dwcXGXNqro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=h3+qsstLdZgrMKrIYjUUZJ3SpvHx3e+0csZghHbFI8vZbxfVK/12Zf+LUjJPRCy6Y
	 pohFdY1HaBTMKdKHwutLvPO+PtHZB0hLTuyDrsWj/t7xUmSLjNJjHNT0I2ZIhtDR+u
	 SNCw6SfnHhStgY9NVmZSJANBBGWFHP/KPTU71RmsroxJA8pWIrmyakAMOGhd0gRKGH
	 5GqgIy5P0cM1GHzA/SrSJOh3mhTWiqAJSqeKl1fAE45R/L4uXugJaIhti/x6XFG7Eu
	 hCtg7UOPklPh/aO/TMXEk16iIYXrlwCfDfrjc+TAsQ/fv5Lsk8bp2yBVAQBsIKmwzi
	 MA/Cqt6Jnyc+g==
Date: Wed, 15 Oct 2025 18:40:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R.T.Dickinson" <rtd2@xtra.co.nz>,
	Christian Zigotzky <info@xenosoft.de>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, hypexed@yahoo.com.au,
	Darren Stevens <darren@stevens-zone.net>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PPC] Boot problems after the pci-v6.18-changes
Message-ID: <20251015234059.GA961901@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015101304.3ec03e6b@bootlin.com>

On Wed, Oct 15, 2025 at 10:13:04AM +0200, Herve Codina wrote:
> ...

> I also observed issues with the commit f3ac2ff14834 ("PCI/ASPM: Enable all
> ClockPM and ASPM states for devicetree platforms")
> 
> My system is an ARM board (Marvel Armada 3720 DDB)
>   https://elixir.bootlin.com/linux/v6.17.1/source/arch/arm64/boot/dts/marvell/armada-3720-db.dts
> 
> I use an LAN966x PCI board
>   https://elixir.bootlin.com/linux/v6.17.1/source/drivers/misc/lan966x_pci.c
> 
> Usually, when I did a ping using the PCI board, I have more or less the
> following timings:
>    # ping 192.168.32.100
>    PING 192.168.32.100 (192.168.32.100): 56 data bytes
>    64 bytes from 192.168.32.100: seq=0 ttl=64 time=3.328 ms
>    64 bytes from 192.168.32.100: seq=1 ttl=64 time=2.636 ms
>    64 bytes from 192.168.32.100: seq=2 ttl=64 time=2.928 ms
>    64 bytes from 192.168.32.100: seq=3 ttl=64 time=2.649 ms
> 
> But with a vanilla v6.18-rc1 kernel, those timings become awful:
>    # ping 192.168.32.100
>    PING 192.168.32.100 (192.168.32.100): 56 data bytes
>    64 bytes from 192.168.32.100: seq=0 ttl=64 time=656.634 ms
>    64 bytes from 192.168.32.100: seq=1 ttl=64 time=551.812 ms
>    64 bytes from 192.168.32.100: seq=2 ttl=64 time=702.966 ms
>    64 bytes from 192.168.32.100: seq=3 ttl=64 time=725.904 ms
> 
> Reverting commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and
> ASPM states for devicetree platforms") fixes my timing issues.

We expect *some* performance impact from enabling ASPM, but this seems
excessive.  You should be able to control the ASPM settings for an
individual device via sysfs:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-bus-pci?id=v6.17-rc1#n431

My guess is that L1.2 is enabled and the threshold values in the L1 PM
Substates control registers are bogus.  I don't know how to fix those,
especially on a devicetree system.  But it might be possible to fiddle
with them using setpci (while ASPM is disabled).  Not for the faint of
heart.

Bjorn

