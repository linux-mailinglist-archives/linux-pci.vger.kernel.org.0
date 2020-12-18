Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B472DEBC3
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgLRWvl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 17:51:41 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:27384 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgLRWvk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 17:51:40 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201218225058epoutp020f2a434fb0be040aea753660ac5aa0c7~R8U3ERaSE3229732297epoutp02x
        for <linux-pci@vger.kernel.org>; Fri, 18 Dec 2020 22:50:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201218225058epoutp020f2a434fb0be040aea753660ac5aa0c7~R8U3ERaSE3229732297epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608331858;
        bh=Z2NFqj8VfHHzdtjUbgSEQIilQ+fIwqpC7aWCnUGTR2g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FQ2BdZmaClWsZG5XIV2kbR5+0zSn6PrSVZRoc2KnOtmX1K3BKvGbCftk5HihBUcsh
         z3PeIH4O3LBxnM+wukxZxpnnVJOeAZVQlTQexYi4VgncaQKc+FytYOrZ+7z//Tm4n/
         1Y4j+IoWhTr+8hkkXYedJHvbPAq3YrC4l4FiKAyQ=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201218225057epcas5p4f495fd8fe622e1dbeb9cfab70bd3233f~R8U2VnzOw0934509345epcas5p4s;
        Fri, 18 Dec 2020 22:50:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.E1.33964.1523DDF5; Sat, 19 Dec 2020 07:50:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201218154704epcas5p1446559adbd4a5b267a4c940b5f744970~R2ivw4tl20804008040epcas5p1r;
        Fri, 18 Dec 2020 15:47:04 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201218154704epsmtrp17777a88462abe3c39565ad1005f6c9ba~R2ivwE9EO1669016690epsmtrp1M;
        Fri, 18 Dec 2020 15:47:04 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-e0-5fdd32514028
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        EF.83.13470.8FECCDF5; Sat, 19 Dec 2020 00:47:04 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201218154702epsmtip1d520d154f76a28cbaf8a63578d78876a~R2iuiKap72025720257epsmtip1Y;
        Fri, 18 Dec 2020 15:47:02 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        pankaj.dubey@samsung.com, Shradha Todi <shradha.t@samsung.com>,
        Sriram Dash <sriram.dash@samsung.com>
Subject: [PATCH v2] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Date:   Fri, 18 Dec 2020 21:15:16 +0530
Message-Id: <1608306316-32096-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmum6g0d14g4a1EhZLmjIsLjztYbO4
        vGsOm8XZecfZLN78fsFusWjrF3aL3sO1FjfWsztweKyZt4bRY8GmUo++LasYPY7f2M7k8XmT
        XABrFJdNSmpOZllqkb5dAlfGkjVf2Aou81b8vjuNqYHxJXcXIyeHhICJRMvxL6xdjFwcQgK7
        GSXm3f/CBuF8YpT4sewQC0iVkMA3Rokvh41gOppn3WOBKNrLKHH7+CuojhYmifWzHjGBVLEJ
        aEk0fu1iBrFFBKwlDrdvAStiFljDKLFq6SqwhLBAmMSqCwfYQWwWAVWJ/zN72EBsXgFXiYPz
        D7FBrJOTuHmukxmkWUJgE7vEtiXbWSASLhJ7Nt5mhrCFJV4d38IOYUtJvOxvg7LzJaZeeApU
        zwFkV0gs76mDCNtLHLgyByzMLKApsX6XPkRYVmLqqXVg9zML8En0/n7CBBHnldgxD8ZWlvjy
        dw/UBZIS845dZoWwPSTOtm9lgoRWrMTG/xMYJzDKzkLYsICRcRWjZGpBcW56arFpgXFearle
        cWJucWleul5yfu4mRnDsa3nvYHz04IPeIUYmDsZDjBIczEoivKEPbscL8aYkVlalFuXHF5Xm
        pBYfYpTmYFES51X6cSZOSCA9sSQ1OzW1ILUIJsvEwSnVwHSnZdOjmc4ntxZN/iCWdsno8Y6D
        e8I8w5T667uiNhQoWgT93+/74LHdY+4rPKH9SZICPP+rZA59CS+o+i7+7P7jjczNMySKOLeJ
        vLvux7Rbw4lj1owQ3ubE4JAVu7atWCZ2OUbqz2ujpKzUhal88aZWmuu+7uP2OiAzLcCmi3mn
        RtrlGt/Z1b5Wv10PtKhZfDgmX+vZJR5o6/KQiSnk65drng42Plx/L95yljW5f0Xm4qv7/gwW
        F9xnH764RvnYzopV75vco39Kt7ExbdFnbb7K8njrc5V/v7ZPF1eatEhz6RnBF06rn/u+E1nu
        dombK8Ug2ang6tMf+owKv4L+3Qh8HJOdkXhcqCtd7L6dpBJLcUaioRZzUXEiALdJnt9sAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkluLIzCtJLcpLzFFi42LZdlhJTvfHuTvxBj+62CyWNGVYXHjaw2Zx
        edccNouz846zWbz5/YLdYtHWL+wWvYdrLW6sZ3fg8Fgzbw2jx4JNpR59W1Yxehy/sZ3J4/Mm
        uQDWKC6blNSczLLUIn27BK6MJWu+sBVc5q34fXcaUwPjS+4uRk4OCQETieZZ91i6GLk4hAR2
        M0r0np7DCpGQlPh8cR0ThC0ssfLfc3aIoiYmiemNi5hBEmwCWhKNX7vAbBEBW4n7jyazghQx
        C2xilHh6uYsNJCEsECKx59RBsKksAqoS/2f2gMV5BVwlDs4/xAaxQU7i5rlO5gmMPAsYGVYx
        SqYWFOem5xYbFhjmpZbrFSfmFpfmpesl5+duYgSHkpbmDsbtqz7oHWJk4mA8xCjBwawkwhv6
        4Ha8EG9KYmVValF+fFFpTmrxIUZpDhYlcd4LXSfjhQTSE0tSs1NTC1KLYLJMHJxSDUzGH3Zc
        POYR5rpJ4/SejmnhP2+n6m3q95Dd+yVlYfvtWhatFi+ZkHXJiQ8yUmfvl5O11WE26K05dLZN
        +LtcAVfftoy2U5xR+wI/pT76pWgR9NFo0jZbpl9HL/37eVw+wf/yvpM+B5LZA64bRjz0n5N4
        6nlD7Yo1m7MEKquezNm/R3UD3/un9zolrthtSNA/kPPt97SPVXnip0Ml2D694T998/SJXCbJ
        WNnXj07P7ln3oTWjq7cqVGZbUfl+D23lrmdFFjpv5z4r0u9k6FFd0DG/M7duZqZS9b38Mm3N
        D5o1zRyVa1/u3vPs++zzeq+lTsVc0y4ontbwS0v/tdKRK/s+VPsfaqqdv7Xdq+q35WElluKM
        REMt5qLiRAA8rxwrlAIAAA==
X-CMS-MailID: 20201218154704epcas5p1446559adbd4a5b267a4c940b5f744970
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201218154704epcas5p1446559adbd4a5b267a4c940b5f744970
References: <CGME20201218154704epcas5p1446559adbd4a5b267a4c940b5f744970@epcas5p1.samsung.com>
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
v2:
 rebase on v1
 v1: https://lore.kernel.org/patchwork/patch/1208269/

 drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 66723d5..f1842e6 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -835,13 +835,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
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

