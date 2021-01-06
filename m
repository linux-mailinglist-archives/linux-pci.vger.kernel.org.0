Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE2C2EBCC8
	for <lists+linux-pci@lfdr.de>; Wed,  6 Jan 2021 11:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbhAFKwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Jan 2021 05:52:36 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:14841 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbhAFKwf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jan 2021 05:52:35 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210106105152epoutp04159d25a6314a329ae7b85563f0d8435d~XnxbnfrLs1187611876epoutp04A
        for <linux-pci@vger.kernel.org>; Wed,  6 Jan 2021 10:51:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210106105152epoutp04159d25a6314a329ae7b85563f0d8435d~XnxbnfrLs1187611876epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609930312;
        bh=kiqqzxtVs6YoPEWPZalZapoDdUqZXOdKnWnJ1ba2mq8=;
        h=From:To:Cc:Subject:Date:References:From;
        b=JZHaPifvMQEWVj3MyU4R507TgVmHpxt34ACrbzq5a7yNv5KcAvbrtim2BgG4JIuCW
         8tGqRTJw2vP4L2z1FktnxCjqhcSA60aBa9dRYW7Ig1r2fITV0Y/zHP0uGTfYDpBlF4
         f/qWoPZLLZaeqhrzZupShlKnISSfUq1I9ODKWiKI=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20210106105151epcas5p3691528765db86836643f095dcf4e5fa9~Xnxagy5fK1437014370epcas5p3e;
        Wed,  6 Jan 2021 10:51:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D0.AA.50652.74695FF5; Wed,  6 Jan 2021 19:51:51 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a~XnrpNB2w71198811988epcas5p3P;
        Wed,  6 Jan 2021 10:45:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210106104514epsmtrp1d3b79d70711aed99945e84c55d5b6862~XnrpL-j1D0422104221epsmtrp1M;
        Wed,  6 Jan 2021 10:45:14 +0000 (GMT)
X-AuditID: b6c32a4a-6b3ff7000000c5dc-77-5ff59647b2c0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.90.13470.AB495FF5; Wed,  6 Jan 2021 19:45:14 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210106104512epsmtip13b470853fec3f5e7413b62be7aba60fe~XnrnSgZMt3031630316epsmtip1J;
        Wed,  6 Jan 2021 10:45:12 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        robh@kernel.org, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v2] PCI: dwc: Change size to u64 for EP outbound iATU
