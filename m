Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5031BF215
	for <lists+linux-pci@lfdr.de>; Thu, 30 Apr 2020 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD3IGq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Apr 2020 04:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgD3IGo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Apr 2020 04:06:44 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2B4021D7F;
        Thu, 30 Apr 2020 08:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588234004;
        bh=TPnP78eeknSuUjBTOPPusY/VNyretW7NK7oJHlas4Mg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oQl9HLUXC1bDoHro/6k7bDuGT4/va3vFcTfqQah95Ds91OcYxam5zgp1fztDwrhkm
         YJ4ZOkzb9jv7au88QTp6AAI3Lwaxagd4X77OheNUr1jA2SWwdIKT0EQAyEJk1kV0oH
         9GX4b/LmwXHYNqEfExNiGskOZHCmd64cWndBZy2w=
Received: by pali.im (Postfix)
        id 27FA27AD; Thu, 30 Apr 2020 10:06:42 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v4 03/12] PCI: of: Zero max-link-speed value is invalid
Date:   Thu, 30 Apr 2020 10:06:16 +0200
Message-Id: <20200430080625.26070-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430080625.26070-1-pali@kernel.org>
References: <20200430080625.26070-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Interpret zero value of max-link-speed property as invalid,
as the device tree bindings documentation specifies.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..27839cd2459f 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -592,7 +592,7 @@ int of_pci_get_max_link_speed(struct device_node *node)
 	u32 max_link_speed;
 
 	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
-	    max_link_speed > 4)
+	    max_link_speed == 0 || max_link_speed > 4)
 		return -EINVAL;
 
 	return max_link_speed;
-- 
2.20.1

