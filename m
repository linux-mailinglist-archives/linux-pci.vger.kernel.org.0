Return-Path: <linux-pci+bounces-24118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AF7A68D27
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 13:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E7119C79BB
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 12:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA41205E36;
	Wed, 19 Mar 2025 12:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBF37e2z"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC626AF5;
	Wed, 19 Mar 2025 12:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742388427; cv=none; b=Lso1MokhUw04wX/IAdq8vsf9daX3AWf5geUF5yYxBflPox0tNJVxEEpuDxOUr2vTP1xYxMJ79gLarhCZtEzLTIdTgd/f7l7ZkZwbaONmaTidTGvJa4OJaczMOkSdKra41QVWuVtkB4g8cnBLkJATHGxqNXXG62keSbrYjDZIjQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742388427; c=relaxed/simple;
	bh=X9J1PnPn5lBgXzgAIhkqUjIlyTNy/ENvQq/3LghXZeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NvSPSr0OUaVhca5QXuPrZ2VKcxm1dxPLqBncN3DAyZwXZ8NhOiJ/R2yxrJlEvisUcF0pOaaP1nAeqfp+AryWktiRdMVDZ8WlVk27k/vyDWc9EXWGpfFjNfGy0O5T4aYCAVsT/h2zSUl2CpDQZHHPFuSPpuQDExdHAMZlO+INUyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBF37e2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0145C4CEE9;
	Wed, 19 Mar 2025 12:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742388426;
	bh=X9J1PnPn5lBgXzgAIhkqUjIlyTNy/ENvQq/3LghXZeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBF37e2zH7LR1ZWo3xZuxBq050/6YHyg8D7yTBKVfLDYVKYKYG6IPoskeiYaFCRKx
	 Q620l3kV3M3wETOYsK+NLFixM7+3Dh/SLK9WS7tXmw2wN0HIFB0SDlNsX47wba//pP
	 0ftDSi760ihKZi6T3Nv99+YGeVrdnEmi2odLUKtzSRilQyelnhp/D2ILSEUtw3GRMe
	 l6QjWKkMjXywDzfOFB7pjXqdR7T/dxdRK3S1lqFH9bMlhXoOs4i5n7oRRs2pfSPO34
	 juEI5VPavKy7Z0a/68agtzfM5wB2wgFbXDpeGRf6u2utf8L6XBdVWH1vx8E/LvXnId
	 i0uFzjtevdUBA==
Date: Wed, 19 Mar 2025 13:47:01 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: pci: impl Send + Sync for pci::Device
Message-ID: <Z9q8xcsAYhQjIpe4@cassiopeiae>
References: <20250318212940.137577-1-dakr@kernel.org>
 <Z9qy-UNJjazZZnQw@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9qy-UNJjazZZnQw@google.com>

On Wed, Mar 19, 2025 at 12:05:13PM +0000, Alice Ryhl wrote:
> On Tue, Mar 18, 2025 at 10:29:21PM +0100, Danilo Krummrich wrote:
> > Commit 7b948a2af6b5 ("rust: pci: fix unrestricted &mut pci::Device")
> > changed the definition of pci::Device and discarded the implicitly
> > derived Send and Sync traits.
> > 
> > This isn't required by upstream code yet, and hence did not cause any
> > issues. However, it is relied on by upcoming drivers, hence add it back
> > in.
> > 
> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> 
> I have a question related to this ... does the Driver trait need to
> require T: Send?

The driver trait does not have a generic, it doesn't need one. But I think I
still get what you're asking.

The driver trait never owns a shared reference of the device, it only ever gives
out a reference that the driver core guarantees to be valid.

> The change itself LGTM, so:
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Alice

