Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA6A01304FA
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2020 23:51:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgADWvB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jan 2020 17:51:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43959 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADWvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jan 2020 17:51:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id k197so25047725pga.10;
        Sat, 04 Jan 2020 14:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OE4dINcLHrSZaKwM4wxH/QREyrfccWfxl0wYxy61JFY=;
        b=Ndc5TkBN1UjJRVhbW0m7NpxXI79agSfKN1Z48xGxIiXomzViL66arVZChk6PmGnZl3
         lPqwSYhAM86YnDDxUrAcxEkoNfVg/GF20XS4uZGaSkXLk0IoOSpiYD3PZiESFNHoRhNX
         L3TwR9Hdw/m8s0w4Vl7axGloX6n3MzDMdMQwdIFCXJ9zApyjnngD1xyEYRxhP98SbJFx
         gmn8Nn6QjHG2Fu+fEPe0mbY0hbJw/4jcHbIrKRZ02z7KZRg6mvvI5eA9fb6tsgqfQ1TU
         Lx8mAXB45v6lJ7sHil+cO4XffTVxdzXLXd4ImouHewOKEYzxh6vW9H1gp7dEovrCkV+3
         NoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OE4dINcLHrSZaKwM4wxH/QREyrfccWfxl0wYxy61JFY=;
        b=jKTdTOKqSnNJhKoAeutsdeRX6FnumbazV+F61TMh4TzFDObDoXGJMXJHdlFba277v0
         aGJLxcV23NgMwhadnuFNSg67qRINAvapM5wKH0CPOLb1CGGTO3/AnbIlQdwTyq+775BF
         +hbmwsNiql9I+hQ2bvC0SIB240tLbGVUx2KDp+RACC8IXtwphHWw1xF/ymqhMD5ZP4aU
         ywSoEszKpYAmYRLGDVFUM538lMaWxRznXVw7J5YWtBPzpFaeU34/PRpQjyest8kgDn2z
         5s2C7gL/SmzSnyJ+W1VXFXBJ5l0ARAD/rhv+ThtaBvm+rkQe4nFqntTgSrT0Q2eg5jOA
         l9RQ==
X-Gm-Message-State: APjAAAXIPjHANpXg5e9+YgN8cuklO4AR5StHebpA1bGPBiyDziFcDZck
        Wd7Vva036bUWWrlgN7lgqR4=
X-Google-Smtp-Source: APXvYqzbRZko0Zmb94PJaOYgFN2EXQ0ohjNld5M+dUs9T6kS2u0dhUCfs0xNuFbqBuGMa/a9uB1LmQ==
X-Received: by 2002:aa7:864a:: with SMTP id a10mr56223713pfo.233.1578178260820;
        Sat, 04 Jan 2020 14:51:00 -0800 (PST)
Received: from deepa-ubuntu.lan (c-98-234-52-230.hsd1.ca.comcast.net. [98.234.52.230])
        by smtp.gmail.com with ESMTPSA id p16sm66905688pgi.50.2020.01.04.14.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 14:51:00 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, alex.williamson@redhat.com,
        logang@deltatee.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Warn if BME cannot be turned off during kexec
Date:   Sat,  4 Jan 2020 14:50:52 -0800
Message-Id: <20200104225052.27275-1-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BME not being off is a security risk, so for whatever
reason if we cannot disable it, print a warning.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 drivers/pci/pci-driver.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 0454ca0e4e3f..6c866a81f46c 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -491,8 +491,12 @@ static void pci_device_shutdown(struct device *dev)
 	 * If it is not a kexec reboot, firmware will hit the PCI
 	 * devices with big hammer and stop their DMA any way.
 	 */
-	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
-		pci_clear_master(pci_dev);
+	if (kexec_in_progress) {
+		if (likely(pci_dev->current_state <= PCI_D3hot))
+			pci_clear_master(pci_dev);
+		else
+			dev_warn(dev, "Unable to turn off BME during kexec");
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.17.1

