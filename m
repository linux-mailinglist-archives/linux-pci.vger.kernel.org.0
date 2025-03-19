Return-Path: <linux-pci+bounces-24136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0CAA69221
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 16:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2399171A7B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9B1DF98E;
	Wed, 19 Mar 2025 14:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4qD2VAX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322B912C499;
	Wed, 19 Mar 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396040; cv=none; b=AA2BrP5Z0Lg+1jzSIGAn1/txPt09vL1JEpi48kpjIboBRJsvOkgmLGTaNVQBtpB1RgLC4Lhz9ZCLvfvKU2FcumnEBefaJi3dOq3eAV2yZVXzk1QyZ4QIeYxwnmtakN/PCrojrN3FZaYIGUQn3grEyaOjsYdZIsOLcOB2Kl/gRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396040; c=relaxed/simple;
	bh=UbK7w+zXIirXffFtrlTXfemOE22THTSAu37y25idMog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moHU8m618CnfRVwN9iOFMU1I2oqXqbBbX91WuXGtC9UitBOVPRWvf12byTI04QpLb5KrEQ7r024F1C8KtLdiDR407ZNWNyF/+oKvMQCLu2yrZUoyagGx+3JBG3drkKN3E0yrpFsObFoM7lmQoRLyTkmUi5+J8HFK0Bl3o56UXMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4qD2VAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA14C4CEEC;
	Wed, 19 Mar 2025 14:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742396039;
	bh=UbK7w+zXIirXffFtrlTXfemOE22THTSAu37y25idMog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4qD2VAXSvm2lK+Tgjl7+RXJZRdsk4arFDNiB8407Z3Q1AI2bWv7vKlOZhbYc4RQS
	 uCQpUvXtsBQpIxyVwtOvSGcdZAIs9yUsHNwnzdDjP4gEI3YhDoRmHA2JUEsEgHVQzM
	 eB2vG2dZq8koIEATdNPt+0tlPtc2V2vW4xSOztH+Sbiv/I0KmpiZKKDFyi5Q/pCkoB
	 UQYQ2UE7Ijiap1Sqgo3TE3kSeHNkqUNbVoWk/NIFA+arg7jltcNgqgaGVcboVPoXKb
	 uBOxo/ALVfo2SBaK6aEEUcKlDohZ1covUS5SN7DFMLdKL1zQRlSdYdwA+rfFsU72an
	 X32rKGq2lNobA==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
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
Subject: [PATCH 2/2] rust: platform: require Send for Driver trait implementers
Date: Wed, 19 Mar 2025 15:52:56 +0100
Message-ID: <20250319145350.69543-2-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319145350.69543-1-dakr@kernel.org>
References: <20250319145350.69543-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The instance of Self, returned and created by Driver::probe() is
dropped in the bus' remove() callback.

Request implementers of the Driver trait to implement Send, since the
remove() callback is not guaranteed to run from the same thread as
probe().

Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver abstractions")
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/platform.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 2811ca53d8b6..e37531bae8e9 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -149,7 +149,7 @@ macro_rules! module_platform_driver {
 ///     }
 /// }
 ///```
-pub trait Driver {
+pub trait Driver: Send {
     /// The type holding driver private data about each device id supported by the driver.
     ///
     /// TODO: Use associated_type_defaults once stabilized:
-- 
2.48.1


