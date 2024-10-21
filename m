Return-Path: <linux-pci+bounces-14934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 708619A5D85
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 09:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A31C213F4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 07:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056CE1E0E05;
	Mon, 21 Oct 2024 07:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qRNNEzhs"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F6B1E0DFE
	for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 07:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729496997; cv=none; b=NuVqG25XY2zStZ8RtEzYpJrUU9fpWKyDgw2aMjhJeRyEXUgaP4x79qW/d9pKyupVJH2GQbHo7Tia2cJMBPuyG2v0PHqMJGFAWUTmkffaFQgT6tspfy8qJDZT/ztLDfuxPN2aGl/LrnZPutWiDcZfQhNS759q+yEuOwf2ued8UG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729496997; c=relaxed/simple;
	bh=6ueq3438Eugt23cQuaxGPReNbER7gxySm/b0l0MuCgc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=pY+LzUZbepr3gX0IPyo3a2NDSOgqyuH4yx06E35J8t/ozX8KfwXsRgUa+KuKAbyeJ/UmHd23WwZMtlZZtqhzwzJxtnEIhFjNFjSwxmcBH9GUgu3/Qmm2NdVfyjUNmPRzykq5nJ/e7evlyLLmDfhHPbA+5JA1Pb5SwTUbaIR8hso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qRNNEzhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327ABC4CEC3;
	Mon, 21 Oct 2024 07:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729496997;
	bh=6ueq3438Eugt23cQuaxGPReNbER7gxySm/b0l0MuCgc=;
	h=Date:From:To:Cc:Subject:From;
	b=qRNNEzhsEx6khXEvywr382zE01xSmcm0whvlhDbA6dL2KXukOf0alLcM+O9y0SfOw
	 0wkN3WKCSzqeOfpd969Jbn5Nnp1d3RxkjBbnF930U5xWVVvv81hwPV6K6+NcJb+qy0
	 BgUhkYbx4V22D+8e3hp1fZKmZ4/O3fAvpA6Rm7ID1UBsuGabmDpeGjkdbLDbLe2L/p
	 YtEINF6y/YH7mOkuGzYdhTfqws7OZ9v04+2m9GcvgDa8Q/0IjYX3m3gA/yqErDm1mk
	 CRDpzRbbMiy+U82FftxvG54CR9NXIGrLOtVSUp6TLl2TKyKAAiTL+tv0WC+46Sw+3t
	 f6UAuAr/ZxFBQ==
Date: Mon, 21 Oct 2024 09:49:54 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
	Damien Le Moal <dlemoal@kernel.org>
Subject: PCI endpoint: pci-epf-test is broken on big-endian
Message-ID: <ZxYHoi4mv-4eg0TK@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello PCI endpoint maintainers,


While looking at the pci-epf-test.c driver, I noticed that
pci-epf-test is completely broken with regards to endianness.

As you probably know, PCI devices are inherently little-endian,
and the data stored in the PCI BARs should be in little-endian.

However, pci-epf-test does no conversion before storing the data
to backing memory, and no conversion after reading the data from
backing memory.

For the data backing test_reg BAR (usually BAR0), which has the
format as defined by struct pci_epf_test_reg, is simply stored
to memory using e.g.:
reg->status = STATUS_WRITE_SUCCESS;

Surely, this should be:
reg->status = cpu_to_le32(STATUS_WRITE_SUCCESS);


Likewise the src and dst address is accessed simply by
reg->dst_addr and reg->src_addr.

Surely, this should be accessed using:
dst_addr = le64_to_cpu(reg->dst_addr);
src_addr = le64_to_cpu(reg->src_addr);

So bottom line, pci-epf-test will currently not behave correctly
on big-endian.



Looking at pci-endpoint-test however, it does all its accesses using
readl() and writel(), and if you look at the implementations of
readl()/writel():
https://github.com/torvalds/linux/blob/v6.12-rc4/include/asm-generic/io.h#L181-L184

They convert to CPU native after reading, and convert to little-endian
before writing, so pci-endpoint-test (RC side driver) is okay, it is
just pci-epf-test (EP side driver) that is broken.

I'm not planning on spending time on this, but I thought that I ought to at
least report it, such that maintainers/developers/users are aware of it.


Kind regards,
Niklas

