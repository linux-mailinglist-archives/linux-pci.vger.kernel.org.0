Return-Path: <linux-pci+bounces-22898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2065DA4EC22
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA4116AAB7
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 18:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BE25F7B4;
	Tue,  4 Mar 2025 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjnH0G3t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D62512FC
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 18:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113143; cv=none; b=PkBVEI3FoSOeHsQMM6hsAbE5js94Iuqg4XOcs7orJjc4cDyt3OujMkwDgaD+cS4jpJFysY+roDKV8Rw2F8wIKx95leorgrqlOYgeDkIDNqSyjXjnUMwesnUjDs5pP5NAfj4FcC1yC1fENX+QT57Wx4RfVkPETBBhwLoObOePeeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113143; c=relaxed/simple;
	bh=Smz3royHSHOULjPYadaKWgce1/hyxsfCjav03xzDzGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cOZN5As1bM3tYjFCQEmSaXQ9xgyiDCm16tBt0sdilD28Pzw4Xo/g44nzlNHhxnGJStb5lsy+gD+qYAupFy6s7nGxjJRnEs2mSz7qsmThJ1HU595YoBe1+/Z0JV26+iWsmQ472kPU/nA9LmTtyvPE2klthFYu5KZYgX0AJDTvmy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjnH0G3t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E1BC4CEE5;
	Tue,  4 Mar 2025 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741113142;
	bh=Smz3royHSHOULjPYadaKWgce1/hyxsfCjav03xzDzGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GjnH0G3tHVU+FZEOc/gMmSbaDGSCAnyxO5CsALA0qT9rj1ny/ewXtHron7fxEUyUb
	 ViB6ayhK/freW+UP8wc14xWM1xNJnFJBHRc/iEbUamw5/YR32uIkVZL5eMSrftv5v/
	 +E3ZHyRUey5qaeJS+gupMydRPW7acvDuxTLtOquYAytQ1WC0z19V8Hpity4Y50Hmim
	 +oEwk3jofrv+l+5mPRp5P973azLrhfCaXLj98tQjsDhui8xJH2Xtfcr1qlz0VlONsM
	 rMcx5e24sRQ12pWYDftis84eLJtLCaJZLDjRHHtH+qydTkpX6xXlhh0ABm9ap9FGUD
	 sh/Wc+X7RIvwA==
Date: Tue, 4 Mar 2025 12:32:21 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Pan-Doh <pandoh@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>,
	linux-pci@vger.kernel.org,
	Martin Petersen <martin.petersen@oracle.com>,
	Ben Fuller <ben.fuller@oracle.com>,
	Drew Walton <drewwalton@microsoft.com>,
	Anil Agrawal <anilagrawal@meta.com>,
	Tony Luck <tony.luck@intel.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/8] PCI/AER: Remove aer_print_port_info
Message-ID: <20250304183221.GA250118@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214023543.992372-2-pandoh@google.com>

On Thu, Feb 13, 2025 at 06:35:36PM -0800, Jon Pan-Doh wrote:
> Info logged is duplicated when the source device is processed. In both
> cases, BDF and error severity are derived from aer_error_info. If
> no source device is found, then an error is logged with the BDF from
> aer_error_info.

Nit: say what the patch does in the commit log as well as in the
subject.

> Code flow:
> aer_isr_one_error()
> -> aer_print_port_info()
> -> find_source_device()
>    -> return/pci_info() if no device found else continue
> -> aer_process_err_devices()
>    -> aer_print_error()

Nit: drop "->"; the indentation is enough.

> aer_print_port_info():
> pcieport 0000:00:04.0: Correctable error message received
> from 0000:01:00.0

Nit: don't wrap log messages, and indent them a couple space since
they're quoted material.

> aer_print_error():
> e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
> e1000e 0000:01:00.0:    [ 6] BadTLP

Give us a clear sample of the log showing the duplicated info.  Are
you're referring to this:

  pcieport 0000:00:04.0: Correctable error message received from 0000:01:00.0
  e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
  e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
  e1000e 0000:01:00.0:    [ 6] BadTLP

where the pcieport message refers to 0000:01:00.0, and the subsequent
e1000e messages also include 0000:01:00.0?

It's true this is redundant information, but that e1000e device may
no longer be accessible.

In that case, I think aer_get_device_error_info() would probably
return 0 because config reads would all return ~0, and
PCI_ERR_COR_STATUS & ~PCI_ERR_COR_MASK would be 0, so
we probably wouldn't see the e1000e messages at all.

> Tested using aer-inject[1]. No more root port log on dmesg.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
>  drivers/pci/pcie/aer.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index ad4206125b86..9a8cc81d01e4 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,18 +733,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> -{
> -	u8 bus = info->id >> 8;
> -	u8 devfn = info->id & 0xff;
> -
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> -}
> -
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  int cper_severity_to_aer(int cper_severity)
>  {
> @@ -1296,7 +1284,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  			e_info.multi_error_valid = 1;
>  		else
>  			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>  
>  		if (find_source_device(pdev, &e_info))
>  			aer_process_err_devices(&e_info);
> @@ -1315,8 +1302,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  		else
>  			e_info.multi_error_valid = 0;
>  
> -		aer_print_port_info(pdev, &e_info);
> -
>  		if (find_source_device(pdev, &e_info))
>  			aer_process_err_devices(&e_info);
>  	}
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

