Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B7030BA3E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 09:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhBBIsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 03:48:38 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:46386 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbhBBIsh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Feb 2021 03:48:37 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210202084754epoutp0439e82a5cd9f8d40f108fdd383c77dee8~f4f5wMsND1026910269epoutp04f
        for <linux-pci@vger.kernel.org>; Tue,  2 Feb 2021 08:47:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210202084754epoutp0439e82a5cd9f8d40f108fdd383c77dee8~f4f5wMsND1026910269epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1612255674;
        bh=9ywKhdDTtBn3L2XcRNpTuOIXa0fWWZM7h+1A/Zcw8zE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=C4Q2oIVggb1eggSjWKwme1XJCWX8W2qr2Em5kkQ8oDKbB7P/sLmpWWgf1l3fhMxQ7
         bWgLwQMPTJp5jKzlAsrN5KP5ARQ5U08KXnK318Q1H8S8/fnpOsbA3msQHcls6Ur5vb
         SMes/WJMjgqjg0Imi7ctRgWGTyyRmpePFy+urHEc=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210202084753epcas5p291ba80de4715cea02b809aea310fce1a~f4f4-cLhP2708227082epcas5p2b;
        Tue,  2 Feb 2021 08:47:53 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AB.44.33964.9B119106; Tue,  2 Feb 2021 17:47:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210202072903epcas5p43dd06fede21ea3a31961b811507fb7f7~f3bDNF9Kd2209222092epcas5p4-;
        Tue,  2 Feb 2021 07:29:03 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210202072903epsmtrp16119f63f255121615ffa35fab9b34520~f3bDMTcWE2135921359epsmtrp1F;
        Tue,  2 Feb 2021 07:29:03 +0000 (GMT)
X-AuditID: b6c32a4b-eb7ff700000184ac-c2-601911b9735a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        43.4B.08745.E3FF8106; Tue,  2 Feb 2021 16:29:02 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210202072857epsmtip1242282d003a92d3e8521ab83acdf2b2d~f3a_fwgRZ0218902189epsmtip18;
        Tue,  2 Feb 2021 07:28:57 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, robh@kernel.org, lorenzo.pieralisi@arm.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        pankaj.dubey@samsung.com, sriram.dash@samsung.com,
        niyas.ahmed@samsung.com, p.rajanbabu@samsung.com,
        l.mehra@samsung.com, hari.tv@samsung.com,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH v3] PCI: dwc: Add upper limit address for outbound iATU
