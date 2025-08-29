Return-Path: <linux-pci+bounces-35124-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA55B3BF22
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 17:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E28AB1717C5
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56414320CC0;
	Fri, 29 Aug 2025 15:25:07 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72F12765D7;
	Fri, 29 Aug 2025 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756481107; cv=none; b=VhAn8J+iVhuvqfqZQOBKBkOYQB3lanL96YuTAYSuqXcpeIFbuFoYfBWYXsmj5g6LpfyuWvGsUqWvXOQtUGQ9LLmuN97rSuF3KJeGHIUpVgItBWzxKyEHRHSOW+LOPUFru+EljAzcQhj14CCAg5GR3A6YVjLAag+SV2La6tFe/o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756481107; c=relaxed/simple;
	bh=gpHaAoHZraDITaWelBYaFP3UvoJmpw2DrTmywlTnVCc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIKAEo7h9V6/3DgYa8lHnINtI/4hTwDpCl0a9/fgqcP2hW67CFL1giIdI9T8yx/lG59trgcEh34/mfZarF/niCPUTBeHArm780BnO6ElaZarby5uE4/9F5BACq5Tj6AI9QQqdI7Gwhv6AmqNql1oitBTe6kZ2DB5ERyyx8aSNYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cD29z2z6Sz6K8r4;
	Fri, 29 Aug 2025 23:24:23 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 35C8F140370;
	Fri, 29 Aug 2025 23:25:02 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 29 Aug
 2025 17:25:01 +0200
Date: Fri, 29 Aug 2025 16:24:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v11 02/23] CXL/AER: Remove CONFIG_PCIEAER_CXL and
 replace with CONFIG_CXL_RAS
Message-ID: <20250829162459.00007ca9@huawei.com>
In-Reply-To: <20250827013539.903682-3-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-3-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:17 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL RAS compilation is enabled using CONFIG_CXL_RAS while the AER CXL logic
> uses CONFIG_PCIEAER_CXL. The 2 share the same dependencies and can be
> combined. The 2 kernel configs are unnecessary and are problematic for the
> user because of the duplication. Replace occurrences of CONFIG_PCIEAER_CXL
> to be CONFIG_CXL_RAS.
> 
> Update the CONFIG_CXL_RAS Kconfig definition to include dependencies 'PCIEAER
> && CXL_PCI' taken from the CONFIG_PCIEAER_CXL definition.
> 
> Remove the Kconfig CONFIG_PCIEAER_CXL definition.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Bjorn, do you mind having some code in PCIE land built depending on 
a config symbol from drivers/cxl?  Alternative to this would be to remove
the visible symbol (drop text after bool) and select it from
the CONFIG_CXL_RAS entry. 

> 
> ---
> Changes in v10 -> v11:
> - New patch
> ---
>  drivers/pci/pcie/Kconfig | 9 ---------
>  drivers/pci/pcie/aer.c   | 2 +-
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 17919b99fa66..207c2deae35f 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -49,15 +49,6 @@ config PCIEAER_INJECT
>  	  gotten from:
>  	     https://github.com/intel/aer-inject.git
>  
> -config PCIEAER_CXL
> -	bool "PCI Express CXL RAS support"
> -	default y
> -	depends on PCIEAER && CXL_PCI
> -	help
> -	  Enables CXL error handling.
> -
> -	  If unsure, say Y.
> -
>  #
>  # PCI Express ECRC
>  #
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..7fe9f883f5c5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1086,7 +1086,7 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> +#ifdef CONFIG_CXL_RAS
>  
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors


