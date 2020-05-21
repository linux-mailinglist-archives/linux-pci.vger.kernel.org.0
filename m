Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900F1DCBFC
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgEULUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 07:20:43 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:38918 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEULUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 May 2020 07:20:43 -0400
Received: by mail-ej1-f67.google.com with SMTP id s3so8348836eji.6
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2020 04:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoEZoMAAOxm9SLL0tL+xU3v7X0W3qwmaHX2hNNqrQz0=;
        b=cdEmP4nSysnIw/ooN8shxrXEi5Omh+ybSSSWh1xVbQKzsLPrJev1mk+bQh7Osm+kHP
         6lVeS8FZNx3EHltzA9f5flPdZO4y4wcVasN2c1oVTv41F0DYGJAsrHo8DQvdCr8KClV2
         dsjDc3fu9qF5wAgKHzNnxRRBmsInFqP0+GowmawBy4GbhZoxwYQ8zi/nToW+3bQO7aV5
         ra184zwR56bOLid52unFNfdXcS1N5qiRVnCN2KX8Cf4AxXPyF1LG6+XzQzdtaz9TRKiS
         4T2ZLhOF2Iq4mt7YXvTmc0WwgFIlV6yho4qgB6FCKOTD+27XRL9Aqqbe7tn96gz3LJKq
         lusw==
X-Gm-Message-State: AOAM531+xiT6kQ/bSm9JTA1xIEmXLYnaM4cAJoIyl+ZukNgc9YxGoJvL
        Mdarrz0O/jjYo9+E+jLFxF4=
X-Google-Smtp-Source: ABdhPJwZLJz/bHmoSFaZC8pLgJRZsGK71YTegZtox3iCpduVGVsj+AD+KD80MqaEpYrghEnRODsaFw==
X-Received: by 2002:a17:906:33c1:: with SMTP id w1mr3194421eja.313.1590060040888;
        Thu, 21 May 2020 04:20:40 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id w10sm4522376eju.106.2020.05.21.04.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 04:20:40 -0700 (PDT)
From:   Krzysztof Wilczynski <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Chuhong Yuan <hslester96@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 2/2] pcmcia: Use resources definitions when freeing CardBus resources
Date:   Thu, 21 May 2020 11:20:36 +0000
Message-Id: <20200521112036.470112-3-kw@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521112036.470112-1-kw@linux.com>
References: <20200521081638.GA30231@rocinante>
 <20200521112036.470112-1-kw@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the loop used to free CardBus resources and replace it with
a yenta_free_res() helper used to release bridge resources explicitly.

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
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

