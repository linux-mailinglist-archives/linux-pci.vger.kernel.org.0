Return-Path: <linux-pci+bounces-10524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F893506E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 18:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021751F21C88
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 16:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E83A14430A;
	Thu, 18 Jul 2024 16:08:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DA51B86D0;
	Thu, 18 Jul 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318895; cv=none; b=cSkPlZoYfCbNS3XZ+GIOvlcPy0+UglEMpp3xEZe6MlZxzo7ecWLVQ3qdXJ9/+iK3Y/1xsh/pTI4kRGpbb+PgGe1O2k7lAe1McEOm1KuWR8fdHBm487SURRhk/AIBoSX5/hSaq/bHKI6lESx5bB0ptOsXeStqsMX7NJ12d66NcEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318895; c=relaxed/simple;
	bh=v8DMx2N923z6kNJIsf8wo0V8ocrklFBtab/9f6dJ4zw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJwB+hWSp0Hp7xMG3lDBXjFJErrhycw4GPGbwqCwqF+Fx79WWNnAO9WktFaxl0FX+8ty6kKGcJwJyoIugyE6mVhvkw7hsqJpqvfYcSN6ffeLqQlwf+x0fYmJhlRksBEm9pt5aFlikFAYp0BLaYDvGqVgLU4PnSzNVe9ykBBCh8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPyMk35J4z6K9gY;
	Fri, 19 Jul 2024 00:05:54 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 6108C140AE5;
	Fri, 19 Jul 2024 00:08:10 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 17:08:09 +0100
Date: Thu, 18 Jul 2024 17:08:09 +0100
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
Subject: Re: [PATCH v2 17/18] spdm: Authenticate devices despite invalid
 certificate chain
Message-ID: <20240718170809.00000849@Huawei.com>
In-Reply-To: <dff8bcb091a3123e1c7c685f8149595e39bbdb8f.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<dff8bcb091a3123e1c7c685f8149595e39bbdb8f.1719771133.git.lukas@wunner.de>
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

On Sun, 30 Jun 2024 21:52:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The SPDM library has just been amended to keep a log of received
> signatures from a device and expose it in sysfs.
> 
> Currently challenge-response authentication with a device is only
> performed if one of its up to 8 certificate chains is considered valid
> by the kernel.
> 
> Valid means several things:
> 
> * That the certificate chain adheres to requirements in the SPDM
>   specification (e.g. each certificate in the chain is signed by the
>   preceding certificate),
> * that the certificate chain adheres to requirements in other
>   specifications such as PCIe r6.1 sec 6.31.3,
> * that the first certificate in the chain is signed by a trusted root
>   certificate on the kernel's keyring
> * or that none of the certificates in the chain is on the kernel's
>   blacklist_keyring.

That "or" seems odd..  Should it be "and"?

> 
> User space should be given the chance to make up its own mind on the
> validity of a certificate chain and the signature generated with it.
> So if none of the 8 certificate chains is considered valid by the
> kernel, pick one of them and perform challenge-response authentication
> with it for the sole purpose of exposing a signature to user space.
> 
> Do not verify that signature because if the kernel considers the
> certificate chain invalid, the signature implicitly is as well.
> 
> Arbitrarily select the certificate chain in the first provisioned slot
> (which is normally slot 0) for such "for user space only" authentication
> attempts.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> I'd like to know whether people actually find this feature useful.
> The patch is somewhat tentative and I may drop it if there is no interest,
> so comments welcome!
> 
Code looks fine, but I'm also interested in whether this is useful
to anyone.  It's not something I care about currently.

Jonathan


