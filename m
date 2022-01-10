Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CD8488E76
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jan 2022 02:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiAJB4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 9 Jan 2022 20:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238047AbiAJB4k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 9 Jan 2022 20:56:40 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4436C06173F
        for <linux-pci@vger.kernel.org>; Sun,  9 Jan 2022 17:56:39 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id p14so10663195plf.3
        for <linux-pci@vger.kernel.org>; Sun, 09 Jan 2022 17:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fungible.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mkYHuJw67a3LbulvnX5SF5Jwp91Xp1LWbpzZ01T5e78=;
        b=Y+pE1fqHcd+rDLcOYZjxlKuafsrt6n+9nLd8OWB/b8Ip8c1QX07h1F0vWc2fR5FbwR
         kpl3JpsNXb0Acxqaf6dvuNwn7vlme6TwtR0EoXnh27FaADB7LKyZryzD/YgbxAWK3L0Q
         rUWNTmO7yY06HN8lvxV9Bf8DJbJb2GlDDMSXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mkYHuJw67a3LbulvnX5SF5Jwp91Xp1LWbpzZ01T5e78=;
        b=Iw1WN0VX2VwrW4kOXbq/49FMpNfwcw1grvz82pC+M6FsLr86hCjZRE1ZaZxB2gKQjJ
         zHBi1lKtYhtI5TPIArKd+ME/P1uIJzFiYD7lU/E6Mf3pToZno3959IivEnJ1NCj5DnG8
         ujshHJylSJbJIFMzeqEC2SSHYv0DLC/nq5Glr9eHj1Lq65xqf5r3uIo6phkBT7MIIB2W
         mNakc9tQVWEOZlNiI8flcrkd3gyiXPeQhuStHF/lmxOdBOXB54UDZi826QBNJT2+i2s7
         wVPbCH8jTyM98SYHfwJZ/xdIue7qMQil1/EUxbn5hnAEEIH4YWLS3+dMjijYwgnQDwI7
         FQaA==
X-Gm-Message-State: AOAM531s+cpxh1SBIchcw2VK/vSYpejRvy+TAV6sCjWK1fChB1fU71WM
        OUz2nGFqFj6HL4mSYGvYdTIaVgQggV+f+A==
X-Google-Smtp-Source: ABdhPJx7N5pSatkNIjYxs21kxaRiwOfmy94ujvV5rWllmtNldh8/pzuz3CWpnzBmXiqm3A6bOAT7Yw==
X-Received: by 2002:a17:90b:3b83:: with SMTP id pc3mr28155778pjb.3.1641779799446;
        Sun, 09 Jan 2022 17:56:39 -0800 (PST)
Received: from cab09-qa-09.fungible.local ([12.190.10.11])
        by smtp.gmail.com with ESMTPSA id rm3sm6909535pjb.8.2022.01.09.17.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 17:56:38 -0800 (PST)
From:   Dimitris Michailidis <d.michailidis@fungible.com>
X-Google-Original-From: Dimitris Michailidis <dmichail@fungible.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, d.michailidis@fungible.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH net-next v6 1/8] PCI: Add Fungible Vendor ID to pci_ids.h
Date:   Sun,  9 Jan 2022 17:56:29 -0800
Message-Id: <20220110015636.245666-2-dmichail@fungible.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220110015636.245666-1-dmichail@fungible.com>
References: <20220110015636.245666-1-dmichail@fungible.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Dimitris Michailidis <dmichail@fungible.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 011f2f1ea5bb..c4299dbade98 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2578,6 +2578,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_FUNGIBLE		0x1dad
+
 #define PCI_VENDOR_ID_HXT		0x1dbf
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
-- 
2.25.1

