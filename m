Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E27E83BA926
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 17:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhGCPPo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Jul 2021 11:15:44 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:46778 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhGCPPn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Jul 2021 11:15:43 -0400
Received: by mail-lf1-f51.google.com with SMTP id p21so2125636lfj.13
        for <linux-pci@vger.kernel.org>; Sat, 03 Jul 2021 08:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4gKaNS+MWVdKg2mBjXfowlkmrYKBzhvJhNdC8LPcZA=;
        b=PWCXLRAhVee6oWTyZhWthmuHqm7eQ5CgqfgD8lkx6ckfDDV5XC9IVM71AziutkpodQ
         1CycHMCkI/u3svCzHs9lFDRSlg8WyI1/fKuzUv3/wUDmDXHdkAR8GPLHDcMHJj7GM92T
         BPwNMkJuWsqnXJTKSsDy7xi02Qc8M1GqcApP65vENA2cDFjyoVUaBVdAw0teqncKgQsW
         ia7acHHNThNHDthL8g+Yva/azEAMfsLS+o5PSUjK+Vm8wNcdGGs/uBIUC+1a/NBgR2bq
         KkRj5FpbuVLOB0DBDL+c0E2oV4JBCePKR3Xpdi2nokrOJu8pTAVA068ixzm9kgn8Mp0L
         ws3w==
X-Gm-Message-State: AOAM532sqaYleT+geCHNi0urjCxCJDbGFPWWGveiywQB4QwIbOLqAxOv
        OJJEL30kkAKFfORSWHym6Vo=
X-Google-Smtp-Source: ABdhPJyIi/j/IQ6MGQKx9+zf59VKtoT16Laht43s1RlBY2AE3P/kLmewgO3VRAt6aBjVkE7enMEsdg==
X-Received: by 2002:a19:dc1c:: with SMTP id t28mr3570189lfg.615.1625325188252;
        Sat, 03 Jul 2021 08:13:08 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p18sm715980ljj.56.2021.07.03.08.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jul 2021 08:13:07 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>,
        Scott Branden <sbranden@broadcom.com>,
        Scott Murray <scott@spiteful.org>,
        Tom Joseph <tjoseph@cadence.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Subject: [PATCH 1/5] PCI: Fix kernel-doc formatting
Date:   Sat,  3 Jul 2021 15:13:02 +0000
Message-Id: <20210703151306.1922450-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting of function pci_dev_set_io_state(), and
resolve build time warnings related to kernel-doc:

  drivers/pci/pci.h:337: warning: Function parameter or member 'dev' not described in 'pci_dev_set_io_state'
  drivers/pci/pci.h:337: warning: Function parameter or member 'new' not described in 'pci_dev_set_io_state'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pci.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 37c913bbc6e1..c1ac65cc4572 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -324,8 +324,8 @@ struct pci_sriov {
 /**
  * pci_dev_set_io_state - Set the new error state if possible.
  *
- * @dev - pci device to set new error_state
- * @new - the state we want dev to be in
+ * @dev: pci device to set new error_state
+ * @new: the state we want dev to be in
  *
  * Must be called with device_lock held.
  *
-- 
2.32.0

