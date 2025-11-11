Return-Path: <linux-pci+bounces-40924-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02454C4ED3A
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 16:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C1D189A8A2
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD13B365A14;
	Tue, 11 Nov 2025 15:42:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92372D9ECB;
	Tue, 11 Nov 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762875747; cv=none; b=k60UxSfY+Y1BlVRq9Sj12hmwlymKUUlMHyF1EPX93oXStj+xEH1T3tEA/7uLrI9Su7UgtEw0/AYsT/yUsmItzJZ2TkKBQAvvyvr79WQrxfvw0qFpLmYgGKhfZZ6WfCf9StgeUxHVmPi1qC3FQN59MVkI8XKgyhMc36GochIRjnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762875747; c=relaxed/simple;
	bh=muKpuY3byqNcRWxxaSgz9NQv7RUetjOa8lPW7ELfWGU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIa0MLfvY8+cnRFf8zBCzqR9GodaV0N4GoRycaVAU/ZRdXA2BxqWjnpD6d+NZToWTyIVaPYcTbkZ98BDaWV7O6Hf5oXflewRYB8IgbXP+BEV6vJubffhX4Hi0jLW+Hat3mKe6mRHjgiHgX0iR5DkMvGcFhxIbBGdw3y+yQmP2TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d5W4F1G38zHnGgv;
	Tue, 11 Nov 2025 23:42:05 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E6F31400D9;
	Tue, 11 Nov 2025 23:42:22 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 11 Nov
 2025 15:42:21 +0000
Date: Tue, 11 Nov 2025 15:42:20 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	"Len Brown" <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, Borislav
 Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, Mauro Carvalho
 Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>,
	"Davidlohr Bueso" <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	"Alison Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/6 v7] acpi/ghes: Make GHES select ACPI_APEI_PCIEAER
Message-ID: <20251111154220.00004767@huawei.com>
In-Reply-To: <20251104182446.863422-4-fabio.m.de.francesco@linux.intel.com>
References: <20251104182446.863422-1-fabio.m.de.francesco@linux.intel.com>
	<20251104182446.863422-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  4 Nov 2025 19:22:34 +0100
"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com> wrote:

> GHES handles the PCI Express Error Section and also the Compute Express
> Link (CXL) Protocol Error Section. Two of its functions depend on the
> APEI PCIe AER logging/recovering support (ACPI_APEI_PCIEAER).
> 
> Make GHES select ACPI_APEI_PCIEAER and remove the conditional
> compilation from the body of two static functions that handle the CPER
> Error Sections mentioned above.

Hi Fabio,

I'm not seeing a justification here for the change and there may be
APEI platforms without PCI support.  So is this just to simplify things or
is there a functional reason that it is necessary?

Jonathan

> 
> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> ---
>  drivers/acpi/apei/Kconfig | 2 ++
>  drivers/acpi/apei/ghes.c  | 4 ----
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 070c07d68dfb..cdf3cfa233b9 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -23,6 +23,8 @@ config ACPI_APEI_GHES
>  	select ACPI_HED
>  	select IRQ_WORK
>  	select GENERIC_ALLOCATOR
> +	select PCIEAER
> +	select ACPI_APEI_PCIEAER
>  	select ARM_SDE_INTERFACE if ARM64
>  	help
>  	  Generic Hardware Error Source provides a way to report
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 97ee19f2cae0..d6fe5f020e96 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -613,7 +613,6 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
>   */
>  static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  {
> -#ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cper_sec_pcie *pcie_err = acpi_hest_get_payload(gdata);
>  
>  	if (pcie_err->validation_bits & CPER_PCIE_VALID_DEVICE_ID &&
> @@ -646,7 +645,6 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
>  				  (struct aer_capability_regs *)
>  				  aer_info);
>  	}
> -#endif
>  }
>  
>  static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
> @@ -711,7 +709,6 @@ struct work_struct *cxl_cper_prot_err_work;
>  static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  				   int severity)
>  {
> -#ifdef CONFIG_ACPI_APEI_PCIEAER
>  	struct cxl_cper_prot_err_work_data wd;
>  	u8 *dvsec_start, *cap_start;
>  
> @@ -767,7 +764,6 @@ static void cxl_cper_post_prot_err(struct cxl_cper_sec_prot_err *prot_err,
>  	}
>  
>  	schedule_work(cxl_cper_prot_err_work);
> -#endif
>  }
>  
>  int cxl_cper_register_prot_err_work(struct work_struct *work)


