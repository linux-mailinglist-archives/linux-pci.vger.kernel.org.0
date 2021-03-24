Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A486634A49D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 10:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCZJhM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 05:37:12 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:59983 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhCZJhD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 05:37:03 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210326093701epoutp0252e5ad648c170c4b381eecc2f71b9f57~v2toUdKKY2100121001epoutp02p
        for <linux-pci@vger.kernel.org>; Fri, 26 Mar 2021 09:37:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210326093701epoutp0252e5ad648c170c4b381eecc2f71b9f57~v2toUdKKY2100121001epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616751421;
        bh=hxHXp6PeFmfwJxhC51xr7jOS0CvxIZzcuhvqoRIdIoY=;
        h=From:To:Cc:Subject:Date:References:From;
        b=NzjKLmCfwxm5+swbdcj36hMuiiRJODvGQlye6vmgT1Y0o+YXs4FtwDzRgTxHsWaLG
         sRdNWNLjlV2K4eJTcGkOu6q8JEp8p68LRGnpphja7qsFt90eW/goRfDu1F9SFy2z5x
         3/tHveYG6A/clraEdsAoiL7EM8m/cT9RKb7MVVd0=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210326093659epcas5p318af0671c516bc2e17b4a202fa47783a~v2tmyN0O52571125711epcas5p3v;
        Fri, 26 Mar 2021 09:36:59 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.CD.41008.B3BAD506; Fri, 26 Mar 2021 18:36:59 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20210324101555epcas5p1b5c8ff4d99b045b94f820c2151800127~vP9B0vIAg1046710467epcas5p1g;
        Wed, 24 Mar 2021 10:15:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210324101555epsmtrp1347a89b34131b9c8ca40757871367bea~vP9Bz2m9F1863418634epsmtrp1M;
        Wed, 24 Mar 2021 10:15:55 +0000 (GMT)
X-AuditID: b6c32a4b-661ff7000001a030-fb-605dab3bca2b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.DD.33967.B511B506; Wed, 24 Mar 2021 19:15:55 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210324101553epsmtip14886026cd630a4b503948d646d4664fd~vP9AIC2nm1129011290epsmtip1y;
        Wed, 24 Mar 2021 10:15:53 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     p.rajanbabu@samsung.com, lorenzo.pieralisi@arm.com, kishon@ti.com,
        bhelgaas@google.com, niyas.ahmed@samsung.com, hari.tv@samsung.com,
        l.mehra@samsung.com, pankaj.dubey@samsung.com,
        Shradha Todi <shradha.t@samsung.com>,
        Sriram Dash <dash.sriram@gmail.com>
