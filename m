Return-Path: <linux-pci+bounces-21753-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E7A3A325
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 17:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A9C188D9E2
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2025 16:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9572126E169;
	Tue, 18 Feb 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgsPvl7W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB2246348
	for <linux-pci@vger.kernel.org>; Tue, 18 Feb 2025 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897286; cv=none; b=oaVtjGEf687iclRarVTudJ8xATMOZQ782WcxU1ZsoHfcMn0f7EW0g52UylfVM6LMmjg4PdEB95KQd5eSeZPPp2b9sgbSAjZCfmwOXpzV0nOQstV5Ne7ELpz2VvREv7RqUBCjjEMCm988OqWZjdWySlYLITNS9S/avcicREP+erQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897286; c=relaxed/simple;
	bh=unlpfRql/ValI8v25Qh2Hw9Dmew1C8fw2o0Y/nSuvBI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KNpETe5deCXZTPH70QMG+wTdEr4qL+Lu2F0zNVRi2mL2xNFxSG97pQs1oZTh35asFIN9zX58s09991n9fGvREHyRYZa7xcOa6mzdzxG0/ZXBDeY/dm/6YGhiKfe6MYeKZQ5CWfNs595CiRkyOE+dMW5whF5PKHIY7sZyrkG2HQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgsPvl7W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE53BC4CEE2;
	Tue, 18 Feb 2025 16:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739897285;
	bh=unlpfRql/ValI8v25Qh2Hw9Dmew1C8fw2o0Y/nSuvBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sgsPvl7WWacc0AU9FXajKAe01OvlJ6rwZdij3X92HI+XT3FpS+MG15q98H71sR2as
	 vlKi2TpcJAUf0KADlcWRNwgZrhJwR8zJ4O0BdI6oNUgUpTVofwfHcZH38N/FguMGlA
	 FqoiShiOaYLYjwKWaqq9ghYQI/SnHbrnzybuC4K07LqYIkBV9Uq7PZIvAa5qiTLkSn
	 Sg5LkLYHwI34oC882cXTzgYWU+dFUZ0QWjGk/oopmkmZkc+vV0Q4tena7eAMsilwV5
	 j8GrB4sb46q62NukDJjD6lwxI+wveY7mr1HMCXhACgKdn/exjVL01vP8LLh1FodMQu
	 hFE9EI01FqIGw==
Date: Tue, 18 Feb 2025 10:48:04 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Udit Kumar <u-kumar1@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 2/7] PCI: endpoint: Add pci_epc_bar_size_to_rebar_cap()
Message-ID: <20250218164804.GA181151@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250131182949.465530-11-cassel@kernel.org>

On Fri, Jan 31, 2025 at 07:29:51PM +0100, Niklas Cassel wrote:
> Add a helper function to convert a size to the representation used by the
> Resizable BAR Capability Register.

> +/**
> + * pci_epc_bar_size_to_rebar_cap() - convert a size to the representation used
> + *				     by the Resizable BAR Capability Register
> + * @size: the size to convert
> + * @cap: where to store the result
> + *
> + * Returns 0 on success and a negative error code in case of error.
> + */
> +int pci_epc_bar_size_to_rebar_cap(size_t size, u32 *cap)
> +{
> +	/*
> +	 * According to PCIe base spec, min size for a resizable BAR is 1 MB,
> +	 * thus disallow a requested BAR size smaller than 1 MB.
> +	 * Disallow a requested BAR size larger than 128 TB.
> +	 */
> +	if (size < SZ_1M || (u64)size > (SZ_128G * 1024))
> +		return -EINVAL;
> +
> +	*cap = ilog2(size) - ilog2(SZ_1M);
> +
> +	/* Sizes in REBAR_CAP start at BIT(4). */
> +	*cap = BIT(*cap + 4);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_bar_size_to_rebar_cap);

This doesn't seem specific to EPC.  It looks basically similar to
pci_rebar_bytes_to_size().  Can we consolidate anything there?

Since we're basing this on the spec, we should include a complete
citation, e.g., PCIe r6.0, sec xxx.

Bjorn

