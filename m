Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92351B02B3
	for <lists+linux-pci@lfdr.de>; Mon, 20 Apr 2020 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgDTHSF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Apr 2020 03:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTHSF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Apr 2020 03:18:05 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Apr 2020 00:18:05 PDT
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05712C061A0C;
        Mon, 20 Apr 2020 00:18:05 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id B7A1520C7E;
        Mon, 20 Apr 2020 07:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587366752; bh=1ni7V2KVE9MknDP4f9hczijTI6TI6s7uclRiTdIqcpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kxQ9fcFfuGwyQAlL0SBOY9EXY/jwSt5K3Wl2FGyOzlhWgzQgv3bu+3KwtQNmIW8Wt
         ditpsAPeT7OK5Y5atMvUwt0kqqd56FuPrusBF5WgyrjckNZQD8zIa4o6Yfgkd6CZOH
         3ekMfJ54qS3zJ9f1iW/dQu0rbQB6yve4Z+36QAoiqgq0ly8464rSM6zEs/j5P0FQhz
         bO/h0hh59EJ9osGFreFpiu6bZRzQlhd7UoEqSJMe2sJ2N88uRLyMb3wtQKxowNOvg0
         sop/ecLF0Rp/yfYbz+qUJHZd9jV2BD2ZE/PazJ7W55TVXdG29+qWEF4AYLgN5qEEcs
         dwwZOokLkRQ8w==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] PCI: OF: Don't remap iospace on unsupported platform
Date:   Mon, 20 Apr 2020 15:12:07 +0800
Message-Id: <20200420071220.155357-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are some platforms don't support iospace remapping
like MIPS. However, our PCI code will try to remap iospace
unconditionally and reject io resources on these platforms.

So we should remove iospace remapping check and use a range
check instead on these platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
--
v4: Fix a typo in commit message.
---
 drivers/pci/of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 81ceeaa6f1d5..36e8761b66c6 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -547,12 +547,21 @@ int pci_parse_request_of_pci_ranges(struct device *dev,
 
 		switch (resource_type(res)) {
 		case IORESOURCE_IO:
+#if defined(PCI_IOBASE) && defined(CONFIG_MMU)
 			err = devm_pci_remap_iospace(dev, res, iobase);
 			if (err) {
 				dev_warn(dev, "error %d: failed to map resource %pR\n",
 					 err, res);
 				resource_list_destroy_entry(win);
 			}
+#else
+			/* Simply check if IO is inside the range */
+			if (res->end > IO_SPACE_LIMIT) {
+				dev_warn(dev, "resource %pR out of the IO range\n",
+					res);
+				resource_list_destroy_entry(win);
+			}
+#endif
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-- 
2.26.0.rc2

