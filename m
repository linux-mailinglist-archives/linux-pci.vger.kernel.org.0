Return-Path: <linux-pci+bounces-24135-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420D5A6921C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 16:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316C31708D7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 14:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFDB1B3934;
	Wed, 19 Mar 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtanLpIj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E98A12C499;
	Wed, 19 Mar 2025 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396036; cv=none; b=UNGEifcufagRhaNHHCa1QHtSZoWyyuklN6ihE/4HlRsCXhCOkDWtcxtPur6euoFQFBskEUL+AXNfIOpsopr+C1CeD4q19ZoAjcagxBUL6jffVIeHzxqmOmuJ8mMhXLsJ2cUYZWk5NdR8CohwmNsrya8IQcf9co1Hck4vofozSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396036; c=relaxed/simple;
	bh=LmRLcecLfEFxwXOfArnFJcuffCvuhH8QBekLkUi9knM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pb/geRZhnSR/MI+NEDC1lVnanLySSKCe1Y/ACjX+XAe5y15352mXC1Nnl5R2O5ACUXF2yOCudXVBHdNXZJpXVKZeMBev1Xgoj72Ow9Doanvp07v7LW/LDt89icN/SVa5QJzDYQiF2ipUPgQgsnHZeOf6skgtNiWmx8UmunXJzgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtanLpIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EC9C4CEE4;
	Wed, 19 Mar 2025 14:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742396036;
	bh=LmRLcecLfEFxwXOfArnFJcuffCvuhH8QBekLkUi9knM=;
	h=From:To:Cc:Subject:Date:From;
	b=YtanLpIj9G60dVc0/KSfhNAmPL/miWNx6MXQXTg1AYbPPmlPv/nAVWTJG93cZ3EOB
	 kBnBTDjFNduRtvBxoDtfQFzgNQ4ZzYYf/w9+Sgj4LidYMzlv6dBdxS6nARUDf867dz
	 AeBGBKwmQ8tfvU9IxpkB4rnMgKOTHXwgY6crfZyMVx0PzHsfZJA3+aIrV1Xza1IRK+
	 BQRHE0c0IvIAO/v7iRTJsn16BmRJUf10FqIbTZ9twUCIXU85E80ameHcAWz9EgQXmn
	 7/TuISM2Da0O/1ONcUQesoz3RpnVXW7TPoGQvrX7utUpY3ZwrqpTDGQPHwJQIqJLA4
	 fp09hen6hNGIA==
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
Subject: [PATCH 1/2] rust: pci: require Send for Driver trait implementers
Date: Wed, 19 Mar 2025 15:52:55 +0100
Message-ID: <20250319145350.69543-1-dakr@kernel.org>
X-Mailer: git-send-email 2.48.1
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

Fixes: 1bd8b6b2c5d3 ("rust: pci: add basic PCI device / driver abstractions")
Reported-by: Alice Ryhl <aliceryhl@google.com>
Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/pci.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 0d09ae34a64d..22a32172b108 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -222,7 +222,7 @@ macro_rules! pci_device_table {
 ///```
 /// Drivers must implement this trait in order to get a PCI driver registered. Please refer to the
 /// `Adapter` documentation for an example.
-pub trait Driver {
+pub trait Driver: Send {
     /// The type holding information about each device id supported by the driver.
     ///
     /// TODO: Use associated_type_defaults once stabilized:
-- 
2.48.1


