Return-Path: <linux-pci+bounces-37561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F48BB7C35
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 19:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B2A4A393E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 17:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C552DA77F;
	Fri,  3 Oct 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZGct/NC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8154F2DA76B;
	Fri,  3 Oct 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759512806; cv=none; b=KnQqGiBxOWUl/j3Aaozr+nVP0iCK1Sz++SGffRHoLGh0zDsqbZ7v1mpEvONfFAoCRxqRPlFUpgBjOmpTVMcL5N2n0WndKeiS3TK6QqX6mkkCpEMJ2iuWIeiKkFrQ+3IYAqLYIDj0V6u78Oo8ufc2NIqsAsNi1JW9dZt/tEKFcOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759512806; c=relaxed/simple;
	bh=YBxUepfkckAj5IwP5nRU1R79rwNPtTxPrmIYM0ip2TU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qhbvBJwdctt9ksUjOuMgK5tIdSd3VaEHY5DcHoaCOPWpnVerCMDYnDEZe05OOuSmgsqxmHe13eZdBoKeZWoe4FdA+uNcXG3odXQDfhJZMbcfO+F4g5Yg6nwZ3+qXDR0kr2CSwGtMIIUKQjY1GcdH851wluPDnP2srGxuddvcDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZGct/NC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E510DC4CEF5;
	Fri,  3 Oct 2025 17:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759512806;
	bh=YBxUepfkckAj5IwP5nRU1R79rwNPtTxPrmIYM0ip2TU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BZGct/NC6j5y1kDVLEt2rL44/BmKTgEood0kPUydXjqv42lBHx3Rw1iUZ5hHx0dwp
	 tIor3GiB5TeGigjM+s3RTP6wyssy6PrksAVtLtAjazx3LHVd9XHSJA58NOuAt3gRLX
	 EpGNbNonLZoq7EytAEtA2GbZjQQTeorcxrPQvHiwyVn9U+9RuamZ51NUgn4JRofVzj
	 NlxxzZxEy8Aan7QDpHJo+NITtXHLpUECSgkcwqWo4r54l6J+0JNudKB1eYT3BXAhnz
	 mO6GPGsg2zr7ZDg9kvUU+uNHUKUwVODRK8AREULm3ZalvhI9aB/e9sFjrqF1OF2A/z
	 stAI0BLB6c38w==
Date: Fri, 3 Oct 2025 12:33:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org, dakr@kernel.org, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	joel@joelfernandes.org,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2] rust: pci: Allocate and manage PCI interrupt vectors
Message-ID: <20251003173324.GA361946@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002183912.1096508-1-joelagnelf@nvidia.com>

On Thu, Oct 02, 2025 at 02:39:12PM -0400, Joel Fernandes wrote:
> Add support to PCI rust module to allocate, free and manage IRQ vectors.
> Integrate with devres for managing the allocated resources.

> +/// IRQ type flags for PCI interrupt allocation.
> +#[derive(Debug, Clone, Copy)]
> +pub enum IrqType {
> +    /// Legacy INTx interrupts
> +    Legacy,

FWIW, when I can, I try to use "INTx" instead of "legacy" because
"INTx" has a specific meaning and is used in the PCIe specs, while
"legacy" by itself has no intrinsic meaning.

> +    /// Message Signaled Interrupts (MSI)
> +    Msi,
> +    /// Extended Message Signaled Interrupts (MSI-X)
> +    MsiX,
> +}

