Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8EAA2DF78C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Dec 2020 02:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgLUB5B (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 20 Dec 2020 20:57:01 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:34990 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgLUB5B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 20 Dec 2020 20:57:01 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201221015617epoutp02bf040ac041ba02a68faccdc3902ae520~SmJPHw_S52285822858epoutp02z
        for <linux-pci@vger.kernel.org>; Mon, 21 Dec 2020 01:56:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201221015617epoutp02bf040ac041ba02a68faccdc3902ae520~SmJPHw_S52285822858epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608515777;
        bh=HHY714gpTNqhRK+2ne6SAdB/8zhLKmusVu9UemBgfOQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ckRdPMZUitaIRHl6HajLEeziN7DQNbrA6+Zxoo8KXnS7Ws8X/klRxxQfDLbBa/QCg
         ZD1o60uM3NJamgmR0ZVJ4RqeAjdk5FnEquPtr2CQKwbZwLGWwpy5W2hFovfW6JYcqv
         WpkZqTUAigX2BqAKzqCscuvimzcTWqzchsM/u28Q=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201221015616epcas5p40e32f02f65249230b9da0d656c9bcaad~SmJOg52kd0316603166epcas5p4e;
        Mon, 21 Dec 2020 01:56:16 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.6F.15682.0C000EF5; Mon, 21 Dec 2020 10:56:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012~R2Uey-x_I2069420694epcas5p1Y;
        Fri, 18 Dec 2020 15:30:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201218153043epsmtrp1222eb8e3f70d9fb3300dea7325daf3ee~R2UeyKmiB0867408674epsmtrp1U;
        Fri, 18 Dec 2020 15:30:43 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-7a-5fe000c0e79b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.23.13470.32BCCDF5; Sat, 19 Dec 2020 00:30:43 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201218153042epsmtip20ee57576c2d407996080862711d6b12e~R2UdYn1o40251902519epsmtip2q;
        Fri, 18 Dec 2020 15:30:42 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH] PCI: dwc: Add upper limit address for outbound iATU
