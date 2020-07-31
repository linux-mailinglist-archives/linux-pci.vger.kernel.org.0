Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBF233DC6
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jul 2020 05:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgGaDkT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jul 2020 23:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731356AbgGaDkT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2020 23:40:19 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9FEC061575
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2020 20:40:16 -0700 (PDT)
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 24583891B0;
        Fri, 31 Jul 2020 15:40:10 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596166810;
        bh=QyXhMPzrP1ywAXT26zbyvUCAWusApigo/oSgJG0v9js=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=sJieyIcuSWEYih5V68ENnpm4Chl+d0iygWUWLe+S5LlAg6iKxRrA7r81ZKASRWDrM
         P8whcraJ/uuN/G0hamgmHhHI4wY4eImTxvSu5Fd3aVf9V2jz1msOl3Rr2xgBjkHOWN
         7sSLMis8pbZydqFtM5F1QagwPrb1C67paRq73roApiRgdVPDvOQQBbjORbHjPA1PLC
         Aoo2WOM3PDdRSPlJrD/8BDnE10p+CsH04/4AoQf08CzWZbxryho1SaCaivaaWO68Tp
         l6VBvaz0uQws+MGySqSAJAcf4p1KvV7v0+cO7c60cf6OVqqzVE99cu3o6dW3RlK4SV
         a+KTZO70DJUcg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f23929a0001>; Fri, 31 Jul 2020 15:40:10 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 3386013EEFA;
        Fri, 31 Jul 2020 15:40:09 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id DB97433ECD0; Fri, 31 Jul 2020 15:40:09 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH v2 2/2] PCI: Reduce warnings on possible RW1C corruption
Date:   Fri, 31 Jul 2020 15:39:56 +1200
Message-Id: <20200731033956.6058-2-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200731033956.6058-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20200731033956.6058-1-mark.tomlinson@alliedtelesis.co.nz>
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

