Return-Path: <linux-pci+bounces-29058-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8EFACF8D2
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEEF189B414
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 20:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC0C27C875;
	Thu,  5 Jun 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGgYBYmZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1142D27A127;
	Thu,  5 Jun 2025 20:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749155604; cv=none; b=NvC8eQ/JJA46dCJrfsq/p7plzQpqVzRj9NxFgT1dUf+YpodZZMZkIvGZCFNjG0WEJAmrxX/WJbb5nSj+sFPuFxYE2fiGO9/Y+8koYfVJJekmf/+UISP2sD+Cre6+0Mzf/nRROoAnFYmzZ9HFJVyFPjvewCl0I4Clxi3NPFDFPAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749155604; c=relaxed/simple;
	bh=LqPpE5uLwfjDAz02pBK0TvjVK+8DTskFli7aSpfSgTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWzS8Y6/4BKNdb+ZrNAVwxlDwIxL+pEQ+OxysJAuzqDEB9xTlrnNfOtbkq6WslaIW4CqZxt6eH18i6pgkDjsdByoqBRZ2Fkut4m4uUzMJHfGAbSXryaTib+NSIFljnKnjG/kg0YpguLAemVNYeU3suRDpZiu7DKeXJUNbIpUlWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGgYBYmZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3E2C4CEEB;
	Thu,  5 Jun 2025 20:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749155603;
	bh=LqPpE5uLwfjDAz02pBK0TvjVK+8DTskFli7aSpfSgTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGgYBYmZH9f1+FHgAlKdJCFw3jcobKPBsADjisneQVg6NP1ZRlONu4cHfBk9VdvUb
	 8WY/35dj6D69eCiUuDUnTyg7mNCfxbI7bilnru7s8SbaZ9lC1WzPsrI9KxYfNsGgfd
	 OWRET5ZnD0SaxKHZAa5J9BI2FGqt9nX6aV0Qf8XKLgQ/e8whLiFBQ6k+vRN0MC+NJl
	 IaegNTAgV1mXAyMPY0YGHwjKFkMHQiyqNyUgLdrM6jRblJknAlyjt/gIHSTpVj0Qcs
	 +SsSQGUvvJEWIwqtrjBJBsBW4Z0XGoX8GmZPO9A4JbVD0Tr1WhAeiJLYwdby+Nokjw
	 2AYg7EL9aswlg==
Message-ID: <f1a055d9-ba72-43cd-8e01-7017fd586be4@kernel.org>
Date: Thu, 5 Jun 2025 22:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Tamir Duberstein
 <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/5/25 9:55 PM, Andreas Hindborg wrote:
> The current implementation of `ForeignOwnable` is leaking the type of the
> opaque pointer to consumers of the API. This allows consumers of the opaque
> pointer to rely on the information that can be extracted from the pointer
> type.
> 
> To prevent this, change the API to the version suggested by Maira
> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
> constant, which specifies the alignment of the pointers returned by
> `into_foreign`.
> 
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Maíra Canal <mcanal@igalia.com>
> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

I think having the pointer type be `crate::ffi::c_void` was much more convenient
for users of the API anyways. :)

	Acked-by: Danilo Krummrich <dakr@kernel.org>

