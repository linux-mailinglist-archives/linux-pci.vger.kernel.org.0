Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34C3885C7
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 05:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241703AbhESDze (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 May 2021 23:55:34 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41110 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237912AbhESDzc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 May 2021 23:55:32 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210519035411epoutp0118034316affacd3d3f0c757cd26e44c6~AW3tQMrFq0064200642epoutp01G
        for <linux-pci@vger.kernel.org>; Wed, 19 May 2021 03:54:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210519035411epoutp0118034316affacd3d3f0c757cd26e44c6~AW3tQMrFq0064200642epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1621396451;
        bh=yRr7g2cJdeuuLCaBAQhw0TJ12bnHPHlVnQJBgw46cE8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l7cCpE1D29xiyoxtbHNYvi4pAaSQKmuPy96lslbk510kpqYTJZSvEg5z54Ml6LBlg
         SRGXU3V+vDW/FTfCks+mXIvziZhLIrEx9gDneC6pqGXPhuPppYHCIAyn8Jt5tEGMMx
         BuCSl1r/1u3LlsSYqoPkUqSlceaRIe7BRc5JAeEw=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210519035409epcas5p38da8e220afc8381c6d13b28b72bc7a0f~AW3sRN4Zj0722707227epcas5p3c;
        Wed, 19 May 2021 03:54:09 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.18.09697.1EB84A06; Wed, 19 May 2021 12:54:09 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210518173826epcas5p32f6b141c9ab4b33e88638cf90a502ef1~AOeGKMYzB0797307973epcas5p3-;
        Tue, 18 May 2021 17:38:26 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210518173826epsmtrp2c411abe05e5122a37fe99adab8f92b92~AOeGJGTLF1328213282epsmtrp2q;
        Tue, 18 May 2021 17:38:26 +0000 (GMT)
X-AuditID: b6c32a4a-639ff700000025e1-50-60a48be197ae
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        1F.D8.08637.29BF3A06; Wed, 19 May 2021 02:38:26 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210518173824epsmtip1f14a785fda1683aa9ef15f86479fd8ed~AOeEVPhM92131721317epsmtip1c;
        Tue, 18 May 2021 17:38:24 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        hari.tv@samsung.com, niyas.ahmed@samsung.com, l.mehra@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 3/3] PCI: dwc: Create debugfs files in DWC driver
