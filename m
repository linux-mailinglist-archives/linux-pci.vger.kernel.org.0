Return-Path: <linux-pci+bounces-35448-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E662AB43C2E
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 14:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00E93A8F52
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446002EB871;
	Thu,  4 Sep 2025 12:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj1aK+kp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C12F39A7;
	Thu,  4 Sep 2025 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990613; cv=none; b=LcprCiIOgR7ZsBNJsQKZgfLVGHPaqjExVqJI9KGDwdYNr+K4OmpP1bHFtzhaXAOohS8T+9pFBF4BlzHb2dkQNqP/+eNzJqozHodOowaXLWsatDLLz15wfPjueV3ZrIdgz3rWxzn/SgouzJuiRWPGsjttuI8ajIrTGw+bW1Vx8Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990613; c=relaxed/simple;
	bh=nig2XtmgG0NDq6V062UJX0zyjynE8UgbQRgVhM49DAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ReGugoHiRMbB3DI+e4+pGoOEoF39gtvLkCl1s0Lg5qAlGQ4OVMTiF6wVHPQaHiEv/8f/lGSajkb7sEdGsZqFDq7DBI/BdUi/67MdXk17YpAFu7XsDxyx/rxYWrHjAOlrD6CPSmshksELCWUBsg/7WW6b277yWbw47wBTbLv6eB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj1aK+kp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3B4C4CEF0;
	Thu,  4 Sep 2025 12:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756990612;
	bh=nig2XtmgG0NDq6V062UJX0zyjynE8UgbQRgVhM49DAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Yj1aK+kpMyhMiaAGvcCcPIbaKvXyYTmV7GrCehqPwJ1eQjO0K6BtUBQNIUcz68Qr7
	 c1pPPNVLs1QIRI3UZgeowruRF6iN+/+q4P8mFPW1s7INYe8q809TMG6E9DQ4GQ/AvC
	 Ev3GmNDTMlznE/xY/aAM6AYyZDphJWNbipC0ZG82qbhupJNV2LaEhghAiSalvF39Ds
	 jO6GDG5ZOeCmIKb3lT7Mm4wJoVe7XVo+YKnds79ZWI8nXpjQrpg5zfE0FYuMCAhCd8
	 RwgwqjDjrNwGga/mRkijRtlGZSG8qRi4MMwnJd8d89DQxYg5zboXM6louXac+h8xia
	 G+rUwSYm0viLw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
In-Reply-To: <9db48807-2a9a-4854-8735-90bfafbaeb6f@amd.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
 <yq5ay0qv1s66.fsf@kernel.org>
 <9db48807-2a9a-4854-8735-90bfafbaeb6f@amd.com>
Date: Thu, 04 Sep 2025 18:26:43 +0530
Message-ID: <yq5aseh21ilw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexey Kardashevskiy <aik@amd.com> writes:

> On 4/9/25 01:17, Aneesh Kumar K.V wrote:
>> Dan Williams <dan.j.williams@intel.com> writes:
>> ...
>> 
>>> +/**
>>> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
>>> + * @pdev: PCI device function to bind
>>> + * @kvm: Private memory attach context
>>> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TSM and DSM
>>> + *
>>> + * Returns 0 on success, or a negative error code on failure.
>>> + *
>>> + * Context: Caller is responsible for constraining the bind lifetime to the
>>> + * registered state of the device. For example, pci_tsm_bind() /
>>> + * pci_tsm_unbind() limited to the VFIO driver bound state of the device.
>>> + */
>>> +int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>>> +{
>>> +	const struct pci_tsm_ops *ops;
>>> +	struct pci_tsm_pf0 *tsm_pf0;
>>> +	struct pci_tdi *tdi;
>>> +
>>> +	if (!kvm)
>>> +		return -EINVAL;
>>> +
>>> +	guard(rwsem_read)(&pci_tsm_rwsem);
>>> +
>>> +	if (!pdev->tsm)
>>> +		return -EINVAL;
>>> +
>>> +	ops = pdev->tsm->ops;
>>> +
>>> +	if (!is_link_tsm(ops->owner))
>>> +		return -ENXIO;
>>> +
>>> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
>>> +	guard(mutex)(&tsm_pf0->lock);
>>> +
>>> +	/* Resolve races to bind a TDI */
>>> +	if (pdev->tsm->tdi) {
>>> +		if (pdev->tsm->tdi->kvm == kvm)
>>> +			return 0;
>>> +		else
>>> +			return -EBUSY;
>>> +	}
>>> +
>>> +	tdi = ops->bind(pdev, kvm, tdi_id);
>>> +	if (IS_ERR(tdi))
>>> +		return PTR_ERR(tdi);
>>> +
>>> +	pdev->tsm->tdi = tdi;
>>> +
>>> +	return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
>>> +
>> 
>> Are we missing assigning pdev and kvm in the above function?
>> 
>> modified   drivers/pci/tsm.c
>> @@ -356,6 +356,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
>>   	if (IS_ERR(tdi))
>>   		return PTR_ERR(tdi);
>>   
>> +	tdi->pdev = pdev;
>
> This signals that this pdev backref is not exactly needed :)
>

I need that in cca_tsm_unbind

static void cca_tsm_unbind(struct pci_tdi *tdi)
{
	struct realm *realm = &tdi->kvm->arch.realm;

	rme_unbind_vdev(realm, tdi->pdev, tdi->pdev->tsm->dsm);
	module_put(THIS_MODULE);
}


-aneesh

