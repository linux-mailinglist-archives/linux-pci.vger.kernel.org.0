Return-Path: <linux-pci+bounces-25373-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B32A7DF55
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 15:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0260188C57F
	for <lists+linux-pci@lfdr.de>; Mon,  7 Apr 2025 13:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C392557C;
	Mon,  7 Apr 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuTuJYHu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038822F19;
	Mon,  7 Apr 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032664; cv=none; b=tvTWsRXJoXENajzt3C7/hg5rDqE/jPGjudjgI3BH//NlsUtLCJmR5QyXihu0kyjr2Jx0i0EQa+9Pv36UMdxG8vwX0kRSGixcrE2RqLvvcW2vIRw21DHokQ3kmh5iImiypO0/6uFGYgFLkF7cO7e4z4pffx4R0EWZoP7oWnJn3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032664; c=relaxed/simple;
	bh=RceCGBrs6VmZXJMqKmA7bk3a68nJVVrKnb1B0yYe2MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uN/iquNQaukibqqXNwLUoAkn8AxJD+NmvTdr9X/KSSTWVb4fSkDvmfGNpFW5q8Qiniw54jGIaAGxHo6i7r/ytsZbv4SkNbiOwD0STA007d5iamxjbru0jQutb6eSbKN1Q3v4WUbaYk7XOPJ6d4beOunr47gqPBtL/uzauELAhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuTuJYHu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3690C4CEDD;
	Mon,  7 Apr 2025 13:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744032664;
	bh=RceCGBrs6VmZXJMqKmA7bk3a68nJVVrKnb1B0yYe2MU=;
	h=From:To:Cc:Subject:Date:From;
	b=KuTuJYHuHtP45Jaq9z+DpYTdj4PH0SBRj5O2d+65hpJaXlr+1/LEe4nH/93qKe9wj
	 qT0mqgifveHn7hf4YPz4S0Z8JajFIPc56fBRoxV86Rrkw9iJ3mTjj4A2pHeuYb88S2
	 eTbscQLjp88PdMqTzse5/rvcP7BKGyCm2lQx2C4G0Z2XCjyidhFS7gXODmyBjNzRAl
	 T7rnX0ugO6axaJyVc0mr3ImLEgcy3xm/AH71Itp5XVB4ldwXRPDUJJgNBqidfEk5qG
	 5nismG3E3lm2WORHY55b+tJE2nrvzEyB6NyJSv1sDyHGFujp89U9D7/Ba6nrKav2NP
	 vkR4VFVLHXqpQ==
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com,
	kw@linux.com
Cc: gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] MAINTAINERS: pci: add entry for Rust PCI code
Date: Mon,  7 Apr 2025 15:29:50 +0200
Message-ID: <20250407133059.164042-1-dakr@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Bjorn, Krzysztof and I agreed that I will maintain the Rust PCI code.
Therefore, create a new entry in the MAINTAINERS file.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..89f4bf7d9013 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18686,6 +18686,16 @@ F:	include/asm-generic/pci*
 F:	include/linux/of_pci.h
 F:	include/linux/pci*
 F:	include/uapi/linux/pci*
+
+PCI SUBSYSTEM [RUST]
+M:	Danilo Krummrich <dakr@kernel.org>
+R:	Bjorn Helgaas <bhelgaas@google.com>
+R:	Krzysztof Wilczyński <kw@linux.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+C:	irc://irc.oftc.net/linux-pci
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
+F:	rust/helpers/pci.c
 F:	rust/kernel/pci.rs
 F:	samples/rust/rust_driver_pci.rs
 

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.49.0


