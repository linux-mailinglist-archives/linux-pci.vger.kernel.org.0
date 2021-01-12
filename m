Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C122F33AA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbhALPJz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 10:09:55 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:44266 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbhALPJy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 10:09:54 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210112150911epoutp0313cc1a25cb930639fe39567d1c863fc0~ZhJ0Gva8W2462824628epoutp03E
        for <linux-pci@vger.kernel.org>; Tue, 12 Jan 2021 15:09:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210112150911epoutp0313cc1a25cb930639fe39567d1c863fc0~ZhJ0Gva8W2462824628epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1610464151;
        bh=u0BvEO9atwxSB4/hI99enjFl2P1vLmAKRGdyk/BKm7w=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aV5g88+PsO/7jE5M0FJ7mAY1rjhw0RdnXHEz0QalAYi5397gu8UEFRtTiIBoCYekt
         4Dx/I+mFpdfKacxVudscdfv3I+diugBoW5q8inGws69lPxqXhtLe3kJYBJn18G36CE
         fonON5BzzPN7LCQoLC55ewyBHNtwCbGiXUeInpB0=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210112150910epcas5p323697deb48e837ddf7d9450903a56964~ZhJzTLRfE2340623406epcas5p3D;
        Tue, 12 Jan 2021 15:09:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.3B.50652.69BBDFF5; Wed, 13 Jan 2021 00:09:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c~ZgPpVYDKz2419824198epcas5p4d;
        Tue, 12 Jan 2021 14:02:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210112140234epsmtrp1daf670ec05288d67e2947e2945b2692e~ZgPpUkJpU1138511385epsmtrp1e;
        Tue, 12 Jan 2021 14:02:34 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-e6-5ffdbb9607e2
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E6.6A.08745.AFBADFF5; Tue, 12 Jan 2021 23:02:34 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210112140232epsmtip1dd05c46eb52829da09e5d97069e9d2b6~ZgPnHe6Gi1104111041epsmtip1L;
        Tue, 12 Jan 2021 14:02:31 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v4] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Tue, 12 Jan 2021 19:32:25 +0530
Message-Id: <1610460145-14645-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmuu603X/jDdo/6Vgsacqw+DhtJZPF
        hac9bBZ3nt9gtLi8aw6bxdl5x9ks3vx+wW7xZMojVoujG4MtFm39wm7Re7jW4sZ6dgcejzXz
        1jB6LNhU6tG3ZRWjx/Eb25k8Pm+SC2CN4rJJSc3JLEst0rdL4MqYc3Ebc8El4Yqb76ewNjB+
        Fuhi5OSQEDCR+Lf0A2sXIxeHkMBuRomtTRtYQRJCAp8YJRae04RIfGaUuDVzBxtMx9nPT1gg
        ErsYJRZ9W8MG4bQwSbxpv88CUsUmoCXR+LWLGcQWEbCWONy+BayIWeAPo0TP/QZGkISwQJjE
        i1+fwPaxCKhKHPnXBBbnFXCVaPvUxAqxTk7i5rlOZgj7FLvE4W+CELaLxOyu7+wQtrDEq+Nb
        oGwpiZf9bVB2vsTUC0+BDuIAsisklvfUQYTtJQ5cmQMWZhbQlFi/Sx8iLCsx9dQ6JhCbWYBP
        ovf3EyaIOK/EjnkwtrLEl797WCBsSYl5xy5DXekhsWrdNmjIxUqs6lrENIFRdhbChgWMjKsY
        JVMLinPTU4tNC4zyUsv1ihNzi0vz0vWS83M3MYLTg5bXDsaHDz7oHWJk4mA8xCjBwawkwlvU
        /TdeiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8OgwfxQgLpiSWp2ampBalFMFkmDk6pBiYGy6b2
        9uajuVlBN71LJeU4ssp0TL9IpOf/Kek0/8NZ/u07i7WJ4HX/uA3dx+R3Ol1n3fF+yx1ZR922
        hY9/m0Wtun46MiTNlvOc0/2dhk9O3d+b9rriy5S1VvPY+1Yr9fpYvZiU8VbQ316k0eBMRupb
        1eOnplUL/5uiV+46c7vxOXUtAb2p17iuLZzu+0fwugK/2f2CFQscbEW0uS7kz3uVtnNXXJbE
        lYnvE9w72YWYZ/S+XpGju34637F9O24J8p/aX8W9ycA9gtX0DNfBMw+e7rv2yLyMn1nvzZI5
        t2+czP267ISqiYzqMq6/TBMic2qMn+3vdDm5PmOL7tSq/Y3a8q0vrt3PsVPMVOtYfFqJpTgj
        0VCLuag4EQDw4OoLfgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSnO6v1X/jDT7f5rNY0pRh8XHaSiaL
        C0972CzuPL/BaHF51xw2i7PzjrNZvPn9gt3iyZRHrBZHNwZbLNr6hd2i93CtxY317A48Hmvm
        rWH0WLCp1KNvyypGj+M3tjN5fN4kF8AaxWWTkpqTWZZapG+XwJUx5+I25oJLwhU3309hbWD8
        LNDFyMkhIWAicfbzE5YuRi4OIYEdjBKHf81mh0hISny+uI4JwhaWWPnvOTtEUROTxNez65hB
        EmwCWhKNX7vAbBEBW4n7jyazghQxC3QwSfy+eg0sISwQInHibQOYzSKgKnHkXxMjiM0r4CrR
        9qmJFWKDnMTNc53MExh5FjAyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECA44La0d
        jHtWfdA7xMjEwXiIUYKDWUmEt6j7b7wQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNIT
        S1KzU1MLUotgskwcnFINTLO9Ll5x/e3y8uGKp4z/y+ymnGdODpC2XrNLPM9380UDY9X/eSVZ
        T3zePLKcpPU08napwZeyRzo8Iiw8PkYNwcYmHAzKAtc+aWS9tTGvXlsSVb9Yu+lJyf530k8v
        zlBXfuolP7/tlnC299UJXLYO7dPuHrmm4POBQ/xZ99ut6Rc23OJ6Y2VysdzIVTH0A3/sJbfa
        wimnmrhlDPhWV6ufZ715N+rlvGspIuryG1sXHnV+3H06rZl7yYMVn5cpOvC6TmfeXyO4R+tT
        3/L7s1f+upQRuiyfce/msnV+S7K+Rsy3a9j164K+tpvrVh8Ts0DB6OJ17EbHwrnT/uVI/FzD
        8dKEddc3JtM6Gw73+0d2KrEUZyQaajEXFScCAKflqyWnAgAA
