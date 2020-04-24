Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85481B7683
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 15:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgDXNJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 09:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727841AbgDXNJx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Apr 2020 09:09:53 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C8C09B046;
        Fri, 24 Apr 2020 06:09:42 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 0E5F92049B;
        Fri, 24 Apr 2020 13:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1587733782; bh=VqVf1ASdzF0mph1JscNNTGrBSOytUtYK/LkjCoO+ue4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7hS1uuSINiqM5LIQhtaB9TGW1dbjFaqU6B2raa61CeHBRx0dV1iEWn5zndLPy1cd
         D4lFsNgbovY041pMwKh9GRqII/nB4lpmDsUm+YmxMcW4Lhtsz/d2hsgr1do/s8fmCi
         mB9Bh/8kNpYkL677XCbu+8EeJsVgcFYjc7dcQXnbaJKzox2cMSFMX6a5gLkSx0nYn+
         4qqaQumRgS6Y3lIT8fQJ/zOLC4fY+g0wNQaAgm5lVwb7NrAbXuFdnDnYzwuyaUAcH3
         lzuFbDuvT7Sh8uqEz9P9Cjs90DPkC5/PXfye32SXA8I7PLuqTHE9Ox9irnLMgPUwIk
         JjheGpcrsStsQ==
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-pci@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Paul Burton <paulburton@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v5 1/6] PCI: OF: Don't remap iospace on unsupported platform
Date:   Fri, 24 Apr 2020 21:08:32 +0800
Message-Id: <20200424130847.328584-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
References: <20200424130847.328584-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are some platforms that don't support I/O space remapping
like MIPS. However, our PCI code will try to remap iospace
unconditionally and reject io resources on these platforms.

So we should remove I/O space remapping check and use a range
check instead on these platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
--
v4: Fix a typo in commit message.
v5: Commit message massage
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
+				dev_warn(dev, "resource %pR out of the I/O range\n",
+					res);
+				resource_list_destroy_entry(win);
+			}
+#endif
 			break;
 		case IORESOURCE_MEM:
 			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
-- 
2.26.0.rc2

