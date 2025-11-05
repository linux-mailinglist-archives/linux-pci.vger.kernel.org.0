Return-Path: <linux-pci+bounces-40312-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2BE6C33F66
	for <lists+linux-pci@lfdr.de>; Wed, 05 Nov 2025 05:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9604D3A6D5D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Nov 2025 04:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA492561D9;
	Wed,  5 Nov 2025 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQFcwFem"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC432F29;
	Wed,  5 Nov 2025 04:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318794; cv=none; b=XWEvNslJp4WgoBjM2MFeO3ywW7bJR+M0RuYHa7gGtpB4ysTBIE2MlIrjj3EtyLYRsR9pCO8z74G3fZ+T12u4pO4QbK5gdqYQvXUTQqJVvpChB2XP98tNaYK12lDMr7vk/ppe3SHGKCJ/cEVFwgBoiLISfbFLQHO9VHXzguct9Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318794; c=relaxed/simple;
	bh=10tBe4egETqxC+cAYL/TP8HqGw0PBpQTZ7rM0AOBDmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HpQlVlS23IrEyGVAQJDaa0L/jtTUOGe2WwmC5lkGKOpp+kSPp1QEdhag1HtrxBavmNSiHR4xPvExbR7kovDGOoOE/EhNucC98id08EatjqD6B+XiUnI2UhsXgeGCBlnm25bxN7J4grpOreZHY4IF/6Lgcs2WgcfNHVskx5cPQvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQFcwFem; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D132C4CEFB;
	Wed,  5 Nov 2025 04:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762318794;
	bh=10tBe4egETqxC+cAYL/TP8HqGw0PBpQTZ7rM0AOBDmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=QQFcwFemBQZv597gXPmhOFw9kUTRcXd4v8M7dOq+VKrs3O51ytK3oSTS7buEGv83U
	 yFMS3LEbtxj3XZLk8C6Jp7YhrGTZsem2pYAjGCoCkgjshGADgnfqkBB2B7SkOpcRrE
	 6PTzBnkTcYkWUX+GsciQACoipEKe9LDBEGDcx8axLZ9HYEaCMC0+YaAxapkS22thHD
	 KD/ffaYAR16VYgkVR2wHF1o6smafz6TRIUr88U5rJH7MyyFkmdDns9KmEL9sib7rUR
	 9I6eaSU1jjeaJrgOR7zx46/6ATzgnr9y5babdUZe6JzVzSLpL29qspxGXFyGiFSSBF
	 KYySckpxRTm3A==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org
Cc: linux-coco@lists.linux.dev, bhelgaas@google.com, yilun.xu@linux.intel.com,
	aik@amd.com
Subject: Re: [PATCH 4/6] PCI/TSM: Add pci_tsm_bind() helper for
 instantiating TDIs
In-Reply-To: <20251105040055.2832866-5-dan.j.williams@intel.com>
References: <20251105040055.2832866-1-dan.j.williams@intel.com>
 <20251105040055.2832866-5-dan.j.williams@intel.com>
Date: Wed, 05 Nov 2025 10:29:49 +0530
Message-ID: <yq5aecqdcbwa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dan Williams <dan.j.williams@intel.com> writes:

...

> +/**
> + * pci_tsm_bind() - Bind @pdev as a TDI for @kvm
> + * @pdev: PCI device function to bind
> + * @kvm: Private memory attach context
> + * @tdi_id: Identifier (virtual BDF) for the TDI as referenced by the TS=
M and DSM
> + *
> + * Returns 0 on success, or a negative error code on failure.
> + *
> + * Context: Caller is responsible for constraining the bind lifetime to =
the
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
> +	tsm_pf0 =3D to_pci_tsm_pf0(pdev->tsm);
> +	guard(mutex)(&tsm_pf0->lock);
> +
> +	/* Resolve races to bind a TDI */
> +	if (pdev->tsm->tdi) {
> +		if (pdev->tsm->tdi->kvm =3D=3D kvm)
> +			return 0;
> +		else
> +			return -EBUSY;
> +	}
> +
> +	tdi =3D to_pci_tsm_ops(pdev->tsm)->bind(pdev, kvm, tdi_id);
> +	if (IS_ERR(tdi))
> +		return PTR_ERR(tdi);
> +
> +	pdev->tsm->tdi =3D tdi;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_tsm_bind);

Can we set tdi in the constructor? I use it later as part of a bind()
callback. I=E2=80=99d prefer not to pass tdi as an argument to those functi=
ons,
since functions like do_dev_communicate() are reused in other contexts
where tdi isn't needed.

cca_tsm_bind -> cca_vdev_create -> vdev state transition to VDEV_UNLOCKED.

	/* setup host_tdi before call to device communicate */
	host_tdi =3D to_cca_host_tdi(pdev);
	host_tdi->rmm_vdev =3D rmm_vdev;

	ret =3D submit_vdev_state_transition_work(pdev, RMI_VDEV_UNLOCKED);
	/* failure is treated as rmi_vdev_create failure */
	if (ret)
		goto err_vdev_comm;


static inline struct cca_host_tdi *to_cca_host_tdi(struct pci_dev *pdev)
{
	struct pci_tsm *tsm =3D pdev->tsm;

	if (!tsm || !tsm->tdi)
		return NULL;

	return container_of(tsm->tdi, struct cca_host_tdi, tdi);
}


modified   drivers/pci/tsm.c
@@ -391,8 +391,6 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm,=
 u32 tdi_id)
 	if (IS_ERR(tdi))
 		return PTR_ERR(tdi);
=20
-	pdev->tsm->tdi =3D tdi;
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_tsm_bind);
@@ -998,6 +996,7 @@ static struct pci_dev *find_dsm_dev(struct pci_dev *pde=
v)
 void pci_tsm_tdi_constructor(struct pci_dev *pdev, struct pci_tdi *tdi,
 			     struct kvm *kvm, u32 tdi_id)
 {
+	pdev->tsm->tdi =3D tdi;
 	tdi->pdev =3D pdev;
 	tdi->kvm =3D kvm;
 	tdi->tdi_id =3D tdi_id;

We could do a pci_tsm_tdi_destructor() to reset pdev->tsm->tdi =3D NULL?=20=
=20

-aneesh

