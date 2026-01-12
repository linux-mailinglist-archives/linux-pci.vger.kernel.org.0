Return-Path: <linux-pci+bounces-44535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE248D14472
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 18:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EBB031080CD
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 17:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC58E2DA755;
	Mon, 12 Jan 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7WuLX/0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982862836B0;
	Mon, 12 Jan 2026 17:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237569; cv=none; b=CfycItiLIaIsWeT3JYw535uVQOIH9cZ4UtVSQ7XfI634YU3lT0NK8iE1YllBu1jE6oGiLl5/ojYn58l/vVftF2TflwhNjXmbXqqM86pDyFbAzWIw3LPOVTKcNLlsB+OM7HdKCirQFUqyvoQzQk9a+CjG2FOtYc6TW9D0Tecp/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237569; c=relaxed/simple;
	bh=Pr37ndEPEGBHQ3SNp9MEyEAqdphptiMyEXrlNZyg+oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Jvj/7SDj2Mno5bY4/9joqpyEj5GrCpjDIZXqWbaE7OXcUjE7fTTfgEKHdQT5sgG9uXMq1BWIN4QYTQbgMF2z1v+tXQImbEQxEE8tirdpVVTKH2/efIKJY3BESw/tT9uiS3989W2ep3hkERRDQPqAXHDboz6IsFh6EyL5udF1dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7WuLX/0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 056AFC116D0;
	Mon, 12 Jan 2026 17:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768237569;
	bh=Pr37ndEPEGBHQ3SNp9MEyEAqdphptiMyEXrlNZyg+oQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A7WuLX/0Uz5VqUXKV/VA0f4fk7F5pnp+RsvoRFsOBp0xFSvc4pxVl2JDnIWCKsX65
	 2KyridHCHNH4scuzwfABXlnvl6QGDFc5hfA4eKiVGAALYIFoHscf2t7nELxEjJFn35
	 n3ll7yQLXlnlks+LwC43PsOsi5Rj5v5zbzhOHa8Sj8qsX7XFZcBL5HqJfs2U3vjuRI
	 ukys33vg/N7ZBSh9XStSAvP0Xh2q5i9mSE8q9pwCXv1wRN7KTO0EVU9Y8HwETaL2T3
	 +V6HDLH97WKZnF58U8s9YeH9X0LRf9uATduFOkzl/cP5ixJ8sxlFBAAEH9Us6DJkDf
	 h/lM7V/uPy12A==
Date: Mon, 12 Jan 2026 11:06:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Dirk Behme <dirk.behme@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	kernel test robot <lkp@intel.com>, Liang Jie <liangjie@lixiang.com>,
	Drew Fustini <fustini@kernel.org>, David Gow <davidgow@google.com>
Subject: Re: [PATCH v2] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
Message-ID: <20260112170607.GA715555@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251226113938.52145-1-boqun.feng@gmail.com>

On Fri, Dec 26, 2025 at 07:39:38PM +0800, Boqun Feng wrote:
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
> Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Closes: https://lore.kernel.org/rust-for-linux/20251209014312.575940-1-fujita.tomonori@gmail.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512220740.4Kexm4dW-lkp@intel.com/
> Reported-by: Liang Jie <liangjie@lixiang.com>
> Closes: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-buaajxlj@163.com/
> Fixes: 473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is disabled")
> Reviewed-by: Drew Fustini <fustini@kernel.org>
> Reviewed-by: David Gow <davidgow@google.com>
> Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>
> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Applied to pci/for-linus for v6.19, thanks!

I updated the commit log like this:

  PCI: Provide pci_free_irq_vectors() stub

  473b9f331718 ("rust: pci: fix build failure when CONFIG_PCI_MSI is
  disabled") fixed a build error by providing Rust helpers when
  CONFIG_PCI_MSI is not set. However the Rust helpers rely on
  pci_free_irq_vectors(), which is only available when CONFIG_PCI=y.

  When CONFIG_PCI is not set, there is already a stub for
  pci_alloc_irq_vectors().  Add a similar stub for pci_free_irq_vectors().

> ---
> v1 --> v2:
> 
> * Add Reported-by from FUJITA Tomonori, kernel test robot and Liang Jie.
> * Add Reviewed-by tags.
> 
> Thanks!
> 
> Liang Jie, I added you as Reported-by because of [1], if you prefer not
> to have that tag, feel free to let me know, thanks!
> 
> [1]: https://lore.kernel.org/rust-for-linux/20251222034415.1384223-1-buaajxlj@163.com/
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

