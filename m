Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E4B239DEA
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 05:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbgHCDxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 Aug 2020 23:53:13 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60580 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgHCDxN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 2 Aug 2020 23:53:13 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 43EC2891B2;
        Mon,  3 Aug 2020 15:53:09 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596426789;
        bh=QyXhMPzrP1ywAXT26zbyvUCAWusApigo/oSgJG0v9js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GBFoFTF8xKLnQzXrkjkMC6ZrPXQWLUR57g6iInsgJnpL8G7YcnbjRWF1vm8fGKba0
         Jf/05B6kxWJaMiLLkyAhTKv9hBF+g1nuvGFG7f76cQE2WspZJIunYvPuttV1dODUkp
         Yd9BnRWax7MS3AWTCmW87CN5zHG7XXzK4gre+4t6vrmESCCXFVRFWzrrvagt7Ret+K
         WcgPjkGsUFJqdP8PWrOtMXrUMpDHBzovPpGmGVAXlTxHo6udLZD08gC89XjtOPD2RT
         yYKglyP5MBoZ2lI0biu3cGRb5pMP8/KxTLEFdz8V71yjkIEWDfZbbHmnm7L1ANJxru
         1Cz4JbxHbAqCA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f278a250001>; Mon, 03 Aug 2020 15:53:09 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 3EA9213EEDE;
        Mon,  3 Aug 2020 15:53:08 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 1FBBD33EB8D; Mon,  3 Aug 2020 15:53:09 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH v3 2/2] PCI: Reduce warnings on possible RW1C corruption
Date:   Mon,  3 Aug 2020 15:52:41 +1200
Message-Id: <20200803035241.7737-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803035241.7737-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200803035241.7737-1-mark.tomlinson@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For hardware that only supports 32-bit writes to PCI there is the
possibility of clearing RW1C (write-one-to-clear) bits. A rate-limited
messages was introduced by fb2659230120, but rate-limiting is not the
best choice here. Some devices may not show the warnings they should if
another device has just produced a bunch of warnings. Also, the number
of messages can be a nuisance on devices which are otherwise working
fine.

This patch changes the ratelimit to a single warning per bus. This
ensures no bus is 'starved' of emitting a warning and also that there
isn't a continuous stream of warnings. It would be preferable to have a
warning per device, but the pci_dev structure is not available here, and
a lookup from devfn would be far too slow.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Fixes: fb2659230120 ("PCI: Warn on possible RW1C corruption for sub-32 bi=
t config writes")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/pci/access.c | 9 ++++++---
 include/linux/pci.h  | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..ab85cb7df9b6 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -160,9 +160,12 @@ int pci_generic_config_write32(struct pci_bus *bus, =
unsigned int devfn,
 	 * write happen to have any RW1C (write-one-to-clear) bits set, we
 	 * just inadvertently cleared something we shouldn't have.
 	 */
-	dev_warn_ratelimited(&bus->dev, "%d-byte config write to %04x:%02x:%02x=
.%d offset %#x may corrupt adjacent RW1C bits\n",
-			     size, pci_domain_nr(bus), bus->number,
-			     PCI_SLOT(devfn), PCI_FUNC(devfn), where);
+	if (!bus->unsafe_warn) {
+		dev_warn(&bus->dev, "%d-byte config write to %04x:%02x:%02x.%d offset =
%#x may corrupt adjacent RW1C bits\n",
+			 size, pci_domain_nr(bus), bus->number,
+			 PCI_SLOT(devfn), PCI_FUNC(devfn), where);
+		bus->unsafe_warn =3D true;
+	}
=20
 	mask =3D ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 	tmp =3D readl(addr) & mask;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34c1c4f45288..5b6ab593ae09 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -613,6 +613,7 @@ struct pci_bus {
 	unsigned char	primary;	/* Number of primary bridge */
 	unsigned char	max_bus_speed;	/* enum pci_bus_speed */
 	unsigned char	cur_bus_speed;	/* enum pci_bus_speed */
+	bool		unsafe_warn;	/* warned about RW1C config write */
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
 	int		domain_nr;
 #endif
--=20
2.28.0

