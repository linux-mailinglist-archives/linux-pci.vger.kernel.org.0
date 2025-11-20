Return-Path: <linux-pci+bounces-41828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB1CC75D54
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 18:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id A717D2C0E6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 17:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C02FA0E9;
	Thu, 20 Nov 2025 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FKV4R0de"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA6C2FE05B;
	Thu, 20 Nov 2025 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661557; cv=none; b=ZQ0omR3CYn4x/N6/CO8EJwgh7E1oiWkvICO8SrjFEU+nkDwWE6LHXjn1uw8wfd/YttGryLBs6ozfU8yXd6tAxQ9SvUJSJzT1KR8Xrts6z+p6DGmb39vpmolp3fwHvkQvHuIUI9iio2O9u60X3qYZQ/2qIuwEqsdm7nvkNc2ViDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661557; c=relaxed/simple;
	bh=j8iVfNQHbGBFw5o1AQhqQ85i0Fy/SaPvvDyzmWQ/hhQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AodsjrxgoxEaKXvOoy3CAxoocvPAYfwYoZ1/LMdxx38m6+Bf/L/Hn+EYS6wlVt+8aBsS9B/++kn1OAkDTlwgJCWSgZvxJgRHYZp0ZPyvV28QBvumHm14hkHXtWc0BbW/kplZwxPcmU20KzXkI5/IpbZItSs3XCo8rm+PNkPn/U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FKV4R0de; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=pg8bpfAqZHinwFuZ1N2NkS2NwoQDtiQ4C8zkIv+wGLQ=;
	b=FKV4R0defO4YvLpmPxFdMH0HxV0e16/O0eAGg20uJ6rt+RJx+jQQbTx1IaQ02KiNOthzY7gUh
	GPW7ootpwaWCENWv1jG0yUXX5gTsJ73UrkM7A4XRaa+rckbMyrm59mqlFPGYYA+Uxql4vdHHgpt
	yrf5Jnd9GUuvNUhp2dz714U=
Received: from frasgout.his.huawei.com (unknown [172.18.146.32])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dC5ft4YbZz1vnNw;
	Fri, 21 Nov 2025 01:57:58 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5gY6hBdzHnGhb;
	Fri, 21 Nov 2025 01:58:33 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1FA4714038F;
	Fri, 21 Nov 2025 01:59:09 +0800 (CST)
Received: from localhost (10.48.159.58) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 20 Nov
 2025 17:59:08 +0000
Date: Thu, 20 Nov 2025 17:59:06 +0000
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
Subject: Re: [PATCH v2 11/11] coco: guest: arm64: Enable vdev DMA after
 attestation
Message-ID: <20251120175906.00003560@huawei.com>
In-Reply-To: <20251117140007.122062-12-aneesh.kumar@kernel.org>
References: <20251117140007.122062-1-aneesh.kumar@kernel.org>
	<20251117140007.122062-12-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 17 Nov 2025 19:30:07 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> - define SMC_RSI_VDEV_DMA_ENABLE and add wrapper in rsi_cmds.h
> - invoke the new helper from the guest accept path once the device
>   passes attestation, rolling back to TDI_LOCKED on failure
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>



