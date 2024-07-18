Return-Path: <linux-pci+bounces-10510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62589934FAF
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1AA1C20CCC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF8A143C4D;
	Thu, 18 Jul 2024 15:11:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F23B3BB30;
	Thu, 18 Jul 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721315516; cv=none; b=JfgfNYbf+rZPOaD+ZQi165kbyjn8/JnhIf4yu5tclDAvdQhgjkDvC9li2Kb0/liXXQPSf+OjgwCjHIYCNhaXn/K4N/pVxWvLoYvoonftHrTQA3kdzNpkwC7PfpjkJl+DB9ak/Z8srPLwZ4iNZjP+uyniOT+eDuUn7uc+jL37QFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721315516; c=relaxed/simple;
	bh=tftujqMhl3/ZpPbxEpSq7XaBUosVPf/UThN/DJ3XRn8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ThBWPucy7eBHjqRsyBiG8fS3Z6pezXbjDXXQCGjdbrX6TX6tPKAe6w835pXESXvLWwg7hEyfk2Y8DoIcfxfHR8T/jpE52qgPkn8GOZEQe7Uew+9IweZmqGyD/RKFI48XC/6QvjQEgYAM/8sBTOm3QESj625UknjZi4CehmtOnkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPx7C2kTLz6H7qS;
	Thu, 18 Jul 2024 23:09:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A84F1140593;
	Thu, 18 Jul 2024 23:11:50 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:11:50 +0100
Date: Thu, 18 Jul 2024 16:11:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>, David Box
	<david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH v2 11/18] PCI/CMA: Expose in sysfs whether devices are
 authenticated
Message-ID: <20240718161149.00007748@Huawei.com>
In-Reply-To: <8851c4d4c829dd6608f15244954e3fbe9995908b.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<8851c4d4c829dd6608f15244954e3fbe9995908b.1719771133.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:46:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The PCI core has just been amended to authenticate CMA-capable devices
> on enumeration and store the result in an "authenticated" bit in struct
> pci_dev->spdm_state.
> 
> Expose the bit to user space through an eponymous sysfs attribute.
> 
> Allow user space to trigger reauthentication (e.g. after it has updated
> the CMA keyring) by writing to the sysfs attribute.
> 
> Implement the attribute in the SPDM library so that other bus types
> besides PCI may take advantage of it.  They just need to add
> spdm_attr_group to the attribute groups of their devices and amend the
> dev_to_spdm_state() helper which retrieves the spdm_state for a given
> device.
> 
> The helper may return an ERR_PTR if it couldn't be determined whether
> SPDM is supported by the device.  The sysfs attribute is visible in that
> case but returns an error on access.  This prevents downgrade attacks
> where an attacker disturbs memory allocation or DOE communication
> in order to create the appearance that SPDM is unsupported.
> 
> Subject to further discussion, a future commit might add a user-defined
> policy to forbid driver binding to devices which failed authentication,
> similar to the "authorized" attribute for USB.
> 
> Alternatively, authentication success might be signaled to user space
> through a uevent, whereupon it may bind a (blacklisted) driver.
> A uevent signaling authentication failure might similarly cause user
> space to unbind or outright remove the potentially malicious device.
> 
> Traffic from devices which failed authentication could also be filtered
> through ACS I/O Request Blocking Enable (PCIe r6.2 sec 7.7.11.3) or
> through Link Disable (PCIe r6.2 sec 7.5.3.7).  Unlike an IOMMU, that
> will not only protect the host, but also prevent malicious peer-to-peer
> traffic to other devices.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

One question on a bit of error path cleanup that I can't immediately see
the reason for.

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index 34bb8f232799..0f94c4ed719e 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c
> @@ -694,6 +694,7 @@ void pci_doe_init(struct pci_dev *pdev)
>  		if (IS_ERR(doe_mb)) {
>  			pci_err(pdev, "[%x] failed to create mailbox: %ld\n",
>  				offset, PTR_ERR(doe_mb));
> +			pci_cma_disable(pdev);

Why?  pci_cma_init() is currently called after pci_doe_init() so I don't
see why we need to disable here.  If we want a default of disabled, do that
before calling pci_doe_init() rather than in the error paths

1) Set default to disabled.
2) pci_doe_init()
3) pci_cma_init() - now not disabled.


>  			continue;
>  		}
>  
> @@ -702,6 +703,7 @@ void pci_doe_init(struct pci_dev *pdev)
>  			pci_err(pdev, "[%x] failed to insert mailbox: %d\n",
>  				offset, rc);
>  			pci_doe_destroy_mb(doe_mb);
> +			pci_cma_disable(pdev);
>  		}
>  	}
>  }





