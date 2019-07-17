Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A15C66C0EE
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2019 20:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfGQSYK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jul 2019 14:24:10 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46299 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbfGQSYJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jul 2019 14:24:09 -0400
Received: by mail-io1-f65.google.com with SMTP id i10so47213949iol.13;
        Wed, 17 Jul 2019 11:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uf/4ZxPFIqOD9RapY4uAy1qNJPgc//Sy2DxkMi0wzxE=;
        b=krxIjMge1Y/jwdgZJHPkKyCSOJdzOmEuGKBdQQQYSbNN8g639+uD17I60myNgM1NkW
         uNRY8Fi3Z5Qm8QM6XSj8EVum+XYgVEQOU9fETb7V785PjvfjkkZrbvQsSxXnsH7Djjws
         zXa++cJNY6JAPFMPvNn0irdUscSgPInop2C48o+NJh6+Wr24Nd1xGVxhxUjNqbXJNYuo
         xovtXmnd+dgXPCFK4Pk9AK47Y6oDsOXeWph2KqSqsvs+SNBv2KD+pIJbMBUuKgRGlBlO
         tEUujRP120KzOKDdXf5I6MvcvTgfXxToWlr+RKxNNCBOjzEy0ekyQ6XRtshw/ffORFYV
         cJbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uf/4ZxPFIqOD9RapY4uAy1qNJPgc//Sy2DxkMi0wzxE=;
        b=s67WJiy19AQyn0DgDyAtqw2B3xVBwRCgtbGQEfp3ocJhUlihNjUSqtLM6EOOawpSrj
         teEg5gNfBZfqnq8wU8Lcfde9RtNNSTUCdenIfJ/D9m5FsRCBfMSfTiarpDNAGBqNAuXq
         cQhBRD+iosCUT4b/tE0KeUPXQh5Dy1vPx3tCCuYgeEYCNz6adjEHu04vO8EEZ7WgPGjA
         t8D4Hfnti0j+RFhPLrbqCl22PcXoXaL6Z8gfNTFQSSOBz/VJz9hK5ksOfqqk4MtON+eo
         Vu+9IWcjcXl/SISSFFx0aeWwmIbNh3jpaoTAyb5KeqaptqMIQ8yIBCFC58NIPb3B+LEk
         sVjg==
X-Gm-Message-State: APjAAAW8fbYFUf/EAybni+hX+2/qcfcLbxn3fBd/O1uSm3kii83ENSww
        z1Z6D/GwRcGuJLgv1kVlYwCoatgCgCBKnQ==
X-Google-Smtp-Source: APXvYqznMC3iKe3XsH51sI6EGKGJn4bbRxG7UsYc3XMuM2UVX6IXm13XQJAw2HEQSq9ouiNQzj7yHw==
X-Received: by 2002:a02:2245:: with SMTP id o66mr12383247jao.53.1563387848779;
        Wed, 17 Jul 2019 11:24:08 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id p10sm41190115iob.54.2019.07.17.11.24.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 11:24:07 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skunberg.kelsey@gmail.com
Subject: [PATCH] PCI: Remove unused EXPORT_SYMBOL()s from drivers/pci/bus.c
Date:   Wed, 17 Jul 2019 12:23:53 -0600
Message-Id: <20190717182353.45557-1-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_bus_get() and pci_bus_put() are not used by a loadable kernel module
and do not need to be exported. Remove lines exporting pci_bus_get() and
pci_bus_put().

Functions were exported in commit fe830ef62ac6 ("PCI: Introduce
pci_bus_{get|put}() to manage PCI bus reference count"). No found history
of functions being used by a loadable kernel module.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/pci/bus.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 495059d923f7..8e40b3e6da77 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -417,11 +417,9 @@ struct pci_bus *pci_bus_get(struct pci_bus *bus)
 		get_device(&bus->dev);
 	return bus;
 }
-EXPORT_SYMBOL(pci_bus_get);
 
 void pci_bus_put(struct pci_bus *bus)
 {
 	if (bus)
 		put_device(&bus->dev);
 }
-EXPORT_SYMBOL(pci_bus_put);
-- 
2.20.1

