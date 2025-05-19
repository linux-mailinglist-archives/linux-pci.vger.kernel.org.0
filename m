Return-Path: <linux-pci+bounces-27982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13766ABC045
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 16:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D8F17FF31
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 14:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7D926AAB5;
	Mon, 19 May 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EUcoY0EH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69431DEFF3
	for <linux-pci@vger.kernel.org>; Mon, 19 May 2025 14:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747663559; cv=none; b=QvKzaSsqPrLHwJn/XcH6q5UNjNhMoCMC20uAidu3Q8ndda7LJZtagW9K3ndmTpo35cFniAjIMq2a7Ud9BJda6Rv3vumpzbikIEf3Gc8xLcGoUc65NnhG/iY789Yq9R0qoiVdMkuWphJL3TFw6lBV/wWZLKb0wKoN3OdmmV8krU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747663559; c=relaxed/simple;
	bh=qH1fosS4Hip7qXkkllGf5Qn3Ka2TyrhRF3G+x+Xj9fA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=stMf6uylhRVHPldgmkvxophqTQ384iEzrMoG+0T68JLTAOb1v2BdsyLdf5dtafrEwHGWL6gmLKoD/yUkYYKSGJ10IJ7I0ADsCvKf4rjm9lB9AkTJ+DPJjGBPfKd25IYYK7WKaTe5oKl8W//BL+ejXSLa1ej/6d9MisZFhbKSsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EUcoY0EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B0BC4CEE4;
	Mon, 19 May 2025 14:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747663559;
	bh=qH1fosS4Hip7qXkkllGf5Qn3Ka2TyrhRF3G+x+Xj9fA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EUcoY0EHLZbwqwsw544VrTHDWxf/vUyiWLtJk+pqjs+s7jZw/98Bxq4AGXUGoM7WJ
	 rTL7EWu0gyLrhMEsQa7SOjyBHXAbpBqn+6C9ezw0WfY0AClVMp+10gH7HlUJWrn3KW
	 /0no9KvA7UzvPZufFE9bfYY4fPvAQeKP8fl2ghzcmVuOQl2C51XqIEZqXjSA7q9J5y
	 28IoEzx1BBZtcK5oU1++M0Q4ASlAQU3nUY9HTtRWPTIwYei8ioWOm1H9a741SRrsIq
	 anXdQDg2XC7GA66Z/633dgv3L1r8gbu2+P6foZGbfoijs3W5RYrDFmXWLrEIn7LirO
	 x5yyGFnyYnIKw==
Date: Mon, 19 May 2025 09:05:57 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	'Cyril Brulebois <kibi@debian.org>,
	"maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" <bcm-kernel-feedback-list@broadcom.com>,
	'Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: POSSIBLE REGRESSION: PCI/pwrctrl: Skip scanning for the device
 further if pwrctrl device is created
Message-ID: <20250519140557.GA1236950@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com>

On Mon, May 05, 2025 at 01:39:39PM -0400, Jim Quinlan wrote:
> Hello,
> 
> I recently rebased to the latest Linux master
> 
> ebd297a2affa Linus.Torvalds Merge tag 'net-6.15-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> 
> and noticed that PCI is broken for
> "drivers/pci/controller/pcie-brcmstb.c"  I've bisected this to the
> following commit
> 
> 2489eeb777af PCI/pwrctrl: Skip scanning for the device further if
> pwrctrl device is created
> 
> which is part of the series [1].  The driver in pcie-brcmstb.c is
> expecting the add_bus() method to be invoked twice per boot-up, but
> the second call does not happen.  Not only does this code in
> brcm_pcie_add_bus() turn on regulators, it also subsequently initiates
> PCIe linkup.
> 
> If I revert the aforementioned commit, all is well.
> 
> FWIW, I have included the relevant sections of the PCIe DT we use at [2].

Mani, Bartosz, where are we at with this?  The 2489eeb777af commit log
doesn't mention a problem fixed by that commit; it sounds more like an
optimization -- just avoiding an unnecessary scan.

2489eeb777af appeared in v6.15-rc1, so there's still time to revert it
before v6.15 if that's the right way to fix this regression.

> [1] https://lore.kernel.org/lkml/20241231-pci-pwrctrl-slot-v2-0-6a15088ba541@linaro.org/T/#t
> [2]
> 
> pcie@1000110000 {
>         reg = <0x10 0x110000 0x0 0x9130>;
>         ...
> 
>         pci@0,0 {
>                 vpcie3v3-supply = <0x45>;
>                 vpcie12v-supply = <0x44>;
>                 reg = <0x0 0x0 0x0 0x0 0x0>;
>                 ranges;
>                 bus-range = <0x1 0xff>;
>                 compatible = "pciclass,0604";
>                 device_type = "pci";
>                 #address-cells = <0x3>;
>                 #size-cells = <0x2>;
> 
>                 pci-ep@0,0 {
>                         local-mac-address = [ 00 10 18 f0 35 55 ];
>                         reg = <0x10000 0x0 0x0 0x0 0x0>;
>                 };
>         };
> }



