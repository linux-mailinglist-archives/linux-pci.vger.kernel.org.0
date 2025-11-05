Return-Path: <linux-pci+bounces-40355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EFFC36573
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8347C3461A8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC0B34D3BD;
	Wed,  5 Nov 2025 15:31:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581D6214812
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356692; cv=none; b=aqoH6b9etAwOfzR7hrHRTkyG8VPAoX4mOFFpfBqhnWfX2OWOuinZlIlhGTYZAk+39EeFpT2u+B6wCbP59tONjJ9/VZTJ/3sCL31yYzQq7Jisv2eb7l8WnsV+YHxf39jevvYv4NPKnwbvc2tbl/WE3IeKGlxIQcbDc7+fdUrpK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356692; c=relaxed/simple;
	bh=BiyCvQO32whuFSmAPn1qkb8ztGbONNB2ZKDytlrp9eo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzMpcfuQErEqAnesDRckSiDPYuH1UXSvcqOrHezIJukrecNF4A1RMVcIHK4lPMSZAOzhcsTIKYxuPao7YoHU41TKMfmliEKHy/cFu1xby+oimOVNTyeJv75yyDLiPhS0RDLKUULOsGcb99/Ha7h/CWewMUoeFIW8azKjFjdSHlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1q6g1f6kzHnGcV;
	Wed,  5 Nov 2025 23:31:23 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C3CEC1402A5;
	Wed,  5 Nov 2025 23:31:28 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 15:31:28 +0000
Date: Wed, 5 Nov 2025 15:31:26 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>
Subject: Re: [PATCH 4/6] PCI/TSM: Add pci_tsm_bind() helper for
 instantiating TDIs
Message-ID: <20251105153126.00002a0a@huawei.com>
In-Reply-To: <20251105040055.2832866-5-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-5-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue,  4 Nov 2025 20:00:53 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> After a PCIe device has established a secure link and session between a TEE
> Security Manager (TSM) and its local Device Security Manager (DSM), the
> device or its subfunctions are candidates to be bound to a private memory
> context, a TVM. A PCIe device function interface assigned to a TVM is a TEE
> Device Interface (TDI).
> 
> The pci_tsm_bind() requests the low-level TSM driver to associate the
> device with private MMIO and private IOMMU context resources of a given TVM
> represented by a @kvm argument. A device in the bound state corresponds to
> the TDISP protocol LOCKED state and awaits validation by the TVM. It is a
> 'struct pci_tsm_link_ops' operation because, similar to IDE establishment,
> it involves host side resource establishment and context setup on behalf of
> the guest. It is also expected to be performed lazily to allow for
> operation of the device in non-confidential "shared" context for pre-lock
> configuration.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial comments only from me.

> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 6a2849f77adc..f0e38d7fee38 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c


> +/**
> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
> + * @pdev: PCI device function to bind
> + * @kvm: Private memory attach context
> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
> + *
> + * Returns 0 on success, or a negative error code on failure.
> + *
> + * Context: Caller is responsible for constraining the bind lifetime to the
> + * registered state of the device. For example, pci_tsm_bind() /
> + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
> + */
> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	struct pci_tdi *tdi;
> +
> +	if (!kvm)
> +		return -EINVAL;
> +
> +	guard(rwsem_read)(&pci_tsm_rwsem);
> +
> +	if (!pdev->tsm)
> +		return -EINVAL;
> +
> +	if (!is_link_tsm(pdev->tsm->tsm_dev))
> +		return -ENXIO;
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	/* Resolve races to bind a TDI */
> +	if (pdev->tsm->tdi) {
> +		if (pdev->tsm->tdi->kvm == kvm)
> +			return 0;
I'd flip so the error case is out of line. Then drop the else.


		if (pdev->tsm->tdi->kvm != kvm)
			return -EBUSY;

		return 0;

> +		else
> +			return -EBUSY;
> +	}
> +
> +	tdi = to_pci_tsm_ops(pdev->tsm)->bind(pdev, kvm, tdi_id);
> +	if (IS_ERR(tdi))
> +		return PTR_ERR(tdi);
> +
> +	pdev->tsm->tdi = tdi;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_bind);



