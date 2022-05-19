Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F10652D75D
	for <lists+linux-pci@lfdr.de>; Thu, 19 May 2022 17:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240831AbiESPWT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 May 2022 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiESPWO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 May 2022 11:22:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 588BB63BD0
        for <linux-pci@vger.kernel.org>; Thu, 19 May 2022 08:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652973730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ga+pMSw4nCAG4T6JtURNSSSM6yGJYnLTOmMdWB8RbA=;
        b=Dh3gcZB4qJjBmt+qzdHpAAGpuvKFLw/9pVm/KtHrADj5tBWvGEHgXljpTyDCIxXHP/4/3p
        PDVSgu23S867o8MI5Ztd5+yJZw1FPsY5nImbs2z98xt6XJ/rsVcqg3eNeEk3v8y9V8WxwT
        OIhpIwX1DDJnWD3lcw5DKrf2aDuavWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-KHB65mE8MGW1siHPSrgNnA-1; Thu, 19 May 2022 11:22:07 -0400
X-MC-Unique: KHB65mE8MGW1siHPSrgNnA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 161E285A5BB;
        Thu, 19 May 2022 15:22:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C79B31121314;
        Thu, 19 May 2022 15:22:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v9 3/3] x86/PCI: Ignore E820 reserved regions for bridge windows on future systems
Date:   Thu, 19 May 2022 17:21:50 +0200
Message-Id: <20220519152150.6135-4-hdegoede@redhat.com>
In-Reply-To: <20220519152150.6135-1-hdegoede@redhat.com>
References: <20220519152150.6135-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some BIOS-es contain bugs where they add addresses which are already
used in some other manner to the PCI host bridge window returned by
the ACPI _CRS method. To avoid this Linux by default excludes
E820 reserved regions when allocating addresses since 2010, see:
commit 4dc2287c1805 ("x86: avoid E820 regions when allocating address
space").

Recently (2019) some systems have shown-up with E820 reserved regions
which cover the entire _CRS returned PCI bridge memory window, causing
all attempts to assign memory to PCI BARs which have not been setup by
the BIOS to fail. For example here are the relevant dmesg bits from
a Lenovo IdeaPad 3 15IIL 81WE:

 [mem 0x000000004bc50000-0x00000000cfffffff] reserved
 pci_bus 0000:00: root bus resource [mem 0x65400000-0xbfffffff window]
 pci 0000:00:15.0: BAR 0: no space for [mem size 0x00001000 64bit]
 pci 0000:00:15.0: BAR 0: failed to assign [mem size 0x00001000 64bit]

The ACPI specifications appear to allow this new behavior:

The relationship between E820 and ACPI _CRS is not really very clear.
ACPI v6.3, sec 15, table 15-374, says AddressRangeReserved means:

  This range of addresses is in use or reserved by the system and is
  not to be included in the allocatable memory pool of the operating
  system's memory manager.

and it may be used when:

  The address range is in use by a memory-mapped system device.

Furthermore, sec 15.2 says:

  Address ranges defined for baseboard memory-mapped I/O devices, such
  as APICs, are returned as reserved.

A PCI host bridge qualifies as a baseboard memory-mapped I/O device,
and its apertures are in use and certainly should not be included in
the general allocatable pool, so the fact that some BIOS-es reports
the PCI aperture as "reserved" in E820 doesn't seem like a BIOS bug.

So it seems that removing/clipping E820 reserved regions from the PCI
host bridge windows is a mistake.

Outright removing the code that clips E820 entries is known to cause
regressions on various existing systems. Some examples of such systems:

Asus C523NA (Coral) Chromebook
Dell Precision T3500, for details see:
https://bugzilla.kernel.org/show_bug.cgi?id=16228
Lenovo ThinkPad X1 gen 2, for details see:
https://bugzilla.redhat.com/show_bug.cgi?id=2029207

To avoid regressions stop clipping E820 entries on future systems
(DMI BIOS year >= 2023) only.

Quoting from:
https://lore.kernel.org/linux-pci/20220518220754.GA7911@bhelgaas/

The decision to do this is based on weighing to following pro/cons:

Without a date check, we'll continue clipping by default:

  - Future systems like Lenovo *IIL*, Acer Spin, and Clevo Barebones
    will require new quirks to disable clipping.

  - The problem here is E820 entries that cover entire _CRS windows
    that should not be clipped out.

  - I think these E820 entries are legal per spec, and it would be
    hard to get BIOS vendors to change them.

  - We will discover new systems that need clipping disabled piecemeal
    as they are released.

  - Future systems like Lenovo X1 Carbon and the Chromebooks (probably
    anything using coreboot) will just work and we will not notice new
    ones that rely on the clipping.

  - BIOS updates will not require new quirks unless they change the
    DMI model string.

With a date check that disables clipping, e.g., "no clipping when
date >= 2023":

  - Future systems like Lenovo *IIL*, Acer Spin, and Clevo Barebones
    will just work without new quirks.

  - Future systems like Lenovo X1 Carbon and the Chromebooks will
    require new quirks to *enable* clipping.

  - The problem here is that _CRS contains regions that are not usable
    by PCI devices, and we rely on the E820 kludge to clip them out.

  - I think this use of E820 is clearly a firmware bug, so we have a
    fighting chance of getting it changed eventually.

  - BIOS updates after the cutoff date *will* require quirks, but only
    for systems like Lenovo X1 Carbon and Chromebooks that we already
    think have broken firmware.

It seems to me like it's better to add quirks for firmware that we think
is broken than for firmware that seems unusual but correct.

Cc: Benoit Grégoire <benoitg@coeus.ca>
Cc: Hui Wang <hui.wang@canonical.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v9:
- Split making use_e820=false the default for BIOS year >= 2023 out
  into this new patch
---
 arch/x86/pci/acpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/pci/acpi.c b/arch/x86/pci/acpi.c
index b88bdfba7908..82b1c93ac04b 100644
--- a/arch/x86/pci/acpi.c
+++ b/arch/x86/pci/acpi.c
@@ -234,6 +234,24 @@ void __init pci_acpi_crs_quirks(void)
 	if (year >= 0 && year < 2008 && iomem_resource.end <= 0xffffffff)
 		pci_use_crs = false;
 
+	/*
+	 * Some BIOS-es contain bugs where they add addresses which are already
+	 * used in some other manner to the PCI host bridge window returned by
+	 * the ACPI _CRS method. To avoid this Linux by default excludes
+	 * E820 reservations when allocating addresses since 2010.
+	 * In 2019 some systems have shown-up with E820 reservations which cover
+	 * the entire _CRS returned PCI host bridge window, causing all attempts
+	 * to assign memory to PCI BARs to fail if Linux uses E820 reservations.
+	 *
+	 * Ideally Linux would fully stop using E820 reservations, but then
+	 * various old systems will regress. Instead stop using E820 reservations
+	 * for new systems with a DMI BIOS year >= 2023;
+	 * and use DMI quirks for existing systems on which excluding E820
+	 * reservations is known to cause issues.
+	 */
+	if (year >= 2023)
+		pci_use_e820 = false;
+
 	dmi_check_system(pci_crs_quirks);
 
 	/*
-- 
2.36.0

