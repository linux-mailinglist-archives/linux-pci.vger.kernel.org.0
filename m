Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2419C37573A
	for <lists+linux-pci@lfdr.de>; Thu,  6 May 2021 17:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhEFPdq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 May 2021 11:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:45828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235147AbhEFPdp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 May 2021 11:33:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 28B1761104;
        Thu,  6 May 2021 15:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620315167;
        bh=ticgXE7CjNhWfVymrLf5bGBpQYvv4IhRaSX2oXSsd1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M7KJ+oKkDugqW1SIubabh+zVXWcvfilXeQofjOvulJH5lqSyxMlYCXZqKJGZftFch
         tQgvE47XG8DnWi+gpTZyv6uOvnSVyVmLA7Dg9wOGHxdC8J/8+gEN5Q+bivDBT1qXrK
         6FHe5MX1xciUQFjZdGKjOKDw2dvqmsAPUt54bp/idv22QxVN2PyBQVGC5LefR2twWS
         m2eKpXwvT6v6AZgH6opcZnT+Kpqt27R5V5SMWNRvH9bLg0RQbIlyBcvqD3QNMqlDBN
         U/cEMW9uB64eXFYDlamrhzD25hdjIMb7OryPDz+aZkXcp6pt/AmnTkqu3/232lYgvS
         YRaf3iHQ/wyOQ==
Received: by pali.im (Postfix)
        id 938538A1; Thu,  6 May 2021 17:32:44 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Remi Pommarel <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/42] PCI: aardvark: Fix checking for PIO Non-posted Request
Date:   Thu,  6 May 2021 17:31:13 +0200
Message-Id: <20210506153153.30454-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506153153.30454-1-pali@kernel.org>
References: <20210506153153.30454-1-pali@kernel.org>
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

