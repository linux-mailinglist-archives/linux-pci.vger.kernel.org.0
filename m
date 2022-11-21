Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28CA632112
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 12:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiKULqN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 06:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiKULqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 06:46:08 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84F5DE1
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 03:46:06 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221121114604epoutp0131fed224568b06d84548df76b7d8d201~plwBchAX71836218362epoutp01X
        for <linux-pci@vger.kernel.org>; Mon, 21 Nov 2022 11:46:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221121114604epoutp0131fed224568b06d84548df76b7d8d201~plwBchAX71836218362epoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669031164;
        bh=4DQSEQbGFqTzsAQ1vDOskhu5NeotvLsqwP2LwtiyYOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G9wf9OFp9+O65mfEGgfr4eUdhvM12Z6IQVk2R/PXpirOdsSlUgQDc3nDIiLMgZhnK
         UWa43lOAsvl8aByc+eWBgkkNmGrfSG+wbsMhvtvBQLTcwFbNa4roEyvDHW7oIR2ig5
         1yRbvn6sqUXGbyZLBeOlCFmTnbESHUj0KGEa+qvs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20221121114603epcas5p42b556919e142f6c0ae022bad2f21b055~plwAwMW_U0433904339epcas5p4C;
        Mon, 21 Nov 2022 11:46:03 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NG5F62YLVz4x9Pw; Mon, 21 Nov
        2022 11:46:02 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F2.F5.56352.AF46B736; Mon, 21 Nov 2022 20:46:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104746epcas5p109c7bb299cf19070a9237c00c162ed8f~pk9HX5aeT2593625936epcas5p1_;
        Mon, 21 Nov 2022 10:47:46 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221121104746epsmtrp1db7d5813c1c84b763ba0a5f00015f418~pk9HVfj7O2438624386epsmtrp1d;
        Mon, 21 Nov 2022 10:47:46 +0000 (GMT)
X-AuditID: b6c32a4b-5f7fe7000001dc20-91-637b64fa45e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.45.18644.2575B736; Mon, 21 Nov 2022 19:47:46 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221121104742epsmtip18fae01eacc517566d39093dcb2713ce7~pk9EDB1I31291012910epsmtip1f;
        Mon, 21 Nov 2022 10:47:42 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, rcsekar@samsung.com,
        sriranjani.p@samsung.com, bharat.uppal@samsung.com,
        s.prashar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, p.rajanbabu@samsung.com,
        niyas.ahmed@samsung.com, chanho61.park@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 6/6] misc: pci_endpoint_test: Add driver data for FSD PCIe
 controllers
