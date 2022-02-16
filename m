Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5C64B8BF5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Feb 2022 16:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbiBPPCK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Feb 2022 10:02:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235271AbiBPPCI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Feb 2022 10:02:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DFF525D7
        for <linux-pci@vger.kernel.org>; Wed, 16 Feb 2022 07:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645023714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+UqUVIxbZMl/kcmiE8/GxYjkclUR25EltdZ3iz7ajFc=;
        b=T53Ooawqo75CqLL5FwRtQ99lnuPIIhTPyg3ACLf+YhjTItraU/sfdXWZV8wXvrlqkKO7dV
        KaZukubhBCTsSxnpoOdlObLLP0wQ3GTKFEGB0dMCRsEhOwhrBPAoRLhbAy4wGrkBaUY42w
        RLvQc3n8QTjFjH76vrwQm7OqzpRE8+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-205-2EqMt_uvN3mCv4_iGsuUqQ-1; Wed, 16 Feb 2022 10:01:50 -0500
X-MC-Unique: 2EqMt_uvN3mCv4_iGsuUqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EA19100C612;
        Wed, 16 Feb 2022 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4F05170D58;
        Wed, 16 Feb 2022 15:01:27 +0000 (UTC)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] x86/PCI: Disable exclusion of E820 reserved addresses in some cases
Date:   Wed, 16 Feb 2022 16:01:20 +0100
Message-Id: <20220216150121.9400-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Here is a new patch to try and address the exclusion of E820 reserved
addresses from PCI bridge windows causing issues on some systems.

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

 arch/x86/include/asm/pci_x86.h |  8 +++++
 arch/x86/kernel/resource.c     |  4 +++
 arch/x86/pci/acpi.c            | 65 +++++++++++++++++++++++++++++++++-
 3 files changed, 76 insertions(+), 1 deletion(-)

-- 
2.33.1

