Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C75D4403B9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 22:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhJ2UGG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 16:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbhJ2UGC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 16:06:02 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B59C061570;
        Fri, 29 Oct 2021 13:03:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id oa4so7921825pjb.2;
        Fri, 29 Oct 2021 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mqyNSe6MvQjNqCrZ6ODvlguuYfZXiuPpJnBJ1oYm5bA=;
        b=Dp8dJxNRzneNfNmUHTWUJrxMcMm6CKcXzdXAxbtTFl0JQmX63q4zhcM8NGb6RmWf6t
         bS2uoaagIgU0oKwHTBNA/5cVxcS/gwX9zt5OrdOCfYCTHnkDF/pRf5cNIqanNkEpQuU6
         5gbzSYIQmFwyjdqwCOO4YTOAlFU6ZSYK6WM7xVSL3/Z17vjHJtEaQXPqXDzhWCRrq5gh
         e0UOlYX4/qsOlXoXfxdWAy6od1/RHinAcjYTSQSSMqqESbLxlrCv+JgPPXOQVmzbSzJt
         bVg3fiUlqffuX5+qGPLkOBEp946sRtketmjGw2gwlJwNBepQDTEM5P3Yl9ReueNd6A71
         JGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mqyNSe6MvQjNqCrZ6ODvlguuYfZXiuPpJnBJ1oYm5bA=;
        b=H2ShPWhcJc+50BT38OqVuY+D/8qYofKsy07x9YyceZs8nk3G4iK2lHbgjLmEu1a04r
         Clxbtwh/m4KdU8ZRvohwj28bQdZtlqj5B/HUMmXQx0UMnRg4+Oz0qBA1IRjg5+FETBde
         HlrPInfFixkHzHJoJdF75GcHAGLgJiYGDYetOjJJw9bCh+vWprtY9AJr6GKLee/MRbXN
         UW/vPzxUCIp153eUWkh9ZhH50v4b4QTw2FDtqnZTdEwCWrTDqbyC3OiwXjBERRK9Clin
         1Kjdpzot4HX2G9D7qrcl0A3YFcX1CVC1EldjhfZP3R6LPgoHqOvFerHEdjA8GNCnjfZZ
         PqZA==
X-Gm-Message-State: AOAM532uTj6ySUWVOJ7cgt+AR76WbFjofjtZmV/r8GEsmump8kiuEFwZ
        1ttp0nww7f2naotkPKfr7gH682KLQR4D9A==
X-Google-Smtp-Source: ABdhPJyu17y3WiVBqzNdl0nuYLkATpneyKPOgCs5w0Krbsr1qhfPFig0+ICxqfvknpxdHO07gb/ycg==
X-Received: by 2002:a17:90b:224e:: with SMTP id hk14mr13837771pjb.224.1635537812766;
        Fri, 29 Oct 2021 13:03:32 -0700 (PDT)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id j16sm8775041pfj.16.2021.10.29.13.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 13:03:32 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
        james.quinlan@broadcom.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 4/9] PCI: separate device_initialize() from pci_device_add()
Date:   Fri, 29 Oct 2021 16:03:12 -0400
Message-Id: <20211029200319.23475-5-jim2101024@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211029200319.23475-1-jim2101024@gmail.com>
References: <20211029200319.23475-1-jim2101024@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Do this so that device_initialize() may be called separately
(to prepare for an imminent commit).  This change does reverse
the invocation of these calls:

	pci_configure_device(dev);
	device_initialize(&dev->dev)
to
	device_initialize(&dev->dev)
	pci_configure_device(dev);

I reviewed this and didn't see any issue but it deserves mentioning.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 drivers/pci/iov.c   | 1 +
 drivers/pci/probe.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index dafdc652fcd0..baf5c1af47de 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -292,6 +292,7 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		BUG_ON(rc);
 	}
 
+	device_initialize(&virtfn->dev);
 	pci_device_add(virtfn, virtfn->bus);
 	rc = pci_iov_sysfs_link(dev, virtfn, id);
 	if (rc)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index f3fc807b4fe8..0f092882b33f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2391,6 +2391,7 @@ static struct pci_dev *pci_scan_device(struct pci_bus *bus, int devfn)
 		kfree(dev);
 		return NULL;
 	}
+	device_initialize(&dev->dev);
 	pci_device_add(dev, bus);
 
 	return dev;
@@ -2491,7 +2492,6 @@ void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
 
 	pci_configure_device(dev);
 
-	device_initialize(&dev->dev);
 	dev->dev.release = pci_release_dev;
 
 	set_dev_node(&dev->dev, pcibus_to_node(bus));
-- 
2.17.1

