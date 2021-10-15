Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89C042F5BC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhJOOnd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240569AbhJOOnJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:43:09 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7928AC061570;
        Fri, 15 Oct 2021 07:41:03 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s1so4709925plg.12;
        Fri, 15 Oct 2021 07:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPWEij9k//B/evooKOYyCZIPd/p9FY3S9h0pgeJmYgg=;
        b=Km2uZRbeyHWl3vxa8aRDCInxBvpIiEO3AmVBHztRFk5ZgfFd9olaTl+rbmu/oydeHZ
         IHppOUEVjxxJAKHEUkTeol51wrxuZ/+gk1GvVDXnURGpLXtpzKXmvLKoe/ud9GKDAyJY
         yMG2uH8n6nvR39i1GvU3pAGyGjYQiRj/kql9GxDZmH+99/bzsytsRFc6JMjh4Hvdnqtn
         I0SjfHPWfnqyMn8ZmPaXDRb1FQmpMIcxcVZj3Pk8ucWVMt6H1NPJS+b/AI2g8ySsYJVb
         f4UYJnd895UJZ/T138mEoKyMJvpDePiztdDGdkWqs4bAT4w1sQVf26mBkq6kWxVDd88M
         J30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPWEij9k//B/evooKOYyCZIPd/p9FY3S9h0pgeJmYgg=;
        b=2LbHODbylrvca+GboksU5Nx8ZkKw6bqYXFH1CFcTarz59Stm34vUA61TTyEe0J61dK
         cwvZpGdvqS4N5q2SuKES878llmy7xf6zep6HZ5SW8jB7WFuG+uopzNn3GYLIKiamaAw4
         y6pjntgkJj0WUwyexiyW5g2d3wECxKYVOzrMWfovr/yf6QIrDih1ntoa0p1w1FPlvGSd
         a8ugox1zwK1wTQUCHw/0AKxyX7ukBE2YHuJ3mL4vxgG15F9fqf/gM1QVS1c2/WS7J5Mq
         Z7iUySzsPrfFFx+CDt535Tv4oYdVmsSjhPvcrhy38rUy8jgAZxNn9nmXqb41f6SOGZva
         T07w==
X-Gm-Message-State: AOAM531VmfELhtkLINJPIGXJG9Bn2wbQAB7EvcFRU8/z8rnTKUIhpncS
        NT81M2Xu9P2C8MAZZBLCDNE=
X-Google-Smtp-Source: ABdhPJyTJ3ugONhH6RB4ceOPoJUQ+a63FyARtrIhRgXhx4d18rG8SOm2ceSMB0F2tFyOUKh6jodFzg==
X-Received: by 2002:a17:902:7c10:b0:13e:e11e:8d1c with SMTP id x16-20020a1709027c1000b0013ee11e8d1cmr11418268pll.55.1634308862978;
        Fri, 15 Oct 2021 07:41:02 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:41:02 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/24] PCI: Remove redundant error fabrication when device read fails
Date:   Fri, 15 Oct 2021 20:08:45 +0530
Message-Id: <0114a4a44ceacfbd6a7859d8613ca5942f5b35d7.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error. There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

The host controller drivers sets the error response values (~0) and
returns an error when faulty hardware read occurs. But the error
response value (~0) is already being set in PCI_OP_READ and
PCI_USER_READ_CONFIG whenever a read by host controller driver fails.

Thus, it's no longer necessary for the host controller drivers to
fabricate any error response.

This helps unify PCI error response checking and make error check
consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 03712866c818..37258af87b0e 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -83,10 +83,8 @@ int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 
 	addr = bus->ops->map_bus(bus, devfn, where);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	if (size == 1)
 		*val = readb(addr);
@@ -125,10 +123,8 @@ int pci_generic_config_read32(struct pci_bus *bus, unsigned int devfn,
 	void __iomem *addr;
 
 	addr = bus->ops->map_bus(bus, devfn, where & ~0x3);
-	if (!addr) {
-		*val = ~0;
+	if (!addr)
 		return PCIBIOS_DEVICE_NOT_FOUND;
-	}
 
 	*val = readl(addr);
 
-- 
2.25.1

