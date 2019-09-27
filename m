Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD36BFC56
	for <lists+linux-pci@lfdr.de>; Fri, 27 Sep 2019 02:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfI0AZI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Sep 2019 20:25:08 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38700 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727777AbfI0AZH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Sep 2019 20:25:07 -0400
Received: by mail-oi1-f196.google.com with SMTP id m16so3747036oic.5;
        Thu, 26 Sep 2019 17:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kwduh2L3Q3wglxQRQFNc0vVRF7aZPumhA9/VlLU+NE=;
        b=mjhcUDE8XUiETIYkOZkncJVwXFfDn3+5OtMOKkMygQtL0EMH6+dzILudd6EoFv4LRt
         NFOVho6exq84wuyEEwcJayqJJ6hzsSz6HAQK1rgWBpW1V52UgdUZe3AHwUtVGOGK73Y+
         aw0vdIsvkAPuEyEvBkTE3pZmOdTDD7jIw35WNmM9Bx/iLhYrfQCtF7sZ0k7O4VdRjGbC
         LV4eBoFPJeKw4wt+FWwOuntgjxUqw9mhdypHpHS2W5oyE5EoT2EUSW7YqLecLlAfMsWl
         lD+3oBlaBBxy4s1L0rVECGMI0c5BFFOXhHwwxeKXX0kWFzxrj9kvJ9bT72PyFp6Uf5fX
         UN/A==
X-Gm-Message-State: APjAAAW8KwnBEzAcWpKg7+K+BIwbrJgcq/hMxW7G8FI6SvMK3qn+OlK/
        0U7Iss5M88wxi5UOZ4txzZdhKvY=
X-Google-Smtp-Source: APXvYqwZ4lR/YWP5vXy1ugIkWQ7hYP0e0FO8/TUE1SqXSQM+108Okq4ee9Kd9IvMs2n7+cX5zbFRVg==
X-Received: by 2002:aca:540a:: with SMTP id i10mr4633085oib.108.1569543906002;
        Thu, 26 Sep 2019 17:25:06 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id j11sm339866otk.80.2019.09.26.17.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 17:25:05 -0700 (PDT)
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
Subject: [PATCH 06/11] of/address: Introduce of_get_next_dma_parent() helper
Date:   Thu, 26 Sep 2019 19:24:50 -0500
Message-Id: <20190927002455.13169-7-robh@kernel.org>
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

Add of_get_next_dma_parent() helper which is similar to
__of_get_dma_parent(), but can be used in iterators and decrements the
ref count on the prior parent.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/of/address.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/of/address.c b/drivers/of/address.c
index 53d2656c2269..e9188c82fdae 100644
--- a/drivers/of/address.c
+++ b/drivers/of/address.c
@@ -695,6 +695,16 @@ static struct device_node *__of_get_dma_parent(const struct device_node *np)
 	return of_node_get(args.np);
 }
 
+static struct device_node *of_get_next_dma_parent(struct device_node *np)
+{
+	struct device_node *parent;
+
+	parent = __of_get_dma_parent(np);
+	of_node_put(np);
+
+	return parent;
+}
+
 u64 of_translate_dma_address(struct device_node *dev, const __be32 *in_addr)
 {
 	struct device_node *host;
-- 
2.20.1

