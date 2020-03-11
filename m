Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226C41815EC
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 11:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCKKes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 06:34:48 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:61399 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgCKKer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Mar 2020 06:34:47 -0400
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200311103445epoutp01242e39b4885a5322d9419f638f286725~7OXjktFut0756307563epoutp01E
        for <linux-pci@vger.kernel.org>; Wed, 11 Mar 2020 10:34:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200311103445epoutp01242e39b4885a5322d9419f638f286725~7OXjktFut0756307563epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583922885;
        bh=62Jjuc6/Y2f5Kkiso4Xvn+Oim+hE7rByIazg5bBNNFc=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Fa1Mst/DFQzsQQ3rhgKg2CdAEy32LGEScI0fBVn2DAiB7K13uyksgGk1UjbPrJurc
         4HKnRmcMSjm0aijbWYWqGpxSiKr8Q3PLVfVMq16vkd9xLpILdii2bTkOK/h2jwLR0O
         hN14+c3kYXQstHoDPX+KrvHqo8DaXKErf0pqzzJ4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200311103443epcas5p12d9bfa8ad90323226af85bebe48394e7~7OXiK0hBp2624126241epcas5p12;
        Wed, 11 Mar 2020 10:34:43 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.21.19726.3CEB86E5; Wed, 11 Mar 2020 19:34:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132~7OXhpAlqY0906409064epcas5p2b;
        Wed, 11 Mar 2020 10:34:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200311103443epsmtrp2f3a4b66906b00296d07588e581cb6a9a~7OXhoUU822380023800epsmtrp2V;
        Wed, 11 Mar 2020 10:34:43 +0000 (GMT)
X-AuditID: b6c32a49-7a9ff70000014d0e-a9-5e68bec380a4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1E.A6.06569.3CEB86E5; Wed, 11 Mar 2020 19:34:43 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200311103438epsmtip2c7aa065bd8c5b47fe95f57da41cb28f3~7OXc4Eu6C2573525735epsmtip2k;
        Wed, 11 Mar 2020 10:34:37 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        pankaj.dubey@samsung.com, Shradha Todi <shradha.t@samsung.com>,
        Sriram Dash <sriram.dash@samsung.com>
Subject: [PATCH] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Wed, 11 Mar 2020 15:58:52 +0530
Message-Id: <20200311102852.5207-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmhu7hfRlxBssf6lgsacqwuPC0h83i
        8q45bBZn5x1ns3jz+wW7xaKtX9gteg/XWtxYz+7A4bFm3hpGjwWbSj36tqxi9Dh+YzuTx+dN
        cgGsUVw2Kak5mWWpRfp2CVwZrx81MBWc4a1Yt2I/UwPjE+4uRg4OCQETiRl35boYuTiEBHYz
        Smz4d4IFwvnEKHF8ew+U841RorFjF2MXIydYx+ujV9ghEnsZJR4cuwbltDBJXLvzFayKTUBL
        ovFrFzOILSJgLdHwahUrSBGzwBpGiVVLV4ElhAWCJZY/essKYrMIqEqs+XCYDcTmFbCUmLX2
        JzvEOnmJ1RsOMIM0Swg0skm8XzoPKuEi8e77elYIW1ji1fEtUHEpic/v9rJB2PkSUy88ZYH4
        tEJieU8dRNhe4sCVOWBhZgFNifW79EHCzAJ8Er2/nzBBVPNKdLQJQVQrS3z5u4cFwpaUmHfs
        MtRSD4mvEy4wgdhCArESU1s/sk9glJmFMHQBI+MqRsnUguLc9NRi0wLDvNRyveLE3OLSvHS9
        5PzcTYzgCNfy3ME465zPIUYBDkYlHt4XdelxQqyJZcWVuYcYJTiYlUR44+WBQrwpiZVVqUX5
        8UWlOanFhxilOViUxHknsV6NERJITyxJzU5NLUgtgskycXBKNTDmai7f66iwxCVuaVah68zo
        vOJbk4NOtZU9Y5x1+Vl9+JP4CeGpvNt4TWZUzpbaVVYU3l34ccpZy/6/2pPd332f7LXlckzN
        sbZkg5LsVuks+4eRcu9PX7re5vt1d8fNl9ZrZT+oSi4Mq4mbWxpeEhu7nHXGiYquRV57T4So
        pb3jyyk8xDKvNESJpTgj0VCLuag4EQBTPQyR7AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJXvfwvow4gyuneSyWNGVYXHjaw2Zx
        edccNouz846zWbz5/YLdYtHWL+wWvYdrLW6sZ3fg8Fgzbw2jx4JNpR59W1Yxehy/sZ3J4/Mm
        uQDWKC6blNSczLLUIn27BK6M148amArO8FasW7GfqYHxCXcXIyeHhICJxOujV9i7GLk4hAR2
        M0qsW7eMHSIhKfH54jomCFtYYuW/51BFTUwSs1/uYwRJsAloSTR+7WIGsUUEbCUa/nYwgxQx
        C2xilHh6uYsNJCEsECjR03odzGYRUJVY8+EwmM0rYCkxa+1PqG3yEqs3HGCewMizgJFhFaNk
        akFxbnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcChpae1gPHEi/hCjAAejEg/vi7r0OCHWxLLi
        ytxDjBIczEoivPHyQCHelMTKqtSi/Pii0pzU4kOM0hwsSuK88vnHIoUE0hNLUrNTUwtSi2Cy
        TBycUg2Mui7/tTKrHLPjLrl/zNuWeLXQ2k5CxFtr9vFzUu3pT7OOc1z//k8rtCp3zvneI3ns
        Ec+e6MVZrXgjm+GS37vWuuLelE9KJ2N1dJJ2Ptavf7D+77e6V5Nzpi8VKZ8YdIvrtr3YljV+
        TpaP3yffsjc4tG+DsldH0M/FQav/9C5ISRBffW6v/5bbSizFGYmGWsxFxYkA29JrryECAAA=
X-CMS-MailID: 20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132
References: <CGME20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132@epcas5p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

get_features ops of pci_epc_ops may return NULL, causing NULL pointer
dereference in pci_epf_test_bind function. Let us add a check for
pci_epc_feature pointer in pci_epf_test_bind before we access it to
avoid any such NULL pointer dereference and return -ENOTSUPP in case
pci_epc_feature is not found.

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c9121b1b9fa9..af4537a487bf 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -510,14 +510,17 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return -EINVAL;
 
 	epc_features = pci_epc_get_features(epc, epf->func_no);
-	if (epc_features) {
-		linkup_notifier = epc_features->linkup_notifier;
-		msix_capable = epc_features->msix_capable;
-		msi_capable = epc_features->msi_capable;
-		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
-		pci_epf_configure_bar(epf, epc_features);
+	if (!epc_features) {
+		dev_err(dev, "epc_features not implemented\n");
+		return -ENOTSUPP;
 	}
 
+	linkup_notifier = epc_features->linkup_notifier;
+	msix_capable = epc_features->msix_capable;
+	msi_capable = epc_features->msi_capable;
+	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+	pci_epf_configure_bar(epf, epc_features);
+
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-- 
2.17.1

