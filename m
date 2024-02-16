Return-Path: <linux-pci+bounces-3650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12131858878
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 23:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD800B285F6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C121482E2;
	Fri, 16 Feb 2024 22:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ka0/U707"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D060941A85;
	Fri, 16 Feb 2024 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122410; cv=none; b=P/78lYBjNtv3lVdW2N0ZgVPS02bqzrBi+OOVSUPXe3PUQBEaaOV6W3zcmkw7Blvi+9xaWFY1sUuPyhSJADQaBHQsGmjtXUHRU/8azFRKSFO1lrCAdSWQOVmR+QMo0TBnuG2+mEdZsO+KYuSk/EYEWdW+9DRJOkVVruz67M7+rFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122410; c=relaxed/simple;
	bh=ZmonJ7Nefi92fQZ0foTUdv615WiSJMYGgeQfRHOvIUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYegP3tBCMWz3/tacawJ0qCkuKo4tQZvuU69axHjYg3EsnOdTW8dufzdv0FJspezv1rhP0tQDd3IvbH+q9XDeiocADFyumb5BwMbgQ5gRv3Rbe/C/WZSOSX6a599N2LL4oQu0y+/11QLLrVrCw3+Va3DarZwpWcaRdH7q9ro5/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ka0/U707; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708122409; x=1739658409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZmonJ7Nefi92fQZ0foTUdv615WiSJMYGgeQfRHOvIUo=;
  b=ka0/U707g2iTja2DaIhslNwNBMLXHTPU47+VxE7ewO1WHCbKwpzwdltE
   ql8To4HIhvPH6KtGghldjoXDp9ervwwvo8LQI4MOwudMDTR6zFMcquk+y
   o9U2cKzOi63+mE0Yu8gF5MRGBiCAJuJDrw4/+UbJTcQpO3OU9menLLiEc
   pkMNDawBjF7xqhtUZHJY5hU1LppyZi01UkzgqMNmYrT32PECsIDjVvHfW
   1YD7LD3MBxPlRc65n4a7YB/Ear3y+Hb51AK2vPh+pq15llfrxkVW74I2V
   053I+JVxSq9mnShvjf2Lhj8qZmul4pI6ZRdqSN56HvKcA2ThrkI0EQEmt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="19687808"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="19687808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:26:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8617406"
Received: from bfraley-mobl.amr.corp.intel.com (HELO [10.209.109.53]) ([10.209.109.53])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 14:26:48 -0800
Message-ID: <4858e202-6097-493a-8405-86d3e8e17c83@linux.intel.com>
Date: Fri, 16 Feb 2024 14:26:47 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: Increase maximum PCIe physical function number to
 7 for non-ARI devices
Content-Language: en-US
To: Bean Huo <beanhuo@iokpp.de>, bhelgaas@google.com, schnelle@linux.ibm.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bean Huo <beanhuo@micron.com>, stable@vger.kernel.org
References: <20240216190113.20341-1-beanhuo@iokpp.de>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240216190113.20341-1-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/16/24 11:01 AM, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
>
> The PCIe specification allows up to 8 Physical Functions (PFs) per endpoint
> when ARI (Alternative Routing-ID Interpretation) is not supported. Previously,
> our implementation erroneously limited the maximum number of PFs to 7 for
> endpoints without ARI support.
I would quote specification reference here, like below:

As per PCIe specification r6.2, sec titled "Alternative Routing-ID Interpretation
(ARI)", up to 8 [fn # 0..7] functions are allowed in an non ARI capable device.

It looks like for an ARI capable device the limit is 256. Why not add that
check as well?

>
> This patch corrects the maximum PF count to adhere to the PCIe specification
> by allowing up to 8 PFs on non-ARI endpoints. This change ensures better
> compliance with the standard and improves compatibility with devices relying
> on this specification.
>
> The necessity for this adjustment was verified by a thorough review of the
> "Alternative Routing-ID Interpretation (ARI)" section in the PCIe 3.0 Spec,
> which first introduced ARI.

I would always use latest PCIe spec for reference.

>
> Fixes: c3df83e01a96 ("PCI: Clean up pci_scan_slot()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bean Huo <beanhuo@micron.com>
> ---
> Changelog:
> 	v1--v2:
> 		1. Add Fixes tag
> 		2. Modify commit message
> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ed6b7f48736a..8c3d0f63bc13 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2630,7 +2630,8 @@ static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
>  	if (pci_ari_enabled(bus))
>  		return next_ari_fn(bus, dev, fn);
>  
> -	if (fn >= 7)
> +	/* If EP does not support ARI, the maximum number of functions should be 7 */
> +	if (fn > 7)
>  		return -ENODEV;
>  	/* only multifunction devices may have more functions */
>  	if (dev && !dev->multifunction)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


