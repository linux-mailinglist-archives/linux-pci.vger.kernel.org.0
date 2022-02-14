Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4754B5466
	for <lists+linux-pci@lfdr.de>; Mon, 14 Feb 2022 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355709AbiBNPSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Feb 2022 10:18:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344927AbiBNPSc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Feb 2022 10:18:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 228B547567
        for <linux-pci@vger.kernel.org>; Mon, 14 Feb 2022 07:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644851903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IshdftsTmc+LMshqQcqlEumOQktApNkIt4YE3EdRO1A=;
        b=TF8+zRXIzEuqF7iOMqh6wRItseSxp8PXGfNYeDc6/DEMNtPFw9i3dg2KIeEZPjpVwRvZ8u
        nsxdGd03agznySB+nzMuxe6Pu2MlkShQ+RpEIGlWLbJ5ju9qZEGDjG6lhQm/LFbdj4e2rk
        dMWcTkEkBs1kUpeJHHLcvB9h4/h6Ntc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-159-HVLcqTleMpCYtaMTa4B9jQ-1; Mon, 14 Feb 2022 10:18:20 -0500
X-MC-Unique: HVLcqTleMpCYtaMTa4B9jQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4104801B0C;
        Mon, 14 Feb 2022 15:18:17 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.192.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54DCC2A19C;
        Mon, 14 Feb 2022 15:18:01 +0000 (UTC)
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
Subject: [RFC 0/2] x86/PCI: Ignore EFI memmap MMIO entries
Date:   Mon, 14 Feb 2022 16:17:57 +0100
Message-Id: <20220214151759.98267-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is a new attempt at fixing the issue where on some laptops
there are EFI memmap MMIO entries covering the entire PCI bridge
mem window, causing Linux to be unable to find free space to
assign to unassigned BARs.

This is marked as RFC atm because I'm waiting for feedback from
testers.

Regards,

Hans


Hans de Goede (2):
  x86/e820: Map EFI_MEMORY_MAPPED_IO to a new E820_TYPE_MMIO type
  x86/PCI: Ignore EFI memmap MMIO entries

 arch/x86/include/asm/e820/types.h       |  3 +++
 arch/x86/include/asm/iommu.h            |  3 ++-
 arch/x86/kernel/e820.c                  |  5 +++++
 arch/x86/kernel/resource.c              |  4 ++++
 arch/x86/mm/ioremap.c                   |  1 +
 arch/x86/pci/mmconfig-shared.c          | 15 +++++++++++----
 arch/x86/platform/efi/efi.c             |  5 ++++-
 drivers/firmware/efi/libstub/x86-stub.c |  5 ++++-
 8 files changed, 34 insertions(+), 7 deletions(-)

-- 
2.33.1

