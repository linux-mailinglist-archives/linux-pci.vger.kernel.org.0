Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2030C42F5B8
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 16:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbhJOOmm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhJOOml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 10:42:41 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAA6C061570;
        Fri, 15 Oct 2021 07:40:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id e65so6405751pgc.5;
        Fri, 15 Oct 2021 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hguH+4h8WJZAQBX6bFk6OLcEE3ensFHbc7yyj62NPUU=;
        b=UZsKQuYMXgZnOPY6/63KM7U41g68pmtEWjrEE4tpt357waPxLydOwrnypYJEaKRGuo
         M42jcPkZuQiKIGmjB3Bf57gNRwXQk5LGwM0w+2D1NHkw8JI1nbuFaA96hEFQJY+3uWAo
         gjALKCDUKhbRgSXCU3D62aG1T45oBE5PivX0G34X+7990sxrTAKReDPSF+IvihVNttLD
         WHKI6bGHVpJ959fLrnmN34o94DpH1P4qnoaYYmhXjlfIRWqiSfJAZ0Z7ERFQHfvDIjE8
         X56PjFySwjbeYg0KiA3GA2t+wI5v71ZRvNbKTE8v/VIofU3hsNTIUkDMvv7yDdBhTjUB
         TCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hguH+4h8WJZAQBX6bFk6OLcEE3ensFHbc7yyj62NPUU=;
        b=vMjvBGUcvWbJk9PS5WkMZbjFnaSh/KDvAU7vXWj1+2Wrryoe3VqagZ7aiEIO7lABcf
         WRj2Dyz5XF7sbYi3QM7vvRPXxzbz72jaUNWBtnciO/P/QDLW3ixYojgppr2R9gWiUwFT
         F0Pzf/+PccEh/LSNeaqSU079neukNmHu2ysPLJX2VtvfIlrRMnfpfZSi8ZEmeRI5agkR
         XoazSdW5a5amhqCm4AwRM8d2BXSthr02Z1h53NQlO6IC2mUTP9UQoB/RtT7H1uJqTSsq
         NHuhowTcn3vv8GiS8DdyZbRpcABUGb/q3nIWlsDeSsQhpus42O4IPkHRi+k5YiIAPvCv
         fqfg==
X-Gm-Message-State: AOAM532OZTVgzmGYTj3imMx8JR5sEuLeVCo6yDJ2YYDgGEKHZ47JDR6B
        IkpblPYFLQVHhKzieo+lT+z7hQDo04EfPPuP
X-Google-Smtp-Source: ABdhPJwCXWgoqc04OqC3Fg9GRl74v/rvPzegKA4beG0/OZmUoAxuGOVBOx/Kgl4WgCs0NKvY8Oqaig==
X-Received: by 2002:a63:cd09:: with SMTP id i9mr9644131pgg.129.1634308834766;
        Fri, 15 Oct 2021 07:40:34 -0700 (PDT)
Received: from localhost.localdomain ([2406:7400:63:4806:9a51:7f4b:9b5c:337a])
        by smtp.gmail.com with ESMTPSA id f18sm5293491pfa.60.2021.10.15.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 07:40:34 -0700 (PDT)
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     bhelgaas@google.com
Cc:     Naveen Naidu <naveennaidu479@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/24] PCI: Unify PCI error response checking
Date:   Fri, 15 Oct 2021 20:08:44 +0530
Message-Id: <da939a6cdb2dea96d16392ae152e1232212877d1.1634306198.git.naveennaidu479@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1634306198.git.naveennaidu479@gmail.com>
References: <cover.1634306198.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

An MMIO read from a PCI device that doesn't exist or doesn't respond
causes a PCI error.  There's no real data to return to satisfy the
CPU read, so most hardware fabricates ~0 data.

Use SET_PCI_ERROR_RESPONSE() to set the error response and
RESPONSE_IS_PCI_ERROR() to check the error response during hardware
read.

These definitions make error checks consistent and easier to find.

Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
---
 drivers/pci/access.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b3b2006ed1d2..03712866c818 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -417,10 +417,10 @@ int pcie_capability_read_word(struct pci_dev *dev, int pos, u16 *val)
 		ret = pci_read_config_word(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_word() fails, it may
-		 * have been written as 0xFFFF if hardware error happens
-		 * during pci_read_config_word().
+		 * have been written as 0xFFFF (PCI_ERROR_RESPONSE) if hardware error
+		 * happens during pci_read_config_word().
 		 */
-		if (ret)
+		if (RESPONSE_IS_PCI_ERROR(val))
 			*val = 0;
 		return ret;
 	}
@@ -452,10 +452,10 @@ int pcie_capability_read_dword(struct pci_dev *dev, int pos, u32 *val)
 		ret = pci_read_config_dword(dev, pci_pcie_cap(dev) + pos, val);
 		/*
 		 * Reset *val to 0 if pci_read_config_dword() fails, it may
-		 * have been written as 0xFFFFFFFF if hardware error happens
-		 * during pci_read_config_dword().
+		 * have been written as 0xFFFFFFFF (PCI_ERROR_RESPONSE) if hardware
+		 * error happens during pci_read_config_dword().
 		 */
-		if (ret)
+		if (RESPONSE_IS_PCI_ERROR(val))
 			*val = 0;
 		return ret;
 	}
@@ -529,7 +529,7 @@ EXPORT_SYMBOL(pcie_capability_clear_and_set_dword);
 int pci_read_config_byte(const struct pci_dev *dev, int where, u8 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_byte(dev->bus, dev->devfn, where, val);
@@ -539,7 +539,7 @@ EXPORT_SYMBOL(pci_read_config_byte);
 int pci_read_config_word(const struct pci_dev *dev, int where, u16 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_word(dev->bus, dev->devfn, where, val);
@@ -550,7 +550,7 @@ int pci_read_config_dword(const struct pci_dev *dev, int where,
 					u32 *val)
 {
 	if (pci_dev_is_disconnected(dev)) {
-		*val = ~0;
+		SET_PCI_ERROR_RESPONSE(val);
 		return PCIBIOS_DEVICE_NOT_FOUND;
 	}
 	return pci_bus_read_config_dword(dev->bus, dev->devfn, where, val);
-- 
2.25.1