Subject: [PATCH v5] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Wed, 24 Mar 2021 15:46:09 +0530
Message-Id: <20210324101609.79278-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPIsWRmVeSWpSXmKPExsWy7bCmuq716tgEg0fHNS2WNGVYLLu0mdHi
        47SVTBYXnvawWdx5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu0Xv4VoHHo81
        89YweuycdZfdY8GmUo++LasYPY7f2M7k8XmTXABbFJdNSmpOZllqkb5dAlfGjimv2QoOiFYs
        OuTcwLhZqIuRk0NCwETi+qy/7F2MXBxCArsZJW7//8MM4XxilLjXsJERwvnGKHF+zz0ghwOs
        ZepbX4j4XkaJzfsPMUE4LUwSD76uYwKZyyagJdH4tYsZxBYRsJY43L6FDcRmFuhgktizIATE
        FhYIk3h25D0jiM0ioCoxdfcmdpAFvAJWEo9vpUOcJy+xesMBsIskBG6xS5xeOJMNIuEicerw
        PxYIW1ji1fEt7BC2lMTL/jYoO19i6oWnLBBHV0gs76mDCNtLHLgyByzMLKApsX6XPkRYVmLq
        KYjrmQX4JHp/P2GCiPNK7JgHYytLfPm7B2qrpMS8Y5dZIWwPiY8zP4JtFRKIlXh68g3TBEbZ
        WQgbFjAyrmKUTC0ozk1PLTYtMM5LLdcrTswtLs1L10vOz93ECE4TWt47GB89+KB3iJGJg/EQ
        owQHs5IIb5JvTIIQb0piZVVqUX58UWlOavEhRmkOFiVx3h0GD+KFBNITS1KzU1MLUotgskwc
        nFINTD55mocT7rQHt2Rl32j5rCQUdvFE3r2LPfqKa/KT9txmfn3hXWaIj4wcQ8KPV9Mk4vsa
        dbstg/Y/uys09ZPChW9Pdv87X9D5959uOJdV4v+p8c02Syqm9e71v13tWW5xt4vLLpVx4wUz
        vh0BDAzrq2P5OKo3z3vmu+qS4orzt/epJT49qCP+ZZ9WVJ/X1kMb9lW+CvrG86fYsf//He43
        7ibTuXIjEt/+WXemeFtExt571ZOcl+7Tr9m3xMtZ9KHJwqpdFwpelT6vMVNhizgob/dt9/mw
        5+be7yKva09fcDFZ+NCtVR4d1179cW00Uk5W+bZ8fa3tBr1F34JPbO9Ru/NnJpN0xCwe89U/
        na8YJyuxFGckGmoxFxUnAgC4s1LGggMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLMWRmVeSWpSXmKPExsWy7bCSnG60YHSCQd8ZDYslTRkWyy5tZrT4
        OG0lk8WFpz1sFnee32C0uLxrDpvF2XnH2Sze/H7BbvFkyiNWi6Mbgy0Wbf3CbtF7uNaBx2PN
        vDWMHjtn3WX3WLCp1KNvyypGj+M3tjN5fN4kF8AWxWWTkpqTWZZapG+XwJWxY8prtoIDohWL
        Djk3MG4W6mLk4JAQMJGY+ta3i5GLQ0hgN6PE0rv32bsYOYHikhKfL65jgrCFJVb+e84OUdTE
        JHFoyzsWkASbgJZE49cuZhBbRMBW4v6jyawgRcwCU5gkHn48wAaSEBYIkfi68SCYzSKgKjF1
        9yZ2kM28AlYSj2+lQyyQl1i94QDzBEaeBYwMqxglUwuKc9Nziw0LDPNSy/WKE3OLS/PS9ZLz
        czcxgsNOS3MH4/ZVH/QOMTJxMB5ilOBgVhLhbQmPSBDiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6HrZLyQQHpiSWp2ampBahFMlomDU6qBaZWdy52pmx5WvHBcvt+hirem6xXTugXC9dFhfy0y
        K9YfFZtgKzuX+fX57HlcJd/a3TTCTT5edMgzmGEgdmHzh7mTFNRzty3PvfeTWyJlT+bDa4mG
        rflv5yfvt+pxU73xKjNt2bsOgfnLjFKnM62VlH0qOs1ZTWHXy/Vmzky7Cq57e6wSOnoxXuZ6
        7535Cw5MfOf5882lTbrFtyV0r/gtM5g384ro2uvVmv3u31NCT6287LTSecZX9Q+lEpwzE2+c
        Xuxacyl2nuh/i3v/NXlldv4UOLj7uMSlGYpaxezXp50I5Lff2KC/0zfz/s77GXdXvL09uSd1
        5kwTs+9rm6e4R5382qT0qmvpxb+Pt67hLeVVYinOSDTUYi4qTgQAMF9lZqoCAAA=
X-CMS-MailID: 20210324101555epcas5p1b5c8ff4d99b045b94f820c2151800127
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210324101555epcas5p1b5c8ff4d99b045b94f820c2151800127
References: <CGME20210324101555epcas5p1b5c8ff4d99b045b94f820c2151800127@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

get_features ops of pci_epc_ops may return NULL, causing NULL pointer
dereference in pci_epf_test_alloc_space function. Let us add a check for
pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid
any such NULL pointer dereference and return -ENOTSUPP in case
pci_epc_feature is not found.

When the patch is not applied and EPC features is not implemented in the
platform driver, we see the following dump due to kernel NULL pointer
dereference.

Call trace:
 pci_epf_test_bind+0xf4/0x388
 pci_epf_bind+0x3c/0x80
 pci_epc_epf_link+0xa8/0xcc
 configfs_symlink+0x1a4/0x48c
 vfs_symlink+0x104/0x184
 do_symlinkat+0x80/0xd4
 __arm64_sys_symlinkat+0x1c/0x24
 el0_svc_common.constprop.3+0xb8/0x170
 el0_svc_handler+0x70/0x88
 el0_svc+0x8/0x640
Code: d2800581 b9403ab9 f9404ebb 8b394f60 (f9400400)
---[ end trace a438e3c5a24f9df0 ]---

Fixes: 2c04c5b8eef79 ("PCI: pci-epf-test: Use pci_epc_get_features() to get EPC features")
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
Changes w.r.t. v4:
  https://lkml.org/lkml/2021/1/12/815
  - Changed commit message to remove time stamp as suggested by Lorenzo
  - Since deference in not actually happening in bind function, mentioned
    the same in the commit message as suggested by Leon.

 drivers/pci/endpoint/functions/pci-epf-test.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index c0ac4e9cbe72..bc35b3566be6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -833,15 +833,18 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return -EINVAL;
 
 	epc_features = pci_epc_get_features(epc, epf->func_no);
-	if (epc_features) {
-		linkup_notifier = epc_features->linkup_notifier;
-		core_init_notifier = epc_features->core_init_notifier;
-		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
-		if (test_reg_bar < 0)
-			return -EINVAL;
-		pci_epf_configure_bar(epf, epc_features);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
 	}
 
+	linkup_notifier = epc_features->linkup_notifier;
+	core_init_notifier = epc_features->core_init_notifier;
+	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+	if (test_reg_bar < 0)
+		return -EINVAL;
+	pci_epf_configure_bar(epf, epc_features);
+
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-- 
2.17.1