Date:   Tue,  2 Feb 2021 12:58:38 +0530
Message-Id: <1612250918-19610-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCmlu5OQckEgwUTNCyWNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        11rcWM/uwOexZt4aRo+ds+6yeyzYVOqxaVUnm0ffllWMHlv2f2b0+LxJLoA9issmJTUnsyy1
        SN8ugSvj3IJHbAXtQhWdt7ezNzCu5u9i5OSQEDCRWHygnbGLkYtDSGA3o8S0z9uZIZxPjBLP
        Ju1lA6kSEvjMKNH+RBWmY/q0TywQRbsYJXbuWgrV0cIkcX7uHFaQKjYBLYnGr13MILaIgLXE
        4fYtbCBFzAJbmSQWvl/PCJIQFnCXuHsMwmYRUJW4s2QXmM0r4Cox5dpZdoh1chI3z3UyQ9gv
        2SXuHYM63EVi051PTBC2sMSr41ug6qUkXva3Qdn5ElMvPAU6lQPIrpBY3lMHEbaXOHBlDliY
        WUBTYv0ufYiwrMTUU+vAJjIL8En0/n4CNZ1XYsc8GFtZ4svfPSwQtqTEvGOXWSGme0hMOOsC
        YgoJxEq0vNedwCg7C2H+AkbGVYySqQXFuempxaYFxnmp5XrFibnFpXnpesn5uZsYwSlEy3sH
        46MHH/QOMTJxMB5ilOBgVhLhPTVJLEGINyWxsiq1KD++qDQntfgQozQHi5I47w6DB/FCAumJ
        JanZqakFqUUwWSYOTqkGpj7vZJuJXj9uHRTsf2O0Re7B64u6YX/ORs40qntz4ZeuGY+wb0Ka
        fe658+e7kpkMbpyY1bSyct4Kvo0nMyaIr1y12IPDJPzk8T0X4kLMds43CDPXjH+1mCn4SsG0
        2ZcyOQUMrEz6HVRZt4QfT03TZrE4y2QdeiTfQ5PzjfdrPvv+3pSI9Fyh51NeTv9l/6TtR1zR
        6jvznoaEpdx9s773/OuFd8S0H82XOnXzYZiDiUfpw++SuZsCK7O81hhW2d0QmMiseMp/9tV4
        pZzCk8lbsjeE9nUHHw2fNmH2q2rp6EuFuU1HJhs497OW7gi/9jfrbfu9vjh981kNF4Mu3F3Y
        8lCscf+q13wr62a7ila/UmIpzkg01GIuKk4EAJmxZcmQAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsWy7bCSnK7df4kEg7MvTCyWNGVY7LrbwW7x
        cdpKJosVX2ayW9x5foPR4vKuOWwWZ+cdZ7N48/sFu8WTKY9YLY5uDLZYtPULu8X/PTvYLXoP
        11rcWM/uwOexZt4aRo+ds+6yeyzYVOqxaVUnm0ffllWMHlv2f2b0+LxJLoA9issmJTUnsyy1
        SN8ugSvj3IJHbAXtQhWdt7ezNzCu5u9i5OSQEDCRmD7tEwuILSSwg1FizUtZiLikxOeL65gg
        bGGJlf+es0PUNDFJzNpnCGKzCWhJNH7tYgaxRQRsJe4/mszaxcjFwSxwmEli5vyXYA3CAu4S
        d4+tZwSxWQRUJe4s2QVm8wq4Sky5dpYdYoGcxM1zncwTGHkWMDKsYpRMLSjOTc8tNiwwykst
        1ytOzC0uzUvXS87P3cQIDkotrR2Me1Z90DvEyMTBeIhRgoNZSYT31CSxBCHelMTKqtSi/Pii
        0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4pRqY1jr96zIR+rZ4YqTLnl+hv//w
        pcYfmK8R0xjHbbvufbzJd/H/G8+cWxnyvvrL/Vufy473Flv9rDjIaFoeave/43zy7+MCjOue
        OnVbzt5hHbB69aIND5LzY6wfunQptNWyZWWF3JVnac75pSXp6s/7n0Pb/tPmfzcn+L86Ftu9
        YMdpbo3Kw+qBSnq7p8gypG7aWWgqKfFI3e3U00z1Y3ltgUV6stKNFTpa6ukG6yMaMn0re3Wq
        q5gOyFck1As9/nB28RzWPgXugDirLn3lqxP25W8/ou/14dfNadvtwyXWV/w8p8Zuo/fvoMhb
        HiXV4ukVM79lNkTzf1mxftOHSb0Tb97KvLfVjLu0vavmha0SS3FGoqEWc1FxIgAgT5hnuQIA
        AA==
X-CMS-MailID: 20210202072903epcas5p43dd06fede21ea3a31961b811507fb7f7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210202072903epcas5p43dd06fede21ea3a31961b811507fb7f7
References: <CGME20210202072903epcas5p43dd06fede21ea3a31961b811507fb7f7@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The size parameter is unsigned long type which can accept size > 4GB. In
that case, the upper limit address must be programmed. Add support to
program the upper limit address and set INCREASE_REGION_SIZE in case size >
4GB.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v1: https://lkml.org/lkml/2020/12/20/187
v2:
   Addressed Rob's review comment and added PCI version check condition to
   avoid writing to reserved registers.
v3:
   Rebased on pci/dwc branch

 drivers/pci/controller/dwc/pcie-designware.c | 5 +++++
 drivers/pci/controller/dwc/pcie-designware.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index bfacdb3..dc23ece 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -332,11 +332,16 @@ static void __dw_pcie_prog_outbound_atu(struct dw_pcie *pci, u8 func_no,
 			   upper_32_bits(cpu_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LIMIT,
 			   lower_32_bits(cpu_addr + size - 1));
+	if (pci->version >= 0x460A)
+		dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_LIMIT,
+				   upper_32_bits(cpu_addr + size - 1));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_LOWER_TARGET,
 			   lower_32_bits(pci_addr));
 	dw_pcie_writel_dbi(pci, PCIE_ATU_UPPER_TARGET,
 			   upper_32_bits(pci_addr));
 	val = type | PCIE_ATU_FUNC_NUM(func_no);
+	val = ((upper_32_bits(size - 1)) && (pci->version >= 0x460A)) ?
+		val | PCIE_ATU_INCREASE_REGION_SIZE : val;
 	if (pci->version == 0x490A)
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_dbi(pci, PCIE_ATU_CR1, val);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d8d2e0a..7247c8b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -100,6 +100,7 @@
 #define PCIE_ATU_DEV(x)			FIELD_PREP(GENMASK(23, 19), x)
 #define PCIE_ATU_FUNC(x)		FIELD_PREP(GENMASK(18, 16), x)
 #define PCIE_ATU_UPPER_TARGET		0x91C
+#define PCIE_ATU_UPPER_LIMIT		0x924
 
 #define PCIE_MISC_CONTROL_1_OFF		0x8BC
 #define PCIE_DBI_RO_WR_EN		BIT(0)
-- 
2.7.4

