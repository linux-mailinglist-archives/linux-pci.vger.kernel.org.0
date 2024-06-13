Return-Path: <linux-pci+bounces-8772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A57F907F1E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 00:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2317C1F235B5
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 22:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82846142636;
	Thu, 13 Jun 2024 22:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWYYGwPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A68713BACB;
	Thu, 13 Jun 2024 22:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718319451; cv=none; b=K4dx1Y0CAvoWxWi5aHd4b2oqmSBN4aWZ4yeOJHKaS9iTRjQEPAWx807q03D0t8bHYg5oSopWkqh6QTgxrl/eL4SCxxXndgtqx6HmYMmaq+DTscJflJNG+e74k2LM7axC3HArABpr9XI1jDINDQGtypFZxNX0IoQRR/BACKEkckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718319451; c=relaxed/simple;
	bh=G7KHocsG4Y5wPaXfjoT2MP9SGdggRXsgr3HMYexyeSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Uk8JXhphmixULcx19O4FOy1z1qQGbIla8/3RoVQSPErERVvMeALba7cQGkkEJh+DxV/zn0zSHqND2aDJMXn5t9T7aVUF57AzZXUodqZghzmzEwq//mZOuWx6GMO6+YFacrO0PGdZ7YKORE9/G8BQRlxe/LZJ0o6LDDx1r4ChpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWYYGwPH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E94BC2BBFC;
	Thu, 13 Jun 2024 22:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718319450;
	bh=G7KHocsG4Y5wPaXfjoT2MP9SGdggRXsgr3HMYexyeSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hWYYGwPH5+Geaw35QopXeST/4lTCIx8ohw1QvONSwsjA02Y38NAASqlrghfqhiWoa
	 Ul6EulWuyfLsgcuA2slA1cNqYJWN8fKCDLrryNkKh6+AyGAoBAIOY5W/pkAhAfndcG
	 /obmdGDBF+EbHr8MpGz/KvOJdjV+dtSSlaLtr9MDfu5ImFCjZVhIBqJAv9LJsChqEK
	 xq6quoyu1NP186TOJUF7a/8A8NAUYV3J09CE+ZtWCgqqOysYQPXAPfH/5rAJkuReM1
	 31mCmNBN4kmCdQX2fEwhDyN7fBuI5r6IIPGv/6jOs+ZQzG5Xa5XAyN0bTeTM2PQjht
	 yL5Cn2PE+peiA==
Date: Thu, 13 Jun 2024 17:57:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: martin.petersen@oracle.com, sathya.prakash@broadcom.com,
	chandrakanth.patil@broadcom.com, ranjan.kumar@broadcom.com,
	prayas.patel@broadcom.com, linux-scsi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 1/3] mpi3mr: Support PCIe Error Recovery callback
 handlers
Message-ID: <20240613225727.GA1089062@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613190022.4128-2-sumit.saxena@broadcom.com>

On Fri, Jun 14, 2024 at 12:30:20AM +0530, Sumit Saxena wrote:
> This patch adds support for the PCIe error recovery callback handlers which is
> crucial for the recovery of the controllers. This feature is necessary for
> addressing the errors reported by the PCI Error Recovery mechanism.

> +++ b/drivers/scsi/mpi3mr/mpi3mr.h

> +mpi3mr_pcierr_detected(struct pci_dev *pdev, pci_channel_state_t state)
> +{
> +	struct Scsi_Host *shost;
> +	struct mpi3mr_ioc *mrioc;
> +	unsigned int timeout = MPI3MR_RESET_TIMEOUT;
> +
> +	dev_info(&pdev->dev, "%s: callback invoked state(%d)\n", __func__,
> +	    state);
> +
> +	shost = pci_get_drvdata(pdev);
> +	mrioc = shost_priv(shost);

This will be a NULL pointer dereference if shost is NULL.  But I think
that's OK, and you don't need the check below, because we should never
get here if either shost or mrioc is NULL unless the code is broken,
and in that case we *want* the NULL pointer oops so we can fix it.

> +	if (!shost || !mrioc) {
> +		dev_err(&pdev->dev, "device not available\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}

> +static pci_ers_result_t mpi3mr_pcierr_slot_reset(struct pci_dev *pdev)
> +{
> +	struct Scsi_Host *shost;
> +	struct mpi3mr_ioc *mrioc;
> +	unsigned int timeout = MPI3MR_RESET_TIMEOUT;
> +
> +	dev_info(&pdev->dev, "%s: callback invoked\n", __func__);
> +
> +	shost = pci_get_drvdata(pdev);
> +	mrioc = shost_priv(shost);
> +
> +	if (!shost || !mrioc) {
> +		dev_err(&pdev->dev, "device not available\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}

Same here.

> +static void mpi3mr_pcierr_resume(struct pci_dev *pdev)
> +{
> +	struct Scsi_Host *shost;
> +	struct mpi3mr_ioc *mrioc;
> +
> +	dev_info(&pdev->dev, "%s: callback invoked\n", __func__);
> +
> +	shost = pci_get_drvdata(pdev);
> +	mrioc = shost_priv(shost);
> +
> +	if (!shost || !mrioc) {
> +		dev_err(&pdev->dev, "device not available\n");
> +		return;
> +	}

Same here.

> +	pci_aer_clear_nonfatal_status(pdev);

Why is there here?  No other driver does this.

> +static pci_ers_result_t mpi3mr_pcierr_mmio_enabled(struct pci_dev *pdev)
> +{
> +	struct Scsi_Host *shost;
> +	struct mpi3mr_ioc *mrioc;
> +
> +	dev_info(&pdev->dev, "%s: callback invoked\n", __func__);
> +
> +	shost = pci_get_drvdata(pdev);
> +	mrioc = shost_priv(shost);
> +
> +	if (!shost || !mrioc) {
> +		dev_err(&pdev->dev, "device not available\n");
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}

Same here.

> +static struct pci_error_handlers mpi3mr_err_handler = {
> +	.error_detected = mpi3mr_pcierr_detected,

I think it's nice if the function name includes the function pointer
name, i.e., ".error_detected = mpi3mr_error_detected" (or
"mpi3mr_pci_error_detected" if you prefer).

That way 'git grep -A5 ".*pci_ers_result_t.*error_detected"' finds
most of them for comparison.

> +	.mmio_enabled = mpi3mr_pcierr_mmio_enabled,
> +	.slot_reset = mpi3mr_pcierr_slot_reset,
> +	.resume = mpi3mr_pcierr_resume,
> +};

