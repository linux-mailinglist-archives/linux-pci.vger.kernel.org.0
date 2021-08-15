Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055C33EC9D6
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhHOPI5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 11:08:57 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:41808 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhHOPI5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 15 Aug 2021 11:08:57 -0400
Received: by mail-lj1-f176.google.com with SMTP id h9so23338028ljq.8
        for <linux-pci@vger.kernel.org>; Sun, 15 Aug 2021 08:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D5fDOg5hsVZqctxAJ1KqBrrp45rGk2Hwe8BSRjMZN1Y=;
        b=XP9nsdiy37cBjhNGXPqvIdjgPQcjvCZVkYDuQDwnZeoomIx4oT/UA0lMNXEW0RYZ1A
         C8q5J4ej0XVXVMyQbqF+E3ov1ySEOIzZqDngy41uJNTjqiSdp3bo/Iw9llCM9enBOj9i
         ErM9rOpfTc96SSrGk3bp4chCRBE0FZ1eGCgKNOAgRbMhIMb98YaWR6/dFKk31wpAIIvM
         UAtxdQZ4Zy7rUVEKvii0L3ac4nZqCC+WQUa1545PnacglH87cOPXKlt/EBdIn70+e4Ae
         JU9CDEbIPitfXxx0wOW9nzi3ZMTlroTLMQ+Xdj9FkUURwgM8yyllY4CEdRU7+5pNkKOE
         EH9Q==
X-Gm-Message-State: AOAM530S9apuatLBGRHdwu7RMo1QWnsoyVzUbHGJYFxsuFn6HoZx8zwF
        YzscAI462fPJr80difkM5KI=
X-Google-Smtp-Source: ABdhPJwpF0cemkUw4FZX68VO7kjRHFP9AxEZ0Jp0ACe/KDRok7UQqu2zprcNtJlgrcQAIWFJUBNbwQ==
X-Received: by 2002:a2e:7411:: with SMTP id p17mr8986860ljc.104.1629040106245;
        Sun, 15 Aug 2021 08:08:26 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id m5sm641831ljg.55.2021.08.15.08.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 08:08:25 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Bin Lai <robinlai@tencent.com>, Jiang Biao <benbjiang@tencent.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: Allow scheduling to take place in proc_bus_pci_read()
Date:   Sun, 15 Aug 2021 15:08:24 +0000
Message-Id: <20210815150824.96773-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI configuration space reads from the /proc/bus/pci for a particular
device, depending on the underlying hardware, can often take several
milliseconds to complete.

Thus, add a schedule point in proc_bus_pci_read() to reduce the maximum
latency.

A similar change has already been completed in the past for the sysfs
counterpart in the commit 2ce02a864ac1 ("PCI: Add schedule point in
pci_read_config()").

Link: https://lore.kernel.org/r/20200824052025.48362-1-benbjiang@tencent.com
Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/proc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index d32fbfc93ea9..cb18f8a13ab6 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -83,6 +83,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 		buf += 4;
 		pos += 4;
 		cnt -= 4;
+		cond_resched();
 	}
 
 	if (cnt >= 2) {
-- 
2.32.0

