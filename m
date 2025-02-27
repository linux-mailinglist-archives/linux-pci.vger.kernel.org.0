Return-Path: <linux-pci+bounces-22486-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A33A47353
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 04:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20343188BD96
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2025 03:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6A2158A13;
	Thu, 27 Feb 2025 03:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="lWA5NYeV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n90ETga/"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0111778F4B;
	Thu, 27 Feb 2025 03:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625806; cv=none; b=taStqEg8E+k7j04LdaHla7a2SE4tS6bBEjGtp3w+u3BrBfLpQcB00nbLERZ3648JPoIbRypY06hOlbmdeOPMEYfbGEAdJ+1DyNuWnOpjPgrmeQC5olvJdnnyKPtNsH8TvkxjBf+TZ2jyz9CSmbTWTbsqfDutROjbe9WIG4PegNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625806; c=relaxed/simple;
	bh=bjkGnvcrxLcXBpGIdXaFlc3TlgiNsUbgXYoQeEOSpmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M2vnaYKBnvIu52D8iVte9bpIQdbMGHXPBzKXs6md1XxifyV4a00kwTwt2VoyvfIKBZsDoR0rxpcY7wTCUeAfkCBQDU+oBtZ0DvFBg30FmoG7KzNdGGeVLXa4WhQm1HNVmuCVQYksQXPzUVnEs2ksrE7vVhGKwwv2JQmgomBtBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=lWA5NYeV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n90ETga/; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6F39325401FE;
	Wed, 26 Feb 2025 22:10:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 26 Feb 2025 22:10:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm1; t=1740625802; x=
	1740712202; bh=OFqV8ivhDVMLyNjQiWEyM/GYTizNj32r/Co5dE3iy08=; b=l
	WA5NYeVqLJahiiKpsUQ3EYKRyha3xEXblLoqgqVMmuUI1EFwL/o/xi+Nerql8j/O
	5XrXnw+uCfDYD5pb+ozsRtNaW05KFDls5027vR20qTcELDIT0sRiKAGK0aMdOZbg
	AD5nJmU0n/fSyuzgent8ZdcYJiqNOkkyPsAAjdgxeKOCrra/MSQpkPrFbcDsSFg4
	v+DCLbSjwFshfWlP2ca59V/UTFsSt2brg+oQYz9rT83+3q+SHAl/TJKvL9SZ9juT
	lOwX48VSgnF7+gS5zZlKAUMJCS4YWjrRPe24iuuwlsHVPid2ZVs7pCOjyJH3E86L
	Hiqhq5GtgJ4z3yB7Y2FRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1740625802; x=1740712202; bh=OFqV8ivhDVMLyNjQiWEyM/GYTizN
	j32r/Co5dE3iy08=; b=n90ETga/XtGQu5nbu3ZbqX8Vwt2f24UgrYKV4JGruP8x
	j0emQEH+wmYdOetv7TCCmVeTGj0p7xZ2XcGJ4HDh3rBA4dZ4Er1tm9BsoSK1WvaJ
	awNaPimePbcHWJ62xiID40yTidgKk4xCiAMgvq2HJgMJFHc7mLDFt2qPEe1MypII
	aAeoZ93IZ8iBV5/qpOFJGTgYJx1fWJQ3nCNkgAhu0E+ByNDNBaRD+VMySzw8eljE
	ogs8ead/j6do0QydiWTcMrqu7pwHmHX5lOV6NJ5339eGY6ABwhgVeXOc1F/4n+qJ
	Niseg/gvRQsBPhD+IhOnfHzx3TwynsVTW8oXaOavag==
X-ME-Sender: <xms:ide_Zz8kFLHh3KZtFkbNYcS0nGq97ScKxe7R5DTRmT4bAJQGQHjsWg>
    <xme:ide_Z_skLtLplRgfyyAowu2Jatlc5jvdOzRG_iuvUSYEKvftg9KKL2NLn2z0taKqF
    cOf4l5m7xxrQaI8kT0>
