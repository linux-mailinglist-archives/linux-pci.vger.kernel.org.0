Return-Path: <linux-pci+bounces-23287-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C08BA58E28
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E611657CE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F92236E0;
	Mon, 10 Mar 2025 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="pLvQJdim"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562FF22330F;
	Mon, 10 Mar 2025 08:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741595357; cv=none; b=sZTcqN5QlKXqU4y8qIpw3ON9Zy9vMXF51GmnC7zNOo+UWysjYX35C+uyo1gOgkg04X2ANFknapRlI9xGQ/6PaMr/AvTuo/sTNBnmmMarz0dLyqFMvVgydstv/VUv0SZcj2PTN+TDKme0tPbAl5c/YBDV70bXPGBrP3CBLsHaE/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741595357; c=relaxed/simple;
	bh=frX4G4i69BdoHfaR05B7WfBtiGFjU59BqKAKCBlX6vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZ0oklARkZ+OlLgPGFXjzBHs44wcQzH/4ONOsKD3xsj/x1JkPff8hdTHWQmSCNs3gG7gahKIk/HwAv4SWwQzG12T/F7JOvJOOyRbMmoTToJrE2IO+omg0t0dS5h9ToHjhs4KBv3Zj/zIi9cw+RH6A6SbCs0gHriWAID/KRyxZco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=pLvQJdim; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p4ffe03ae.dip0.t-ipconnect.de [79.254.3.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 1364A45229;
	Mon, 10 Mar 2025 09:29:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1741595354;
	bh=frX4G4i69BdoHfaR05B7WfBtiGFjU59BqKAKCBlX6vc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pLvQJdim6IyNh9OflrLb5oh+e8PpvuLCM7gou4Gbs0/mv/l0Y/CTYc5KJYczw60zh
	 tyB81d0pFn7H4QWWzddDp47l9aIy2fBqzokWlz0g3XJfyBzaHLj7Cw/XF+dOnvcUgx
	 ltV0QEF5YEldt6xlVgABrLyQ8mNC66Vlbe9G+8u9THehDW1Rde0MdBuqOWbjX1VyNw
	 rqWATAisQ6IvQiG29+Xa3szaWqDZjlEB62Nqd/BeNV2EBXhGcEyXVkAdSJvBAaYkOy
	 u8HEDFkVKAkbbvlEbGh0YDF5gu1Oor0qHpQjrXpS2vPEDIswU1Ee60j+y7dGCO00PP
	 lG20mHqj4VUaA==
Date: Mon, 10 Mar 2025 09:29:12 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Charan Teja Kalla <quic_charante@quicinc.com>
Subject: Re: [PATCH v2 0/4] iommu: Fix the longstanding probe issues
Message-ID: <Z86i2BHhmAINErv_@8bytes.org>
References: <cover.1740753261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740753261.git.robin.murphy@arm.com>

On Fri, Feb 28, 2025 at 03:46:29PM +0000, Robin Murphy wrote:
> This spin irons out a couple of issues which v1 had. Firstly there
> should now be no change in behaviour for the weird of_dma_configure()
> calls, other than possibly getting the warning if they deserve it.
> Secondly I think there was still a possibility for probe to run via
> the replay path while its "real" probe was waiting to reacquire the
> lock; this is now solved by making dev->iommu a reliable indicator of
> the probe lifecycle, with a couple more prep patches.
> 
> Thanks,
> Robin.
> 
> 
> Robin Murphy (4):
>   iommu: Handle race with default domain setup
>   iommu: Resolve ops in iommu_init_device()
>   iommu: Keep dev->iommu state consistent
>   iommu: Get DT/ACPI parsing into the proper probe path
> 
>  drivers/acpi/arm64/dma.c        |  5 +++
>  drivers/acpi/scan.c             |  7 -----
>  drivers/amba/bus.c              |  3 +-
>  drivers/base/platform.c         |  3 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  3 +-
>  drivers/cdx/cdx.c               |  3 +-
>  drivers/iommu/iommu-priv.h      |  2 ++
>  drivers/iommu/iommu.c           | 55 ++++++++++++++++++++++++---------
>  drivers/iommu/of_iommu.c        | 13 ++++++--
>  drivers/of/device.c             |  7 ++++-
>  drivers/pci/pci-driver.c        |  3 +-
>  11 files changed, 74 insertions(+), 30 deletions(-)

Applied, thanks Robin.

