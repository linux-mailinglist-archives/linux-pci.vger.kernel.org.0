Return-Path: <linux-pci+bounces-33392-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB3EB1AA8D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 23:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72867189CF41
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 21:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFB222259E;
	Mon,  4 Aug 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRkCIw47"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E1634;
	Mon,  4 Aug 2025 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754344349; cv=none; b=d1IeqrUJNwqcOyAIAosvbI0fkW9Le0g8ENWfOfFzpaD3Qs6u4m5EzQx01k402nA9vVLm8bqyVbET1Hz74r1YePGNxfGlo+MHf1S9rppGFAn4qk2QU4kQRxTtAdyEiy86Q3b19W6eV7KBAu/xG1XdJjTRA1ST5JbApex9wa5d8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754344349; c=relaxed/simple;
	bh=rLV4kTNP6xbv8+l9VQYq3ZMbQ7UGSERvE+LOo6qumgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JOYOT53YbKlNM0GOzU5/mQ9r7ZknrnfOQK2M6bSq/nVeYD7Ao+oQRX4DiOvSxX3gUQRgFXf0dTRHh4AouuRdS/ISPvxaJCLYHaQgP/bue1P26fgsSRzXtkj3XCqYm4T5DT6+ztj7wBtbh12OAD516XyVCxTf29NV/3yxMfwhgJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRkCIw47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E16CAC4CEE7;
	Mon,  4 Aug 2025 21:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754344349;
	bh=rLV4kTNP6xbv8+l9VQYq3ZMbQ7UGSERvE+LOo6qumgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sRkCIw47ngdZqhotgjMx0Hc3pct7iRy+6IBEsglcb1owbtPEzcDnfgmG9gMFqcJtE
	 br3ebBqK4IaZ81FTfBcvluLir0RotKHxzvpk/rs28Es19/6ObovFSQtnFNLbEdvTmS
	 2WpIfk7TbIwoXDTEZK2g/sh0keWzLflnYw5PE0RtweU4iGmNQ+whplYNsY2eKJDYKz
	 t/dSAxhSJq1VvkkHiX0FSUTjldCkzNkgkSJq3AJWxVKKZJXabbrEV8FPCWxSxNlo7X
	 oU+/Gh09jXjRjbAcxaznTPYVfsbU42mfIOfLxVU5MopScM67vTUyGo9fyggA0hb4DG
	 UjLfgtf3hoHdQ==
Date: Mon, 4 Aug 2025 16:52:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 03/38] tsm: Move dsm_dev from pci_tdi to pci_tsm
Message-ID: <20250804215227.GA3643759@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-4-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:40PM +0530, Aneesh Kumar K.V (Arm) wrote:

Subject line should include "PCI" prefix.

Needs a commit log, even if it repeats what's in the subject.  Would
also be good to know *why* this is desirable.

> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>  drivers/pci/tsm.c       | 72 ++++++++++++++++++++++++-----------------
>  include/linux/pci-tsm.h |  4 +--
>  2 files changed, 45 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/tsm.c b/drivers/pci/tsm.c
> index 794de2f258c3..e4a3b5b37939 100644
> --- a/drivers/pci/tsm.c
> +++ b/drivers/pci/tsm.c
> @@ -415,15 +415,55 @@ static enum pci_tsm_type pci_tsm_type(struct pci_dev *pdev)
>  	return PCI_TSM_INVALID;
>  }
>  
> +/* lookup the Device Security Manager (DSM) pf0 for @pdev */

