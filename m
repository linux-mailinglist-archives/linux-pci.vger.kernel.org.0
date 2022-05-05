Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFC151C3C0
	for <lists+linux-pci@lfdr.de>; Thu,  5 May 2022 17:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380619AbiEEPYf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 May 2022 11:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381305AbiEEPYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 May 2022 11:24:32 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 757FD554A8
        for <linux-pci@vger.kernel.org>; Thu,  5 May 2022 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651764051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NOhqwWJm0Xg7KJkj4jc2xm55/msX/E/vXJVK7yWqZr8=;
        b=XdaKNQb6kRSCw+LgFTD+pGBqcE0tA9DWWjGkiCi9rFJOxazaYUQ633FSRYtHNT5nZlkvYE
        pfzNPR7xw9EEozhEJw1bg83K3ia0Q4yA8oNRDT0LMBilq2kgRdIll77rv9kIvEib85TSW9
        9TThnbLQMSZXW/F7GXSWNRmCdqM2uXE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-195-htru64m9OTylFJ3NnKPgnQ-1; Thu, 05 May 2022 11:20:46 -0400
X-MC-Unique: htru64m9OTylFJ3NnKPgnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF1A53C10229;
        Thu,  5 May 2022 15:20:40 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 032207B64;
        Thu,  5 May 2022 15:20:16 +0000 (UTC)
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
Subject: [PATCH v7 0/1] x86/PCI: Ignore E820 reservations for bridge windows on newer systems
Date:   Thu,  5 May 2022 17:20:15 +0200
Message-Id: <20220505152016.5059-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
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

Here is v7 of my patch to address the E820 reservations vs PCI host bridge
ranges issue which are causing touchpad and/or thunderbolt issues on many
different laptop models.

After previous attemps to identify these systems by looking for E820
reservations covering the entire bridge window, which broke the boot
on some coreboot based ChromeBooks we are now back to using a bios date
based approach, now combined with DMI quirks for systems after the
cutoff date which still report a wrong window from their _CRS method
despite them being new(ish).

This is based on top of Bjorn's pci/resource branch:
https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/log/?h=pci/resource

Regards,

Hans


Hans de Goede (1):
  x86/PCI: Ignore E820 reservations for bridge windows on newer systems

 .../admin-guide/kernel-parameters.txt         |  9 +++
 arch/x86/include/asm/pci_x86.h                |  2 +
 arch/x86/pci/acpi.c                           | 74 ++++++++++++++++++-
 arch/x86/pci/common.c                         |  6 ++
 4 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.36.0

