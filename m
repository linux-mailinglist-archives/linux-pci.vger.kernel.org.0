Return-Path: <linux-pci+bounces-19080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5A29FD833
	for <lists+linux-pci@lfdr.de>; Sat, 28 Dec 2024 00:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B94487A2160
	for <lists+linux-pci@lfdr.de>; Fri, 27 Dec 2024 23:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC0D140E5F;
	Fri, 27 Dec 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/3bzb85"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C885626;
	Fri, 27 Dec 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735341322; cv=none; b=ZznY5Sj0+3Q6j2ImfLVA2h14ufSiot7/PKWLdbEGl4qUbUyR+nbMBYscd58c2fJhAAC5PF1Jge4C9K0yvwEKDpp8Soqa26soHIHuNi2Md5MzPlYsZqaYNbWsKskY/DVJHuCgNpFzDOYVsnlewROogH0aEg46rf669hg+FciQjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735341322; c=relaxed/simple;
	bh=zmTrHN/vVyXx6O5nCWS5jgvdFT9oOyuoMCBjMxQKnUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i1U4aGalmiBL1Hpw0g908Yi4/doE2JWr/ToP+QBr56i8ME+4Yvy3nQSYazcnrOhVsHkLRs49OS8Z9QJHPVlPmrQE6FODwhsKiC4qYBvojEevN6XCgEPzz2520h063l+JDRM07FLp5Awxt16gtdF+aAvteKiY+AFQkskj4Ftz5sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/3bzb85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF2DC4CED0;
	Fri, 27 Dec 2024 23:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735341322;
	bh=zmTrHN/vVyXx6O5nCWS5jgvdFT9oOyuoMCBjMxQKnUE=;
	h=Date:From:To:Cc:Subject:From;
	b=Z/3bzb85SFDXjtH727BGCrnY63N9EAx4hAmrcI3JVCeprve6AiK2t4d9vyw5mHwE4
	 F+33OW5wia9Kae3tXez+IN49jKEklIdFCBtE9Yd9ZMk3Tv1OXVcrnMh1Bt3eKk1MZJ
	 Xa1YBNdC8azah8DfRhwnfaGnTMBu98ewNLOeKtRBME2aTkzTeRbTxdFApzNLMalIj8
	 oJOcOXeugc5CezUljNlQrzau6zrB/7zlqO82aySlRXU6MuIgLty/BSQulXGuiMeyN1
	 uFJmYDPYtlS7thg+VLxmAWqoLZzRkO643b4yQl8Y0NJJ+meRp19hpqVIs0CxVF0Rc+
	 7sZunwjTKpaIg==
Date: Fri, 27 Dec 2024 17:15:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Evert Vorster <evorster@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, regressions@lists.linux.dev
Subject: [REGRESSION] Kernel version 6.13.rc4 not powering off laptop
Message-ID: <20241227231520.GA3929732@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

#regzbot introduced: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")

From https://bugzilla.kernel.org/show_bug.cgi?id=219629:

> I have recently installed a git version of the linux kernel on my Asus ROG Strix laptop.
> 
> Hardware info:
> [code]
> Operating System: Arch Linux
> KDE Plasma Version: 6.2.4
> KDE Frameworks Version: 6.9.0
> Qt Version: 6.8.1
> Kernel Version: 6.12.6-arch1-1 (64-bit)
> Graphics Platform: Wayland
> Processors: 32 × AMD Ryzen 9 7945HX3D with Radeon Graphics
> Memory: 62.0 GiB of RAM
> Graphics Processor: AMD Radeon 610M
> Manufacturer: ASUSTeK COMPUTER INC.
> Product Name: ROG Strix G733PYV_G733PYV
> System Version: 1.0
> [/code]
> 
> Up to this point, I have been running a variety of kernels, Arch's
> lts version: 6.6.67, Arch's normal kernel version: 6.12.6, a custom
> g14 kernel with patches for the Asus type laptops, version: 6.12.6
> None of these kernels had any trouble shutting down the power at
> shutdown.
> 
> Arch mainline version of the kernel, currently at 6.13rc1, and the
> git version, currently at 6.13.rc4 both do not power off the laptop
> after a shutdown command has been issued.
> 
> The journal stops after the shutdown command is executed, so I can't
> see any error as to why this power off is not working.
> 
> I filed a bug report in the Arch Linux Forums, and that has some
> more information on the journals, but ultimately we can't figure out
> what is going on.

Subsequent bisection to 665745f27487 ("PCI/bwctrl: Re-add BW
notification portdrv as PCIe BW controller") at
https://bugzilla.kernel.org/show_bug.cgi?id=219629#c6

Evert reproduced this failure on v6.13-rc4, which includes
774c71c52aa4 ("PCI/bwctrl: Enable only if more than one speed is
supported").

Thanks very much for the report and the bisection, Evert!

Bjorn

