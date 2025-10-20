Return-Path: <linux-pci+bounces-38764-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5DCBF1FA6
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 17:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34F124F55A9
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 15:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9F24169A;
	Mon, 20 Oct 2025 15:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohBwijkW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0915923EAAB;
	Mon, 20 Oct 2025 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972615; cv=none; b=KP0pXUE7e/CJ3Ry+O1Lq5v2DgOhckPTiZjCPV5aYlM7tEt3Nmu8jGBW75CwqFR8vfige9k9n73gwEzEnTTASxJmkvqKRjDFPbyTuz26x3FkY2ImBoQFGNtfa2hVbectAO3isFIx2ab6QG9buQAtK46TCtT+piMgFf1ZoRNAlLj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972615; c=relaxed/simple;
	bh=iUG+fRnnUVsa259c08kxC+gXjuE42e8X9HNnAtoNEl8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R10ncT2JVf0BLJgGuZKg2GSC0U5U8mm0W0Ti1+I+ceqMnzPUJHOnpDM0/n+eMVCcZmQAGqOSG+hYja+I7RxS2YT9wDY01PitiODhoTgzKJq7dgikLo8mamdT05IuPk1WoSpyPrBcKIrgtD5EdTjZEqjGstJ66KerIjtjXaiiy40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohBwijkW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6B5C4CEF9;
	Mon, 20 Oct 2025 15:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760972614;
	bh=iUG+fRnnUVsa259c08kxC+gXjuE42e8X9HNnAtoNEl8=;
	h=From:To:Cc:Subject:Date:From;
	b=ohBwijkWaIjvhjaDuLMjE0LGurcDhRmxVVh1v/Z8SOIQNTqviNh2nzb/78CzMAMMb
	 sPiC0mmyDdGKWhI1soCSAMQPipua1Y7iMuXd2964YXBulXgOvW/OuQm/kZxiCpv3Os
	 Y3/IxmxdbdnqwJX4inad+nmYhQzUJu2w8bnka3oE/6GiFyc6AoWDvVnZo6INoHEbxj
	 6jQaGm+Ok8poL0EfAyiF6PP8uLSsfY6XVX8cr9IxmYG0lghiWkUXQB/MSLJZ5XcAKk
	 dgU0+yDFxitlzua2KpLpXSGEGv2L49iqC+wNX3YNFUXcZaCXZumLbMLH0k5gnQdQ2s
	 I1WMLjIh0RvEg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>, Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v1] PM: runtime: Fix conditional guard definitions
Date: Mon, 20 Oct 2025 17:03:28 +0200
Message-ID: <5943878.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since pm_runtime_get_active() returns 0 on success, all of the
DEFINE_GUARD_COND() macros in pm_runtime.h need the "_RET == 0"
condition at the end of the argument list or they would not work
correctly.

Fixes: 9a0abc39450a ("PM: runtime: Add auto-cleanup macros for "resume and get" operations")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/linux-pm/202510191529.BCyjKlLQ-lkp@intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/pm_runtime.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -629,13 +629,13 @@ DEFINE_GUARD(pm_runtime_active_auto, str
  * device.
  */
 DEFINE_GUARD_COND(pm_runtime_active, _try,
-		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
+		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
 DEFINE_GUARD_COND(pm_runtime_active, _try_enabled,
-		  pm_runtime_resume_and_get(_T))
+		  pm_runtime_resume_and_get(_T), _RET == 0)
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try,
-		  pm_runtime_get_active(_T, RPM_TRANSPARENT))
+		  pm_runtime_get_active(_T, RPM_TRANSPARENT), _RET == 0)
 DEFINE_GUARD_COND(pm_runtime_active_auto, _try_enabled,
-		  pm_runtime_resume_and_get(_T))
+		  pm_runtime_resume_and_get(_T), _RET == 0)
 
 /**
  * pm_runtime_put_sync - Drop device usage counter and run "idle check" if 0.




