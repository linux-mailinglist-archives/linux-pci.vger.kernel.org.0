Return-Path: <linux-pci+bounces-28205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6FBABF1A7
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E4E97B1256
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3525F7AC;
	Wed, 21 May 2025 10:31:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27781F869E;
	Wed, 21 May 2025 10:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747823489; cv=none; b=k8JioKK20k1WhaH4oP5EFhxxp4jKN4wCo3kNQVddWyzju5r1o9Zbd8IdMUSVDxZUK9ffbIicAjDcwKgxnGiUi1a4E5rmcTJp+jPUL591WLhtFJpv3tjW3k3vrauVe6VzS686S3NZG8E93+w+/W/UDqV09a7zpt3vm9hgOp3l5pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747823489; c=relaxed/simple;
	bh=yNefhY0Yb3i3XbOnbCmVwgsteNfUs7PGaKuiRFQbkFQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0y4evymDIMqwfIYz0AgNDWpnSGGX2Cio5SjnZ5dIy0doYZHUbgleL2jPuVMnqu8li5H10zlxbBvIl98RqQKfHxeusAZKw1P7k02RZuFuTb8GFy14elcYEcyW4dYWwoeGm/6Dug9focpSjuNQzYuKa2dilYO104RVw9yIkJP7Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4b2SP32hj5z6L54Y;
	Wed, 21 May 2025 18:30:31 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2C4961402FC;
	Wed, 21 May 2025 18:31:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 21 May
 2025 12:31:23 +0200
Date: Wed, 21 May 2025 11:31:21 +0100
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
Subject: Re: [PATCH v7 15/17] PCI/AER: Ratelimit correctable and non-fatal
 error logging
Message-ID: <20250521113121.000067ce@huawei.com>
In-Reply-To: <20250520215047.1350603-16-helgaas@kernel.org>
References: <20250520215047.1350603-1-helgaas@kernel.org>
	<20250520215047.1350603-16-helgaas@kernel.org>
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
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 20 May 2025 16:50:32 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> From: Jon Pan-Doh <pandoh@google.com>
> 
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and non-fatal
> uncorrectable errors that use the kernel defaults (10 per 5s).  Logging of
> fatal errors is not ratelimited.

See below. I'm not sure that logging of fatal error should affect the rate
for non fatal errors + the rate limit infrastructure kind of assumes
that you only call it if you are planning to respect it's decision.

Given overall aim is to restrict rates, maybe we don't care if we sometimes
throttle earlier that we might expect with a simpler separation of what
is being limited.

I don't mind strongly either way.

> 
> There are two AER logging entry points:
> 
>   - aer_print_error() is used by DPC and native AER
> 
>   - pci_print_aer() is used by GHES and CXL
> 
> The native AER aer_print_error() case includes a loop that may log details
> from multiple devices.  This is ratelimited such that we log all the
> details we find if any of the devices has not hit the ratelimit.  If no
> such device details are found, we still log the Error Source from the ERR_*
> Message, ratelimited by the Root Port or RCEC that received it.
> 
> The DPC aer_print_error() case is not ratelimited, since this only happens
> for fatal errors.
> 
> The CXL pci_print_aer() case is ratelimited by the Error Source device.
> 
> The GHES pci_print_aer() case is via aer_recover_work_func(), which
> searches for the Error Source device.  If the device is not found, there's
> no per-device ratelimit, so we use a system-wide ratelimit that covers all
> error types (correctable, non-fatal, and fatal).
> 
> Sargun at Meta reported internally that a flood of AER errors causes RCU
> CPU stall warnings and CSD-lock warnings.
> 
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
> 
> [bhelgaas: commit log, factor out trace_aer_event() and aer_print_rp_info()
> changes to previous patches, collect single aer_err_info.ratelimit as union
> of ratelimits of all error source devices, don't ratelimit fatal errors,
> "aer_report" -> "aer_info"]
> Reported-by: Sargun Dhillon <sargun@meta.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.h      |  3 +-
>  drivers/pci/pcie/aer.c | 66 ++++++++++++++++++++++++++++++++++++++----
>  drivers/pci/pcie/dpc.c |  1 +
>  3 files changed, 64 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 705f9ef58acc..65c466279ade 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -593,7 +593,8 @@ struct aer_err_info {
>  	unsigned int id:16;
>  
>  	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int __pad1:5;
> +	unsigned int ratelimit:1;	/* 0=skip, 1=print */

That naming is less than intuitive.  Maybe expand it to ratelimit_print or
something like that.

> +	unsigned int __pad1:4;
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4f1bff0f000f..f9e684ac7878 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

> @@ -815,8 +843,19 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   */
>  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  {
> +	/*
> +	 * Ratelimit AER log messages.  "dev" is either the source
> +	 * identified by the root's Error Source ID or it has an unmasked
> +	 * error logged in its own AER Capability.  If any of these devices
> +	 * has not reached its ratelimit, log messages for all of them.
> +	 * Messages are emitted when "e_info->ratelimit" is non-zero.
> +	 *
> +	 * Note that "e_info->ratelimit" was already initialized to 1 for the
> +	 * ERR_FATAL case.
> +	 */
>  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> +		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);

So this is a little odd.  I think it works but there is code inside __ratelimit
that I think we should not be calling for that ERROR_FATAL case
(whether we should call lots of times for each device isn't obvious either
 but maybe that is more valid).

In the event of it already being 1 due to ERROR_FATAL you will falsely trigger
a potential print from inside __ratelimit() if we were rate limited and no
longer are but only skipped FATAL prints.  My concern is that function
is kind of assuming it's only called in cases where a rate limit decision
is being made and the implementation may change in future).

https://elixir.bootlin.com/linux/v6.14.7/source/lib/ratelimit.c#L56

Maybe, 
		if (!info->ratelimit)
			e_info->ratelimit = aer_ratelimit(dev, e_info->severity);
is an alternative option.
That allows a multiplication factor on the rate as all device count for 1.
 



>  		e_info->error_dev_num++;
>  		return 0;
>  	}
> @@ -914,7 +953,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>   * e_info->error_dev_num and e_info->dev[], based on the given information.
>   */
>  static bool find_source_device(struct pci_dev *parent,
> -		struct aer_err_info *e_info)
> +			       struct aer_err_info *e_info)
Unrelated change

>  {
>  	struct pci_dev *dev = parent;
>  	int result;

>  			pci_aer_clear_fatal_status(pdev);


