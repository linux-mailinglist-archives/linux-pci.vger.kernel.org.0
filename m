Return-Path: <linux-pci+bounces-11877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E59AF95853F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 12:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252EC1C2422A
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2024 10:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0C18DF9F;
	Tue, 20 Aug 2024 10:53:30 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF618E033
	for <linux-pci@vger.kernel.org>; Tue, 20 Aug 2024 10:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724151210; cv=none; b=nqQcOTkdhy2TjN97+29nWPuFPvXfDnB+S4XnTHBV7xNXh3xWEYtJUZ4ucP4Bomivmg+YIQ478p8roUhXiZCioXGKvzZzFFyCcbb3obinT2oUjHvnlWMpyNf/Ay0ZfSMxDb/KdRVk6fJk09VLjC5zRVGY9EwPtPDCF8Q+jg9B9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724151210; c=relaxed/simple;
	bh=shDP66lodSzjlOjkZRdg2/Mz/cp4ItbtMcIHqaeJch0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JXq79ZCbisZGUV4/N+eVdLROK5hGNyajzSFooaNqhe2WjYXAejZ2H66aMBLyEn7XbTeZEmhG70W2vtV3q0ppBj8PbGe2Fa6SRH/s5A0+nwoLw6q84TmlSybjo/r4jszze+Hmb/iMWvBGhoncydOXMbVCKscb9DcZERhDFfNEtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wp5ng2JN0z6FGtl;
	Tue, 20 Aug 2024 18:49:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 89680140CB9;
	Tue, 20 Aug 2024 18:53:18 +0800 (CST)
Received: from localhost (10.122.19.247) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 20 Aug
 2024 11:53:18 +0100
Date: Thu, 15 Aug 2024 15:36:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Keith Busch <kbusch@meta.com>
CC: <linux-pci@vger.kernel.org>, <bhelgaas@google.com>, <lukas@wunner.de>,
	<mika.westerberg@linux.intel.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH RFC 5/8] pci: unexport pci_walk_bus_locked
Message-ID: <20240815153658.000036cf@Huawei.com>
In-Reply-To: <20240722151936.1452299-6-kbusch@meta.com>
References: <20240722151936.1452299-1-kbusch@meta.com>
	<20240722151936.1452299-6-kbusch@meta.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 22 Jul 2024 08:19:33 -0700
Keith Busch <kbusch@meta.com> wrote:

> From: Keith Busch <kbusch@kernel.org>
> 
> There's only one user of this, and it's internal, so no need to export
> it.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Maybe Bjorn can queue a few of these cleanups to reduce the scope
of future versions of this to just the more complex patches?

Jonathan

> ---
>  drivers/pci/bus.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index b7208e644c79f..638e79d10bfab 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -435,7 +435,6 @@ void pci_walk_bus_locked(struct pci_bus *top, int (*cb)(struct pci_dev *, void *
>  
>  	__pci_walk_bus(top, cb, userdata);
>  }
> -EXPORT_SYMBOL_GPL(pci_walk_bus_locked);
>  
>  struct pci_bus *pci_bus_get(struct pci_bus *bus)
>  {


