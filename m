Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2628646731E
	for <lists+linux-pci@lfdr.de>; Fri,  3 Dec 2021 09:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379136AbhLCIMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 03:12:23 -0500
Received: from smtpbguseast3.qq.com ([54.243.244.52]:55342 "EHLO
        smtpbguseast3.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379133AbhLCIMX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 03:12:23 -0500
X-QQ-mid: bizesmtp50t1638518887t4ydjjwp
Received: from localhost.localdomain (unknown [124.126.19.250])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 03 Dec 2021 16:08:05 +0800 (CST)
X-QQ-SSF: 0140000000200050C000B00A0000000
X-QQ-FEAT: HoyAXBWgsknQr7AMlTD/ZJdcFjHnvRIYmLXIcckAZZ9zNNgfv0HwvZc0mCw32
        IIZ4Kw+X20S2laKHXgCovAKOk7TrVF1+zvJ8wxQE8wdcVKnRKREkcDL3+qkwCM4N//kemwS
        eAbTIww8GP0LR/p1V2mO6c9GY1iHx4ZNX0sy85/OW6M98lxeSjtSeo+PHEvQBWUldm396+M
        VqsmQjXX3xZHTpri9pZ6iivp1YKiJnX1DDtwlq9N3ddBt1G0Li+ZvI0kFAYCyt7F9WchyJo
        YJr2cq6Tg6BsGX2kDD8L7kcifFQTrIfiLRrUObpEEoVev/4tABogklcXuEpRa2InYgTgnU9
        IJaavozYEFz9Fr7EaNccMI0XFfJUw==
X-QQ-GoodBg: 2
From:   Longji Guo <guolongji@uniontech.com>
To:     bhelgaas@google.com, tglx@linutronix.de
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Longji Guo <guolongji@uniontech.com>
Subject: [PATCH] X86: PCI: ACPI: Remove initialization of static variables to false
Date:   Fri,  3 Dec 2021 16:07:58 +0800
Message-Id: <20211203080758.962-1-guolongji@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the initialization of pci_ignore_seg to false which is pointless.

Signed-off-by: Longji Guo <guolongji@uniontech.com>
---
 arch/x86/pci/acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index 948656069cdd..052f1d78a562 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -20,7 +20,7 @@ struct pci_root_info {
 };
 
 static bool pci_use_crs = true;
-static bool pci_ignore_seg = false;
+static bool pci_ignore_seg;
 
 static int __init set_use_crs(const struct dmi_system_id *id)
 {
-- 
2.20.1



