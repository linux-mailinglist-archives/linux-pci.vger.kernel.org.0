Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B72B93B9634
	for <lists+linux-pci@lfdr.de>; Thu,  1 Jul 2021 20:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhGASpk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Jul 2021 14:45:40 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34512 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhGASpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Jul 2021 14:45:40 -0400
Received: by mail-wm1-f43.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5488719wmc.1
        for <linux-pci@vger.kernel.org>; Thu, 01 Jul 2021 11:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1Kv6I7sUlvtyCvL4aFUkRbTmxcHfskGkISZpJ9DTLvQ=;
        b=OM7KvS5hAAo9+RP4ew6Gd7A3VKMKxbdppNCTcqgU/V8jPTgEgXbVQI0e4NvNJLx9xi
         Y9kzWzysWMcIn4dN4D2z9EhY2TLTvAo6C1iv26JT0GVZlHnBoys1lgOAkSKYA3DMIqSj
         ArDrXh9Y9mPB3p+E6W0Iu6rGTuB9RuvX7uA8QcE6vGJXA6QAy6ynFuDsenRySE83e8E2
         qsVpQ5KSbSxBju25f+YwreACtldYpBWUgeJOqhy2/e/HspNRaqPqqu/eWkqoRcpBHb2b
         Oh9d5Z0d0VMiN2FN2XvMU15VSrEBDtW5aBlgpku8JD+MlcnWiLeox8uaodscx78JTLDU
         h4rg==
X-Gm-Message-State: AOAM530PiYLhELE0TqsJpJFSRzUK5B1V7MmIaY4KBUK54iBLE2OT3TBL
        7hzI9elGPcDzMc0R64Av9GFU3BWNHSb7Yuzu
X-Google-Smtp-Source: ABdhPJwGOaYsOYKJUTEEuxBcPB/bY437ICGvjqluOLPN1wfW0wXJvqQftLVD5Wd5uj85HsMXmBR/rw==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr1175160wmh.97.1625164988130;
        Thu, 01 Jul 2021 11:43:08 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j11sm754086wms.6.2021.07.01.11.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 11:43:07 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: cpcihp: Move declaration of cpci_debug to the header file
Date:   Thu,  1 Jul 2021 18:43:06 +0000
Message-Id: <20210701184306.1492003-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

At the moment, the global variable cpci_debug is declared in the
cpci_hotplug_core.c file.  Since this variable has users outside of this
file and uses the extern keyword to change its visibility, move the
variable declaration to the header file.

This resolves the following sparse warning:

  drivers/pci/hotplug/cpci_hotplug_core.c:47:5: warning: symbol 'cpci_debug' was not declared. Should it be static?

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v2:
  Remove hunk that incorrectly removed definition of the cpci_debug
  variable.

 drivers/pci/hotplug/cpci_hotplug.h     | 3 +++
 drivers/pci/hotplug/cpci_hotplug_pci.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index f33ff2bca414..3fdd1b9bd8c3 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -75,6 +75,9 @@ int cpci_hp_unregister_bus(struct pci_bus *bus);
 int cpci_hp_start(void);
 int cpci_hp_stop(void);
 
+/* Global variables */
+extern int cpci_debug;
+
 /*
  * Internal function prototypes, these functions should not be used by
  * board/chassis drivers.
diff --git a/drivers/pci/hotplug/cpci_hotplug_pci.c b/drivers/pci/hotplug/cpci_hotplug_pci.c
index 2c16adb7f4ec..6c48066acb44 100644
--- a/drivers/pci/hotplug/cpci_hotplug_pci.c
+++ b/drivers/pci/hotplug/cpci_hotplug_pci.c
@@ -19,8 +19,6 @@
 
 #define MY_NAME	"cpci_hotplug"
 
-extern int cpci_debug;
-
 #define dbg(format, arg...)					\
 	do {							\
 		if (cpci_debug)					\
-- 
2.32.0

