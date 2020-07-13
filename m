Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A2E21D6B1
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbgGMNW6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbgGMNW5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:57 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D2CC08C5DB;
        Mon, 13 Jul 2020 06:22:56 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id rk21so17148738ejb.2;
        Mon, 13 Jul 2020 06:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DdekBSMp1R6DMOi8Ubgu/NKkVYPxPUhZ+i21xkvtPe8=;
        b=FTWOqfbply9IuxFuX4WbClT+NDxhwIxjM5Ro3JMMJvWUF/qmT2QqYgn9mPlI4ZQhXi
         v2c89Y7pRNNIkGHanZbWp714th0k6d/h/SqBbsn+TQXTvtHl1WfGUK+WeRAROyk9zne2
         GtYuFQG89vv7dtXuHtwkzzKJDhwHfvwWHwTbjCOUd9cUdw41wUN78Ov22kBOR8YHFYQ5
         wrBmxb1+4kdpnw2QV/j7UQp6iZ+bvCdiStFmNnTvD3pP+jCsVYww9Dxnz3+0lznY6oNv
         4kZM5mNHRH1z1WUnoN3xGqKrYKvdrXbBTYmFSue4FHdg/I3vdUFls2hkGjyHozP9urHc
         yikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DdekBSMp1R6DMOi8Ubgu/NKkVYPxPUhZ+i21xkvtPe8=;
        b=Hb66iLzcPP5/VN/JkQf0oHFgTnJE6iguXdh4t5DZ6iB7KtIY3P8fZB6iWD0QQUqHPT
         r1057jW4kzk70Wetq0VQmMKyFYJF4x2tGcHqyEDbwhqulE2RIfjBpkdlxfYc8rwA1pNT
         qhXIIHLKQe6Z17e+ha4q2YY37pWR14M5F3ADolIu3lFwIFpbjzLVyLR0Yrw6OVa47ewx
         D3QKpbAY83Nm6wBmo/DsB1L96LMAqvglFeajQk55cOUiH9GxxiHkfx/leDVYE4N1v8wj
         KqyJzAEt+4TtL4Yt7sS4mIX/9uaw18MP3zIQK59LlY2eSrPZtGWQ0CIiJO9xHeocsOmO
         0TjQ==
X-Gm-Message-State: AOAM532CrijCQKWeWHNsopkjCFie0C4Vvlhj2wEXZSl7ztulhij3a48l
        uigWF7P1RSJl8HgyhzUbsKU=
X-Google-Smtp-Source: ABdhPJwlZKUK04d4vumCE1XKJSvgTpI1XxdiZZmiZ06iFJo6g09xUAqwOaAm7kBfWxZHFEZ22od4hg==
X-Received: by 2002:a17:906:6606:: with SMTP id b6mr77145046ejp.102.1594646575134;
        Mon, 13 Jul 2020 06:22:55 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:54 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 13/35] cxl: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:25 +0200
Message-Id: <20200713122247.10985-14-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
There scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/misc/cxl/vphb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 1cf320e2a415..1264253cc07b 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -150,7 +150,7 @@ static int cxl_pcie_read_config(struct pci_bus *bus, unsigned int devfn,
 
 out:
 	cxl_afu_configured_put(afu);
-	return rc ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return rc ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -184,7 +184,7 @@ static int cxl_pcie_write_config(struct pci_bus *bus, unsigned int devfn,
 
 out:
 	cxl_afu_configured_put(afu);
-	return rc ? PCIBIOS_SET_FAILED : PCIBIOS_SUCCESSFUL;
+	return rc ? PCIBIOS_SET_FAILED : 0;
 }
 
 static struct pci_ops cxl_pcie_pci_ops =
-- 
2.18.2

