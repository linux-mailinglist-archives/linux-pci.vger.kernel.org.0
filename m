Return-Path: <linux-pci+bounces-29445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2470AD575B
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 15:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 122783A28A1
	for <lists+linux-pci@lfdr.de>; Wed, 11 Jun 2025 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEBE28A708;
	Wed, 11 Jun 2025 13:37:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABADB2857CF;
	Wed, 11 Jun 2025 13:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749649064; cv=none; b=jIydv1zJOVsT+gvY4KkcuVHSWyZMLFG6tT5V/OZ/IbsebJG6KIXoVa+SjKLhfhBGvFRmiipmMuooiag3uCFSJYqiBrEN0TEgMif86OnwmCJ6iijRGHqlAx+JgKq2izrMtg5esO69OfkF2PtVbZmR9RGMiZayxsaKnwVjvbFbDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749649064; c=relaxed/simple;
	bh=LlinO4DQVDm6Z0yBVcBfYI1ybTL41BszC99Grakd+uA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iLQ4NzLqVjlz3C+BJ6A8r5oIQTuSSIRkribiaXKG8326jo/MDYunA9Vdcab98qTQ4tD1OMvAAhG0vA+uFdP/iAL7U+/yU5wZERA+YSjEreUEvDWG1VDd2DWC9eX97+m5Lc4MBe38sNcGRppnGHGF+tYHVLIgVUAM1UNOjRNnnHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHRXq1JY4z6DB2C;
	Wed, 11 Jun 2025 21:37:15 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 83C221405E2;
	Wed, 11 Jun 2025 21:37:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Jun
 2025 15:37:38 +0200
Date: Wed, 11 Jun 2025 14:37:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Alistair Francis <alistair@alistair23.me>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lukas@wunner.de>, <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
	<rust-for-linux@vger.kernel.org>, <akpm@linux-foundation.org>,
	<boqun.feng@gmail.com>, <bjorn3_gh@protonmail.com>,
	<wilfred.mallawa@wdc.com>, <aliceryhl@google.com>, <ojeda@kernel.org>,
	<alistair23@gmail.com>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
	<gary@garyguo.net>, <alex.gaynor@gmail.com>, <benno.lossin@proton.me>
Subject: Re: [RFC v2 00/20] lib: Rust implementation of SPDM
Message-ID: <20250611143737.00005e21@huawei.com>
In-Reply-To: <20250227030952.2319050-1-alistair@alistair23.me>
References: <20250227030952.2319050-1-alistair@alistair23.me>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 27 Feb 2025 13:09:32 +1000
Alistair Francis <alistair@alistair23.me> wrote:

> Security Protocols and Data Models (SPDM) [1] is used for authentication,
> attestation and key exchange. SPDM is generally used over a range of
> transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
> 
> From the kernels perspective SPDM is used to authenticate and attest devices.
> In this threat model a device is considered untrusted until it can be verified
> by the kernel and userspace using SPDM. As such SPDM data is untrusted data
> that can be mallicious.
> 
> The SPDM specification is also complex, with the 1.2.1 spec being almost 200
> pages and the 1.3.0 spec being almost 250 pages long.
> 
> As such we have the kernel parsing untrusted responses from a complex
> specification, which sounds like a possible exploit vector. This is the type
> of place where Rust excels!
> 
> This series implements a SPDM requester in Rust.
> 
> This is very similar to Lukas' implementation [2]. This series includes patches
> and files from Lukas' C SPDM implementation, which isn't in mainline.
> 
> This is a standalone series and doesn't depend on Lukas' implementation, although
> we do still rely on Lukas' crypto preperation patches, not all of which are
> upstream yet.
> 
> To help with maintaining compatibility it's designed in a way to match Lukas'
> design and the state struct stores the same information, although in a Rust
> struct instead of the original C one.
> 
> This series doesn't expose the data to userspace (except for a single sysfs
> bool) to avoid the debate about how to do that. I'm planning to do that in
> the future though.
> 
> This series is based on the latest rust-next tree.
> 
> This seris depends on the Untrusted abstraction work [4].
> 
> This seris also depends on the recent bindgen support for static inlines  [5].
> 
> The entire tree can be seen here: https://github.com/alistair23/linux/tree/alistair/spdm-rust
> 
> based-on: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
> based-on: https://lore.kernel.org/rust-for-linux/20250107035058.818539-1-alistair@alistair23.me/

Hi Alastair,

