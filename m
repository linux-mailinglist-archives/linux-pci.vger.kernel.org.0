Return-Path: <linux-pci+bounces-33402-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A153DB1AAEB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 603733A7566
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81DBE23AE62;
	Mon,  4 Aug 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCh9xGt7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD6628FAB7;
	Mon,  4 Aug 2025 22:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346494; cv=none; b=ZRFdMSfURvH5TiTe9FlrI7ayUBhGASlc+eYmb2plMagHzTomSjZ9uMIVeQPHf4xU27ADXGBMIh3tPo6gkr53fWlGODy1l4ZbnBGkyOdcsq253JTdQeisA6VXYrZoV8nEAMrm3YmBwqUApW/rdLJt/QOYK9tcHSsgLgXPbdCZAX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346494; c=relaxed/simple;
	bh=VEDdtnrXmtStkhq9z4lMyQxccc8EH1cR7PNQK/h2aM0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hgNga9iinfRdpYrjj80qdypPvuWvGr5tY+7945sHcPn0haSECU9x1L9wxW/SOqJshIPMQtMhQWk8GKh2ALwcLmrYiIPQBz/YUgy7rbwRW576Sr1F7w8FasybtBfYISxzamYLq7KLBc4MGptRRd+z2LmlGhtQicNob/3Bz1dAg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCh9xGt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFCC4C4CEE7;
	Mon,  4 Aug 2025 22:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346493;
	bh=VEDdtnrXmtStkhq9z4lMyQxccc8EH1cR7PNQK/h2aM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qCh9xGt7imyzFiPPprdhjYQzJD/Ew0iJCh1fXw7SgUUXmPgUimPFmb9WaeFR6izSj
	 uFl1srLFYOKN1h5HOPknLWl4DSUY0amvSs+lN8xRQ5FJiayzm4i+L9q5zqBQ7pSIok
	 0rEGrjAZP0j2oqpWn3H1hiNFKx/20KVFes/aCK0Y1J+U7FlPPDlkeo3z1aD7d2L3MU
	 I6/uDTmzQ7TFQFjPKEsULq2RY7EovuxTBZphnBKAIvFUGc+4NdFKost3eF9zxaVVY6
	 0U3Dj3hOhzCbcKKwVlukK+SA7PpD6gviacgD3jrgjJTfTSNU1v4gIkKgkfg0Bawzok
	 FoP+RdkkgAYLQ==
Date: Mon, 4 Aug 2025 17:28:12 -0500
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
Subject: Re: [RFC PATCH v1 13/38] coco: host: arm64: Create a PDEV with rmm
Message-ID: <20250804222812.GA3644946@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-14-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:21:50PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Create the realm physical device with RMM.

> +++ b/drivers/virt/coco/arm-cca-host/arm-cca.c
> @@ -124,7 +124,15 @@ static int cca_tsm_connect(struct pci_dev *pdev)
>  	rc = tsm_ide_stream_register(pdev, ide);
>  	if (rc)
>  		goto err_tsm;
> -
> +	/*
> +	 * Take a module reference so that we won't call unregister
> +	 * without rme_unasign_device

s/rme_unasign_device/rme_unassign/

> +	 */
> +	if (!try_module_get(THIS_MODULE)) {
> +		rc = -ENXIO;
> +		goto err_tsm;
> +	}
> +	rme_asign_device(pdev);

s/rme_asign_device/rme_assign_device/

