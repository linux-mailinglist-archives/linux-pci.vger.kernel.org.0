Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B88BD9AD3
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 22:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfJPUGx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 16:06:53 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46432 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfJPUGx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 16:06:53 -0400
Received: by mail-oi1-f194.google.com with SMTP id k25so82498oiw.13;
        Wed, 16 Oct 2019 13:06:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A4I4vYKlrRjeCcvZ3gdAUf5OIh4K24Pgv1HRMaUxQSM=;
        b=oAIcbIUDBcpFNknn1Xh+VmdR6GC4vTCFyHxF9u7UHNExAUbCA/nRhDnbMJ01SXIuTj
         MPd8KJsrgWTSaFUOPsPO/+df2R49+uefoU0oF883HwyzSgNIfrxyQWVotx5oSvKzPcIy
         wO6rF5uNz45om98FGLZNWqlHgEGEUPj8zlLdvzieLUA00P3HWCRs/oAZn1AawW8JKnP+
         gO891V2VlxRm2ocfcuxaBcTR2YQzRQnG5TqoeBgsXuXpjJDQ31iNZv1wyJm6oBd3F7pM
         jbTsD2qg2r9/KF5vs1JcnXY5aNZJwAIoS1W+6k80MMCvxeQzRpxHygNATMpqWu547RwO
         +Frg==
X-Gm-Message-State: APjAAAUW0+PnEKSrlHczvafphXs+djTqfqx9lv9KLsHUFCrVhQXrxgi7
        UWnvhVYp2p+GpNZ7eMTbGA==
X-Google-Smtp-Source: APXvYqy2RgxqIowsn3RilHDMVL8ZYUZqVhZ4FNbcwDaYFpFY5yEQQz1OcvvwTVzq3lVosqWKYYObvw==
X-Received: by 2002:aca:b9d7:: with SMTP id j206mr110297oif.112.1571256412390;
        Wed, 16 Oct 2019 13:06:52 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id a9sm7412463oie.7.2019.10.16.13.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 13:06:51 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>, rfi@lists.rocketboards.org,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 01/25] resource: Add a resource_list_get_entry_of_type helper
Date:   Wed, 16 Oct 2019 15:06:23 -0500
Message-Id: <20191016200647.32050-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191016200647.32050-1-robh@kernel.org>
References: <20191016200647.32050-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A common pattern is looping over a resource_list just to get a matching
entry with a specific type. Add resource_list_get_entry_of_type() helper
which implements this.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- New patch

 include/linux/resource_ext.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
index 06da59b23b79..9f52183fab8b 100644
--- a/include/linux/resource_ext.h
+++ b/include/linux/resource_ext.h
@@ -66,4 +66,16 @@ resource_list_destroy_entry(struct resource_entry *entry)
 #define resource_list_for_each_entry_safe(entry, tmp, list)	\
 	list_for_each_entry_safe((entry), (tmp), (list), node)

+static inline struct resource_entry *resource_list_get_entry_of_type(struct list_head *list,
+							      unsigned long type)
+{
+	struct resource_entry *entry;
+
+	resource_list_for_each_entry(entry, list) {
+		if (resource_type(entry->res) == type)
+			return entry;
+	}
+	return NULL;
+}
+
 #endif /* _LINUX_RESOURCE_EXT_H */
--
2.20.1