X-CMS-MailID: 20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c
References: <CGME20210112140234epcas5p4f97e9cf12e68df9fb55d1270bd14280c@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

get_features ops of pci_epc_ops may return NULL, causing NULL pointer
dereference in pci_epf_test_bind function. Let us add a check for
pci_epc_feature pointer in pci_epf_test_bind before we access it to avoid
any such NULL pointer dereference and return -ENOTSUPP in case
pci_epc_feature is not found.

When the patch is not applied and EPC features is not implemented in the
platform driver, we see the following dump due to kernel NULL pointer
dereference.

[  105.135936] Call trace:
[  105.138363]  pci_epf_test_bind+0xf4/0x388
[  105.142354]  pci_epf_bind+0x3c/0x80
[  105.145817]  pci_epc_epf_link+0xa8/0xcc
[  105.149632]  configfs_symlink+0x1a4/0x48c
[  105.153616]  vfs_symlink+0x104/0x184
[  105.157169]  do_symlinkat+0x80/0xd4
[  105.160636]  __arm64_sys_symlinkat+0x1c/0x24
[  105.164885]  el0_svc_common.constprop.3+0xb8/0x170
[  105.169649]  el0_svc_handler+0x70/0x88
[  105.173377]  el0_svc+0x8/0x640
[  105.176411] Code: d2800581 b9403ab9 f9404ebb 8b394f60 (f9400400)
[  105.182478] ---[ end trace a438e3c5a24f9df0 ]---

Fixes: 2c04c5b8eef79 ("PCI: pci-epf-test: Use pci_epc_get_features() to get EPC features")
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e4e51d8..1b30774 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -830,13 +830,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return -EINVAL;
 
 	epc_features = pci_epc_get_features(epc, epf->func_no);
-	if (epc_features) {
-		linkup_notifier = epc_features->linkup_notifier;
-		core_init_notifier = epc_features->core_init_notifier;
-		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
-		pci_epf_configure_bar(epf, epc_features);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
 	}
 
+	linkup_notifier = epc_features->linkup_notifier;
+	core_init_notifier = epc_features->core_init_notifier;
+	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
+	pci_epf_configure_bar(epf, epc_features);
+
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
 
-- 
2.7.4

