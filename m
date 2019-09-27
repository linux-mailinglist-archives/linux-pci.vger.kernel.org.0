Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9EBFC4E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbfI0AZJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38700 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfI0AZI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id m16so3747063oic.5;
        Thu, 26 Sep 2019 17:25:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2eJmO98TJvWjef7NL2xv0z4jdHs/rDOAySInsQ51HYo=;
        b=qvhDAxBAoQbm3dv5rQzxbn/qYzKGe8M9Q8bRLb1NFqcCmGIreODiyDFEQhX9QBXu03
         k8mnioCWIxWn3N1Hponxx0o49k3m1IPao1UKyYUYcmUkdGJG6oUsErr6jkg4DRTSDk+B
         YSy+hiPm2eqiuoF2QEbEE1KkAhixZKy1F1c17IH8/1Bz023JjY8lQlGqzME+PMUzxUqu
         2ZkOXfhu1cRGDXMCwB116cyUuYcm358yoBv8vQp/OSBeqE/PTLcl6slgqWghwTaOjOSW
         bT3p2KGcxoscq01EMRp1Yzig/pS+Gc72JiOO0u38A9NQgBBcdd0n5UkiBc/j8hn7gq3x
         Qolg==
X-Gm-Message-State: APjAAAWfW33ukipWuz5cmvm3nBsPPsoXjTYni3uUE7tnrUo+nnW/hDg6
        8cwV4MwoyfhtI2iRk7Z8m+N3sOA=
X-Google-Smtp-Source: APXvYqymF9L96mPxVpqSA9nOQNOKKwoPIHBbCEwP0jWqbUfs1Sl2A8wDMIuZP/zjDv51L0/QcKzRIQ==
X-Received: by 2002:aca:4890:: with SMTP id v138mr5031090oia.57.1569543907590;
        Thu, 26 Sep 2019 17:25:07 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:07 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Oza Pawandeep <oza.oza@broadcom.com>
Subject: [PATCH 07/11] of: address: Follow DMA parent for "dma-coherent"
Date:   Thu, 26 Sep 2019 19:24:51 -0500
Message-Id: <20190927002455.13169-8-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927002455.13169-1-robh@kernel.org>
References: <20190927002455.13169-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Robin Murphy <robin.murphy@arm.com>

Much like for address translation, when checking for DMA coherence we
should be sure to walk up the DMA hierarchy, rather than the MMIO one,
now that we can accommodate them being different.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index e9188c82fdae..3fd34f7ad772 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -999,7 +999,7 @@ bool of_dma_is_coherent(struct device_node *np)
 			of_node_put(node);
 			return true;
 		}
-		node = of_get_next_parent(node);
+		node = of_get_next_dma_parent(node);
 	}
 	of_node_put(node);
 	return false;
-- 
2.20.1

