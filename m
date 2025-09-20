Return-Path: <linux-pci+bounces-36585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27FABB8C637
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 12:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1777B6143
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 10:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B02F60A6;
	Sat, 20 Sep 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idmVQB3M"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CA534BA2A;
	Sat, 20 Sep 2025 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758365824; cv=none; b=hbnQxF/V8IEj+X1pQDlHARwC0lAlM5D+Gtq/ofA1r7chGoOrL3naV+kTMIFxe2Rj1kSVMUrBgJBuI+dnVzlkLXViSxPSiZB8Y4FJLlrV+pFe5da6usIBIRwuiXNSYEwOiWweQQlOlUu5zVT/GCVFr3C89pIgKxOFts0lSIxW6TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758365824; c=relaxed/simple;
	bh=JM2q+LNN65xB7Ao0ojLqZbNBOTDZ2QBiB70Sw/LhkYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToohPHnu8zhR+BOLWVNBbcuf7p7FKyRQLTzt66IFg5znBSKTwvg/DkiHtL+46ms5+W325Mu9Q01+ZXWRRXyuyiYfLwLirE0jpKATUe9uSaFIo7GLstJf3K94yq0opx+LDpl2E6oWIYRSrlWxUHxVadrS6Tu/+1l4QWSb74M4nIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idmVQB3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D6DC4CEF9;
	Sat, 20 Sep 2025 10:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758365822;
	bh=JM2q+LNN65xB7Ao0ojLqZbNBOTDZ2QBiB70Sw/LhkYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=idmVQB3MHxGnwVSImUhMjgDuVbRYWJ+Zr/b9DvtPzW2fMHo+hb1XmIEEptv95iieu
	 fpjxwgF83UiWbGO2d/9x+dbZkwOQx/X/FI0GYNJEPyE7eQbWAyEyZVpa+gQxPrWlFk
	 Il98p98RT2BTrKRbSC6GoxSNNuGNWjmZbWG8LfGaZkV0hCl9Z2oZ9SBH3caCsPxG+H
	 m33YpS/Uqlss0eUTN/R4NrfkNu0bLnlpCkD/rOOp5dtTD9JaCbgI1/G3V9FXrzjx81
	 ImUxRHaRzc9cShSXlgSIhn8M31YQgPzIcX8f1VrLlmQDkSw5but8FrhYgwZzsBZ/TH
	 otKoqC87w1s4g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/3] PCI/sysfs: Use runtime PM class macro for auto-cleanup
Date: Sat, 20 Sep 2025 12:56:08 +0200
Message-ID: <10735039.nUPlyArG6x@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Takashi Iwai <tiwai@suse.de>

Use the newly introduced class macro to simplify the code.

Also, add the proper error handling for the PM runtime get errors.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de
[ rjw: Adjusted the subject and the name of the class ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Adjust the name of the class to handle the disabled runtime PM case
     transparently (like the original code).

---
 drivers/pci/pci-sysfs.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct
 		return count;
 	}
 
-	pm_runtime_get_sync(dev);
-	struct device *pmdev __free(pm_runtime_put) = dev;
+	CLASS(pm_runtime_get_active, pmdev)(dev);
+	if (IS_ERR(pmdev))
+		return -ENXIO;
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);




