Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3B1A62AA
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 07:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgDMFmb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgDMFma (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Apr 2020 01:42:30 -0400
Received: from vultr.net.flygoat.com (vultr.net.flygoat.com [IPv6:2001:19f0:6001:3633:5400:2ff:fe8c:553])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DB6C008679;
        Sun, 12 Apr 2020 22:42:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2001:da8:20f:4430:250:56ff:fe9a:7470])
        by vultr.net.flygoat.com (Postfix) with ESMTPSA id 426DE20CF8;
        Mon, 13 Apr 2020 05:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com; s=vultr;
        t=1586756049; bh=KZzC8hDq/L5Ksu7mwvgHXdRRg3Pi1Gnhas1jIt28u50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P6bbNlDMWmSNeWxbTzqMAXSopRk5GTcT3hOk9EVI+P06pr2cQKJPJXaRNmAH1Cjr5
         Tul/Y9bSZiZKuQk/Ecxj3mXfrGlw8KEXRRQSYFXCiDOT7g1HnDGRZJRlm2NnQfr3VD
         v18Hr00bAcBGUtniaBxUttIrJp3YJ7n/UuwMy7kmZPtuGyD0v0NUWUmYc048QJ386l
         xcuS+gS52dRLW/XkBJj2Km6jdBkTIko+4+PTZ/akTepf+Y3zO9dxylZLSaM89rMkpj
         ih1/j7eteO0kf2zZ3Rnof/VFZnq1zHKOqIs6vFGUZdwMYCgCEvZoAW44AAaxjyd7Ft
         MlSNG/TLRgGYA==
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
Subject: [PATCH v3 1/5] PCI: OF: Don't remap iospace on unsupported platform
Date:   Mon, 13 Apr 2020 13:32:09 +0800
Message-Id: <20200413053222.3976680-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
References: <20200330114239.1112759-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are some platforms doesn't support iospace remapping
like MIPS. However, our PCI code will try to remap iospace
unconditionally and reject io resources on these platforms.

So we should remove iospace remapping check and use a range
check instead on these platforms.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
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

