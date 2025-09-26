Return-Path: <linux-pci+bounces-37096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2DEBA3F1A
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 15:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0731624E38
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 13:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBBA1519A6;
	Fri, 26 Sep 2025 13:49:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8009D38DDB;
	Fri, 26 Sep 2025 13:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758894597; cv=none; b=ASPIEqSXWH7GFRryiFYtPtaGIUAf4fCXLKcIUDsXu2ahVhUT6f4js0p6tGTT7TUhKcuW5gabIfK9nvZCMICStjgYFgbwIFvn1ebN6bF8aAxNsoeNqZldk5l1NDT2gTZCG7Elcx0FsOWH6O9zGKQ93m8gunqOACQDpVWUzftRXAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758894597; c=relaxed/simple;
	bh=PwFJteLDyIOU4uIjRb3sENCpEjryKFC0ECy+IzyD6Bo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlHLgzoia3BPOEXGUHt1oO9AI4NJ5eTwZ7dfOKGEsiv4XTbsHC6gg8spdBkQhG4+MCAQyS8HQQrGbMcTHRNHQ9uYEpcAYAd+xehj8OHGXZAorY8mlhdzyopeOXVS4q09bK85ZYubtK9+bNBAC7Jxw6XDBVN01mxb0f5gw2U3mnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cYBjh72tTz6L535;
	Fri, 26 Sep 2025 21:47:52 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E79F514011A;
	Fri, 26 Sep 2025 21:49:51 +0800 (CST)
Received: from localhost (10.47.75.77) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Sep
 2025 14:49:50 +0100
Date: Fri, 26 Sep 2025 14:49:47 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>, "Alex Williamson"
	<alex.williamson@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>, Takashi
 Iwai <tiwai@suse.de>, Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "Dan Williams" <dan.j.williams@intel.com>
Subject: Re: [PATCH v1 2/3] PCI/sysfs: Use PM runtime class macro for auto
 cleanup in reset_method_store()
Message-ID: <20250926144947.00002f75@huawei.com>
In-Reply-To: <2245131.irdbgypaU6@rafael.j.wysocki>
References: <5049058.31r3eYUQgx@rafael.j.wysocki>
	<2245131.irdbgypaU6@rafael.j.wysocki>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 18:38:42 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> From: Takashi Iwai <tiwai@suse.de>
> 
> The newly introduced class macro can simplify the code.
> 
> Also, add the proper error handling for the PM runtime get.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> [ rjw: Adjust subject and error handling ]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/pci/pci-sysfs.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
>  		return count;
>  	}
>  
> -	pm_runtime_get_sync(dev);
> -	struct device *pmdev __free(pm_runtime_put) = dev;
> +	CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> +	if (IS_ERR(pmdev))
> +		return -ENXIO;
Hi Rafael,

Why this approach rather than treating runtime pm state like a conditional
lock (we use it much like one) and using ACQUIRE() / ACQUIRE_ERR()?

Ultimately that's a wrapper around the same infrastructure but
perhaps neater as it removes need to have that explicit magic pmdev.

+CC Dan as he can probably remember the discussions around ACQUIRE()
vs the way you have here better than I can.

In general great that you've done this.  Was on my list too, but I didn't
get around to actually spinning the patches!   This is going to be
very useful indeed.
 
Jonathan


>  
>  	if (sysfs_streq(buf, "default")) {
>  		pci_init_reset_methods(pdev);
> 
> 
> 
> 
> 


