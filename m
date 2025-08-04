Return-Path: <linux-pci+bounces-33405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE5CB1AAF6
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CAB8C4E1EE4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC421146C;
	Mon,  4 Aug 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3L80y8n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971092E3700;
	Mon,  4 Aug 2025 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346664; cv=none; b=EP9urAx/Tobg8Rca4UtRhGRlSlTkgNxvG9zB0BmgWbocJUFRDAHIuYRGGk/EOzgI7TuZxudNRHrIUvKp06oSz+rIYFFFSGDt+/THrpsrW4/zMa5OUY8NkYJDUgsQ/tduRuoYjTLrrhrms07q7gYR2vhTzu18S/AJIqHw/DwZkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346664; c=relaxed/simple;
	bh=8USLv3eV5SxOmYlHxmUidi/yf9NbyJsTn0iAiPTq1fU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=gbPMybXJDmAQ5tTwDNJyCZICzxwzYWzLHSxQoDixFOUKI1EWkwk7WZOlHdomAXXjii483cJkAHEeYLqfXsVm2g7OjavU6XA2zB28DEO94zAsns+6ai/DP3+xr6GZXoQ7Ckk+9yYUfNS1R+OvdF3f5iwo+BtbMB5yMK2NaWcQYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3L80y8n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD44C4CEE7;
	Mon,  4 Aug 2025 22:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346664;
	bh=8USLv3eV5SxOmYlHxmUidi/yf9NbyJsTn0iAiPTq1fU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A3L80y8nrARmpwX5FrasJdjMlYExoPRIKB6C3GcEiiYv5aHzxjXkWbW2xXio6QdZu
	 AWU9B67rLEPkL4uJvxMQLOCWHHnTLUKMb155uuFdoiXhsp2d7NaGnplaVt/djliOxF
	 X0JOpt5kUFb42BIYPKUUFRwjSOBqidnJSSzQcvX7a5VmVcBytI7jk4o7j6GZYAGSeB
	 BMXHkBjMpGerIOYZo7ihXfjJGQULBtA2dVcpIDp+q4D47YRSJP7GCTDwFuSyfng0Y0
	 Tq0KBgV9N7OqITOxhEDt4ex+vipDURXO5O58rz0NBf3zagYMBxwKLZ2giWToXt74G6
	 GajCL6rt7sErQ==
Date: Mon, 4 Aug 2025 17:31:02 -0500
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
Subject: Re: [RFC PATCH v1 34/38] coco: guest: arm64: Validate mmio range
 found in the interface report
Message-ID: <20250804223102.GA3645183@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-35-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:22:11PM +0530, Aneesh Kumar K.V (Arm) wrote:
> This starts the sequence to transition the realm device to the TDISP RUN
> state by writing 1 to 'tsm/accept'.

> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c

> +int rsi_update_interface_report(struct pci_dev *pdev, bool validate)
> +{
> +	int ret;
> +	struct resource *r;
> +	int msix_tbl_bar, msix_pba_bar;
> +	unsigned int range_id;
> +	unsigned long mmio_start_phys;
> +	unsigned long mmio_flags = 0; /* non coherent, not limited order */
> +	struct pci_tdisp_mmio_range *mmio_range;
> +	struct pci_tdisp_device_interface_report *interface_report;
> +	struct cca_guest_dsc *dsm = to_cca_guest_dsc(pdev);
> +	int vdev_id = (pci_domain_nr(pdev->bus) << 16) |
> +		PCI_DEVID(pdev->bus->number, pdev->devfn);
> +
> +
> +	interface_report = (struct pci_tdisp_device_interface_report *)dsm->interface_report;
> +	mmio_range = (struct pci_tdisp_mmio_range *)(interface_report + 1);
> +
> +
> +	msix_tbl_bar = get_msix_bar(pdev, PCI_MSIX_TABLE);
> +	msix_pba_bar = get_msix_bar(pdev, PCI_MSIX_PBA);
> +
> +	for (int i = 0; i < interface_report->mmio_range_count; i++, mmio_range++) {
> +
> +		/*FIXME!! units in 4K size*/

I guess you intend to fix this?

> +		/* no secure interrupts */
> +		if (msix_tbl_bar != -1 && range_id == msix_tbl_bar) {
> +			pr_info("Skipping misx table\n");
> +			continue;
> +		}
> +
> +		if (msix_pba_bar != -1 && range_id == msix_pba_bar) {
> +			pr_info("Skipping misx pba\n");

s/misx/MSI-X/ (twice)
s/pba/PBA/

