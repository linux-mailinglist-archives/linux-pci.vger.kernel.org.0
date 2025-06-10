Return-Path: <linux-pci+bounces-29334-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA05AD3B19
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A08B83A3DF0
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 14:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4775226533;
	Tue, 10 Jun 2025 14:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J0t+PbkW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401B017736;
	Tue, 10 Jun 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565694; cv=none; b=a8adxahimsUPEDotJGCbqsSqmo4cvTEqo0jknYQK3/DY80yJBvnmpgYO5L01vCz2vJ13KKoSJJLpHpch1w4NAKWxY6Vkdgg1QvhwQXo/Jk27hcyy7qgAOANCnBcUnYf7Mymbt4pEkLc+jgFcXZvUxxVMcCzpHk33JvO+acLSSPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565694; c=relaxed/simple;
	bh=gTGrkkXJXtcN3VCr/khEFI8vA0euMy7qN+z/5//IhEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VpLGSbR4jgH6CpvDrEGdxDujs7AAHaUGYLmcI7k2VeByiGEgoGQE25iiY+yuUUVUg/i6uyyliKsrEks9v2JWopCVDwSN6EEJPeaB2QPub2skQs8ybQSSLciuCBuOVcGBNyl4bkwWm6FDOgmCpPDzTTAwZxCl78XiqEpSpHMfdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J0t+PbkW; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749565693; x=1781101693;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gTGrkkXJXtcN3VCr/khEFI8vA0euMy7qN+z/5//IhEQ=;
  b=J0t+PbkWG+BwrbSPNJmth8n+2jFnNTtontcCUhYQ93bBod39JKMgEjBE
   Hi0Xab3AGMnZdTSOxsDNNrNUzTnhSbHPAy1cUzgS+uDSE6ea7VaEsXB89
   nOtp/9RQPdJ4cm1OIGvYGOJIT3RW4ygTcC8VuHPZkofa2kPpzFpClxLRh
   nxm1b0CzMrHKH2Qe1LijWpxAsj7U7LSpVFFTq/Jfz2U5OPAdeUSaFs1kK
   BW0j6nk8vhilOeRqAnZdC9foHD8VoJiDn8xIMWgo39KGB5zfslSzG4712
   yslvh+gjoKktHgDSRJtS+WzM9PJy251luwKsT6ejAwa6JfNnYDu1IXKZ5
   Q==;
X-CSE-ConnectionGUID: 0WezmPsRQ3SMUHy4R1mdhw==
X-CSE-MsgGUID: NWI3x6k1TOq2UHIgNCA5Yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63032983"
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="63032983"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:28:12 -0700
X-CSE-ConnectionGUID: F+yeyCRiTtW8dhS1ONg2RA==
X-CSE-MsgGUID: TnlSzNbkQImsd4kwRZbssw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,225,1744095600"; 
   d="scan'208";a="146782750"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 07:28:12 -0700
Received: from [10.124.220.93] (unknown [10.124.220.93])
	by linux.intel.com (Postfix) with ESMTP id B11A220B5736;
	Tue, 10 Jun 2025 07:28:11 -0700 (PDT)
Message-ID: <9d4ab150-0006-40a9-9056-71c16971d928@linux.intel.com>
Date: Tue, 10 Jun 2025 07:28:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] PCI: Cleanup pci_scan_child_bus_extend() loop
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610105820.7126-1-ilpo.jarvinen@linux.intel.com>
 <20250610105820.7126-3-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250610105820.7126-3-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/10/25 3:58 AM, Ilpo Järvinen wrote:
> pci_scan_child_bus_extend() open-codes device number iteration in the
> for loop. Convert to use PCI_DEVFN() and add PCI_MAX_NR_DEVS (there
> seems to be no pre-existing defines for this purpose).
>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.h   | 1 +
>   drivers/pci/probe.c | 6 +++---
>   2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..caa6e02a9aea 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -8,6 +8,7 @@ struct pcie_tlp_log;
>   
>   /* Number of possible devfns: 0.0 to 1f.7 inclusive */
>   #define MAX_NR_DEVFNS 256
> +#define PCI_MAX_NR_DEVS	32
>   
>   #define MAX_NR_LANES 16
>   
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index f08e754c404b..963cab481327 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3029,14 +3029,14 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>   {
>   	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>   	unsigned int start = bus->busn_res.start;
> -	unsigned int devfn, cmax, max = start;
> +	unsigned int devnr, cmax, max = start;
>   	struct pci_dev *dev;
>   
>   	dev_dbg(&bus->dev, "scanning bus\n");
>   
>   	/* Go find them, Rover! */
> -	for (devfn = 0; devfn < 256; devfn += 8)
> -		pci_scan_slot(bus, devfn);
> +	for (devnr = 0; devnr < PCI_MAX_NR_DEVS; devnr++)
> +		pci_scan_slot(bus, PCI_DEVFN(devnr, 0));
>   
>   	/* Reserve buses for SR-IOV capability */
>   	used_buses = pci_iov_bus_range(bus);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


