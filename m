Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE44C90628
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbfHPQvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51326 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727067AbfHPQvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 3707B42EE3;
        Fri, 16 Aug 2019 16:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974279; x=1567788680; bh=4FBRD8yK42SiYXr6aUuvlJDVMjXjanyoyQq
        1TUHja0k=; b=nNrIWLgvXU7RRpAXoHx6Q6OkVrYNI4XOVkb6OWaJ7FWO5q1PuTU
        ANIg/n/CeXehrsYFfqB7qhd6JCyGr1z6WVnNNbrYfvP/rZuokRLNoIUChaU0DeeP
        psaD7w8iouexrqpwuSZnGttK2ApGpsLAQlFxc9x7OmdfombZsnBEmG58=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fRCzmCLd_3Ig; Fri, 16 Aug 2019 19:51:19 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id BCD8D42EE5;
        Fri, 16 Aug 2019 19:51:12 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:12 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: [PATCH v5 18/23] powerpc/pci: Handle BAR movement
Date:   Fri, 16 Aug 2019 19:50:56 +0300
Message-ID: <20190816165101.911-19-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190816165101.911-1-s.miroshnichenko@yadro.com>
References: <20190816165101.911-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pcibios_rescan_prepare()/_done() hooks for the powerpc platform. Now if
the device's driver supports movable BARs, pcibios_rescan_prepare() will be
called after the device is stopped, and pcibios_rescan_done() - before it
resumes. There are no memory requests to this device between the hooks, so
it it safe to rebuild the EEH address cache during that.

CC: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 arch/powerpc/kernel/pci-hotplug.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
index 0b0cf8168b47..18cf13bba228 100644
--- a/arch/powerpc/kernel/pci-hotplug.c
+++ b/arch/powerpc/kernel/pci-hotplug.c
@@ -144,3 +144,13 @@ void pci_hp_add_devices(struct pci_bus *bus)
 	pcibios_finish_adding_to_bus(bus);
 }
 EXPORT_SYMBOL_GPL(pci_hp_add_devices);
+
+void pcibios_rescan_prepare(struct pci_dev *pdev)
+{
+	eeh_addr_cache_rmv_dev(pdev);
+}
+
+void pcibios_rescan_done(struct pci_dev *pdev)
+{
+	eeh_addr_cache_insert_dev(pdev);
+}
-- 
2.21.0

