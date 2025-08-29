Return-Path: <linux-pci+bounces-35146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F80B3C433
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 23:18:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F733B1197
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 21:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40674265CCB;
	Fri, 29 Aug 2025 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTF1qr6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050131EEA49;
	Fri, 29 Aug 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756502284; cv=none; b=ReICshlY3i4xKXd8QLhAdps6AoTDN2OpY3X8v+gj1G8vrSV6YE6FAWVnVqdNBuo/kDnuoijuVWJjrNSV8smmc7lgPJlEQV0eXjTd6K4C7ibWmOhk31cvE0OLVvmxU8SLYzhGVx+ixeArW+Hp1eA1OkczwY4ATiBCMvRI+HlmQ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756502284; c=relaxed/simple;
	bh=V5VOMAjw9pzEl70en0MP+3pcBujDo0p2tlcA6Iwhj08=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KdxfetHFKFz/Ui447a7Xk/yO97URuOZAXNkMM3VOyUZPMQXLzQ4y2SbQv+DeSC0zWWN2Vve4CN9qV5+nUT2yDKbFI4DxHa1Z55X7wARDbx5rKCVeoRKllo6Zy9uI77tBYZGsaq7s+pJyxy09hP39z+4rE8lI+W8hUX0tXlCFmqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTF1qr6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E6C4CEF0;
	Fri, 29 Aug 2025 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756502283;
	bh=V5VOMAjw9pzEl70en0MP+3pcBujDo0p2tlcA6Iwhj08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cTF1qr6gFycOdtViqBehM1mwJmfXzfYP+ZHDqakqlmGuO18OPu7EJxuqBPjbkolvL
	 qOxyZ4ZX6PBxKF6Y0I4ZTcz4v/tOkzZG4R0ZohsfxpaWtdJOfA8hiUEcZl+I0hvIbP
	 mEXIVFKiifrZQEXq47mc7+8EuwpjhADw05aGzMbr5TqBL9v5w1YOPzezEmHpEBCLHj
	 ZVsQdN3oZZbcIBF+e537fOz9HTTWFObWhdCnCU9zrXgEK1vSezg6ArLxCRu3dX5PDS
	 4JUBXpK3uOMKHxjZ9GHz3s1Us6VsQrWHYGdCjHdjlcRryaOzKIjDXzJ/8o/VcOO3qR
	 zztYif2H5i5wA==
Date: Fri, 29 Aug 2025 16:18:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, mahesh@linux.ibm.com,
	oohall@gmail.com, linuxppc-dev@lists.ozlabs.org,
	linux-acpi@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	james.morse@arm.com, tony.luck@intel.com, bp@alien8.de,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com, linmiaohe@huawei.com,
	shiju.jose@huawei.com, adam.c.preble@intel.com, lukas@wunner.de,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	linux-cxl@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org, erwin.tsaur@intel.com,
	sathyanarayanan.kuppuswamy@intel.com, dan.j.williams@intel.com,
	feiting.wanyan@intel.com, yudong.wang@intel.com,
	chao.p.peng@intel.com, qingshun.wang@linux.intel.com,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Matthew W Carlis <mattc@purestorage.com>
Subject: Re: [PATCH v5 2/2] PCI/AER: Print UNCOR_STATUS bits that might be
 ANFE
Message-ID: <20250829211801.GA1025641@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620025857.206647-3-zhenzhong.duan@intel.com>

[+cc Matt]

On Thu, Jun 20, 2024 at 10:58:57AM +0800, Zhenzhong Duan wrote:
> When an Advisory Non-Fatal error(ANFE) triggers, both correctable error(CE)
> status and ANFE related uncorrectable error(UE) status will be printed:
> 
>   AER: Correctable error message received from 0000:b7:02.0
>   PCIe Bus Error: severity=Correctable, type=Transaction Layer, (Receiver ID)
>     device [8086:0db0] error status/mask=00002000/00000000
>      [13] NonFatalErr
>     Uncorrectable errors that may cause Advisory Non-Fatal:
>      [12] TLP
> 
> Tested-by: Yudong Wang <yudong.wang@intel.com>
> Co-developed-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: "Wang, Qingshun" <qingshun.wang@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  drivers/pci/pcie/aer.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 3dcfa0191169..ba3a54092f2c 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -681,6 +681,7 @@ static void __aer_print_error(struct pci_dev *dev,
>  {
>  	const char **strings;
>  	unsigned long status = info->status & ~info->mask;
> +	unsigned long anfe_status = info->anfe_status;
>  	const char *level, *errmsg;
>  	int i;
>  
> @@ -701,6 +702,20 @@ static void __aer_print_error(struct pci_dev *dev,
>  				info->first_error == i ? " (First)" : "");
>  	}
>  	pci_dev_aer_stats_incr(dev, info);
> +
> +	if (!anfe_status)
> +		return;

__aer_print_error() is used by both native AER handling, where Linux
fields the AER interrupt and reads the AER status registers directly,
and APEI GHES firmware-first error handling, where platform firmware
fields the AER interrupt, reads the AER status registers, and packages
them up to hand off to Linux via aer_recover_queue().

But the previous patch only sets info->anfe_status for the native
path, so the APEI GHES path doesn't get the benefit of this change.

I think both paths should log the same ANFE information.

> +
> +	strings = aer_uncorrectable_error_string;
> +	pci_printk(level, dev, "Uncorrectable errors that may cause Advisory Non-Fatal:\n");
> +
> +	for_each_set_bit(i, &anfe_status, 32) {
> +		errmsg = strings[i];
> +		if (!errmsg)
> +			errmsg = "Unknown Error Bit";
> +
> +		pci_printk(level, dev, "   [%2d] %s\n", i, errmsg);
> +	}
>  }
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> -- 
> 2.34.1
> 