Date:   Tue, 18 May 2021 23:16:18 +0530
Message-Id: <20210518174618.42089-4-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518174618.42089-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0xSURzv3HvhXtioK/Y42mtpj2VG9jBvZfZY2V1t2epDq62E9E4qBQZY
        1LKorJTKpOd8jJRqEWokWZGiJSQVzazphj1sUpZF9vDZy7Lk6vr2e53/73/ODoEKMzjBxFaZ
        mlHKJMkhXD520zk1bLr36EVxRFv9XOriASlV3pSBU+1nryCUqSsHp162NgKqvjyfS9Ua7nOp
        tl/vcarl9GsOVVO6jjLe6MKpPrsNp4470xYL6GJDMaBv5zbhdIE1lbaaM7l0VpkZ0GV3OgHd
        aR23Bt/Ij05kkrfuYJQzYsR8aZU7VaHlaXzP63AtcOM6wCMgOQfWu3s5OsAnhGQFgOnfs1GW
        dABoz+nBWNIDoKXbyx08Upbh4rJGJYC9uZ4Bko7AmtIWtD/FJcPg/m6dHw8nF0Ctz+wvQcl8
        BPa5jFi/EUgugcYjX0A/xshJsDX7p79CQM6H+U4Lh60bD4uu3fUP4v0bVHTY5l8Qkr9xeNLS
        hugA8Y8sg+ajcjYfCH33ywZuFww7P1cOrC2HZ568xdi4Bl4+tpeVF8G7Dfl+GSWnQkv5DFYe
        C8+4ryL9GCWHwuO/WhBWF0CbYRCHwq7fdozFQdDgqh/YmIbfer7g7JtkAfgj6wgnG4zL/V9R
        AIAZBDEKVUoSo4pUzJIxO0UqSYoqVZYkSpCnWIH/s4SttAFv81eRAyAEcABIoCHDBbdWXRAL
        BYmSXbsZpTxemZrMqBxgNIGFjBKYvKfEQjJJoma2M4yCUQ66CMEL1iLy9rNxExRTqCa9h7dO
        dNCztuGDe8jEjm6+6WaCq848pnBaaMA5+z73nsxPnUUVJyJ0xqApjuzohyW8nICDgR5pjq2i
        UmNZ1ud7EHn+aWu1i2PP+xN5p+odiFkdV/4s70J6ZPvk4pOXTJl6E5ow2yfW7t8Wr6+4Gvpo
        m0YZbtq3d+Hmeer1ETJEP+xrbQdy2hnQqDO+WwqjY9MMLpRukq54kzcmLWZ8qac1qkNU2TB9
        g1B9/l7Ui11bHFUOxtfnulw7QjdyrjoqDh9aFB77tES8ofde4KbmEqc1cU78Zk1pjR6r/vyi
        +ZDjRq6+5ERN4eNqU+O3Oi8Sfv3jq9hbLctDMJVUMjMMVaokfwGLeD79mwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJLMWRmVeSWpSXmKPExsWy7bCSnO6k34sTDB5cVrJY0pRhsetuB7vF
        x2krmSxWfJnJbnHn+Q1Gi8u75rBZnJ13nM3ize8X7BZPpjxitTi6Mdhi0dYv7Bb/9+xgt+g9
        XOvA67Fm3hpGj52z7rJ7LNhU6rFpVSebR9+WVYweW/Z/ZvT4vEkugD2KyyYlNSezLLVI3y6B
        K2PfqdKCBs6KV7fOszcwnmLvYuTkkBAwkdjScYyti5GLQ0hgN6PEt9N32SASkhKfL65jgrCF
        JVb+ew7WICTQxCTx7ytYnE1AS6LxaxcziC0iYCvR8LeDGWQQs8AKJom2M5NZQBLCAo4Si9rf
        M4LYLAKqEs8n/AJbwCtgJTHn8HpWiAXyEqs3HAAbxClgLbG6bQeQzQG0zEri/52yCYx8CxgZ
        VjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn525iBIeuluYOxu2rPugdYmTiYDzEKMHBrCTC
        u917cYIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTApc
        cfdEp3Mw5LQ8FBfTzthzveaJzPwFUfO3FT7g3bs+5Z7r8aaNaU6r/YTNWHc6HtrJNkO142Fu
        S5XjjwKxoqvOfH6+Vxhj7iRva8wVLlozYeGb+29mdrE+95wXuXOJs0Tplg3sh9QDnzM82ZQy
        2eLFsblPpp2c0Ph/kXph6vuq+qx5CRXSnnZcEsccOx58CTzRenjTH7HmrKy2qbkP0spEl06e
        oSVtd8KHY2F6Ivd9mb6VDlmOy56cbOh+feXZvXnbJ8XFaYf6fNjuemhjVVNfQ1hk/j9WMwaF
        mX0B0pn9ZR3BmYIB3pdDl9bFrgjbs0z17Hk5/mtiqek772SKr9SZbfKNtez16tLq9L9eSizF
        GYmGWsxFxYkAPIyJWcwCAAA=
X-CMS-MailID: 20210518173826epcas5p32f6b141c9ab4b33e88638cf90a502ef1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210518173826epcas5p32f6b141c9ab4b33e88638cf90a502ef1
References: <20210518174618.42089-1-shradha.t@samsung.com>
        <CGME20210518173826epcas5p32f6b141c9ab4b33e88638cf90a502ef1@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add call to create_debugfs_files() from DWC driver to create the RASDES
debugfs structure for each platform driver. Since it can be used for both
DW HOST controller as well as DW EP controller, let's add it in the common
setup function.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 348f6f696976..c054f8ba1cf4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -15,6 +15,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-designware-debugfs.h"
 
 /*
  * These interfaces resemble the pci_find_*capability() interfaces, but these
@@ -793,4 +794,8 @@ void dw_pcie_setup(struct dw_pcie *pci)
 		       PCIE_PL_CHK_REG_CHK_REG_START;
 		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
 	}
+
+	ret = create_debugfs_files(pci);
+	if (ret)
+		dev_err(pci->dev, "Couldn't create debugfs files\n");
 }
-- 
2.17.1

