Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87BA51953F1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Mar 2020 10:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgC0J1L (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Mar 2020 05:27:11 -0400
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:56565 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbgC0J1L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 27 Mar 2020 05:27:11 -0400
X-Greylist: delayed 906 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Mar 2020 05:27:07 EDT
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:57 +0800
Received: from raymond-pc.zhaoxin.com (10.29.28.62) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 27 Mar
 2020 17:11:56 +0800
From:   Raymond Pang <RaymondPang-oc@zhaoxin.com>
To:     <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC:     <TonyWWang-oc@zhaoxin.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] PCI: Add ACS quirk for Zhaoxin's multi-function devices
Date:   Fri, 27 Mar 2020 17:11:47 +0800
Message-ID: <20200327091148.5190-3-RaymondPang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
References: <20200327091148.5190-1-RaymondPang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.29.28.62]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some Zhaoxin's endpoints are implemented as multi-function devices
without ACS capability. They actually don't support peer-to-peer
transactions. So add ACS quirk to declare DMA isolation.

Signed-off-by: Raymond Pang <RaymondPang-oc@zhaoxin.com>
---
 drivers/pci/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 3e0ca273f903..3f06496a3d4c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4767,6 +4767,10 @@ static const struct pci_dev_acs_enabled {
 	{ PCI_VENDOR_ID_BROADCOM, 0xD714, pci_quirk_brcm_acs },
 	/* Amazon Annapurna Labs */
 	{ PCI_VENDOR_ID_AMAZON_ANNAPURNA_LABS, 0x0031, pci_quirk_al_acs },
+	/* Zhaoxin multi-function devices */
+	{ PCI_VENDOR_ID_ZHAOXIN, 0x3038, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_ZHAOXIN, 0x3104, pci_quirk_mf_endpoint_acs },
+	{ PCI_VENDOR_ID_ZHAOXIN, 0x9083, pci_quirk_mf_endpoint_acs },
 	{ 0 }
 };
 
-- 
2.26.0

