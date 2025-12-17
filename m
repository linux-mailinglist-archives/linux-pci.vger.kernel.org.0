Return-Path: <linux-pci+bounces-43231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F65BCC906A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 332CA30394B8
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230CC31A570;
	Wed, 17 Dec 2025 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qerOCDLz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F041F03D2;
	Wed, 17 Dec 2025 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765991506; cv=none; b=pOsjijNAFzsefsJigClPEKP0O74OAU7IKHh1xYh3SpnhLqvykcApuxjF0OV/mId7xmBSvTroCtIiYnpYqF3lQEi2Et2BvEhfXC83hHOapUvlE6fQNLPGqPXcZTUhD52i//qRxqndJFbYmyBJJzvnMFdb/6+HsTQgevVH09rBIjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765991506; c=relaxed/simple;
	bh=/nAgd19KAMs4LUvJxmr3iCiCNJhEBirgf/j0tblLL2Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=d6XcjOEjRNhlARxKzgJyjckRlScqv31QFTyCM4Xjv2Nkz1S6Cpg+EyVPgCA05znX907R04v656xlIzFtlYOyAW0KMiw4TuR48SKWjyeCEG52n8AGoRa402qFV4UyAJFNh5Va/IvOAnewlXCUiCot/TbgLUDU15Ht9Q0k/2f/dMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qerOCDLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8A5C4CEF5;
	Wed, 17 Dec 2025 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765991505;
	bh=/nAgd19KAMs4LUvJxmr3iCiCNJhEBirgf/j0tblLL2Q=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=qerOCDLzpCYaAy9dZCJb1iCe+iYs3fRQGUKndNbUJZiaQinehTx4Uw+e+8IqgJGtD
	 NcKp9lRpDjqiW4Pwsl8HJ1D5bPoM6bKkq9h1CLEiZH6IgtiZk8aQeaAe708r2SDJKF
	 wbiCV3H5nWu901IyA5wA6/4FxTICQcN+7hlaLaQIGNVFHcFnKUNgYZqoridrSjN2cM
	 /G8L4iM5wmM0xrfKv9MZuyKii543WrMZ7Dg/Eyn/LC16jsazPwgYxvYzT1DaqQgyGM
	 nQVu/JHY59hfBDsuSi8c+251k1qm0oKiERBRbGmTop5c0pB92NmEflJXbUMvTdPbNw
	 tTVT3ocMkkDZA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Dec 2025 18:11:42 +0100
Message-Id: <DF0NQO5QIZW1.36J2HDK070HC2@kernel.org>
Subject: Re: [PATCH 2/2] samples: rust: fix endianness issue in
 rust_driver_pci
Cc: <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <miguel.ojeda.sandonis@gmail.com>, <dirk.behme@de.bosch.com>,
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <stable@vger.kernel.org>
To: "Marko Turk" <mt@markoturk.info>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251210112503.62925-1-mt@markoturk.info>
 <20251210112503.62925-2-mt@markoturk.info>
In-Reply-To: <20251210112503.62925-2-mt@markoturk.info>

(Cc: stable@vger.kernel.org)

On Wed Dec 10, 2025 at 12:25 PM CET, Marko Turk wrote:
> MMIO backend of PCI Bar always assumes little-endian devices and
> will convert to CPU endianness automatically. Remove the u32::from_le
> conversion which would cause a bug on big-endian machines.
>
> Signed-off-by: Marko Turk <mt@markoturk.info>
> Fixes: 685376d18e9a ("samples: rust: add Rust PCI sample driver")

Applied to driver-core-linus, thanks!

