Return-Path: <linux-pci+bounces-36520-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D05AB8A998
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17FEA5A66B6
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F384306B3D;
	Fri, 19 Sep 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOUCMEA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647D926CE2B;
	Fri, 19 Sep 2025 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300042; cv=none; b=tZ2EKtVtSRznPfWhC0Yj1mfw8VWwFeqBMnpAJymCjlY3Yrd5cKyFM4DUHeZFjHYFS4XubLx0CSMSztsYHljx4677tmn4Y+gjQILLTa8HffndNC5FnL2nrC0F/XWFxMYwOlurP5HLpo1lh1qXFR56gUK/uHG8bobsC5lMN46FZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300042; c=relaxed/simple;
	bh=5gTnW3I/NqFh1bOYgEo3YvuTdJlKrTDdYrhiKlb663U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IrB+fjgStG8liHICxfXj2q32kjrCkuod1RcPvJa/T/rVViGqk4SlqHRfJjmXX7kEJ9qxBXkOWvlL6u1y2H2e82n2VcB5gHfbucnLuCuo3InUgCIYnCM7TdSkWazMmteRBEEcEjhxoTy7fBXlmEH66swnG0lGOF5iuYJr4aaSATk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOUCMEA2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2790AC4CEF0;
	Fri, 19 Sep 2025 16:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300042;
	bh=5gTnW3I/NqFh1bOYgEo3YvuTdJlKrTDdYrhiKlb663U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOUCMEA2aOsF3N+VblkjSlxzwfQZ4DeqqBg59NJZRhrk7tEpVBVYTjI4FPXFim4c4
	 UzWe9D1b8lCyACTKvWwxS+2D/WwYsyHPO3EvISxURmU2Yq8Rkf6oemtbhH9qclSdEQ
	 opTxnDuxvhzQKIL7bzbBDFF1t1jtrf/SrUVwcv4qBcSKKS0hsgtSwqGxArSh1ehhj8
	 VYjUzoTNTB1gpFSpu1Jkvb0tXwjGdzufyv4EkTg6zxTqgcH6LnQKKejUCHpuzTq3+/
	 cO0A7QwZ9q6d8g0psIXNs7/B5gzvK/yoHOAntaQgBuWGsht1IFXWWkmMNgx1O4X38w
	 ELuFJ3M9RnkOA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v1 3/3] PM: runtime: Drop DEFINE_FREE() for pm_runtime_put
Date: Fri, 19 Sep 2025 18:40:13 +0200
Message-ID: <3016592.e9J7NaK4W3@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5049058.31r3eYUQgx@rafael.j.wysocki>
References: <5049058.31r3eYUQgx@rafael.j.wysocki>
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
---
 include/linux/pm_runtime.h |    2 --
 1 file changed, 2 deletions(-)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -579,8 +579,6 @@ static inline int pm_runtime_put(struct
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
-DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
-
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.




