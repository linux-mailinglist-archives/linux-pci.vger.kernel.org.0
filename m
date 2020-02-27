Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAB1171661
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 12:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgB0Lvy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 06:51:54 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44327 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgB0Lvy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2020 06:51:54 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200227115152euoutp02297cba3c79e46872b9f88edc2dff85a8~3QCLby3iJ2000620006euoutp02m
        for <linux-pci@vger.kernel.org>; Thu, 27 Feb 2020 11:51:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200227115152euoutp02297cba3c79e46872b9f88edc2dff85a8~3QCLby3iJ2000620006euoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582804312;
        bh=3EmbG3tIsUVU+euXxv8svqYHWtp3RefmURy/Bm4oE2Y=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GuE3phDriPKdmRz+yVJ/SCJxzj1AtyPVs8q1NhVM60dbEEl3GMEULMDzlo9MyMUiV
         CtLg6N2MuEguOulxnb7LiUEljLpe8tFeKwqTORXGwOXeMxUrUXMwcBAS9t4kymTVc2
         YCj4hvAuAMAiWDP54XKQxk/lvPJlo7kJgB1OMBD8=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227115152eucas1p164f7e8fe212a8527b05c5a8f3f8523d6~3QCLKDD9t2247222472eucas1p1-;
        Thu, 27 Feb 2020 11:51:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3B.0A.60679.85DA75E5; Thu, 27
        Feb 2020 11:51:52 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227115151eucas1p22ff7409009d917addcc7e20f523c9051~3QCKzogZl1499214992eucas1p2M;
        Thu, 27 Feb 2020 11:51:51 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227115151eusmtrp2f12427f90b3c6d046b265c4788884a5c~3QCKzCQaa3190131901eusmtrp2x;
        Thu, 27 Feb 2020 11:51:51 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-f3-5e57ad585a4a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 57.52.08375.75DA75E5; Thu, 27
        Feb 2020 11:51:51 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200227115151eusmtip1321c3ea5662c027f51c54f12309a59ca~3QCKU13Jm2289622896eusmtip1H;
        Thu, 27 Feb 2020 11:51:51 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] pci: brcmstb: Fix build on 32bit ARM platforms with older
 compilers
