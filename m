Return-Path: <linux-pci+bounces-16807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D18F9CD6A1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 06:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBCA51F224F1
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 05:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E916F851;
	Fri, 15 Nov 2024 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="IJe8p6gb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cBnMliZx"
X-Original-To: linux-pci@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611C13C9A3;
	Fri, 15 Nov 2024 05:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731649590; cv=none; b=Ihqpb31kRfh9sbeQ/P4WFQnu0a/rkjAhpSv5DFfFqTDoHWSXsCZmBbH70ASQ+SsCjy4ztZj1sSUCWpbAzAnV9Pgeee7pETB9vaTILFEcTXQXgGlosukWOd1/ivgqBxPAWZ0osI6NwP2ReXEopfeeRfTHwEzJKrdTkPtpkcxxasA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731649590; c=relaxed/simple;
	bh=g+TWxp8r0cFE9e5Yx0soVZGR0BkCsV6nwR/mjiL69EE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cW1wHEhsUK2D+A7fLgSgmRJj5Onspmi0PeNbICaJ/3eOByFHmfKU9gjozPpsC96B3yx/N2R2hY+/I7JCvuwo7hNiA3RPKb9X2rIt5jAbpTkPBwSdD2JXMDrMNMEt0D+fzJUBt+F/eWps4olT1p9fOwkOMuYR7SbagfT8V9kVTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=IJe8p6gb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cBnMliZx; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 8A45B11400C6;
	Fri, 15 Nov 2024 00:46:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 15 Nov 2024 00:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1731649585; x=
	1731735985; bh=sqvoc3APmGB5tb6niPFOzLw3Iq4+7kJyzp+d/Tks6Kc=; b=I
	Je8p6gbq3nvB9BgRC5f4A1pfTDvNvVuF0aJxtTcqli/PZYLXzX3oD4m0L72SOrOa
	+lmvcTCpKlqCimzJjUuZPmx0M8/c1V09dQKcxT/w5jTTyP3rRlHSgS4bTzXwENdr
	R6fB7aqJh8IcswWbAhmy7cMpgfyXxchWQjTrkGKq/rKJWTzyahigEvmsf9lX2+9u
	5dbgWcuImUleSslV5SB5/1VNrXx491TSlvnrglzzJRnJdxe36TAcVgbbx/75ZUY3
	T+vMowkKT/pynqsdfwT8Wk9u95dZYMx9FNwBTxCmIhxr2DCF8Bl/iKhZZBeTHpvN
	2vwnHbuHTx6fuRX5U4NPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1731649585; x=1731735985; bh=sqvoc3APmGB5tb6niPFOzLw3Iq4+
	7kJyzp+d/Tks6Kc=; b=cBnMliZxbkCwPPbmV5tc2uyjB/Bdkj6HL77752R0hCsw
	7L3WagOmJCuw1EC5CmvUecrrruu4mmg1jqgeWBwKdcyvat/bEGiQyzqEyTZS2KPZ
	F5HfHbB8yiphSZxHuwnlT3FpZV8Kl/A3PH/RXlRccM7caJJ0VMnarEpY6GN/gDNg
	4jW6JEH5g3s8pFYJYdnar71m5VtRkM7G5OI9376Q25jQObJUo7gI4TH/N2i8NhwC
	p2ungSsAdB3V/lOI1QuJb+BPLoIx5j2OqQ4lQY9QKKO0MfGhiZ4VIc3am40bYGMJ
	NVTyVYICo7sw9mwt7mzaFVhIKkO6QfmWyDvC7t5btw==
X-ME-Sender: <xms:MOA2Z_EuOdSl_QSkyeNpNuVbLRExs8zTkOF2A5lxoRi_yLwgXW-XBg>
    <xme:MOA2Z8Wep0iIb1VGpmqoLZjbREDv4ODx5ZOcyI1KTA7Af_sHq1sstfv_7wbrvNV-C
    c-7Y88CbNJ1TaYBqII>
X-ME-Received: <xmr:MOA2ZxLw_7LraFrDT_zK3UQoZ6jbju_IPz9i9CRHMc3wog1L1ELUYVAzwJzr1J0L3pbpbOOh0hzE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefuff
    fkofgtggfgsehtkeertdertdejnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghi
    shcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvg
    hrnhepieekleektdfhveeludegleefuefffefhfeeuiedthefgheehveeuheekieejjeek
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpdgumhhtfh
    drohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgdpnhgspghrtghpthhtohepvd
    dtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhkrghsseifuhhnnhgvrhdr
    uggvpdhrtghpthhtohepjhhonhgrthhhrghnrdgtrghmvghrohhnsehhuhgrfigvihdrtg
    homhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhn
    rdhorhhgpdhrtghpthhtohepsghhvghlghgrrghssehgohhoghhlvgdrtghomhdprhgtph
    htthhopehlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheplhhinhhugidqtgiglhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    gsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
