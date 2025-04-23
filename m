Return-Path: <linux-pci+bounces-26550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CAAA9903D
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 17:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665313A73D8
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892828BAA0;
	Wed, 23 Apr 2025 15:04:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83C728BA96;
	Wed, 23 Apr 2025 15:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420690; cv=none; b=Tp8T7ekw3ujYk+XsNpicl2+Bpn2CmBCHZxOREBjGuSUXw52mT0SURDFa5ix1b9pSu9dAkEp4vKjX0X/NiXrJKj3zCU0ZoDocSzCN7GxYgaprIpuHIAtLRx6S2woewebDjBfOvp1UYvlHVp/41O2faOKk3fpMPK3lJXMPo9/CSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420690; c=relaxed/simple;
	bh=EhzDT9AyqRzCcMefw4bfWlKe5r12Bea74KdJlIRDaQM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CvohfzcY7T5qrDT2+NuhNOFTmnPRiQdc6YNcS3Abm+05zWakm9Zn4FKYJRKpSi4ERVJqwvgHXjDa9eVejA1ToJJNZKQyff5nN9VkasVuWJA9AuxmhztbjLt7cINMf+3pzey1Oq8SGTjsqi8TXKkeLTf55NiY6oa38byXRSEm9XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjMjb43n9z6M4kw;
	Wed, 23 Apr 2025 23:00:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E3AE1402FF;
	Wed, 23 Apr 2025 23:04:45 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 17:04:44 +0200
Date: Wed, 23 Apr 2025 16:04:43 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 04/16] cxl/aer: AER service driver forwards CXL error
 to CXL driver
Message-ID: <20250423160443.00006ee0@huawei.com>
In-Reply-To: <20250327014717.2988633-5-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-5-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:05 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER service driver includes a CXL-specific kfifo, intended to forward
> CXL errors to the CXL driver. However, the forwarding functionality is
> currently unimplemented. Update the AER driver to enable error forwarding
> to the CXL driver.
> 
> Modify the AER service driver's handle_error_source(), which is called from
> process_aer_err_devices(), to distinguish between PCIe and CXL errors.
> 
> Rename and update is_internal_error() to is_cxl_error(). Ensuring it
> checks both the 'struct aer_info::is_cxl' flag and the AER internal error
> masks.
> 
> If the error is a standard PCIe error then continue calling pcie_aer_handle_error()
> as done in the current AER driver.
> 
> If the error is a CXL-related error then forward it to the CXL driver for
> handling using the kfifo mechanism.
> 
> Introduce a new function forward_cxl_error(), which constructs a CXL
> protocol error context using cxl_create_prot_err_info(). This context is
> then passed to the CXL driver via kfifo using a 'struct work_struct'.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Hi Terry,

Finally got back to this.  I'm not following how some of the reference
counting in here is working.  It might be fine but there is a lot
taking then dropping device references - some of which are taken again later.

> @@ -1082,10 +1094,44 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>  	pci_info(rcec, "CXL: Internal errors unmasked");
>  }
>  
> +static void forward_cxl_error(struct pci_dev *_pdev, struct aer_err_info *info)
> +{
> +	int severity = info->severity;

So far this variable isn't really justified.  Maybe it makes sense later in the
series?

> +	struct cxl_prot_err_work_data wd;
> +	struct cxl_prot_error_info *err_info = &wd.err_info;

Similarly. Why not just use this directly in the call below?

> +	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(_pdev);
Can you talk me through the reference counting?  You take one pci device reference
here.... 
> +
> +	if (!cxl_create_prot_err_info) {
> +		pci_err(pdev, "Failed. CXL-AER interface not initialized.");
> +		return;
> +	}
> +
> +	if (cxl_create_prot_err_info(pdev, severity, err_info)) {

...but the implementation of this also takes once internally.  Can we skip that
internal one and document that it is always take by the caller?

> +		pci_err(pdev, "Failed to create CXL protocol error information");
> +		return;
> +	}
> +
> +	struct device *cxl_dev __free(put_device) = get_device(err_info->dev);

Also this one.  A reference was acquired and dropped in cxl_create_prot_err_info()
followed by retaking it here.  How do we know it is still about by this call
and once we pull it off the kfifo later?

> +
> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
> +		pr_err_ratelimited("CXL kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_prot_err_work);
> +}
> +

Thanks,

Jonathan


