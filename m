Return-Path: <linux-pci+bounces-37109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE0BA49FC
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5552A18A1
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DA52DF6F4;
	Fri, 26 Sep 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Emf+L8kU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC81283CB5;
	Fri, 26 Sep 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904069; cv=none; b=VZP2zD++mfcTqHbj7ESELMebRizRddiyomN/cDokHKUPO0JnsZFDaygn9qUX8xoktC/CopMklAHAm4aNNcjQ5JBuvRAYxs2LL1ZXaJBXnis2JgY67LMVyJB22SlTTFrL5TsohxoxowQy24fCFMSYepX1c9QtJJ3KC+JDxnI8rKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904069; c=relaxed/simple;
	bh=7S79uZdrDyC8TorrZT9eUpU4HISQIufbMjy+cWyAHDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMesIHx2ftktU5eAC6PdxZfKTc8iAs/ghzRj/7KmlyQt0+22mBGNeypwRyEsQolMNoncYL+wTBF40AcwiCaLNfQyw6NGdonmAmrzzq49VLFWlwIlp3JJT13uX9LIcYN+RrylsQiZZFZfjZp9nYQzgaHNKnmhE4p9fCfQ8f34WQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Emf+L8kU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134D9C113CF;
	Fri, 26 Sep 2025 16:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904069;
	bh=7S79uZdrDyC8TorrZT9eUpU4HISQIufbMjy+cWyAHDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Emf+L8kUMl1EdmvzikUoXBjkSR3BP2Lv/77S7wBnDuyiuADCC35rWDW0KCEJo4fVZ
	 caBX13UvsviDoXC8gUtey8E8kecGHi5Rk11IXS51dfjQWY1/3A7EBBrXEu2mLjsffx
	 EHtNamrne0lNOZy1AiB6iMytC9g+GtpW7iQiURJvjEb5fmkB6x4x8IURSxnxsX1jwy
	 AgR8X6ioabLYucKLd5lWoJlVhyW67WUBgW3zGirGNg6fs9EJPqUAzEeaDHW60jjZYs
	 TbPVdatLhJkvCi1NVjjR6eoInqOEd/rr8MaaFTG7nNczmykS37otIv4DNqGM6lyfda
	 ZJ2M8JupRN+3w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v4 2/3] PCI/sysfs: Use runtime PM guard macro for auto-cleanup
Date: Fri, 26 Sep 2025 18:24:05 +0200
Message-ID: <2323750.iZASKD2KPV@rafael.j.wysocki>
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

Use the newly introduced pm_runtime_active_try guard to simplify
the code and add the proper error handling for PM runtime resume
errors.

Based on an earlier patch from Takashi Iwai <tiwai@suse.de> [1].

Link: https://patch.msgid.link/20250919163147.4743-3-tiwai@suse.de [1]
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v3 -> v4:
   * Use ACQUIRE()/ACQUIRE_ERR() (Jonathan)
   * Adjust subject and changelog
   * Take patch ownership (it's all different now)
   * Pick up Bjorn's ACK from v3 (Bjorn, please let me know if that's not OK)

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
+	ACQUIRE(pm_runtime_active_try, pm)(dev);
+	if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
+		return -ENXIO;
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);




