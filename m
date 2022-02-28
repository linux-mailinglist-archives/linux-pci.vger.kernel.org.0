Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08AC4C68FB
	for <lists+linux-pci@lfdr.de>; Mon, 28 Feb 2022 11:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233514AbiB1K4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Feb 2022 05:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbiB1Ky6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Feb 2022 05:54:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B203B193FD
        for <linux-pci@vger.kernel.org>; Mon, 28 Feb 2022 02:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646045597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4T8Uvp57TFU5Petlm3lZYbx4MZCWOM5rrxCxQpNIp9Y=;
        b=hrKuSolpZ3zT8uPOcbaUnnHb9TdWuhCIzxR+qEKZ4PFKthill8+6pjPb6vpUNDwO7DtDfU
        4HGzQcijz8RXOlOXhJJiqWrvpsRixX/uxryAT3enBTuFRCPq8ikeU71JI+de2KAedSG6kk
        vM19gh4AA9prZBUSLttE5JvtU1uK1Dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-i5atVmE0PVmVTs2N7rir6Q-1; Mon, 28 Feb 2022 05:53:14 -0500
X-MC-Unique: i5atVmE0PVmVTs2N7rir6Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66E2F8031E1;
        Mon, 28 Feb 2022 10:53:12 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.193.120])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D8506C92C;
        Mon, 28 Feb 2022 10:53:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        =?UTF-8?q?Benoit=20Gr=C3=A9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] x86/PCI: Disable exclusion of E820 reserved addressed in some cases
Date:   Mon, 28 Feb 2022 11:52:58 +0100
Message-Id: <20220228105259.230903-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is v2 of my patch to address the exclusion of E820 reserved
addresses from PCI bridge windows causing issues on some systems.

This fixes a couple of issues found by the kernel test robot:

- Add a couple of missing includes to arch/x86/include/asm/pci_x86.h
  to fix i386 build errors Reported-by: kernel test robot <lkp@intel.com>
- Do not call resource_is_efi_mmio_region() on resource-list entries which
  have just been destroyed because they match resource_is_pcicfg_ioport()
  Reported-by: kernel test robot <oliver.sang@intel.com>
- Add (res->flags & IORESOURCE_MEM) check to resource_is_efi_mmio_region()

Sorry about not catching these during my own testing.

For reference here is the v1 cover-letter:

Since the previous attempt at fixing this (commit 7f7b4236f204 ("x86/PCI:
Ignore E820 reservations for bridge windows on newer systems")) we have
learned that excluding E820 reserved addresses from PCI bridge windows
helps to workaround issues where the ACPI _CRS advertised window for
the bridge overlaps with some mem addresses which we should not touch,
so just disabling it on most new systems turns out to not be a good idea.

This new patch instead takes a very narrow approach. On all the systems
where we end up having issues to allocate PCI BARs this is caused by there
being a MMIO EFI memmap entry which covers the entire ACPI _CRS advertised
window for the PCI bridge.  This new patch makes use of this by making
pci_acpi_root_prepare_resources() check for those specific set of
conditions and when these exact conditions are met, then disable the
exclusion of E820 reserved addresses from PCI bridge windows, to fix
the PCI BAR allocation failures.

This has been successfully tested on one of the laptops where we were
seeing PCI BAR allocation failures, see:
https://bugzilla.redhat.com/show_bug.cgi?id=1868899

I've also tested this on a X1C8 and the new "host bridge window %pR is
marked by EFI as MMIO" message does not show up there as expected.

Regards,

Hans


Hans de Goede (1):
  x86/PCI: Disable exclusion of E820 reserved addressed in some cases

 arch/x86/include/asm/pci_x86.h | 10 +++++
 arch/x86/kernel/resource.c     |  4 ++
 arch/x86/pci/acpi.c            | 68 +++++++++++++++++++++++++++++++++-
 3 files changed, 81 insertions(+), 1 deletion(-)

-- 
2.35.1

