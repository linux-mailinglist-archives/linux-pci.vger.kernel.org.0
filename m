Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2711DBCF5
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgETSeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 14:34:19 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:35448 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgETSeS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 14:34:18 -0400
Received: by mail-ej1-f67.google.com with SMTP id s21so5326822ejd.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2020 11:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoW8bRUAiBX+8/rdRyNkjijqyC9zlfBu1RYXN/tkouU=;
        b=msDg72TJO5fZvK9kf8UhkLiSsL5ZB/WYdtYMTnDGQzOODkt/xEnAIe+WwV3wjUPnAm
         dvDVPV2LjcmGIoKNRTAJae5Yp76LvqqEL0zDoje1KNM0C03hcnumHQ2XMNwDgpffbF8G
         njkFUhgQp0Qrx0ivHXguYSEwFwbStnJkc+TLipAUMGtAAYBDNXtk3Uc4jFD8CSgR64is
         WeumvjUpMC1F7JO33FnCe0RUyUa71epTooTFeD5L2v32xORbU4TcvqsWblUEEA6OD5EG
         7jss6p3HzV9CA1C/3PXwzk/bFCT5tUsRLculsZdOQQ9bxAjEv1BCyPCqmdbxCYy9e3mk
         VWVA==
X-Gm-Message-State: AOAM533bd9IFwHksUukeB3wErhgKPnt6hlln5zojTeDcv0f2/vpXnYEl
        7EozpU0kJhCEaQ9KSPWZNXQ=
X-Google-Smtp-Source: ABdhPJwVo8kS5PvO71d/ZwFJH0qaPhTozJKjzU2/J243qM3fCI7wBGRNU78KgX0cbTCAkEMNA0bPaA==
X-Received: by 2002:a17:906:9419:: with SMTP id q25mr381876ejx.111.1589999655848;
        Wed, 20 May 2020 11:34:15 -0700 (PDT)
Received: from localhost.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z3sm2739855ejl.38.2020.05.20.11.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:34:14 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 2/2] pcmcia: Use resources definitions when freeing CardBus resources
Date:   Wed, 20 May 2020 18:34:11 +0000
Message-Id: <20200520183411.1534621-3-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200520183411.1534621-1-kw@linux.com>
References: <20200520170609.GA1102503@bjorn-Precision-5520>
 <20200520183411.1534621-1-kw@linux.com>
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

