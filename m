Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1E8787FD5
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 08:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbjHYG1x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 02:27:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242188AbjHYG1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 02:27:42 -0400
Received: from out-40.mta1.migadu.com (out-40.mta1.migadu.com [95.215.58.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C1E1BDB
        for <linux-pci@vger.kernel.org>; Thu, 24 Aug 2023 23:27:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692944857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8g1PhZtieFXqvl5KlmXpfelaKvpJdAuWlFNqp32lxU=;
        b=azk9oKl/yWYIN5PPkoo3zBSOa5qD4a5Ttwotj7deRwg4VxJLVd1VH9ZPjzSxR8PPOtGk7H
        2eXNsnzhwSuxKFP68ub1/EATKxmpRZkXRApbQsGsMiJuZEaOOoibeOK2+BNWPK3PdLGpfw
        qaDtANXtL8laXrkLljPHNF5ob99FzAU=
From:   Sui Jingfeng <sui.jingfeng@linux.dev>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-pci@vger.kernel.org, alsa-devel@alsa-project.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amdgpu: Use pci_get_base_class() to reduce duplicated code
Date:   Fri, 25 Aug 2023 14:27:13 +0800
Message-Id: <20230825062714.6325-5-sui.jingfeng@linux.dev>
In-Reply-To: <20230825062714.6325-1-sui.jingfeng@linux.dev>
References: <20230825062714.6325-1-sui.jingfeng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sui Jingfeng <suijingfeng@loongson.cn>

Should be no functional change.

Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 ++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 20 +++++---------------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index a5a2b06c6588..4f18af877105 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1389,14 +1389,11 @@ void amdgpu_acpi_detect(void)
 	struct pci_dev *pdev = NULL;
 	int ret;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
-		if (!atif->handle)
-			amdgpu_atif_pci_probe_handle(pdev);
-		if (!atcs->handle)
-			amdgpu_atcs_pci_probe_handle(pdev);
-	}
+	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
+		if ((pdev->class != PCI_CLASS_DISPLAY_VGA << 8) &&
+		    (pdev->class != PCI_CLASS_DISPLAY_OTHER << 8))
+			continue;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
 		if (!atif->handle)
 			amdgpu_atif_pci_probe_handle(pdev);
 		if (!atcs->handle)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 38ccec913f00..5bbb23e102ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -287,7 +287,11 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
+	while ((pdev = pci_get_base_class(PCI_BASE_CLASS_DISPLAY, pdev))) {
+		if ((pdev->class != PCI_CLASS_DISPLAY_VGA << 8) &&
+		    (pdev->class != PCI_CLASS_DISPLAY_OTHER << 8))
+			continue;
+
 		dhandle = ACPI_HANDLE(&pdev->dev);
 		if (!dhandle)
 			continue;
@@ -299,20 +303,6 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 		}
 	}
 
-	if (!found) {
-		while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_OTHER << 8, pdev)) != NULL) {
-			dhandle = ACPI_HANDLE(&pdev->dev);
-			if (!dhandle)
-				continue;
-
-			status = acpi_get_handle(dhandle, "ATRM", &atrm_handle);
-			if (ACPI_SUCCESS(status)) {
-				found = true;
-				break;
-			}
-		}
-	}
-
 	if (!found)
 		return false;
 	pci_dev_put(pdev);
-- 
2.34.1

