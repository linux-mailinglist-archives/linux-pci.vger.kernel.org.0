Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75643D25F1
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 16:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhGVOAL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 10:00:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232105AbhGVOAL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Jul 2021 10:00:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4FB1261285;
        Thu, 22 Jul 2021 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626964846;
        bh=AGW0hEbHDYJfNl3F7CYdm1S5nOzQVn1ScB3D2nURFRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eb3fufsYCU4t7fcug59aWAmrzfXf1tFWAQ+4babi5AQuBdAi+RH23vQgyPO+5OxRf
         5vPeVJKu1DTIBzcFK6K/Wh7WFjNoiUkRL7oM6cMq5mLtXpP5r1TbZZiAiYbLb9mPv6
         RzXGkpOJpBxc3rq2BNur2l1KD4hr7nJR5jcjG5oOpMp4EBG80v79aG6y6h45N6Muif
         SKcL76bcbZMwjdfHZ+oP4K7xf5hl59tdVuLQddvmRe6C6keBwO7G14C8YEKbV+u1F2
         bPK0NigCGyZhSazT3SKsMCYnGejxfecvLkAl27ZnVnycOJKae/asLmmPn8xfkS3Hhq
         5itqPDCGjrIqQ==
Received: by pali.im (Postfix)
        id 72076133C; Thu, 22 Jul 2021 16:40:44 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] PCI: aardvark: Increase polling delay to 1.5s while waiting for PIO response
Date:   Thu, 22 Jul 2021 16:40:39 +0200
Message-Id: <20210722144041.12661-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722144041.12661-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
 <20210722144041.12661-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Measurements in different conditions showed that aardvark hardware PIO
response can take up to 1.44s. Increase wait timeout from 1ms to 1.5s to
ensure that we do not miss responses from hardware. After 1.44s hardware
returns errors (e.g. Completer abort).

The previous two patches fixed checking for PIO status, so now we can use
it to also catch errors which are reported by hardware after 1.44s.

After applying this patch, kernel can detect and print PIO errors to dmesg:

    [    6.879999] advk-pcie d0070000.pcie: Non-posted PIO Response Status: CA, 0xe00 @ 0x100004
    [    6.896436] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100004
    [    6.913049] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100010
    [    6.929663] advk-pcie d0070000.pcie: Non-posted PIO Response Status: CA, 0xe00 @ 0x100010
    [    6.953558] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100014
    [    6.970170] advk-pcie d0070000.pcie: Non-posted PIO Response Status: CA, 0xe00 @ 0x100014
    [    6.994328] advk-pcie d0070000.pcie: Posted PIO Response Status: COMP_ERR, 0x804 @ 0x100004

Without this patch kernel prints only a generic error to dmesg:

    [    5.246847] advk-pcie d0070000.pcie: config read/write timed out

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org # 7fbcb5da811b ("PCI: aardvark: Don't rely on jiffies while holding spinlock")
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index a74ac8addeae..ebb48530024c 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -166,7 +166,7 @@
 #define PCIE_CONFIG_WR_TYPE0			0xa
 #define PCIE_CONFIG_WR_TYPE1			0xb
 
-#define PIO_RETRY_CNT			500
+#define PIO_RETRY_CNT			750000 /* 1.5 s */
 #define PIO_RETRY_DELAY			2 /* 2 us*/
 
 #define LINK_WAIT_MAX_RETRIES		10
-- 
2.20.1

