Return-Path: <linux-pci+bounces-43105-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE24CC1B30
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 10:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A22DF300EE73
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCD82F39A3;
	Tue, 16 Dec 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWVN9lwe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3A42E413;
	Tue, 16 Dec 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876393; cv=none; b=bIiaZTXvjqcNDIAdq9edd1UF3vXP8RQ2+ORG4lkC/O4iQyB0GWl/IkSD/iU8GSCQMEo9Mk6k1CFPKx6sq9WO6JBasOpbS4RcTi613kXKZFYAhVIg2DIuH4zru0d5+uZb6Iw+sJ/YXe1TXb425+Pv6M0TtxKtBm16V8hLi4wuA7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876393; c=relaxed/simple;
	bh=+bQXQluU40rX6u2ZXNQ5SqKPtFENGuQAWMbyvBYnupc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Exy/IJ9XGg8xYJqwonsBcFTwgjf0p3a19foBf7LQ6NsCcEL8FXwbuCUc3twpSh37qNJjUm36/I2Qzxi8Xj6dYfpYx5m5keHG5m45odoq3islRureKdwlelEGarLSvhyQ9BDYbUixqIccPVLyYQEYkIE8dlRrVWrpav7OC+P6wvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWVN9lwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99F22C4CEF1;
	Tue, 16 Dec 2025 09:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765876393;
	bh=+bQXQluU40rX6u2ZXNQ5SqKPtFENGuQAWMbyvBYnupc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RWVN9lweHnBibbTiKH7eLyr6F6YQAgadzFt5KOeUqNbokkf3/zZr09wicU0Tpx4aK
	 e0fAXOB8skaJUk+8A8HKsf9F0IgQV9Jl275MTRBVfqKuBh8Ys3j5VvGoNpQcaoNIYK
	 iDAEWs6wlm+BPD2Du5c3fZfeCVgx4I6rihk9oeniDxHhc4Fmp0qgRwA6dWn5zZ0Gxm
	 DneRAcEMTt8gz2HrcYLtnPrUsa0ygJVgX6U/pDEdOLzbmikw+UtvtLpifm9zG7BDao
	 lpv/L6rGJhDUD/LujpTS7P5e5ahnVtnPu5HdlqUZg/RQKKFiEqYPSB/fG+RNUYrPHO
	 YRMh6WwA/FX6Q==
Message-ID: <f802398c-05e6-444d-9e8d-d37be1c69041@kernel.org>
Date: Tue, 16 Dec 2025 10:13:08 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Provide pci_free_irq_vectors() for CONFIG_PCI=n
To: Boqun Feng <boqun.feng@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
References: <20251215025444.65544-1-boqun.feng@gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20251215025444.65544-1-boqun.feng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/15/25 3:54 AM, Boqun Feng wrote:
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

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

Bjorn, I assume you will pick this up? Otherwise I can pick it up as well, I
will likely send a -fixes PR for -rc2 anyways.