Date:   Mon, 21 Nov 2022 16:22:10 +0530
Message-Id: <20221121105210.68596-7-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221121105210.68596-1-shradha.t@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe0zTVxTHd/trfy2kNT8L00szGfmRLQPHo1rKBYFBJFsNZoLOZSFboGl/
        aYHSdn3ApjMgUpNhRcGqPCsCU1odYkHltVFesocjzWDEDTaBsYWXgyFieHRZS2H773PO+Z7H
        PfdeFsZ14DxWhlJHaZRiBYl70+/3Br0RsiY9KQk3WtjIvtBNR+Pm+zhylj5kop7me0w0MuNg
        ovoCORrq2ouu9Q0y0Jm6Ozhy/GHEUfH0BIbyjesMNNRehaMfzAM4umhdoaPCjUI6si9aAZoy
        TTJQ/91jqPbeMhNVOFoZyPBVHxOZW6sBOt97Co3ONzJQ29g3WDxPtL5WCkQ1Nr3IZv0cF42N
        dOKiqeGrNFFX9W2mqLk+T1TcYgWigccPaKJnNv9k79SsGDklllKaAEopUUkzlLJYMulY2sG0
        CGE4P4QfhSLJAKU4m4olEw8nh7ydoXAdnAzIESv0LleyWKslw+JiNCq9jgqQq7S6WJJSSxVq
        gTpUK87W6pWyUCWli+aHh++LcAnTs+SGfr561PuT7o5/mPngnFcR8GJBQgCLe9tobuYSHQAO
        PskrAt4uXgJwebAG9xjPAOxsHMa3M64YypmeQDuAJRYjw2MYaHC++sxmLZwIhqefF2Fu9iWW
        MPjiSrRbhBE1AE48tgB3wIf4AD798UtXWRaLTrwGGy587EYOEQ27ag56mr0KbzXZN8t4EQdg
        Y93o5kSQmGfBytlLWxMlwtXSP4GHfeDsQAvTwzw4c+HsFsugpbkM87ACrjTX0zz8FrQPV9Hd
        fTEiCN5pD/O498DL3zVuSjBiBzy/PrUl58BW8zYHwmVnJ93DftD8cIjhYRHsWKjdWlAxgOWl
        PYyLwL/i/xY1AFiBH6XWZssobYR6v5LK/e/OJKpsG9h82sFJrWByfDG0B9BYoAdAFkb6cvI+
        PCnhcqTiT09QGlWaRq+gtD0gwrW+Eoz3skTl+htKXRpfEBUuEAqFgqj9Qj65m1NXFizhEjKx
        jsqiKDWl2c6jsbx4+bRdBWdPf3Y9h1THxGVkzk7L4go144HL7LnD45K9TyPJQw92KJqcIxNZ
        V9+VlX+fUllyPeinpeCX5gyCqoUwRsNx7istw3O5iVI/x7zFbHrnvQrTrpsrdwnDvr96byFb
        ehmPKUwY+vYL5aS8aWfKRkjgjQC587jvCd6bq7Uj65X97D2S5JTdbN8bCV/3FySOnGpYHM1d
        Tco8knzIboonK9ceZSQkYezSMKM/ZYu65DP2iNvN+bXd+fx93s7ImZ+FG04bNcapzRlPn4w/
        kGnNcUgv/2YPM9J+f2F6UvQLhz0kFdSb+s4ddUz36xraPnr9ZqqFAas0qyu3U1v1hpTqv4/6
        knStXMwPxjRa8b/Obxt5YwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42LZdlhJTjcovDrZ4M4zfosD7w+yWDyYt43N
        4u+kY+wWhzZvZbe49vICu8WSpgyLy/u1LeYfOcdq0bx4PZvFhac9bBZ9Lx4yWzT0/Ga1uLxr
        DpvF2XnH2SwmrPrGYtHyp4XF4sCHVYwWT6Y8YrU4ujHYYtHWL+wWsy7sYLVo3XuE3WLejrmM
        Fr2Hay1uv1nHarHzzglmBymP378mMXos2FTqsWlVJ5vHnWt72DyeXJnO5LF/7hp2j81L6j36
        tqxi9Dh+YzuTx+dNcgFcUVw2Kak5mWWpRfp2CVwZrUcNC25zVRzc/Y+9gbGbs4uRk0NCwERi
        WutM9i5GLg4hgR2MEt/W/2eBSEhKfL64jgnCFpZY+e85VFEzk8Skk4vBitgEtCQav3YxgyRE
        BHpYJGZvvQNWxSywhFFi8909bCBVwgJhEne//APq4OBgEVCVWNFfCGLyClhJ7F/gDLFAXmL1
        hgPMIDangLXEusW3wTqFgErW3fjDPoGRbwEjwypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjODI0tLawbhn1Qe9Q4xMHIyHGCU4mJVEeEWOVSYL8aYkVlalFuXHF5XmpBYfYpTmYFES
        573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwHRlkfWD894y94VaImsPTP5S9mWe0YLIRG2H1SVM
        LSFFV9ZOFt1gcazmwdwPX+dZKelP0FWeU+2nPVmRoZB7PqfqtxNMU1c+U627n7B93dd/KUdY
        O3zW6k87J1XDfo1TXPs7176JOY/uXGOyTuM8YVsVwmNy2aS8bfdz6ykMzVWNO/JSVT3n6Lof
        jXHM8XFPSy38fuSS+b7T0iI3HUo6zwqHi0f0JxrX5xw28UpujFv4fba6HEsn55y0SQmZUe7Z
        udt3VidMyBKa9PO+8eQJDZ/3BWdprJ/10fSg7y0dYxNlLeWUdREfA98Kq6u/zbo2762xNufO
        2Y/WKu5KZz97J33/xm6dbZ2sCzTXfDh6WImlOCPRUIu5qDgRAPt6QyUbAwAA
X-CMS-MailID: 20221121104746epcas5p109c7bb299cf19070a9237c00c162ed8f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221121104746epcas5p109c7bb299cf19070a9237c00c162ed8f
References: <20221121105210.68596-1-shradha.t@samsung.com>
        <CGME20221121104746epcas5p109c7bb299cf19070a9237c00c162ed8f@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_map_single() might not return a 4KB aligned address, so add the
default_data as driver data for FSD PCIe controllers to make it
4KB aligned.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/misc/pci_endpoint_test.c | 3 +++
 include/linux/pci_ids.h          | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 11530b4ec389..2cd1aaa87966 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -983,6 +983,9 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, PCI_DEVICE_ID_LS1088A),
 	  .driver_data = (kernel_ulong_t)&default_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TESLA, 0x7777),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
 	  .driver_data = (kernel_ulong_t)&am654_data
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index b362d90eb9b0..a29b69e908aa 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -158,6 +158,8 @@
 
 #define PCI_VENDOR_ID_LOONGSON		0x0014
 
+#define PCI_VENDOR_ID_TESLA		0x014a
+
 #define PCI_VENDOR_ID_TTTECH		0x0357
 #define PCI_DEVICE_ID_TTTECH_MC322	0x000a
 
-- 
2.17.1

