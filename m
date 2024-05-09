Return-Path: <linux-pci+bounces-7288-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EF28C0E99
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 12:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9073C1F21765
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2024 10:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83512FF71;
	Thu,  9 May 2024 10:57:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2368112EBC8;
	Thu,  9 May 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715252277; cv=none; b=rNKEdz6+A4ZoUkr7RCLgSjoa11vAqQfB4gmSqUxRlsKb3Ki2qd7Ml6CIRB3y5WTAFe1K+p7oMoUp0/9OyUnz2+W/143cTlNoT9pBdoRDrgK1hkB2wE4I+1nQCKGxqr31XTKMUB6ANf51qE2PPdZ7xFbU4nOrO4fwnijOYjxmb/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715252277; c=relaxed/simple;
	bh=9zBnXIOJ4g31aUy09rmkWoSTOzhGnZNoRO+xhbjZ19I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TUDjxxt89C5P23ub7qSUkFpVx/Iy9L6ztj7XljpaF9sFEgfck40vE/U3FVSuuas2B3SVzDHTn3MZ3fvFnLhTzKAFtlISuYqhF9YW923g5NOJkCBhESL5KQjfSnT3nOeM6oTnUG5oPNb1CLTd2QLx3XJ9eHk5g1jUWKK6WCC99Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VZpmy6Qq3z6J6Mk;
	Thu,  9 May 2024 18:54:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 786601400D9;
	Thu,  9 May 2024 18:57:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 9 May
 2024 11:57:51 +0100
Date: Thu, 9 May 2024 11:57:50 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <linux@treblig.org>
CC: <bhelgaas@google.com>, <rafael@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: PCI: Remove unused struct 'acpi_handle_node'
Message-ID: <20240509115750.000078ad@Huawei.com>
In-Reply-To: <20240509000858.204114-1-linux@treblig.org>
References: <20240509000858.204114-1-linux@treblig.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu,  9 May 2024 01:08:58 +0100
linux@treblig.org wrote:

> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'acpi_handle_node' is unused since
> Commit 63f534b8bad9 ("ACPI: PCI: Rework acpi_get_pci_dev()")
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

FWIW, indeed unused.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/acpi/pci_root.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 58b89b8d950ed..59e6955e24edb 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -293,11 +293,6 @@ struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
>  }
>  EXPORT_SYMBOL_GPL(acpi_pci_find_root);
>  
> -struct acpi_handle_node {
> -	struct list_head node;
> -	acpi_handle handle;
> -};
> -
>  /**
>   * acpi_get_pci_dev - convert ACPI CA handle to struct pci_dev
>   * @handle: the handle in question


