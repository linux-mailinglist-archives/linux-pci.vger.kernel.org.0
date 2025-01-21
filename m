Return-Path: <linux-pci+bounces-20192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 968F5A17F84
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 15:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EFCB3AB8B9
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 14:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC71F12FF;
	Tue, 21 Jan 2025 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BQ01S1Pp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555563CF
	for <linux-pci@vger.kernel.org>; Tue, 21 Jan 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737469100; cv=none; b=Df7CapF0MQliOoXpHEEt6ZnCRyTTzCTiJgcWaZ1YQeFl7DgCd3KYe5rMjpWPwNpaTsrgSnzjYhGU6ZeDBwjPe/klyBZPzJCQiqCYmfYt6iSFsBEqKSGe3dvTHlBPP33IbdyFZThS3C171hYkEh6LzYCVMM7e6xLD4D37pZukV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737469100; c=relaxed/simple;
	bh=TBM1w+Gom42UyOvKDQitTkrfL3XqZcy1rfjxGfVoqAY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BvN+GFhOsuk9ed79dZO3LWWfZJg0gtdSQX99jvlcV5MpuUajn38o7b7dTjnpGCl9T5vUcBvcEldqBHCldbeCvhsiqIQ09a70f7AAm0vkIzuMYspft/ws0PTunqngj29IrDpJM+zVsVJZefjCR7LmJy3V1SU8+9sfwwwuIZAvYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BQ01S1Pp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737469100; x=1769005100;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TBM1w+Gom42UyOvKDQitTkrfL3XqZcy1rfjxGfVoqAY=;
  b=BQ01S1Ppg7kBX0/pSxQfAcrsxitnmiA4XKCFD0SklIwl24DkBeaFkHLC
   wsmB78M/nSR+ukqJUsqhTzd3NR8EKQlVRaUlzLDpV35IpPKad+kyYnCZW
   937BhbeYCLFvAfgoMpUkPXjJOTQzzEhKhOP32TFKVCTngv8uWn25iD1Wm
   BDQqnKZmcUVbf9yJ5XlBQPgrqgrT3zCuj/1QiJrtDUKheJwterHu2MyH/
   v+/89qTb+EHrypO6tqxWwhH2jtaujlc0u1HTIZojxyYPwwAMukm9J8bJp
   YRA08Voicwac6ajsIK1ctXZmrrdmyD0hprUsd2lWKuZQmRn4DkshA0OWc
   w==;
X-CSE-ConnectionGUID: d7ECeMCJSTeBYTi2WE5pRA==
X-CSE-MsgGUID: 0uHzM2AsRSqCEXO2xstXmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11322"; a="37094490"
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="37094490"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 06:18:19 -0800
X-CSE-ConnectionGUID: lcb3KUHpRhmtdWrWZOCIdQ==
X-CSE-MsgGUID: BK1NtJWeQ5Go8Vp8Xc6LdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,222,1732608000"; 
   d="scan'208";a="111803211"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.188])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2025 06:18:15 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Jan 2025 16:18:12 +0200 (EET)
To: Jon Pan-Doh <pandoh@google.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 1/8] PCI/AER: Remove aer_print_port_info
In-Reply-To: <20250115074301.3514927-2-pandoh@google.com>
Message-ID: <f1eb0909-b845-98c8-d81a-7069d352ffef@linux.intel.com>
References: <20250115074301.3514927-1-pandoh@google.com> <20250115074301.3514927-2-pandoh@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 14 Jan 2025, Jon Pan-Doh wrote:

> Info logged is duplicated when either the source device is processed. If

Is the first sentence lacking something, as "either" feels to require
another option/alternative that is not present in the sentence? (I'm 
non-native myself)

> no source device is found, than an error is logged.
> 
> Code flow:
> aer_isr_one_error()
> -> aer_print_port_info()
> -> find_source_device()
>    -> return/pci_info() if no device found else continue
> -> aer_process_err_devices()
>    -> aer_print_error()
> 
> aer_print_port_info():
> [   21.596150] pcieport 0000:00:04.0: Correctable error message received
> from 0000:01:00.0
> 
> aer_print_error():
> [   21.596163] e1000e 0000:01:00.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> [   21.600575] e1000e 0000:01:00.0:   device [8086:10d3] error status/mask=00000040/0000e000
> [   21.604707] e1000e 0000:01:00.0:    [ 6] BadTLP
> 
> Tested using aer-inject[1] tool. No more root port log on dmesg.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>  drivers/pci/pcie/aer.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34ce9f834d0c..ba40800b5494 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -735,18 +735,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> -{
> -	u8 bus = info->id >> 8;
> -	u8 devfn = info->id & 0xff;
> -
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> -}
> -
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
>  int cper_severity_to_aer(int cper_severity)
>  {
> @@ -1295,7 +1283,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  			e_info.multi_error_valid = 1;
>  		else
>  			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>  
>  		if (find_source_device(pdev, &e_info))
>  			aer_process_err_devices(&e_info);
> @@ -1314,8 +1301,6 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>  		else
>  			e_info.multi_error_valid = 0;
>  
> -		aer_print_port_info(pdev, &e_info);
> -
>  		if (find_source_device(pdev, &e_info))
>  			aer_process_err_devices(&e_info);
>  	}
> 

-- 
 i.

