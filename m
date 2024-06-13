Return-Path: <linux-pci+bounces-8736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEFC907417
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 15:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 167E41C23E21
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 13:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CDE1448E4;
	Thu, 13 Jun 2024 13:42:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7E2143C7E;
	Thu, 13 Jun 2024 13:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718286178; cv=none; b=XwArnr5m3SYJPBofLaCcDz8BcIrsTAwJZzC8Xu5ggDZtj5CqFimx4aJOmnBUQEVkGSJ128C+ztRv150uey4/Ddkc8eEzu8Mr+auaCFsBWQXU05cRApeGJW4j48CYS4cnV4GERI4cLUaskUr8HhkIJHsp5qLnU2Kj5CDtQdPWP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718286178; c=relaxed/simple;
	bh=Ec9s1B8/QF2gw96Rd/is0XIs6OGbUlCjx4IVYntIBkI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MhFjLYA74/4uVGL1H9YYXpXXA8ci3/y1ZT7CLdLGPhCSD2egIpUVkPKaAtjA1wOdPbseSipm+eA0bTn3U5KsBi1/7QBK0TagmVYoyiowl+pHCF33T51BAEw/tEBzxJ6E6Q3wyRQNJsKoju91GZyxS8FBgJ+ZBenftAUhN88OmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0NqH041mz6H78J;
	Thu, 13 Jun 2024 21:41:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5589140B2F;
	Thu, 13 Jun 2024 21:42:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 13 Jun
 2024 14:42:53 +0100
Date: Thu, 13 Jun 2024 14:42:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, <linux-kernel@vger.kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>,
	"Robert Richter" <rric@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH 3/3] PCI: Use align and resource helpers, and SZ_* in
 quirk_s3_64M()
Message-ID: <20240613144252.000070f4@Huawei.com>
In-Reply-To: <20240612085629.5015-4-ilpo.jarvinen@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
	<20240612085629.5015-4-ilpo.jarvinen@linux.intel.com>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 12 Jun 2024 11:56:29 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Use IS_ALIGNED(), resource_size(), and SZ_* defines in quirk_s3_64M().
>=20
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

