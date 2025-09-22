Return-Path: <linux-pci+bounces-36687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFFB91F2C
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 17:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF442A15DD
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 15:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9CF2E7F3C;
	Mon, 22 Sep 2025 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXM5QUiY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06AA2E7F2A;
	Mon, 22 Sep 2025 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555204; cv=none; b=jN24HuD3x1ZpLadKUvGWCU7Yj2Kr9ZubQDSl8w2o3axqHSZB4XFvY75R+DB6vWqlXUkoM5Ob1dsFfFxhsoJjh/c5auiKfa0WOetk5KEFr3YVqmTBZTDy+E49Nqc/F8hs1bjkBdIXku1YH2w8X4xoKBU66S8YD2FDTlVsOBsYcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555204; c=relaxed/simple;
	bh=OCz7zJBEnf97vpSiBCLClDWqNe8hZTHYV35i690Btlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b7gcxx7O1Cpr1g4uAHikiiSog0QMVuTOP/9/ckQ6Q9q51quafwY3bsrRmnDJCbz3XW5Bz7ZJc+oca2Z9NQ8ngD7irTtPqbNQuOXlVxgEsSDZ/f0S0Q2QVMn9gD93Ho21pTWYLH02aW/4G5OWd/OKwBugMhcL5SDarJETwjTMNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXM5QUiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A54C4CEF0;
	Mon, 22 Sep 2025 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555203;
	bh=OCz7zJBEnf97vpSiBCLClDWqNe8hZTHYV35i690Btlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXM5QUiY7W956Il35348XSH4rBsqGetv6Ms/9LgSMkhV35pfMsCZbpGsXHeu95KNF
	 trmyj21Q3FCj5QjQj9sRJ+WxMeLcSK70gXbZYAKH0nSMsM6ULikfBHPGLPAHSRswIF
	 L+QTUmybm4ghIJpnma64gczJzeFZC4cwnA6TUBhA/CsluSFXmXmcF8rGSEDTK8z3q/
	 XRS7QLiiYlYpdkdav/nuIFpgCutWu8OuktFenRoc5/necEKj7/woBhQOza02i1Ae4y
	 8V/Px42bpzrkD6lcIWOKb+bXD2MLHGBP34XDjPGq3IZGmBoPT1V1LkShHWWbEWbKfk
	 gnf5eG+VN1bQg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 2/3] PCI/sysfs: Use runtime PM class macro for auto-cleanup
Date: Mon, 22 Sep 2025 17:31:53 +0200
Message-ID: <1950293.tdWV9SEqCh@rafael.j.wysocki>
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

From: Takashi Iwai <tiwai@suse.de>

Use the newly introduced class macro to simplify the code.

Also, add the proper error handling for the PM runtime get errors.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de
[ rjw: Adjusted the subject and the name of the class ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: No changes

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




