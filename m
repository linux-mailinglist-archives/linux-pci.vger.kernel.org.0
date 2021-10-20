Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52BC4348D6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 12:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhJTKXa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Oct 2021 06:23:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230005AbhJTKXa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Oct 2021 06:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634725275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fjeeaJAmGc/cJBLCzFRMTsi0zmxugYUYz3uW8vaj7aU=;
        b=aodgZagBMXzRtgq1aWMR5bH2B44t7U8GqaaBZcSQrAAyP3BjjoPn4xaihQnlBXd8nXjP8S
        5pHxKRYV0U6bfkusFroCdbx29yeMGPREZ8YAEONkL8RS+07kTJUg+kvFqAW8F5ceD0WOcc
        sWmcYPQizqSQcSnul13If0wLZ48ORYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-7RHTl5KvOlyTzHNR3iEUkw-1; Wed, 20 Oct 2021 06:21:12 -0400
X-MC-Unique: 7RHTl5KvOlyTzHNR3iEUkw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED5D180A5C1;
        Wed, 20 Oct 2021 10:21:09 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.195.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0430C19C79;
        Wed, 20 Oct 2021 10:21:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] x86/PCI: Fix compile errors when CONFIG_PCI is disabled
Date:   Wed, 20 Oct 2021 12:21:02 +0200
Message-Id: <20211020102102.86577-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

arch/x86/include/asm/pci_x86.h uses a number of data -types and defines
without including the headers which define these.

Instead so far it has been relying on files including it including the
necessary headers first.

Recently a include <asm/pci_x86.h> was added to arch/x86/kernel/resource.c
which does not include the necessary headers first.

Add the missing includes to arch/x86/include/asm/pci_x86.h to fix the
compile errors (with certain .config-s) when it is included from
arch/x86/kernel/resource.c.

Fixes: f10507a66e36 ("x86/PCI: Ignore E820 reservations for bridge windows on newer systems")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/x86/include/asm/pci_x86.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/pci_x86.h b/arch/x86/include/asm/pci_x86.h
index 0bb4e7dd0ffc..c5413d8007ed 100644
--- a/arch/x86/include/asm/pci_x86.h
+++ b/arch/x86/include/asm/pci_x86.h
@@ -5,7 +5,10 @@
  *	(c) 1999 Martin Mares <mj@ucw.cz>
  */
 
+#include <linux/errno.h>
+#include <linux/init.h>
 #include <linux/ioport.h>
+#include <linux/spinlock.h>
 
 #undef DEBUG
 
-- 
2.31.1

