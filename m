Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5172990615
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2019 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfHPQvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Aug 2019 12:51:12 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:51280 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfHPQvM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 16 Aug 2019 12:51:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 210C042ED6;
        Fri, 16 Aug 2019 16:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1565974270; x=1567788671; bh=DvT4qGp6HX+GCbOTr3FGSZxLc+qwVjkTFT9
        Ui2jCv7g=; b=gsfu+uG1Z8jcn3sbgEKbLBVMfDD37TBQqXIlQmyNOB6p786Kp6N
        csT9uXjxwtsMAkPEZs0r+oC+JU8f4j0zT35r3v71+jNd51uF0IZOZzcf7sQ7Ii1G
        VS8xieXd49SGDE7c4QlitMNKlMQSzfwQLXtdGskArdKCI1fwekmDY1zQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6HvuoHKhq8Cm; Fri, 16 Aug 2019 19:51:10 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 10A32412D6;
        Fri, 16 Aug 2019 19:51:10 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.60) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 16
 Aug 2019 19:51:08 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v5 02/23] PCI: Enable bridge's I/O and MEM access for hotplugged devices
Date:   Fri, 16 Aug 2019 19:50:40 +0300
Message-ID: <20190816165101.911-3-s.miroshnichenko@yadro.com>
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

The PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits of the bridge must be
updated not only when enabling the bridge for the first time, but also if a
hotplugged device requests these types of resources.

Originally these bits were set by the pci_enable_device_flags() only, which
exits early if the bridge is already pci_is_enabled(). So if the bridge was
empty initially (an edge case), then hotplugged devices fail to IO/MEM.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e7f8c354e644..61d951766087 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1652,6 +1652,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
 		pci_enable_bridge(bridge);
 
 	if (pci_is_enabled(dev)) {
+		int i, bars = 0;
+
+		for (i = PCI_BRIDGE_RESOURCES; i < DEVICE_COUNT_RESOURCE; i++) {
+			if (dev->resource[i].flags & (IORESOURCE_MEM | IORESOURCE_IO))
+				bars |= (1 << i);
+		}
+		do_pci_enable_device(dev, bars);
+
 		if (!dev->is_busmaster)
 			pci_set_master(dev);
 		mutex_unlock(&dev->enable_mutex);
-- 
2.21.0

