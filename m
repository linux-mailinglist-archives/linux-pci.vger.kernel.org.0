Return-Path: <linux-pci+bounces-27118-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABC6AA87E5
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 18:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D52B97AA72D
	for <lists+linux-pci@lfdr.de>; Sun,  4 May 2025 16:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B5D1DDA14;
	Sun,  4 May 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLyGErdI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BFF1D9A50;
	Sun,  4 May 2025 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375307; cv=none; b=PAM84dKGH13ntOdjIbd+cUbz1+WZbtPq8NfxmWQh5K4JR8JVpR3f2HNHGnwNhsb1xwUzhgXPC5dN7dWRqguo1tA5pIkVrK9SKK79MWg8mH7nXtXiQVfH2mi75Lcx0zBRI9tPCnuh810+sSW1gDf/acBexDO2/Xihe1ZvwyqqbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375307; c=relaxed/simple;
	bh=tKJYnlBaANGFuI7HcwwK/OhmNXjmKApd+I7pw+gyVw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LvQqsiV71xyJZbmA/iMFmAfO1eqSdXCT+cvUfH/XtMF3l31Bo5QVvOzeT/ksNixGeGhS81faXU0nOqWFCvtoq42JrRZ4dvrf8fPbYN6ePNR0L3W/ItPOwWwpYVvti6keJEUxQgzniNbrZbB0ff/wvl2Lgpdgu1F0N8byMTYIwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLyGErdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D416C4CEE7;
	Sun,  4 May 2025 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746375307;
	bh=tKJYnlBaANGFuI7HcwwK/OhmNXjmKApd+I7pw+gyVw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dLyGErdI64iZ2qo0TDMyYP6l7LKLLJbCCPc5WJPeTwEE39FUp9SrvyrQgWzJA+oX0
	 gJPCG2v1hryobjrhnPeHLJ+gmg2IIFcr3IG7FJykAm8LPjQxqkB6Pz5GUrCmi+yvx9
	 YNt3oIsZhx6piJxkdNh798RYblbGyMKMKpTa7sOa8uVYLwcBvXzavmA0fGUj5rSC8W
	 M2ZJK8YrNwzI2akrYFr0hlfJXsmNzZkLQZvV5q7bWp1jzMnG9XnZaAPKwCKpOMdFha
	 K0IKOdzHggl005qU37SX3dsUEERtn/1zxqfzNQ8OX7gEEqVwQtF7nQCYaanNm/iL9Q
	 chs9iUJ2KSp5Q==
Date: Sun, 4 May 2025 18:14:55 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Devres optimization with bound devices
Message-ID: <aBeSf__SNkd7goGv@polis>
References: <20250428140137.468709-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428140137.468709-1-dakr@kernel.org>

On Mon, Apr 28, 2025 at 04:00:26PM +0200, Danilo Krummrich wrote:
> This patch series implements a direct accessor for the data stored within
> a Devres container for cases where we can prove that we own a reference
> to a Device<Bound> (i.e. a bound device) of the same device that was used
> to create the corresponding Devres container.

Applied to nova-next, thanks!

