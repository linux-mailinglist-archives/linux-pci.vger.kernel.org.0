Return-Path: <linux-pci+bounces-40356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DADC36740
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 16:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F2FE622B02
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 15:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E606925A2A4;
	Wed,  5 Nov 2025 15:38:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5B31577D
	for <linux-pci@vger.kernel.org>; Wed,  5 Nov 2025 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357088; cv=none; b=XW99KSVTdifQJDJpKBBEa/7UzNgk6H2sc/WbC3k9IZ9gMW6vMhGPoWzWTMqgaudd8Qe+rQ/KoSDz7l3QsuUD3ujj+2/USiaXk0SRj2VItPVnn6OX08ANQnTFxGRWlL4hqfywSw7OrSwhmewd6FvFKtBtIa+re6sek60rbpiurqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357088; c=relaxed/simple;
	bh=Oe3S+39sj/V0R6yRXCOVv4P+70T/0yOBTI7uMHIlpx4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYWlm0JY0KdAwMBoZAwT0YS43PT/vmcZlv+V22H2k2ZhLkwKhYiepqL+0z0TBuzjTnrUU48BPFJtuAEiegga49uG2ODkazaZHyes39zVgyHVCrLGcl52PjRrvJ7ZyDxS40ePRjstl1/d5CSNTfYGneJECvn3UhAR2v2d3JuqMfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d1qGG3fSDzHnGcV;
	Wed,  5 Nov 2025 23:37:58 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 14FFA1402A5;
	Wed,  5 Nov 2025 23:38:04 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 5 Nov
 2025 15:38:03 +0000
Date: Wed, 5 Nov 2025 15:38:02 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-pci@vger.kernel.org>, <linux-coco@lists.linux.dev>,
	<bhelgaas@google.com>, <aneesh.kumar@kernel.org>, <yilun.xu@linux.intel.com>,
	<aik@amd.com>
Subject: Re: [PATCH 5/6] PCI/TSM: Add pci_tsm_guest_req() for managing TDIs
Message-ID: <20251105153802.00004ddc@huawei.com>
In-Reply-To: <20251105040055.2832866-6-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
	<20251105040055.2832866-6-dan.j.williams@intel.com>
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

On Tue,  4 Nov 2025 20:00:54 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> A PCIe device function interface assigned to a TVM is a TEE Device
> Interface (TDI). A TDI instantiated by pci_tsm_bind() needs additional
> steps taken by the TVM to be accepted into the TVM's Trusted Compute
> Boundary (TCB) and transitioned to the RUN state.
> 
> pci_tsm_guest_req() is a channel for the guest to request TDISP collateral,
> like Device Interface Reports, and effect TDISP state changes, like
> LOCKED->RUN transititions. Similar to IDE establishment and pci_tsm_bind(),
> these are long running operations involving SPDM message passing via the
> DOE mailbox.
> 
> The path for a TVM to invoke pci_tsm_guest_req() is:
> * TSM triggers exit via guest-to-host-interface ABI (implementation specific)
> * VMM invokes handler (KVM handle_exit() -> userspace io)
> * handler issues request (userspace io handler -> ioctl() ->
>   pci_tsm_guest_req())
> * handler supplies response
> * VMM posts response, notifies/re-enters TVM
> 
> This path is purely a transport for messages from TVM to platform TSM. By
> design the host kernel does not and must not care about the content of
> these messages. I.e. the host kernel is not in the TCB of the TVM.
> 
> As this is an opaque passthrough interface, similar to fwctl, the kernel
> requires that implementations stay within the bounds defined by 'enum
> pci_tsm_req_scope'. Violation of those expectations likely has market and
> regulatory consequences. Out of scope requests are blocked by default.
> 
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
More triviality inline.


> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index f0e38d7fee38..4dd518b45eea 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -354,6 +354,69 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_bind);

> +ssize_t pci_tsm_guest_req(struct pci_dev *pdev, enum pci_tsm_req_scope scope,
> +			  sockptr_t req_in, size_t in_len, sockptr_t req_out,
> +			  size_t out_len, u64 *tsm_code)
> +{
> +	struct pci_tsm_pf0 *tsm_pf0;
> +	struct pci_tdi *tdi;
> +	int rc;
> +
> +	/*
> +	 * Forbid requests that are not directly related to TDISP
> +	 * operations
> +	 */

	/* Forbid requests that are not directly related to TDISP operations */
Is just under 80 chars.


> +	 */


