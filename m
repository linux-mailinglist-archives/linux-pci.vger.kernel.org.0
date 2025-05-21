Return-Path: <linux-pci+bounces-28224-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23483ABF963
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 17:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10AD9E02D6
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 15:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39BFB21931C;
	Wed, 21 May 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3w61wKl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF22192F4;
	Wed, 21 May 2025 15:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747841552; cv=none; b=jjD2AniNnGJ0F2h4Y/RbvFfJ1IJPxdT6fJCrnr1W0JACip+tPaRK1VdeLQRauHaudNgP4U2I98TuB8p5zkLENKXUUsBmPIeCd2ya43OIfw2zsof+2Ny3KvYmgjtN7YAg87DwEoxiKWoEGdyEAKILFOA4AD1XZDuwkIq0ABmoaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747841552; c=relaxed/simple;
	bh=LMtuE9dsKh98YmZuBP64WyO1t0zlGdMJ2SeiCRQiOrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oZoGQZLF79asHOLW7tZA+Wr0BbkVH12Ws15DYeFbde3DCd9uifGiL3TiIQu2arXl0h+dhPNl76ikcaKGb4ViZqmBuZI2UuK5q6zm8xFE2ERfAihc+toYtD1+SPpv2wxnB/zRIeAOfuLBj0cNupSBg5Tm+PeUzx52dRpohM/MnB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3w61wKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63316C4CEE4;
	Wed, 21 May 2025 15:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747841551;
	bh=LMtuE9dsKh98YmZuBP64WyO1t0zlGdMJ2SeiCRQiOrE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=u3w61wKlZFZGWiWBLOwGFyjpDI6J6ZqI0rCGxUHe/U0/e+37qG4a2Pt0ZPJ3hr5Rt
	 q+IAOJeh7PUjcZl3ODW/VX6lC9Y0XDjUSatAxwS7ENEmT1pCTG76WgLttz7n/xTKEH
	 ll2wGkJAFLtILbnKpGIuKUpgTheKdzS3rfppCRJZxniTb/Bxyg/bVL+ly0PGVeWCKV
	 tADDADQyj8V1aJ/AurQwYjlHG6JKcEr/IJKSg6qwEquBnOm3erkzjbDAs/3Sjr6a6A
	 vIS6V6xopbV6/cGil0GnYEg0CxWfnln9AfOFWAiDBCbXD8XCz0O28+WOcrVnDFWAQp
	 sXzn7a0u63O4A==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, suzuki.poulose@arm.com,
	sameo@rivosinc.com, aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 03/13] PCI/TSM: Authenticate devices via platform TSM
In-Reply-To: <20250516054732.2055093-4-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-4-dan.j.williams@intel.com>
Date: Wed, 21 May 2025 21:02:23 +0530
Message-ID: <yq5ajz6a3rp4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

....

> +static void pci_tsm_pf0_init(struct pci_dev *pdev)
> +{
> +	bool tee_cap;
> +
> +	tee_cap = pdev->devcap & PCI_EXP_DEVCAP_TEE;
> +
> +	if (!(pdev->ide_cap || tee_cap))
> +		return;
>

If we expect to use pci_tsm_pf0_init and is_pci_tsm_pf0() from the
guest, can we have the ide_cap and tee_cap check here? Will that be true
for all devices assigned to the guest?

> +
> +	lockdep_assert_held_write(&pci_tsm_rwsem);
> +	if (!tsm_ops)
> +		return;
> +
> +	/*
> +	 * If a physical device has any security capabilities it may be
> +	 * a candidate to connect with the platform TSM
> +	 */
> +	struct pci_tsm *pci_tsm __free(tsm_remove) = tsm_ops->probe(pdev);
> +
> +	pci_dbg(pdev, "Device security capabilities detected (%s%s ), TSM %s\n",
> +		pdev->ide_cap ? " ide" : "", tee_cap ? " tee" : "",
> +		pci_tsm ? "attach" : "skip");
> +
> +	if (!pci_tsm)
> +		return;
> +
> +	pdev->tsm = no_free_ptr(pci_tsm);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_auth_attr_group);
> +	sysfs_update_group(&pdev->dev.kobj, &pci_tsm_pf0_attr_group);
> +	if (pci_tsm_owner_attr_group)
> +		sysfs_merge_group(&pdev->dev.kobj, pci_tsm_owner_attr_group);
> +}
> +
>
....

> +/* physical function0 and capable of 'connect' */
> +static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pdev->is_virtfn)
> +		return false;
> +
> +	/*
> +	 * Allow for a Device Security Manager (DSM) associated with function0
> +	 * of an Endpoint to coordinate TDISP requests for other functions
> +	 * (physical or virtual) of the device, or allow for an Upstream Port
> +	 * DSM to accept TDISP requests for switch Downstream Endpoints.
> +	 */
> +	switch (pci_pcie_type(pdev)) {
> +	case PCI_EXP_TYPE_ENDPOINT:
> +	case PCI_EXP_TYPE_UPSTREAM:
> +	case PCI_EXP_TYPE_RC_END:
> +		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
> +			break;
> +		fallthrough;
>

here

> +	default:
> +		return false;
> +	}
> +
> +	return PCI_FUNC(pdev->devfn) == 0;
> +}
> +


-aneesh

