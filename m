Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02B7CB0F79
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 15:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731871AbfILNCc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 09:02:32 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:54260 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731810AbfILNCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 09:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568293351; x=1599829351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cFgtLcVnGrPNy52atQN20rg2h5EbDP7J3d0LSQoZ0yw=;
  b=ovrm98+fR31ikq0upSah1aoXIH7/SWVcn1o+UyBRlj5DZKjasDmVDsR0
   cpNHSJWd5nnsfv9TucYVba05uxEz3fjW+xkMVV5lhUiZ+MsIuV6l+TCsV
   jhJ3cp7/+/wYNy8PLgTZkeFX+Y21LBxRhvtzrrklWpK8YnEfZj/NIzTyl
   s=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702155736"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 13:01:47 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id BAA18A0600;
        Thu, 12 Sep 2019 13:01:39 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:39 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.43.161.82) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 13:01:33 +0000
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <andrew.murray@arm.com>, <dwmw@amazon.co.uk>,
        <benh@kernel.crashing.org>, <alisaidi@amazon.com>,
        <ronenk@amazon.com>, <barakw@amazon.com>, <talel@amazon.com>,
        <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Subject: [PATCH v6 1/7] PCI: Add Amazon's Annapurna Labs vendor ID
Date:   Thu, 12 Sep 2019 16:00:39 +0300
Message-ID: <20190912130042.14597-2-jonnyc@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190912130042.14597-1-jonnyc@amazon.com>
References: <20190912130042.14597-1-jonnyc@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.82]
X-ClientProxiedBy: EX13D02UWC003.ant.amazon.com (10.43.162.199) To
 EX13D13UWA001.ant.amazon.com (10.43.160.136)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Amazon's Annapurna Labs vendor ID to pci_ids.h.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index f59a6f98900c..f3130542c752 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2571,6 +2571,8 @@
 
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
 
+#define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
+
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
 
-- 
2.17.1

