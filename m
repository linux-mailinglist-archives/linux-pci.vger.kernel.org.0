Return-Path: <linux-pci+bounces-30517-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56DAE6B2C
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D822F3A401A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F212E175E;
	Tue, 24 Jun 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQlJUGTV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADE42D8DC4;
	Tue, 24 Jun 2025 15:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750778310; cv=none; b=lZxGd95g7a6Cc/vNGPh9vIHPDWroW5dJwExXiASJUAKIXzGUue6vnEaCGebr+TZQ+z3PQKrzh3uscreulKGyOUUWPqDqTIjFp9ewUaszgeAApT50w12ahKt/K6gvwesB6Ql7Z3VHwqNLlbxeLdv6pCpXonk5LSgzB6WddB3wAoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750778310; c=relaxed/simple;
	bh=4bDKQc8ZdrkM28JhnaFABoCB0feiVBRNt+Kx9AsEEEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOs/Qbdo9GK/1yN4U+ugDAgFtwrZdpvzsJGjA2wgBdk304jvxrDj33PvLYu8vfmkDm6j3JFk1b4Q/DWDJcr5tEfLNyLGTbCrYWxgLiCprretyiw0DYN+ieSkcOyGhpozxKMf+yWChA3MylC0Qoy/jzTiFAieiXVe+7duKAYEEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQlJUGTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85640C4CEE3;
	Tue, 24 Jun 2025 15:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750778310;
	bh=4bDKQc8ZdrkM28JhnaFABoCB0feiVBRNt+Kx9AsEEEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQlJUGTVjwVdmwf6czfXHbVrjXEoNzFfJwmRD0Bu8b8mU0n/llu9SSgZW/lHasjax
	 +s8nQIhdj8kszM/pdS70uqcq7wpKMghXaLAEkyKcavPClxKbMIHsx/F66wuUa0/1R5
	 GlfUUQ+ryaaAu2CN5u0yDvI7PA8Ux3kzdYggTVEEhrAbv97YyVjyk1dwbxn6Tc5Ndr
	 vCbffXChwdqUsl/kM8I1FitAu2gSPBylUA7eUb6dwCFr7aNt1Rr7B0p2qVCK+AnAgE
	 SjEQMoAruKQ7QzxOX4SmDJjqvAoowu3CxKTlZFebgDstPBCZ5CnSl/j2DElxOGy3/B
	 l2fesWBbQGYHg==
Date: Tue, 24 Jun 2025 17:18:23 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 3/4] rust: devres: get rid of Devres' inner Arc
Message-ID: <aFrBvwFrUGD45TeF@cassiopeiae>
References: <20250622164050.20358-1-dakr@kernel.org>
 <20250622164050.20358-4-dakr@kernel.org>
 <aFizv7suXTADJU3f@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFizv7suXTADJU3f@Mac.home>

On Sun, Jun 22, 2025 at 06:54:07PM -0700, Boqun Feng wrote:
> I think you also need to mention that `inner` only remains valid until
> `inner.devm.complete_all()` unblocks `Devres::drop()`, because after
> `Devres::drop()`'s `devm.wait_for_completion()` returns, `inner` may be
> dropped or freed.

I think of it the other way around: The invariant guarantees that `inner` is
*always* valid.

The the `drop_in_place(inner)` call has to justify that it upholds this
invariant, by ensuring that at the time it is called no other code that accesses
`inner` can ever run.

Defining it the other way around would make the `inner()` accessor unsafe.

