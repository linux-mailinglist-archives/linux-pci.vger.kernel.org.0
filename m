Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC71BAC83
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 20:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgD0SY3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 14:24:29 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53238 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgD0SY2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 14:24:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id BA3BB4C86E;
        Mon, 27 Apr 2020 18:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1588011865; x=1589826266; bh=ww1JbFd15j11fFK4QC8cPsAS5VzoDQpG9GO
        LrElSSqI=; b=FoJOQdekthER0v2d/kyah+zp6IxhuTgtHo5kVOrybKR85fXGFbE
        gw0TPxIPaFMXWdF6wbfd7QORA78iI4nO8DxmTc5r2x6wu8m7NmUlU3cRyCPiTK4S
        duxSvLSY/WDC4hLCIbRsGyTnn+o0svNaTRfu1ATuZO0+mo3y3cLgWdew=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vCA71xEwWLje; Mon, 27 Apr 2020 21:24:25 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8238C4C667;
        Mon, 27 Apr 2020 21:24:13 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 27
 Apr 2020 21:24:14 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v8 22/24] PCI: hotplug: Enable the movable BARs feature by default
Date:   Mon, 27 Apr 2020 21:23:56 +0300
Message-ID: <20200427182358.2067702-23-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
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

This is the last patch in the series which implements the essentials of the
movable BARs feature, so it is turned on by default now. Tested on Intel
and AMD machines with "pci=pcie_bus_peer2peer" command line argument.

In case of problems it is still can be overridden by the following command
line option:

  pcie_movable_bars=off

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ae07991edff..4aa6c22264a3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -79,7 +79,7 @@ static void pci_dev_d3_sleep(struct pci_dev *dev)
 int pci_domains_supported = 1;
 #endif
 
-bool pci_can_move_bars;
+bool pci_can_move_bars = true;
 
 #define DEFAULT_CARDBUS_IO_SIZE		(256)
 #define DEFAULT_CARDBUS_MEM_SIZE	(64*1024*1024)
-- 
2.24.1

