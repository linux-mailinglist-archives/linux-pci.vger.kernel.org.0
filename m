Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C21DB03D
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 12:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgETKbz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 06:31:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42948 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgETKbz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 06:31:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id l15so2659858lje.9
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 03:31:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoW8bRUAiBX+8/rdRyNkjijqyC9zlfBu1RYXN/tkouU=;
        b=cH97s/4vttgoT0UZ+eQSAW78ObdxHjYt7++tjx5Q8Q+xY7iY5zbe5+LkEM7b2Yg3Nf
         w0F1k2MFzCLlciYJTdCvMDndyRuZv59T8TtXmv+5YoZFIXeIBp3LYhyZxL0zAsgWCke/
         M13Y+Qf2CFXFO3zaT0ob2i6tjNrkafad+Et7bbNN1knuMT3Qq4IcWqzCvcBKN7eMozAh
         1fUKYB8pkC0PjUTEI9ibMKG/2coauNTra9CMi2VzX5kVqwtNeWvwh8Kk7ivIYfp27FEG
         Ah3BCPyLt8/MFF56bdHGio3fpWBF4BpjgpaJ6v2ZmWABEVMZPFjEfmx2FnPTzd1z799j
         BVMg==
X-Gm-Message-State: AOAM530ZDTp5HCDVhgwWvNCSOedBYkgJYObsbL/wPh+pY8bCwfhKu/cU
        onlMAFg+JDMyXnnoaDBaMHVpGB4XW/SPaw==
X-Google-Smtp-Source: ABdhPJyF2Is06dIlCXSgdFj25y2LLshIMhodu/Oz5VPcuA28GxJo5qbxCiD1FJorfqmwGTNtV/Uh9g==
X-Received: by 2002:a2e:7d19:: with SMTP id y25mr2406895ljc.255.1589970712140;
        Wed, 20 May 2020 03:31:52 -0700 (PDT)
Received: from localhost.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id v28sm967404lfd.35.2020.05.20.03.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 03:31:51 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 3/3] pcmcia: Use resources definitions when freeing CardBus resources
Date:   Wed, 20 May 2020 10:31:47 +0000
Message-Id: <20200520103147.985326-4-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520103147.985326-1-kw@linux.com>
References: <20200519214926.969196-1-kw@linux.com>
 <20200520103147.985326-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the loop used to free CardBus resources and replace it with
a yenta_free_res() helper used to release bridge resources explicitly.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
 drivers/pcmcia/yenta_socket.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 76036ccf2106..3f34b49a6f33 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -745,6 +745,18 @@ static int yenta_allocate_res(struct yenta_socket *socket, int nr, unsigned type
 	return 0;
 }
 
+static void yenta_free_res(struct yenta_socket *socket, int nr)
+{
+	struct pci_dev *dev = socket->dev;
+	struct resource *res;
+
+	res = &dev->resource[nr];
+	if (res->start != 0 && res->end != 0)
+		release_resource(res);
+
+	res->start = res->end = res->flags = 0;
+}
+
 /*
  * Allocate the bridge mappings for the device..
  */
@@ -773,14 +785,10 @@ static void yenta_allocate_resources(struct yenta_socket *socket)
  */
 static void yenta_free_resources(struct yenta_socket *socket)
 {
-	int i;
-	for (i = 0; i < 4; i++) {
-		struct resource *res;
-		res = socket->dev->resource + PCI_BRIDGE_RESOURCES + i;
-		if (res->start != 0 && res->end != 0)
-			release_resource(res);
-		res->start = res->end = res->flags = 0;
-	}
+	yenta_free_res(socket, PCI_CB_BRIDGE_IO_0_WINDOW);
+	yenta_free_res(socket, PCI_CB_BRIDGE_IO_1_WINDOW);
+	yenta_free_res(socket, PCI_CB_BRIDGE_MEM_0_WINDOW);
+	yenta_free_res(socket, PCI_CB_BRIDGE_MEM_1_WINDOW);
 }
 
 
-- 
2.26.2

