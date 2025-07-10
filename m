Return-Path: <linux-pci+bounces-31884-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA7FB00C3E
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 21:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC483B0811
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 19:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24793218EA7;
	Thu, 10 Jul 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2SCsdvQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96C2F510;
	Thu, 10 Jul 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752176768; cv=none; b=qtXH2MxePpiYV/5xYpspAwT525paX7wjnGhycQX4z7y3XlV+xY6hE4VqXwdunmlo/PIV51C+ZycfWGDk7cWEaCase+GWIZWwzA6oKDVy7C9GZNSDZR18YT2WHSz9/DtNP4lRHT9a37QYWxE+YFG3EGXhSB7S6OWD4ytI0Tm9ec0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752176768; c=relaxed/simple;
	bh=udnZyaEtWLgOBUXN73fOVVys/CmYGjjlytAIkU4TrSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4kg1I0F9bFSeDezSTmKiJ0QoWnUjUj3aSK2ydznGviNrTOYSJP9uYr6A2+LoWyoO8rZclY9ekE+jGeDdGj6vuu4NdF99yCfKzeQAcTB+Vy5RNxaY8zeC2yUXnSO4Ybc9746hkENyC4J3CbhmAYHiyEGHQYN43ALhCBacB52eLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2SCsdvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FBCC4CEE3;
	Thu, 10 Jul 2025 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752176767;
	bh=udnZyaEtWLgOBUXN73fOVVys/CmYGjjlytAIkU4TrSE=;
	h=From:To:Cc:Subject:Date:From;
	b=W2SCsdvQmhCuLN6wl9JFWEZErI9Una618TMZrrX4SqAcQiTbLB4RcY/Y1qFAg0oIC
	 C8WLh+d8GXPc/Qz8ad4rbNo4CXZcG1uMlKGYjGMcZwpANJgaGzXVBnn7A4zDM4drOp
	 edKoHPtTQSwucVWmij7z3g/cW0uut+umnAHhf8NVgs0h8ACayackXttgoJpSl5R0Cg
	 UVjgFq6fv7pNOHmHQ/IBSwj8b0Z0W/sHGkETjg82nPZFzA9rE0CztYSORyrps6+gul
	 LSRtjMMdUjWgG4Gsmm3QO0Nx/8wr15TC4LWW5C+ZYHcnSNOH+JK0Qfc3u/EpiFjkpk
	 KVc2iU4AXtjww==
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
Subject: [PATCH 0/5] dma::Device trait and DMA mask
Date: Thu, 10 Jul 2025 21:45:42 +0200
Message-ID: <20250710194556.62605-1-dakr@kernel.org>
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

Danilo Krummrich (5):
  rust: dma: implement `dma::Device` trait
  rust: dma: add DMA addressing capabilities
  rust: pci: implement the `dma::Device` trait
  rust: platform: implement the `dma::Device` trait
  rust: samples: dma: set DMA mask

 rust/helpers/dma.c       |  5 +++
 rust/kernel/dma.rs       | 95 +++++++++++++++++++++++++++++++++++++---
 rust/kernel/pci.rs       |  2 +
 rust/kernel/platform.rs  |  2 +
 samples/rust/rust_dma.rs | 12 ++++-
 5 files changed, 109 insertions(+), 7 deletions(-)


base-commit: d49ac7744f578bcc8708a845cce24d3b91f86260
-- 
2.50.0


