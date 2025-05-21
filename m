Return-Path: <linux-pci+bounces-28178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF23ABEF79
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E0D3BF7AC
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB523C4F1;
	Wed, 21 May 2025 09:20:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170623D2A1;
	Wed, 21 May 2025 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747819250; cv=none; b=RCi5j8Ma8maFcMFfo9RYHqu/cDBKvtaepYW4LW0wiXu3K2vwgVrxS1Py4GyjXxLYUEnQctUH8prDh/gt6ZD2IlRGIEVmcWcJWrrXd7FyYhifXygieS638fHQzK/i8G7poi0uvSN5hLnMJgEhVKo8kZIsBnxKDlQ/BluG4vegThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747819250; c=relaxed/simple;
	bh=nhHBBZzFkwk0xr6cgUIFHE4SdJrJmeu6i70RAsXrpjY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjCd0ltCTjbS/GmUNQd7pYm20+ltRY4VqwVgs+4r9yeSarDsVFAXObyhDHWhT3YXvhX765b45yhk7nenN/iihrRiI8FcztCwnKTD3PIsjhQY0iWzbsy9FcALEexKcr7FxxEyhNdu4kKt1zKybcgt9GNrggGiZbwvr4nvlTNzeXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2QqW4CpMz6GDJ7;
	Wed, 21 May 2025 17:19:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E4251402C3;
	Wed, 21 May 2025 17:20:44 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 11:20:43 +0200
Date: Wed, 21 May 2025 10:20:41 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-pci@vger.kernel.org>, Jon Pan-Doh <pandoh@google.com>, "Karolina
 Stolarek" <karolina.stolarek@oracle.com>, Weinan Liu <wnliu@google.com>,
	Martin Petersen <martin.petersen@oracle.com>, Ben Fuller
	<ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, "Anil
 Agrawal" <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Sathyanarayanan
 Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, Lukas Wunner
	<lukas@wunner.de>, Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney"
	<paulmck@kernel.org>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver
 O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, Keith
 Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, "Terry Bowman"
	<terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, "Dave Jiang"
	<dave.jiang@intel.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 04/17] PCI/AER: Consolidate Error Source ID logging
 in aer_isr_one_error_type()
Message-ID: <20250521102041.00004901@huawei.com>
In-Reply-To: <20250520215047.1350603-5-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-5-helgaas@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 16:50:21 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Previously we decoded the AER Error Source ID in aer_isr_one_error_type(),
> then again in find_source_device() if we didn't find any devices with
> errors logged in their AER Capabilities.
> 
> Consolidate this so we only decode and log the Error Source ID once in
> aer_isr_one_error_type().  Add a "details" parameter so we can add a note
> when we didn't find any downstream devices with errors logged in their AER
> Capability.
> 
> This changes the dmesg logging when we found no devices with errors logged:
> 
>   - pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0
>   - pci 0000:00:01.0: AER: found no error details for 0000:02:00.0
>   + pci 0000:00:01.0: AER: Correctable error message received from 0000:02:00.0 (no details found)
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Nice little improvement.  I'll assume you reuse
details later as otherwise passing a bool and creating
the (no details found) in aer_print_port_info() would
have been simpler to my eyes as it would have put all the
string generation in one place.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/pcie/aer.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 568229288ca3..488a6408c7a8 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -733,16 +733,17 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
> -static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
> +static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info,
> +				const char *details)
>  {
>  	u8 bus = info->id >> 8;
>  	u8 devfn = info->id & 0xff;
>  
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d%s\n",
>  		 info->multi_error_valid ? "Multiple " : "",
>  		 aer_error_severity_string[info->severity],
>  		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +		 PCI_FUNC(devfn), details);
>  }
>  
>  #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -926,15 +927,8 @@ static bool find_source_device(struct pci_dev *parent,
>  	else
>  		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
>  
> -	if (!e_info->error_dev_num) {
> -		u8 bus = e_info->id >> 8;
> -		u8 devfn = e_info->id & 0xff;
> -
> -		pci_info(parent, "found no error details for %04x:%02x:%02x.%d\n",
> -			 pci_domain_nr(parent->bus), bus, PCI_SLOT(devfn),
> -			 PCI_FUNC(devfn));
> +	if (!e_info->error_dev_num)
>  		return false;
> -	}
>  	return true;
>  }
>  
> @@ -1281,9 +1275,11 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info)
>  static void aer_isr_one_error_type(struct pci_dev *root,
>  				   struct aer_err_info *info)
>  {
> -	aer_print_port_info(root, info);
> +	bool found;
>  
> -	if (find_source_device(root, info))
> +	found = find_source_device(root, info);
> +	aer_print_port_info(root, info, found ? "" : " (no details found");
> +	if (found)
>  		aer_process_err_devices(info);
>  }
>  


