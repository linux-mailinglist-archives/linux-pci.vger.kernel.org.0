Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD404F35D
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbfFVDjD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jun 2019 23:39:03 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38198 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbfFVDjD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 21 Jun 2019 23:39:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 120A6991F0451A546662;
        Sat, 22 Jun 2019 11:39:01 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 22 Jun 2019 11:38:53 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] dt-bindings: 83xx-512x-pci: Drop cell-index property
Date:   Sat, 22 Jun 2019 11:45:57 +0800
Message-ID: <20190622034557.196097-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

28eac2b74cc7 ("powerpc/fsl: Remove cell-index from PCI nodes"),
and for now it is still not used, drop it from doc.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 Documentation/devicetree/bindings/pci/83xx-512x-pci.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt b/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
index b9165b72473c..3abeecf4983f 100644
--- a/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
+++ b/Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
@@ -9,7 +9,6 @@ Freescale 83xx and 512x SOCs include the same PCI bridge core.
 
 Example (MPC8313ERDB)
 	pci0: pci@e0008500 {
-		cell-index = <1>;
 		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
 		interrupt-map = <
 				/* IDSEL 0x0E -mini PCI */
-- 
2.20.1

