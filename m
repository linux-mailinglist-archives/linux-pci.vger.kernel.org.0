Return-Path: <linux-pci+bounces-29534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBD2AD6E8C
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D8C170A04
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 11:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BB234971;
	Thu, 12 Jun 2025 11:04:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44F323C4E9;
	Thu, 12 Jun 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749726285; cv=none; b=h6hpbYDafjRpDqo5ZUg5q7uAlo0sics3HNf/sVkyQmY0CwjeDsaC+BQsvbiWc06YTql+I8OJf3NIkrDIU4Q1Xq4CSsawoBhVf8NMMbmw4yuUMzyD1Fk6YZTJNkw8JRX/08EBJbvpVHiLHRno2WXfE/xfdrKUEXDUgsAiQID7EOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749726285; c=relaxed/simple;
	bh=iWfSMHs65N5FHQ224diOqaLZT4DtgY0DBPQrUxrKmVI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h7qe2C5UGHkdVH5D0thK4YxnvZuNCb/u2YLVKA0bneWk4F11+EM9DVWqyVLnGXXOGAo334YkGHP/6uHfi+xisdqh3UA0DqFz2robLdGsEL5Ted0eVhtpTSn4rwm0nkfyXMMXzfDxSshzbwo1PdVlWpMOwvo76T++aix6EWWbxdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ0441XtNz6HJkq;
	Thu, 12 Jun 2025 19:02:44 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6AEC91402EC;
	Thu, 12 Jun 2025 19:04:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 13:04:38 +0200
Date: Thu, 12 Jun 2025 12:04:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <bp@alien8.de>,
	<ming.li@zohomail.com>, <shiju.jose@huawei.com>, <dan.carpenter@linaro.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <kobayashi.da-06@fujitsu.com>,
	<yanfei.xu@intel.com>, <rrichter@amd.com>, <peterz@infradead.org>,
	<colyli@suse.de>, <uaisheng.ye@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
Message-ID: <20250612120436.00005af5@huawei.com>
In-Reply-To: <20250603172239.159260-4-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-4-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 12:22:26 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used
> as an indication for the CXL drivers to handle and log the CXL RAS errors.
> 
> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
> 
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
> 
> Introduce function cxl_create_prot_err_info() and 'struct cxl_prot_err_info'.
> Implement cxl_create_prot_err_info() to populate a 'struct cxl_prot_err_info'
> instance with the AER severity and the erring device's PCI SBDF. The SBDF
> details will be used to rediscover the erring device after the CXL driver
> dequeues the kfifo work. The device rediscovery will be introduced along
> with the CXL handling in future patches.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

A few trivial bits of feedback.  I didn't find anything substantial that
hasn't already been covered by others.

Jonathan

> ---
>  drivers/cxl/core/ras.c |  31 +++++++++-
>  drivers/cxl/cxlpci.h   |   1 +
>  drivers/pci/pcie/aer.c | 132 ++++++++++++++++++++++++++++-------------
>  include/linux/aer.h    |  36 +++++++++++
>  4 files changed, 157 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..d35525e79e04 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -5,6 +5,7 @@

>  
>  void cxl_ras_exit(void)
>  {
>  	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>  	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_prot_err_work();
> +	cancel_work_sync(&cxl_prot_err_work);
>  }

> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index adb4b1123b9b..5350fa5be784 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c

> +static int cxl_create_prot_error_info(struct pci_dev *pdev,
> +				      struct aer_err_info *aer_err_info,
> +				      struct cxl_prot_error_info *cxl_err_info)
> +{
> +	cxl_err_info->severity = aer_err_info->severity;
> +
> +	cxl_err_info->function = PCI_FUNC(pdev->devfn);
> +	cxl_err_info->device = PCI_SLOT(pdev->devfn);
> +	cxl_err_info->bus = pdev->bus->number;
> +	cxl_err_info->segment = pci_domain_nr(pdev->bus);
Maybe 
	*cxl_err_info = (struct cxl_prot_error_info) {
		.severity = aer_err_info->severity,
		.function = PCI_FUNC(pdev->devfn),
		.device = PCI_SLOT(pdev->devfn),
		.bus = pdev->bus_number,
		.segment = pci_domain_nr(dev->nbus),
	};

Or if it isn't going to get more use later, just put that assignment in
forward_cxl_error as this helper doesn't seem to add a huge amount of
value wrt to code reability.


> +
> +	return 0;
> +}
> +
> +static void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
> +{
> +	struct cxl_prot_err_work_data wd;
> +	struct cxl_prot_error_info *cxl_err_info = &wd.err_info;
> +
> +	cxl_create_prot_error_info(pdev, aer_err_info, cxl_err_info);

	cxl_create_prot_error_info(pdev, aer_err_info, &wd.err_info);

Ignore if this gets more complicated in a later patch but for now I don't
see the local variable adding any value. If anything it slightly obscures
how this gets used via wd in the next line.  However given the code is short
that is fairly obvious either way.

Or as above
	wd.error_info = (struct cxl_prot_error_info) {
		.severity = ...
	};

> +
> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_prot_err_work);
> +}
> +
>  #else
>  static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>  static inline void cxl_rch_handle_error(struct pci_dev *dev,
>  					struct aer_err_info *info) { }
> +static inline void forward_cxl_error(struct pci_dev *dev,
> +				    struct aer_err_info *info) { }

Is this aligned right - looks one space short?

> +static inline bool handles_cxl_errors(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return 0; };

wrap choices for the two stubs are a bit odd.   The first one is actually shorter
if not wrapped than the second one is that you chose not to wrap.
My slightly preference would be to wrap them both as the fist one.


>  #endif



