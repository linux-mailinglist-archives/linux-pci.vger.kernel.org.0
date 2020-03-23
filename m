Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F09F818EEB1
	for <lists+linux-pci@lfdr.de>; Mon, 23 Mar 2020 04:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgCWDzz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Mar 2020 23:55:55 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:48955 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCWDzy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Mar 2020 23:55:54 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 897B38364E;
        Mon, 23 Mar 2020 16:55:52 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1584935752;
        bh=arKzCGTNZ3XHcJI7hEnNga0sxrR8a0d5XhKmL+vIvH0=;
        h=From:To:Cc:Subject:Date;
        b=eE/fIqo/J2742MGioqhShvbmZB8EaATKK0wEKnrbCbfBVvGH6sA1H0b7CAyUkVU6g
         B49PYrH/LxEpLLI2Wjle504geDWmZoiZn2B5edbG2OipExbRHc3ME4/sK8Qv6Qcmle
         h8jVmLe8E/06Fg1K9oXzRdrueqdUqFOSXDINTxzgA0XTbCDC2KuXt7DftBHXSY8hHW
         WJmbOIeAZSYOLqRGPiuSbUjBOgLMbBJiCJ6A4ka2/qZ599MDXDFoMitxaasazVx0KL
         sWqgCybmWNMbIOVh6eLENy6hSpyKJxl5llvwc5M+DYF8taPohwXEZ/0G/zGS46RvUL
         kXUbLCmDPY+bQ==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e7833430000>; Mon, 23 Mar 2020 16:55:52 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 415AB13EEB7;
        Mon, 23 Mar 2020 16:55:46 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 4B07A28006C; Mon, 23 Mar 2020 16:55:47 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] PCI/ASPM: Reduce severity of log message
Date:   Mon, 23 Mar 2020 16:55:30 +1300
Message-Id: <20200323035530.11569-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the UEFI/BIOS or bootloader has not initialised a PCIe device we
would get the following message.

  kern.warning: pci 0000:00:01.0: ASPM: current common clock configuratio=
n is broken, reconfiguring

"warning" and "broken" are slightly misleading. On an embedded system it
is quite possible for the bootloader to avoid configuring PCIe devices
if they are not needed.

Downgrade the message to pci_info() and change "broken" to
"inconsistent" since we fix up the inconsistency in the code immediately
following the message (and emit an error if that fails).

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
I'm updating a system from an older kernel to the latest and our tests fl=
agged
this error message. I don't believe it's actually an error since our boot=
loader
doesn't touch the PCI bus (infact the kernel releases the reset to that
particular device before the PCI bus scan).

 drivers/pci/pcie/aspm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 0dcd44308228..3a165ab3413b 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -273,7 +273,7 @@ static void pcie_aspm_configure_common_clock(struct p=
cie_link_state *link)
 		}
 		if (consistent)
 			return;
-		pci_warn(parent, "ASPM: current common clock configuration is broken, =
reconfiguring\n");
+		pci_info(parent, "ASPM: current common clock configuration is inconsis=
tent, reconfiguring\n");
 	}
=20
 	/* Configure downstream component, all functions */
--=20
2.25.1

