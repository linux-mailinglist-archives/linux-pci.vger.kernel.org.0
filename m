Return-Path: <linux-pci+bounces-37108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C33A7BA49F9
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F767BC23C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4532026C3BD;
	Fri, 26 Sep 2025 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZSenCnDy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1B125FA13;
	Fri, 26 Sep 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904064; cv=none; b=OilACY4bcfV3ul5Orq3JK2QSkxN1u9yJr8qp8Lg3G/z3sBLtSn155PFiBOeodmj1J+xf/EPMlO1neMPukvrbGDhJTibP5rOtpw4q7N4thLpCSupnQYz5JM7ir3fPbGuTF3+dPp3oUAxQ21fPB37MmFiv6M5koiKDQSIpTEbCt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904064; c=relaxed/simple;
	bh=q4hs9AuGgKoM1p8EhtnQRn0bIzEyhLE3EGxPyvfGB+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fpo/8h58Xalmjng9xOOxUdwBrZUdOjEohJKcjoyI2/f2f5NilDfrbYpDOzdiMBy3+YAatOgxhebSmv6LntIPeKVOQvAx5REUrnC2X4vfiQzy5tBEL37C5khvVgSbzfWxebn0jxA4AThdxp3skGO35/P2DFo/nFlXUArgTY0/9e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZSenCnDy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092C1C116D0;
	Fri, 26 Sep 2025 16:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904063;
	bh=q4hs9AuGgKoM1p8EhtnQRn0bIzEyhLE3EGxPyvfGB+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZSenCnDy7YJ0X2yIjCf4yy0nDY+42PJ8US/tkoY6QRpsb+EWdpkvNRYlKMFBRcgG9
	 AW5Hn7esd0gUuro1qsqfeqy29S/eYG1DT5rSUvQ0o4pRBLPqte12N9ggbTSg3gOHda
	 I+ZXhppqDm14Qq1pFk/D38TOALPex1kkEvtt6liMJDrnmPOotRMtSoU7xNunXxuOBF
	 Ax7XUSM8P3ze9oDILfUVIhA240nf8ymreAsB7f+PFbj0kE8RbdXSHCX70gli+FohKK
	 7FBMVpRUTjdE3L+XJQMVqX/vBaYHejWfh+NYls/K8COYj7o9+9ZjLf84rzI5eHcLpE
	 DbsgeuvT+gUtg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v4 3/3] PM: runtime: Drop DEFINE_FREE() for pm_runtime_put()
Date: Fri, 26 Sep 2025 18:26:40 +0200
Message-ID: <7855547.EvYhyI6sBW@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
References: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The DEFINE_FREE() for pm_runtime_put has been superseded by recently
introduced runtime PM auto-cleanup macros and its only user has been
converted to using one of the new macros, so drop it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
---

v3 -> v4: Pick up R-by from Dhruva

v1 -> v3: No changes

---
 include/linux/pm_runtime.h |    2 --
 rust/kernel/cpufreq.rs     |    3 ++-
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -561,8 +561,6 @@ static inline int pm_runtime_put(struct
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
-DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
-
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -39,7 +39,8 @@ use macros::vtable;
 const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
 
 /// Default transition latency value in nanoseconds.
-pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
+pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
+    bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
 
 /// CPU frequency driver flags.
 pub mod flags {




