Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0513AD82F
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jun 2021 08:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhFSGmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 02:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhFSGmZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jun 2021 02:42:25 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4C0C061574;
        Fri, 18 Jun 2021 23:40:14 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q192so2870658pfc.7;
        Fri, 18 Jun 2021 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cTrGZor3giFSILahtV27RiFLtW55t+UVcQqePFHTEzI=;
        b=XcNwAOt4Iaca+5I7ng6jQeAUgDZQdzV4x+GsaNGBPWqmAq4s8U5PZ4FfMEEBZWsnbg
         /iO6gOOw4+uCrfX34VEFStsCbq5OOVSZU/ESNU4tiGHnzD6FZawjxIUXwzBkkNqzpgc5
         UGdbvD03/Iw8AXIprWT5hpsLEXL9iVNGb2jW07IN+7MfStS/TW0/j6X+BaodroEsueSd
         e3xddEaEP1QuOJTWLD2u1Zm9jas4qm741gSJBMa7Z1mwQzzqY8GxzNXCQkBruUjqWvk5
         FWmGoaGpOLc9QbblLOdV+JRTA5FspI/0o8WWSnghAPnHFy7HtUChgdBAP7nuQmYErDVx
         r1sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cTrGZor3giFSILahtV27RiFLtW55t+UVcQqePFHTEzI=;
        b=bF1Op6+hzto/PTB0Q6JZEaSnm1wqhBaBjZrxr3nW9qawbpiNKeEBZjr7Kx3E4lFMl8
         b7HDUdCM2K823egVnP0E0wAeMRPvpcxPiaR3T4xQp0Vsh8pASyk+f1HVzOr7uxuvIcIp
         6rHzB883lFsyYy0R6ffOFqs4XdzYGwDyZhnJ+fPefR+tSB0WKoKld5jv1J1lw6qqKhcR
         4GEzi0Vldp1oH9XOtoHmlqWnD7+hxQKFPL0G5jqNCl5N49EXHyYCPsQzhXxV3Mu3uGUV
         a+B16I4+dkvU9CUy5HZl+8IGWcnutje5Qhb2lcANytzIMdB/bFjb6EcXJfuvOWR5+uYK
         unTQ==
X-Gm-Message-State: AOAM533nyzvr/b+Yn86NytNZw/sCk7SVWt9OkSKH7LrHrpKZZNsGKxSM
        D3EcBSOUx0eOJB+2KmMEEGVQXeZ3W+eu+w==
X-Google-Smtp-Source: ABdhPJywWDZq3dgNDKtQB7s+bDUb2ze2dkeB2P4aHX12qoZcnCaeqhQ+Sct5O2yT2zz/apKFljN1qw==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr13898803pgi.82.1624084814388;
        Fri, 18 Jun 2021 23:40:14 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id r19sm9440274pfh.152.2021.06.18.23.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 23:40:13 -0700 (PDT)
From:   Artem Lapkin <email2tema@gmail.com>
X-Google-Original-From: Artem Lapkin <art@khadas.com>
To:     narmstrong@baylibre.com
Cc:     yue.wang@Amlogic.com, khilman@baylibre.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        art@khadas.com, nick@khadas.com, gouwa@khadas.com
Subject: [PATCH 1/4] PCI: move Keystone and Loongson device IDs to pci_ids
Date:   Sat, 19 Jun 2021 14:39:49 +0800
Message-Id: <20210619063952.2008746-2-art@khadas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210619063952.2008746-1-art@khadas.com>
References: <20210619063952.2008746-1-art@khadas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Moved from
* drivers/pci/controller/dwc/pci-keystone.c
* drivers/pci/controller/pci-loongson.c

Signed-off-by: Artem Lapkin <art@khadas.com>
---
 include/linux/pci_ids.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4c3fa5293d76..e19d224bbca8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -151,6 +151,9 @@
 /* Vendors and devices.  Sort key: vendor first, device next. */
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
+#define PCI_DEVICE_ID_LOONGSON_PCIE_PORT_0	0x7a09
+#define PCI_DEVICE_ID_LOONGSON_PCIE_PORT_1	0x7a19
+#define PCI_DEVICE_ID_LOONGSON_PCIE_PORT_2	0x7a29
 
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
@@ -885,6 +888,10 @@
 #define PCI_DEVICE_ID_TI_J721E		0xb00d
 #define PCI_DEVICE_ID_TI_DRA74x		0xb500
 #define PCI_DEVICE_ID_TI_DRA72x		0xb501
+#define PCI_DEVICE_ID_TI_RC_K2HK	0xb008
+#define PCI_DEVICE_ID_TI_RC_K2E		0xb009
+#define PCI_DEVICE_ID_TI_RC_K2L		0xb00a
+#define PCI_DEVICE_ID_TI_RC_K2G		0xb00b
 
 #define PCI_VENDOR_ID_SONY		0x104d
 
-- 
2.25.1