X-ME-Proxy: <xmx:MOA2Z9HPJFoawqiA_3Tcl0tHN80FJ4Wls83zKgLhXGUJOaa-Ayg-zw>
    <xmx:MOA2Z1UGUoOuaMUf2Lii_IPOctHlJjFlI1d41zIMja9ojTSz3mfTcQ>
    <xmx:MOA2Z4Os36g_a0ZgMAx7qfbrJ7nQNKJRPQQF9Y58ukunVTaxBbjQ4Q>
    <xmx:MOA2Z023m_GzIsIg5iDQbnu8LSCcukDYYqu_cstNZ9bn3HOksPgcgg>
    <xmx:MeA2Zy1Kqoj4SDh1UXfs18B-ac3YT_oMCaqwehV03Lkuakw5fkFkyw1M>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 00:46:18 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Cc: bjorn3_gh@protonmail.com,
	ojeda@kernel.org,
	tmgross@umich.edu,
	boqun.feng@gmail.com,
	benno.lossin@proton.me,
	a.hindborg@kernel.org,
	wilfred.mallawa@wdc.com,
	alistair23@gmail.com,
	alex.gaynor@gmail.com,
	gary@garyguo.net,
	aliceryhl@google.com,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC 0/6] lib: Rust implementation of SPDM
Date: Fri, 15 Nov 2024 15:46:10 +1000
Message-ID: <20241115054616.1226735-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.47.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Security Protocols and Data Models (SPDM) [1] is used for authentication,
attestation and key exchange. SPDM is generally used over a range of
transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.

From the kernels perspective SPDM is used to authenticate and attest devices.
In this threat model a device is considered untrusted until it can be verified
by the kernel and userspace using SPDM. As such SPDM data is untrusted data
that can be mallicious.

The SPDM specification is also complex, with the 1.2.1 spec being almost 200
pages and the 1.3.0 spec being almost 250 pages long.

As such we have the kernel parsing untrusted responses from a complex
specification, which sounds like a possible exploit vector.

As such this series implements a SPDM requester in Rust.

This is very similar to Lukas' implementation [2]. This series applies on top
of Lukas' tree [3] and is heavily based on Lukas' work. At build time a user can
choose to use either the Rust of the C SPDM implementation. The two are
interchangable, although you can only use one at a time.

To help with maintaining compatibility it's designed in a way to match Lukas'
design and the state struct stores the same information, although in a Rust
struct instead of the original C one.

The Rust implementation currently supports less features, but my end goal
is to consolidate to a single Rust implementation eventually. That will
probably have to wait until Rust in the kernel is no longer experimental
as SPDM is looking to be an important feature to support for all platforms.

This series is based on the latest rust-next tree.

This seris depends on the Untrusted abstraction work [4].

This seris also depends on the recent bindgen support for static inlines  [5].

The entire tree can be seen here: https://github.com/alistair23/linux/tree/alistair/spdm-rust

based-on: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
based-on: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
based-on: https://lore.kernel.org/all/20241114005631.818440-1-alistair@alistair23.me/

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: https://github.com/l1k/linux/commits/spdm-future/
4: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
5: https://lore.kernel.org/all/20241114005631.818440-1-alistair@alistair23.me/

Alistair Francis (6):
  rust: bindings: Support SPDM bindings
  drivers: pci: Change CONFIG_SPDM to a dependency
  lib: rspdm: Initial commit of Rust SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  lib: rspdm: Support SPDM negotiate_algorithms

 MAINTAINERS                     |   6 +
 drivers/pci/Kconfig             |   2 +-
 lib/Kconfig                     |  47 ++-
 lib/Makefile                    |   1 +
 lib/rspdm/Makefile              |  11 +
 lib/rspdm/consts.rs             | 123 +++++++
 lib/rspdm/lib.rs                | 146 +++++++++
 lib/rspdm/req-sysfs.c           | 174 ++++++++++
 lib/rspdm/state.rs              | 556 ++++++++++++++++++++++++++++++++
 lib/rspdm/sysfs.rs              |  27 ++
 lib/rspdm/validator.rs          | 301 +++++++++++++++++
 rust/bindgen_static_functions   |   4 +
 rust/bindings/bindings_helper.h |   2 +
 13 files changed, 1384 insertions(+), 16 deletions(-)
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/req-sysfs.c
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/sysfs.rs
 create mode 100644 lib/rspdm/validator.rs

-- 
2.47.0


