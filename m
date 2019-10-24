Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 266B1E396F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405899AbfJXRMn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:12:43 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:48758 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2405931AbfJXRMm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:12:42 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 9526343B0D;
        Thu, 24 Oct 2019 17:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937160; x=1573751561; bh=7LK5j1jdEBLIX2jiqRm58ICC7aVyOZzOenw
        2Gw9gTSA=; b=gtqnnE4Ry6yu+htTvQwLZWM8c+2+3hPyIIy7LlPS7TK/t2ozV62
        y5Ts5++ZhXMeiar6dq19hc7mvdMU3sFoODdMKuNQ85+OsYxdDupKNXfkGr2Agwpv
        uzAim+PBfw9VVQwKIwRqdyhLKvx5IDabVzergkOvVQPxllGa09HClX2s=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rwaLFxmMzZHi; Thu, 24 Oct 2019 20:12:40 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8DA9843130;
        Thu, 24 Oct 2019 20:12:39 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:12:39 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH v6 02/30] PCI: Enable bridge's I/O and MEM access for hotplugged devices
Date:   Thu, 24 Oct 2019 20:12:00 +0300
Message-ID: <20191024171228.877974-3-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
References: <20191024171228.877974-1-s.miroshnichenko@yadro.com>
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
index 44d0d12c80cf..e85dc63c73fd 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1650,6 +1650,14 @@ static void pci_enable_bridge(struct pci_dev *dev)
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
2.23.0

