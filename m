Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7499590627
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfHPQvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:22 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51430 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727178AbfHPQvV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 2C49F42EEA;
        Fri, 16 Aug 2019 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974280; x=1567788681; bh=VTRm7nHJv8AF5BKbIOmvCTB0nIvM/7ZSDko
        5kPpBymk=; b=ojDz65djYSmRHc6RhKPhPNBx/+X4sgoTL+0AGdmGhmwLp6d7bB4
        oX1MPPfVRl8wCvcHCZtrzzGyeY57LMmmKgZiPFF1iW1qNAAcPPF0wfmBSusVg40h
        BoeF2rmBZSLTlZQx5rk5EdWPJ2VMqa8YcCikkNXjcD0V4w1FYjNpKepE=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cPn10qYAlOtF; Fri, 16 Aug 2019 19:51:20 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 5D1C242EEB;
        Fri, 16 Aug 2019 19:51:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:12 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 20/23] PCI: hotplug: movable BARs: Enable the feature by default
Date:   Fri, 16 Aug 2019 19:50:58 +0300
Message-ID: <20190816165101.911-21-s.miroshnichenko@yadro.com>
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

This is the last patch in the series which implements the essentials of the
Movable BARs feature, so it is turned by default now. Tested on:

 - x86_64 with "pci=realloc,assign-busses,use_crs,pcie_bus_peer2peer"
   command line argument;
 - POWER8 PowerNV+PHB3 ppc64le with "pci=realloc,pcie_bus_peer2peer".

In case of problems it is still can be overridden by the following command
line option:

    pcie_movable_bars=off

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci-driver.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index d11909e79263..a8124e47bf6e 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1688,8 +1688,6 @@ static int __init pci_driver_init(void)
 {
 	int ret;
 
-	pci_add_flags(PCI_IMMOVABLE_BARS);
-
 	ret = bus_register(&pci_bus_type);
 	if (ret)
 		return ret;
-- 
2.21.0

