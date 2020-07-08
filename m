Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0852183A0
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 11:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGHJal (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 05:30:41 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58106 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbgGHJal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 05:30:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0689UVkr077802;
        Wed, 8 Jul 2020 04:30:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594200631;
        bh=ZG1VUcH+6tOwwV7BnhCzX/gBAhx0Ee8zky2NKNJPpXQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HJahAXyB6Z34ypn9y3jD+pIOIszCEcBFXiT4dOI4C47tZpeT4idB2dcYMSf+Pcm3X
         rvC3YooTWdS92WgLE11+7NCWgNIDAn5oO29UMV4hunsoPtDFhwn047EPfVZ7w5k+q2
         JXirucwvxnKF81rbsau43+Fbp22nnFtogulMNh+M=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0689UVG8021580;
        Wed, 8 Jul 2020 04:30:31 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 8 Jul
 2020 04:30:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 8 Jul 2020 04:30:30 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0689UJEJ098512;
        Wed, 8 Jul 2020 04:30:27 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 02/14] linux/kernel.h: Add PTR_ALIGN_DOWN macro
Date:   Wed, 8 Jul 2020 15:00:06 +0530
Message-ID: <20200708093018.28474-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708093018.28474-1-kishon@ti.com>
References: <20200708093018.28474-1-kishon@ti.com>
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

Acked-by: Rob Herring <robh@kernel.org>
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

