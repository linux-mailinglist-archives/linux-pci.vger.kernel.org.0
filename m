Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273FC377AEA
	for <lists+linux-pci@lfdr.de>; Mon, 10 May 2021 06:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhEJEPn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 May 2021 00:15:43 -0400
Received: from mail-ej1-f42.google.com ([209.85.218.42]:47003 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhEJEPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 May 2021 00:15:39 -0400
Received: by mail-ej1-f42.google.com with SMTP id u21so22345919ejo.13
        for <linux-pci@vger.kernel.org>; Sun, 09 May 2021 21:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DdJ+gi3kfx5UscQD8MEmkjatX64t7LAuyBsCWTQVyR4=;
        b=iTYSEO7EJIoYU1vNMJBtRuaII0IasayZDDMNIe8R/zpDQUw3kF5WxRZqBg33HqivRQ
         5B8wEAFr1i8CTp3RpBciKiOXRhW21wdURQJkoMlMTw32HRo0TMo9lZv64Qr+SMUpOF8P
         AexrErepAqJvNjD8y8QaVG7mr5tly5rTzp/Uw2PhwAihctqoSfQrNYWpsdQbOIiNvbGL
         tpgep9CLGHywKjCJAqwFPtZfpuKUBEwpJrQ/u2UKmqyjRhaGSTlR79BWTTfcpnHHrOdV
         BB1V1S2ucfcXIg5cx//EA7UaiPXesF1t9IFKZByAo3ES3NBS+G7CS2J9/pr3cTx0ZuJG
         LUaw==
X-Gm-Message-State: AOAM533t7Bp+PKhjN3IchgisgFF8E9VliDhq/D5vSYsfMSlRCPDjL9qJ
        pLtoxvjVvl4+x9TqJcwJlbM=
X-Google-Smtp-Source: ABdhPJzQfHOmwxaUAAA/yt6AGTtGTnJzQboG84wpMWkla3kP1bDDdqnRsuymn/mXmRv8Z4Fc2V9tUw==
X-Received: by 2002:a17:906:e2d6:: with SMTP id gr22mr24241114ejb.356.1620620074968;
        Sun, 09 May 2021 21:14:34 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e4sm8165006ejh.98.2021.05.09.21.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 21:14:34 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/11] PCI: hotplug: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Mon, 10 May 2021 04:14:23 +0000
Message-Id: <20210510041424.233565-10-kw@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510041424.233565-1-kw@linux.com>
References: <20210510041424.233565-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The sysfs_emit() and sysfs_emit_at() functions were introduced to make
it less ambiguous which function is preferred when writing to the output
buffer in a device attribute's "show" callback [1].

Convert the PCI sysfs object "show" functions from sprintf(), snprintf()
and scnprintf() to sysfs_emit() and sysfs_emit_at() accordingly, as the
latter is aware of the PAGE_SIZE buffer and correctly returns the number
of bytes written into the buffer.

No functional change intended.

[1] Documentation/filesystems/sysfs.rst

Related to:
  commit ad025f8e46f3 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index 5ac31f683b85..058d5937d8a9 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -73,7 +73,7 @@ static ssize_t power_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t power_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -130,7 +130,7 @@ static ssize_t attention_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static ssize_t attention_write_file(struct pci_slot *pci_slot, const char *buf,
@@ -175,7 +175,7 @@ static ssize_t latch_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_latch = {
@@ -192,7 +192,7 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 	if (retval)
 		return retval;
 
-	return sprintf(buf, "%d\n", value);
+	return sysfs_emit(buf, "%d\n", value);
 }
 
 static struct pci_slot_attribute hotplug_slot_attr_presence = {
-- 
2.31.1

