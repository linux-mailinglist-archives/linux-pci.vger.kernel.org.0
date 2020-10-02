Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D742817C9
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 18:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgJBQXV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 12:23:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55606 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgJBQXV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 12:23:21 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kONq3-00050Y-1E; Fri, 02 Oct 2020 16:23:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        linux-pci@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI/ASPM: fix an unintended sign extension of a u16
Date:   Fri,  2 Oct 2020 17:23:18 +0100
Message-Id: <20201002162318.93555-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The multiplication of the u16 variable 'value' causes it to be
prompted to a int type and this is then sign extended to a u64.
When the result of the multiplication is > 0x7fffffff the upper
bits are all unitentionally set to 1 on a sign extension operation.
Fix this by explicitly casting value to a u64 to avoid the int
type promotion and the following sign extension.

Addresses-Coverity: ("Unintended sign extension")
Fixes: 5ccf2a6e483f ("PCI/ASPM: Add support for LTR _DSM")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/pci/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index db8feb2033e7..736197f9094b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3083,8 +3083,8 @@ static u64 pci_ltr_decode(u16 latency)
 	case 1: return value * 32;
 	case 2: return value * 1024;
 	case 3: return value * 32768;
-	case 4: return value * 1048576;
-	case 5: return value * 33554432;
+	case 4: return (uint64_t)value * 1048576;
+	case 5: return (uint64_t)value * 33554432;
 	}
 	return 0;
 }
-- 
2.27.0

