Return-Path: <linux-pci+bounces-28048-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3BCABCBDE
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 02:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBA34A5A2A
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC7C26AE4;
	Tue, 20 May 2025 00:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IE5G3rTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEED182BC;
	Tue, 20 May 2025 00:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747699352; cv=none; b=uOTURrOJkCBkLal83FB7lnKuyTgDdRrgHzlqMgnG6pg0PdHoz6T8hNuG5QkH2LUJqvYStvZKBC/S+FqMf7+hVBvtp1VuLXrWI2aaXRlWcRQyaMTaaiOCS9X9QqV0w0EHQNgbUa1LZ2IfVrll4dAoD6He6m8fu/Kq7tOyup5Q5wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747699352; c=relaxed/simple;
	bh=J43x42J+4FoAQ0Tp7uilc32NtEm5R2XUDI1KVaIDlTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EyGnAEwoScHWdFi0XpkyjkSAt12pfc2zQ0Sphd1j/J8//9MjXyxR6ncZEo8AYtrko2/Kx8NvK0UcgUzMlhZEI2FpYXw23xYcq2pngNEWEdQFrX6J6rsZ8/J2lLv+REE0Zv/CKriKZgarHpoqcJy9ViX/L/Ump9ECPvcDotwyDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IE5G3rTy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747699350; x=1779235350;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=J43x42J+4FoAQ0Tp7uilc32NtEm5R2XUDI1KVaIDlTY=;
  b=IE5G3rTyfmmk3nDyj2DF2LhwTVvJBjTWR6qrsVtlwbVAmDUb7BBxW8F+
   F4HaK1XxaDEE+1lxWCJ8mmn5pqVHIXT642Uw76o4Vnb2nvDQdS8E/q2MY
   tPjDGkpAyf/8lTd8KUcpb3tVyjdk3sK7OHfA9jN60Y/e8j2jMvAoyIWqE
   Wd1J1chfMhIJq0UGSzi2pDJwxoD8y60o8hD4iVhYCvwoEMmb2aQOwrw4U
   vJkeLCbbKpjrQDc3zFlF4dghnzdrRr49ZJGJozu2WrWxz9kymIK78d4if
   JDXmEay8LDr9A/AigUuUhYzWGKmNJFY5jlIolH8pBRbr3lSuBYkBAb5VM
   A==;
X-CSE-ConnectionGUID: FxT3Yq2ISFKLa6zs6ua9vQ==
X-CSE-MsgGUID: RH/L7UYzQt2Q+Oywpj/kdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="61008285"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="61008285"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:02:29 -0700
X-CSE-ConnectionGUID: h7nQP4WzT+uoVKSWgwtLbA==
X-CSE-MsgGUID: vwaPAcRVRp+ujxE6ObiciA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139423280"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:02:28 -0700
Message-ID: <89d93eb8-ad95-4ac4-b0dc-44b37c458d91@linux.intel.com>
Date: Mon, 19 May 2025 17:02:28 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 08/16] PCI/AER: Simplify pci_print_aer()
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
 <20250519213603.1257897-9-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-9-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> Simplify pci_print_aer() by initializing the struct aer_err_info "info"
> with a designated initializer list (it was previously initialized with
> memset()) and using pci_name().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pcie/aer.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 40f003eca1c5..73d618354f6a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -765,7 +765,10 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   {
>   	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
> -	struct aer_err_info info;

You have cleaned up other stack allocations of struct aer_err_info to zero
initialization in your previous patches. Why not follow the same format
here? I don't think this function resets all fields of aer_err_info, right?

> +	struct aer_err_info info = {
> +		.severity = aer_severity,
> +		.first_error = PCI_ERR_CAP_FEP(aer->cap_control),
> +	};
>   
>   	if (aer_severity == AER_CORRECTABLE) {
>   		status = aer->cor_status;
> @@ -776,14 +779,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>   	}
>   
> -	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> -	agent = AER_GET_AGENT(aer_severity, status);
> -
> -	memset(&info, 0, sizeof(info));
> -	info.severity = aer_severity;
>   	info.status = status;
>   	info.mask = mask;
> -	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> +
> +	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> +	agent = AER_GET_AGENT(aer_severity, status);
>   
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info);
> @@ -797,7 +797,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>   
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(pci_name(dev), (status & ~mask),
>   			aer_severity, tlp_header_valid, &aer->header_log);
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


