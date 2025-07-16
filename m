Return-Path: <linux-pci+bounces-32274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9AFB0791F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 17:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807101888E9F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD736262FC8;
	Wed, 16 Jul 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaPM0QwO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C93596B;
	Wed, 16 Jul 2025 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678247; cv=none; b=fOiLJ5O8jHS/I2YFoF4SugW0iJdQi4by7vWTRIK2YsipeZvkKPO+grdjLWBJNJjamZt/xWAbghEyIW4YpxY0FIxxAE+y1K6aPPCurH4J5I4/M40NOMwMyC6MucErDh3sBWG/mSgjEO2qdJg/PvzPk6+QNlt3xz/6DvQI9YN3cSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678247; c=relaxed/simple;
	bh=QSOfqXzuBlf+cL9JGG4N53loLu8Px4Wr4sqBfvUDY6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mydX/PLeynBZVeBhUKSKD/bJd1xIBcHmPTWO4VXfbEpikXaiSDZfnPJgjBXodEeBwa2b9EbnGd5t7VzwB+pXsQU4lNijOc6uiqKGAaZ7U1K1ZoHH41izotjBaBpdpxEI8QqAo2gLluvksm1LHCbb/CutlWV915PMZUr7y5i4vKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaPM0QwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B38C4CEF0;
	Wed, 16 Jul 2025 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752678247;
	bh=QSOfqXzuBlf+cL9JGG4N53loLu8Px4Wr4sqBfvUDY6g=;
	h=From:To:Cc:Subject:Date:From;
	b=eaPM0QwO2ePNSemrCsNXs/6x6U+/GMKlUxMjSgNSfuVDcTg0Oqp9Nm7sGVRyjtQJ6
	 rtLssTtb+7/RgKFIiBzULcs3CmE7V3euk4EfqnuqUhaopGSrwZRvmru4gBgvsy34zK
	 3UEHkF5DfpFAQ4DVv+x4iNXf2vvMBD3xuW60QXGzFsMqW2/2KRy2t6Ot/uEfeEnn7g
	 EyhxnkvoSdFcA7/UvFdxbs988egjupbM4LL24eGdi3yQLzldhWeo4Gejg+djGZ+9ie
	 Gt27Ch8bynFqbcqqfBD+5+Q8uAqO7G0FhOyX8V+OP7YXuUQYv9ezPKN7md4N62ch+S
	 5Y5KoBok/aLVA==
From: Danilo Krummrich <dakr@kernel.org>
To: abdiel.janulgue@gmail.com,
	daniel.almeida@collabora.com,
	robin.murphy@arm.com,
	a.hindborg@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/5] dma::Device trait and DMA mask
Date: Wed, 16 Jul 2025 17:02:45 +0200
Message-ID: <20250716150354.51081-1-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the dma::Device trait to be implemented by bus devices on
DMA capable busses.

The dma::Device trait implements methods to set the DMA mask for for such
devices.

The first two bus devices implementing the trait are PCI and platform.

Unfortunately, the DMA mask setters have to be unsafe for now, since, with
reasonable effort, we can't prevent drivers from data races writing and reading
the DMA mask fields concurrently (see also [1]).

Link: https://lore.kernel.org/lkml/DB6YTN5P23X3.2S0NH4YECP1CP@kernel.org/ [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/dma-mask

Changes in v2:
  - replace dma_bit_mask() with a new type DmaMask
  - mention that DmaMask is the Rust equivalent of the C macro DMA_BIT_MASK()
  - make DmaMask::new() fallible
  - inline DmaMask methods

Danilo Krummrich (5):
  rust: dma: implement `dma::Device` trait
  rust: dma: add DMA addressing capabilities
  rust: pci: implement the `dma::Device` trait
  rust: platform: implement the `dma::Device` trait
  rust: samples: dma: set DMA mask

 rust/helpers/dma.c       |   5 ++
 rust/kernel/dma.rs       | 125 ++++++++++++++++++++++++++++++++++++---
 rust/kernel/pci.rs       |   2 +
 rust/kernel/platform.rs  |   2 +
 samples/rust/rust_dma.rs |  14 ++++-
 5 files changed, 140 insertions(+), 8 deletions(-)


base-commit: d49ac7744f578bcc8708a845cce24d3b91f86260
-- 
2.50.0


