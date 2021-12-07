Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B035646B972
	for <lists+linux-pci@lfdr.de>; Tue,  7 Dec 2021 11:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbhLGKxB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Dec 2021 05:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhLGKxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Dec 2021 05:53:00 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6024DC061746;
        Tue,  7 Dec 2021 02:49:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t9so28554077wrx.7;
        Tue, 07 Dec 2021 02:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+bN8SexTbCT5j9k/6OymCyhRoZPMwyN555jgSjh4EQ=;
        b=P1lAEmSty9+oVN7ngYjQ4zFH+Wx/uOVSwAHA63Hqcy888EZH8enMV/Tmlvz8hET7OV
         0DJqXbZB2VVbEieInVsSFnETOol0DedILeRicm7yzom7m+HH2zqmlf892OTXLnJ3c7WA
         8nDGPgGcATwR/PQtOB5myEi/zMTL2oCElqPk4CV8OpGj5FJ9UqI7PXsmHQHsFYsXCU8T
         53jno+TEowDJCj+HDQo6DIAmObGQ95cAeIs04Az5mKCtoksEfwPiaMuRj2jOGlck9fpM
         GMydobjL15YMFP/UU0x6YIQMsVksyGQHztt4bX7l8EOEJSHTqFpXp6uGuuXaymDve+bh
         UxFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+bN8SexTbCT5j9k/6OymCyhRoZPMwyN555jgSjh4EQ=;
        b=YDJwPklf+lZHVbUfNS29C7tNT6rRhn7fnlKaLDL5RnClxRmjUrSdpzauzbQ35cc/Co
         MxWKHb71iWVPlmA0VSNKJYDIhD6k78a7oo2OlolvU+MBQkW7p/mH+3eW6Q4woPsX+jMs
         fpq/xcescg/2F0BpdCjHqfxoBANLfdJ4SgKz5gJg0H9G+X5tqHx0nhP2F0+uF9nv3A1e
         tnQNdwkqF7xLysVDyoDdOzZ8/DVWzHtKLaXv3hozlFcU0szHM2KDVCvZqTJSXLVGodG0
         I27HJfOgzKRwZOQtoqMNxUyoIZZrzPqx89CKrz9y9F1l2lcjOAVBQjRH/6yz+PpFY2AL
         QZIg==
X-Gm-Message-State: AOAM531LXRHvwoqRupPeIol817DEVYzaiYS5BQsp06ZSaQzSztgQfQGl
        WrLyWSIC1I+B1Ea4y05oyAUUul02nWw=
X-Google-Smtp-Source: ABdhPJzaqN6ETNDykpM2QqXb22kDi1lRS7wiK0GqelsIplLzN1LcAIybRtvPj4y24KxfKcJKsWWSMQ==
X-Received: by 2002:a5d:6101:: with SMTP id v1mr51625072wrt.598.1638874168667;
        Tue, 07 Dec 2021 02:49:28 -0800 (PST)
Received: from localhost.localdomain (27.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.27])
        by smtp.gmail.com with ESMTPSA id z6sm13958561wrm.93.2021.12.07.02.49.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Dec 2021 02:49:27 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux@roeck-us.net,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v3 1/5] PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
Date:   Tue,  7 Dec 2021 11:49:20 +0100
Message-Id: <20211207104924.21327-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
References: <20211207104924.21327-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When function pci_register_host_bridge() is called, 'bridge->windows' are
already available. However this windows are being moved temporarily from
there. To let pcibios_root_bridge_prepare() to have access to this windows
move this windows movement after call this function. This is interesting for
MIPS ralink mt7621 platform to be able to properly set I/O coherence units
with this information and avoid custom MIPS code in generic PCIe controller
drivers.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 087d3658f75c..372a70efccc6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -898,8 +898,6 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 
 	bridge->bus = bus;
 
-	/* Temporarily move resources off the list */
-	list_splice_init(&bridge->windows, &resources);
 	bus->sysdata = bridge->sysdata;
 	bus->ops = bridge->ops;
 	bus->number = bus->busn_res.start = bridge->busnr;
@@ -925,6 +923,8 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	if (err)
 		goto free;
 
+	/* Temporarily move resources off the list */
+	list_splice_init(&bridge->windows, &resources);
 	err = device_add(&bridge->dev);
 	if (err) {
 		put_device(&bridge->dev);
-- 
2.33.0

