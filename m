Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC133A7BBF
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 12:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhFOK2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 06:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34080 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhFOK2F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jun 2021 06:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623752761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPwGu3AZNzkT9qCQUBVRwqD7gIDQLKuJf6PBWBraPfA=;
        b=Grkkq6WNCFcatIX8/hED0OlS1HADlzuXnJAA+NmjECP2Pby5+C9tdyLaCc9p9e0X0+H2UU
        FORrRgppoH8bjMRCjxmxxgsCzrWq+QAl3d60glaYkP0ASY/U3uiGkMtl0kS0AdEtgUewOv
        /UxhST+AfAf+yNN++JgTF06rL7sF5Og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-cZ_fxNPqMuq04f6DzgYTEg-1; Tue, 15 Jun 2021 06:26:00 -0400
X-MC-Unique: cZ_fxNPqMuq04f6DzgYTEg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA6528018A7;
        Tue, 15 Jun 2021 10:25:58 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-81.ams2.redhat.com [10.36.113.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9145E5D9CA;
        Tue, 15 Jun 2021 10:25:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [RFC 1/1] PCI/ACPI: Make acpi_pci_root_validate_resources() reject IOMEM resources which start at address 0
Date:   Tue, 15 Jun 2021 12:25:55 +0200
Message-Id: <20210615102555.6035-2-hdegoede@redhat.com>
In-Reply-To: <20210615102555.6035-1-hdegoede@redhat.com>
References: <20210615102555.6035-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some Lenovo laptops the base-addrsss of some PCI devices is left
at 0 at boot:

[    0.283145] pci 0000:00:15.0: [8086:34e8] type 00 class 0x0c8000
[    0.283217] pci 0000:00:15.0: reg 0x10: [mem 0x00000000-0x00000fff 64bit]
[    0.285117] pci 0000:00:15.1: [8086:34e9] type 00 class 0x0c8000
[    0.285189] pci 0000:00:15.1: reg 0x10: [mem 0x00000000-0x00000fff 64bit]

There is a _CRS method for these devices, which simply returns the
configured 0 address. This is causing the PCI core to not assign
memory to these PCI devices and is causing these errors:

[    0.655335] pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
[    0.655337] pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]
[    0.655339] pci 0000:00:15.1: BAR 0: no space for [mem size 0x00001000 64bit]
[    0.655340] pci 0000:00:15.1: BAR 0: failed to assign [mem size 0x00001000 64bit]

This happens specifically for the designware I2C PCI devices on these
laptops, causing I2C-HID attached touchpads/touchscreens to not work.

Booting with nocrs on these devices results in the kernel itself
assigning memory to these devices, fixing things:

[    0.355716] pci 0000:00:15.0: BAR 0: assigned [mem 0x29c000000-0x29c000fff 64bit]
[    0.355783] pci 0000:00:15.1: BAR 0: assigned [mem 0x29c001000-0x29c001fff 64bit]

At least the following models are known to be affected by this (but there
might be more):

Lenovo IdeaPad 3 15IIL05 81WE
Lenovo IdeaPad 5 14IIL05 81YH

Add an extra check for the base-address being 0 to
acpi_pci_root_validate_resources() and reject IOMEM resources where this
is the case, to fix this issue.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1871793
BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1868899
BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-signed-hwe/+bug/1878279
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Note we could instead add the known to be affected models to the
pci_crs_quirks table in arch/x86/pci/acpi.c, but it is likely that more
systems are affected and a more generic fix seems better in general.
---
 drivers/acpi/pci_root.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index dcd593766a64..6cd2ca551005 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -686,6 +686,13 @@ static void acpi_pci_root_validate_resources(struct device *dev,
 		if (!(res1->flags & type))
 			goto next;
 
+		if ((type & IORESOURCE_MEM) && res1->start == 0) {
+			dev_info(dev, "host bridge window %pR (ignored, start address not set)\n",
+				 res1);
+			free = true;
+			goto next;
+		}
+
 		/* Exclude non-addressable range or non-addressable portion */
 		end = min(res1->end, root->end);
 		if (end <= res1->start) {
-- 
2.31.1

