Return-Path: <linux-pci+bounces-26410-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8EA970AF
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2D2A1894D3C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5D528F939;
	Tue, 22 Apr 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkUY/ptD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7D28F92A;
	Tue, 22 Apr 2025 15:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335639; cv=none; b=Fo1NfE3DhGcK3Vxw++ylfzKZmwVFPJU5VDe9RDIR+EoEjeWMW12YE7JIb58jou2+xCbADsrWMMF1DLmDVDphVTxqwsrHXXgwh8eZCN0QA5N/qJLlpUW/r3opjk1JVe5mexAdfs2+mvyL7cUNpIpBDFxCHQn28dHw6nVeNxf1pbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335639; c=relaxed/simple;
	bh=DijUCZu/aFgIZUTId4Wp/83yaBWCR+x9g9MDmtu59Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXPeeaaawFlyp+kGwrWo7kjibNPWNJfWMLVKl3+uoDdlL+ZwY8ueoxxffHIqbTIgfTzRb7/U8atKGxq1oBfJLafqRCeNJ6D1hqI/dhELTl1DQ3HnSiUGWLYwCDeIsqSGDH7KEsBNcudNdXwpiDkDMzFoyrnjxIVRzSPGUnLkv0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkUY/ptD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A655C4CEE9;
	Tue, 22 Apr 2025 15:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745335638;
	bh=DijUCZu/aFgIZUTId4Wp/83yaBWCR+x9g9MDmtu59Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkUY/ptDJC3ucQ3Sa7XqwtzdbmxUyT7CmBCFBsZZVTTUxxDyk8GqwZeGT3+QM5Jpx
	 aG1JgFthxwT6rkkrFn0xzAT3SRUFBIIjQo/dHyICqiHjeRewlYX0eXGdkJdw7AJeIA
	 Wx3JUpV9UWr/PCGOzk3GIju6qSrS/Rp1s/z7vmNRJn9XsTtlGKj6b5voyiQJhNJX35
	 BgofOfGH9aqB2T/9GHo3IzM201Cp38W0TDxIi8abAAmLHG7pSafZ3SE9c5sZ19eKtl
	 DrmX90C9THweuYU9FrT89XD/yQdA7julT/eFp0PAdAXy8Gh5si6GbrSBXNhzOLXphW
	 4DoWGagcx+maw==
Date: Tue, 22 Apr 2025 17:27:13 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 0/2] rust/revocable: add try_access_with() convenience
 method
Message-ID: <aAe1UZqD61pn9bKV@cassiopeiae>
References: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411-try_with-v4-0-f470ac79e2e2@nvidia.com>

On Fri, Apr 11, 2025 at 09:09:37PM +0900, Alexandre Courbot wrote:
> This is a feature I found useful to have while writing Nova driver code
> that accessed registers alongside other operations. I would find myself
> quite confused about whether the guard was held or dropped at a given
> point of the code, and it felt like walking through a minefield; this
> pattern makes things safer and easier to read according to my experience
> writing nova-core code.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

With the following changes, applied to nova-next, thanks!

  * link `None`, `Some`, `Option` in doc-comment

- Danilo

