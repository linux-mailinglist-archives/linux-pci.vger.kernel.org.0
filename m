Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9891DD693
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgEUTFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 15:05:01 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:43206 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgEUTFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 15:05:00 -0400
Received: by mail-ej1-f66.google.com with SMTP id a2so10121522ejb.10
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 12:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAj9plI/0kJlMU0mdpTKLdz6l6st1GqxTJaMw8KC8gE=;
        b=t7jLOatHYS78yorO6vHW+ff/o2NgFVPyHpIyED//dkti9IFnJwEennUjhrZDbzQnKO
         u3VekFAQWToqtaq5zhlAaCl6gEI5voN+TkFkLytaF3hhM9Rn9EXcZ7sFsp+1VG/qh+E+
         SlpYQEDCus4Gi+/1mTDqrZEc8g3rtOwkJMGFC7qrCdirWBBPryTunMD7NY78+Gn5RxWc
         lE8BYJOWEG2I424cCLq4Bw/Ca13gj262GmmuJ1Dr1OrC70XAfVLXEriW6jRa41SHNvYY
         kmEHY/XvxGCVym3U1Vhht2swxvCL1mT2UNOeOO+zM6heC2qVLE9GRVoCgocL9WIVErsJ
         c2Kg==
X-Gm-Message-State: AOAM532/A3dO5hydiiIdxu7eWoXSQ3WKMecJWFYhh+8XaITA7FOJseMn
        AD2ZP3rOQb9ixeEQ46vECDI=
X-Google-Smtp-Source: ABdhPJyJwaBbIA5WcCFqs1phf8NZgcrqaNMgAIB6PzGedvOJ9VmNnAmSeLC5kFVa3Ul98KZkn+qfrg==
X-Received: by 2002:a17:906:d98:: with SMTP id m24mr4712748eji.553.1590087898729;
        Thu, 21 May 2020 12:04:58 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id p89sm5128073edd.79.2020.05.21.12.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:04:57 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH] PCI: shpchp: Remove surplus variable and ineffectual error check
Date:   Thu, 21 May 2020 19:04:57 +0000
Message-Id: <20200521190457.1066600-1-kw@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Function remove_board() calls shpchp_unconfigure_device() and checks its
return code for a possible error which is unnecessary as
shpchp_unconfigure_device() always returns 0.

Also, remove surplus variable that has not been used for anything.  This
will also address the following Coccinelle warning:

  drivers/pci/hotplug/shpchp_pci.c:66:5-7: Unneeded variable: "rc".
  Return "0" on line 86

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pci/hotplug/shpchp.h      | 2 +-
 drivers/pci/hotplug/shpchp_ctrl.c | 3 +--
 drivers/pci/hotplug/shpchp_pci.c  | 5 +----
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp.h b/drivers/pci/hotplug/shpchp.h
index f7f13ee5d06e..6e85885b554c 100644
--- a/drivers/pci/hotplug/shpchp.h
+++ b/drivers/pci/hotplug/shpchp.h
@@ -164,7 +164,7 @@ u8 shpchp_handle_switch_change(u8 hp_slot, struct controller *ctrl);
 u8 shpchp_handle_presence_change(u8 hp_slot, struct controller *ctrl);
 u8 shpchp_handle_power_fault(u8 hp_slot, struct controller *ctrl);
 int shpchp_configure_device(struct slot *p_slot);
-int shpchp_unconfigure_device(struct slot *p_slot);
+void shpchp_unconfigure_device(struct slot *p_slot);
 void cleanup_slots(struct controller *ctrl);
 void shpchp_queue_pushbutton_work(struct work_struct *work);
 int shpc_init(struct controller *ctrl, struct pci_dev *pdev);
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index 078003dcde5b..afdc52d1cae7 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -341,8 +341,7 @@ static int remove_board(struct slot *p_slot)
 	u8 hp_slot;
 	int rc;
 
-	if (shpchp_unconfigure_device(p_slot))
-		return(1);
+	shpchp_unconfigure_device(p_slot);
 
 	hp_slot = p_slot->device - ctrl->slot_device_offset;
 	p_slot = shpchp_find_slot(ctrl, hp_slot + ctrl->slot_device_offset);
diff --git a/drivers/pci/hotplug/shpchp_pci.c b/drivers/pci/hotplug/shpchp_pci.c
index 115701301487..36db0c3c4ea6 100644
--- a/drivers/pci/hotplug/shpchp_pci.c
+++ b/drivers/pci/hotplug/shpchp_pci.c
@@ -61,9 +61,8 @@ int shpchp_configure_device(struct slot *p_slot)
 	return ret;
 }
 
-int shpchp_unconfigure_device(struct slot *p_slot)
+void shpchp_unconfigure_device(struct slot *p_slot)
 {
-	int rc = 0;
 	struct pci_bus *parent = p_slot->ctrl->pci_dev->subordinate;
 	struct pci_dev *dev, *temp;
 	struct controller *ctrl = p_slot->ctrl;
@@ -83,6 +82,4 @@ int shpchp_unconfigure_device(struct slot *p_slot)
 	}
 
 	pci_unlock_rescan_remove();
-	return rc;
 }
-
-- 
2.26.2

