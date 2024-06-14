Return-Path: <linux-pci+bounces-8828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FDC908BB7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 14:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08C91C20E35
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BA194AC5;
	Fri, 14 Jun 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nopoLBWV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A802312D74D;
	Fri, 14 Jun 2024 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718368334; cv=none; b=dWMUsrhVdMHqog/9lV20iqcrAbav2B7D+/j1lqiAmWW9SpaktICbTFYI7vP1ml3LgrsbQit20CMOO+xFkwVyxKcdIlVP6XMAvjCU+OwoHxWjyd/LTNiYEJGxAkpFhjGn7MKIL+PjApb5S/qH/dQ6O1S98fvs077wLC5x6pyHpmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718368334; c=relaxed/simple;
	bh=d4Bv2ZzuYu1QopJr82AZ6xrYRfuX0NoNXCgdGIEC8Nc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HHVZ8apKioEiOszJsF+u4OX3hTdFxLTW8GU8H67pNQp8YLAcHOpIf3TVnnF+zY1xc85KBPr3J2DblNG/YsbNZh+E/vm07k1Jl65FBnfY3EykP9bEoREhof4qlz+TmKEhwSuZyPpm4GNgpfF+4X4GGQKt5lNymEUCtJsNfzOpIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nopoLBWV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718368333; x=1749904333;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d4Bv2ZzuYu1QopJr82AZ6xrYRfuX0NoNXCgdGIEC8Nc=;
  b=nopoLBWVgSFSExTMBwO/aW4kMJIYsMsdyNQsT72/1dXDRK0NDOW7e2Ri
   ceuEArmNwdkhMVMd+CN9SiFjRFtSgjkYD6ZA55/XNE48UAEuLU3pjmTif
   s/M49bCv5Kra3GinF/wHpe3i2Mx9WMMN9yEXRhbofrKv/6XRang1O96Yh
   FAd6DBoLOAgGWYd5ykOyR9V1jijDYBnyA0S6IBRSQf1L7Wz4ToKz4veHd
   F7Uu4Veuqa2gnT4s/a9QQGVEButySgp/xXDIdRWqfk3qL8qQKqLXF9WHE
   VkvljUzRrgdwYCo6suW+yUzPlY/2V14RgaBAUsCHDCouk3JI7alnFOR9r
   Q==;
X-CSE-ConnectionGUID: c4nys7iCQhSEjg28/63XYw==
X-CSE-MsgGUID: knrB/t/5TE6ckMB8gDY8sA==
X-IronPort-AV: E=McAfee;i="6700,10204,11103"; a="26366574"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="26366574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:32:12 -0700
X-CSE-ConnectionGUID: tdkimbqMR1mmScCfKZcLzg==
X-CSE-MsgGUID: KkhV+DFFQ7q2xccIm4rZzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="40414794"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 05:32:04 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 14 Jun 2024 15:32:01 +0300 (EEST)
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
cc: Bjorn Andersson <andersson@kernel.org>, 
    Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
    Conor Dooley <conor+dt@kernel.org>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org, 
    bmasney@redhat.com, djakov@kernel.org, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
    devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, vireshk@kernel.org, quic_vbadigan@quicinc.com, 
    quic_skananth@quicinc.com, quic_nitegupt@quicinc.com, 
    quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v14 3/4] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
In-Reply-To: <20240609-opp_support-v14-3-801cff862b5a@quicinc.com>
Message-ID: <c76624fa-1c07-1bb4-dff0-e35fe072f176@linux.intel.com>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com> <20240609-opp_support-v14-3-801cff862b5a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 9 Jun 2024, Krishna chaitanya chundru wrote:

> Bring the switch case in pcie_link_speed_mbps() to new function to
> the header file so that it can be used in other places like
> in controller driver.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c | 19 +------------------
>  drivers/pci/pci.h | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d2c388761ba9..6e50fa89b913 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6027,24 +6027,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
>  	if (err)
>  		return err;
>  
> -	switch (to_pcie_link_speed(lnksta)) {
> -	case PCIE_SPEED_2_5GT:
> -		return 2500;
> -	case PCIE_SPEED_5_0GT:
> -		return 5000;
> -	case PCIE_SPEED_8_0GT:
> -		return 8000;
> -	case PCIE_SPEED_16_0GT:
> -		return 16000;
> -	case PCIE_SPEED_32_0GT:
> -		return 32000;
> -	case PCIE_SPEED_64_0GT:
> -		return 64000;
> -	default:
> -		break;
> -	}
> -
> -	return -EINVAL;
> +	return pcie_link_speed_to_mbps(to_pcie_link_speed(lnksta));

pcie_link_speed_mbps() calls pcie_link_speed_to_mbps(), seems quite 
confusing to me. Perhaps renaming one to pcie_dev_speed_mbps() would help
against the almost identical naming.

In general, I don't like moving that code into a header file, did you 
check how large footprint the new function is (when it's not inlined)?

Unrelated to this patch, it would be nice if LNKSTA register read would 
not be needed at all here but since cur_bus_speed is what it is currently, 
it's just wishful thinking.

>  }
>  EXPORT_SYMBOL(pcie_link_speed_mbps);
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 1b021579f26a..391a5cd388bd 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -333,6 +333,28 @@ void pci_bus_put(struct pci_bus *bus);
>  	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
>  	 0)
>  
> +static inline int pcie_link_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}



-- 
 i.


