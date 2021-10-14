Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D3842E176
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhJNSmE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 14:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231529AbhJNSmD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 14:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634236798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=+ni2awkqOA8DQJ0VSeHi5pmwnEX+NV6HLx5LM+Jk7/4=;
        b=K6cv7jPFestJO8rUGvaJkvJs1CkCrVCR7dkqYOzTR5qg7KLJlcElcFHQOTX4rTMKQ2QBa/
        HZ9MeU6xVu2A8iC+2BAZP9Qt8i3X0dsRV2CDCbYks9UC0PPjPxnCMH9DgEHXhv6aQkQtBH
        Vj0dGi80pU7ACqzJI5z/UuufyuoN/OE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-gFxsONaQNzye5NV0RJ59-Q-1; Thu, 14 Oct 2021 14:39:55 -0400
X-MC-Unique: gFxsONaQNzye5NV0RJ59-Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 504D81842154;
        Thu, 14 Oct 2021 18:39:53 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80BF757CA5;
        Thu, 14 Oct 2021 18:39:44 +0000 (UTC)
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
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] x86/PCI: Ignore E820 reservations for bridge windows on newer systems
Date:   Thu, 14 Oct 2021 20:39:41 +0200
Message-Id: <20211014183943.27717-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is v5 of my patch to address the E820 reservations vs PCI host bridge
windows issue which is causing touchpad and/or thunderbolt issues on many
different laptop models.

Changes in v5:
- Drop mention of Windows behavior from the commit msg, replace with a
  reference to the specs
- Improve documentation in Documentation/admin-guide/kernel-parameters.txt
- Reword the big comment added, use "PCI host bridge window" in it and drop
  all references to Windows
- Add a second patch moving the arch/x86/pci/acpi.c printk-s to pr_info/warn

Changes in v4:
- Rewrap the big comment block to fit in 80 columns

I believe that this is ready for merging now.

Bjorn, can you review/ack this please ?

x86/tip folks it would be ideal if you can pick this up and send at
least the first patch as a fix to Linus for 5.15. This fixes a bug which
has been plaguing a lot of users (see all the bug links in the commit msg).

Regards,

Hans


Hans de Goede (2):
  x86/PCI: Ignore E820 reservations for bridge windows on newer systems
  x86/PCI/ACPI: Replace printk calls with pr_info/pr_warn calls

 .../admin-guide/kernel-parameters.txt         |  9 ++++
 arch/x86/include/asm/pci_x86.h                | 10 ++++
 arch/x86/kernel/resource.c                    |  4 ++
 arch/x86/pci/acpi.c                           | 49 +++++++++++++++----
 arch/x86/pci/common.c                         |  6 +++
 5 files changed, 68 insertions(+), 10 deletions(-)

-- 
2.31.1

