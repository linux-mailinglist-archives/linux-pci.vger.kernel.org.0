Return-Path: <linux-pci+bounces-10513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9E0934FCC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567191F21259
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F91143C55;
	Thu, 18 Jul 2024 15:20:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942727A724;
	Thu, 18 Jul 2024 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316003; cv=none; b=cHp0xQWlsZMUA+iyYJpZZZrHS/8OWm8JBCZqn+DcuiTDrLWtMDR3n8HJ2ZMt+2DyNoQhJVcoW1fMaZnHpyOp/nUTwezKuvoBUC4Wr43TwxOgu9zP+fHHhqFhOyR+xVI9cpOGbBjsbuQ6gSdm+cHpAbKDCH4Lr+cF1RS4Akcj12c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316003; c=relaxed/simple;
	bh=nWPAZlQkcOnRtDZxhKLvWWSeEFOq36D4LuYtz3DocKw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bi+i7qIsFzGxVEDT8Xm6ELg5A+DS5t2nrGmJ5dH3+Mdn3erRLm6GcMi31daQUwacfNftjjZCwV071rizB68qRaVytM4gLels8b5Xx5wl/NMCQeV047qmNmZIp17cC9Rhd71Qd0ikNjLO+hT6NzOKp5/y2cD4HPVhel0a/6oGV4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPxJ73Kntz6K9gJ;
	Thu, 18 Jul 2024 23:17:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 5CA91140B73;
	Thu, 18 Jul 2024 23:19:59 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:19:58 +0100
Date: Thu, 18 Jul 2024 16:19:57 +0100
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
Subject: Re: [PATCH v2 12/18] PCI/CMA: Expose certificates in sysfs
Message-ID: <20240718161957.00001781@Huawei.com>
In-Reply-To: <e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<e42905e3e5f1d5be39355e833fefc349acb0b03c.1719771133.git.lukas@wunner.de>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:47:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> The kernel already caches certificate chains retrieved from a device
> upon authentication.  Expose them in "slot[0-7]" files in sysfs for
> examination by user space.
> 
> As noted in the ABI documentation, the "slot[0-7]" files always have a
> file size of 65535 bytes (the maximum size of a certificate chain per
> SPDM 1.0.0 table 18), even if the certificate chain in the slot is
> actually smaller.  Although it would be possible to use the certifiate
> chain's actual size as the file size, doing so would require a separate
> struct attribute_group for each device, which would occupy additional
> memory.
> 
> Slots are visible in sysfs even if they're currently unprovisioned
> because a future commit will add support for certificate provisioning
> by writing to the "slot[0-7]" files.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
One trivial thing in addition to discussion in Dan's review thread.

Jonathan

> diff --git a/lib/spdm/req-authenticate.c b/lib/spdm/req-authenticate.c
> index 90f7a7f2629c..1f701d07ad46 100644
> --- a/lib/spdm/req-authenticate.c
> +++ b/lib/spdm/req-authenticate.c
> @@ -14,6 +14,7 @@
>  #include "spdm.h"
>  
>  #include <linux/dev_printk.h>
> +#include <linux/device.h>
>  #include <linux/key.h>
>  #include <linux/random.h>
>  
> @@ -288,9 +289,9 @@ static int spdm_get_digests(struct spdm_state *spdm_state)
>  	struct spdm_get_digests_req *req = spdm_state->transcript_end;
>  	struct spdm_get_digests_rsp *rsp;
>  	unsigned long deprovisioned_slots;
> +	u8 slot, supported_slots;
>  	int rc, length;
>  	size_t rsp_sz;
> -	u8 slot;

Move that to earlier patch.


