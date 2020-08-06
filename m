Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E8523D5F9
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 06:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgHFEPL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 00:15:11 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:37543 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHFEPK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Aug 2020 00:15:10 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 1F1968011F;
        Thu,  6 Aug 2020 16:15:06 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1596687306;
        bh=y/TS5dY/e8pkHaHRXcCzB2vajvea5CBxtY3MHgzDUiw=;
        h=From:To:Cc:Subject:Date;
        b=Si2lRLsHzS9JXlt0wpsVDwE4y5ZY79wRzK0RtbWTtiIbLSzcsDamNJlBiLDap3SGy
         EXI5ZMv6egTG38LtOrV8PKLi/2Rro8+g84jMQ2A5erGNm0aUiEENYCyXbVrWoW4edt
         0ebmxxROMi+hkIrMqgYQxfO1mgBG1DEP72HAHsw8mm8Qxnvon5EhzWfFq2396w/Pb4
         oBRBmff6pdQfFea8rWtJqPzl6jMgDXh/lmLhyMKYjPJsqwiVFxGK7VokDxovweFpx+
         mcFN2mIbAXW5R2lWKYB1hv6Fqg4t3fS1U3Q5KIaLVLMFT8wgDM2CMTa7kKpLr282za
         kDepSIhcOb6XQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f2b83ca0000>; Thu, 06 Aug 2020 16:15:06 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id AB2EB13EEBA;
        Thu,  6 Aug 2020 16:15:04 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id CFB3E341096; Thu,  6 Aug 2020 16:15:05 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     ray.jui@broadcom.com, helgaas@kernel.org, sbranden@broadcom.com,
        f.fainelli@gmail.com, lorenzo.pieralisi@arm.com, robh@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
Date:   Thu,  6 Aug 2020 16:14:55 +1200
Message-Id: <20200806041455.11070-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
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
changes in v4:
 - Use bitfield rather than bool to save memory (was meant to be in v3).

 drivers/pci/access.c | 9 ++++++---
 include/linux/pci.h  | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 79c4a2ef269a..b452467fd133 100644
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
+		bus->unsafe_warn =3D 1;
+	}
=20
 	mask =3D ~(((1 << (size * 8)) - 1) << ((where & 0x3) * 8));
 	tmp =3D readl(addr) & mask;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 34c1c4f45288..85211a787f8b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -626,6 +626,7 @@ struct pci_bus {
 	struct bin_attribute	*legacy_io;	/* Legacy I/O for this bus */
 	struct bin_attribute	*legacy_mem;	/* Legacy mem */
 	unsigned int		is_added:1;
+	unsigned int		unsafe_warn:1;	/* warned about RW1C config write */
 };
=20
 #define to_pci_bus(n)	container_of(n, struct pci_bus, dev)
--=20
2.28.0

