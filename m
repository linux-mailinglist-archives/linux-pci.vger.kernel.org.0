Return-Path: <linux-pci+bounces-15253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC479AF5C4
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 01:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5101C2176C
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C81B392C;
	Thu, 24 Oct 2024 23:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIYqikKK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0BB22B641;
	Thu, 24 Oct 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811852; cv=none; b=frTEAyvVoLFCqAc3cvTkGzQn/0GJdTCF681kI0IJfaMVCxyxB1STL49o3zbL+jAIgBrWzuTffyiDPOdYgP8/atii0Us0GeVkrtBoxMQhbJ+8zRIuMDo7zbEQQxdchuyrjBD7TiKMSUHF6jakVd2Wt8noXNh2n3yb1TVzNHP47BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811852; c=relaxed/simple;
	bh=plDHJ2sfxgjxWKlJmyZSaNtlfwVXzMVY5wbhauPFuSg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rbRN5M/S8vAT0mSEmU2HbKPr7yBCKjkHVRQovCvcUQLTK6dd/cRRGtKeHMLiWRiRvurbMzH3Vmaxk0LauJSstQN/0xgClRSg5O16jCXT7G/ZxoFtVPw4GpjczpI5YX9Xc6eiNid17ekf+zrw7riHo5QFOADYJAa2O8AYF8W9js4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIYqikKK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B06AC4CEC7;
	Thu, 24 Oct 2024 23:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729811851;
	bh=plDHJ2sfxgjxWKlJmyZSaNtlfwVXzMVY5wbhauPFuSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZIYqikKKBa6qTkHgQ1j3GQv7JDng8wRd85YwdYO26xJanFqO7NiBwiFabyRy+RS/N
	 vPUHe6ke3NESdIATu0zKWG96P9IXyektZvVb7IdK9JMIvY3Zxj4j6WDJFbRZ11/9VP
	 F4xqnZ//7BXZT/9pdBEHf9Pz4JEzutMB8iuf/101xFCJ3dx+Py+yUna5TMZD06I0IU
	 qw0pbEtwtAgep7nPmvxHRB34t2F0Mctn0wkyUcrgMkAD7HF7yf6gOsUYBBu80VJ8od
	 kEBRBGetaOdP6K9ulGlJDU1huumdh+vTwjSm+CBE3z6cnZgVUQYv9QSLt0iQDAfpWz
	 IQV9SOVhJZxYA==
Date: Thu, 24 Oct 2024 18:17:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: liwei <liwei728@huawei.com>
Cc: bhelgaas@google.com, jpk@sgi.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobo.shaobowang@huawei.com
Subject: Re: [PATCH] PCI/ROM: Fix PCI ROM header check bug
Message-ID: <20241024231729.GA1005838@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024021725.2608037-1-liwei728@huawei.com>

On Thu, Oct 24, 2024 at 10:17:25AM +0800, liwei wrote:
> 'pds' does not perform 4-byte alignment check. If 'pds' is not 4-byte
> aligned, it will cause alignment fault.
> 
> Mem abort info:
> ESR = 0x0000000096000021
> EC = 0x25: DABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x21: alignment fault
> Data abort info:
> ISV = 0, ISS = 0x00000021, ISS2 = 0x00000000
> CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=0000203ef6a0d000
> [ffff8000c930ffff] pgd=1000002080bcf003, p4d=1000002080bcf003, pud=100000403ae8a003, pmd=1000202027498003, pte=00680000b000ff13
> Internal error: Oops: 0000000096000021 [#1] SMP
> CPU: 16 PID: 451316 Comm: read_all Kdump: loaded Tainted: G W 6.6.0+ #6
> Hardware name: Huawei TaiShan 200 (Model 2280)/BC82AMDD, BIOS 6.57 05/17/2023
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : pci_get_rom_size+0x74/0x1f0
> lr : pci_map_rom+0x140/0x280
> sp : ffff8000b96178f0
> x29: ffff8000b96178f0 x28: ffff004e284b3f80 x27: ffff8000b9617be8
> x26: ffff0020facb7020 x25: 0000000000100000 x24: 00000000b0000000
> x23: ffff00208c8ea740 x22: 1ffff000172c2f2e x21: ffff8000c9300000
> x20: 0000000000100000 x19: ffff8000c9300000 x18: 0000000000000000
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
> x14: 0000000000000000 x13: 0000000041b58ab3 x12: 1ffff000172c2ec8
> x11: 00000000f1f1f1f1 x10: ffff7000172c2ec8 x9 : ffffb9ba9db93ad8
> x8 : ffff7000172c2eac x7 : ffff8000c9400000 x6 : 0000000052494350
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000c930ffff
> x2 : 000000000000aa55 x1 : 0000000000000000 x0 : ffff00208c8ea000
> Call trace:
>   pci_get_rom_size+0x74/0x1f0
>   pci_map_rom+0x140/0x280
>   pci_read_rom+0xa8/0x158
>   sysfs_kf_bin_read+0xb8/0x130
>   kernfs_file_read_iter+0x124/0x278
>   kernfs_fop_read_iter+0x6c/0xa8
>   new_sync_read+0x128/0x208
>   Inject: max_dir_depth
>   vfs_read+0x244/0x2b0
>   ksys_read+0xd0/0x188
>   __arm64_sys_read+0x4c/0x68
>   invoke_syscall+0x68/0x1a0
>   el0_svc_common.constprop.0+0x11c/0x150
>   do_el0_svc+0x38/0x50
>   el0_svc+0x64/0x258
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x188/0x190
> Code: d50331bf ca030061 b5000001 8b030263 (b9400064)
> SMP: stopping secondary CPUs
> Starting crashdump kernel...
> 
> In UEFI Specification Version 2.8, describes that the PCIR data structure must
> start on a 4-byte boundary. Fix it by verifying the 'pds' is aligned.
>
> Cc: stable@vger.kernel.org
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: liwei <liwei728@huawei.com>
> ---
>  drivers/pci/rom.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/rom.c b/drivers/pci/rom.c
> index e18d3a4383ba..0fa6b3da63cc 100644
> --- a/drivers/pci/rom.c
> +++ b/drivers/pci/rom.c
> @@ -98,6 +98,12 @@ static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,
>  		}
>  		/* get the PCI data structure and check its "PCIR" signature */
>  		pds = image + readw(image + 24);
> +		/* The PCIR data structure must begin on a 4-byte boundary */
> +		if (!IS_ALIGNED((unsigned long)pds, 4)) {
> +			pci_info(pdev, "Invalid PCI ROM header signature: PCIR %#06x\n",
> +				 readw(image + 24));
> +			break;
> +		}

We definitely should not panic if the ROM is incorrectly formatted.  I
assume this crash happened because the ROM is mapped in such a way
that an unaligned readl() causes an alignment fault.

What would be the downside of reading byte-wise and just not enforcing
the alignment restriction, e.g., by using memcpy_fromio() or similar?

If we bail out here, I think we'll report a size that doesn't include
any images after this one where PCIR isn't correctly aligned.

>  		if (readl(pds) != 0x52494350) {
>  			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>  				 readl(pds));
> -- 
> 2.25.1
> 