s/lookup/Look up/ (it's a verb here)
 
> +static struct pci_dev *dsm_dev_get(struct pci_dev *pdev)
> +{
> +	struct pci_dev *uport_pf0;
> +

Remove this blank line ...

> +	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);

and add one here.

> +	if (!pf0)
> +		return NULL;
> +
> +	if (pf0 == pdev)
> +		return no_free_ptr(pf0);
> +
> +	/* Check that @pf0 was not initialized as PCI_TSM_DOWNSTREAM */
> +	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0)
> +		return no_free_ptr(pf0);
> +
> +	/*
> +	 * For cases where a switch may be hosting TDISP services on
> +	 * behalf of downstream devices, check the first usptream port
> +	 * relative to this endpoint.

s/usptream/upstream/

> +	 */
> +	if (!pdev->dev.parent || !pdev->dev.parent->parent)
> +		return NULL;
> +
> +	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
> +	if (!uport_pf0->tsm)
> +		return NULL;
> +	return pci_dev_get(uport_pf0);
> +}
> +
>  /**
>   * pci_tsm_initialize() - base 'struct pci_tsm' initialization
>   * @pdev: The PCI device
>   * @tsm: context to initialize
>   */
> -void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
> +int pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm)
>  {
> +	struct pci_dev *dsm_dev __free(pci_dev_put) = dsm_dev_get(pdev);
> +	if (!dsm_dev)
> +		return -EINVAL;
> +
>  	tsm->type = pci_tsm_type(pdev);
>  	tsm->pdev = pdev;

Add blank line before comment.

> +	/*
> +	 * No reference needed because when we destroy
> +	 * dsm_dev all the tdis get destroyed before that.

"tdi" looks like an initialism, which would normally be capitalized.

> +	 */
> +	tsm->dsm_dev = dsm_dev;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_initialize);
>  
> @@ -447,7 +487,8 @@ int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm)
>  	}
>  
>  	tsm->state = PCI_TSM_INIT;
> -	pci_tsm_initialize(pdev, &tsm->tsm);
> +	if (pci_tsm_initialize(pdev, &tsm->tsm))
> +		return -ENODEV;
>  
>  	return 0;
>  }
> @@ -612,32 +653,6 @@ int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>  }
>  EXPORT_SYMBOL_GPL(pci_tsm_doe_transfer);
>  
> -/* lookup the Device Security Manager (DSM) pf0 for @pdev */
> -static struct pci_dev *dsm_dev_get(struct pci_dev *pdev)
> -{
> -	struct pci_dev *uport_pf0;
> -
> -	struct pci_dev *pf0 __free(pci_dev_put) = pf0_dev_get(pdev);
> -	if (!pf0)
> -		return NULL;
> -
> -	/* Check that @pf0 was not initialized as PCI_TSM_DOWNSTREAM */
> -	if (pf0->tsm && pf0->tsm->type == PCI_TSM_PF0)
> -		return no_free_ptr(pf0);
> -
> -	/*
> -	 * For cases where a switch may be hosting TDISP services on
> -	 * behalf of downstream devices, check the first usptream port
> -	 * relative to this endpoint.
> -	 */
> -	if (!pdev->dev.parent || !pdev->dev.parent->parent)
> -		return NULL;
> -
> -	uport_pf0 = to_pci_dev(pdev->dev.parent->parent);
> -	if (!uport_pf0->tsm)
> -		return NULL;
> -	return pci_dev_get(uport_pf0);
> -}

This code move looks like it could be a separate patch that only moves
(and fixes the typos I mentioned).

Then a second patch could do what the subject claims (moving dsm_dev
from pci_tdi to pci_tsm) so it's not buried in the simple move.

>  /* Only implement non-interruptible lock for now */
>  static struct mutex *tdi_ops_lock(struct pci_dev *pf0_dev)
> @@ -695,7 +710,6 @@ int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id)
>  		return -ENXIO;
>  
>  	tdi->pdev = pdev;
> -	tdi->dsm_dev = dsm_dev;
>  	tdi->kvm = kvm;
>  	pdev->tsm->tdi = tdi;
>  
> diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
> index 1920ca591a42..0d4303726b25 100644
> --- a/include/linux/pci-tsm.h
> +++ b/include/linux/pci-tsm.h
> @@ -38,7 +38,6 @@ enum pci_tsm_type {
>   */
>  struct pci_tdi {
>  	struct pci_dev *pdev;
> -	struct pci_dev *dsm_dev;
>  	struct kvm *kvm;
>  };
>  
> @@ -56,6 +55,7 @@ struct pci_tdi {
>   */
>  struct pci_tsm {
>  	struct pci_dev *pdev;
> +	struct pci_dev *dsm_dev;
>  	enum pci_tsm_type type;
>  	struct pci_tdi *tdi;
>  };
> @@ -173,7 +173,7 @@ void pci_tsm_core_unregister(const struct pci_tsm_ops *ops);
>  int pci_tsm_doe_transfer(struct pci_dev *pdev, enum pci_doe_proto type,
>  			 const void *req, size_t req_sz, void *resp,
>  			 size_t resp_sz);
> -void pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
> +int pci_tsm_initialize(struct pci_dev *pdev, struct pci_tsm *tsm);
>  int pci_tsm_pf0_initialize(struct pci_dev *pdev, struct pci_tsm_pf0 *tsm);
>  int pci_tsm_bind(struct pci_dev *pdev, struct kvm *kvm, u64 tdi_id);
>  int pci_tsm_unbind(struct pci_dev *pdev);
> -- 
> 2.43.0
> 

