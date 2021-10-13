Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50DF42C0AA
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbhJMM5v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 08:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbhJMM5u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Oct 2021 08:57:50 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967B1C061746;
        Wed, 13 Oct 2021 05:55:47 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ls18-20020a17090b351200b001a00250584aso4352787pjb.4;
        Wed, 13 Oct 2021 05:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qr5cIxR0kdJHZu/gbgrUUMTaWeuTBYEyE1I2TMeES3E=;
        b=BUVeFcn3vgfyjzgM6QdcnqCR93fo+yrUB6EJo2NT0cf/r7m3xXFLZc1jDRog2P+w+3
         MrmFHkUKzPOgaSqSXB+2JBYb6ir9knikOqS39VpJPvg5N1Pqfs3bCit6/HNG4hLovR1C
         4i5HzENFtqN999l+3lrtZTPoC3m+xtHcTW4S/Z9BYMim4MJGD1Pxh61aqD0C0vpJzLmw
         12NM+eLfhHL1twGh/MM4F9WvupOR+x/EzMHrd86uMbav/7Zx2S0JcQveMYz5qzzQqU3l
         A6ZCU5Iq2LKi5AL4QeOy9jXvcipqS3fqadeDJ2f7edjTLwHLT+MvpP/6SblGJnGs1y1h
         wJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qr5cIxR0kdJHZu/gbgrUUMTaWeuTBYEyE1I2TMeES3E=;
        b=0JCplw4iPK8KAVsse14nx93lw3f0Se7QKAl0U2+ZIpLTP0q09cQRhSIek7ZPuSQ3kA
         fWAWhQTSa4wDcVkKPp9wXFZVjo0b7+FbPOI8dsIhPHIpi5eovpysWzGT0Ox9ZTKZkCN1
         VdRTw+Ss/Lk7Of9NdnLzy4cXmOpwM7xHSUhiH+nZcUWo4Vrik34WWYQFYXU5TrIVa90m
         pmWPxoHw80xNcrxN6pg5VsfBo7q1tT49UY9drInI0ulOujMGzijZjQs5ffP25LH8i8Et
         EXCZYJyfqTDobq3ObjAr0Za2B7BTRz0/kaZYKVn7mu8uywpoEbqLd3uSO4PTS2AFgaxf
         cKig==
X-Gm-Message-State: AOAM533pqT66Tmc87/VIQkZOhOiMLEdh2ch48LXXKBaTlm2GvYhyD6AS
        i8kCK+uleavWQvl3N9FMBZg4b2YdBoQ=
X-Google-Smtp-Source: ABdhPJwAkaclm8MzT5pl3WIADyA9rHbW9aNl8oBMKSQ/1bAMV+IqbI8a3AVx+5uQhxe04xG2IO6OAA==
X-Received: by 2002:a17:902:b70d:b0:13d:f6c9:2066 with SMTP id d13-20020a170902b70d00b0013df6c92066mr35704665pls.2.1634129747148;
        Wed, 13 Oct 2021 05:55:47 -0700 (PDT)
Received: from desktop.cluster.local ([162.14.19.95])
        by smtp.gmail.com with ESMTPSA id z13sm14302581pfq.130.2021.10.13.05.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:55:46 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
Subject: [PATCH] pci: call _cond_resched() after pci_bus_write_config
Date:   Wed, 13 Oct 2021 20:55:42 +0800
Message-Id: <20211013125542.759696-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

While the system is running in KVM, pci config writing for virtio devices
may cost long time(about 1-2ms), as it causes VM-exit. During
__pci_bus_assign_resources(), pci_setup_bridge, which can do pci config
writing up to 10 times, can be called many times without any
_cond_resched(). So __pci_bus_assign_resources can cause 25+ms scheduling
latency with !CONFIG_PREEMPT.

To solve this problem, call _cond_resched() after pci config writing.

Signed-off-by: Menglong Dong <imagedong@tencent.com>
---
 drivers/pci/access.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 46935695cfb9..babed43702df 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -57,6 +57,7 @@ int noinline pci_bus_write_config_##size \
 	pci_lock_config(flags);						\
 	res = bus->ops->write(bus, devfn, pos, len, value);		\
 	pci_unlock_config(flags);					\
+	_cond_resched();						\
 	return res;							\
 }
 
-- 
2.27.0

