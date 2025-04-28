Return-Path: <linux-pci+bounces-26937-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85EA9F309
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 16:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548D01897151
	for <lists+linux-pci@lfdr.de>; Mon, 28 Apr 2025 14:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AA625E829;
	Mon, 28 Apr 2025 14:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBqxa9MH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57DB156677;
	Mon, 28 Apr 2025 14:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745848905; cv=none; b=YGf7/t7NpyQeVe7MfJffZdSy4+G81nSS2nB6jWCFd615oCNFzEJRJbVspbik9F+rAkKKhlC40SiSIbAZA0c4FgPC9h6JVBG04Z+ctqsB+xvROkg8yD2lvrA4itjxv3tPKgdahsnJ+jcUlpZLCH7gg/MmWa6X8bkO7zljK7afBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745848905; c=relaxed/simple;
	bh=AkNxV8lGLsUolM5DerUPl2T/JNmeZR9jvv0aQqgBJHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S4shXLr1vucd61KPInBuoawvLCzybKAIX6+rjWWhKDLWF1cboA/KXwDTiTAH2nVZQhs2ilg9bWOdS2n9n5ve6kohYwjjzDKb3yehCTlQkalpy48YaSITDpQojb2TjUlFQ3J8aGuJMfs0FAT32V762cPItcI6zCb2+PbES9S2nhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBqxa9MH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67F35C4CEE4;
	Mon, 28 Apr 2025 14:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745848905;
	bh=AkNxV8lGLsUolM5DerUPl2T/JNmeZR9jvv0aQqgBJHY=;
	h=From:To:Cc:Subject:Date:From;
	b=HBqxa9MHWKYwKc7sX3vr4SN4S52q/tJiJt6AwMSGlCmdqVrdBgiRMyopuu7yHfVG6
	 OKQpAm/E+QU4GSeH/Hm3+0ViV0wrXOvcZDO8QS7azUa8d7KzwWBNTT88Uw7DPTNU+K
	 CLAkBw0vwa8BQz+7w8Ut/X6hTAEjM1DxnAvpL2r0d0WrZOVffvEZYdwRN+e46TZFlK
	 lVMvrPk0FBE+6glYDVzvum9Ug16ulFlnKHwAIaJXgLmpZcXhInhlLtu+ECBUcuLVxP
	 QyYstHQEXKehfmMlSboO4wbH/t2CLW73sBxOARi16RPumBakCFlEw1lIJWYpwKyMRL
	 jrHNA5VhFOdlg==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	zhiw@nvidia.com,
	cjia@nvidia.com,
	jhubbard@nvidia.com,
	bskeggs@nvidia.com,
	acurrid@nvidia.com,
	joelagnelf@nvidia.com,
	ttabi@nvidia.com,
	acourbot@nvidia.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu
Cc: linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 0/3] Devres optimization with bound devices
Date: Mon, 28 Apr 2025 16:00:26 +0200
Message-ID: <20250428140137.468709-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series implements a direct accessor for the data stored within
a Devres container for cases where we can prove that we own a reference
to a Device<Bound> (i.e. a bound device) of the same device that was used
to create the corresponding Devres container.

Usually, when accessing the data stored within a Devres container, it is
not clear whether the data has been revoked already due to the device
being unbound and, hence, we have to try whether the access is possible
and subsequently keep holding the RCU read lock for the duration of the
access.

However, when we can prove that we hold a reference to Device<Bound>
matching the device the Devres container has been created with, we can
guarantee that the device is not unbound for the duration of the
lifetime of the Device<Bound> reference and, hence, it is not possible
for the data within the Devres container to be revoked.

Therefore, in this case, we can bypass the atomic check and the RCU read
lock, which is a great optimization and simplification for drivers.

The patches of this series are also available in [1].

[1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/devres

Changes in v2:
  - Revocable::access(): remvoe explicit lifetimes; don't refer to 'a in
    the safety requirement
  - Devres::access()
    - rename Devres::access_with() to Devres::access()
    - add missing '```' at the end of the example
    - remove 's lifetime
    - add # Errors section

Danilo Krummrich (3):
  rust: revocable: implement Revocable::access()
  rust: devres: implement Devres::access_with()
  samples: rust: pci: take advantage of Devres::access_with()

 rust/kernel/devres.rs           | 38 +++++++++++++++++++++++++++++++++
 rust/kernel/revocable.rs        | 12 +++++++++++
 samples/rust/rust_driver_pci.rs | 12 +++++------
 3 files changed, 56 insertions(+), 6 deletions(-)


base-commit: 3be746ebc1e6e32f499a65afe405df9030153a63
-- 
2.49.0


