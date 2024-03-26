Return-Path: <linux-pci+bounces-5194-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CE188CA51
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 007531F8240C
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 17:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD928664F;
	Tue, 26 Mar 2024 16:56:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF99D86643;
	Tue, 26 Mar 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472191; cv=none; b=euALFmGiCHD78X4cpPQZ6oKs1FeRkbyddNy2HU6CqHNM4UleIj4kTetASgWy77TahF/PTcTXNF94MaAvn98Dr+sfY7QiPOFyjmjud//b307cEW4ObztIRaKFYMEzXJzcxjivgefCp5cUzvfSYv9iVXPy3koMudYyxE2wsSDXAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472191; c=relaxed/simple;
	bh=4RBQkJlhFKpCT4/hh4bcHX7zCUxKMVUv7eGrJmW03nA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NISFMqTEoHofYkpmf4gzE+nJt+/R0l1otyAakhRD2EzYCKRJneV7/8dnmY8oAtE0eOUAgIwOnuayp1G78hkkH/Hxu04cuCYQaZFUX7uxk8o4E26GKV8QwbYqJV/Q2hZX8d7IpR6qDmeKqefq6VeW6MPwxSUNdBoqCAbmYdR7TW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3wnW1FbRz688KN;
	Wed, 27 Mar 2024 00:51:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 21185140B2F;
	Wed, 27 Mar 2024 00:56:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 26 Mar
 2024 16:56:24 +0000
Date: Tue, 26 Mar 2024 16:56:23 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Ira Weiny <ira.weiny@intel.com>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Lukas Wunner <lukas@wunner.de>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] cleanup: Add usage and style documentation
Message-ID: <20240326165623.000002fa@Huawei.com>
In-Reply-To: <171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
	<171140738438.1574931.15717256954707430472.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 25 Mar 2024 15:57:42 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> When proposing that PCI grow some new cleanup helpers for pci_dev_put()
> and pci_dev_{lock,unlock} [1], Bjorn had some fundamental questions
> about expectations and best practices. Upon reviewing an updated
> changelog with those details he recommended adding them to documentation
> in the header file itself.
>=20
> Add that documentation and link it into the rendering for
> Documentation/core-api/.
>=20
> Link: http://lore.kernel.org/r/20240104183218.GA1820872@bhelgaas [1]
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Other than the formatting improvement Jon suggested, this looks good to me
and corresponds to my understanding of how this stuff should be used.

FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

