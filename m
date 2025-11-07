Return-Path: <linux-pci+bounces-40595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA99EC414EC
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 19:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690684E9317
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 18:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78163396F3;
	Fri,  7 Nov 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4XdfS+7"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8690D336ECC;
	Fri,  7 Nov 2025 18:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762540938; cv=none; b=UN8I9Q52ZH75838ORHwgsGG/0c6Hmc6AxShgh3fVEu8dDon3CM/a8Hf3Nu/Y1Bwxs1rT3CPrAleInW3u3Sy5O8MV1SyUfHMguSXp+EoKSZpFf8/Y/Lfp28GqaBS6biQFNO8fJh0I0VwSpk2DyGzT3PuFKbVREEJv2kVQ53GWsiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762540938; c=relaxed/simple;
	bh=en6upkwT++UxL455QIHKqM8WSfxmUBiJJb8kZK2H/sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OIsH/vXx1sGxn59WDewI+A5sB8ajq+PJ/FpZsSBn5NkUPCtmPNERfiHm8HdBF8xmctzEvOB2ffFkSA44vFeL0o+IVQH3GXsSzZOliM3LXDB4jrAwH2b+dewQ8B5BRFug+QxiIVfzbUTRuOJ0rCpmhZxv1kXnHihKmcSgCePYrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4XdfS+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D701C116B1;
	Fri,  7 Nov 2025 18:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762540938;
	bh=en6upkwT++UxL455QIHKqM8WSfxmUBiJJb8kZK2H/sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B4XdfS+7Bva/zXVfkWz7hYLSD4/ZM9fwkrbEyIfTx/HcQQ2ciaXjPUvddn1OkXjfr
	 iWv1auRzv/DiEYz7vMysdxqKiizuUg7uRe2tKBjRnno+EBFTV/R/SqKD/5zBwr/SbJ
	 hrACvpUJIhluBEuHUMS7429sDK//FrmlFkWCR7z0tqYs3ZL8NOFvcCdlDHGavSqX+5
	 1Cvrq54wudwlkhyOT6FY1ZafpHGaGhQeIJhQJ4rsX8MaV+KjRlLehBcsoIAk0xk+a7
	 3X7Ap/aulZi8wRbGihT9G+ygJLVQ+ke6IuHKsN9ia5GzTILbKE3rxz5wu6dMcZi47j
	 6ZuCqV4z8Mahg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>
Subject:
 [PATCH v1 2/3] PCI/sysfs: Use PM_RUNTIME_ACQUIRE()/PM_RUNTIME_ACQUIRE_ERR
Date: Fri, 07 Nov 2025 19:40:54 +0100
Message-ID: <2021740.PYKUYFuaPT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <13883374.uLZWGnKmhe@rafael.j.wysocki>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use new PM_RUNTIME_ACQUIRE() and PM_RUNTIME_ACQUIRE_ERR wrapper macros
to make the code look more straightforward.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/pci/pci-sysfs.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1517,8 +1517,8 @@ static ssize_t reset_method_store(struct
 		return count;
 	}
 
-	ACQUIRE(pm_runtime_active_try, pm)(dev);
-	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+	PM_RUNTIME_ACQUIRE(dev);
+	if (PM_RUNTIME_ACQUIRE_ERR)
 		return -ENXIO;
 
 	if (sysfs_streq(buf, "default")) {




