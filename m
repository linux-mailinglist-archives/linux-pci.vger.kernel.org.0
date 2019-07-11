Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBBF26596A
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jul 2019 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbfGKOxi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jul 2019 10:53:38 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:22229 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGKOxi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jul 2019 10:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1562856817; x=1594392817;
  h=from:to:cc:message-id:in-reply-to:references:
   mime-version:subject:resent-from:resent-cc:date:
   content-transfer-encoding;
  bh=6PsnZ60xKF4Mvc0cy+iEXp9w4rM1XglvTNVhZlgYFao=;
  b=KBh9k81Oh8l7kFh1IlN1pNFdGH1f6VXX3QhEm1kuT8MC99fJx1KYth0l
   I9mbWuShA5/VH12rioeO8KbF44aXI3JJSBdgslsh0KcEr5zm8u8tBJgHM
   VKJwo6olIbfhxtXQFrQJMXcNUcPeIBN9a1V+SQJfzky97DxyUphldjiqu
   4=;
X-IronPort-AV: E=Sophos;i="5.62,478,1554768000"; 
   d="scan'208";a="810658320"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Jul 2019 14:53:35 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-1c1b5cdd.us-west-2.amazon.com (Postfix) with ESMTPS id 2970BA226A;
        Thu, 11 Jul 2019 14:53:35 +0000 (UTC)
Received: from EX13D24UWB004.ant.amazon.com (10.43.161.4) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:53:34 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D24UWB004.ant.amazon.com (10.43.161.4) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Jul 2019 14:53:34 +0000
Received: from u9ff250417f405e.ant.amazon.com (10.107.0.52) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 11 Jul 2019 14:53:32 +0000
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Mailbox Transport; Wed, 10 Jul 2019 16:45:32 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Wed, 10 Jul 2019 16:45:32 +0000
Received: from email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com
 (10.25.10.214) by mail-relay.amazon.com (10.43.160.118) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Wed, 10 Jul 2019 16:45:32
 +0000
Received: by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix)
        id B8715A2356; Wed, 10 Jul 2019 16:45:31 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com
 (iad7-ws-svc-lb50-vlan3.amazon.com [10.0.93.214]) by
 email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS
 id CC9BAA1EF8; Wed, 10 Jul 2019 16:45:30 +0000 (UTC)
Received: from u9ff250417f405e.ant.amazon.com (localhost [127.0.0.1]) by
 u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Debian-10) with ESMTP id
 x6AGjQ24021402; Wed, 10 Jul 2019 19:45:26 +0300
Received: (from jonnyc@localhost)
        by u9ff250417f405e.ant.amazon.com (8.15.2/8.15.2/Submit) id x6AGjOtL021367;
        Wed, 10 Jul 2019 19:45:24 +0300
From:   Jonathan Chocron <jonnyc@amazon.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <alisaidi@amazon.com>, <ronenk@amazon.com>, <barakw@amazon.com>,
        <talel@amazon.com>, <hanochu@amazon.com>, <hhhawa@amazon.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <jonnyc@amazon.com>
Message-ID: <20190710164519.17883-2-jonnyc@amazon.com>
In-Reply-To: <20190710164519.17883-1-jonnyc@amazon.com>
References: <20190710164519.17883-1-jonnyc@amazon.com>
Content-Type: text/plain
MIME-Version: 1.0
Subject: [PATCH 1/8] PCI: Add Amazon's Annapurna Labs vendor ID
Date:   Thu, 11 Jul 2019 17:53:31 +0300
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Amazon's Annapurna Labs vendor ID to pci_ids.h.

Signed-off-by: Jonathan Chocron <jonnyc@amazon.com>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 0dd239f11e91..ed350fd522c6 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2568,6 +2568,8 @@
=20
 #define PCI_VENDOR_ID_ASMEDIA		0x1b21
=20
+#define PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS	0x1c36
+
 #define PCI_VENDOR_ID_CIRCUITCO		0x1cc8
 #define PCI_SUBSYSTEM_ID_CIRCUITCO_MINNOWBOARD	0x0001
=20
--=20
2.17.1


