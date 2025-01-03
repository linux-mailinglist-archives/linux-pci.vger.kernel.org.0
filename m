Return-Path: <linux-pci+bounces-19217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B52EA0087A
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 12:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C9B16440B
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 11:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0671F9F4B;
	Fri,  3 Jan 2025 11:16:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D788C1F9ABC;
	Fri,  3 Jan 2025 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903019; cv=none; b=oj4seAke9SJYQxl6QdgBoHrMugpZzkVX8DT135f/JvYF/Tq7WU55rhPZQmELS3POu7QEvgRUqm3SCaTj7OfGwkzPlFLbo0sOhPhu3Aq1B2FdX3rGahWZta3ExOOD2tySqkK1xRivneTvkzQcLoCrMWOlx2ksLWqRpEtxW+e7070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903019; c=relaxed/simple;
	bh=/hvtFIoK2qgtL9r1xnJahwLRHIH9NaLph7TIvsrFzgA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m1YVVgtT2mLHR1EElz61NSBL2iPTFdqZlRbuVtybQ5DrslCD5pKLoZ5xI8yFfctMnZk1pTclHVN9lBz4mxbrBslDYwpLqUUurThMiB1ZeidAN+1JbTXros9j0Ac5t/Mutx3hfNiwcdmXyGf4lcZjBx77B8WUX/lKddS5Dp6M5mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPgxF4ty1z6K6JG;
	Fri,  3 Jan 2025 19:16:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 60554140C72;
	Fri,  3 Jan 2025 19:16:53 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 3 Jan
 2025 12:16:52 +0100
Date: Fri, 3 Jan 2025 11:16:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Atharva Tiwari <evepolonium@gmail.com>
CC: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Oliver O'Halloran
	<oohall@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/ERR: use panic instead pci_info for device recovery
 failure in PCIe
Message-ID: <20250103111651.00007c57@huawei.com>
In-Reply-To: <20241227065253.72323-1-evepolonium@gmail.com>
References: <20241227065253.72323-1-evepolonium@gmail.com>
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

On Fri, 27 Dec 2024 12:22:53 +0530
Atharva Tiwari <evepolonium@gmail.com> wrote:

> update failed in drivers/pci/pcie/err.c to 
> trigger a kernel panic instead of pci_info
> 
> Thanks
Rewrite message as described in submitting patches documentation.

Key thing here is question of 'why?'
A question was in that comment, what is your reasoning for panic being the
correct choice?

Jonathan

> 
> Signed-off-by: Atharva Tiwari <evepolonium@gmail.com>
> ---
>  drivers/pci/pcie/err.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 31090770fffc..2630b88564d8 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -271,8 +271,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>  
>  	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
>  
> -	/* TODO: Should kernel panic here? */
> -	pci_info(bridge, "device recovery failed\n");
> +
> +	panic("Kernel Panic: %s: Device recovery failed\n", pci_name(bridge));
>  
>  	return status;
>  }


