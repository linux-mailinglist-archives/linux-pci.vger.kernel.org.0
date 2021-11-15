Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CCB44FF07
	for <lists+linux-pci@lfdr.de>; Mon, 15 Nov 2021 08:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhKOHLi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Nov 2021 02:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbhKOHLL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Nov 2021 02:11:11 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A2CC061766;
        Sun, 14 Nov 2021 23:08:14 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso14920900wmc.2;
        Sun, 14 Nov 2021 23:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDuMlt4ukL93ZP789pRIz0IDAng97x1CmRl/YW4VpFE=;
        b=LsPI06cvMDNIH8/Xy+mxaWV0gEpxQN0/AVYLBjGM1H9PD4R/UkxpuA9b1bN6d+DADy
         W5u3NJKlQ9yq5D3El/AkMnY4pxidYro0gTYQVInoS4GAzBcDxiRXbgrFxcHiJIoo1hnR
         +0c5pKJzJ8PRIyDwEWenRKgrosmaIoDFPLeeDS6/6p+SOddFzH97RMqnZnPBk0gE1ZEz
         Nysh4uhNCzb3fIOchPG8h26zbDoxx0MrBktNOWXlZC3A9KOs+TiKVolyjEPiygWXi/Em
         OztXfB/lqqR6WvZiOklXLs+8x1o2y+oGemWVItR37XH+du4/qvUQoPo/PPr4ydajIbkT
         mTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDuMlt4ukL93ZP789pRIz0IDAng97x1CmRl/YW4VpFE=;
        b=4yJ/yuM69lloV/tmFsFgdA+HvjhOVcsShmJpSGcrPH9dN5l8OiLt9KLetxLnn5kaNo
         jFRTWOToLFzy+OtSRPQQ4wpqS61LCHkPPT3wrJ02+NXyzyTxPLJbQGH9MlIq/LFiURKP
         ZQxDv8RAEvcmIIPr+lsdlIehlZf1sLgE6ajZlB27jAIxLqKLN5Ks3TFg4LHfdfK3FuUp
         EYsVoDx9SjzaXkrBRXv8PEGJITGDWHoOr/5K8TCWYHgNlJxTaO8e5wfea8BnS1N0QtLw
         /NXNV6r/4o/fFIC3LsP735jzB8HuKO09JZoV+kIQdPDBG3u0bJOBDQAFmQ0GYIoVAAby
         mJ1Q==
X-Gm-Message-State: AOAM532NqCB46hKaiIyUJZ0nccQGbg7xK1azM1jVoN33ioDMA2wpu1jh
        SITxEuCRVXbsvXf7RllihzIvNJgu2do=
X-Google-Smtp-Source: ABdhPJzdhzCUYOtFpREBoYEc2i6uaHan0JmgRdMe5sgLs6HCWCMRLxxK3I21cBirYN+16ozUjD9XWQ==
X-Received: by 2002:a1c:7c19:: with SMTP id x25mr41461932wmc.42.1636960092619;
        Sun, 14 Nov 2021 23:08:12 -0800 (PST)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id d6sm13301079wrx.60.2021.11.14.23.08.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Nov 2021 23:08:12 -0800 (PST)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] PCI: let 'pcibios_root_bridge_prepare()' access to 'bridge->windows'
Date:   Mon, 15 Nov 2021 08:08:05 +0100
Message-Id: <20211115070809.15529-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
References: <20211115070809.15529-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When function 'pci_register_host_bridge()' is called, 'bridge->windows' are
already available. However this windows are being moved temporarily from
there. To let 'pcibios_root_bridge_prepare()' to have access to this windows
move this windows movement after call this function. This is interesting for
MIPS ralink mt7621 platform to be able to properly set I/O coherence units
with this information and avoid custom MIPs code in generic PCIe controller
drivers.

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

