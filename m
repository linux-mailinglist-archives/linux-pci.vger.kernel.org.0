Return-Path: <linux-pci+bounces-19218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C160A00883
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 12:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5203A466E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334F1CDFD3;
	Fri,  3 Jan 2025 11:17:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1A91F9EBB;
	Fri,  3 Jan 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903060; cv=none; b=GeJcq3ALpIC22MB/uJ3c6JL434RwroC1tms96yCtUU9isTH8iWoXSN7afZzIgmwD/69iHHVqpfI0lUHZwWvQv7YLa+5SnVRR+SE0qs2QAVoqeSpYZZ3FlBg4ufAyMW9QgXEKkdhc32c048G2XpFDVTI3n7YnXmbkr23b7Vh7xjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903060; c=relaxed/simple;
	bh=9lviS43MPi4ucwnHexqDaQcmac898j+lOZHDzd9BC64=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBKeDQXf4+VrK7D0KxA0mrOT0TjEK5Pi34TTR2HZ7EyO5xAaN6L+IhTWxKA8deWQwbpuGs8RW7E+gbi2na4c3sgFfKsdDqdYxSU90pHa2ufRpoFqHoJ1H+n5GVGVE97TM+ACkIlVupTLUDvw+fhPH2JteaPpgAdvsmNMr8NARak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPgxM1w8zz6M4KP;
	Fri,  3 Jan 2025 19:16:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6F8691406AC;
	Fri,  3 Jan 2025 19:17:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 12:17:34 +0100
Date: Fri, 3 Jan 2025 11:17:32 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Atharva Tiwari <evepolonium@gmail.com>
CC: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran
	<oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/AER:Add error message when unable to handle
 additional devices
Message-ID: <20250103111732.00003ab3@huawei.com>
In-Reply-To: <20241227071910.1719-1-evepolonium@gmail.com>
References: <20241227071910.1719-1-evepolonium@gmail.com>
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

On Fri, 27 Dec 2024 12:49:10 +0530
Atharva Tiwari <evepolonium@gmail.com> wrote:

> Log an error message in `find_device_iter'
> when the system cannot handle more error devices.
Needs a statement of 'why'

Jonathan

> 
> Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
> ---
>  drivers/pci/pcie/aer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 34ce9f834d0c..04743617202e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -886,7 +886,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>  		/* List this device */
>  		if (add_error_device(e_info, dev)) {
>  			/* We cannot handle more... Stop iteration */
> -			/* TODO: Should print error message here? */
> +			pr_err("PCI: Unable to handle additional error devices\n");
>  			return 1;
>  		}
>  


