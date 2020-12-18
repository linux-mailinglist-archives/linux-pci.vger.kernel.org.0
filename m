Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37092DE861
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 18:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgLRRlv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 12:41:51 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:37900 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728147AbgLRRlu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Dec 2020 12:41:50 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 6F806413CD;
        Fri, 18 Dec 2020 17:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1608313268; x=1610127669; bh=W7zcvbVJmLFtBKGNQFYRu7td+56m3Kd/9dF
        l39M0Org=; b=iLUSPGXzahlGftaQ5771vVhjXgoB4UwPfqCxggAclgyA7P17OZb
        lTfsYmNUvb9g9gBnf/BFLw1BJ1lWyP1ntYvOHmbq9XgV1sRopRlyZVGHbigYyvKu
        rDDYDKUftOANmaNIDwxyD9TP79bhDfmrRwXiaWOdsQLITRJNzV+HHgT0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RBAXJFHrNrA4; Fri, 18 Dec 2020 20:41:08 +0300 (MSK)
Received: from T-EXCH-03.corp.yadro.com (t-exch-03.corp.yadro.com [172.17.100.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 73C7E412E1;
        Fri, 18 Dec 2020 20:41:07 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-03.corp.yadro.com
 (172.17.100.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 18
 Dec 2020 20:41:05 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, <linux@yadro.com>,
        Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v9 02/26] PCI: Ensure a bridge has I/O and MEM access for hot-added devices
Date:   Fri, 18 Dec 2020 20:39:47 +0300
Message-ID: <20201218174011.340514-3-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
References: <20201218174011.340514-1-s.miroshnichenko@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.15.136]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-03.corp.yadro.com (172.17.100.103)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During hot-adding a device, its bridge may be already pci_is_enabled(), but
without the I/O and/or MEM access bits, which may be required by this new
device: these bits are set during first enabling the bridge, and they must
be checked again.

When hot-adding to the following bridge:

  +-[0020:00]---00.0-[01-0d]----00.0-[02-0d]----04.0-[03-0d]--   <-   00.0

this patch sets up the MEM bit in the downstream port 0020:02:04.0, needed
for 0020:08:00.0:

  [ 1037.698206] pci 0020:00:00.0: PCI bridge to [bus 01-0d]
  [ 1037.698785] pci 0020:00:00.0:   bridge window [mem 0x3fe800000000-0x3fe8017fffff]
  [ 1037.698874] pci 0020:00:00.0:   bridge window [mem 0x240000000000-0x2400ffffffff 64bit pref]
  [ 1037.699002] pcieport 0020:02:04.0: enabling device (0545 -> 0547)
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  [ 1037.699114] pcieport 0020:03:00.0: enabling device (0540 -> 0542)
  [ 1037.699198] pciehp 0020:04:09.0:pcie204: Slot #41 AttnBtn+ PwrCtrl+ MRL- AttnInd+ PwrInd+ HotPlug+ Surprise- Interlock- NoCompl- LLActRep+
  [ 1037.699285] pciehp 0020:04:09.0:pcie204: Slot(41): Card present
  [ 1037.699346] pciehp 0020:04:09.0:pcie204: Slot(41): Already enabled

Signed-off-by: Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 076b908127fe..b7bbc462a0b3 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1868,6 +1868,10 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		pci_enable_bridge(bridge);
 
 	if (pci_is_enabled(dev)) {
+		retval = pci_reenable_device(dev);
+		if (retval)
+			pci_err(dev, "Error reenabling bridge, continuing\n");
+
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
 		mutex_unlock(&dev->enable_mutex);
-- 
2.24.1

