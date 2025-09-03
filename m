Return-Path: <linux-pci+bounces-35390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4BB424F8
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 17:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6973ACE62
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 15:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210C4225409;
	Wed,  3 Sep 2025 15:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPL/qy/b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D36225408;
	Wed,  3 Sep 2025 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912682; cv=none; b=dTR+C0g95zZOA90YkT3E9nVr7i0acKQF8BZ+5m2TKRTQnBSjiLkmBNgu5Xb37fQlvauMW1E5kRy4hjP+0u9O8AY2IePk98r5MHsJPWpPcqJk3XtH3WTPF0GE+J7L3uNTom3e6j6EhbwTvXl5QQdktZkUmDmkgwcQV78V+6e5jBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912682; c=relaxed/simple;
	bh=DSV80I41HNdrHgq8ScGZor8qjlma6CCCC2HAyKlmfkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R1y1fvKGcLwK1elcs8FOZfU6zQNoN0GJKLX6hjsBOh6nkxOuzRh+sAJ3F8x0hyo/Nn/dTSoGEY6rubnmpkj/lT3UqF78BAGe8Hfz+dLY7PQcxwpMJNn4HdZ12RrPYTKI3/nrz/QZzgf67IZP1uTFCV+DKVJ2JNK0TpNPlaWHZaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPL/qy/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CD7C4CEE7;
	Wed,  3 Sep 2025 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756912680;
	bh=DSV80I41HNdrHgq8ScGZor8qjlma6CCCC2HAyKlmfkM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=IPL/qy/baUA54iz0l26WqXC7I6vxSBIHps2BTOdpbKZuSfgQSRIkH5klKEzNcAFi5
	 nVV9umg4ur1hmDMmV7W+XjWSY5vXXFdP/ILKGKm1uQHcCGEYcogu3cGruka+pMES8a
	 im18Nw2o91MtYYyi3Bi9pNnrn0X0e1e+HPIeeUqmGs3PWb5I0ea/q40sYq4oXwAFLf
	 fuTYLhJvwvOAnWoxE39VCm31ulxbRTIPJp2HHSy28vUYyf2LLxXzz2AT3P8wbBv6wE
	 nbn0qYtucE4TMDK6YJMO6mwaUKLJnDfp+ysCZ3BH0J8yWuqlI1l3JG61GVRduX+0Tj
	 gauo1LmSe7hAQ==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 1/7] PCI/TSM: Add pci_tsm_{bind,unbind}() methods for
 instantiating TDIs
In-Reply-To: <20250827035259.1356758-2-dan.j.williams@intel.com>
References: <20250827035259.1356758-1-dan.j.williams@intel.com>
 <20250827035259.1356758-2-dan.j.williams@intel.com>
Date: Wed, 03 Sep 2025 20:47:53 +0530
Message-ID: <yq5ay0qv1s66.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:
...

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
> +	const struct pci_tsm_ops *ops;
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
> +	ops = pdev->tsm->ops;
> +
> +	if (!is_link_tsm(ops->owner))
> +		return -ENXIO;
> +
> +	tsm_pf0 = to_pci_tsm_pf0(pdev->tsm);
> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	/* Resolve races to bind a TDI */
> +	if (pdev->tsm->tdi) {
> +		if (pdev->tsm->tdi->kvm == kvm)
> +			return 0;
> +		else
> +			return -EBUSY;
> +	}
> +
> +	tdi = ops->bind(pdev, kvm, tdi_id);
> +	if (IS_ERR(tdi))
> +		return PTR_ERR(tdi);
> +
> +	pdev->tsm->tdi = tdi;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_bind);
> +

Are we missing assigning pdev and kvm in the above function? 

modified   drivers/pci/tsm.c
@@ -356,6 +356,8 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u32 tdi_id)
 	if (IS_ERR(tdi))
 		return PTR_ERR(tdi);
 
+	tdi->pdev = pdev;
+	tdi->kvm = kvm;
 	pdev->tsm->tdi = tdi;
 
 	return 0;

-aneesh

