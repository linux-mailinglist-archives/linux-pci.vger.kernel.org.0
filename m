Return-Path: <linux-pci+bounces-43607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC9BCDA01C
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CC2F3023782
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86844339701;
	Tue, 23 Dec 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJ5qrDvV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E0335550;
	Tue, 23 Dec 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766508921; cv=none; b=sOBU7LDOk9jcgqBfVP/Bm7x15oFj5NPnduZ/+UuMCHTEMJ+1Ch96HPeTEegrYouPyfhhhG05alSqezF0vgHu5S+HcSm2jlXiYHb2EmiimuFOwu7wzgRdD18MkN7llXIgUrvpu0YfigdbstXcLZ2kpI08w/f4wxJIq+Y9NvyvnOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766508921; c=relaxed/simple;
	bh=ltgQdYgBnysWUr/VkNwZQnLBoSCYQLPBmTC7FhV54Vw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=plFIuKVGsJvsve4Qa2xce6w4wLXDL93f0nptLYE5YNAQDYl6WXiwAB1JoF5QW4fEHD1XP5MOWmW9VqT7a8grkMAFkXAs2NaLnKwfd1q4FIjjbzr+KadaAhb8FiguOk6mwteAA/XHzH4cV+JVZ9cHDaVVytikaRgdhyaIQv+mD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJ5qrDvV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7701FC116C6;
	Tue, 23 Dec 2025 16:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766508920;
	bh=ltgQdYgBnysWUr/VkNwZQnLBoSCYQLPBmTC7FhV54Vw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=tJ5qrDvVoBQ4kOO5ge25lE/hBeoULuTjpy2CaWn4gnHDWgEzkutHAqPbF0xXIouA3
	 fF49etJlMga1rKpNPHrnZrh918I1Nog9oZFMBV/nNsa36jyYe/Y3OFt5K7U+EJl37Z
	 vAKaFpU2cwTu2igvMExlmyaGhIK8yoj8Y5zJ3D15dvHgGDYWXXsAFHat1e8V3PP4zx
	 00UEIjsu6ZncV380FFkUVOmUMNkxs5zbfy16HWF4QywD/VA/Nogq5UGluypawL/QM1
	 T/ywbHIIpds3sqonssBC99TK93DAzdz0FoeU9RU9PJ0txFjkZ92FB9qjz6uVREUgCn
	 zPyFZoG7IiH7A==
Date: Tue, 23 Dec 2025 10:55:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ziming Du <duziming2@huawei.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, chrisw@redhat.com,
	jbarnes@virtuousgeek.org, alex.williamson@redhat.com,
	liuyongqiang13@huawei.com
Subject: Re: [PATCH 1/3] PCI/sysfs: fix null pointer dereference during PCI
 hotplug
Message-ID: <20251223165519.GA4023266@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216083912.758219-2-duziming2@huawei.com>

Capitalize first word of subject to match history (see
"git log --oneline drivers/pci/pci-sysfs.c")

Drop "PCI" in "PCI hotplug" -- we already know this is PCI.

On Tue, Dec 16, 2025 at 04:39:10PM +0800, Ziming Du wrote:
> During the concurrent process of creating and rescanning in VF, the resource
> files for the same "pci_dev" may be created twice. The second creation attempt
> fails, resulting the "res_attr" in "pci_dev" to 'kfree', but the pointer is not
> set to NULL. This will subsequently lead to dereferencing a null pointer when
> removing the device.

Wrap this to fit in 75 columns so it still fits in 80 when git log
indents it.

Drop quotes around struct and member names, e.g., pci_dev, res_attr.

Drop '' around function names and add "()" after, e.g., kfree().

> When we perform the following operation:
> "echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
>  sleep 0.5
>  echo 1 > /sys/bus/pci/rescan
>  pci_remove "$pfname" "
> system will crash as follows:

Indent quoted material two spaces and drop the "" around it, e.g.,

When we perform the following operation:

  echo $vfcount > /sys/class/net/"$pfname"/device/sriov_numvfs &
  sleep 0.5
  ...

system will crash as follows.

> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> Mem abort info:
> ESR = 0x0000000096000004
> EC = 0x25: DABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> FSC = 0x04: level 0 translation fault
> Data abort info:
> ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> user pgtable: 4k pages, 48-bit VAs, pgdp=000020400d47b000
> 0000000000000000 pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 #1 SMP
> CPU: 115 PID: 13659 Comm: testEL_vf_resca Kdump: loaded Tainted: G W E 6.6.0 #9
> Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 0.98 08/25/2019
> pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __pi_strlen+0x14/0x150
> lr : kernfs_name_hash+0x24/0xa8
> sp : ffff8001425c38f0
> x29: ffff8001425c38f0 x28: ffff204021a21540 x27: 0000000000000000
> x26: 0000000000000000 x25: 0000000000000000 x24: ffff20400f97fad0
> x23: ffff20403145a0c0 x22: 0000000000000000 x21: 0000000000000000
> x20: 0000000000000000 x19: 0000000000000000 x18: ffffffffffffffff
> x17: 2f35322f38302038 x16: 392e3020534f4942 x15: 00000000fffffffd
> x14: 0000000000000000 x13: 30643378302f3863 x12: 3378302b636e7973
> x11: 00000000ffff7fff x10: 0000000000000000 x9 : ffff800100594b3c
> x8 : 0101010101010101 x7 : 0000000000210d00 x6 : 67241f72241f7224
> x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
> __pi_strlen+0x14/0x150
> kernfs_find_ns+0x54/0x120
> kernfs_remove_by_name_ns+0x58/0xf0
> sysfs_remove_bin_file+0x24/0x38
> pci_remove_resource_files+0x44/0x90
> pci_remove_sysfs_dev_files+0x28/0x40
> pci_stop_bus_device+0xb8/0x118
> pci_stop_and_remove_bus_device+0x20/0x40
> pci_iov_remove_virtfn+0xb8/0x138
> sriov_disable+0xbc/0x190
> pci_disable_sriov+0x30/0x48
> hinic_pci_sriov_disable+0x54/0x138 [hinic]
> hinic_remove+0x140/0x290 [hinic]
> pci_device_remove+0x4c/0xf8
> device_remove+0x54/0x90
> device_release_driver_internal+0x1d4/0x238
> device_release_driver+0x20/0x38
> pci_stop_bus_device+0xa8/0x118
> pci_stop_and_remove_bus_device_locked+0x28/0x50
> remove_store+0x128/0x208

Indent this quoted material two spaces and remove parts that aren't
relevant.

> Fix this by set the pointer to NULL after releasing 'res_attr' immediately.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index c2df915ad2d2..7e697b82c5e1 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1222,12 +1222,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr[i] = NULL;
>  		}
>  
>  		res_attr = pdev->res_attr_wc[i];
>  		if (res_attr) {
>  			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
>  			kfree(res_attr);
> +			pdev->res_attr_wc[i] = NULL;
>  		}
>  	}
>  }
> -- 
> 2.43.0
> 

