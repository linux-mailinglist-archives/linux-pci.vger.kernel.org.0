Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D263F3B38C8
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhFXVgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 17:36:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232591AbhFXVgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 17:36:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3A7F613B7;
        Thu, 24 Jun 2021 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624570441;
        bh=ticgXE7CjNhWfVymrLf5bGBpQYvv4IhRaSX2oXSsd1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=je0lJSUkjWr6LfhmkY1QEILZbvNQwe8wmPRM/TrXmK1AjiIKFHuB5dK1TjC7vQ2H7
         Q+UUhqcw18blwKk+JBNE3j0MipA4pwbaSgSAdQFmLp3kvMHKKS4ddIwQQcwamz0iVN
         nxxI57PuJUXjYyGchYvhyN1SQmiVVMPbpfY5XDkpBuYg6nbc3mzQWK5y02BX8c88nr
         OVCSxio5AaC3KGaYE71Wy3udYilJBd7MCUobi0VF1BINrS/Bpvim0YyMtsJ67auJrt
         SRXRGezrr+rG7w29mktUwxw9KHlWRSrBqBV+7p7YFPcAhSVPlhZFzf0+IJ62u5NJDl
         Up2vvC69POWNQ==
Received: by pali.im (Postfix)
        id 0E1EB96D; Thu, 24 Jun 2021 23:33:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 1/3] PCI: aardvark: Fix checking for PIO Non-posted Request
Date:   Thu, 24 Jun 2021 23:33:43 +0200
Message-Id: <20210624213345.3617-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210624213345.3617-1-pali@kernel.org>
References: <20210624213345.3617-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PIO_NON_POSTED_REQ for PIO_STAT register is incorrectly defined. Bit 10 in
register PIO_STAT indicates the response is to a non-posted request.

Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <kabel@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index e3f5e7ab7606..2f8380a1f84f 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -57,7 +57,7 @@
 #define   PIO_COMPLETION_STATUS_UR		1
 #define   PIO_COMPLETION_STATUS_CRS		2
 #define   PIO_COMPLETION_STATUS_CA		4
-#define   PIO_NON_POSTED_REQ			BIT(0)
+#define   PIO_NON_POSTED_REQ			BIT(10)
 #define PIO_ADDR_LS				(PIO_BASE_ADDR + 0x8)
 #define PIO_ADDR_MS				(PIO_BASE_ADDR + 0xc)
 #define PIO_WR_DATA				(PIO_BASE_ADDR + 0x10)
-- 
2.20.1

