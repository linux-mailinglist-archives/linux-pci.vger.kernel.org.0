Return-Path: <linux-pci+bounces-33106-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95151B14D07
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 13:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E952718A35C6
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 11:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415D828CF6A;
	Tue, 29 Jul 2025 11:28:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078528D829;
	Tue, 29 Jul 2025 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788504; cv=none; b=DVm55Mc0qig/RJpIaeZk5OypxT7kx5H3s72fH1JwZw25pguDHAD2vnkMwnfbMkTWZlJJKz7MO69ufa6H5gpG5ObvhIU+6S4EMonFfiaSTK3eI1UUycaQO4bdzh7hVJxfUY9mzGs9zwMyBFuilzJPvKu5XDfFqy4phNinjt46h5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788504; c=relaxed/simple;
	bh=95KnHoEI2OnNA8bds9YbjE3P0QGj3btAA1vLBgfUonA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aewmfbgj8CWRtPoYYbFLv815K5hV02bsOdmF/wStrYoWJJzRisay/suwZl4u9YWTUZ2PhWO730PloimLcER6zaH+H7fyt63zHGX+lVtKISEcZeYuRHu9XR6/YDsqt80BpUlYziy5jRZJdtoEKYO0Iqw57zzdOlHXtIG+S2f4LbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brtMw6Bc1z6M4PM;
	Tue, 29 Jul 2025 19:26:36 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 36FF114038F;
	Tue, 29 Jul 2025 19:28:11 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 13:28:05 +0200
Date: Tue, 29 Jul 2025 12:28:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Xiaoyao Li <xiaoyao.li@intel.com>, Isaku Yamahata
	<isaku.yamahata@intel.com>, Yilun Xu <yilun.xu@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, John Allen <john.allen@amd.com>, "Aneesh Kumar K.V
 (Arm)" <aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 01/10] coco/tsm: Introduce a core device for TEE
 Security Managers
Message-ID: <20250729122802.00004aac@huawei.com>
In-Reply-To: <20250717183358.1332417-2-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-2-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:49 -0700
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
> Cc: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Isaku Yamahata <isaku.yamahata@intel.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: John Allen <john.allen@amd.com>
> Co-developed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Nice. One trivial comment inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index f918bbb61737..c0c3733be165 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -2,9 +2,11 @@
>  #
>  # Confidential computing related collateral
>  #
> +

Unrelated change.

>  obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>  obj-$(CONFIG_ARM_PKVM_GUEST)	+= pkvm-guest/
>  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
>  obj-$(CONFIG_ARM_CCA_GUEST)	+= arm-cca-guest/
> +obj-$(CONFIG_TSM) 		+= tsm-core.o
>  obj-$(CONFIG_TSM_GUEST)		+= guest/


