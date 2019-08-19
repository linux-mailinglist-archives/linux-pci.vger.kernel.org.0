Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB849258F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfHSNx2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 09:53:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40137 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfHSNx2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 09:53:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id c3so8828670wrd.7;
        Mon, 19 Aug 2019 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmwaSC7HpE3oDWdiILvMJ+7rFncLXsPhOTLihzduEAM=;
        b=Ot3ZB4C6DgDey7zy/58Y+Rc3b56iXid2BHQpRPmBJ1a2612DTBW9/utMJx6Ecva1DA
         OPkU8vcN7h8i2pwZESBWgl1HKKCZYBIVq1VZnvEQvDGGYoDc44Mimc+F84lNe5QB12+8
         Uh1PMdq4syNzNlx/0zXwMb8G7WhYklDiuhz0s45CVSbPNXm0xZQdERd35ZHuOLRJj3LR
         5Sr4FWux8yOKROjr8krsryRi/h9oWVvkmANZfz/ZkYAcX+5NnPsVI3J9plF/b/t/Xb8R
         v9waUvcXlvLe7DW93dvYJT/KkYWZ2/ubGpVGLh2/aSnbuzxHdpPHYKvV3TLFwB7+QhuL
         vFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=YmwaSC7HpE3oDWdiILvMJ+7rFncLXsPhOTLihzduEAM=;
        b=ZPvn/VxK+oAYG+0w6YmOMMO4mEoFpWhsNbGzfYWFHPnr/7BxFmCaFzjEqYWkVqep6C
         VuEhS7ze000cUxHRxLxcjWiQJoWEVRSGqAI5X39+gbf1yblygmUIvDFA723y+F/3EvEC
         0ZaU1ePDVUkeXcOkIVNfehCjrwEUu7CNH4J2RHIA9yLgULRBR1+UD2yrqmpgvtLXC+qA
         y6h9TFvP4Vqb+xs1jZEPr3H+bgb/kYxSFUOokb45xcycQNELIrgUcJpAxmVIEiRTHHzQ
         4Vt/TobsoQGIvZi93l+3SKtSPwkfIhzalXqgVUCg044VSOEDetDKOFCeWjboaTeGQqxi
         nKLg==
X-Gm-Message-State: APjAAAW9odGFFvQ3PyiY4pJADv/ViPJbPJZHXK6I3s2VfNI3AReGn2Nq
        +6IT7/iuu+9yX9o9dQPUPCE=
X-Google-Smtp-Source: APXvYqzt7UogDLmQpJewHEHjU3K0zbT7DLuq8Rxo7t6kxsGKERRPMo+OBji8oHMrXmiJ/kNpmo5VOA==
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr28346448wrx.241.1566222806055;
        Mon, 19 Aug 2019 06:53:26 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aef41.dynamic.kabel-deutschland.de. [95.90.239.65])
        by smtp.gmail.com with ESMTPSA id z2sm11308806wmi.2.2019.08.19.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 06:53:25 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI/PCI: Remove surplus parentheses from a return statement
Date:   Mon, 19 Aug 2019 15:53:24 +0200
Message-Id: <20190819135324.29504-1-kw@linux.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove unnecessary parentheses enclosing the value in a return
statement in the drivers/acpi/pci_link.c.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/acpi/pci_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
index db11f7771ef1..00a6da2121be 100644
--- a/drivers/acpi/pci_link.c
+++ b/drivers/acpi/pci_link.c
@@ -661,7 +661,7 @@ int acpi_pci_link_allocate_irq(acpi_handle handle, int index, int *triggering,
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 			  "Link %s is referenced\n",
 			  acpi_device_bid(link->device)));
-	return (link->irq.active);
+	return link->irq.active;
 }
 
 /*
@@ -712,7 +712,7 @@ int acpi_pci_link_free_irq(acpi_handle handle)
 		acpi_evaluate_object(link->device->handle, "_DIS", NULL, NULL);
 
 	mutex_unlock(&acpi_link_lock);
-	return (link->irq.active);
+	return link->irq.active;
 }
 
 /* --------------------------------------------------------------------------
-- 
2.22.1

