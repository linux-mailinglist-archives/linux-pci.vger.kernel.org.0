Return-Path: <linux-pci+bounces-38929-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BEDBF7D22
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1999619C1197
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 17:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F134167F;
	Tue, 21 Oct 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BfuC1iWz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A019341650;
	Tue, 21 Oct 2025 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761066318; cv=none; b=qpyeFBf5yCsnKFivhbHSEhaJsVcaMcr3X8Gk+SubcR3SfDwD5DL9RYSruYNLNFEvmAE59PpG0T1K27iMDI3KERxTavJl1A+L5O2MWL4DtnkxeDmkGyGf55ohfsO5KQhTMggTwB6/khO4WovV35+6XlSYnDlJ6Uwen8oFo6Fp8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761066318; c=relaxed/simple;
	bh=nTdwv3Rks8hDE9igPxkMOcHeAQ1oHeXXF17Qtt8UWNo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h4iu3l5jfbja2ro9zolCCsCY+glh7fiNtXek5gpD/62Fd8ZFXo3XUXQwrHrAcjdJSGnQNgCKn2jpVPh1/8eQh0Xe4IbeFu3x6xQv7LaO0v4qVlle9yuSuWmeNOFjWqtAWZTQt6OnMe6nNl3RfXE+bmE569YaAixdfZioyZFlZsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BfuC1iWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2BEC4CEF1;
	Tue, 21 Oct 2025 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761066317;
	bh=nTdwv3Rks8hDE9igPxkMOcHeAQ1oHeXXF17Qtt8UWNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BfuC1iWzEwI9u9n3LOJLbQ9s2OOkABW/X5O5BnhDVairX7hiGIwwWZR016oUFlwhd
	 fLc9xJixm03Nir31F+8FRS2DqKVHlOaKQoMiET30k8XwvAI9JuvZQQlw6Suz9KFJDQ
	 ox4zVMwDHa3Rit7JDT8rwHqFrFE2t7TbqFaIFpnPm5fDtgU+imc8VUidXrarKuoXkR
	 ALUwTwN4+BKPW31Ig46yCYPeG5IKzsXqLPLqkDUKMQ/vfEEH0WkdhZDguNgR5ZfI7A
	 JX7fkvUJzy58mZr5oCilgJPOLWAjHKSuzubpSWTJ22XmZl+JWxkIBF7kI/eJqMo0FQ
	 K4d13AKGqsNnA==
Date: Tue, 21 Oct 2025 12:05:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, pjw@kernel.org, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v8 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <20251021170516.GA1193376@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120349.656553-5-randolph@andestech.com>

On Tue, Oct 14, 2025 at 08:03:48PM +0800, Randolph Lin wrote:
> Add driver support for DesignWare based PCIe controller in Andes
> QiLai SoC. The driver only supports the Root Complex mode.

> + * Setup the Qilai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
> + * Write-Back, Read and Write Allocate mode.

s/Setup/Set up/
s/Qilai/QiLai/

> + * The QiLai SoC PCIe controller's outbound iATU region supports
> + * a maximum size of SZ_4G - 1. To prevent programming failures,
> + * only consider bridge->windows with sizes within this limit.
> + *
> + * To ensure compatibility with most endpoint devices, at least
> + * one memory region must be mapped within the 32-bits address space.
> + */
> +static int qilai_pcie_host_fix_ob_iatu_count(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct device *dev = pci->dev;
> +	struct resource_entry *entry;
> +	/* Reserved 1 ob iATU for config space */
> +	int count = 1;
> +	bool ranges_32bits = false;
> +	u64 pci_addr;
> +	u64 size;
> +
> +	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		if (resource_type(entry->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		size = resource_size(entry->res);
> +		if (size < SZ_4G)
> +			count++;
> +
> +		pci_addr = entry->res->start - entry->offset;
> +		if (pci_addr < SZ_4G)
> +			ranges_32bits = true;
> +	}
> +
> +	if (!ranges_32bits) {
> +		dev_err(dev, "Bridge window must contain 32-bits address\n");
> +		return -EINVAL;

Is this really a PCI host controller driver probe failure?  I assume
there are devices that only have 64-bit BARs and could work fine
without a 32-bit window?

If a device requires a 32-bit BAR, and the PCI core can't assign such
an address, and gracefully decline to enable a device where we
couldn't assign the BAR, I think that would be preferable and would
identify the specific device that doesn't work.

> +	}
> +
> +	pci->num_ob_windows = count;
> +
> +	return 0;
> +}


