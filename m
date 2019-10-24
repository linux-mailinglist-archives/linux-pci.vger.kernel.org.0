Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5543E39B5
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2019 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440025AbfJXRWG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Oct 2019 13:22:06 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49456 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2440024AbfJXRWG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Oct 2019 13:22:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 89760437F8;
        Thu, 24 Oct 2019 17:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1571937724; x=1573752125; bh=m98a7Y6dEiqX/LFqMb+Uk9Qflv4ygcMGKHQ
        ygeUzUCY=; b=G/XVRpc0QhENdTOEcKCkEKAnaWGQBuc4Xkq+d1tldPWm0Mkmlj0
        5HRQLD/WFMmd9r9WeoxxkWmAMyKZea0+A1O6aVT3kGsfyiWgeZVPlsnn9Lc6izcE
        DMZad8UCccPpds85V2JfsWvHNiE07MCG3AXXQ6yJZccndzS/yJqkjhBs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jh3zB7iBOJ2A; Thu, 24 Oct 2019 20:22:04 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8776F42F15;
        Thu, 24 Oct 2019 20:22:04 +0300 (MSK)
Received: from NB-148.yadro.com (172.17.15.136) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 24
 Oct 2019 20:22:04 +0300
From:   Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
To:     <linux-pci@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
CC:     Bjorn Helgaas <helgaas@kernel.org>, <linux@yadro.com>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: [PATCH RFC 01/11] PCI: sysfs: Nullify freed pointers
Date:   Thu, 24 Oct 2019 20:21:47 +0300
Message-ID: <20191024172157.878735-2-s.miroshnichenko@yadro.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
References: <20191024172157.878735-1-s.miroshnichenko@yadro.com>
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

After hotplugging a bridge the PCI topology will be changed: buses may have
their numbers changed. In this case all the affected sysfs entries/symlinks
must be recreated, because they have BDF address in their names.

Set the freed pointers to NULL, so the !NULL checks will be satisfied when
its time to recreate the sysfs entries.

Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
---
 drivers/pci/pci-sysfs.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 793412954529..a238935c1193 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1129,12 +1129,14 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr[i] = NULL;
 		}
 
 		res_attr = pdev->res_attr_wc[i];
 		if (res_attr) {
 			sysfs_remove_bin_file(&pdev->dev.kobj, res_attr);
 			kfree(res_attr);
+			pdev->res_attr_wc[i] = NULL;
 		}
 	}
 }
@@ -1175,8 +1177,11 @@ static int pci_create_attr(struct pci_dev *pdev, int num, int write_combine)
 	res_attr->size = pci_resource_len(pdev, num);
 	res_attr->private = (void *)(unsigned long)num;
 	retval = sysfs_create_bin_file(&pdev->dev.kobj, res_attr);
-	if (retval)
+	if (retval) {
 		kfree(res_attr);
+		if (pdev->res_attr[num] == res_attr)
+			pdev->res_attr[num] = NULL;
+	}
 
 	return retval;
 }
-- 
2.23.0

