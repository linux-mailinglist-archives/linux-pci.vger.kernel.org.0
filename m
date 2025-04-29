Return-Path: <linux-pci+bounces-27007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 910E6AA0D5A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 15:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E5721885C39
	for <lists+linux-pci@lfdr.de>; Tue, 29 Apr 2025 13:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0B1E89C;
	Tue, 29 Apr 2025 13:20:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969462BE7C0;
	Tue, 29 Apr 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745932830; cv=none; b=eHudDpfwlTgGCqAh7zHUIJw6KKcSeZiUYDIDJlo4rP43IlbnKYaqj3vHYR3VwFlZ5vwXspoIGextJp+lGeG98v/qyn7zoAeEn3Zo8iou9w7JzOtKo1hHnP2ORvZPwLcZVj57TcgwDp7bvYwAg1WV6hILqPNbdHfja/joBAnHeMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745932830; c=relaxed/simple;
	bh=+ddzy9jCYjhQes9mHraU7a+/SWmYuS3TBFPtlx+VGto=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6qbVHnVjZArP3WjS2a1FSHML8qby1UjkahEBF9eFQALaZZ5iQ6F2VtmWh+IeO8tbjr7MxGIN2UisQsQerLNkR5VIc8uPaCA5du0XStZPBX7GyxIe6i0dmo1R79K8kmLvte2S+uutgBzG6APLqpMSvtJE7V3U/s2uQo6Xcux0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zn18s5K5Jz6L5Wb;
	Tue, 29 Apr 2025 21:18:21 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D9D9114064C;
	Tue, 29 Apr 2025 21:20:23 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Apr
 2025 15:20:23 +0200
Date: Tue, 29 Apr 2025 14:20:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Zhe Qiao <qiaozhe@iscas.ac.cn>
CC: <rafael@kernel.org>, <lenb@kernel.org>, <bhelgaas@google.com>,
	<will@kernel.org>, <sunilvl@ventanamicro.com>, <linux-acpi@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ACPI: PCI: Release excess memory usage.
Message-ID: <20250429142022.00003460@huawei.com>
In-Reply-To: <20250429091051.249911-1-qiaozhe@iscas.ac.cn>
References: <20250429091051.249911-1-qiaozhe@iscas.ac.cn>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 29 Apr 2025 17:10:51 +0800
Zhe Qiao <qiaozhe@iscas.ac.cn> wrote:

> In the pci_acpi_scan_root() function, if the PCI bus creation failed,
> the allocated memory should be released to avoid memory occupation.
> 
> Fixes: 789befdfa389 ("arm64: PCI: Migrate ACPI related functions to pci-acpi.c")
> Signed-off-by: Zhe Qiao <qiaozhe@iscas.ac.cn>
> 
> ---
> V1 -> V2:
> Modified labels for better readability.
> 
> ---
>  drivers/pci/pci-acpi.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..bde104ecac80 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1677,15 +1677,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  
>  	root_ops = kzalloc(sizeof(*root_ops), GFP_KERNEL);
>  	if (!root_ops) {
> -		kfree(ri);
> -		return NULL;
> +		goto free_ri;
>  	}
>  
>  	ri->cfg = pci_acpi_setup_ecam_mapping(root);
>  	if (!ri->cfg) {
> -		kfree(ri);
> -		kfree(root_ops);
> -		return NULL;
> +		goto free_root_ops;
>  	}
>  
>  	root_ops->release_info = pci_acpi_generic_release_info;
> @@ -1693,7 +1690,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	root_ops->pci_ops = (struct pci_ops *)&ri->cfg->ops->pci_ops;
>  	bus = acpi_pci_root_create(root, root_ops, &ri->common, ri->cfg);
>  	if (!bus)
> -		return NULL;

Do we also need to tear down the ecam mapping done in pci_acpi_setup_ecam_mapping()?
Might just be pci_ecam_free(ri->cfg);


> +		goto free_root_ops;
>  
>  	/* If we must preserve the resource configuration, claim now */
>  	host = pci_find_host_bridge(bus);
> @@ -1710,6 +1707,12 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  		pcie_bus_configure_settings(child);
>  
>  	return bus;
> +
> +free_root_ops:
> +	kfree(root_ops);
> +free_ri:
> +	kfree(ri);
> +	return NULL;
>  }
>  
>  void pcibios_add_bus(struct pci_bus *bus)


