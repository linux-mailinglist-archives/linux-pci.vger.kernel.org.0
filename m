Return-Path: <linux-pci+bounces-34613-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF7AB3217D
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 19:27:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FC61C2757E
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBD92820C7;
	Fri, 22 Aug 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYIJREYc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D731096F;
	Fri, 22 Aug 2025 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883649; cv=none; b=tAY+ugRqKo31hReuRYPcYF8Ifj4rji2IcNs4aAUnHexG6d5l3EfhnY1W9pPKpSC+YpFPLUeCw/PRo7TYfetAwM/1qHRq89FFkOXSVbVhdrxIA41ZM3muWlCQsIwWlv0rzifkPaQGAO189bFcl7rg4Mm01Ix5DOIGoNYN8wN7AOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883649; c=relaxed/simple;
	bh=G7KtXL3SjzTkHJuJOjwYNF1lYEbXJj7RSBitEc7W8Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SGvj2fz5RAMfHXpO/c2CKb+nZsrqMWVSY7PoBC1kqdP76w219bqOg4QJSHYBothfK1yuiUrfcScSDCC45DpGV71INVRFz5OjQtZPwrD+DziL8NiLgAaGEpOVWljYcHnppJkCsDAg3pqLhcyOhz1xKEKh8izCYdsAAjKLE6CQxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYIJREYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA3CC4CEED;
	Fri, 22 Aug 2025 17:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755883649;
	bh=G7KtXL3SjzTkHJuJOjwYNF1lYEbXJj7RSBitEc7W8Zw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JYIJREYc3SZvg4o7EQpPH98l0K7aQf2+DyQbIFgiot+v5EJ++MLXdULNEx4PVxR+A
	 zC9ma60qFBdp2XnPeijvRm+wVOkoqzpt15MRz/yn/5n90QBS6uVUiSvHE7AEGt90uP
	 zSFIO0Xy/X66608SXg7/eEo6+mUpBp71po7Vv9MaQmOSSGXObn/Nx1LXxYvbhJEDZy
	 Wfzz4nJy1B0TR7/QOJO21Mw90TDV4FtTIOkbi0JkC2H8HctU/SLT75H3DjYoeheL0r
	 66HNIRe+xb/XdQWmpdkEZ2WP+bLIrTOdXnMid5nXxcXP+UNe1eUbxB+l+xxkeCBO0s
	 Xw/eo9rSGhsig==
Date: Fri, 22 Aug 2025 12:27:27 -0500
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
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v5 2/2] PCI/AER: Print UNCOR_STATUS bits that might be
 ANFE
Message-ID: <20250822172727.GA690123@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620025857.206647-3-zhenzhong.duan@intel.com>

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

Forgot to mention on other patch, but please add spaces between the
spelled-out terms and the "()" abbreviation, e.g., "Correctable Error
(CE)".

Also, can you update this commit log to say what the patch does?  It's
OK if it repeats and/or expands on the subject.

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
> +
> +	strings = aer_uncorrectable_error_string;
> +	pci_printk(level, dev, "Uncorrectable errors that may cause Advisory Non-Fatal:\n");

Will have to look at the spec more, but I don't think "may cause" is
quite the right wording here.  It's not that an Uncorrectable Error
causes a separate Advisory Non-Fatal Error; IIUC there's only a single
error and it's just *treated* and signaled differently.

> +
> +	for_each_set_bit(i, &anfe_status, 32) {
> +		errmsg = strings[i];
> +		if (!errmsg)
> +			errmsg = "Unknown Error Bit";
> +
> +		pci_printk(level, dev, "   [%2d] %s\n", i, errmsg);

I think we might have removed pci_printk() recently, so this might
need adjustment.

> +	}
>  }
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> -- 
> 2.34.1
> 

