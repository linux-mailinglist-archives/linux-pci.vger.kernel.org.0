Return-Path: <linux-pci+bounces-41510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6A0C6A6B8
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 16:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F01834C0D9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Nov 2025 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021B436827A;
	Tue, 18 Nov 2025 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QLnMRxYH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECE34DB64
	for <linux-pci@vger.kernel.org>; Tue, 18 Nov 2025 15:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480869; cv=none; b=nBLV64cOsK9UXYPfJtfRoXRYFghw/pIIcVc9CV8JQy01N3T988JP9YKtiiEu+K6IIEU/7QUt0VzTeshKD+wTCc60Nao0cEK1xR7EHaf8jQO/Ek8Wsv71S0XZpwA7cjDw/KGwFV+w2n/G37b9wwK+ghoulma2YGJ2WgtabIg+UJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480869; c=relaxed/simple;
	bh=cyhXzVMzGTGvtqpzcCL+7A+0PQYZJ8mfGKNkFW1y+6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSd0s3BBDWfzx7nKqi/OyplYQ6EuBeBEpa+wXJEFrhBakZff8+OLYNE3wrUgKTpwTSmKjM/s4o7D0t2h7lCTmtduC/VAl2U/k1YpiDM/bLh05C3l1BGhGq4FfM0FOEHQnF7UgojwLV/SxX4AL+nFQZCZkiOt5WQXwdC3y/m6xRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QLnMRxYH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763480868; x=1795016868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cyhXzVMzGTGvtqpzcCL+7A+0PQYZJ8mfGKNkFW1y+6o=;
  b=QLnMRxYHrG8090xtEKL+UDY23h3ER/oiqccYx1XVmR8MwdQlS/ZpkXyf
   K+u6irwDW/kNi7PCfCZmbEajM2XFc0194kAMXKaOFg+/azi7iX21/7QDE
   Upgvpo2cCJouNiDnx1BG/QOc8xir3O3mc9BvJ2+zbcYZ6LoYRBo2t6cIa
   +HniKK7ZcbziP9xpCPZKG2NsAHy7+3in9hR9TdskiAbRjDFRAa+DN5eJB
   yjMl9yL2dWDdGLYBR+6BpQcoSALiQ/XZL8Bl7ETIgDXCRbgOe4pVy6TUb
   w8AnIRp1yxwRy2M0TFDeJ2ma6hLHMoIT3dNTQG1i1aKPtEpqFzmNeU2iS
   w==;
X-CSE-ConnectionGUID: atNGnDHYTqCSxdyc5W2fYA==
X-CSE-MsgGUID: ZOehhZULTeuFb3lATr5BBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76108767"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76108767"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 07:47:47 -0800
X-CSE-ConnectionGUID: RETMKZeFQHWhYhwf2TrBtQ==
X-CSE-MsgGUID: 1JcVudI1SnygAtcdcsvX7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="191564983"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 18 Nov 2025 07:47:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 442B398; Tue, 18 Nov 2025 16:47:45 +0100 (CET)
Date: Tue, 18 Nov 2025 16:47:45 +0100
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Check rom image addr at every step
Message-ID: <aRyVIebrZk__gkKE@black.igk.intel.com>
References: <20251114063411.88744-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114063411.88744-1-kanie@linux.alibaba.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Nov 14, 2025 at 02:34:11PM +0800, Guixin Liu wrote:
> We meet a crash when running stress-ng:

+ blank line.

>   BUG: unable to handle page fault for address: ffa0000007f40000
>   RIP: 0010:pci_get_rom_size+0x52/0x220
>   Call Trace:
>   <TASK>
>   pci_map_rom+0x80/0x130
>   pci_read_rom+0x4b/0xe0
>   kernfs_file_read_iter+0x96/0x180

>   vfs_read+0x1b1/0x300
>   ksys_read+0x63/0xe0
>   do_syscall_64+0x34/0x80
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2

Please, read
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and act accordingly (I think of 4 least significant lines)

+ blank line.

> Bcause of broken rom space, before calling readl(pds), pds already
> points to the rom space end (rom + size - 1), invoking readl()
> would therefore cause an out-of-bounds access and trigger a crash.
> 
> Fix this by adding every step address checking.

From the description and the code I'm not sure this is the best approach. Since
the accesses seem to be not 4-byte aligned, perhaps readl() should be split to
something shorter in such cases? Dunno, I haven't looked at the code.

Ah, it seems we are looking for the full 4 bytes to match. But then we need more, no?
See below.

...

> +#define PCI_ROM_DATA_STRUCT_OFFSET 24
> +#define PCI_ROM_LAST_IMAGE_OFFSET 21
> +#define PCI_ROM_LAST_IMAGE_LEN_OFFSET 16

Are those based on PCI specifications? Perhaps if we go this way the reference
to the spec needs to be added.

...

> static size_t pci_get_rom_size(struct pci_dev *pdev, void __iomem *rom,

>  	void __iomem *image;
>  	int last_image;
>  	unsigned int length;
> +	void __iomem *end = rom + size;

Can you group together IOMEM addresses?

	void __iomem *end = rom + size;
	void __iomem *image;
	int last_image;
	unsigned int length;

>  
>  	image = rom;
>  	do {
>  		void __iomem *pds;

> +		if (image + 2 >= end)
> +			break;

Shouldn't we rather check the size to be at least necessary minimum? With this
done, this check won't be needed here. Or we would need another one to check
for the length for the entire structure needed.

>  		/* Standard PCI ROMs start out with these bytes 55 AA */
>  		if (readw(image) != 0xAA55) {
>  			pci_info(pdev, "Invalid PCI ROM header signature: expecting 0xaa55, got %#06x\n",
>  				 readw(image));
>  			break;
>  		}

> +		if (image + PCI_ROM_DATA_STRUCT_OFFSET + 2 >= end)
> +			break;
>  		/* get the PCI data structure and check its "PCIR" signature */
> -		pds = image + readw(image + 24);
> +		pds = image + readw(image + PCI_ROM_DATA_STRUCT_OFFSET);
> +		if (pds + 4 >= end)
> +			break;
>  		if (readl(pds) != 0x52494350) {
>  			pci_info(pdev, "Invalid PCI ROM data signature: expecting 0x52494350, got %#010x\n",
>  				 readl(pds));

You also want to reconsider double readl(). Would it have side-effects? What about hot-plug?

>  			break;
>  		}
> -		last_image = readb(pds + 21) & 0x80;
> -		length = readw(pds + 16);
> +
> +		if (pds + PCI_ROM_LAST_IMAGE_OFFSET + 1 >= end)
> +			break;
> +		last_image = readb(pds + PCI_ROM_LAST_IMAGE_OFFSET) & 0x80;
> +		length = readw(pds + PCI_ROM_LAST_IMAGE_LEN_OFFSET);
>  		image += length * 512;
>  		/* Avoid iterating through memory outside the resource window */
> -		if (image >= rom + size)
> +		if (image + 2 >= end)
>  			break;
>  		if (!last_image) {
>  			if (readw(image) != 0xAA55) {

I agree that defensive programming helps, but I think it's too much in this
case. We may relax and do less, but comprehensive checks.

...

Thanks for the testing and proposing a fix, nevertheless!


-- 
With Best Regards,
Andy Shevchenko



