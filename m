Return-Path: <linux-pci+bounces-10515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A5934FD7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 17:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4840FB21116
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 15:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF813C3CF;
	Thu, 18 Jul 2024 15:22:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4113012C474;
	Thu, 18 Jul 2024 15:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721316137; cv=none; b=dT+NQelKFeEqOJ8m8No1IS89a84JkC6OGKFNDaKaOpJkGKTl+j1YpMwi1RGa6/iKh4QXVjleVfhZ8U6yjwr/bFYYfM1oH1Z16V/1VTqt/nJBF/6QlHNVq7DYHzvophvi23mUkxuar4SAWwa7Dt3XoopZmAXE2kXoVOn/JnwdHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721316137; c=relaxed/simple;
	bh=E533HHAhj/uoDBVDUL3yh1xvV9mHBjJwKPZdvRn1GGQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdwcvV54giyiLuK9kXkBhEm8Vb7m4jVe1MG1+GEXh364erT6JzEUATGr5hOGefDVv1BDVDGu+yhT3U+SDbDv3FifMbAACfLgdv1YlvD7+g1cJBrSqjuzyzNRrwpOsm3cq1zfCjYGFbfPw457uZGhYWa4IkJu+bAdCUB+gvJN+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WPxMk1FJQz6HJp8;
	Thu, 18 Jul 2024 23:20:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id B5CA7140B73;
	Thu, 18 Jul 2024 23:22:11 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 18 Jul
 2024 16:22:11 +0100
Date: Thu, 18 Jul 2024 16:22:10 +0100
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
Subject: Re: [PATCH v2 13/18] sysfs: Allow bin_attributes to be added to
 groups
Message-ID: <20240718162210.000055ee@Huawei.com>
In-Reply-To: <16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>
References: <cover.1719771133.git.lukas@wunner.de>
	<16490618cbde91b5aac04873c39c8fb7666ff686.1719771133.git.lukas@wunner.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 30 Jun 2024 21:48:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
> introduced dynamic addition of sysfs attributes to groups.
>=20
> Allow the same for bin_attributes, in support of a subsequent commit
> which adds various bin_attributes every time a PCI device is
> authenticated.
>=20
> Addition of bin_attributes to groups differs from regular attributes in
> that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
> vis-=E0-vis sysfs_add_file_mode_ns().
>=20
> So call either of those two functions from sysfs_add_file_to_group()
> based on an additional boolean parameter and add two wrapper functions,
> one for bin_attributes and another for regular attributes.
>=20
> Removal of bin_attributes from groups does not require a differentiation
> for bin_attributes and can use the same code path as regular attributes.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



