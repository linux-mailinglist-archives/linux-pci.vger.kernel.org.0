Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C243D21D709
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729869AbgGMNWm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 09:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729873AbgGMNWk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jul 2020 09:22:40 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7206C061755;
        Mon, 13 Jul 2020 06:22:39 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so13646400edy.7;
        Mon, 13 Jul 2020 06:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wIKAQlJ5EJGoiOmdek0QEY4ROpHfaSKBPeLwiXvsVhs=;
        b=aynnQr9yYe4ZZ1ZrHtzXBl8SSf7HblZmsshVDBYFj9NrSxrnGirktKY/HZ6DlVUMRo
         zNvyjcCe47FefuyS03sMQ0xLJU58XwtxM5ihWJNrNC2+oGFM0+m4u9grTzP5heNWjczx
         46yKHiCd0qOYmibGFbP82US3V33mP0Qz0BbBs7sHjirydyTG/dP5i0Hb0YjsXuMO4BrB
         FQjDcLEEkoFdmrx7ZqmJHkTM8sy+pfx+sQgIDDFcPfSILhRS0uByhwHVIsHH5nCCoqc+
         N7S6TcWUMbpn/D7sJPLW9GfWUJxg0hVocp07mU4YHB2kVH1+fvOOX+9UChqHzqBvN4sx
         oxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wIKAQlJ5EJGoiOmdek0QEY4ROpHfaSKBPeLwiXvsVhs=;
        b=TMO7W0v4izcH8IU1teIvmLINxxWIHJMa/uS4KmSKTyCt5tIDMFJKNm9itwixb5PZjM
         4hCTXbnRS7XqZl6esxnkr/yEfrEFU5fham745vJ4ln5jMOwE8d3lZDHKMFZboN2RaASE
         ck6xZF9bPCVJ7Dqau7XE/3DU4OaZdE61FpXfqc1ZJMUpvIDa2R9tbIgbiHhAyeKSoq6i
         1XWl/MxmKMNJeqX9m0MjyGKSheyECrwYxITWCwJdFHHpPmAQGwuDE06VXv8ivpOuTSEU
         GKR3futvxf6y0n8HIlo7pWJEFCo6zPfjoecOH7vRVfHgndmzAjFL85IM4+j43/AnPNRm
         rx5Q==
X-Gm-Message-State: AOAM531tMMnmPL7YrxpQWsDxg3kuh+7DW+sJ5+BF0818wvdB0HzWsZkX
        V9sveeXEek6WEDc8ahBPzludaHebV2RsBA==
X-Google-Smtp-Source: ABdhPJwUad8FS77l0N6XR9hbRFDjoFcDuPDZlPtaI+ROx0M/Xa+ASTlCW28qVdgQnqcUOGj6m510DA==
X-Received: by 2002:a05:6402:1ca6:: with SMTP id cz6mr70528395edb.171.1594646558717;
        Mon, 13 Jul 2020 06:22:38 -0700 (PDT)
Received: from net.saheed (54007186.dsl.pool.telekom.hu. [84.0.113.134])
        by smtp.gmail.com with ESMTPSA id n9sm11806540edr.46.2020.07.13.06.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 06:22:38 -0700 (PDT)
From:   "Saheed O. Bolarinwa" <refactormyself@gmail.com>
To:     helgaas@kernel.org, Michael Buesch <m@bues.ch>
Cc:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        bjorn@helgaas.com, skhan@linuxfoundation.org,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [RFC PATCH 02/35] ssb: Change PCIBIOS_SUCCESSFUL to 0
Date:   Mon, 13 Jul 2020 14:22:14 +0200
Message-Id: <20200713122247.10985-3-refactormyself@gmail.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200713122247.10985-1-refactormyself@gmail.com>
References: <20200713122247.10985-1-refactormyself@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In reference to the PCI spec (Chapter 2), PCIBIOS* is an x86 concept.
Their scope should be limited within arch/x86.

Change all PCIBIOS_SUCCESSFUL to 0

Signed-off-by: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
---
 drivers/ssb/driver_gige.c    | 4 ++--
 drivers/ssb/driver_pcicore.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/ssb/driver_gige.c b/drivers/ssb/driver_gige.c
index ebee6b0e3c34..ccb4a35715bf 100644
--- a/drivers/ssb/driver_gige.c
+++ b/drivers/ssb/driver_gige.c
@@ -134,7 +134,7 @@ static int ssb_gige_pci_read_config(struct pci_bus *bus, unsigned int devfn,
 	}
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ssb_gige_pci_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -164,7 +164,7 @@ static int ssb_gige_pci_write_config(struct pci_bus *bus, unsigned int devfn,
 	}
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	return PCIBIOS_SUCCESSFUL;
+	return 0;
 }
 
 static int ssb_gige_probe(struct ssb_device *sdev,
diff --git a/drivers/ssb/driver_pcicore.c b/drivers/ssb/driver_pcicore.c
index c1186415896b..1b67af1097c8 100644
--- a/drivers/ssb/driver_pcicore.c
+++ b/drivers/ssb/driver_pcicore.c
@@ -212,7 +212,7 @@ static int ssb_pcicore_read_config(struct pci_bus *bus, unsigned int devfn,
 				     PCI_FUNC(devfn), reg, val, size);
 	spin_unlock_irqrestore(&cfgspace_lock, flags);
 
-	return err ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return err ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static int ssb_pcicore_write_config(struct pci_bus *bus, unsigned int devfn,
@@ -226,7 +226,7 @@ static int ssb_pcicore_write_config(struct pci_bus *bus, unsigned int devfn,
 				      PCI_FUNC(devfn), reg, &val, size);
 	spin_unlock_irqrestore(&cfgspace_lock, flags);
 
-	return err ? PCIBIOS_DEVICE_NOT_FOUND : PCIBIOS_SUCCESSFUL;
+	return err ? PCIBIOS_DEVICE_NOT_FOUND : 0;
 }
 
 static struct pci_ops ssb_pcicore_pciops = {
-- 
2.18.2