Date:   Wed,  6 Jan 2021 16:15:00 +0530
Message-Id: <1609929900-19082-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRmVeSWpSXmKPExsWy7bCmhq77tK/xBu1f+C2WNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        11rcWM/uwOexZt4aRo+ds+6yeyzYVOqxaVUnm0ffllWMHlv2f2b0+LxJLoA9issmJTUnsyy1
        SN8ugSvj1tyzbAXfeSu+XXzE2sB4iLuLkZNDQsBE4uj3FaxdjFwcQgK7GSWev1rNBOF8YpRY
        8/sfC4TzjVHi/o7ZTDAtX45PYYZI7GWUeDdnHjtIQkighUmidY0iiM0moCXR+LWLGcQWEbCW
        ONy+hQ2kgVlgK5PE2cUL2UASwgKuEm8eNjOC2CwCqhKX13SCxXmB4lt3PWaB2CYncfNcJ9g2
        CYG37BI/Hi4FauAAclwkfrUHQdQIS7w6voUdwpaSeNnfBmXnS0y98JQForxCYnlPHUTYXuLA
        lTlgYWYBTYn1u/QhwrISU0+tA/uRWYBPovf3E6h/eSV2zIOxlSW+/N0DdZmkxLxjl1khbA+J
        d2vWMUKCIVbiyZW/jBMYZWchbFjAyLiKUTK1oDg3PbXYtMAoL7Vcrzgxt7g0L10vOT93EyM4
        jWh57WB8+OCD3iFGJg7GQ4wSHMxKIrwWx77EC/GmJFZWpRblxxeV5qQWH2KU5mBREufdYfAg
        XkggPbEkNTs1tSC1CCbLxMEp1cDUxd2wY84938P3JZdfUInpetLBJxD3U2huQ/fUtAyem5Kr
        rLIuOdcs3/F/8X2fnt6i6+2Tvvw+ePGH0JIVeUe7DxorSWveXvK00fL89GqutQ4sm4r4JzNO
        mcE81dV3z+37eZrbVn5/b5rX/Db8xcuHj26zcK1dqNEsdeHyadvojWfPzXzf/+yjAWfwOaEz
        iV/WfF0fceSS1fd7rSLGV7z3iMjVFGh/klwXWy8yu7rJk8nvgZjrnFMP7pQ80ctqfdq+WS47
        Vu5Oc8HibRf5HJ2frokIV1528VqQ1rGnM4LqYt7Ind3MWMWfpnr7s/4K01CZJ4/9faXij/w4
        x2I8s+CgTFp4lc55tyeqWRf/vVjzUImlOCPRUIu5qDgRANp1F+eSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSnO6uKV/jDeY3qFksacqw2HW3g93i
        47SVTBYrvsxkt7jz/AajxeVdc9gszs47zmbx5vcLdosnUx6xWhzdGGyxaOsXdov/e3awW/Qe
        rrW4sZ7dgc9jzbw1jB47Z91l91iwqdRj06pONo++LasYPbbs/8zo8XmTXAB7FJdNSmpOZllq
        kb5dAlfGrbln2Qq+81Z8u/iItYHxEHcXIyeHhICJxJfjU5i7GLk4hAR2M0p0b1vOBpGQlPh8
        cR0ThC0ssfLfc3aIoiYmifPz7oMVsQloSTR+7WIGsUUEbCXuP5rMClLELHCYSeJj/0OwhLCA
        q8Sbh82MIDaLgKrE5TWdYM28QPGtux6zQGyQk7h5rpN5AiPPAkaGVYySqQXFuem5xYYFhnmp
        5XrFibnFpXnpesn5uZsYwYGppbmDcfuqD3qHGJk4GA8xSnAwK4nwWhz7Ei/Em5JYWZValB9f
        VJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QDU3TF2x2V6UrlhxpnLWQQtz12
        bNuCP59Oed5kFX/PuvKjl9k/o4vrdofN7JjS9Mdm8p6fso6HNoS/qLLUe1Ql/OTlJ88DTtt2
        7G/aNuuKJ5vZkmrWG3ePLed3O7H6Sbf1pn/cSWcFppnECSil3vvE8SZ++z2btvunJ0/4E1xX
        9CVogl/KzIxV+oWTHmWH/dtd86/66JQ6m4Mcs9c7ya3+VXz2k5/6rh9cxe87dvxJTpY3OJRp
        ss8uxCF72XSVeTyme35kLzeeqps3mfO7V6jFv2dRP/Rdl6z+8qX+6OpPDPeOsEg+3rci+5vB
        x/tCNuktf9rCVhXPDzzykFHd2uJhpdexSwvtzKv7/qru4LtVF/RLiaU4I9FQi7moOBEAPUTf
        bbsCAAA=
X-CMS-MailID: 20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a
References: <CGME20210106104514epcas5p37d8e3a88aefdf109f7fb4157d4a1f07a@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since outbound iATU permits size to be greater than 4GB for which the
support is also available, allow EP function to send u64 size instead of
truncating to u32.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
v1: https://lkml.org/lkml/2020/12/18/690
v2:
   Addressed Bjorn's review on to keep commit message length limit to 75

 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1d62ca9..db407ed 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -326,7 +326,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 
 void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
-				  u32 size)
+				  u64 size)
 {
 	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
 				    cpu_addr, pci_addr, size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 7da79eb..359151f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -302,7 +302,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       u64 size);
 void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
-				  u32 size);
+				  u64 size);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 			     int bar, u64 cpu_addr,
 			     enum dw_pcie_as_type as_type);
-- 
2.7.4