I've completely failed to find time to actually pick up enough rust to review
this :(  Also failed to find anyone else who has the rust skills and enough of
the background.

Ideally I'll get up to speed at some point, but in the meantime wanted to revisit
the question of whether we want to go this way from day 1 rather than trying to
deal with C version and later this?

What's your current thoughts?  I know Lukas mentioned he was going to spin a
new version shortly (in one of the TSM threads) so are we waiting on that?

For now I'm going to take this off my review queue. Sorry!

Jonathan



> 
> 1: https://www.dmtf.org/standards/spdm
> 2: https://lore.kernel.org/all/cover.1719771133.git.lukas@wunner.de/
> 3: https://github.com/l1k/linux/commits/spdm-future/
> 4: https://lore.kernel.org/rust-for-linux/20240925205244.873020-1-benno.lossin@proton.me/
> 5: https://lore.kernel.org/rust-for-linux/20250107035058.818539-1-alistair@alistair23.me/
> 
> v2:
>  - Drop support for Rust and C implementations
>  - Include patches from Lukas to reduce series deps
>  - Large code cleanups based on more testing
>  - Support support for authentication
> 
> Alistair Francis (12):
>   lib: rspdm: Initial commit of Rust SPDM
>   lib: rspdm: Support SPDM get_version
>   lib: rspdm: Support SPDM get_capabilities
>   lib: rspdm: Support SPDM negotiate_algorithms
>   lib: rspdm: Support SPDM get_digests
>   lib: rspdm: Support SPDM get_certificate
>   crypto: asymmetric_keys - Load certificate parsing early in boot
>   KEYS: Load keyring and certificates early in boot
>   PCI/CMA: Support built in X.509 certificates
>   lib: rspdm: Support SPDM certificate validation
>   rust: allow extracting the buffer from a CString
>   lib: rspdm: Support SPDM challenge
> 
> Jonathan Cameron (1):
>   PCI/CMA: Authenticate devices on enumeration
> 
> Lukas Wunner (7):
>   X.509: Make certificate parser public
>   X.509: Parse Subject Alternative Name in certificates
>   X.509: Move certificate length retrieval into new helper
>   certs: Create blacklist keyring earlier
>   PCI/CMA: Validate Subject Alternative Name in certificates
>   PCI/CMA: Reauthenticate devices on reset and resume
>   PCI/CMA: Expose in sysfs whether devices are authenticated
> 
>  Documentation/ABI/testing/sysfs-devices-spdm |   31 +
>  MAINTAINERS                                  |   14 +
>  certs/blacklist.c                            |    4 +-
>  certs/system_keyring.c                       |    4 +-
>  crypto/asymmetric_keys/asymmetric_type.c     |    2 +-
>  crypto/asymmetric_keys/x509_cert_parser.c    |    9 +
>  crypto/asymmetric_keys/x509_loader.c         |   38 +-
>  crypto/asymmetric_keys/x509_parser.h         |   40 +-
>  crypto/asymmetric_keys/x509_public_key.c     |    2 +-
>  drivers/pci/Kconfig                          |   13 +
>  drivers/pci/Makefile                         |    4 +
>  drivers/pci/cma.asn1                         |   41 +
>  drivers/pci/cma.c                            |  272 +++++
>  drivers/pci/doe.c                            |    5 +-
>  drivers/pci/pci-driver.c                     |    1 +
>  drivers/pci/pci-sysfs.c                      |    3 +
>  drivers/pci/pci.c                            |   12 +-
>  drivers/pci/pci.h                            |   15 +
>  drivers/pci/pcie/err.c                       |    3 +
>  drivers/pci/probe.c                          |    1 +
>  drivers/pci/remove.c                         |    1 +
>  include/keys/asymmetric-type.h               |    2 +
>  include/keys/x509-parser.h                   |   55 +
>  include/linux/oid_registry.h                 |    3 +
>  include/linux/pci-doe.h                      |    4 +
>  include/linux/pci.h                          |   16 +
>  include/linux/spdm.h                         |   39 +
>  lib/Kconfig                                  |   16 +
>  lib/Makefile                                 |    2 +
>  lib/rspdm/Makefile                           |   11 +
>  lib/rspdm/consts.rs                          |  135 +++
>  lib/rspdm/lib.rs                             |  180 +++
>  lib/rspdm/req-sysfs.c                        |   97 ++
>  lib/rspdm/state.rs                           | 1037 ++++++++++++++++++
>  lib/rspdm/sysfs.rs                           |   28 +
>  lib/rspdm/validator.rs                       |  489 +++++++++
>  rust/bindgen_static_functions                |    5 +
>  rust/bindings/bindings_helper.h              |    7 +
>  rust/kernel/error.rs                         |    3 +
>  rust/kernel/str.rs                           |    5 +
>  40 files changed, 2587 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-spdm
>  create mode 100644 drivers/pci/cma.asn1
>  create mode 100644 drivers/pci/cma.c
>  create mode 100644 include/keys/x509-parser.h
>  create mode 100644 include/linux/spdm.h
>  create mode 100644 lib/rspdm/Makefile
>  create mode 100644 lib/rspdm/consts.rs
>  create mode 100644 lib/rspdm/lib.rs
>  create mode 100644 lib/rspdm/req-sysfs.c
>  create mode 100644 lib/rspdm/state.rs
>  create mode 100644 lib/rspdm/sysfs.rs
>  create mode 100644 lib/rspdm/validator.rs
> 


