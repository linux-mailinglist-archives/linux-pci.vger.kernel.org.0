Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAFBA377A35
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 04:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbhEJCqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 May 2021 22:46:40 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:45827 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhEJCqg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 May 2021 22:46:36 -0400
Received: by mail-ed1-f43.google.com with SMTP id s7so12233248edq.12
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 19:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kbQg4+9brtIpQyB367XuQ54IAM6gOiPLjgHbH6iKbI4=;
        b=mIMkM+d+sxAKAQoMHkWjDdMKvglAmUUSPvWHTOCKx2ORsErYoEYIT2BpEmCaz3NmSF
         yXXkprLb6NR9WZSW24CxN14mqIO/PrvaAcGNdNZ2UkRUGOXjtfOg7kZiNtkgT8Uh45qy
         h2MO39d8gbjlKsmBVDBwveYBc5WzltC3x8eX64X6YTKwXY8ftbb9oVPbgggcmXjixuRS
         cBVUfxImFGjhmAEbt6AObfDKOPKDnQhAm3uAkklkMBSpcwP4PlitQerzWNDQcz8YoomT
         MgOX9d3qP7RGUPl1IzHt4UiwZE+V0QT3pQNfz1YdnKegcb+rxi4DiSQYH3aRazYoH9BB
         kSsw==
X-Gm-Message-State: AOAM530CZHpaO8FM7HWKdVbDhMr/UM2ei6H+WpQoCmB5CY8DIdEYDSel
        5w8ctQ2UiF8ksHylp1Q2G3xuLPt5W+I=
X-Google-Smtp-Source: ABdhPJxUnwdQGG4/VBjRb+GsfCokeEepj6rGrwAeoHyLRgvmnv3bfrDdVEPeeEH3CO8oDBwbIZd9tw==
X-Received: by 2002:a05:6402:683:: with SMTP id f3mr26041287edy.22.1620614731235;
        Sun, 09 May 2021 19:45:31 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j20sm8100733ejc.110.2021.05.09.19.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 19:45:30 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: cpcihp: Move declaration of cpci_debug to the header file
Date:   Mon, 10 May 2021 02:45:29 +0000
Message-Id: <20210510024529.3221347-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
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
 drivers/pci/hotplug/cpci_hotplug.h      | 3 +++
 drivers/pci/hotplug/cpci_hotplug_core.c | 1 -
 drivers/pci/hotplug/cpci_hotplug_pci.c  | 2 --
 3 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index d0559d2faf50..7a78e6340291 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -44,7 +44,6 @@ static DECLARE_RWSEM(list_rwsem);
 static LIST_HEAD(slot_list);
 static int slots;
 static atomic_t extracting;
-int cpci_debug;
 static struct cpci_hp_controller *controller;
 static struct task_struct *cpci_thread;
 static int thread_finished;
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
2.31.1

