Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3921ADDAF
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 14:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgDQM6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 08:58:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47174 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729828AbgDQM6V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 Apr 2020 08:58:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HCw5Bn013732;
        Fri, 17 Apr 2020 07:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587128285;
        bh=ANKUGmxjcIwlV3rIaZN/J5tOLrnX04VnB9EtUZpb2tU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vJyLydBbBLghDDKzGmRc4DlmcG68d0v5qQX4ps6ix7y5Wj/WoI7eSRdDPlnDeVPSD
         5dwvxqb/ScdadpKBLv9PbtSwTHDnzKQ0RnR+hA2V1WBCLz2H4k31lh9Z79DphA/PdB
         SdvuHmSScJ3mDfRYb/dp6dSedpamZCqRY4UiyHxw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HCw5kN056755
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 07:58:05 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 07:58:05 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 07:58:05 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HCvsD7031089;
        Fri, 17 Apr 2020 07:58:02 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/14] linux/kernel.h: Add PTR_ALIGN_DOWN macro
Date:   Fri, 17 Apr 2020 18:27:41 +0530
Message-ID: <20200417125753.13021-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417125753.13021-1-kishon@ti.com>
References: <20200417125753.13021-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a macro for aligning down a pointer. This is useful to get an
aligned register address when a device allows only word access and
doesn't allow half word or byte access.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 include/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 9b7a8d74a9d6..c3b361b5be54 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -34,6 +34,7 @@
 #define ALIGN_DOWN(x, a)	__ALIGN_KERNEL((x) - ((a) - 1), (a))
 #define __ALIGN_MASK(x, mask)	__ALIGN_KERNEL_MASK((x), (mask))
 #define PTR_ALIGN(p, a)		((typeof(p))ALIGN((unsigned long)(p), (a)))
+#define PTR_ALIGN_DOWN(p, a)	((typeof(p))ALIGN_DOWN((unsigned long)(p), (a)))
 #define IS_ALIGNED(x, a)		(((x) & ((typeof(x))(a) - 1)) == 0)
 
 /* generic data direction definitions */
-- 
2.17.1

