Return-Path: <linux-pci+bounces-36521-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21490B8A9AD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184B77B0061
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 16:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D1D32126C;
	Fri, 19 Sep 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsDBoMQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930CA26D4C0;
	Fri, 19 Sep 2025 16:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300046; cv=none; b=c7dir0k946aQpaHu3xtl+/2u/8jClDTZYEGdKRf0H6BJ2dXq+cpW3dhyQbWte68rP6RFhVwf9urzIxbrJ9iKu94lZX1vyxt0qJSyZq2nQTwfBQgD3jge+DjTpOHyJXn59SbFTG7oL5CSTQsB46+kVArjbPCG37sM0hJsTQ4XP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300046; c=relaxed/simple;
	bh=Lk0O1L7hjdO97zvfG/KEfg0A1cK285Y7YOABL3BKAts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSazh9+73VciOWNvWhl3DRIUAj0lMV6jYa4imQBCkmLH3QIrjIdr2DJzaF3orBq7XAXXs9uimVawhliI8r4sOStriv8u+zXEoUfpo06AYXtU8yiqHp4KoPO1M5MBpzCFdZf4sLXLAkGzy8/jCeyvzM447fnGfHA1qAcgA08zbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsDBoMQ3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FF7C4CEF9;
	Fri, 19 Sep 2025 16:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758300046;
	bh=Lk0O1L7hjdO97zvfG/KEfg0A1cK285Y7YOABL3BKAts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsDBoMQ3eM/YDaPQ27O5WLI7O0LIXCmMiXB8Nki5+P6wVSFI/10BrVTIlsuqamfuJ
	 5yvvEf/UhkZYWumrwChVo1rAP8Zgmmf/fGugR2bZrshIJ+lOsOKD/L8xedW1IQRX92
	 UD4UgqpGYjDOs8yz/as20CodJmDkKI7QMADYPVIWZDKoOl8KSyEbxvm30zDHig4dFP
	 fBX+dbfTUxcMNYpP4ROgtPNbNIZ/mZ7rJvGWfJ4eGyP4wl7NOIJBXZByyXMQaJBAom
	 8ZkuXcp8+rIz/sgnK3vapLn+Cf+c9/nrXbnxBxwOJKnaZsEEpkGP0SrrCGBnRXlPh8
	 ZaQVhVxfId1lw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Takashi Iwai <tiwai@suse.de>,
 Zhang Qilong <zhangqilong3@huawei.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject:
 [PATCH v1 2/3] PCI/sysfs: Use PM runtime class macro for auto cleanup in
 reset_method_store()
Date: Fri, 19 Sep 2025 18:38:42 +0200
Message-ID: <2245131.irdbgypaU6@rafael.j.wysocki>
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

From: Takashi Iwai <tiwai@suse.de>

The newly introduced class macro can simplify the code.

Also, add the proper error handling for the PM runtime get.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ rjw: Adjust subject and error handling ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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
+	CLASS(pm_runtime_resume_and_get, pmdev)(dev);
+	if (IS_ERR(pmdev))
+		return -ENXIO;
 
 	if (sysfs_streq(buf, "default")) {
 		pci_init_reset_methods(pdev);




