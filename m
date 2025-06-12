Return-Path: <linux-pci+bounces-29548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C423EAD714F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CE3216367B
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3654E23D28B;
	Thu, 12 Jun 2025 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcEd6hF9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3723D284;
	Thu, 12 Jun 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733908; cv=none; b=C2rEMn5qdIWVfUy3Y2v+6fbWLH0E71TdSKXuOtvIK+QMk9MOvxwU4JnvWSDZNUhdIno/kFCTxqA0X4PzXqwYfE65HQ9JTwvGe5MIi6KNvVieeEEzyxKz6/4+pXufFnRPsCql8gMSJWewpdeWFAr34quVxgbKNGGddkmzbG+std0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733908; c=relaxed/simple;
	bh=bIy2thIEfxDGMyB737DcdbHDleWakNZE1CwB2X4ViXU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oesXwxp+GeZQI8F5ytTgmUhwzwp9uGWiE203u+nrXD4adMVrduw5iDHiLONhRhiOb67wFp02QnlO/8axa8tzHlv5M/i7GG9IO79znz/i3Qyy8aBeQC56jaEfUIiNAkx6gjzc9DyuTMy7/dp+eDY7IKyZVwruyxqQxCpQ2pQqg+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcEd6hF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ABFC4CEEA;
	Thu, 12 Jun 2025 13:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749733907;
	bh=bIy2thIEfxDGMyB737DcdbHDleWakNZE1CwB2X4ViXU=;
	h=From:Subject:Date:To:Cc:From;
	b=OcEd6hF9UaHs1aIuWHxMuJQzT1/evtHx8yOF4SHsVekPIEsFqzA8s3WBZHnY+hNce
	 R62jWCA/TYudMVU3N0+gjT6Suq2y5RqqpUTU4kChQZT0R5eJuFUfb8l10Tje8aSUrO
	 hJyATSqMsyZIjSkQQngOq7JL+oh4blpHOJQVgThc70HT+zt/lMEuD2QuNS5F2gKHIU
	 UW1EX3Vt9g0+3UwqPtfpa0OGQ0IwOKsKJgwckjcNp3xWNhBpNniQ/9S29KogBaVMPy
	 F7oIEFcen0XT6kWUpGZQelyRYmH0/QrRZbPjfoknJjuTx9s9+LySfd4tenLMsozCnO
	 FwwO+2BQZ5xvQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Subject: [PATCH v3 0/2] rust: improve `ForeignOwnable`
Date: Thu, 12 Jun 2025 15:09:42 +0200
Message-Id: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbRSmgC/23MQQrCMBCF4auUWRvJjKRaV95DXJR00g5KUpISl
 NK7m3ZlweV78P0zJI7CCa7VDJGzJAm+jNOhAju0vmclXdlAmoyutVFjED9xp6agajzrljUa0g4
 KGCM7eW+x+6PsQdIU4mdrZ1zfv5mMChUzMtXUIFl7e3L0/DqG2MPayfRjUe8sFeva7uIasg7Z7
 OyyLF/gXYFT4QAAAA==
X-Change-ID: 20250605-pointed-to-6170ae01520f
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=bIy2thIEfxDGMyB737DcdbHDleWakNZE1CwB2X4ViXU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoStGZ17fL8yiCQEhNAsNp6t7+FqLczWFIdk6+u
 RkHDER3wg6JAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaErRmQAKCRDhuBo+eShj
 d7ulEADBumqdwZTNXkUtozvBItTY1O6Gt0D2UL7eBML2BaNtx84E83warF4pF5m6nxu1gQsBdbf
 zRprxy544Dq+q4FgVP74BSF/5NdK4Qn4dpk22Evxwmhw3OrlWeLtWSdQKAPlFspW1bo/6dYl6nW
 oB1RuXHe1fjczhpOibvFddpUS0rPR4MtaUCB8hpEMMpvjp6guWp2IHycFJ03af7d5g/r4eTGQ3n
 79twylyC/X9JHZjioZSj2rGFwkTCOJEa6WoRPeNxuLpbjaUZEZQ6AFFya6/XS+UpskkwzdChNnt
 lMGu1oqmS2mgy2LD/fyttxPWCenjCm4CsspCXluquxqGyBQsC+t5Mo1aAwpnp3KInz6qfRiR9BJ
 cLWq0Dz2nZBeGCAxuYgOZ3Cv/GQS9dgIEqPpO5nDesDjsWaf2Drol51mb2/B+9n/6QFeq2l2sMt
 jdQ6qwxCKIrV2xKmQzVW4iYovdajRfAVqi1UZ3SfDVSxfcTtcMWRbVzaWup5R4JsDNOXA21H8tW
 W0Xko/4UldgFC7tdungh1dgFhGH0UplFWAVTezBuIHEP1R9WQL8L/JMaaOVQdbJTSm8CJGyUfzT
 pbKmQAJjNIhcijDCCULAxgvdNMbSmlHtNO+RA9Q/p2kzSlmkAhCONsyCaN9I/nP9XlrwEhwmB1T
 tSrZGxhJIzp5Pow==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

This series improves `ForeignOwnable` by:

 - changing the way we assert pointer allignment,
 - improving the safety requirements of the trait.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
Changes in v3:
- Remove more instances of absolute paths to `ffi` types.
- Reword safety requirements in terms of function guarantees.
- Add a patch to restrict use of null pointers with `ForeignOwnable`.
- Link to v2: https://lore.kernel.org/r/20250610-pointed-to-v2-1-fad8f92cf1e5@kernel.org

Changes in v2:
- Replace qualified path with `use` for `crate::ffi::c_void`.
- Fix a typo and rephrase docs for `ForeignOwnable`.
- Reorganize docs for `ForeignOwnable::into_foreign`.
- Link to v1: https://lore.kernel.org/r/20250605-pointed-to-v1-1-ee1e262912cc@kernel.org

---
Andreas Hindborg (2):
      rust: types: add FOREIGN_ALIGN to ForeignOwnable
      rust: types: require `ForeignOwnable::into_foreign` return non-null

 rust/kernel/alloc/kbox.rs | 41 +++++++++++++++++++++++------------------
 rust/kernel/miscdevice.rs | 10 +++++-----
 rust/kernel/pci.rs        |  2 +-
 rust/kernel/platform.rs   |  2 +-
 rust/kernel/sync/arc.rs   | 24 +++++++++++++-----------
 rust/kernel/types.rs      | 46 +++++++++++++++++++++++-----------------------
 rust/kernel/xarray.rs     |  9 +++++----
 7 files changed, 71 insertions(+), 63 deletions(-)
---
base-commit: ec7714e4947909190ffb3041a03311a975350fe0
change-id: 20250605-pointed-to-6170ae01520f

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



