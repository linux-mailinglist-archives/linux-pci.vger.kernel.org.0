Return-Path: <linux-pci+bounces-33357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C2B19FA7
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 12:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068B33BAE27
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 10:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62736248F78;
	Mon,  4 Aug 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="krZ916p6"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C54A07;
	Mon,  4 Aug 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754303024; cv=none; b=MEzLFyQA7e0VMFL4HJeo7EjFRBcISQW+5rKK04BofS2FPvYqXIzRjDBT8cBlqa1GVpimrZCvJlMI2L4jcj31dFW/9HutHFkAs8FWA9FsIYrYtQqcxWQCVaE6pa73/O1N3Xg1B7V2Hj2dJS/VxxC8H7FlDA91ZMbwxVttnFtZHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754303024; c=relaxed/simple;
	bh=X1VUhgt8QW/ZfVr4EXLGfxcOIQqMZmFuJ0KQugFBrP0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G3Jt0bFwdAxMDRH3PTO4nKdyK4GCcZlPFscV4aIRHxVfwxU3wvtaEUPNEVTedaxwEt8OpjDXo6ggi1xE0OC9tKmPTjZRUjCUbE6+UgEacZ86xrzSqxoMcQLUKOSXhibdwggNCrXamW8yoeTRwqJ+h+k2CIooff/PhxX0Knc5vYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=krZ916p6; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yXPzIEEoaPN1VOdITWv34hp9rv4PXkmKFCr/GnHNnyQ=;
	b=krZ916p6MflWi+t54Nh5ZPuOIQXBLK17j9mJYliCU3H8LoGXgjO1vjrCmf+7jTthc71o+Scz/
	8gRm/qrszeSN0RjpvFGrpSumMnaTnLPyhy0sYRhp+Mugi7yKgilUQHdwE9HkleCa1H4GnJSDTuD
	7dTPC95O7J3AD57GduXJkAQ=
Received: from frasgout.his.huawei.com (unknown [172.18.146.37])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bwXfV5p2mzN0dZ;
	Mon,  4 Aug 2025 18:21:54 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bwXb96HLrz6L5Ks;
	Mon,  4 Aug 2025 18:19:01 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EAAA140133;
	Mon,  4 Aug 2025 18:23:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 4 Aug
 2025 12:23:28 +0200
Date: Mon, 4 Aug 2025 11:23:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 38/38] coco: guest: arm64: Add support for
 fetching device info
Message-ID: <20250804112326.00000f40@huawei.com>
In-Reply-To: <yq5ao6sv8tw9.fsf@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-39-aneesh.kumar@kernel.org>
	<20250731113653.000000cd@huawei.com>
	<yq5ao6sv8tw9.fsf@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)


> >  
> >> +	if (!dev_info) {
> >> +		ret = -ENOMEM;
> >> +		goto err_out;
> >> +	}
> >> +
> >> +	ret = rsi_rdev_get_info(vdev_id, dsm->instance_id, virt_to_phys(dev_info));
> >> +	if (ret != RSI_SUCCESS) {
> >> +		pci_err(pdev, "failed to get device digests (%lu)\n", ret);
> >> +		ret = -EIO;
> >> +		kfree(dev_info);
> >> +		goto err_out;
> >> +	}
> >> +
> >> +	dsm->dev_info.attest_type   = dev_info->attest_type;
> >> +	dsm->dev_info.cert_id       = dev_info->cert_id;
> >> +	dsm->dev_info.hash_algo     = dev_info->hash_algo;
> >> +	memcpy(dsm->dev_info.cert_digest, dev_info->cert_digest, SHA512_DIGEST_SIZE);
> >> +	memcpy(dsm->dev_info.meas_digest, dev_info->meas_digest, SHA512_DIGEST_SIZE);
> >> +	memcpy(dsm->dev_info.report_digest, dev_info->report_digest, SHA512_DIGEST_SIZE);
> >> +  
> >
> > Can't you memcpy the whole thing in one go?
> >  
> 
> yes. But won't that be confusing? Is there a difference?
> Also struct dsm_device_info is not same as struct rsi_device_info. We
> don't need to keep all that padding in dsm_device_info.
Ah. I misread and thought they were the same structure.  No problem copying
only relevant fields then!

Jonathan

