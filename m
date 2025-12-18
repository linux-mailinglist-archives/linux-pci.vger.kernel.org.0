Return-Path: <linux-pci+bounces-43241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8E3CCA46D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 06:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F3130194D9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 05:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6936238D54;
	Thu, 18 Dec 2025 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIw10Cyt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7712E1DDA24;
	Thu, 18 Dec 2025 05:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766034231; cv=none; b=aWnMI10S2axG/iCWTizReTkmOjWS0zj2hPnW3TluF1KTIc0Kdv4nQSavEwkLFU76Fhuirir3En0lwhpSIMpj6IjnThROmcRLHRst6shGOq0ZOzs9hXfEsjH0DRqyWDMg5jEXbk/NQudNckEBhnOWNZC5juldJ3io7oy2maXDJ94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766034231; c=relaxed/simple;
	bh=CH4SzLUDUwJuvoXn4WB03rskv1cVp/0VReJeVhrLttM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZou4ZMjJUtUgFTgf0LMp9PbxKjhfFrq5mKXNZt+/dgLkYXhaXufim705XKcfY6QS0GiwPP9gAjL0Xx8OZxj/mmUAf2gsMezVXrvtp9sdCDy+CI6jUucdZwGk36TXbPg9F7Es2BOcenaanrErVuX8kqz7FBOOD6PkPqgpQDrNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIw10Cyt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB8BC4CEFB;
	Thu, 18 Dec 2025 05:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766034231;
	bh=CH4SzLUDUwJuvoXn4WB03rskv1cVp/0VReJeVhrLttM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vIw10CytQ4J33F+dIGoWSnBJ7tl4c7VP4jT8iVhCHWc1T4HxyTHI+fxqDZxHNlNSf
	 eW/z2ygU/zRjOl3AN5ZQdeM4DQzHrhgeqTegd561BRIChC6k/DXDYDlPaWrDWKjF7r
	 uzFOyziiRxOh3/C4k/G85zV3EAYOjcfwdrkKGw9tEABoP+GYexX7DeJDuE3QfOx9wB
	 PwMYu+urVoXQtgsuCU0n0Lrj31dX0qS0GkPuj2LpmG8vk5JXBzqAuXqPCVpReMb6PY
	 zZL8Re64hHqp+HoWNEm2qZdbd2lMsZgknu8OA+WuGiS56dw3h4SOm8cHgBF1FQLO7J
	 Ra70/vIIa/FNQ==
Date: Wed, 17 Dec 2025 21:03:49 -0800
From: Drew Fustini <fustini@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Message-ID: <aUOLNXDeC0Fq4pHc@x1>
References: <20251215025444.65544-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215025444.65544-1-boqun.feng@gmail.com>

On Mon, Dec 15, 2025 at 11:54:44AM +0900, Boqun Feng wrote:
> Commit 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI
> is disabled") fixed a build error by providing rust helpers when
> CONFIG_PCI_MSI=n. However the rust helpers rely on the
> pci_alloc_irq_vectors() function is defined, which is not true when
> CONFIG_PCI=n. There are multiple ways to fix this, e.g. a possible fix
> could be just remove the calling of pci_alloc_irq_vectors() since it's
> empty when CONFIG_PCI_MSI=n anyway. However, since PCI irq APIs, such as
> pci_alloc_irq_vectors(), are already defined even when CONFIG_PCI=n, the
> more reasonable fix is to define pci_alloc_irq_vectors() when
> CONFIG_PCI=n and this aligns with the situations of other primitives as
> well.
> 
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> I hit a build error without this:
> 
> ../rust/helpers/pci.c:36:2: error: call to undeclared function 'pci_free_irq_vectors'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>    36 |         pci_free_irq_vectors(dev);
>       |         ^
> ../rust/helpers/pci.c:36:2: note: did you mean 'pci_alloc_irq_vectors'?
> ../include/linux/pci.h:2208:1: note: 'pci_alloc_irq_vectors' declared here
>  2208 | pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>       | ^
> 1 error generated.
> 
> when ./tools/testing/kunit/kunit.py run --make_options LLVM=1 --arch arm64 --kconfig_add CONFIG_RUST=y  rust_doctests_kernel
> 
>  include/linux/pci.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 864775651c6f..b5cc0c2b9906 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2210,6 +2210,10 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  {
>  	return -ENOSPC;
>  }
> +
> +static inline void pci_free_irq_vectors(struct pci_dev *dev)
> +{
> +}
>  #endif /* CONFIG_PCI */
>  
>  /* Include architecture-dependent settings and functions */
> -- 
> 2.51.0
> 

Reviewed-by: Drew Fustini <fustini@kernel.org>

Thanks for the fix. I ran into this when building next-20251217 for a
machine without PCIe and was happy to find this on lore.

Drew

