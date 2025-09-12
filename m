Return-Path: <linux-pci+bounces-36050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9040DB5558D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 19:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E63416936F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65243324B24;
	Fri, 12 Sep 2025 17:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abWVJLlu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C63081BD;
	Fri, 12 Sep 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757698944; cv=none; b=XO2tYKnAoZXDSCzblyunj06NbB/jhMOUgHVoHmZiul2TB729Id8MuzGHg+i3TlohALSXd5gvc8EMBnT3UCHZNfhDH71nefgwTR1szkzxuPoykA8mbh1WCweTXVolrp2oT8sVHZ285ZorIkxV540tcFSOnc3IVkj/s8STMy/dLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757698944; c=relaxed/simple;
	bh=0cY7VeaySFBSAW5INmThb2nsUazkylOBbySNCBPZKbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VX1vx7p1ohl8fRf0dFBZKMdLxTHBGhxQMjKyoyn/vvgOmwmK/no2RqGsP82+yVll1UKNvV3k41OxnXS4ErqEMJPOzi1t6wy2yVQuQw+DXGn5mIGkPwBbgzU4QZYX4VkAIG7YpJekkvSMZNdSXMEZguushY9mrYKK0bQOnlfNR08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abWVJLlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1EC4CEF1;
	Fri, 12 Sep 2025 17:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757698943;
	bh=0cY7VeaySFBSAW5INmThb2nsUazkylOBbySNCBPZKbw=;
	h=From:To:Cc:Subject:Date:From;
	b=abWVJLluulo3Sk63YTyecs8iH4LIt/zrLRDB5tD2tBXVS1+CDaUuymgYv4H8Iu2e+
	 jqp+YeWn1u/W9HmZ8uuv3y+CeFyk2O8TGJ+Q1Uz88EcyWG5DGBHxLGWWeBp2EDVrxY
	 mdJJ+6gRj//jEbPpWz00DlDDCcsb6MN4Fyt7GfrpCHJtypipvNSDiKpzuAfqY86TIZ
	 BI0dORgLOvQQqqqdBGljofFyaejshKgxVvD1V2Vugw4QPD4jTneT5tCofs7ToFh3Kb
	 qfrXIZm63eXPsPHhExHGzb3CNeBzdBWgeP5Ese5GCL+oRQ47ciyXLcDwvXEYN2NZxh
	 AZEZ88lGdszVw==
From: Benno Lossin <lossin@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Benno Lossin <lossin@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Tamir Duberstein <tamird@gmail.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Fiona Behrens <me@kloenk.dev>,
	Christian Schrefl <chrisi.schrefl@gmail.com>,
	Alban Kurti <kurti@invicto.ai>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [GIT PULL] Rust pin-init for v6.18
Date: Fri, 12 Sep 2025 19:41:46 +0200
Message-ID: <20250912174148.373530-1-lossin@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Danilo,

As discussed with Miguel, I'm sending my PR to you this time.

The code changes themselves aren't that big, but functionality-wise
there are three important ones: pin-projections, code blocks and access
to previously initialized fields. More syntax changes will be on the way
for v6.19 and I hope I'll be a bit earlier in that cycle :)

The commits have been in linux-next for one day.

I have a conflict with your devres fix that's in -rc3, the resolution in
linux-next looks good.

Please pull for v6.18 -- thanks!

---
Cheers,
Benno

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  https://github.com/Rust-for-Linux/linux.git tags/pin-init-v6.18

for you to fetch changes up to 42415d163e5df6db799c7de6262d707e402c2c7e:

  rust: pin-init: add references to previously initialized fields (2025-09-11 23:30:02 +0200)

----------------------------------------------------------------
pin-init changes for v6.18

Changed:

- `#[pin_data]` now generates a `*Projection` struct similar to the
  `pin-project` crate.

- Add initializer code blocks to `[try_][pin_]init!` macros: make
  initializer macros accept any number of `_: {/* arbitrary code */},` &
  make them run the code at that point.

- Make the `[try_][pin_]init!` macros expose initialized fields via a
  `let` binding as `&mut T` or `Pin<&mut T>` for later fields.

Upstream dev news:

- Released v0.0.10 before the changes included in this tag.

- Inform users of the impending rename from `pinned-init` to `pin-init`
  (in the kernel the rename already happened).

- More CI improvements.

----------------------------------------------------------------
Benno Lossin (6):
      rust: pin-init: examples: error: use `Error` in `fn main()`
      rust: pin-init: README: add information banner on the rename to `pin-init`
      rust: pin-init: rename `project` -> `project_this` in doctest
      rust: pin-init: add pin projections to `#[pin_data]`
      rust: pin-init: add code blocks to `[try_][pin_]init!` macros
      rust: pin-init: add references to previously initialized fields

 rust/kernel/devres.rs           |   6 +-
 rust/kernel/workqueue.rs        |   9 +-
 rust/pin-init/README.md         |  12 ++
 rust/pin-init/examples/error.rs |   4 +-
 rust/pin-init/src/lib.rs        |   4 +-
 rust/pin-init/src/macros.rs     | 239 ++++++++++++++++++++++++++++++++++------
 samples/rust/rust_driver_pci.rs |   2 +-
 7 files changed, 227 insertions(+), 49 deletions(-)

