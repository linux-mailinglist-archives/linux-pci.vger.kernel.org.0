Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711CB3BA536
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jul 2021 23:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhGBVna (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 17:43:30 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38876 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhGBVna (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 17:43:30 -0400
Received: by mail-lj1-f174.google.com with SMTP id x20so15211181ljc.5
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 14:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=APgZ1VYutcJayu7pZPFCLxqguMlRp2IyYgS4CUn0HKU=;
        b=gmWWkte9RmaVhWU+DXP0oelPZWmClxjog7lOmr8HYDXOy23NkO52jlBhIz4yjQ+mEq
         ySh8YZtPNEfa07YW/l8rL1U2AQK1mPeg8COyjiyXXo+9c2V0xKxL8IeBxWflIi+s5VNf
         b9h+87pZsJRQby4vr6e92gFhQVj5spK4MPsnIIPIbWfqRvQOj3Qns3JWsdhhhW086wbW
         4X1r68TmsFtCDYb5xuuDef2h0b1vpSC0wTiN8KFLS7Iq6Krpv7E3feVo5+CNbopH67t0
         9awF9zUp9VmxgLGUyy+AjrAxUfoYiDD16MdJM1rUegqna527ePkQnHjklrRIue/Ogva7
         ceog==
X-Gm-Message-State: AOAM530X772+YYrXdwzFOCS23DVuoeuHLp7SizdX7u+0ZeT95zELCpj3
        wCehLIKh8oLSl3Onv5j4P4k=
X-Google-Smtp-Source: ABdhPJwwjUolKRjpwd4e6giJl9xEJZTd2JHs166X+tcc6SRMlKKghCdvEQJ5V2fJgK/JAn7AHhzpUg==
X-Received: by 2002:a2e:b893:: with SMTP id r19mr1145840ljp.322.1625262057090;
        Fri, 02 Jul 2021 14:40:57 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u15sm378995lft.75.2021.07.02.14.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 14:40:56 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: hotplug: Fix kernel-doc formatting and add missing documentation
Date:   Fri,  2 Jul 2021 21:40:55 +0000
Message-Id: <20210702214055.1663227-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting and add missing documentation for the
parameters "bus" of the get_slot_mapping() function and resolve build
time warnings related to kernel-doc:

  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'bus' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'bus_num' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'dev_num' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'slot' not described in 'get_slot_mapping'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index b8aacb41a83c..efe6031c1e68 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -292,15 +292,17 @@ static int ctrl_slot_cleanup(struct controller *ctrl)
 
 
 /**
- * get_slot_mapping - determine logical slot mapping for PCI device
+ * get_slot_mapping - Determine logical slot mapping for PCI device.
+ * @bus:	Pointer to the PCI bus structure.
+ * @bus_num:	Bus number of the PCI device.
+ * @dev_num:	Device number of the PCI device.
+ * @slot:	Pointer to where slot number will be returned.
  *
- * Won't work for more than one PCI-PCI bridge in a slot.
+ * Will not work for more than one PCI-PCI bridge in a slot.
  *
- * @bus_num - bus number of PCI device
- * @dev_num - device number of PCI device
- * @slot - Pointer to u8 where slot number will	be returned
- *
- * Output:	SUCCESS or FAILURE
+ * Return:
+ * * 0		- Logical slot mapping has been found for this PCI device.
+ * * < 0	- Unable to find entry in the routing table for this PCI device.
  */
 static int
 get_slot_mapping(struct pci_bus *bus, u8 bus_num, u8 dev_num, u8 *slot)
-- 
2.32.0

