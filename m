Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95DE265D68
	for <lists+linux-pci@lfdr.de>; Fri, 11 Sep 2020 12:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgIKKJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Sep 2020 06:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgIKKJl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Sep 2020 06:09:41 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376E6C061573
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 03:09:41 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x123so6946785pfc.7
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2020 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=FcvpBmr8Z+8Tm8UV5OexJQFxmZi0SdfMHn6zncSMmF0=;
        b=UJpd7AM0KqI1M7Gy6GTTClwpeTIL1skcd4nGQdcPNmdLfQIknijAN4+2Sl3gdoueXb
         hldHFtKBXH2XvSXcCzc+LOPGGGNcvJ8ILmrF4Wl8ZmvX+C7kFta+1/NSTuUKXG7Lj9uh
         rUTX7GdolQEWx21aroJ/R53pcnrbDw5nNHPqIWDUlPYhUT6kcGFHltoPkZo2uvT1HDSM
         ZrEoD+6wmTZUgu1hTKNVzAYF6V5yR1jRC5BpnoEOaV04Q3qVM/TUL2T2lIE0aAhmcOIo
         IjkawEEIKI00GxGD6Ed+ZBPy6TV8uVPXV1IOBoppGllmXl/HB43FsZ3hun6wluWswEeO
         TU6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=FcvpBmr8Z+8Tm8UV5OexJQFxmZi0SdfMHn6zncSMmF0=;
        b=XRYSE9WvG888KTsLGplCrQ1qg3oNa25e1mQ4GyKF97Xhc7aMFvnsGgjl9PO7YpiTDU
         WAF4mHfbjpi9FYIULbAZZmPAhQEYMF49UaXWz/0WDY6mO2O6l7c6xBqmIJfvpD6E2ZLY
         dq5LaO7pENdab2kQ8KiCix6cA4/ZPTk4FEKcojl3apHL6qSKNKKH9jF0+plXJ5u54JTO
         1NwVaFh2AL6A4ESeYSfClNoM1AYgvGlcZzothqr08n1tnzcGmuVLa3xcSXjcIOdCmg86
         CIi5+I8XCZRV2eZB4SUEhbUuZFniQSCo+Mh7XkoAgEldMVMy/bm2JUsqe7tEx+P2R99F
         XSwA==
X-Gm-Message-State: AOAM530O5Y4Arja7BywIUOZaJ32uBJ7KiezrX4Mo8w4qV2G8hF4Wxv6h
        DZrQnPq9co07qsCNPQ2dlDk=
X-Google-Smtp-Source: ABdhPJz1AO/W9rmbXnIn5gb12BPr79G6RnJLebpbod+imemPVoqIMdG/yXtb4Z/OLHtpOu0nxUOAQg==
X-Received: by 2002:a63:7b16:: with SMTP id w22mr1110906pgc.17.1599818980801;
        Fri, 11 Sep 2020 03:09:40 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
        by smtp.gmail.com with ESMTPSA id t24sm1883387pfq.37.2020.09.11.03.09.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2020 03:09:40 -0700 (PDT)
From:   Huacai Chen <chenhc@lemote.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        linux-pci@vger.kernel.org, Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 1/2] PCI/portdrv: Remove the .remove() method in pcie_portdriver
Date:   Fri, 11 Sep 2020 18:09:36 +0800
Message-Id: <1599818977-25425-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As Bjorn Helgaas said, portdrv can only be built statically (not as a
module), so the .remove() method in pcie_portdriver is useless. So just
remove it.

BTW, rename pcie_portdrv_remove() to pcie_portdrv_shutdown() since it
is only used by the .shutdown() method now.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 drivers/pci/pcie/portdrv_pci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
index 3a3ce40..4e0af0f 100644
--- a/drivers/pci/pcie/portdrv_pci.c
+++ b/drivers/pci/pcie/portdrv_pci.c
@@ -134,7 +134,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
 	return 0;
 }
 
-static void pcie_portdrv_remove(struct pci_dev *dev)
+static void pcie_portdrv_shutdown(struct pci_dev *dev)
 {
 	if (pci_bridge_d3_possible(dev)) {
 		pm_runtime_forbid(&dev->dev);
@@ -210,8 +210,7 @@ static struct pci_driver pcie_portdriver = {
 	.id_table	= &port_pci_ids[0],
 
 	.probe		= pcie_portdrv_probe,
-	.remove		= pcie_portdrv_remove,
-	.shutdown	= pcie_portdrv_remove,
+	.shutdown	= pcie_portdrv_shutdown,
 
 	.err_handler	= &pcie_portdrv_err_handler,
 
-- 
2.7.0

