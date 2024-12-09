Return-Path: <linux-pci+bounces-17965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E1E9EA12D
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 22:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D3A2814FF
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 21:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403DB198E76;
	Mon,  9 Dec 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyL2iuMA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B56249652;
	Mon,  9 Dec 2024 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733779361; cv=none; b=f5xWlfWtbF70cBS4tUPba0+/zLdXW3t3jsA8laLOVImLCAD1QmKQxZSiusKSrgIaqA6kywaoJiKUy57fdJ2cjS42Oti+EsCDn2kkb+M3ncCVSjYrEqatQrGWiJADvS0oeplIiouHXNm2iTuB9L5ri4gcYjpZO3veBae2lRjfMV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733779361; c=relaxed/simple;
	bh=90Wzf2BnALaciJfqUCZ7IRuSh5rcnWkqt3oeGVrhBSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmV6K+bwJyMCvT9amse25ameJlZXng/bwLwT/so3sqF53hKJ1IPvGOH3f//ndg9pxH1pH5HJsWNda7dQXovc0oeUAicBNPVZ0+ugRdjR3XYFejm7ek6N4lBCamrXa+TewYQ1yK9nRJ/ECiE7WOVZJJR6rZfyFW4mmHsYgYd9/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyL2iuMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A728CC4CED1;
	Mon,  9 Dec 2024 21:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733779360;
	bh=90Wzf2BnALaciJfqUCZ7IRuSh5rcnWkqt3oeGVrhBSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyL2iuMAtJTI9uVas9+prE56V1/izvjQ1oshD7XQGsVR8UXURxuN1jRSdsES8hAXL
	 Zj1RqcA+rs3xREWK4Q5YnmF38wakQvxwj8RJQN4PP4SmBviUqPZp+osi6zfkVIx0vE
	 FTGU37C3MvECg3b2W3i7wb5x3fK97UyrHmQ1Ez1XLdqg6OfRhDDTojvcJsaR8onCq4
	 d9Ift5CgBnjZZrWrwILMcC/biLZpcFkQtmS6MtIrAOoHFehUY9/KFvACiDbXScJAC8
	 3/snmbjWPstWoQnpuduC8R2NNvd4lEMtTNOIyDc2xUMU2t1tJdIEpEzvJGZtLGi74Q
	 ZMmdRykaqyDQw==
Date: Mon, 9 Dec 2024 15:22:38 -0600
From: Rob Herring <robh@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 11/13] rust: of: add `of::DeviceId` abstraction
Message-ID: <20241209212238.GE938291-robh@kernel.org>
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-12-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205141533.111830-12-dakr@kernel.org>

On Thu, Dec 05, 2024 at 03:14:42PM +0100, Danilo Krummrich wrote:
> `of::DeviceId` is an abstraction around `struct of_device_id`.
> 
> This is used by subsequent patches, in particular the platform bus
> abstractions, to create OF device ID tables.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  MAINTAINERS        |  1 +
>  rust/kernel/lib.rs |  1 +
>  rust/kernel/of.rs  | 57 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 59 insertions(+)
>  create mode 100644 rust/kernel/of.rs

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

