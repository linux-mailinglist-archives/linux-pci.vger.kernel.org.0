Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A39525658
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 22:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358357AbiELUZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 May 2022 16:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358355AbiELUZc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 May 2022 16:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0D9A2734F6
        for <linux-pci@vger.kernel.org>; Thu, 12 May 2022 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652387129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=A+SVmp8Ec1mwAnRL9D+3Iqr0uC2bLC542T8P5rVpM1s=;
        b=CrzK61ujNxPSTtk6EOrmI6j45klHbzDNFH+pQqEHYDQ4hjg4Y42WMKsBIqrMQ0RQP0YIr+
        /86q+K8w3zzXroyBnZazpE/EUCrI2ckYNUaDB/xt9Skr0nSXPRpAXrgq/mfsHqgqMJsJAC
        4xb7Pwb++NGtODSTqrTNM0iV774B5dA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-qKjpMjsnNjyiSDCCJcbD4Q-1; Thu, 12 May 2022 16:25:24 -0400
X-MC-Unique: qKjpMjsnNjyiSDCCJcbD4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92FC1101A52C;
        Thu, 12 May 2022 20:25:23 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 993EA2026D6A;
        Thu, 12 May 2022 20:25:12 +0000 (UTC)
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
Subject: [PATCH v8 0/1] x86/PCI: Ignore E820 reservations for bridge windows on future systems
Date:   Thu, 12 May 2022 22:25:10 +0200
Message-Id: <20220512202511.34197-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is v8 of my patch to address the E820 reservations vs PCI host bridge
ranges issue which are causing touchpad and/or thunderbolt issues on many
different laptop models.

After previous attemps to identify these systems by looking for E820
reservations covering the entire bridge window, which broke the boot
on some coreboot based ChromeBooks we are now back to using a bios date
based approach.

Changes in v8:
- Change the cut-off for no longer excluding E820 reservations from
  the bridge window to BIOS year >= 2023 so that this only applies to
  upcoming systems.
- Use DMI quirks for existing systems on which excluding E820
  reservations from the _CRS returned bridge window is an issue.

This is based on top of Bjorn's pci/resource branch:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/resource

Regards,

Hans


Hans de Goede (1):
  x86/PCI: Ignore E820 reservations for bridge windows on future systems

 .../admin-guide/kernel-parameters.txt         |   9 ++
 arch/x86/include/asm/pci_x86.h                |   2 +
 arch/x86/pci/acpi.c                           | 109 +++++++++++++++++-
 arch/x86/pci/common.c                         |   8 ++
 4 files changed, 126 insertions(+), 2 deletions(-)

-- 
2.36.0

