Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B664220F24
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGOO0C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jul 2020 10:26:02 -0400
Received: from lists.nic.cz ([217.31.204.67]:34852 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgGOO0A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 10:26:00 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 2FDD21405F6;
        Wed, 15 Jul 2020 16:25:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1594823158; bh=XjDxcdcVGrz+d5OePWpf+or5ePv31N9WBkAeqAIKxek=;
        h=From:To:Date;
        b=bU8BR0101pBkUmKJVcgQ51wZNhxpmIWt0MDyLAsrmrPDg1by3oLYvfdz3Z23/NFFb
         anAk2UB9AVdFC2UMYSNlaJ4+UearZa+q78qEJmLnyveufFAhBQdIzXk7/aBQVCMIX5
         kGyrc4VNQUyTSJnHvxZvEYmHTuJBHVz9G3HXiX1s=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     linux-pci@vger.kernel.org
Cc:     Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        kernel test robot <lkp@intel.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 1/5] PCI: aardvark: Fix compilation on s390
Date:   Wed, 15 Jul 2020 16:25:53 +0200
Message-Id: <20200715142557.17115-2-marek.behun@nic.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715142557.17115-1-marek.behun@nic.cz>
References: <20200715142557.17115-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.nic.cz
X-Spam-Status: No, score=0.00
X-Spamd-Bar: /
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Pali Rohár <pali@kernel.org>

Include linux/gpio/consumer.h instead of linux/gpio.h, as is said in the
latter file.

This was reported by kernel test bot when compiling for s390.

  drivers/pci/controller/pci-aardvark.c:350:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror,-Wimplicit-function-declaration]
  drivers/pci/controller/pci-aardvark.c:1074:21: error: implicit declaration of function 'devm_gpiod_get_from_of_node' [-Werror,-Wimplicit-function-declaration]
  drivers/pci/controller/pci-aardvark.c:1076:14: error: use of undeclared identifier 'GPIOD_OUT_LOW'

Link: https://lore.kernel.org/r/202006211118.LxtENQfl%25lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5169a9851da ("PCI: aardvark: Issue PERST via GPIO")
Signed-off-by: Pali Rohár <pali@kernel.org>
Reviewed-by: Marek Behún <marek.behun@nic.cz>
---
 drivers/pci/controller/pci-aardvark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..8caa80b19cf8 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -9,7 +9,7 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
-- 
2.26.2

