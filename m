Return-Path: <linux-pci+bounces-38284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A07BE0FEB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 01:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38D25805A3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 23:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6DE309F08;
	Wed, 15 Oct 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKp6h8Y9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF02FC00E;
	Wed, 15 Oct 2025 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760569332; cv=none; b=L3BA9SqyLZkERdQU24oVL28xXn0N0PeslEaQmRkNvigp02YZY1KAYOEOQTeZRlQMqkJb/DpVS+oo/YWOiPQAsw+Gx1pDosfxgkRr8HLMaqRAlfZiTDVICkdkZP6t1CAEnYsmHyNiHHNR7pQA3l+7BCQN+PwzSUbNiLkXsT2GzhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760569332; c=relaxed/simple;
	bh=ucocps56wr1kLrXEhr30Oi2Y2Ck6q/vgoOIs0oP616k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Dvv077aNHK2RwXMa3cpT+iOxdKJKhhJ87cAPpbABdb+xZn34WEzE3sRAc+e4LA21cI8mxs2vSdQSoxi7d48OMRz4qeKd3szzl1o9bHrdAMD6R1lX/tH5ABLbtkc1F7Ik8D5F9CmTKBBq3eB4seGJotm0eAVKuJMBs3RkC6Lj5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKp6h8Y9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2427EC4CEF8;
	Wed, 15 Oct 2025 23:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760569331;
	bh=ucocps56wr1kLrXEhr30Oi2Y2Ck6q/vgoOIs0oP616k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oKp6h8Y9AOa9RmNo6f9nGVkWZn06X4q78/VdJfgLr4A/UciljMSQodejaxO5oPpA+
	 yNr/rYcEWtWDC0OyHVLmrGet+xVA+HrfStJRXCUF1Yg5LHv85z5iHc/Yoi+/phyhzK
	 +0RgO1nZ6LO2Tx9f924jvXIvS/ql9udjyCaEQRW31O1saXeeD99tGSJcoOP2surfA3
	 3mgBtQlrUe3/H3wBN1+OmnDowYAMy4Ct/zM+6lX5ctag39jLcqzlQY5/eBcXtmFvIU
	 yhJvppYPVPunA5o8g8S2Rwa7rmCDrdwsjLlRZKJ0TVpI3kgaKhqHn0XcK7udWgI6cb
	 wjfB0wglqMkwQ==
Date: Wed, 15 Oct 2025 18:02:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rust: pci: move IRQ infrastructure to separate file
Message-ID: <20251015230209.GA960343@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015182118.106604-4-dakr@kernel.org>

On Wed, Oct 15, 2025 at 08:14:31PM +0200, Danilo Krummrich wrote:
> Move the PCI interrupt infrastructure to a separate sub-module in order
> to keep things organized.

> +++ b/rust/kernel/pci/irq.rs

> +pub enum IrqType {
> +    /// INTx interrupts.
> +    Intx,
> +    /// Message Signaled Interrupts (MSI).
> +    Msi,
> +    /// Extended Message Signaled Interrupts (MSI-X).
> +    MsiX,
> +}

> +impl IrqTypes {
> +    /// Create a set containing all IRQ types (MSI-X, MSI, and Legacy).
> ...
> +    /// // Create a set with only MSI and MSI-X (no legacy interrupts).
> ...
> +    /// The allocation will use MSI-X, MSI, or legacy interrupts based on the `irq_types`
> +    /// parameter and hardware capabilities. When multiple types are specified, the kernel
> +    /// will try them in order of preference: MSI-X first, then MSI, then legacy interrupts.
> ...
> +    /// // Allocate MSI or MSI-X only (no legacy interrupts).

Again, just a move, but could s/Legacy/INTx/ to make them all match.

