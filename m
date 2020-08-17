Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D242467E0
	for <lists+linux-pci@lfdr.de>; Mon, 17 Aug 2020 15:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgHQN7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Aug 2020 09:59:09 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:47656 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbgHQN7J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Aug 2020 09:59:09 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BACA4C0758;
        Mon, 17 Aug 2020 13:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1597672748; bh=aUf4ca3GAzxlLUszF9y6r7Fe2ysKhwxP0CiLN9biR88=;
        h=From:To:Cc:Subject:Date:From;
        b=Ykiywd9ez1Fl9i6l1DGaDAfyRTO7wAxhN4QaHRzcOafqgeOiq6YjZcq41+xp0Kq1a
         LaLwqmUK5B4GiUo9fMCR/XSi0oPcT9QzoNUEu7Y4b4AnBaAOHp/zn/v6nLCb5M1DsP
         kabyY7zliaLSQvFEFV8jYkT7qJiLpyRVgFz1H3gSmV1Mlc0Y4FO5pBYM7SWsA6Qv3w
         N2BGsUhIqEoSFBO6O2S2z92LxMp+/tlSNrNWjj32VPcvyZ6ldxh9x0ck5DxM4h9ZW+
         N13ezN9oEGNNsnlh3NJXizxdGnrYhQ+0odYfTTyuWJm6ryO6tMyzropQbs7/K0zxCc
         bxjrD4a+L+vng==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id D47BEA005A;
        Mon, 17 Aug 2020 13:59:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-pci@vger.kernel.org
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] MAINTAINERS: Add missing documentation references to PCI Endpoint Subsystem
Date:   Mon, 17 Aug 2020 15:59:00 +0200
Message-Id: <0099b4e78dc60be0afd413834994308c68a11d0b.1597672498.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds documentation reference created by Kishon Abraham to the
MAINTAINERS list relative with the PCI endpoint subsystem section.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698c..56d319f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13192,6 +13192,8 @@ M:	Kishon Vijay Abraham I <kishon@ti.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
+F:	Documentation/PCI/endpoint/*
+F:	Documentation/misc-devices/pci-endpoint-test.txt
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/pci-endpoint.git
 F:	drivers/misc/pci_endpoint_test.c
 F:	drivers/pci/endpoint/
-- 
2.7.4

