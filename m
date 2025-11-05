Return-Path: <linux-pci+bounces-40335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0189C34DE8
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 10:34:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1DF18911FD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 09:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01BE301036;
	Wed,  5 Nov 2025 09:33:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245828C035
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762335208; cv=none; b=m9SbdDS8bJm2zW+dh3AWFlmsU+MpxWm5L3MDJF13lVTVpJXvbBDO7OA7DRbD6hslgHTnWliA/LjUg8+nVYMsYJO7X2ceBWbGOZMv5+im956/xnOHFZICks3WtPGVxWa4V6IMfDhbyqqfFGZ8MzSqpYBKDlNTV2AuQ36LoFBlXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762335208; c=relaxed/simple;
	bh=/BlFRsUqHzpyPFsgXRPVEfArD94AsjLLqYTCp3TIbWc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ax9skUdokUiOe0ovdbv6W3tOq+kBc3DCAvnBXjTJtYHXwsKR8N80CRPi0UBBHE/wIFpGdaBD9r4CSZ9d4nbE9fTmef8XoLKSxlc7aCIZKQeqYcRKE1X1rsEuxJ9i7PejWVHu54ffu+rbRsBnXCWPEnRYNCe3VdxFr446TppOD4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1fqF2qwgzHnGdC;
	Wed,  5 Nov 2025 17:17:29 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 700071402A5;
	Wed,  5 Nov 2025 17:17:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 09:17:33 +0000
Date: Wed, 5 Nov 2025 09:17:32 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 1/6] resource: Introduce resource_assigned() for
 discerning active resources
Message-ID: <20251105091732.0000302c@huawei.com>
In-Reply-To: <20251105040055.2832866-2-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-2-dan.j.williams@intel.com>
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

On Tue,  4 Nov 2025 20:00:50 -0800
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
One trivial thing on documentation style below.

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

Some stuff in this file now has kernel-doc style comments. To me it
seems like a better idea to use that style for new function descriptions
whilst perhaps not being worth the churn that would be inherent in switching
all docs to that style.

> +static inline bool resource_assigned(struct resource *res)
> +{
> +	return res->parent;
> +}
> +
>  int find_resource_space(struct resource *root, struct resource *new,
>  			resource_size_t size, struct resource_constraint *constraint);
> =20


