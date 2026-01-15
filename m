Return-Path: <linux-pci+bounces-44974-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7F3D259A3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 17:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4948630A8BBB
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDE829E110;
	Thu, 15 Jan 2026 16:01:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066D22BE7A7;
	Thu, 15 Jan 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768492874; cv=none; b=AyA0NyglN++rOwAxmlxyuPWBe6U/GcweDjnM5SiAdno0X9SEnEt/URzDFHJ3vGodLk8b68LoaQPIb+aFqRJYc3D/sipa4YIcIwxYoqZzYJyzA7TZZD2SftHTTtIiFtM/nYVgg9TxUAN1LrYrOto23GiXyOpG7NJ46lIqD++kt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768492874; c=relaxed/simple;
	bh=o1OO85c2gUFPnlaX65hZClCSxgp04Wn+ZeLEHFnY/ss=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz6CpmD9Xpuaj2S8n8X1OldYltA9gfL0mXulYppW512C4uV00TNPkLR1t3Acl0tNeDfWKQadooMF2LZH36jIl3P3Pqxr9WGuxBvhgggXSTxnqqCfV9qgpobhTMdH2IG4ZaMuN4Z2m0aWCj6m+hMLl1UG9HJHIUM0wvPvMLXBNaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dsSPx4tqszJ46ZJ;
	Fri, 16 Jan 2026 00:00:53 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 310BB40539;
	Fri, 16 Jan 2026 00:01:10 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 15 Jan
 2026 16:01:08 +0000
Date: Thu, 15 Jan 2026 16:01:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>, <alucerop@amd.com>,
	<ira.weiny@intel.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 30/34] PCI/AER: Dequeue forwarded CXL error
Message-ID: <20260115160107.000019d3@huawei.com>
In-Reply-To: <20260114182055.46029-31-terry.bowman@amd.com>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-31-terry.bowman@amd.com>
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

On Wed, 14 Jan 2026 12:20:51 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The AER driver now forwards CXL protocol errors to the CXL driver via a
> kfifo. The CXL driver must consume these work items and initiate protocol
> error handling while ensuring the device's RAS mappings remain valid
> throughout processing.
> 
> Implement cxl_proto_err_work_fn() to dequeue work items forwarded by the
> AER service driver. Lock the parent CXL Port device to ensure the CXL
> device's RAS registers are accessible during handling. Add pdev reference-put
> to match reference-get in AER driver. This will ensure pdev access after
> kfifo dequeue. These changes apply to CXL Ports and CXL Endpoints.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Few things inline.
Thanks,

Jonathan

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index bf82880e19b4..0c640b84ad70 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -117,17 +117,6 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)

> +/*
> + * Return 'struct cxl_port *' parent CXL Port of dev
> + *
> + * Reference count increments returned port on success
> + *
> + * @pdev: Find the parent CXL Port of this device

This is a non standard type of a comment. I'd make it formal
kernel-doc.



> +
> +static void cxl_proto_err_work_fn(struct work_struct *work)
> +{
> +	struct cxl_proto_err_work_data wd;
> +
> +	while (cxl_proto_err_kfifo_get(&wd)) {

I'm probably being slow today but where does that helper come from?

> +		struct pci_dev *pdev __free(pci_dev_put) = wd.pdev;
> +
> +		if (!pdev) {
> +			pr_err_ratelimited("NULL PCI device passed in AER-CXL KFIFO\n");
> +			continue;
> +		}
> +
> +		struct cxl_port *port __free(put_cxl_port) = get_cxl_port(pdev);
> +		if (!port) {
> +			pr_err_ratelimited("Failed to find parent Port device in CXL topology.\n");
> +			continue;
> +		}
> +		guard(device)(&port->dev);
> +
> +		cxl_handle_proto_error(&wd);
> +	}
> +}


