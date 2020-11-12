Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AB82B0617
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 14:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKLNOp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 08:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLNOp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 08:14:45 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC914C0613D1
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:14:44 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so5238148wml.2
        for <linux-pci@vger.kernel.org>; Thu, 12 Nov 2020 05:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPufWXUvflZOkCQBFv9K24dsHX6XgFEqQ6+V4B+kMZI=;
        b=thqnkAx1WSys1ZQMRFVAq+lQ3bPBJqFhNZSqbqs8AWCstc9x6z1TRCZTEXGSt4tbpD
         WbqmnLnBmhNHew9f2dCN/qA2XPz5ZT3v+m1spBOqELBKraI4JFLTEz6eBGsAmA22YOoq
         xKSMzS27VqpwAFqVAFcBVB6YpuQO11fv0W/2RiRT/iTXEIZcsJ1jg/8mMfPxo5VHPm1i
         LuigQ1O9rgiMzx51F4/MucKz8+TQETcFV17z0BqumOeiiGOo+gwIV+UQE1TwKtvwjaDQ
         jflabNeNPBF2FtOhdtj3MU2q139mLIHfV+7F2wJj8GAXdJ+JQEb6vvUlK7LmOYMxzGHO
         x4gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPufWXUvflZOkCQBFv9K24dsHX6XgFEqQ6+V4B+kMZI=;
        b=mf7cSv0Au5fa55114bzn771qgW62GbFOil5m6I8bSEIn3OBgu6M49PuA4hAAowHjfZ
         7MIlNmoslr35WmcOHRjJFF6Wh63CyyNngGUBGbV2lXhnuW1nsRjVw6i5LkcA5+njIF3y
         27IRyRUKFSQpOjVDm4oTk8C6jWKXxnKYdBrFdwT3QhVFKxc013+8EKHct6UFjsxEtu5a
         sY/qeGiPivnMJL99uL6MtLWgzULCG4LQWn5f+bDVEgz1EjBAcawSzObJ49bpCJjWn15/
         efWef4RFndKAP5fMk8tKC8bjDY1YRMHwPt7Wenaydb3XW8w5f0I1BtRjZ2wkuJl7hWWO
         Ks/g==
X-Gm-Message-State: AOAM530iEaaYGFF1zdHibZZt00azGydfd579Uh5ilfzqDYiXt7Ke0fp3
        vAKSdl48UPuKAh7may1BgVPUEQ==
X-Google-Smtp-Source: ABdhPJy/Z7Q8Bq93Eb3xNGrwCULq9ucQIfuTWP+xhF+9b47D77XF4YLCvNgfwy5sXJbuIMCpQdLiMA==
X-Received: by 2002:a7b:c453:: with SMTP id l19mr9419313wmi.2.1605186883687;
        Thu, 12 Nov 2020 05:14:43 -0800 (PST)
Received: from buildbot.pitowers.org ([2a00:1098:3142:14:ae1f:6bff:fedd:de54])
        by smtp.gmail.com with ESMTPSA id x6sm6908363wmc.48.2020.11.12.05.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 05:14:42 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH] PCI: brcmstb: Restore initial fundamental reset
Date:   Thu, 12 Nov 2020 13:14:01 +0000
Message-Id: <20201112131400.3775119-1-phil@raspberrypi.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")
replaced a single reset function with a pointer to one of two
implementations, but also removed the call asserting the reset
at the start of brcm_pcie_setup. Doing so breaks Raspberry Pis with
VL805 XHCI controllers lacking dedicated SPI EEPROMs, which have been
used for USB booting but then need to be reset so that the kernel
can reconfigure them. The lack of a reset causes the firmware's loading
of the EEPROM image to RAM to fail, breaking USB for the kernel.

Fixes: commit 04356ac30771 ("PCI: brcmstb: Add bcm7278 PERST# support")

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index bea86899bd5d..a90d6f69c5a1 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -869,6 +869,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 
 	/* Reset the bridge */
 	pcie->bridge_sw_init_set(pcie, 1);
+	pcie->perst_set(pcie, 1);
+
 	usleep_range(100, 200);
 
 	/* Take the bridge out of reset */
-- 
2.25.1

