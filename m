Return-Path: <linux-pci+bounces-28308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17F9AC1835
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 01:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B944507E5A
	for <lists+linux-pci@lfdr.de>; Thu, 22 May 2025 23:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92C52BFC6C;
	Thu, 22 May 2025 23:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gomBanB3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553D28EBE5;
	Thu, 22 May 2025 23:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747957487; cv=none; b=f5be2luQzGPCLGksGXZYi+Vg4Ad01vDXlRr3rn6Ner7Kde+07FPjCoOHj8H2Jq+YxI/1h0Mv13SOlgkq46ID/uW4XtQjqnfZfowbp8sI4VHvrdKRoIVI2lC7m0fcv0sFSZyzpPGsLWsh6Lk7kkw9xY7C4fG5omtRmhWz+TyNMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747957487; c=relaxed/simple;
	bh=HrxTnpzGlksA3R7lsGE+tdhiAU6geStxqS72uNEzULM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnQb9uaE8/U1rkZAz309UyKntXRwjnDPucAtmK/zSm7S2lOuMjK7DNrmOo1g2GmBJ0gCoXJfOUEiEq2gkNfPjbV2rWCi3AqFL/7dv0YVLdCIH7mi7f9NP+8HQWKVeYBfsnBe3TDxO6vgITTVDMQwP10bYW/ZIvvUbZXJ1anVdcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gomBanB3; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747957486; x=1779493486;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HrxTnpzGlksA3R7lsGE+tdhiAU6geStxqS72uNEzULM=;
  b=gomBanB30cX9JladWukW8XEgFmfH76x83KgqGzsauPNVRobbgMH0EgMl
   du+MXQkU1hA9KLI53BGJ154ng2NFvOFUiF7NhdI7u7deg201MFpO3nlZS
   tog3ik8z7BQHOTImrtOqGjJAqs38IUM8DnsWTTO/9jgViHeDxAywoHVBD
   gUH4nW5VSdVqj3jr80oLn9Aa/R2V0bmtEyvA3MIquj2Ni/f/xcftl/VP6
   hwWWcTTzZTib2hM9tqcLeW6VcRrwyjpOh2V8V+SXvLDmfQknQhSYkuQrB
   nBlYr9he9Vnv+YoPYQkzTNIxIelV2MVJT31SKftRt+XIWA+VX3xLaChsx
   g==;
X-CSE-ConnectionGUID: pWvHJ+qCSy2cNBxb1TLBCw==
X-CSE-MsgGUID: ommC8IaRQTWLWp4UdtIxsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60257378"
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="60257378"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:44:45 -0700
X-CSE-ConnectionGUID: y/I8ALG+QGGXRBknYG+cJA==
X-CSE-MsgGUID: MLFZckS/QtKuGpd0063UaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,307,1739865600"; 
   d="scan'208";a="145538704"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.223.120]) ([10.124.223.120])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 16:44:44 -0700
Message-ID: <2d99e03b-e899-41dd-91f8-d36673d23392@linux.intel.com>
Date: Thu, 22 May 2025 16:44:43 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 13/20] PCI/ERR: Add printk level to
 pcie_print_tlp_log()
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Weinan Liu <wnliu@google.com>, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250522232339.1525671-1-helgaas@kernel.org>
 <20250522232339.1525671-14-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250522232339.1525671-14-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/22/25 4:21 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> aer_print_error() produces output at a printk level (KERN_ERR/KERN_WARNING/
> etc) that depends on the kind of error, and it calls pcie_print_tlp_log(),
> which previously always produced output at KERN_ERR.
>
> Add a "level" parameter so aer_print_error() can control the level of the
> pcie_print_tlp_log() output to match.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.h      | 3 ++-
>   drivers/pci/pcie/aer.c | 5 +++--
>   drivers/pci/pcie/dpc.c | 2 +-
>   drivers/pci/pcie/tlp.c | 6 ++++--
>   4 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 705f9ef58acc..1a9bfc708757 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -613,7 +613,8 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>   		      struct pcie_tlp_log *log);
>   unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc);
>   void pcie_print_tlp_log(const struct pci_dev *dev,
> -			const struct pcie_tlp_log *log, const char *pfx);
> +			const struct pcie_tlp_log *log, const char *level,
> +			const char *pfx);
>   #endif	/* CONFIG_PCIEAER */
>   
>   #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f80c78846a14..f0936759ba8b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -734,7 +734,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	__aer_print_error(dev, info);
>   
>   	if (info->tlp_header_valid)
> -		pcie_print_tlp_log(dev, &info->tlp, dev_fmt("  "));
> +		pcie_print_tlp_log(dev, &info->tlp, level, dev_fmt("  "));
>   
>   out:
>   	if (info->id && info->error_dev_num > 1 && info->id == id)
> @@ -797,7 +797,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   			aer->uncor_severity);
>   
>   	if (tlp_header_valid)
> -		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> +		pcie_print_tlp_log(dev, &aer->header_log, info.level,
> +				   dev_fmt("  "));
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 6c98fabdba57..7ae1590ea1da 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -222,7 +222,7 @@ static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>   			  dpc_tlp_log_len(pdev),
>   			  pdev->subordinate->flit_mode,
>   			  &tlp_log);
> -	pcie_print_tlp_log(pdev, &tlp_log, dev_fmt(""));
> +	pcie_print_tlp_log(pdev, &tlp_log, KERN_ERR, dev_fmt(""));
>   
>   	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG + 1)
>   		goto clear_status;
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 890d5391d7f5..71f8fc9ea2ed 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -98,12 +98,14 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>    * pcie_print_tlp_log - Print TLP Header / Prefix Log contents
>    * @dev: PCIe device
>    * @log: TLP Log structure
> + * @level: Printk log level
>    * @pfx: String prefix
>    *
>    * Prints TLP Header and Prefix Log information held by @log.
>    */
>   void pcie_print_tlp_log(const struct pci_dev *dev,
> -			const struct pcie_tlp_log *log, const char *pfx)
> +			const struct pcie_tlp_log *log, const char *level,
> +			const char *pfx)
>   {
>   	/* EE_PREFIX_STR fits the extended DW space needed for the Flit mode */
>   	char buf[11 * PCIE_STD_MAX_TLP_HEADERLOG + 1];
> @@ -130,6 +132,6 @@ void pcie_print_tlp_log(const struct pci_dev *dev,
>   		}
>   	}
>   
> -	pci_err(dev, "%sTLP Header%s: %s\n", pfx,
> +	dev_printk(level, &dev->dev, "%sTLP Header%s: %s\n", pfx,
>   		log->flit ? " (Flit)" : "", buf);
>   }

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


