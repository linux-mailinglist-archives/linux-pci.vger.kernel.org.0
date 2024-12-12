Return-Path: <linux-pci+bounces-18319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533429EF3CE
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 18:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0964317D05D
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FF50242A9F;
	Thu, 12 Dec 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmTwzaQj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D3223C5C;
	Thu, 12 Dec 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021408; cv=none; b=Roa5KGSrb+cJ6h4sLWVceF66TE4io9csMKokqqb2P/cBYJwAHG/RhFx1QKQHw/ewhf+WMrpAkbPjgqClJm4Eh7Sb69Pz+lOmEo0fh3rqaOx1KJyQWpT73BY8/75e8Pl0loP1A3Vd9oVgAgWOuNbfdPzNtkUBxebRBTOil0NcvHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021408; c=relaxed/simple;
	bh=ltomMjy5y7L8lzyf7pvlUKvJ0SvIiUEzsOHnZ3Azi/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bo9sXXRVmC+3kTJYZFnxPSzEWXVgxSjfwb+gqmwdUZX6+JzOM1QG3LDHJ5N6T9xdueGV2v1krniNOllh41frbcRoEVNPIeGZ3e57vtH85PPAYO5EyC5KS1TPVrC8rHrxh99p167l7916PDHCRRpIZapMrOSsyqrPg+hVNsKLBdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmTwzaQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6770EC4CED0;
	Thu, 12 Dec 2024 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734021408;
	bh=ltomMjy5y7L8lzyf7pvlUKvJ0SvIiUEzsOHnZ3Azi/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmTwzaQjefuQscdXiMjlQAAK4GNk4+na2qkCgKdBAEBungkA2a9+GDB8WTTRpPfKg
	 QOFXVeWus6Y9o5et4Ptkv/fgI/mk3N5RKJEJs06CdeTaFVAvK3pB57e6UxO9LqtIqD
	 pd6bPMXG+jcBXySaZ9Ozt+VulUhNUagV2xNp3bsNS1P8JNXPsmPtout0MPk95Ey1xG
	 FZDKibBVcYzj/IHJR4KjmZOkNlBtIrfdDHhYAhWyEMgyYFNgi/5UWlWMfN/wg69i8U
	 /ZjK19gBLUrPGimx9jj3WcWqgEgM7gITglCCON5YaWVhupLiXgkQg01Ll+uv/r9uyh
	 vMgUdMOcSNCUQ==
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
	chrisi.schrefl@gmail.com,
	paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	rcu@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v6 16/16] MAINTAINERS: add Danilo to DRIVER CORE
Date: Thu, 12 Dec 2024 17:33:47 +0100
Message-ID: <20241212163357.35934-17-dakr@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212163357.35934-1-dakr@kernel.org>
References: <20241212163357.35934-1-dakr@kernel.org>
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
index 95bd7dc88ad8..6b9e10551392 100644
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
2.47.1


