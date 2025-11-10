Return-Path: <linux-pci+bounces-40713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38509C47122
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 15:02:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB201886603
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1A9307AEA;
	Mon, 10 Nov 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beqHn+dE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD210228CBC;
	Mon, 10 Nov 2025 14:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762783336; cv=none; b=qzRzWKWZWKrnXMhhUrgHniWmvMhBSYVpvkVJLTXTO+4dy1W39ZlsR9HxqeM0pmprnqBUj2q6dzC8stzyhjO+RtzZ537X3r2wyFMdxz617pXfnR9okFeEtQA9KwodCvFXqOjdba17Ppwvejc42MIAdAKKgKH0LRKFKgTmE/QyWwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762783336; c=relaxed/simple;
	bh=kRwsXVFv1McQ3Dvj5cuxK3qdGt6Zp8GEmPh7L11Pq6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHartHoHZUupQ54qCOH7gYH9WevRpfrptYVxy27IXit6uJ6MXH5zLcuPQDk2fZmqaAmPiUGqpIV0bpv1les1uNrMQII2iwyxiPHZngJPDnLnKZJGdjFkLxIp1AtW56QNtNG9enmK0JgOmfZFHE33wNVF/DuBo09SKW6+1ALWeAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beqHn+dE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803D7C19422;
	Mon, 10 Nov 2025 14:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762783336;
	bh=kRwsXVFv1McQ3Dvj5cuxK3qdGt6Zp8GEmPh7L11Pq6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=beqHn+dEFMF6TBBtFIUbQk20e2unDHEEzqFAseqx1VMPiiixeu0GzDT0ztuC0E6K6
	 HXvc9etRm9K+Kfme2p3YPXOtamnzXnO4UPe6QEBpFfj8VWRJKgnghUfq5SggvC4x8N
	 UTymRzOeKwUyxxevZvjYO7LiX8WJmZNVZt5P5JSgVASRoHPv0HTEenu69ELlPyOm12
	 vlQCDNJbwPIrLOT/+RHu8TXrz08NGiS8IkJIEr5syqFEhFOQ0l82dAjXgzd8iviUcH
	 LNGhdI42I421yxYIGngpyRj1RYM6a7lQUTpBLKMQAEqU5eavAC+9XPnA7HmaCJlB91
	 NbeXBTprGPMBw==
Date: Mon, 10 Nov 2025 16:02:11 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jay Cornwall <Jay.Cornwall@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alexander Schmidt <alexs@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: AtomicOps: Define valid root port capabilities
Message-ID: <20251110140211.GK15456@unreal>
References: <20251110-fix_pciatops-v1-0-edc58a57b62e@linux.ibm.com>
 <20251110-fix_pciatops-v1-1-edc58a57b62e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110-fix_pciatops-v1-1-edc58a57b62e@linux.ibm.com>

On Mon, Nov 10, 2025 at 02:25:05PM +0100, Gerd Bayer wrote:
> Provide the two combinations of Atomic Op Completion size attributes
> that a root port may support per PCIe Spec 7.0 section 6.15.3.1. -
> besides the trivial "No support" - as two new defines.
> 
> Change documentation of pci_enable_atomic_ops_to_root() that these are
> the only ones that should be used. Also, spell out that all requested
> capabilities need to be supported at the root port for enable to
> succeed. Also emphasize that on success, this sets AtomicOpsCtl:ReqEn to
> 1, and leaves it untouched in case of failure.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
>  drivers/pci/pci.c             | 13 +++++++------
>  include/uapi/linux/pci_regs.h |  8 ++++++++
>  2 files changed, 15 insertions(+), 6 deletions(-)

<...>

> +/* PCIe spec 7.0 6.15.3.1: Root ports may support one of 2 sets of Atomic Ops */
> +#define  PCI_EXP_ROOT_PORT_ATOMIC_BASE		\
> +	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
> +	 PCI_EXP_DEVCAP2_ATOMIC_COMP64)
> +#define  PCI_EXP_ROOT_PORT_ATOMIC_FULL		\
> +	(PCI_EXP_DEVCAP2_ATOMIC_COMP32 |	\
> +	 PCI_EXP_DEVCAP2_ATOMIC_COMP64 |	\
> +	 PCI_EXP_DEVCAP2_ATOMIC_COMP128)

Thanks for doing this.

