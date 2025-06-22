Return-Path: <linux-pci+bounces-30321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F56AE31EE
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219B53AC017
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB891DE881;
	Sun, 22 Jun 2025 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3ipB4xj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F5623BE;
	Sun, 22 Jun 2025 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750623810; cv=none; b=To2TbfbTZvEJ5e3poiqMqz4sVgJz800YrPO6bCUl4kdJfEfIJ7BuzCasXdxklrN5yqsIQoEzu4X+2UeQN/p7XCAFjxCOhJMzqZHh2hd4HQCFwrPFJ0micntqUffQuWViY30TaWAPT9qDigHpOwylye2e+M4D6tmbMDvZp0JyO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750623810; c=relaxed/simple;
	bh=cuh/kTRSf3lg2Zgz1dj/VnQdhGgGAk6gr3v6/+qBxcQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=lh9SCxWat9bgdmn86tVzV1AWWbnfrFk/EPHDNcHUuFhoz5Mju7fpuh9YKyFRNrGcIq3gRmTd4JFEzZrWKkUcPI8OClTnr1LwMSpGYEIn1Ez2iX/krSYOp0FXc//uuhs+Ak4X72sw9SDGbNdDRHL1F9nHSx7PXQgZaaEPgNgIzSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3ipB4xj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2F2C4CEE3;
	Sun, 22 Jun 2025 20:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750623810;
	bh=cuh/kTRSf3lg2Zgz1dj/VnQdhGgGAk6gr3v6/+qBxcQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=I3ipB4xjwDoigNTnXVDuyQnZKf0yLlvyhrXEBfs5ER+a8Ct+g4eP+f4v3NIkaXwnJ
	 LQv8GpYF53kF01t2KXTIgqE3URoZ4GYu0mTAk17jltCKVdywJjwD57mzylyV55EfvP
	 HVs8dPAdt3DsekDNPL7jxCHMu/NZPDOVTGKi5TA0cP9zca3d7XLWP3EhBg7K5RMd8y
	 qXL0ShKbpzdeF25K5SudFEUnWkYqbHuA1wBRWS9ewj4VoxDB7v5Q9+hyajZE8pH1MH
	 9vcXWlOdtGss4acJbgHaZPVYg16gBvOz2RAeifkAd/f6tatknohJehROt1rel9VS82
	 Z1VS+iXKDx/3g==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 22:23:25 +0200
Message-Id: <DATCCHOD9195.2D6WO275DW0CU@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] rust: revocable: support fallible PinInit types
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
X-Mailer: aerc 0.20.1
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-2-dakr@kernel.org>
In-Reply-To: <20250622164050.20358-2-dakr@kernel.org>

On Sun Jun 22, 2025 at 6:40 PM CEST, Danilo Krummrich wrote:
> Currently, Revocable::new() only supports infallible PinInit
> implementations, i.e. impl PinInit<T, Infallible>.
>
> This has been sufficient so far, since users such as Devres do not
> support fallibility.
>
> Since this is about to change, make Revocable::new() generic over the
> error type E.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  rust/kernel/devres.rs    | 2 +-
>  rust/kernel/revocable.rs | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)

