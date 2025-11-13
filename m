Return-Path: <linux-pci+bounces-41083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09388C573D2
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4BB0B357BD0
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2965B2EB5CE;
	Thu, 13 Nov 2025 11:36:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D8133F8A4
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 11:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033785; cv=none; b=MiUPobvhsrgej3HI4FgaUp/FhjsT4BKIauX1P3nM+LW8FjgE78/gWM1jE7qXKB0doD7gGKRlDCnvU9adjDNDDQiaXF5v4BvRQIjeNFpsDok7+zPRLME1buGzlPdp6X2OrNLehCN4Sp/o9Op71Gy8EcWlRXNxye+kBJ7m9cV12JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033785; c=relaxed/simple;
	bh=YUCLKjsmRfTHIUJ7aou5XK4iVdEJEQRU6+KSmW2F6QE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LErHZbM5F5WfT3nwbJi5SX0Gk/N2rEn4CnUiO9WEpR5SFZ3iKcd8tQXKVqFQIQ9B8xUC786iOJ/WMzaB1bRyVxS7fmyJzdcVGAabP/56hHX7Ho9osjQenMOrsVrgHa4WP/zc3ER+HnTN8yO6tvTtx8GwnMLNAfy8DqroJB07qeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6dW54D4rzJ46pd;
	Thu, 13 Nov 2025 19:35:45 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C7EA140277;
	Thu, 13 Nov 2025 19:36:19 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 11:36:19 +0000
Date: Thu, 13 Nov 2025 11:36:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Bjorn Helgaas
	<bhelgaas@google.com>
Subject: Re: [PATCH v2 3/8] resource: Introduce resource_assigned() for
 discerning active resources
Message-ID: <20251113113617.00007078@huawei.com>
In-Reply-To: <20251113021446.436830-4-dan.j.williams@intel.com>
References: <20251113021446.436830-1-dan.j.williams@intel.com>
	<20251113021446.436830-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 12 Nov 2025 18:14:41 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> A PCI bridge resource lifecycle involves both a "request" and "assign"
> phase. At any point in time that resource may not yet be assigned, or may
> have failed to assign (because it does not fit).
>=20
> There are multiple conventions to determine when assignment has not
> completed: IORESOURCE_UNSET, IORESOURCE_DISABLED, and checking whether the
> resource is parented.
>=20
> In code paths that are known to not be racing assignment, e.g. post
> subsys_initcall(), the most reliable method to judge that a bridge resour=
ce
> is assigned is to check the resource is parented [1].
>=20
> Introduce a resource_assigned() helper for this purpose.
>=20
> Link: http://lore.kernel.org/2b9f7f7b-d6a4-be59-14d4-7b4ffccfe373@linux.i=
ntel.com [1]
> Suggested-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Given you replied (and I'm happy to accept that reply) to the doc formattin=
g comment
I had on v1.  This LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Nice to have a follow up series applying this more widely if anyone has tim=
e.
Lots of them in pci/setup-bus.c for instance.=20
One of those is doing an assignment check but maybe isn't good to change as=
 it is

if (res->parent)
	return res->parent;

Others all look like low hanging fruit for the readability improvement this
brings.


> ---
>  include/linux/ioport.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index e8b2d6aa4013..9afa30f9346f 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -334,6 +334,15 @@ static inline bool resource_union(const struct resou=
rce *r1, const struct resour
>  	return true;
>  }
> =20
> +/*
> + * Check if this resource is added to a resource tree or detached. Calle=
r is
> + * responsible for not racing assignment.
> + */
> +static inline bool resource_assigned(struct resource *res)
> +{
> +	return res->parent;
> +}
> +
>  int find_resource_space(struct resource *root, struct resource *new,
>  			resource_size_t size, struct resource_constraint *constraint);
> =20


