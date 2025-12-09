Return-Path: <linux-pci+bounces-42854-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C8CB0666
	for <lists+linux-pci@lfdr.de>; Tue, 09 Dec 2025 16:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F9A300855E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Dec 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00822C0F62;
	Tue,  9 Dec 2025 15:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="njQcincw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C42BEC3F;
	Tue,  9 Dec 2025 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294191; cv=none; b=ktC8M68FgjMwaOZbPlppq2dot2JkO27Q/yo7o0c+x+Kx08D06B974l7fJw/HBL5EmliU/jM2vcla7bl9fBulDVQ+ihNXXJkCA4CRrH/W/Lf2kUcP/J94jy+jBQVKRZFoJho7G2JhRZB8/Co3ys1NqpKzLZMthbe5O56nYcpBWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294191; c=relaxed/simple;
	bh=DtHPrO93RryFrNtCXwUdRBTS0o7exTpmRgQl395wLAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kwDrz/2Bj2i/gZDX7qFp0KYyOE5Meuk+ujQMBYV7OVOYdONd9+Tr9ZAQyNsNQ3N+uHQW1i7xA4K/5CIc9ovE25PJlcCuxRkZeCiOPKZMLqaZQyHAAUaQvSmqDepQlGmjpTdL5SM/An4fy45D8zo05zOzJQE+Wes7xWk6CL3al5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=njQcincw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765294190; x=1796830190;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DtHPrO93RryFrNtCXwUdRBTS0o7exTpmRgQl395wLAU=;
  b=njQcincwA/brf4Yy5lj0V1vGNHxv7ek1YUpfEqnEdHv9qobPZ96W7C21
   TWXvXZ9Mgo+krMCkMrYzt6rdWKfK2FNo3SB1+FkLsNiIEN29+bzUDoIVd
   6vM5+EsHI4d886yYVCMOznENfc0h+bTcz2x1ZpUgLp8ItLov5o7UNQm1o
   kD5JqF8AxXv2HDOui2Ov6+gDtIzJ4g0ZnHm/1ciaOoNj5ay+2z9UvSGH7
   5Yske6RdkNEvQodA0PLlYqs8g/+MauH/0mml8ItWzFaFyht3vvA2WvHFR
   Gcb2jyssEWmtJn+fLvepP0B9+FyT+NfycVnHERX5Dk44WUcHafs4ddIk4
   g==;
X-CSE-ConnectionGUID: oXhe1QwySImTarvhAd3XEg==
X-CSE-MsgGUID: mKkWlM6hT2e83UxRqYdYtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11637"; a="66257804"
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="66257804"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:29:48 -0800
X-CSE-ConnectionGUID: uz8LxhTnQQmEORQnviIxmw==
X-CSE-MsgGUID: fLP1LYGLRAWzdkpWSgL6dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,261,1758610800"; 
   d="scan'208";a="201358326"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2025 07:29:49 -0800
Received: from [10.125.109.59] (unknown [10.125.109.59])
	by linux.intel.com (Postfix) with ESMTP id 4B85320B5871;
	Tue,  9 Dec 2025 07:29:48 -0800 (PST)
Message-ID: <c603bed2-7d1f-4559-a7d6-dcbd91a03f3b@linux.intel.com>
Date: Tue, 9 Dec 2025 07:29:47 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] drivers/pci: Decouple DPC from AER service
To: Darshit Shah <darnshah@amazon.de>, lukas@wunner.de
Cc: Jonthan.Cameron@huawei.com, bhelgaas@google.com, darnir@gnu.org,
 feng.tang@linux.alibaba.com, kwilczynski@kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nh-open-source@amazon.com
References: <aSnWyePbCKPvjpKq@wunner.de>
 <20251208112545.21315-1-darnshah@amazon.de>
 <20251208112545.21315-2-darnshah@amazon.de>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20251208112545.21315-2-darnshah@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 12/8/25 3:25 AM, Darshit Shah wrote:
> According to [1] it is recommended that the Operating System link the
> enablement of Downstream Port Containment (DPC) to the enablement of
> Advanced Error Reporting (AER).
>
> However, AER is advertised only on Root Port (RP) or Root Complex Event
> Collector (RCEC) devices. On the other hand, DPC may be advertised on
> any PCIe device in the hierarchy. In fact, since the main usecase of DPC
> is for the switch upstream of an endpoint device to trigger a signal to
> the host-bridge, it is imperative that it be supported on non-RP,
> non-RCEC devices.
>
> Previously portdrv has interpreted [1] to mean that the AER service must
> be available on the same device in order for DPC to be available. This is
> not what the implementation note in [1] meant to imply. If the firmware
> hands the OS control of AER via _OSC on the host bridge upstream of the
> device, then the OS should be allowed to assume control of DPC on that device.
>
> The comment above this check alludes to this, by saying:
>   > With dpc-native, allow Linux to use DPC even if it doesn't have permission
>   > to use AER.
> However, permission to use AER is negotiated at the host bridge, not
> per-device. So we should not link DPC to enabling AER at the device.
> Instead, DPC should be enabled if the OS has control of AER for the
> host bridge that is upstream of the device in question, or if dpc-native
> was set on the command line.
>
> [1]: PCI Express Base Specification Revision 5.0 Version 1.0, Sec. 6.2.10
>
> Signed-off-by: Darshit Shah <darnshah@amazon.de>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changes in patch v2:
>    * Don't touch the PCIE_PORT_SERVICE_AER attachment
>    * Stop relying on PCIE_PORT_SERVICE_AER for enabling DPC
>    * Instead test that OS has control of AER at parent host bridge
>
>   drivers/pci/pcie/portdrv.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 38a41ccf79b9..8db2fa140ae2 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -264,7 +264,7 @@ static int get_port_device_capability(struct pci_dev *dev)
>   	 */
>   	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
>   	    pci_aer_available() &&
> -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> +	    (host->native_aer || pcie_ports_dpc_native))
>   		services |= PCIE_PORT_SERVICE_DPC;
>   
>   	/* Enable bandwidth control if more than one speed is supported. */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


