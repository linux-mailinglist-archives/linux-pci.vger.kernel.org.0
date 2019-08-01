Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CFA7E513
	for <lists+linux-pci@lfdr.de>; Fri,  2 Aug 2019 00:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfHAWBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Aug 2019 18:01:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726403AbfHAWBd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Aug 2019 18:01:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 60F1930BE987;
        Thu,  1 Aug 2019 22:01:33 +0000 (UTC)
Received: from malachite.bss.redhat.com (dhcp-10-20-1-11.bss.redhat.com [10.20.1.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F1C7F600C6;
        Thu,  1 Aug 2019 22:01:28 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>
Cc:     Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: Use pci_reset_bus() in quirk_reset_lenovo_thinkpad_50_nvgpu()
Date:   Thu,  1 Aug 2019 18:01:17 -0400
Message-Id: <20190801220117.14952-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 01 Aug 2019 22:01:33 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since quirk_nvidia_hda() was added there's now two nvidia device
functions on any laptops with nvidia GPUs: the HDA controller, and the
GPU itself. Unfortunately this has the sideaffect of breaking
quirk_reset_lenovo_thinkpad_50_nvgpu() since pci_reset_function() was
using pci_parent_bus_reset() to reset the GPU's respective PCI bus, and
pci_parent_bus_reset() does not work on busses which have more then a
single device function present.

So, fix this by simply calling pci_reset_bus() instead which properly
resets the GPU bus and all device functions under it, including both the
GPU and the HDA controller.

Fixes: b516ea586d71 ("PCI: Enable NVIDIA HDA controllers")
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Drake <drake@endlessm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Aaron Plattner <aplattner@nvidia.com>
Cc: Peter Wu <peter@lekensteyn.nl>
Cc: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Karol Herbst <kherbst@redhat.com>
Cc: Maik Freudenberg <hhfeuer@gmx.de>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/pci/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 208aacf39329..44c4ae1abd00 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5256,7 +5256,7 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 	 */
 	if (ioread32(map + 0x2240c) & 0x2) {
 		pci_info(pdev, FW_BUG "GPU left initialized by EFI, resetting\n");
-		ret = pci_reset_function(pdev);
+		ret = pci_reset_bus(pdev);
 		if (ret < 0)
 			pci_err(pdev, "Failed to reset GPU: %d\n", ret);
 	}
-- 
2.21.0

