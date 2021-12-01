Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFDC465897
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 22:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353225AbhLAVzB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 16:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbhLAVyy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 16:54:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CDFC061748;
        Wed,  1 Dec 2021 13:51:32 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s13so55400291wrb.3;
        Wed, 01 Dec 2021 13:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+bN8SexTbCT5j9k/6OymCyhRoZPMwyN555jgSjh4EQ=;
        b=R8qT7/eoh5/ttqQmHnRP/EPXLtBfokqyDLguIQVMm0q6ACnWVDzoC/huqVM/nJZpgj
         YrsHNFQQfS2Nu8ljDHX71/hc6vRxDQUjwczdBYeQxfqkfXlqJWSaK7EHUOUyGtx7SA7N
         2hOGKNPbHtSHT3rIFnsB93kJyNwG/hhON7R2XTN8v2Dma1q5pz1A5rAerqLlKOQTJAIJ
         /a4YkNi7Ni3cMw2/DYgk6JoqOGV5Rqm1g8/NNPdhYI8bHRIsQ1teLJE5zLK9gngNMTn9
         iDH86RqSoVtLYJkZE3eHSciLQpOzqQqJEL5aThiw1GJgbuZlaisTZMJ+Zx5ltkyiskSP
         sEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+bN8SexTbCT5j9k/6OymCyhRoZPMwyN555jgSjh4EQ=;
        b=yqTEiIEtGRIPZcrUbDhjKfy0bLF1z++GsVorJ89lE3cLhoIZSLqV3vekS3Jpx4I/d4
         OZdo6tbiF2pmxG4siWjqyTzv/QgSZhFnQWbQoXDlKbikPuNIhwSjnTZwRKuf+dnv7PaD
         Brr4TBLVxOpUbbBHQVFhS3KVg7b1ikBsJUeRAlIw1ikHfAzx+OSMz67T1QoL7kKIBUA3
         8/q66oaBYiqyhLNGv3ieLjdah0MRi9ufCgnlCXOJC2s9XBW9rvA/4Vo5MBSma85Kc2xa
         UwKqlMU3Rd0eSU9ALCTIyEIbw5miJjNJZ8RSV8eIt+kYSstwNkOwd0zZ/ZVCZJhiidiw
         BFMA==
X-Gm-Message-State: AOAM533Gg8mwLf+6epU4SzwLC7zekQVTwa6XwRGv3wq6cqSspPuYChfN
        TO7Kog7G7HHMmk94mzqdKuEBOmqUeqI=
X-Google-Smtp-Source: ABdhPJypB0rYDFu1QuwPhrefdwnGwmoaVYpE2KIf1zC2NF1YUDLXINMl12I4vsIof4XNYC1h2nzB/Q==
X-Received: by 2002:a5d:66c5:: with SMTP id k5mr9740544wrw.621.1638395491213;
        Wed, 01 Dec 2021 13:51:31 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id c10sm877879wrb.81.2021.12.01.13.51.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Dec 2021 13:51:30 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com, arnd@arndb.de,
        linux@roeck-us.net, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] PCI: Let pcibios_root_bridge_prepare() access to 'bridge->windows'
Date:   Wed,  1 Dec 2021 22:51:23 +0100
Message-Id: <20211201215127.23550-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
References: <20211201215127.23550-1-sergio.paracuellos@gmail.com>
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

