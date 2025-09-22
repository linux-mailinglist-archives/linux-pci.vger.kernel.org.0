Return-Path: <linux-pci+bounces-36686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BEDB91F29
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539A117E524
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AE2E7197;
	Mon, 22 Sep 2025 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W9RL44iQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A942264B2;
	Mon, 22 Sep 2025 15:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555199; cv=none; b=hBZY3bCvS3bXabpNdQrzcMDKJSfWSLYYDK7nKG5EwrijlNm93Nb2u9r0JUd2Nv8tFXxCEEjjJh2UWwikmNJsJm6m0Ap/XAGC9FHUAMZ8CpTNMni+WeJpdjqNJsYCSNnc5YpoCdKod1hWy2eKhhYM5VbtRJuphjbfUhdy5wSki4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555199; c=relaxed/simple;
	bh=MbbyWa/Cvkd1FIcjtMh8Dx20mYbioqWVqL5+Z3kN8ZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlsHaQdrGR1dbtf/Ptj5fzg9MMMKXa4iA01r9PYHYaNajXtcwX8gBKxn8VN+007bGIhehAkwfi9EpAf/Mib6IGF1agIOg7MhszbmYF1gQK4KB6VpL8bF4s38pu5QXXMHv49mKRPKMZeqLyOBng+dE1F5aIzOATIZa+uayl1bJIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W9RL44iQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65A5C4CEF0;
	Mon, 22 Sep 2025 15:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555198;
	bh=MbbyWa/Cvkd1FIcjtMh8Dx20mYbioqWVqL5+Z3kN8ZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W9RL44iQlqyEG3RoVi15aoQNirL3ptwg+gPIXXTd9hw+wGpfK64BRQPixb8O1hxOI
	 QVW1GOeAh20HyXTb2JIkx1Oztd6+GemqQ8u1J3ejxqexxPMKl7X9noA+1GsJRRQ/J0
	 thBXLjFP3IqlMnnaLBxsS/Mw/ai2nMvSxOLZIe8cjtP2sHPk0YjgCcJ3pbn56LZv/s
	 X2s9f7fYIFpq5KPOz0sNWkcNh9eYl3MKWkBRrVjaU91tUl8mVZnmUD3kHTHSb1gq/z
	 UNqzzMa9OJKb6mZ2aO1MOY6DtThyKkueKeKVDTvH9kBk4n+m/KaYDSbHYzT2cclZEP
	 Pa3kF8ZaY3o2w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 3/3] PM: runtime: Drop DEFINE_FREE() for pm_runtime_put()
Date: Mon, 22 Sep 2025 17:33:07 +0200
Message-ID: <13866828.uLZWGnKmhe@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12763087.O9o76ZdvQC@rafael.j.wysocki>
References: <12763087.O9o76ZdvQC@rafael.j.wysocki>
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

v2 -> v3: No changes

v1 -> v2: No changes

---
 include/linux/pm_runtime.h |    2 --
 1 file changed, 2 deletions(-)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -582,8 +582,6 @@ static inline int pm_runtime_put(struct
 	return __pm_runtime_idle(dev, RPM_GET_PUT | RPM_ASYNC);
 }
 
-DEFINE_FREE(pm_runtime_put, struct device *, if (_T) pm_runtime_put(_T))
-
 /**
  * __pm_runtime_put_autosuspend - Drop device usage counter and queue autosuspend if 0.
  * @dev: Target device.




