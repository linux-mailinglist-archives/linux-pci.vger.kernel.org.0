Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A09B914CD65
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 16:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgA2PaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 10:30:03 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:55864 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgA2PaD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 10:30:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 14DA847631;
        Wed, 29 Jan 2020 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1580311801; x=1582126202; bh=Dxswjjywe+xbcUcUpQxrsAnQF3ejBIGGFAC
        bdqzbCRM=; b=jlYE6faLTfcawA0GciYGayGwjbzkaEp8OjVHOMWtA7EYXkY0M1k
        e1qqCkpnNWZP55XcixG2gKcHFFXFkW/S3FQ16eeePPG8/JZmwE6lhQdUaoMWYSvk
        2YCBFSsiBojtklxUtfhL26Xn8HCWh0GZ4wiaKzhg6OekGPEHwtzg83cM=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RgKd-x6DstPL; Wed, 29 Jan 2020 18:30:01 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A34FF47614;
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
Subject: [PATCH v7 15/26] PCI: hotplug: Enable the movable BARs feature by default
Date:   Wed, 29 Jan 2020 18:29:26 +0300
Message-ID: <20200129152937.311162-16-s.miroshnichenko@yadro.com>
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
index 6741c7f111ac..db8cfec2baff 100644
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

