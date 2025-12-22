Return-Path: <linux-pci+bounces-43542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 677E3CD6F5C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 20:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1545A304A28A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 19:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B15E31A07B;
	Mon, 22 Dec 2025 19:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjwghZUD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E417221D9E;
	Mon, 22 Dec 2025 19:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766431623; cv=none; b=X2+ylRuUhj8fYiAKaxvEY1eIGnCvsdAuQo6iuPGPIGwlu3un9UgEIVx22qSSLagv3p/rV7ivf8B1mRCzXZ51FbW5KF1ZcuWrPYrSwO4nEuxF9ytU3sHVvYrdcnBc1gPtV4UBbkVFJbqjR6TPHC8DZ+xmf48yxCEKamptxNNKSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766431623; c=relaxed/simple;
	bh=f28n5VQXzWE6m53i5LgzLRfxG1VL/g6ACeV4leVxbpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZL5aIMOkf4GFSbhvHk4RRUiKXyYd5xHVRY0cO/KwWvfLwW4KS7sLrc2QY7oHTAs4ljWmxetmI/ax6GMJYJMWiIrVxoHPymb3gBAdlUO/ohzoVMjvNsKIzovuna6mg48iFG4jSf3RDLPQP+USmOwcq+kVOMCuueHj84wxAy2/r3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjwghZUD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43E8C116D0;
	Mon, 22 Dec 2025 19:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766431622;
	bh=f28n5VQXzWE6m53i5LgzLRfxG1VL/g6ACeV4leVxbpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjwghZUDKUx1s6HPOOOHJeRowC8DmWwF0IlzT/pfimTgTAzWmOGmmIqzKwYPVNrCR
	 h09KobY9OGaq+sAfmfPeHjGIl+jP+nKaNd/NRPUiHwH11SafdlzVMHCarEyP7RO8se
	 C68i+QjDEAmb3wixaXkPi6i6wADOrVBcPM2cSUkSwdVooyM8vmc17Oj0HiiZ9RrX7F
	 GKXMTa+jZtXCdRo3oDXR1mvcYIlbFUDGN4SF2ND3M2CUf+QiWg5+sp3scFuaCa1HBW
	 4ePZDN/zxyTHvRumxzNJwjhLuWCrGx6zbgiSldZWUUHvs5yochBwa+EOgVTjTqm8KU
	 SPqomwwTX7rNg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject:
 [PATCH v2.1 5/8] ACPI: bus: Rename label and use ACPI_FREE() in
 acpi_run_osc()
Date: Mon, 22 Dec 2025 20:18:40 +0100
Message-ID: <8682086.NyiUUSuA9g@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2413407.ElGaqSPkdT@rafael.j.wysocki>
References: <2413407.ElGaqSPkdT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Use ACPI_FREE() for freeing an object coming from acpi_eval_osc()
and rename the "out_free" to "out" because it does not involve
kfree() any more.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---

v1 -> v2.1: Add R-by from Jonathan.

---
 drivers/acpi/bus.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -308,19 +308,19 @@ acpi_status acpi_run_osc(acpi_handle han
 
 	if (acpi_osc_error_check(handle, &guid, context->rev, &context->cap, retbuf)) {
 		status = AE_ERROR;
-		goto out_kfree;
+		goto out;
 	}
 
 	context->ret.length = out_obj->buffer.length;
 	context->ret.pointer = kmemdup(retbuf, context->ret.length, GFP_KERNEL);
 	if (!context->ret.pointer) {
 		status =  AE_NO_MEMORY;
-		goto out_kfree;
+		goto out;
 	}
 	status =  AE_OK;
 
-out_kfree:
-	kfree(output.pointer);
+out:
+	ACPI_FREE(out_obj);
 	return status;
 }
 EXPORT_SYMBOL(acpi_run_osc);




