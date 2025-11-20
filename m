Return-Path: <linux-pci+bounces-41826-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7E9C75D45
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AB204E0737
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028C2287265;
	Thu, 20 Nov 2025 17:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3UKBPiND"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DE2F49ED;
	Thu, 20 Nov 2025 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661498; cv=none; b=m25d8iC5x5/vd8jV5uhtlak1OAsPskPrdwQCbnUyOYsFZzG6iVLG6xesrOJGCdBQkLgdGGwjHn2/jY/d18swPDdmmVJ0jHAJyjhimm547U49VmaI5sXasFyJphFBoHmN9DEk82Loc8WZTJmA+xUW78sNLsNBgRIGGAH9WdcEAvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661498; c=relaxed/simple;
	bh=QkaqeS2vBSCn4HapEgxEsYw/JGemPDqat0ypE+Fmq0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZQMi40lrHMnCP56cfL0gG986ZZDoeB1EdYU/yyiIUTSkdZABa2wqRrBPp0hJCxDhh92doyJ3Wkt2qKMtM4+zCkOhVgDIoxFj3PlJHkvDRhqrTiO2uHNVrUx53AbtRbMq15Uy7sRstEPgKCY4BL87LVShX4IW/EJISNCYe9QN+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3UKBPiND; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=QkaqeS2vBSCn4HapEgxEsYw/JGemPDqat0ypE+Fmq0s=;
	b=3UKBPiNDBG5by3W0PRr66Oa7vHkg7rj749caN+d9NXQC6yxqUUBjpZ8qzmx3c1iAqgZc7mJuF
	zZIhlvaotF4IF5RMaw/n+WAp10z/OllYjlJyMURGAtBKSheNbQdztC04ZAxjFoVdk+SoAkpNeJY
	u9Zc/s6JWCdFADjRy/TSYN0=
Received: from frasgout.his.huawei.com (unknown [172.18.146.33])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dC5dl1dprz1vnNw;
	Fri, 21 Nov 2025 01:56:59 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5fC5lnMzJ46B9;
	Fri, 21 Nov 2025 01:57:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A25911402FD;
	Fri, 21 Nov 2025 01:58:09 +0800 (CST)
Received: from localhost (10.48.159.58) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 17:58:08 +0000
Date: Thu, 20 Nov 2025 17:58:07 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH v2 10/11] coco: arm64: dma: Update force_dma_unencrypted
 for accepted devices
Message-ID: <20251120175807.00007c2e@huawei.com>
In-Reply-To: <20251117140007.122062-11-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-11-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:30:06 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> This change updates the DMA behavior for accepted devices by assuming
> they access only private memory. Currently, the DMA API does not provide
> a mechanism for allocating shared memory that can be accessed by both
> the secure realm and the non-secure host.
>=20
> Accepted devices are therefore expected to operate entirely within the
> private memory space. As of now, there is no API in the DMA layer that
> allows such devices to explicitly request shared memory allocations for
> coherent data exchange with the host.

Isn't this sentence a bit of a repeat of the one at the end of the
1st paragraph.

>=20
> If future use cases require accepted devices to interact with shared
> memory=E2=80=94 for example, for host-device communication, we will need =
to
> extend the DMA interface to support such allocation semantics. This
> commit lays the groundwork for that by clearly defining the current
> assumption and isolating the enforcement to force_dma_unencrypted.
>=20
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>



