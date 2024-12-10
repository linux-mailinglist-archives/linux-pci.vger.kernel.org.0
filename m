Return-Path: <linux-pci+bounces-18076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAA9EBE89
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 23:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335571627FE
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB6D225A3E;
	Tue, 10 Dec 2024 22:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QPLkR8fQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2E211264;
	Tue, 10 Dec 2024 22:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733871101; cv=none; b=tUT0AP0Io4t4HEwqF+ZAIHvyxI7kq7EoGBrr9wEKLf8zLQT4x0RroB668EMAwVn7gk8DIqSm6mZdsXaeGilv/HNNK4nCOxzaqGvLfUXEqVIwbs0x0VPqMvPG54arJw2lXiFxSwMoU9DsZEtBF+BkZuCNRR5vyjI1xKUKPU7VTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733871101; c=relaxed/simple;
	bh=5bRC9IpLxj0D0qXMFpV6n22XRLzh6hoh8/W5/HtC2vM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jh8xs11r4T4ObyIgPXeSO48gI6Tk20o5A5ta/bnI7DRzBR3NKNOVofhSLuj8Vm+Q/cAPTX3K6WoM3BL4weKz7VDAgKnPwHtR8cymHc8bKYqnCryed2Ip4ix34rjpmKdpYqipiH827rXQrtkzo2bYjVWt+iEZqKFiGK1WdeHaC0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QPLkR8fQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94183C4CEE5;
	Tue, 10 Dec 2024 22:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733871100;
	bh=5bRC9IpLxj0D0qXMFpV6n22XRLzh6hoh8/W5/HtC2vM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPLkR8fQq/yP5+Z4/5jDf5zfedAwKU1GLQ+8e+cClNw03AeOUB4UPVwQB3KFaGZig
	 rWjua9nVKEWKfUGYo2Zwl7omkuhR8UEEYM8N9LOTMxuCNzx9JUh8qA1ZA9gMzqrqJ9
	 xhoRH4jsplj5mbb/8velCJAZu+Pfar2cAaJZ4El2rSae0x+AkuZ4abkpSxyRMy+lSX
	 KrcJxRsz1qA0WSx22HFKttt1ip/c4pANWxPJsFqys7RHu9dEXNVU8aZ2jmbfSO0y0H
	 l1ia6FUk7QPBVi4SxA0bcNdbVUcIpwZvpLo7fj9JccD1QNi+HTsk3zjQNrD4pWkPlD
	 In6mGV8cF0KWQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	tmgross@umich.edu,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	lina@asahilina.net,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com,
	robh@kernel.org,
	daniel.almeida@collabora.com,
	saravanak@google.com,
	dirk.behme@de.bosch.com,
	j@jannau.net,
	fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v5 16/16] MAINTAINERS: add Danilo to DRIVER CORE
Date: Tue, 10 Dec 2024 23:46:43 +0100
Message-ID: <20241210224947.23804-17-dakr@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241210224947.23804-1-dakr@kernel.org>
References: <20241210224947.23804-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's keep an eye on the Rust abstractions; add myself as reviewer to
DRIVER CORE.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 47b1a82dfdd0..ca3546f9f3b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7021,6 +7021,7 @@ F:	include/linux/component.h
 DRIVER CORE, KOBJECTS, DEBUGFS AND SYSFS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 R:	"Rafael J. Wysocki" <rafael@kernel.org>
+R:	Danilo Krummrich <dakr@kernel.org>
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
 F:	Documentation/core-api/kobject.rst
-- 
2.47.0


