Return-Path: <linux-pci+bounces-3501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB985668C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 424AC1C22873
	for <lists+linux-pci@lfdr.de>; Thu, 15 Feb 2024 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E7132470;
	Thu, 15 Feb 2024 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JeQXA7zR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B07130ADA;
	Thu, 15 Feb 2024 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708008681; cv=none; b=j2Gl8S4xglwV8OWJmp3iy/Z7FHpFCQ3sCsmSM/TfTy7wIvmD12G+XeYSpglaotvT/Mxwyks2DX8W3KL/b/JsyICO57Nl9ph0LSPYU5o4W2hB/br5flhcO7frkOWHTErCgH56j3/egtCtLp97+/OF2qHaI7kUOfxrr6dhzRfTPHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708008681; c=relaxed/simple;
	bh=B8mmg75WeEttw7pPxYccdGAOyO7FWsoSc/5kLKpImqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PSypx8M3gvgoxah2fCSEIjyKMnpef2/jiYPcR4vvyIR/YeMGKeGWeJRs8WfedkNP0Id4IQfUVejVvgwsl/dcIGF7NQwKtiEhIIc2uoG8oSM0M2Qoygy9Lhl1HaLdsgxb3I0KmlZFT2mtB6Kyetf5YlXutDo0554Qh29DZkxykTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JeQXA7zR; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708008680; x=1739544680;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=B8mmg75WeEttw7pPxYccdGAOyO7FWsoSc/5kLKpImqQ=;
  b=JeQXA7zRp5CZ/JqxQh3BOssC3S/onpxMXXb8i3Aewq0/IjkXylCmLO6p
   te+MJDhkd1+rt0AzUg3vUjQHZETaLQMy7xjoVmlZaXWXnXyyuPU3Nm3FQ
   GzIeJS2S5kSmqOr2tu+G93NmyBzlNqBYUvahBWRG6N77rTKCGtP8GjC+R
   wXvKI1Rm5Nni/z2bqctCgpxfC47QxWeQUx4p1rC/3WT+lAYYeECEvpWdH
   JRy90jXxp6mIYipntWJGyOWaEClwmarWHq6Wm6gNSgz6KpnXOeO3A59n6
   WRL8mH4KrzuEMCY4NkNwPgHMJ7BwwSBObmmcPcntBZuI5d8fFvN6P8Lio
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1968915"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="1968915"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:51:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="935676974"
X-IronPort-AV: E=Sophos;i="6.06,161,1705392000"; 
   d="scan'208";a="935676974"
Received: from wilesamy-mobl.amr.corp.intel.com (HELO [10.251.3.206]) ([10.251.3.206])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 06:51:18 -0800
Message-ID: <361f7ae0-6de1-423c-bb64-82a5acccb502@linux.intel.com>
Date: Thu, 15 Feb 2024 06:51:16 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dwc: Use the correct sleep function in wait_for_link
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johan Hovold <johan+linaro@kernel.org>
References: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240215-topic-pci_sleep-v1-1-7ac79ac9739a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/15/24 2:39 AM, Konrad Dybcio wrote:
> According to [1], msleep should be used for large sleeps, such as the
> 100-ish ms one in this function. Comply with the guide and use it.
>
> [1] https://www.kernel.org/doc/Documentation/timers/timers-howto.txt
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Tested on Qualcomm SC8280XP CRD
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..abce6afceb91 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -655,7 +655,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		if (dw_pcie_link_up(pci))
>  			break;
>  
> -		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> +		msleep(LINK_WAIT_MSLEEP_MAX);
>  	}
>  
>  	if (retries >= LINK_WAIT_MAX_RETRIES) {
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..3f145d6a8a31 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,8 +63,7 @@
>  
>  /* Parameters for the waiting for link up routine */
>  #define LINK_WAIT_MAX_RETRIES		10
> -#define LINK_WAIT_USLEEP_MIN		90000
> -#define LINK_WAIT_USLEEP_MAX		100000
> +#define LINK_WAIT_MSLEEP_MAX		100

Since 90 ms is an acceptable value, why not use it?

>  
>  /* Parameters for the waiting for iATU enabled routine */
>  #define LINK_WAIT_MAX_IATU_RETRIES	5
>
> ---
> base-commit: 26d7d52b6253574d5b6fec16a93e1110d1489cef
> change-id: 20240215-topic-pci_sleep-368108a1fb6f
>
> Best regards,

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


