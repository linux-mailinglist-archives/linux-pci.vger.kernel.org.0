Return-Path: <linux-pci+bounces-1609-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE6B8221EC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 20:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E261C227AF
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jan 2024 19:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6348315AEF;
	Tue,  2 Jan 2024 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XcBMLyCc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C74415AD4;
	Tue,  2 Jan 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704223374; x=1735759374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fVCcKmpfYEHeBzGLIPKiA/LCVGfjiQfemd8HKgtcMv4=;
  b=XcBMLyCcLMH0TjhVehPc9e8H2gDMk00rZW7t9bU+5VL4/pWoio1JLZ5B
   kWpixHKvuwTaCGDYwUOoR37GviK4RoSnK0BY3SLJhvO+vwPwUKX9RUuF/
   3e9NQbjN0OtyHVKZ3Y1FGuiJExcsA+b1hfVaJmC2cqED0O7en4NKLzjyr
   QvHSlqCD447tBWKqPOY+mJg+pgi2FPRnzGn5QKlXj4YQIkUymOUlnM9Kl
   Nw+jUT8zJroZbYp6Y8VX5S9DncC21PGOwriD/VVsLWZMiOpqKpKxyCeA/
   oByDfrZurStiOjJ8BJrcr0GJVitalyVEpqBWL1grzWcqr/mlMo6etNMau
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="428078494"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="428078494"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:22:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="1111132006"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="1111132006"
Received: from keithj1-mobl2.amr.corp.intel.com (HELO [10.209.44.31]) ([10.209.44.31])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:22:52 -0800
Message-ID: <6cc6adf0-e82d-4429-9e76-5fef7dda2d95@linux.intel.com>
Date: Tue, 2 Jan 2024 11:22:53 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI/AER: Decode Requester ID when no error info found
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20231206224231.732765-1-helgaas@kernel.org>
 <20231206224231.732765-3-helgaas@kernel.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231206224231.732765-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/6/2023 2:42 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> When a device with AER detects an error, it logs error information in its
> own AER Error Status registers.  It may send an Error Message to the Root
> Port (RCEC in the case of an RCiEP), which logs the fact that an Error
> Message was received (Root Error Status) and the Requester ID of the
> message source (Error Source Identification).
> 
> aer_print_port_info() prints the Requester ID from the Root Port Error
> Source in the usual Linux "bb:dd.f" format, but when find_source_device()
> finds no error details in the hierarchy below the Root Port, it printed the
> raw Requester ID without decoding it.
> 
> Decode the Requester ID in the usual Linux format so it matches other
> messages.
> 
> Sample message changes:
> 
>   - pcieport 0000:00:1c.5: AER: Correctable error received: 0000:00:1c.5
>   - pcieport 0000:00:1c.5: AER: can't find device of ID00e5
>   + pcieport 0000:00:1c.5: AER: Correctable error message received from 0000:00:1c.5
>   + pcieport 0000:00:1c.5: AER: found no error details for 0000:00:1c.5
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Except for the suggestion given below, it looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> ---
>  drivers/pci/pcie/aer.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 20db80018b5d..2ff6bac9979f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -740,7 +740,7 @@ static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>  	u8 bus = info->id >> 8;
>  	u8 devfn = info->id & 0xff;
>  
> -	pci_info(dev, "%s%s error received: %04x:%02x:%02x.%d\n",
> +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
>  		 info->multi_error_valid ? "Multiple " : "",
>  		 aer_error_severity_string[info->severity],
>  		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> @@ -929,7 +929,12 @@ static bool find_source_device(struct pci_dev *parent,
>  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
>  	if (!e_info->error_dev_num) {
> -		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
> +		u8 bus = e_info->id >> 8;
> +		u8 devfn = e_info->id & 0xff;

You can use PCI_BUS_NUM(e_info->id) for getting bus number. Since you are
extracting this info in more than one place, maybe you can also define a
macro PCI_DEVFN(id) (following PCI_BUS_NUM()).

> +
> +		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> +			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> +			 PCI_FUNC(devfn));
>  		return false;
>  	}
>  	return true;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