Date:   Thu, 27 Feb 2020 12:51:46 +0100
Message-Id: <20200227115146.24515-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSfSyUcRzfz/Pcc4/Ttadj85tMdaphQ1fanpWEaXtaVq1Q01xOnh26O3aP
        l1Qb0UpHDbXoNGReyltCV4c/Yuq0GypNL3cI1XQOGbZI6h6P6r/v522f77774oiokOeCx6uS
        abVKphBjAlT3YrHf+2TDCekO4yWc/PjgNp9suP4cJSuz4sil6W4+2Tw+yCMH2u5iZG+pASML
        TE180vpzwmbrHuKTOm0NFuhA1ZfWA0o70otReu0QnypvTqFaKjOoG621gGoxXqBMP1TUXLPb
        UftIgX8srYhPpdW+AdGCOMPkMEjqEJwrHtNjmWAM1wAch4QfrLBKNECAi4j7AN6bq0U0wN4G
        5gG0LsRwwhyAZYszfFZgAzetH1BOqAFQl1PC44AtUfg9H2VdGCGBmikNxgpORC6ARW9nAQsQ
        os0Ojn4tWHU5EhFwpqQPYxdBiW2wZ9CLpYXEPjgzrEe4uk2wrukZwmYhkcuHlzsmUU4IgXe0
        jRg3O0KLoXVtP1f4W19mxwWyARzta+BzIA/AgaxiwLn2QnPf0mozQnjCh22+HB0Eh6pWAHeZ
        9fD91AaWRmxjoa4I4WghzLki4tzbodbQ+K+289WbtZ0p2Gtu5HF3jIKVAyYkH7hp/3eVA1AL
        nOkURimnmZ0qOs2HkSmZFJXc50yishnYPsW4Yph/CtqWY7oAgQPxOiGMjpCKeLJUJl3ZBSCO
        iJ2EjxbCpSJhrCz9PK1OPK1OUdBMF9iIo2Jn4a6Kb1EiQi5Lps/SdBKt/qva4fYumeDJ8Yz2
        rTPv9qiGAz91VB873Gldzg2yYn7eCqEl67HFFOOoufi5+ou73ONI2ATjKi2zU46/DDgYWpW9
        2XRV7O/3eiThVsu1SjdzaX5wyLCRVKAuFofiSHNe2CmP3gP9qGd1UyivA0vWJfbMloe7/7pT
        uGV3muP0obpgPbo/oV0iRpk4mcQLUTOyP6qm8sslAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t/xu7rha8PjDKa+M7C4tXIau8Xa3qMs
        FkuaMix+vTvCbrHp8TVWi8u75rBZnJ13nM1i4u0N7BZvfr8AKjtyl91i26zlbA7cHmvmrWH0
        mHX/LJvHzll32T0WbCr12Lyk3qNvyypGj82nqz1u/8jz+LxJLoAzSs+mKL+0JFUhI7+4xFYp
        2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j+Ot7jAV7uCpmPNrJ1sD4iKOL
        kZNDQsBEYvKbmyxdjFwcQgJLGSUO79nKApGQkTg5rYEVwhaW+HOtiw2i6BOjxNObe8CK2AQM
        JbregiQ4OUQEehkljnzIBCliFtjHJNF4eBlzFyMHh7BAiMTvMwkgJouAqsSJa1og5bwCthLv
        7+1khpgvL7F6wwHmCYw8CxgZVjGKpJYW56bnFhvqFSfmFpfmpesl5+duYgQG8rZjPzfvYLy0
        MfgQowAHoxIPr0RCWJwQa2JZcWXuIUYJDmYlEd6NX0PjhHhTEiurUovy44tKc1KLDzGaAu2e
        yCwlmpwPjLK8knhDU0NzC0tDc2NzYzMLJXHeDoGDMUIC6YklqdmpqQWpRTB9TBycUg2Ms1w+
        +4VfLP1wffXzPt0d705XV0i0OEze9N1a6saMLBXtuEKOVYvZs99UCB9Q5WNwzFcqs/m64bmp
        7+31RtLznEO1fcpTfNUd1lm5+lYnd8z1MnrP/kutwmdLrH9I9bq5j29t5udkWsrQaV4Uqvxz
        y4Zo28S0qbm/eLqTFH6Lz5i1Qemu7X0lluKMREMt5qLiRADdBbMJegIAAA==
X-CMS-MailID: 20200227115151eucas1p22ff7409009d917addcc7e20f523c9051
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227115151eucas1p22ff7409009d917addcc7e20f523c9051
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227115151eucas1p22ff7409009d917addcc7e20f523c9051
References: <CGME20200227115151eucas1p22ff7409009d917addcc7e20f523c9051@eucas1p2.samsung.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some older compilers have no implementation for the helper for 64-bit
unsigned division/modulo, so linking pcie-brcmstb driver causes the
"undefined reference to `__aeabi_uldivmod'" error.

*rc_bar2_size is always a power of two, because it is calculated as:
"1ULL << fls64(entry->res->end - entry->res->start)", so the modulo
operation in the subsequent check can be replaced by a simple logical
AND with a proper mask.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index d20aabc26273..3a10e678c7f4 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -670,7 +670,7 @@ static inline int brcm_pcie_get_rc_bar2_size_and_offset(struct brcm_pcie *pcie,
 	 *   outbound memory @ 3GB). So instead it will  start at the 1x
 	 *   multiple of its size
 	 */
-	if (!*rc_bar2_size || *rc_bar2_offset % *rc_bar2_size ||
+	if (!*rc_bar2_size || (*rc_bar2_offset & (*rc_bar2_size - 1)) ||
 	    (*rc_bar2_offset < SZ_4G && *rc_bar2_offset > SZ_2G)) {
 		dev_err(dev, "Invalid rc_bar2_offset/size: size 0x%llx, off 0x%llx\n",
 			*rc_bar2_size, *rc_bar2_offset);
-- 
2.17.1

