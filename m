Return-Path: <linux-pci+bounces-10523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0E4935063
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CEB9B22A3B
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3E144306;
	Thu, 18 Jul 2024 16:03:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21B813C3E6;
	Thu, 18 Jul 2024 16:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318599; cv=none; b=qR1hYEZN/HuX3KwKr1DpJybsx9S3J0RQcQAVIRfqBAqaIROB8+1E6c5kDnoffDuIyfIk4eaDfwz4fkeLtuJ/OJlrFksVGRbxcC/SH2Hi6SoF9yYgdujmUb1aN4XSNtqHDjIAqMWTT+TmH5EPhtHTQ/tfpycK0RuwFdHRtD8s+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318599; c=relaxed/simple;
	bh=zOvCzP11qp6dVxJ2N6I/9DUxbVi3FjgOnLiqM87dfTI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dh6YW3spEupG1j1CUelnzw8NmoQYqrX67QVB+3iyz2tu6xVv6dXrZEbaTUYv4I3tkqx9uj9lAot48dKXq4lJyhgMG0Tn2heEcxH0aBt9NdQ/K0aoLgm1J60WiQWT8Hz3vQdpUnI2fCB8Fp3ETLYJghZS/FEQqa/Ts4ofvVLr08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPyGW5qb4z67NNP;
	Fri, 19 Jul 2024 00:01:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E4CE140AE5;
	Fri, 19 Jul 2024 00:03:15 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 17:03:14 +0100
Date: Thu, 18 Jul 2024 17:03:13 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lukas Wunner <lukas@wunner.de>
CC: Bjorn Helgaas <helgaas@kernel.org>, David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, David Woodhouse <dwmw2@infradead.org>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>,
	<linux-pci@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <keyrings@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>, David Box
	<david.e.box@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Li, Ming"
	<ming4.li@intel.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>, Alistair
 Francis <alistair.francis@wdc.com>, Wilfred Mallawa
	<wilfred.mallawa@wdc.com>, Damien Le Moal <dlemoal@kernel.org>, "Alexey
 Kardashevskiy" <aik@amd.com>, Dhaval Giani <dhaval.giani@amd.com>,
	Gobikrishna Dhanuskodi <gdhanuskodi@nvidia.com>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Gonda <pgonda@google.com>, Jerome Glisse
	<jglisse@google.com>, Sean Christopherson <seanjc@google.com>, "Alexander
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, Jonathan Corbet
	<corbet@lwn.net>
Subject: Re: [PATCH v2 16/18] spdm: Limit memory consumed by log of received
 signatures
Message-ID: <20240718170313.00005614@Huawei.com>
In-Reply-To: <2e6ee6670a5d450bc880e77a892ea0227a2cc3b4.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<2e6ee6670a5d450bc880e77a892ea0227a2cc3b4.1719771133.git.lukas@wunner.de>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:51:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The SPDM library has just been amended to keep a log of received
> signatures and expose it in sysfs.
> 
> Limit the log's memory footprint subject to a sysctl parameter.  Purge
> old signatures when adding a new signature which causes the limit to be
> exceeded.  Likewise purge old signatures when the sysctl parameter is
> reduced.
> 
> The latter requires keeping a list of all struct spdm_state and
> protecting it with a mutex.  It will come in handy when further global
> sysctl parameters are added to the SPDM library.  Unfortunately an
> xarray is not a better option in this case as the xarray-integrated
> xa_lock() is a spinlock but purging signatures from sysfs may sleep
> (due to kernfs_rwsem).
> 
> This functionality is introduced in a separate commit on top of basic
> signature exposure to split the code into digestible, reviewable chunks.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
Ah. This avoids potential problem in previous patch. Fair enough no need
to check the counter for overflow as long as it's not feasible to set that
sysctl high enough that we still get a collision.

LGTM 
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

