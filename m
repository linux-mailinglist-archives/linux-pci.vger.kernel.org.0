Return-Path: <linux-pci+bounces-39644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B05C1ADB5
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4175347F96
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9983346B1;
	Wed, 29 Oct 2025 13:33:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23AB248F64
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744837; cv=none; b=PprFYIQjUt3Y3XquY5nVBzucdPhyLqI+MCxtnoNkc9M8jzFSviTbuJJR4Ym33Lqh0bSBkk81Wq48s/xkIVelcr1vJuXEFph0XvTOrfX8eglH1Wt+HPDVjN/i4spd89agPQJn30FLPfqzlsDZRZhn3KKIL24J9CfzR4bJ2z/qnc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744837; c=relaxed/simple;
	bh=jlev8PE/xgx2AUTioaa7Y5hmKoVv5SOK7CK6euPPQys=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzNI+3dQfyS755xPrl1G+iuDtfEMJn7zEuBvPriugA0aitmtStqqLpPi91baQmWf5OcOTFjl/CrigQHg5wURXa4GAC85XILAuV23YtyRYLJSeo9twTTgPqTK7S5faOdhvRhdsOdqcTb31lDpDkmfYwQaELPGstcUgTlo51v1Lb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cxSr52c0vzJ46C9;
	Wed, 29 Oct 2025 21:33:41 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 35D7A140373;
	Wed, 29 Oct 2025 21:33:51 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 13:33:50 +0000
Date: Wed, 29 Oct 2025 13:33:49 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 1/9] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <20251029133349.000057cf@huawei.com>
In-Reply-To: <20251024020418.1366664-2-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Thu, 23 Oct 2025 19:04:10 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A "TSM" is a platform component that provides an API for securely
> provisioning resources for a confidential guest (TVM) to consume. The
> name originates from the PCI specification for platform agent that
> carries out operations for PCIe TDISP (TEE Device Interface Security
> Protocol).
> 
> Instances of this core device are parented by a device representing the
> platform security function like CONFIG_CRYPTO_DEV_CCP or
> CONFIG_INTEL_TDX_HOST.
> 
> This device interface is a frontend to the aspects of a TSM and TEE I/O
> that are cross-architecture common. This includes mechanisms like
> enumerating available platform TEE I/O capabilities and provisioning
> connections between the platform TSM and device DSMs (Device Security
> Manager (TDISP)).
> 
> For now this is just the scaffolding for registering a TSM device sysfs
> interface.
> 
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Dan,

My usual problem of having forgotten all the details since I last
looked applies, so I'll take another look at the lot.

One trivial comment below.

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> new file mode 100644
> index 000000000000..a64b776642cf
> --- /dev/null
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
Maybe worth updating as in general this has evolved a bit this year
I think.

> +
> +static void put_tsm_dev(struct tsm_dev *tsm_dev)
> +{
> +	if (!IS_ERR_OR_NULL(tsm_dev))
> +		put_device(&tsm_dev->dev);
> +}
> +
> +DEFINE_FREE(put_tsm_dev, struct tsm_dev *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_tsm_dev(_T))

I'm entirely on board with the normal argument behind the !IS_ERR_OR_NULL()
check and the fact it lets the compiler remove an indirect call in some
cases.  However, here you have the protection here and in put_tsm_dev()
that is only called via this path.  That seems excessive.