X-ME-Received: <xmr:ide_ZxCZo6vHMpAeabuHHyj9AgqCDQiXzSvS4KUE036xxFzjuRvNxRSvnbyCHLpl252WoQwKPQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekieefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecuogfuohhrthgvugftvg
    gtihhpvdculdegtddmnecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecu
    hfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghirhesrghlih
    hsthgrihhrvdefrdhmvgeqnecuggftrfgrthhtvghrnhepfffgudekvddtudejgfefkeev
    feejteeuleeijedvuedtieefheffieegudehveehnecuffhomhgrihhnpehgihhthhhusg
    drtghomhdpkhgvrhhnvghlrdhorhhgpdgumhhtfhdrohhrghenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsth
    grihhrvdefrdhmvgdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehlihhnuhigqdgtgihlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhukhgrshesfihunhhnvghrrdguvgdprhgtphhtthhopehlihhnuhigqd
    hptghisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsghhvghlghgrrghs
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdrtggrmhgvrhhonh
    eshhhurgifvghirdgtohhmpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfoh
    hunhgurghtihhonhdrohhrghdprhgtphhtthhopegsohhquhhnrdhfvghnghesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:ide_Z_f3z0-FZ6xtrPfcUL1ywbkdyadUCjJMYP0-cpHrHPeZMRY1WQ>
    <xmx:ide_Z4NCTNqybi2KfCdfigAo1tkuyfE1X_S5qANcZYXv1otm-_BOUw>
    <xmx:ide_Zxmg5OHIUcPfxwMpCi-buM4ekrw-qw2wS7LAUN95-G0IQsmP5w>
    <xmx:ide_Zysy2E2m4FCRWTmRrVWWO2L-j-OCVhCMwJH5lRgKr-D6tjtRCA>
    <xmx:ite_Z0tmU_ghUctdwAMz-qmL0GaVRt3G7i7qeOsNr1lxbO5Hq8t8kJNW>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Feb 2025 22:09:55 -0500 (EST)
From: Alistair Francis <alistair@alistair23.me>
To: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	linux-pci@vger.kernel.org,
	bhelgaas@google.com,
	Jonathan.Cameron@huawei.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org
Cc: boqun.feng@gmail.com,
	bjorn3_gh@protonmail.com,
	wilfred.mallawa@wdc.com,
	aliceryhl@google.com,
	ojeda@kernel.org,
	alistair23@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	gary@garyguo.net,
	alex.gaynor@gmail.com,
	benno.lossin@proton.me,
	Alistair Francis <alistair@alistair23.me>
Subject: [RFC v2 00/20] lib: Rust implementation of SPDM
Date: Thu, 27 Feb 2025 13:09:32 +1000
Message-ID: <20250227030952.2319050-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
specification, which sounds like a possible exploit vector. This is the type
of place where Rust excels!

This series implements a SPDM requester in Rust.

This is very similar to Lukas' implementation [2]. This series includes patches
and files from Lukas' C SPDM implementation, which isn't in mainline.

This is a standalone series and doesn't depend on Lukas' implementation, although
we do still rely on Lukas' crypto preperation patches, not all of which are
upstream yet.

To help with maintaining compatibility it's designed in a way to match Lukas'
design and the state struct stores the same information, although in a Rust
struct instead of the original C one.

This series doesn't expose the data to userspace (except for a single sysfs
bool) to avoid the debate about how to do that. I'm planning to do that in
the future though.

This series is based on the latest rust-next tree.

This seris depends on the Untrusted abstraction work [4].

This seris also depends on the recent bindgen support for static inlines  [5].

The entire tree can be seen here: https://github.com/alistair23/linux/tree/alistair/spdm-rust

based-on: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
based-on: https://lore.kernel.org/rust-for-linux/20250107035058.818539-1-alistair@alistair23.me/

1: https://www.dmtf.org/standards/spdm
2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
3: https://github.com/l1k/linux/commits/spdm-future/
4: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
5: https://lore.kernel.org/rust-for-linux/20250107035058.818539-1-alistair@alistair23.me/

v2:
 - Drop support for Rust and C implementations
 - Include patches from Lukas to reduce series deps
 - Large code cleanups based on more testing
 - Support support for authentication

