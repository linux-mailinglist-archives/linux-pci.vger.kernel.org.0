Return-Path: <linux-pci+bounces-10517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAFE935006
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 084831F22B70
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404B1448D7;
	Thu, 18 Jul 2024 15:36:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08281448FF;
	Thu, 18 Jul 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316979; cv=none; b=YFNXeFaZC367Dv7sT+L4CKXYl66Ehwyecbvu8yFlfTqUxGvDVKC1v4ABp9RrXxdgsTn5N9u2UY0eskqRFp6qq4PN06tDNrbU+5HCgUwEexfK0iMdavliEc8n1y1SMqSTLDakGuDef26LS3kgje9vVQ3E/plfa6qrJx72RKPO0Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316979; c=relaxed/simple;
	bh=Tjr91XqziOyw9pAkPN6H/0OP3OMBotGhZiCu+9rQFMc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHV5+5GlKbJEq46B8Z1EpySpNvBpvJHsUo72V8pp2YmBRzBQfjlvUJ7dVh/7cD33qp0vtSymqwKyTj683hFmoWxWKVoazuGQRsufK/W27cIWtG1eoc/Vb5g8aNn/3i6XMr7fUq/yE3LR4XgiXmCDCNBSQ7bJbGrvGJdV03R2Ix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPxgD6dJfz6H7xp;
	Thu, 18 Jul 2024 23:34:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3563D140B2F;
	Thu, 18 Jul 2024 23:36:08 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:36:07 +0100
Date: Thu, 18 Jul 2024 16:36:06 +0100
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
 Graf" <graf@amazon.com>, Samuel Ortiz <sameo@rivosinc.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Alan Stern
	<stern@rowland.harvard.edu>
Subject: Re: [PATCH v2 14/18] sysfs: Allow symlinks to be added between
 sibling groups
Message-ID: <20240718163606.000069c4@Huawei.com>
In-Reply-To: <7b4e324bdcd5910c9460bb5fc37aaf354f596ebf.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<7b4e324bdcd5910c9460bb5fc37aaf354f596ebf.1719771133.git.lukas@wunner.de>
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
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:49:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> A subsequent commit has the need to create a symlink from an attribute
> in a first group to an attribute in a second group.  Both groups belong
> to the same kobject.
> 
> More specifically, each signature received from an authentication-
> capable device is going to be represented by a file in the first group
> and shall be accompanied by a symlink pointing to the certificate slot
> in the second group which was used to generate the signature (a device
> may have multiple certificate slots and each is represented by a
> separate file in the second group):
> 
> /sys/devices/.../signatures/0_certificate_chain -> .../certificates/slot0
> 
> There is already a sysfs_add_link_to_group() helper to add a symlink to
> a group which points to another kobject, but this isn't what's needed
> here.
> 
> So add a new function to add a symlink among sibling groups of the same
> kobject.
> 
> The existing sysfs_add_link_to_group() helper goes through a locking
> dance of acquiring sysfs_symlink_target_lock in order to acquire a
> reference on the target kobject.  That's unnecessary for the present
> use case as the link itself and its target reside below the same
> kobject.
> 
> To simplify error handling in the newly introduced function, add a
> DEFINE_FREE() clause for kernfs_put().
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Nice in general. A few minor comments inline.


> ---
>  fs/sysfs/group.c       | 33 +++++++++++++++++++++++++++++++++
>  include/linux/kernfs.h |  2 ++
>  include/linux/sysfs.h  | 10 ++++++++++
>  3 files changed, 45 insertions(+)
> 
> diff --git a/fs/sysfs/group.c b/fs/sysfs/group.c
> index d22ad67a0f32..0cb52c9b9e19 100644
> --- a/fs/sysfs/group.c
> +++ b/fs/sysfs/group.c
> @@ -445,6 +445,39 @@ void sysfs_remove_link_from_group(struct kobject *kobj, const char *group_name,
>  }
>  EXPORT_SYMBOL_GPL(sysfs_remove_link_from_group);
>  
> +/**
> + * sysfs_add_link_to_sibling_group - add a symlink to a sibling attribute group.

> + * @kobj:	The kobject containing the groups.
> + * @link_grp:	The name of the group in which to create the symlink.
> + * @link:	The name of the symlink to create.

Maybe should go with the link_name naming used in sysfs_add_link_to group.

> + * @target_grp:	The name of the target group.
> + * @target:	The name of the target attribute.
> + *
> + * Returns 0 on success or error code on failure.
> + */
> +int sysfs_add_link_to_sibling_group(struct kobject *kobj,
> +				    const char *link_grp, const char *link,
> +				    const char *target_grp, const char *target)
> +{
> +	struct kernfs_node *target_grp_kn __free(kernfs_put),
> +			   *target_kn __free(kernfs_put) = NULL,
> +			   *link_grp_kn __free(kernfs_put) = NULL;

Maybe just define these when used (similar to earlier reviews)
rather than in one clump up here.  Given they are all doing the same
thing maybe it's not worth the effort though.


> +
> +	target_grp_kn = kernfs_find_and_get(kobj->sd, target_grp);
> +	if (!target_grp_kn)
> +		return -ENOENT;
> +
> +	target_kn = kernfs_find_and_get(target_grp_kn, target);
> +	if (!target_kn)
> +		return -ENOENT;
> +
> +	link_grp_kn = kernfs_find_and_get(kobj->sd, link_grp);
> +	if (!link_grp_kn)
> +		return -ENOENT;
> +
> +	return PTR_ERR_OR_ZERO(kernfs_create_link(link_grp_kn, link, target_kn));
> +}
> +



