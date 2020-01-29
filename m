Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 255C714CD66
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgA2PaE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:04 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55810 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727069AbgA2PaE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:04 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9C8B147634;
        Wed, 29 Jan 2020 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311801; x=1582126202; bh=pruCkVN12XWGTbusYnkiSrsH6okdpvdCkfg
        wa2pRilk=; b=nJD6VJXDwvk98z/j4ouf2ntlXcUYrSIQqxZqPHcJHWwvqXbNFOb
        +xr5SdfEDJDPIMQVu5tUlf2ufbUuMyqcznOOR7U306Ah0NRnluQDWIjI4u2fX5qX
        kzhLBJVDurI+0QHi7dL3B4wmZMyzyocWhiATEOUZfpfve5ElQfdDD85w=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2dT5f8D_y4fg; Wed, 29 Jan 2020 18:30:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id D663D47612;
        Wed, 29 Jan 2020 18:29:53 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 29
 Jan 2020 18:29:53 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Stefan Roese <sr@denx.de>,
        <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v7 16/26] PCI: Ignore PCIBIOS_MIN_MEM
Date:   Wed, 29 Jan 2020 18:29:27 +0300
Message-ID: <20200129152937.311162-17-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
References: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

BARs and bridge windows are only allowed to be assigned to their
parent bus's bridge windows, going up to the root complex's resources.
So additional limitations on BAR address are not needed, and the
PCIBIOS_MIN_MEM can be ignored.

Besides, the value of PCIBIOS_MIN_MEM reported by the BIOS 1.3 on
Supermicro H11SSL-i via e820__setup_pci_gap():

  [mem 0xebff1000-0xfe9fffff] available for PCI devices

is only suitable for a single RC out of four:

  pci_bus 0000:00: root bus resource [mem 0xec000000-0xefffffff window]
  pci_bus 0000:20: root bus resource [mem 0xeb800000-0xebefffff window]
  pci_bus 0000:40: root bus resource [mem 0xeb200000-0xeb5fffff window]
  pci_bus 0000:60: root bus resource [mem 0xe8b00000-0xeaffffff window]

, which makes the AMD EPYC 7251 unable to boot with this movable BARs
patchset.

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/setup-res.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index a7d81816d1ea..4043aab021dd 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -246,12 +246,13 @@ static int __pci_assign_resource(struct pci_bus *bus, struct pci_dev *dev,
 		int resno, resource_size_t size, resource_size_t align)
 {
 	struct resource *res = dev->resource + resno;
-	resource_size_t min;
+	resource_size_t min = 0;
 	int ret;
 	resource_size_t start = (resource_size_t)-1;
 	resource_size_t end = 0;
 
-	min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
+	if (!pci_can_move_bars)
+		min = (res->flags & IORESOURCE_IO) ? PCIBIOS_MIN_IO : PCIBIOS_MIN_MEM;
 
 	if (pci_can_move_bars && dev->subordinate && resno >= PCI_BRIDGE_RESOURCES) {
 		struct pci_bus *child_bus = dev->subordinate;
-- 
2.24.1

