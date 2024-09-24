Return-Path: <linux-pci+bounces-13445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15270984841
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF171C20BCC
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 15:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2E1AB6C6;
	Tue, 24 Sep 2024 15:08:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8D155757;
	Tue, 24 Sep 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727190515; cv=none; b=ZCgR+/tMoyTM7AzdUpplCFF030k1YBaQimUwz7vtsQIn9fbz5UkayD8VKijzKsSw6ZrSOtyusZ1fwEHMiRt87QUzvM1jhVzlNv5yHAZXM49S/8deZfcVSYjCfrPY4hLSg//nv1+A2pG+s81spQrN4w6/HetSFKZYsTX4J6KTaO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727190515; c=relaxed/simple;
	bh=bJl4aHDHHFVlpUdXXtylYpC5cGHghAmoBWgZNKJcXlM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdMJX8su+1mqu48iXg/wuUoo27DHHGjgSbFvFDqFNdIz9pSBhqfd3SgiPSNIkTswD8BU8CWgdTeB8mXhawW26Jm2SmPdjr1e+BfvsWqvxSdE56NGI1YMQBtZhgGQhFiSvu3smqEhWtsPTSjkU0ft/XlnVUmpZ9lcifz9EBYaK4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XCjnX3Sz2z6DB8S;
	Tue, 24 Sep 2024 23:04:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 20AF9140B39;
	Tue, 24 Sep 2024 23:08:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 24 Sep
 2024 17:08:28 +0200
Date: Tue, 24 Sep 2024 16:08:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<manivannan.sadhasivam@linaro.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <sumanesh.samanta@broadcom.com>,
	<sathya.prakash@broadcom.com>, <sjeaugey@nvidia.com>
Subject: Re: [PATCH 2/2 v2] PCI/P2PDMA: Modify p2p_dma_distance to detect
 P2P links
Message-ID: <20240924160827.000049dd@Huawei.com>
In-Reply-To: <1726733624-2142-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1726733624-2142-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
	<1726733624-2142-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 19 Sep 2024 01:13:44 -0700
Shivasharan S <shivasharan.srikanteshwara@broadcom.com> wrote:

> Update the p2p_dma_distance() to determine inter-switch P2P links existing
> between two switches and use this to calculate the DMA distance between
> two devices.
> 
> Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> ---
>  drivers/pci/p2pdma.c       | 17 ++++++++++++++++-
>  drivers/pci/pcie/portdrv.c | 34 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h |  2 ++
>  3 files changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13cb500..eed3b69e7293 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -21,6 +21,8 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> +extern bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b);

That's nasty.  Include the header so you get a clean stub if
this support is not built in etc.

> +

> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index c940b4b242fd..2fe1598fc684 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -104,6 +104,40 @@ static bool pcie_port_is_p2p_supported(struct pci_dev *dev)
>  	return false;
>  }
>  
> +/**
> + * pcie_port_is_p2p_link_available: Determine if a P2P link is available
> + * between the two upstream bridges. The serial number of the two devices
> + * will be compared and if they are same then it is considered that the P2P
> + * link is available.
> + *
> + * Return value: true if inter switch P2P is available, return false otherwise.
> + */
> +bool pcie_port_is_p2p_link_available(struct pci_dev *a, struct pci_dev *b)
> +{
> +	u64 dsn_a, dsn_b;
> +
> +	/*
> +	 * Check if the devices support Inter switch P2P.
> +	 */

Single line comment syntax fine here.  However it's kind
of obvious, so I'd just drop the comment.


> +	if (!pcie_port_is_p2p_supported(a) ||
> +	    !pcie_port_is_p2p_supported(b))

Don't wrap this. I think it's under 80 chars anyway.

> +		return false;
> +
> +	dsn_a = pci_get_dsn(a);
> +	if (!dsn_a)
> +		return false;
If we assume that dsn is the only right way to detect this
(I'm fine with that for now) then we know the supported tests
above would only pass if this is true. Hence

return pci_get_dsn(a) == pci_get_dsn(b);

should be fine.

> +
> +	dsn_b = pci_get_dsn(b);
> +	if (!dsn_b)
> +		return false;
> +
> +	if (dsn_a == dsn_b)
> +		return true;

	return dsn_a == dsn_b;

> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(pcie_port_is_p2p_link_available);
> +
>  /*
>   * Traverse list of all PCI bridges and find devices that support Inter switch P2P
>   * and have the same serial number to create report the BDF over sysfs.



