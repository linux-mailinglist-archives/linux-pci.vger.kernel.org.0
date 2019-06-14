Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD245D08
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 14:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfFNMkR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 08:40:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44352 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfFNMkR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Jun 2019 08:40:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id t16so1388042pfe.11;
        Fri, 14 Jun 2019 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G6J+XslQx14mgUJu3IkiN0FzUg+9m/GNr8qGP15QXM4=;
        b=nSzXWq2wgDfSBPulagdL8DAcLzRmrLOdE8OSqGLUh/cCWEG3++iLthKmJE9JgDDu0J
         g6PnPHyDY4q1EPdQW2X9uzxa3pPRJ1cOQ1fmM2aAQOyFV0HQsI4WYBYU17eIUeOW/36Y
         KMj/d23F7Z95RMGAVs1TVxOW+bsfxCQPm7DxMpsIGQveqjpZoTZoueZ+mBMA9pxuYLEZ
         /Wvfsyspn1WnCvGsUWh7gn1T+DdlKXPbDnokDp+vpPD9ZTI7sNMCiTspAz3oXxBwFKKx
         OgMQHvcTuF2AoZgLsLOqS77QFmKQ0yZpPHOcNVjbQ5a6LU7o7HAkbsD5iytZBkx/8vr5
         ngGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G6J+XslQx14mgUJu3IkiN0FzUg+9m/GNr8qGP15QXM4=;
        b=U4nq5HKrszTiqmcJW/4G87D3JptiK8laVf3weo0WVzpl6cDeDskbUoJqWFe+myp7k2
         chAVnrZX/bIeEovQPTE5WkYTEgBvUa5BG/1uCHlBoXAftBYOWHJ6I3hKaF2UiiQ4lkxP
         DL5okDpnwugrr5AITKQ17l96nD/HJRgth/eVEzgGFSqCa3m6vn+3okYkRZRxEF5xOFQY
         BGQcyRTvn8LciOTSO0Iwfy0BniQiHmPYUrPEo1AEt0NfG2OuMLeAtF1gUCOt8M8lIlWz
         AnOr8gpCMGa8pdlBtXeWZ1Z8lE3E5ibLbe6sidS7CHUWc41iZb1QJO4aTFK0MT6hIFaA
         ykCA==
X-Gm-Message-State: APjAAAUAM8AqSKLNpFLtXps4XC4650UbYftdfGk5jWAdTFVESRICM3Lo
        vmE6bkgUyCtfLd5QNTI0qDQ=
X-Google-Smtp-Source: APXvYqx9/TmX0TUwRb9YhbZ2LXa7SIjFQEulobTNWMcuiWddW3z+6s9Qvfj2cWsqDvqXx986mqHohQ==
X-Received: by 2002:aa7:84d1:: with SMTP id x17mr75198419pfn.188.1560516016456;
        Fri, 14 Jun 2019 05:40:16 -0700 (PDT)
Received: from xy-data.openstacklocal ([159.138.22.150])
        by smtp.gmail.com with ESMTPSA id a3sm2477908pff.122.2019.06.14.05.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jun 2019 05:40:15 -0700 (PDT)
From:   Young Xiao <92siuyang@gmail.com>
To:     bhelgaas@google.com, tyreld@linux.vnet.ibm.com,
        andy.shevchenko@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] PCI/hotplug: fix potential null pointer deference
Date:   Fri, 14 Jun 2019 20:41:25 +0800
Message-Id: <1560516085-3101-1-git-send-email-92siuyang@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is otherwise a risk of a null pointer dereference.

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/pci/hotplug/cpqphp_ctrl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index b7f4e1f..3c8399f 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -598,10 +598,11 @@ static struct pci_resource *get_io_resource(struct pci_resource **head, u32 size
 			*head = node->next;
 		} else {
 			prevnode = *head;
-			while (prevnode->next != node)
+			while (prevnode && prevnode->next != node)
 				prevnode = prevnode->next;
 
-			prevnode->next = node->next;
+			if (prevnode)
+				prevnode->next = node->next;
 		}
 		node->next = NULL;
 		break;
@@ -788,10 +789,11 @@ static struct pci_resource *get_resource(struct pci_resource **head, u32 size)
 			*head = node->next;
 		} else {
 			prevnode = *head;
-			while (prevnode->next != node)
+			while (prevnode && prevnode->next != node)
 				prevnode = prevnode->next;
 
-			prevnode->next = node->next;
+			if (prevnode)
+				prevnode->next = node->next;
 		}
 		node->next = NULL;
 		break;
-- 
2.7.4

