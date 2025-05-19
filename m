Return-Path: <linux-pci+bounces-27975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A447ABBEA2
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 15:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ADED179CF4
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE22B279799;
	Mon, 19 May 2025 13:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nCId4YK7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8E279787;
	Mon, 19 May 2025 13:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660182; cv=none; b=fJtRgeKqLCW2LmXVbJZ+jxYusipS8xqjI5wHoOUGj99rYAZ2VxPQKzK7jyzgT+cj5apSXxHnt87QCRyWDUWxdxCBQgW5+thMU/CzTFOy4E6QFbQ5a7IgYo3TbgS45DK963i+cGbJnKg3hNi6VNoLXSMbZvBPUUwT66kRU10Ypx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660182; c=relaxed/simple;
	bh=XkpJ6tPlbFlgCwUloxB4+DSdIpU5E6VB27qBjkhOUZY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=L4C3n48eX6f4AYIcs74HKKnLgb7VJFl+WKN1bsr7mOoY0gFaIRQTVtHRekBhGBXKVccyKtDaV40mFkNQuz4UXwHeK+VRQLhplUR7yASAQpflEWheTnSSwJLxp73XXgju02jvdaPPd3LkKZ3F4p5Pp8TFwNF84oFjuX2bJ/NGV6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nCId4YK7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747660181; x=1779196181;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=XkpJ6tPlbFlgCwUloxB4+DSdIpU5E6VB27qBjkhOUZY=;
  b=nCId4YK7/MDDVzX7wFmoDPGqTLuSnz9qgVi0hI0CcWZfnxmGQ7EP812M
   9Y0tDNZw2w+/jXN7PYYy+FPzFd3fgyxUjACax3f7rAmFQAfyDlIbcDBB5
   vpHIvP/0LqgPxmAPSEt9ZZ4Sku3cvrYN4l24ftBeT1YMEzw22y9PtVNCy
   kU9jW5+i0qgff0MwR/yQtyfWWV4+1M9m17vClvinZYyhOHedTosVvRGmW
   S0VWRb0bd2DvQYYdvsffa7xf/ho4khzTaIfdtW6YQhpDyDx9cOC4FZKx6
   jHMXOgWUJIG15xCm1kxZl5TRgRvvyz26+1tMRl7c/Shybyg56LzoNi037
   A==;
X-CSE-ConnectionGUID: sCPLbqiiSXKm+JCvX/Ed/w==
X-CSE-MsgGUID: qB6hA4C7Q36lJEYNSOjMIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49461251"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="49461251"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:09:40 -0700
X-CSE-ConnectionGUID: i7eVy+IHQsae7CF1FyJ1Zg==
X-CSE-MsgGUID: dqBI7AaxQyeWNq1kumUO4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="170396769"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.35])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 06:09:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 19 May 2025 16:09:30 +0300 (EEST)
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
    Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
    Lorenzo Pieralisi <lpieralisi@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Rob Herring <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
    Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
    linux-wireless@vger.kernel.org, ath11k@lists.infradead.org, 
    qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
    quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
    Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3 01/11] PCI: Update current bus speed as part of
 pci_pwrctrl_notify()
In-Reply-To: <20250519-mhi_bw_up-v3-1-3acd4a17bbb5@oss.qualcomm.com>
Message-ID: <10de35f5-bec6-5df3-768d-04f88c4e3d77@linux.intel.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com> <20250519-mhi_bw_up-v3-1-3acd4a17bbb5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 May 2025, Krishna Chaitanya Chundru wrote:

> If the link is not up till the pwrctl drivers enable power to endpoints
> then cur_bus_speed will not be updated with correct speed.
> 
> As part of rescan, pci_pwrctrl_notify() will be called when new devices
> are added and as part of it update the link bus speed.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/pwrctrl/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pwrctrl/core.c b/drivers/pci/pwrctrl/core.c
> index 9cc7e2b7f2b5608ee67c838b6500b2ae4a07ad52..034f0a5d7868fe956e3fc6a9b7ed485bb69caa04 100644
> --- a/drivers/pci/pwrctrl/core.c
> +++ b/drivers/pci/pwrctrl/core.c
> @@ -10,16 +10,21 @@
>  #include <linux/pci-pwrctrl.h>
>  #include <linux/property.h>
>  #include <linux/slab.h>
> +#include "../pci.h"
>  
>  static int pci_pwrctrl_notify(struct notifier_block *nb, unsigned long action,
>  			      void *data)
>  {
>  	struct pci_pwrctrl *pwrctrl = container_of(nb, struct pci_pwrctrl, nb);
>  	struct device *dev = data;
> +	struct pci_bus *bus = to_pci_dev(dev)->bus;
>  
>  	if (dev_fwnode(dev) != dev_fwnode(pwrctrl->dev))
>  		return NOTIFY_DONE;
>  
> +	if (bus->self)
> +		pcie_update_link_speed((struct pci_bus *)bus);

Why are you casting here?? (Perhaps it's a leftover).

> +
>  	switch (action) {
>  	case BUS_NOTIFY_ADD_DEVICE:
>  		/*
> 
> 

-- 
 i.