Date:   Fri, 18 Dec 2020 21:00:34 +0530
Message-Id: <1608305434-31685-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWy7bCmlu4BhgfxBtf2qFssacqw2HW3g91i
        xZeZ7BaXd81hszg77zibxZvfL9gtFm39wm7xf88Odovew7UOnB5r5q1h9Ng56y67x4JNpR6b
        VnWyefRtWcXosWX/Z0aPz5vkAtijuGxSUnMyy1KL9O0SuDIeX/rGUtAiUNHx4h9jA+Mt3i5G
        Tg4JAROJw32fGbsYuTiEBHYzSpzetI8FJCEk8IlR4v45VojEN0aJ5n1zWGE6NnVNYIdI7GWU
        WPz/BFRHC5PEiV4XEJtNQEui8WsXM4gtImAtcbh9CxtIA7PAHkaJH4vuM4EkhAVcJJadWAzW
        zCKgKnGxaReYzSvgKvHyxUpmiG1yEjfPdTKDNEsInGKX2D7rNyNEwkXi0t9Z7BC2sMSr41ug
        bCmJl/1tUHa+xNQLT4GGcgDZFRLLe+ogwvYSB67MAQszC2hKrN+lDxGWlZh6ah3YacwCfBK9
        v58wQcR5JXbMg7GVJb783cMCYUtKzDt2GRooHhIzfuyChkOsxPql71kmMMrOQtiwgJFxFaNk
        akFxbnpqsWmBYV5quV5xYm5xaV66XnJ+7iZGcGLQ8tzBePfBB71DjEwcjIcYJTiYlUR4zaTu
        xwvxpiRWVqUW5ccXleakFh9ilOZgURLnVfpxJk5IID2xJDU7NbUgtQgmy8TBKdXAtND0+tyu
        Z852UetPtcduObxg/Z1X99tkD/5LLWCqdqjfsKtqb8H8iw84zxv+ybXMTLS3kREteDw7Sf/n
        US75a2vTlA4v+73gCf+mKVOuzZBp8+BcVRh7xPTPhAvheen793MvnPFbepdfT7KYlgWDF9+T
        EKmr5gtKy0Pt18n1X+I89r296OFHsRN/Ak7ELHnl7mmwlP+R/KUntruvy4ce+HTZyGjDuvzl
        qyQid9+4yxdse/5xutmd69OC7Pqi86dz9ci+rz2adllq+ZF0YW3nE5felvVmRDI6n2hzWMrH
        EyO9ueeQ8q27AW+e92zK6NGYbvjvvOla47aIwoPfI3++vZC27o1i3q0zclF33oV/yVFiKc5I
        NNRiLipOBADkgbq+ewMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprILMWRmVeSWpSXmKPExsWy7bCSvK7y6TvxBlf26Fosacqw2HW3g91i
        xZeZ7BaXd81hszg77zibxZvfL9gtFm39wm7xf88Odovew7UOnB5r5q1h9Ng56y67x4JNpR6b
        VnWyefRtWcXosWX/Z0aPz5vkAtijuGxSUnMyy1KL9O0SuDIeX/rGUtAiUNHx4h9jA+Mt3i5G
        Tg4JAROJTV0T2LsYuTiEBHYzSsz7tYAVIiEp8fniOiYIW1hi5b/nUEVNTBK9By4zgyTYBLQk
        Gr92gdkiArYS9x9NZgUpYhY4wijR8+AuG0hCWMBFYtmJxSwgNouAqsTFpl1gNq+Aq8TLFyuZ
        ITbISdw818k8gZFnASPDKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4FDT0tzBuH3V
        B71DjEwcjIcYJTiYlUR4Qx/cjhfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2
        ampBahFMlomDU6qBaYnktpinM8r1nC5dO/16xfe/E+N/fX2ezvzp63F/iy61U98iLItPR0bx
        tVh4l5UvNd3/4MXPY+nC3VNK9opNiu7fuX53gW7xuc/nIg/zvbcykfqmaGYXpW6Re1L/5Y3F
        zD+y66ZsfBbJxv1E4OuVd+uFA8XKuBaqxh2wXROlqyn47WLOizrjYy6qhq8e/G55wSKcHJGS
        Uxpw99J8+Xsr/u7Kl47eYnxjddbuvKyL99/PM1i2xVtMzGbZ6b7cR1Yn//5rX7v66VnmfYvY
        Z2Tvf+zrdLTQT//RrR8PhOpuJnJPF0+K+af8XZ338NurZzletrXsOLHtd6dElHVFibXPIZu1
        SazppqGLzy72ylxT8UWJpTgj0VCLuag4EQDNMhWNpAIAAA==
X-CMS-MailID: 20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012
References: <CGME20201218153043epcas5p1831d9bc440e9e05609792f19dfeb4012@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The size parameter is unsigned long type which can accept
size > 4GB. In that case, the upper limit address must be
programmed. Add support to program the upper limit
address and set INCREASE_REGION_SIZE in case size > 4GB.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 8 ++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 28c56a1..7eba3b2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -290,12 +290,16 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
 			   lower_32_bits(cpu_addr + size - 1));
+	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
+			   upper_32_bits(cpu_addr + size - 1));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
 			   lower_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
-	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, type |
-			   PCIE_ATU_FUNC_NUM(func_no));
+	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = upper_32_bits(size - 1) ?
+		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
+	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR2, PCIE_ATU_ENABLE);
 
 	/*
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index b09329b..28b72fb 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -106,6 +106,7 @@
 #define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
 #define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
 #define PCIE_ATU_UPPER_TARGET		0x91C
+#define PCIE_ATU_UPPER_LIMIT		0x924
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
 #define PCIE_DBI_RO_WR_EN		BIT(0)
-- 
2.7.4

