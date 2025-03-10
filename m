Return-Path: <linux-pci+bounces-23361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE50A5A364
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 19:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1640916E955
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 18:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C422343C5;
	Mon, 10 Mar 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XZkM2iHV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581722D7AF;
	Mon, 10 Mar 2025 18:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632546; cv=none; b=Bd6Q9Pg7AlznZ1eJDBXORDHPgMmASVFQQanaGqLDxgdRkf53pcUeZefPNwS1vZ1lyffyw7hy+dH9QOBabboP4j0CtcCiTgbgkiLVGgUCbHap1av/AK7pZZjgJiy49ku6GtqHgmKdhWi5A6sOJAqRAk94P42fg/LvCHEdJNdEeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632546; c=relaxed/simple;
	bh=sNJdbmXy/Tk0MEkmZqvg7WEtMf2IVSmQKv14VkQ4aL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GB/XlZDSw6xLUbOWb7kDAF7NsvsKTxicC3wd1sTsYSpKLg/8ILNoyxyQmRtnt/h0n9XoYOyZWRRbqeiDqEdnQRKbUmb4mNbOSxpkjMe9g5Cq4Ye+xIj14Xv2UXXwZWAXjUZMpmpU2R7gUJZmS2vq2KUDIRHGEI3uS/e90b/G5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XZkM2iHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7C2C4CEE5;
	Mon, 10 Mar 2025 18:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741632546;
	bh=sNJdbmXy/Tk0MEkmZqvg7WEtMf2IVSmQKv14VkQ4aL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XZkM2iHVWuWUcGnoVeoG6gEcSxmVQo+wUu8Iymvhi8SYXJGTn3GZUKVNiVsk9Iyz6
	 jmMYfnL2gdQwMc2YhTuyWYRD9YoU4+zxIguUKW7j1P6b8FCGlp0uqqTOOw4c8F2rPK
	 wCbnc/wsTZMnUMqDxKi06iPw/K31bC1XZO9O2V04ccyyRcB7Y0G3YtokrlHkWEkBMd
	 Vwug8CxYDUplCvD8ZCLSFw/jXw9FOGz2At4iCAn8SCbWDkAu2hyPej+dkry0LT+sAy
	 HRz2YN+bDUNN5S1p2iuCgH/DuzFCxRU5rNFsTTZfUJw5XA5t26FzceqDYPTjI6u22t
	 af3ffPdXSk84A==
Date: Tue, 11 Mar 2025 03:49:04 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Niklas Cassel <cassel@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [pci:endpoint-test 16/18]
 drivers/pci/controller/dwc/pcie-dw-rockchip.c:316:3: error: field designator
 'intx_capable' does not refer to any field in type 'const struct
 dw_pcie_ep_ops'
Message-ID: <20250310184904.GB1179150@rocinante>
References: <202503110151.vQXf5yof-lkp@intel.com>
 <20250310182605.GA1179150@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250310182605.GA1179150@rocinante>

Hello,

> [...]
> > vim +316 drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > 
> >    313	
> >    314	static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
> >    315		.init = rockchip_pcie_ep_init,
> >  > 316		.intx_capable = false,
> >    317		.raise_irq = rockchip_pcie_raise_irq,
> >    318		.get_features = rockchip_pcie_get_features,
> >    319	};
> >    320	
> 
> I moved setting the .intx_capable property to false to the pci_epc_features
> struct definition for RK3568, which is what I believe the intention was.
> 
> Have a look at:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=endpoint-test&id=cb349262d9770e6478a7e91bdf438122b8cda44d
> 
> Let me know if this is OK with you.

Niklas, I saw your reply to this failure report.

Based on it, I fixed the patch and dropped any annotations added (since
there was no need to do anything aside from retroing the code to its
orignal form).


That said, I didn't do any edits when applying the patch that I can recall,
so I think something got its knickers in a twist when I was applying the
patches.

However, I did miss that it got applied incorrectly when reviewing the
changes before pushing them.  My bad.

Anyway.  Sorry for the commotion.  I am glad the fix was trivial here.

Thank you!

	Krzysztof

