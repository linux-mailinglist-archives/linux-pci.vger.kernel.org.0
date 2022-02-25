Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B794C3C0C
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 03:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbiBYC7i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Feb 2022 21:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiBYC7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Feb 2022 21:59:37 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D711EC255
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 18:59:07 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id bd1so3590994plb.13
        for <linux-pci@vger.kernel.org>; Thu, 24 Feb 2022 18:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fungible.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R9dcpe70j9Trk9rKuKWmAu1MvnVHF87exvDoWtSGUqM=;
        b=KQoLjAf8JH3bVzNJAVgTc6i2EqQqA8oE3gAxLFZVdbVRq8STVIeVGh0qXCEms3U4Iy
         +OgCxWBwRwQ3BO+oCBOtpIlECk7zQQcKxX0EqjtFtVIZxOyNpbhelmm3k/dRtmkBEEkN
         J9DOZGM/9nQGk/SEbciSrOJxzriGAIFHlcpOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R9dcpe70j9Trk9rKuKWmAu1MvnVHF87exvDoWtSGUqM=;
        b=Y77ciQrlAkC/JeqEdMkiUUS+DRzCQL+geMrRx4fzDBjC3PfPWQGO4hbiZvKKN0bQkr
         SnDRSCETf4pLIEauNSQX+18CH76QlQZoqw8oo+UwIMISpC5h1TMV+DgYNeubpNntpTzr
         wlDWXxtKH027LBukATaZxnJFV62QDbOk8mntfzIjeAFslLMTYXuQDPSEenfF7WN1cIBl
         M7rv6g1oZQeYYik5h4mLgdCgGUn1/gzYogW8aUGzPJJqx2yo628qAdoM3cnJGHLO025T
         HJoML6rUDy4eqlOG6Ym15oWSdpgrhPP3VbJEC+n9P18onecRE5KL0pBWZ9cyTElhO2/q
         MVgw==
X-Gm-Message-State: AOAM532NWGRDaf6hiD9sedAk+tImInrtLsY95CpVdga7n6eHtajMZAWw
        tJQbQPZZQT6NiC1gtoFzeLRrBA==
X-Google-Smtp-Source: ABdhPJxQZhDsbRkEFSGIqh9jmp4oIZe/o9KQ4KxxA/u7dmgTljFQcTdyChCC+P0s5+WS95oLB+oCxA==
X-Received: by 2002:a17:90a:800b:b0:1bc:1954:9640 with SMTP id b11-20020a17090a800b00b001bc19549640mr1094593pjn.89.1645757946660;
        Thu, 24 Feb 2022 18:59:06 -0800 (PST)
Received: from cab09-qa-09.fungible.local ([12.190.10.11])
        by smtp.gmail.com with ESMTPSA id q93-20020a17090a4fe600b001b9ba2a1dc3sm7397526pjh.25.2022.02.24.18.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 18:59:06 -0800 (PST)
From:   Dimitris Michailidis <d.michailidis@fungible.com>
X-Google-Original-From: Dimitris Michailidis <dmichail@fungible.com>
To:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, d.michailidis@fungible.com
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [PATCH net-next v8 1/8] PCI: Add Fungible Vendor ID to pci_ids.h
Date:   Thu, 24 Feb 2022 18:58:55 -0800
Message-Id: <20220225025902.40167-2-dmichail@fungible.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225025902.40167-1-dmichail@fungible.com>
References: <20220225025902.40167-1-dmichail@fungible.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index aad54c666407..c7e6f2043c7d 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2561,6 +2561,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_FUNGIBLE		0x1dad
+
 #define PCI_VENDOR_ID_HXT		0x1dbf
 
 #define PCI_VENDOR_ID_TEKRAM		0x1de1
-- 
2.25.1

