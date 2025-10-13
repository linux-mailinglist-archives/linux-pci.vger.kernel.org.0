Return-Path: <linux-pci+bounces-37983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8FABD6517
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 23:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDE5C18A2A25
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64A723185E;
	Mon, 13 Oct 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KFOtIaYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A874225401;
	Mon, 13 Oct 2025 21:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389357; cv=none; b=ikLmuY+6UV7FHwFVH+EfX2PNASYjJFuw5uxvU8KGVj6ginj/08E7dUSixWcVwinBCQXCwchg2jK1Nbawc6fwiwDrlLAfBv5s4cdLatFUyMziGUx/QJhu4WBJYwEVCvuzLOIYSkod4+EWXjUluteU69FhJ9cPFfNamWTJCm8eCw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389357; c=relaxed/simple;
	bh=rk47wc3bcYnjvI5ZSIYiPS5R2QOmXR2X8w20XM8e8xU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DklzRhbP6Am08h9QfY6+YZV9NrCPteqCrun8+MOvIj4yWCTUCw3pI0ZH0iR7EI+T+6Z6e3oL1PCLFvzI9WjHO99iSfj7xmWXutPbLZAfKToKGuSYieUQl8zKuJUe2D1KG9sNDnALT3jyiXGXMWHTop2vCFzAZcHhrxw+z2ryXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KFOtIaYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B311C4CEE7;
	Mon, 13 Oct 2025 21:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760389357;
	bh=rk47wc3bcYnjvI5ZSIYiPS5R2QOmXR2X8w20XM8e8xU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KFOtIaYjaaXNg5KasaQLZSoOrrI94uwnE+NVPCjVUTFRvwGBleqKqxHQD4+ppvPh+
	 R7bBYtOU9MQU5gBjhWnUbVW4z9dlv9EL0NIqqmRk22UX4pQpjHJkjG8MFQXNwtYYV4
	 vuVysnuAX0ZDiLxeFBGek+jRY/vdDi4M4vXp/0p4eyWKSyL8EmG2ZDZd/afazFtazR
	 gGFxgtDlffeUqT97FDCmbwLWKSWt8bbNjne/l/+CSKHzh8UR2tsLuTgt/7wHs6BHkC
	 k7zUSMvFGhsFp5iPv0YN4RQxC+oNj6EbJpl4h2ICgvZE0hl4yCU890itoJw/TqvA5n
	 SWLuzj8VUv0fw==
Date: Mon, 13 Oct 2025 16:02:36 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	regressions@lists.linux.dev
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <20251013210236.GA864224@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net>

[+cc regressions]

On Mon, Oct 13, 2025 at 12:54:25PM -0700, Guenter Roeck wrote:
> On Fri, Aug 29, 2025 at 04:10:52PM +0300, Ilpo Järvinen wrote:
> > pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
> > pcibios_enable_resources(). Having own copy of same functionality could
> > lead to inconsistencies in behavior, especially now as
> > pci_enable_resources() and the bridge window resource flags behavior are
> > going to be altered by upcoming changes.
> > 
> > The check for !r->start && r->end is already covered by the more generic
> > checks done in pci_enable_resources().
> > 
> > Call pci_enable_resources() from MIPS's pcibios_enable_device() and remove
> > pcibios_enable_resources().
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> 
> This patch causes boot failures when trying to boot mips images from
> ide drive in qemu. As far as I can see the interface no longer instantiates.
> 
> Reverting this patch fixes the problem. Bisect log attached for reference.
> 
> Guenter
> 
> ---
> # bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
> # good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
> git bisect start 'HEAD' 'v6.17'
> # good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
> git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
> # good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
> git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
> # good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
> git bisect good 6a74422b9710e987c7d6b85a1ade7330b1e61626
> # bad: [522ba450b56fff29f868b1552bdc2965f55de7ed] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
> git bisect bad 522ba450b56fff29f868b1552bdc2965f55de7ed
> # bad: [256e3417065b2721f77bcd37331796b59483ef3b] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect bad 256e3417065b2721f77bcd37331796b59483ef3b
> # bad: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
> git bisect bad 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
> # bad: [531abff0fa53bc3a2f7f69b2693386eb6bda96e5] Merge branch 'pci/controller/qcom'
> git bisect bad 531abff0fa53bc3a2f7f69b2693386eb6bda96e5
> # bad: [fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3] Merge branch 'pci/resource'
> git bisect bad fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3
> # good: [0bb65e32495e6235a069b60e787140da99e9c122] Merge branch 'pci/p2pdma'
> git bisect good 0bb65e32495e6235a069b60e787140da99e9c122
> # bad: [ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd] PCI: Use pbus_select_window_for_type() during IO window sizing
> git bisect bad ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd
> # bad: [2ee33aa14d3f2e92ba8ae80443f2cd9b575f08cb] PCI: Always claim bridge window before its setup
> git bisect bad 2ee33aa14d3f2e92ba8ae80443f2cd9b575f08cb
> # good: [2657a0c982239fecc41d0df5a69091ca4297647c] m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
> git bisect good 2657a0c982239fecc41d0df5a69091ca4297647c
> # bad: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()
> git bisect bad ae81aad5c2e17fd1fafd930e75b81aedc837f705
> # good: [754babaaf33349d9ef27bb1ac6f5d9d5a503a2a6] sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
> git bisect good 754babaaf33349d9ef27bb1ac6f5d9d5a503a2a6
> # first bad commit: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()

#regzbot introduced: ae81aad5c2e1 ("MIPS: PCI: Use pci_enable_resources()")

