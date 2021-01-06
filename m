Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA93B2EBCCA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 11:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbhAFKwy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 05:52:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42200 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbhAFKwx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 05:52:53 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210106105211epoutp02d367bfc019d3005326e702a8b939b2bf~XnxtJHcqZ1858318583epoutp02h
        for <linux-pci@vger.kernel.org>; Wed,  6 Jan 2021 10:52:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210106105211epoutp02d367bfc019d3005326e702a8b939b2bf~XnxtJHcqZ1858318583epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609930331;
        bh=S5F4hqYTLpsu9Adtr3Hc5YMY+HoQSI660uecHx9eVrs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=o6UC2Pvrusu8HVCnXvI7eSsi7vg+nXbwZpYDvXY6qA1v0H+ysluSGLhEcEqQu+n59
         uXcrF+rW7cXBBDwCQxehSiRAQ8EFU6U3mW8Ab80w7i61v2BQY4PnOTI5jq/u5cSI+t
         tXgNJP1X6U/PBm+Nupod43NHFquP5B6Dax5cCqFw=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210106105210epcas5p3596faff7fde2384f6cebe2087f7e47be~XnxsqQvv40505705057epcas5p3B;
        Wed,  6 Jan 2021 10:52:10 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CF.B8.33964.A5695FF5; Wed,  6 Jan 2021 19:52:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210106103829epcas5p20a5c8aa2ae8bd6d8d555dad1aa265a1c~XnlvpW86v2797727977epcas5p2R;
        Wed,  6 Jan 2021 10:38:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210106103829epsmtrp12d6f4a4901baea3150fd47155c2e20bc~Xnlvof7P50070200702epsmtrp1Z;
        Wed,  6 Jan 2021 10:38:29 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-dc-5ff5965a9f95
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.DF.13470.52395FF5; Wed,  6 Jan 2021 19:38:29 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210106103827epsmtip1fa6f13763881b0f339c000bb8db10a15~Xnlt45sH62781227812epsmtip1I;
        Wed,  6 Jan 2021 10:38:27 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, kishon@ti.com, lorenzo.pieralisi@arm.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Wed,  6 Jan 2021 16:08:10 +0530
Message-Id: <1609929490-18921-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCmum7UtK/xBl9u6Fosacqw+DhtJZPF
        hac9bBZ3nt9gtLi8aw6bxdl5x9ks3vx+wW7xZMojVoujG4MtFm39wm7Re7jW4sZ6dgcejzXz
        1jB6LNhU6tG3ZRWjx/Eb25k8Pm+SC2CN4rJJSc3JLEst0rdL4Mpo3XeHpeCSSEXLrvVMDYy3
        BLsYOTkkBEwkjrRuZuxi5OIQEtjNKPH6+D92kISQwCdGiTMroiES3xgl/i1azgjT8XHaVBaI
        xF5GiSUNJ5kgnBYmidaeBSwgVWwCWhKNX7uYQWwRAWuJw+1b2ECKmAX+MEr03G8AGyUsECbx
        8c9KNhCbRUBV4srZjUwgNq+Aq8T0I4vYINbJSdw818kM0iwhcIpd4sKZmcwQCReJfxv6mSBs
        YYlXx7ewQ9hSEi/726DsfImpF54CXcQBZFdILO+pgwjbSxy4MgcszCygKbF+lz5EWFZi6ql1
        YBOZBfgken8/gZrOK7FjHoytLPHl7x4WCFtSYt6xy6wQtofErKP3GEFGCgnESvw+ETeBUXYW
        woIFjIyrGCVTC4pz01OLTQuM81LL9YoTc4tL89L1kvNzNzGC04OW9w7GRw8+6B1iZOJgPMQo
        wcGsJMJrcexLvBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeHQYP4oUE0hNLUrNTUwtSi2CyTByc
        Ug1MnlPv/Iqqcp/SXlybnSnewnVqjqhNdGBTwoHPwRyrlxl/NXpvsN/IX2Tvxe9WzcfOX7FM
        uV2ve4B3zwM1zguODTOObwnRESouO/fW/Wn9tJYky00axuYt29NXby0U65S/Z8W5Yue6HY2T
        3K59uHQ2xq7z1Otrzc9m34nfsSfw0PR9tneU+Bs3sJb9nPwv6GOEDocYY8B3g8Ync09Uz2h5
        cUBE7eDeXbfm+uzcEdxkv2bqp1+n+FN8mF5MEOZN7G+6M6PuVcg/iSUT9Zb23P3z7Lbq/Q13
        N0odND+1jjvp1oaTniX7jz3SnTHT3OXs3sUT9X5ap91jtNaS8zwVJpBWln5yh/XEaF6xF1Nc
        Tuz9E63EUpyRaKjFXFScCACLttJXfgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCLMWRmVeSWpSXmKPExsWy7bCSnK7q5K/xBism81osacqw+DhtJZPF
        hac9bBZ3nt9gtLi8aw6bxdl5x9ks3vx+wW7xZMojVoujG4MtFm39wm7Re7jW4sZ6dgcejzXz
        1jB6LNhU6tG3ZRWjx/Eb25k8Pm+SC2CN4rJJSc3JLEst0rdL4Mpo3XeHpeCSSEXLrvVMDYy3
        BLsYOTkkBEwkPk6bytLFyMUhJLCbUWL53rVMEAlJic8X10HZwhIr/z1nhyhqYpL4POsJO0iC
        TUBLovFrFzOILSJgK3H/0WRWkCJmgQ4mid9Xr4ElhAVCJD5+7wGbxCKgKnHl7EYwm1fAVWL6
        kUVsEBvkJG6e62SewMizgJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcMBpae5g
        3L7qg94hRiYOxkOMEhzMSiK8Fse+xAvxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2x
        JDU7NbUgtQgmy8TBKdXA5PrF4tls5jeHT6q8aSszXn9aJeDZ/ND+Asfnv81amiwj0mWvVvHP
        cngQ7/Yt+lS4aPyZP/cl5r9Yl9Mf9UPn6KuAoAVPLnQdzzjaKX2K/cTKCWUZvM1rDpwKz755
        1zCcRVtuq5g1S+ycEEWVjIeKR54u5lz11ltFeuFsU92jodzTfLbddnWNbloh2uN8lPWM1pXp
        v6TvB0xcEdn/esbpK78LZ4Y3/lyzQqNgTVZH0RYJLWV37jDdovde5lvbV+yKyLuxT5XJ4J70
        kcdR0duf2VzXXJt6N33HTp0fqRy/jFxtH3sF1E6s38jksFap7lGUpWL5bPEfjiK5uaGGsf31
        OlNMNVhikvK1yyYVrBJTYinOSDTUYi4qTgQAeI9beacCAAA=
X-CMS-MailID: 20210106103829epcas5p20a5c8aa2ae8bd6d8d555dad1aa265a1c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106103829epcas5p20a5c8aa2ae8bd6d8d555dad1aa265a1c
References: <CGME20210106103829epcas5p20a5c8aa2ae8bd6d8d555dad1aa265a1c@epcas5p2.samsung.com>
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

Fixes: 2c04c5b8eef79 ("PCI: pci-epf-test: Use pci_epc_get_features() to get
EPC features")

Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Sriram Dash <sriram.dash@samsung.com>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
v2: https://lkml.org/lkml/2020/12/18/691
v3:
   Addressed Bjorn's comment to enhance commit message by adding fixes tag

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

