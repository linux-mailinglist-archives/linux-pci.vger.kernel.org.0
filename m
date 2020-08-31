Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA22257C28
	for <lists+linux-pci@lfdr.de>; Mon, 31 Aug 2020 17:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgHaPSh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Aug 2020 11:18:37 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:7156 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgHaPSe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Aug 2020 11:18:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1598887114; x=1630423114;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eH58IyTxq1bGrzWsPvkVg+srdd+BLp80k+swpu7gV3M=;
  b=ochWFT4rQf9OifsZH8XVjxCi1K1Yq8nu7tMAZftxU7T3mQXd1w6ERsG+
   Gs3eIQbJvIt6XjHdd3aXOM/iKrIPIkr0mFUekNlk4PC3rmbnT0xHpFVnt
   9vK06q9vQ66idzCLcjRNtR6O/W7YPctFeT6SPRg+jTVu0mSvCatcFY4qp
   M=;
X-IronPort-AV: E=Sophos;i="5.76,376,1592870400"; 
   d="scan'208";a="64236674"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-81e76b79.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 31 Aug 2020 15:18:30 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2b-81e76b79.us-west-2.amazon.com (Postfix) with ESMTPS id 4978DA0740;
        Mon, 31 Aug 2020 15:18:30 +0000 (UTC)
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 15:18:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13d01UWB002.ant.amazon.com (10.43.161.136) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 31 Aug 2020 15:18:29 +0000
Received: from dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (172.19.34.216)
 by mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 31 Aug 2020 15:18:28 +0000
Received: by dev-dsk-csbisa-2a-37939146.us-west-2.amazon.com (Postfix, from userid 800212)
        id 77A279090; Mon, 31 Aug 2020 15:18:27 +0000 (UTC)
Date:   Mon, 31 Aug 2020 15:18:27 +0000
From:   Clint Sbisa <csbisa@amazon.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>, <csbisa@amazon.com>,
        <benh@kernel.crashing.org>
Subject: [PATCH] arm64: Enable PCI write-combine resources under sysfs
Message-ID: <20200831151827.pumm2p54fyj7fz5s@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using write-combine is crucial for performance of PCI devices where
significant amounts of transactions go over PCI BARs.

arm64 supports write-combine PCI mappings, so the appropriate define
has been added which will expose write-combine mappings under sysfs
for prefetchable PCI resources.

Signed-off-by: Clint Sbisa <csbisa@amazon.com>
---
 arch/arm64/include/asm/pci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
index 70b323cf8300..b33ca260e3c9 100644
--- a/arch/arm64/include/asm/pci.h
+++ b/arch/arm64/include/asm/pci.h
@@ -17,6 +17,7 @@
 #define pcibios_assign_all_busses() \
 	(pci_has_flag(PCI_REASSIGN_ALL_BUS))
 
+#define arch_can_pci_mmap_wc() 1
 #define ARCH_GENERIC_PCI_MMAP_RESOURCE	1
 
 extern int isa_dma_bridge_buggy;
-- 
2.23.3

