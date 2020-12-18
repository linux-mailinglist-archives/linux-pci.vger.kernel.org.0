Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351202DEBC2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Dec 2020 23:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgLRWva (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 17:51:30 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:52252 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgLRWv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 17:51:27 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201218225043epoutp01b0ede7438de370b4d8c50f82c2b1a6a3~R8UpuKL000591505915epoutp01T
        for <linux-pci@vger.kernel.org>; Fri, 18 Dec 2020 22:50:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201218225043epoutp01b0ede7438de370b4d8c50f82c2b1a6a3~R8UpuKL000591505915epoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1608331843;
        bh=qmJ6MBsH2JlVTRk0oWIBvfavnlcYbg8BSsz4vkManxU=;
        h=From:To:Cc:Subject:Date:References:From;
        b=OFsbGKIOohHt3WPTazQexfw+Qm/zYiia2yGwcLIQUCYO5GUCG9ycnfutbLu7Y9gBS
         4zJeOZpC+8n5+6+rdaZx22eLv6gWp7HHosDFNPWGysjxLCgiP1LQ0TUMKGTaQXa7ey
         vi4ew3R3/FHOv8ewh3FJv6i41Sied30EBaZshxwM=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20201218225042epcas5p4de74e4f1d0d64ff06f330eb322c83faf~R8UonJfzi2377123771epcas5p4-;
        Fri, 18 Dec 2020 22:50:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.D1.33964.2423DDF5; Sat, 19 Dec 2020 07:50:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20201218153422epcas5p42f09cbf8e40b3d68e3c037256e54d97c~R2XqHAEXd0338803388epcas5p41;
        Fri, 18 Dec 2020 15:34:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201218153422epsmtrp218f4b169215282c1a6400f93f3c4fa6b~R2XqGUJPS0358503585epsmtrp2b;
        Fri, 18 Dec 2020 15:34:22 +0000 (GMT)
X-AuditID: b6c32a4b-ea1ff700000184ac-ce-5fdd3242564c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.7F.08745.DFBCCDF5; Sat, 19 Dec 2020 00:34:22 +0900 (KST)
Received: from ubuntu.sa.corp.samsungelectronics.net (unknown
        [107.108.83.125]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201218153420epsmtip2af3d10892d030863cd035a092a86b5f8~R2XomA0270089100891epsmtip2Y;
        Fri, 18 Dec 2020 15:34:20 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        pankaj.dubey@samsung.com, Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH] PCI: dwc: Change size to u64 for EP outbound iATU
Date:   Fri, 18 Dec 2020 21:04:08 +0530
Message-Id: <1608305648-31816-1-git-send-email-shradha.t@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7bCmpq6T0d14g643GhZLmjIsdt3tYLdY
        8WUmu8XlXXPYLM7OO85m8eb3C3aLRVu/sFv837OD3aL3cK0Dp8eaeWsYPXbOusvusWBTqcem
        VZ1sHn1bVjF6bNn/mdHj8ya5APYoLpuU1JzMstQifbsEroyVK9sZC/7yVPyY+IW5gfEeVxcj
        J4eEgInEpWuf2bsYuTiEBHYzSiw+uJARwvnEKLG7bQsLhPOZUeLplkuMMC3Lj96HatnFKHHi
        5D82CKeFSeLG6j1MIFVsAloSjV+7mEFsEQFricPtW8CKmAX2MEr8WHQfrEhYwEni0YNbYGNZ
        BFQlvl37zAZi8wq4Sjzt3cUGsU5O4ua5TmaQZgmBY+wSR569ZIJIuEj8Of6aFcIWlnh1fAs7
        hC0l8fndXqjmfImpF54CPcEBZFdILO+pgwjbSxy4MgcszCygKbF+lz5EWFZi6ql1YNOZBfgk
        en8/gdrEK7FjHoytLPHl7x4WCFtSYt6xy1AXeEisugFxspBArETnrSOsExhlZyFsWMDIuIpR
        MrWgODc9tdi0wDgvtVyvODG3uDQvXS85P3cTIzg5aHnvYHz04IPeIUYmDsZDjBIczEoivKEP
        bscL8aYkVlalFuXHF5XmpBYfYpTmYFES51X6cSZOSCA9sSQ1OzW1ILUIJsvEwSnVwGTFf9vJ
        bUdIQX+/5I4PkbEJPlpZf1luKpg8FzxjzP5r9oIuMR42ZTkp4WKNqauY5/zdfshKYrvWl2sa
        V/KLy2qnJqY9P2S22HL97L+KS/fff1jy55yxvxnbUk3h/jatsNTTVZFiMa6zbWetXLdwYtGp
        /m93RTqiC1+XdnWbaV5WzbXrFKyWfzKjoXbRzIWlGe78ylG/3x+2u2mu+JnZV6H31PRK3+rm
        K2kMEj1NN9US/7zyZJZ0Zlsc1LpSsrndz3J2VtqvfVdZCrXDL380WtP29M0a/RfbGF1rLSMq
        vv/g/fakfWfAmZMH1glum+l54aSPS9yjzwK7twlMnVlU8n0v37WdL959Fdnl6rLnkBJLcUai
        oRZzUXEiAOwK/wp9AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprALMWRmVeSWpSXmKPExsWy7bCSvO6/03fiDZ40Mlssacqw2HW3g91i
        xZeZ7BaXd81hszg77zibxZvfL9gtFm39wm7xf88Odovew7UOnB5r5q1h9Ng56y67x4JNpR6b
        VnWyefRtWcXosWX/Z0aPz5vkAtijuGxSUnMyy1KL9O0SuDJWrmxnLPjLU/Fj4hfmBsZ7XF2M
        nBwSAiYSy4/eZwexhQR2MEpMn24EEZeU+HxxHROELSyx8t9zoBouoJomJomnd5vBEmwCWhKN
        X7uYQWwRAVuJ+48ms4IUMQscYZToeXCXDSQhLOAk8ejBLUYQm0VAVeLbtc9gcV4BV4mnvbvY
        IDbISdw818k8gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4EDT0trBuGfV
        B71DjEwcjIcYJTiYlUR4Qx/cjhfiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2
        ampBahFMlomDU6qBaf2uc6f5DyRGlq1Zw9wjPOP6pg+/vlkYeKzcdItZlHEphw/PHHeTaiWN
        VRsqZLT8r60R2H8mS8FOO3Lig94ZJXcDClONU/xC8hV1eKOmRohs4DSX9i1hqAxvXnIwJ37Z
        +6cN96LDGt9kCHOc15pj8iwlYQJv85TwQ7vmVfhxPQxe1V9p+K3viq/HpqJTTfse2f791Ob4
        SzvtS9fquDfhbetbdd9ImClySli96Fn5gVFXs/tOL7NOQ/qXub/27DV58GVS6b2C6y8++cWq
        LIkTKGOLfLfxS1qP8V6dD1Zps5qzbvB8N1uU8W7yvcYZeRmXfjDXF3TqxmQ8n5qYElL89cWK
        01FeK/xeP5v8w/qBEktxRqKhFnNRcSIAO7Vu2KMCAAA=
X-CMS-MailID: 20201218153422epcas5p42f09cbf8e40b3d68e3c037256e54d97c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20201218153422epcas5p42f09cbf8e40b3d68e3c037256e54d97c
References: <CGME20201218153422epcas5p42f09cbf8e40b3d68e3c037256e54d97c@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since outbound iATU permits size to be greater than
4GB for which the support is also available, allow
EP function to send u64 size instead of truncating
to u32.

Signed-off-by: Shradha Todi <shradha.t@samsung.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 +-
 drivers/pci/controller/dwc/pcie-designware.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 7eba3b2..6298212 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -325,7 +325,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
 
 void dw_pcie_prog_ep_outbound_atu(struct dw_pcie *pci, u8 func_no, int index,
 				  int type, u64 cpu_addr, u64 pci_addr,
-				  u32 size)
+				  u64 size)
 {
 	__dw_pcie_prog_outbound_atu(pci, func_no, index, type,
 				    cpu_addr, pci_addr, size);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 28b72fb..bb33f28 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -307,7 +307,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
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

