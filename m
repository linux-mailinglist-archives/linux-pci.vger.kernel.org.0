Return-Path: <linux-pci+bounces-29929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA8EADCFD7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F684062EB
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FB2DBF42;
	Tue, 17 Jun 2025 14:22:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70F22E3AE8
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750170123; cv=none; b=ri3q++QTPqMvLETMlV/VPr3YBgP8MyiibETICrBnhxyyWM5hcmNIkJ7TJ2xqnjcAovOmf9NQGjHfym/4tMicqhmz6k8q8/7Xm0EXcOWkRrjfMfX6L1n1Ruc9Ja7Nquir/ST+xn/ZRUHaUbHuanFbuhrpz5ClgW2+NC9HY9wCXGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750170123; c=relaxed/simple;
	bh=iZFsen1wzgMPKepSb8rWXV52OMIT/eONbL+Pp5LT5Co=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otQnF4ejLfWd0/bB0Of8VuKsPqce3U5cmdyBZsvC0OE0GfwOzgTHPDXdog6lDRzGD3BHAHTaPcOiTLohG+ZgGJkmmt09RoV/P5a8zkmH+yGu4QCDH0oPPFVnc9OBjmKakGSqvEfUVbxltgDC5Foh/DXMq95nlGYioxQ/g8owDSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM88L4jfWz6L5Zp;
	Tue, 17 Jun 2025 22:17:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id C95EB140277;
	Tue, 17 Jun 2025 22:21:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 16:21:59 +0200
Date: Tue, 17 Jun 2025 15:21:57 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>
Subject: Re: [PATCH v3 10/13] PCI/TSM: Report active IDE streams
Message-ID: <20250617152157.000048a2@huawei.com>
In-Reply-To: <20250516054732.2055093-11-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-11-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:29 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Given that the platform TSM owns IDE Stream ID allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the Stream ID.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tsm | 10 ++++++++++
>  drivers/virt/coco/host/tsm-core.c         | 17 +++++++++++++++++
>  include/linux/tsm.h                       |  4 ++++
>  3 files changed, 31 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 7503f04a9eb9..75ee2b9bc555 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -8,3 +8,13 @@ Description:
>  		signals when the PCI layer is able to support establishment of
>  		link encryption and other device-security features coordinated
>  		through the platform tsm.
> +
> +What:		/sys/class/tsm/tsm0/streamN:DDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host bridge has established a secure connection via
> +		the platform TSM, symlink appears. The primary function of this
> +		is have a system global review of TSM resource consumption
> +		across host bridges. The link points to the endpoint PCI device
> +		at domain:DDDD bus:BB device:DD function:F.

Do we need the name to link to include the sbdf?  Maybe just streamN
is enough. It's a little fiddly to get the spdf from where that goes, but not
that challenging.

For user ls -lf /sys/class/tsm/tsm0/* should work for instance.

I don't care strongly about this. Maybe one for Bjorn.



