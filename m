Return-Path: <linux-pci+bounces-4799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A787B678
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 03:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E29C284B62
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 02:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A0E7E1;
	Thu, 14 Mar 2024 02:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R0W9/X3p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F48F55
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 02:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710384012; cv=none; b=IHRI7hlQNMXJPq1E4IA0tUJKcrRVuK/2ZedK3LcZ4XtdLcsbB/Nyjai+AOIeuvey8KlxI1oWjiCfvYcBE5Ak5Jz01Opr4NXNUfIGgUgo7JiwvZ+zMGzRNpk87l5QmZ9FXooFbCGwgOf+ScTsARfpCuEqNuSuhsS/AMw4lhI7c2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710384012; c=relaxed/simple;
	bh=EQ9kcIPVT0jRQjxYxP4rUtRFP72dl7XijGgSMqx97EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kaXyJqvP6oP6NNv8vUNzwUHJjupF6x0x2tRT8it1UuzI2P0X63Y2eAUdt1CpERZJlk5SVD2pPPULaLbjip1F86OWybZ73ZKNNHjyqzvuAwn6VqnY9n2BRitudqiD9tzrT5fl26xz6RVqH+/RJuw3Dd7k+gZoE+mmxQmgg0OD6hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R0W9/X3p; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710384011; x=1741920011;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EQ9kcIPVT0jRQjxYxP4rUtRFP72dl7XijGgSMqx97EI=;
  b=R0W9/X3pdrqVarEF3E/cdHtJQN0YT2O2FdXwLOgNAV3cl5hir+2sIgmC
   TRiIuj3y+Lirsrd4RnOTWPhh7kKKsDlQ2MllIrHR4qaRLPueb15hCjOdg
   CCV8r4fx0PJzsrPnPU65c8g05lsLOOvu88wDapIQ8a94n1O4de/I08Zif
   Qh/pyDztMnbUwKwe4w24r8OwJqZMINj/y5BSDR8LmID8OHBJ6RH56Khc/
   8SEYzgFSDjN8gcQ/VHxkxiST3zcgbE//KZkDarVBTq+ofbfg9KBJSaQRd
   iVf9QMmlrOv20RWmY+8tF5qIqn4yiGi+6ZPsDLDx+ZTnP4jVTmqhE1szX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="22642883"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="22642883"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:40:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="12057647"
Received: from oozturk-mobl3.amr.corp.intel.com (HELO [10.209.75.221]) ([10.209.75.221])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:40:10 -0700
Message-ID: <518813f8-294f-461c-b0dc-e980893a9ebf@linux.intel.com>
Date: Wed, 13 Mar 2024 19:40:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [drivers/pci] Possible memleak in pci_bus_set_aer_ops
Content-Language: en-US
To: zzjas98@gmail.com, bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, chenyuan0y@gmail.com
References: <ZfJe4GZGpEQq7WIa@zijie-lab>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <ZfJe4GZGpEQq7WIa@zijie-lab>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 3/13/24 7:20 PM, Zijie Zhao wrote:
> Dear PCI Developers,
>
> We are curious whether the function `pci_bus_set_aer_ops` might have a memory leak.
>
> The function is https://elixir.bootlin.com/linux/v6.8/source/drivers/pci/pcie/aer_inject.c#L297
> and the relevant code is
> ```
> static int pci_bus_set_aer_ops(struct pci_bus *bus)
> {
> 	struct pci_ops *ops;
> 	struct pci_bus_ops *bus_ops;
> 	unsigned long flags;
>
> 	bus_ops = kmalloc(sizeof(*bus_ops), GFP_KERNEL);
> 	if (!bus_ops)
> 		return -ENOMEM;
> 	ops = pci_bus_set_ops(bus, &aer_inj_pci_ops);
> 	spin_lock_irqsave(&inject_lock, flags);
> 	if (ops == &aer_inj_pci_ops)
> 		goto out;
> 	pci_bus_ops_init(bus_ops, bus, ops);
> 	list_add(&bus_ops->list, &pci_bus_ops_list);
> 	bus_ops = NULL;
> out:
> 	spin_unlock_irqrestore(&inject_lock, flags);
> 	kfree(bus_ops);
> 	return 0;
> }
> ```
>
> Here if the goto statement does not jump to `out`, the `bus_ops` will be assigned with `NULL` and then `kfree(bus_ops)` will not free the allocated memory.
>
> Please kindly correct us if we missed any key information. Looking forward to your response!

I think it is a valid issue that needs to be fixed. If you would like, please send a patch to fix it.

>
> Best,
> Zijie
>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


