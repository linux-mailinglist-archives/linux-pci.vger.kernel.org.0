Return-Path: <linux-pci+bounces-28046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3C8ABCBC0
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 01:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E37179CB3
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 23:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A3421146B;
	Mon, 19 May 2025 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPItoz0/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC764B1E5E;
	Mon, 19 May 2025 23:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747698577; cv=none; b=SDGZ8yiA2CJP1unYi4fSaS5v1pVm+nRjZ2S6fd/sYzIlrjF49M5wozq0PF1bvFQ75b930n/N2wqANrjv833qcpqM5CGgcpFLmhbYomu1JF1fP5uPawRHAV1Fc3kYwgKjvVQwiXiI1+4Rx662mOEeAAyQ/3dTrYhQNk0gJJTbjpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747698577; c=relaxed/simple;
	bh=O84k9EnJyyrZuf5S6CNnSfQgF+n7riYthWXWhPrZbyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx4OQiwGxQzIAIBy/FMsn5akeV/9N+Wg9r5s9p1m6lZrzH5bSTmnSkpp6wYgURi3fM/5eyHArgCv7Trx15Q9IBoWCJintuJ+6F6q2XeAbPslUfvZzeN7d2c7NxvYxiBIcuZ1PvNwu9ufHAlcPi9KNvH8gw8+IO/R5fd8DD92Gi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPItoz0/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747698577; x=1779234577;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O84k9EnJyyrZuf5S6CNnSfQgF+n7riYthWXWhPrZbyM=;
  b=UPItoz0/XWp3n86yFOGYs7Q5e8jlNoUCkhk0qEbOCN1toZ0CgoinDtj1
   uR1/naBvr/ILLWCGszFv01IbpLd/5/bxj+BMu23z1ImguGeKbjUc/VpX0
   jh9THwi9QAQLZjgy0UKTRIkdQjY1RdBUP0gcuy+u4zmTvrMACWhkANXF7
   sBw79XeFnKv3yoriHvz9B7rHPVTNIuCEGePI8nOGAn5ePGwXIwTVWZe2X
   JWwadS3cg+M9ZPqahSka7uJ0Guy8Vo/rqySQREkFSMcJdD05pw0h6yYWy
   1ClaKC68jF/TMnw8zgsO+4+q/T1bdFNvaetpmPREFq81WoVvPqiqBHr+K
   A==;
X-CSE-ConnectionGUID: SzfdeTY/QK+4JA3/FIL8Gg==
X-CSE-MsgGUID: j5g2uniOR1yP+HspNTXXPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49597453"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49597453"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:49:36 -0700
X-CSE-ConnectionGUID: 9jiAD3WuT0C4XQE2d1Yunw==
X-CSE-MsgGUID: R0u7aAmeTsa+JZ3syAFdsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="162811269"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 16:49:34 -0700
Message-ID: <4a21d39b-fd88-4699-80dd-21abe7aa5053@linux.intel.com>
Date: Mon, 19 May 2025 16:49:34 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 06/16] PCI/AER: Move aer_print_source() earlier in file
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Martin Petersen <martin.petersen@oracle.com>,
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
References: <20250519213603.1257897-1-helgaas@kernel.org>
 <20250519213603.1257897-7-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-7-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Move aer_print_source() earlier in the file so a future change can use it
> from aer_print_error(), where it's easier to rate limit it.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pcie/aer.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index eb42d50b2def..95a4cab1d517 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -696,6 +696,18 @@ static void __aer_print_error(struct pci_dev *dev,
>   	pci_dev_aer_stats_incr(dev, info);
>   }
>   
> +static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
> +			     const char *details)
> +{
> +	u16 source = info->id;
> +
> +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
> +		 info->multi_error_valid ? "Multiple " : "",
> +		 aer_error_severity_string[info->severity],
> +		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
> +		 PCI_SLOT(source), PCI_FUNC(source), details);
> +}
> +
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	int layer, agent;
> @@ -733,18 +745,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> -static void aer_print_source(struct pci_dev *dev, struct aer_err_info *info,
> -			     const char *details)
> -{
> -	u16 source = info->id;
> -
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), PCI_BUS_NUM(source),
> -		 PCI_SLOT(source), PCI_FUNC(source), details);
> -}
> -
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
>   int cper_severity_to_aer(int cper_severity)
>   {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


