Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F033E7638
	for <lists+linux-pci@lfdr.de>; Mon, 28 Oct 2019 17:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732823AbfJ1QdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Oct 2019 12:33:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41389 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730772AbfJ1QdC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Oct 2019 12:33:02 -0400
Received: by mail-oi1-f194.google.com with SMTP id g81so6399413oib.8;
        Mon, 28 Oct 2019 09:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ly9SwwfQU77PS/De9nePQz9/hgu0i/2+0AP8IGmXD3o=;
        b=E4EL88dFKu3hNE3PiY3hx79WoH+Zk7+YuRD5T8HVBKY1kJ1nuHVWPUfv+MaVgmJPCN
         DJ9TcdJ4uO0l2A4rLEPE7YNqasbSxkYM6n905MZW98Z91u80RIIzOigju8p8GxEysVFt
         jsztL2P0Ec/GMLJjKv8eaPKjdyCr1ewjCBov7pQf5s5t6rd+UndxNtmlQVUuENmls2qJ
         hyY05QP+hCePW6tIxYfhc3NUnh5GJIOpKAnz8IEuSnf1RT16dbofJeL/X4KQPRVnmg46
         FbFWVA5IxIMbEhBiHqI1ccVMqXnb63pX9qSgL6ewt+I3DHKgMZd93qnfCzkvnPKN4k9a
         dlIA==
X-Gm-Message-State: APjAAAXbU4Gvbc2zogzSmobIDxgL4hkOtI/lnPzDHomxawsAJS2Y7O4+
        7oVDXSEIiuB/g1H1i4S2iw==
X-Google-Smtp-Source: APXvYqz7AvFVl42WcaIBsnF/FBWNvONUeq6ow/pzPzHbo/QsqT4JbiucFb+B7zhfVTYFjNW6To0vKg==
X-Received: by 2002:aca:1e0c:: with SMTP id m12mr168280oic.18.1572280381198;
        Mon, 28 Oct 2019 09:33:01 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id e186sm354991oia.47.2019.10.28.09.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 09:33:00 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Christoph Hellwig <hch@infradead.org>,
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
Subject: [PATCH v3 01/25] resource: Add a resource_list_first_type helper
Date:   Mon, 28 Oct 2019 11:32:32 -0500
Message-Id: <20191028163256.8004-2-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191028163256.8004-1-robh@kernel.org>
References: <20191028163256.8004-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A common pattern is looping over a resource_list just to get a matching
entry with a specific type. Add resource_list_first_type() helper which
implements this.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v3:
- Rename resource_list_get_entry_of_type to resource_list_first_type

 include/linux/resource_ext.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/resource_ext.h b/include/linux/resource_ext.h
index 06da59b23b79..ff0339df56af 100644
--- a/include/linux/resource_ext.h
+++ b/include/linux/resource_ext.h
@@ -66,4 +66,16 @@ resource_list_destroy_entry(struct resource_entry *entry)
 #define resource_list_for_each_entry_safe(entry, tmp, list)	\
 	list_for_each_entry_safe((entry), (tmp), (list), node)

+static inline struct resource_entry *
+resource_list_first_type(struct list_head *list, unsigned long type)
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