Alistair Francis (12):
  lib: rspdm: Initial commit of Rust SPDM
  lib: rspdm: Support SPDM get_version
  lib: rspdm: Support SPDM get_capabilities
  lib: rspdm: Support SPDM negotiate_algorithms
  lib: rspdm: Support SPDM get_digests
  lib: rspdm: Support SPDM get_certificate
  crypto: asymmetric_keys - Load certificate parsing early in boot
  KEYS: Load keyring and certificates early in boot
  PCI/CMA: Support built in X.509 certificates
  lib: rspdm: Support SPDM certificate validation
  rust: allow extracting the buffer from a CString
  lib: rspdm: Support SPDM challenge

Jonathan Cameron (1):
  PCI/CMA: Authenticate devices on enumeration

Lukas Wunner (7):
  X.509: Make certificate parser public
  X.509: Parse Subject Alternative Name in certificates
  X.509: Move certificate length retrieval into new helper
  certs: Create blacklist keyring earlier
  PCI/CMA: Validate Subject Alternative Name in certificates
  PCI/CMA: Reauthenticate devices on reset and resume
  PCI/CMA: Expose in sysfs whether devices are authenticated

 Documentation/ABI/testing/sysfs-devices-spdm |   31 +
 MAINTAINERS                                  |   14 +
 certs/blacklist.c                            |    4 +-
 certs/system_keyring.c                       |    4 +-
 crypto/asymmetric_keys/asymmetric_type.c     |    2 +-
 crypto/asymmetric_keys/x509_cert_parser.c    |    9 +
 crypto/asymmetric_keys/x509_loader.c         |   38 +-
 crypto/asymmetric_keys/x509_parser.h         |   40 +-
 crypto/asymmetric_keys/x509_public_key.c     |    2 +-
 drivers/pci/Kconfig                          |   13 +
 drivers/pci/Makefile                         |    4 +
 drivers/pci/cma.asn1                         |   41 +
 drivers/pci/cma.c                            |  272 +++++
 drivers/pci/doe.c                            |    5 +-
 drivers/pci/pci-driver.c                     |    1 +
 drivers/pci/pci-sysfs.c                      |    3 +
 drivers/pci/pci.c                            |   12 +-
 drivers/pci/pci.h                            |   15 +
 drivers/pci/pcie/err.c                       |    3 +
 drivers/pci/probe.c                          |    1 +
 drivers/pci/remove.c                         |    1 +
 include/keys/asymmetric-type.h               |    2 +
 include/keys/x509-parser.h                   |   55 +
 include/linux/oid_registry.h                 |    3 +
 include/linux/pci-doe.h                      |    4 +
 include/linux/pci.h                          |   16 +
 include/linux/spdm.h                         |   39 +
 lib/Kconfig                                  |   16 +
 lib/Makefile                                 |    2 +
 lib/rspdm/Makefile                           |   11 +
 lib/rspdm/consts.rs                          |  135 +++
 lib/rspdm/lib.rs                             |  180 +++
 lib/rspdm/req-sysfs.c                        |   97 ++
 lib/rspdm/state.rs                           | 1037 ++++++++++++++++++
 lib/rspdm/sysfs.rs                           |   28 +
 lib/rspdm/validator.rs                       |  489 +++++++++
 rust/bindgen_static_functions                |    5 +
 rust/bindings/bindings_helper.h              |    7 +
 rust/kernel/error.rs                         |    3 +
 rust/kernel/str.rs                           |    5 +
 40 files changed, 2587 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
 create mode 100644 drivers/pci/cma.asn1
 create mode 100644 drivers/pci/cma.c
 create mode 100644 include/keys/x509-parser.h
 create mode 100644 include/linux/spdm.h
 create mode 100644 lib/rspdm/Makefile
 create mode 100644 lib/rspdm/consts.rs
 create mode 100644 lib/rspdm/lib.rs
 create mode 100644 lib/rspdm/req-sysfs.c
 create mode 100644 lib/rspdm/state.rs
 create mode 100644 lib/rspdm/sysfs.rs
 create mode 100644 lib/rspdm/validator.rs

-- 
2.48.1


