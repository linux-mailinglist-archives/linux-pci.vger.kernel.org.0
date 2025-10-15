Return-Path: <linux-pci+bounces-38251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A6ABE0294
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 20:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AEBDA54884D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 18:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4D033CE83;
	Wed, 15 Oct 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT854q7G"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE333A01F;
	Wed, 15 Oct 2025 18:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552495; cv=none; b=bDbKfEus8KXwqv0XHZBo6qGjW/gImianexwDvdiLsnEBA9y8IBCEnYBk9Sy59RnOqQNCReUk5QYSvXCbrzksNJH+v8K7XiKVmjCR4bo5dFoz7E2kNqaec4bPRh0WjIwc464HWN955rodIfT13J1ObYKB0NOJxPMnEypT9FRqfQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552495; c=relaxed/simple;
	bh=+bFDODzdhr6el3T4MCDV7ELxaZ6G8GTe/G41eC/gOMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njG0R7+Tlaqs8joOYcNsx1EJg8Vp4icBl2KqHonbl2PkOZmLEcz+CBkna3//TWtht93Ml6BSzP1N8iP87qiIaDbcLbX+/sMTs9N7zj8waup8xek1FMftE8YifybywdylQFEXrWDp3B8KhRu72GDA+RB+KmsDcjOUf3TagD52y7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT854q7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219BAC4AF54;
	Wed, 15 Oct 2025 18:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760552495;
	bh=+bFDODzdhr6el3T4MCDV7ELxaZ6G8GTe/G41eC/gOMc=;
	h=From:To:Cc:Subject:Date:From;
	b=rT854q7G2L1JPzvf6YPz0sLUQM9uPnyF2hixOzFJ68VBcNHCXICI60C4Ca2ci9ZXD
	 U4Fge5Bn2lwFbPTiulpnjp968xMHaIkuAEpXEdJRn7wsGyioIx5wf5j8Gf/30mwCBy
	 NyeVqbGZDAOaXwAZW22WULcW18bUAujQoTabG+uB325rk5CF+c5DJp1rMxcqZOH6Qc
	 wjL1IKm6K/5Grx0WzqSvBR/LnBqCpilRO0mmlbztvxUKSr5V9TdUm8c19u0X8uu2qU
	 r/6feNB+B2mJRO/NBS41wVjWok3yLmTz3/esxspGXyhDtDQMUI6AE5DMPMPol9wKWF
	 UeOduw9JNO1ZA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kwilczynski@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 0/3] Rust PCI housekeeping
Date: Wed, 15 Oct 2025 20:14:28 +0200
Message-ID: <20251015182118.106604-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some minor housekeeping:

- Implement TryInto<IrqRequest<'a>> for IrqVector<'a> to directly convert a
  pci::IrqVector into a generic IrqRequest, instead of taking the indirection
  via an unrelated pci::Device method.

- Besides that, move I/O and IRQ specific code into separate sub-modules to keep
  things organized.

Danilo Krummrich (3):
  rust: pci: implement TryInto<IrqRequest<'a>> for IrqVector<'a>
  rust: pci: move I/O infrastructure to separate file
  rust: pci: move IRQ infrastructure to separate file

 rust/kernel/pci.rs     | 365 +----------------------------------------
 rust/kernel/pci/io.rs  | 141 ++++++++++++++++
 rust/kernel/pci/irq.rs | 244 +++++++++++++++++++++++++++
 3 files changed, 389 insertions(+), 361 deletions(-)
 create mode 100644 rust/kernel/pci/io.rs
 create mode 100644 rust/kernel/pci/irq.rs


base-commit: 340ccc973544a6e7e331729bc4944603085cafab
-- 
2.51.0


