Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9773351CE4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Apr 2021 20:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhDASW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Apr 2021 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbhDASLl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Apr 2021 14:11:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B801C03114D
        for <linux-pci@vger.kernel.org>; Thu,  1 Apr 2021 09:44:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e18so2460592wrt.6
        for <linux-pci@vger.kernel.org>; Thu, 01 Apr 2021 09:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YSnhs+QugQX12bb4GkY/AXYl7X1tCBk+JT0tdjERlBo=;
        b=Wcd3lEvvpTNi2r3myGrKY/G9gxpe497zxepnIBDzVdUXV/f6CXhN8lkS+XuU/awnzT
         CS1WdiHekcKHkBbcZA7WrGO6G/cJAU4kliOSdUFb3MasyMHr3uEn4VPIOmvV8gAC8drP
         rk69xX45ifNRXYL5IKAsLD4Sw5xFo1RHXWO+a3602LE8peUDpYSMJyO28EIZAESjoiXL
         TMAMwtBVlV4xpMXicr+3+1EeDx+3rB8DqgWhrOKFPazE80HmDgCdpwiMDOoSoYOXUg1V
         9d3o6cVvVFjf0s7oP2bqik3zTRY/69RgGNrjT70HCIh70my0rAMJIf+IjpKt1THSBUAF
         TGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YSnhs+QugQX12bb4GkY/AXYl7X1tCBk+JT0tdjERlBo=;
        b=MTrmYWf0EC/SYffAXYwntVZmcjKwNDS/KZzXvHipqDGnc5c+ev8/9NOehL2jfAPOMf
         ZZ/q1U7F0m2bdPUgkqG5SQJLlXa4aa4ZCEe97u3SpbPWep/iEFPYXfCbwb6bEXO8riyW
         nxhVtazhqq2/rQesJaDzNB7iHkyzrZiNwu6E+iDpp9hI0+kC9QghsoSJcTQ8Mz3B9jz1
         iwdVg7hSt+zb06esM/HL18dXqzeCNS5lwaqhy1xRfceVqEdtAfTq+9mSMJ5Naj/kdLGB
         TBzTr4TC2efREqkao9kP8bDLCHKGyl5IoDCHU7EjoOVs6acfAMZiJLXIvxBLigjGiERE
         Ls7A==
X-Gm-Message-State: AOAM530bSnrm1WNeryBPGGW1TePKn0R+JhOwf+Sbl53zFq5agUv5NbuM
        HlV+V5sbhVkDAs1EH9WjC6sbonFU7mS8Zg==
X-Google-Smtp-Source: ABdhPJwaGgPmDPMmXXEY+GmlIa8Z5vaCpSw6GR8dpI4krTiFjJI4LWV4pE8+CCfAJei+hc5CmugbFA==
X-Received: by 2002:a5d:554b:: with SMTP id g11mr10492913wrw.411.1617295468920;
        Thu, 01 Apr 2021 09:44:28 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f1f:bb00:5544:e633:d47e:4b76? (p200300ea8f1fbb005544e633d47e4b76.dip0.t-ipconnect.de. [2003:ea:8f1f:bb00:5544:e633:d47e:4b76])
        by smtp.googlemail.com with ESMTPSA id a13sm10148732wrp.31.2021.04.01.09.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 09:44:28 -0700 (PDT)
Subject: [PATCH 1/3] PCI/VPD: Change pci_vpd_init return type to void
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Message-ID: <663ec440-8375-1459-ddb4-98ea76e75917@gmail.com>
Date:   Thu, 1 Apr 2021 18:37:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <1a0155ce-6c20-b653-d319-58e6505a1a40@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_init_capabilities() is the only caller and doesn't use the return
value. So let's change the return type to void.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pci/pci.h | 2 +-
 drivers/pci/vpd.c | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bbbc55965..ff0f4aeef 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -141,7 +141,7 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
 	       type == PCI_EXP_TYPE_PCIE_BRIDGE;
 }
 
-int pci_vpd_init(struct pci_dev *dev);
+void pci_vpd_init(struct pci_dev *dev);
 void pci_vpd_release(struct pci_dev *dev);
 
 /* PCI Virtual Channel */
diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
index 48f4a9ae8..85889718a 100644
--- a/drivers/pci/vpd.c
+++ b/drivers/pci/vpd.c
@@ -337,18 +337,18 @@ static const struct pci_vpd_ops pci_vpd_f0_ops = {
 	.write = pci_vpd_f0_write,
 };
 
-int pci_vpd_init(struct pci_dev *dev)
+void pci_vpd_init(struct pci_dev *dev)
 {
 	struct pci_vpd *vpd;
 	u8 cap;
 
 	cap = pci_find_capability(dev, PCI_CAP_ID_VPD);
 	if (!cap)
-		return -ENODEV;
+		return;
 
 	vpd = kzalloc(sizeof(*vpd), GFP_ATOMIC);
 	if (!vpd)
-		return -ENOMEM;
+		return;
 
 	vpd->len = PCI_VPD_MAX_SIZE;
 	if (dev->dev_flags & PCI_DEV_FLAGS_VPD_REF_F0)
@@ -360,7 +360,6 @@ int pci_vpd_init(struct pci_dev *dev)
 	vpd->busy = 0;
 	vpd->valid = 0;
 	dev->vpd = vpd;
-	return 0;
 }
 
 void pci_vpd_release(struct pci_dev *dev)
-- 
2.31.1


