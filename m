Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0390842DE57
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 17:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhJNPlb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 11:41:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231776AbhJNPl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 11:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634225963;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=HmEMMzM2iFuhalw9nXhuj98UjN3y0/BsxBxx9whXOng=;
        b=XZp+fNzmuolhN8h8VL1mZ1sSyA+sD/H5mMufBBJW8dhUiIY2m/76YzZMBZJ94XuYnezn9F
        EOdP9yS19qcArAfAMLjrJ4fW6TW8bvxCyqShiJDlI4UZgkVKF/WLIBpkNzfuSj38zi6dMX
        HadKuX1O81thKLA0vNtzA6EheF6r0Tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-rj_mUbJ0N7-GjIgFh2RrrQ-1; Thu, 14 Oct 2021 11:39:19 -0400
X-MC-Unique: rj_mUbJ0N7-GjIgFh2RrrQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B69A1018720;
        Thu, 14 Oct 2021 15:39:18 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.192.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F71419D9D;
        Thu, 14 Oct 2021 15:39:09 +0000 (UTC)
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
Subject: [PATCH v4 0/1] x86/PCI: Ignore E820 reservations for bridge windows on newer systems
Date:   Thu, 14 Oct 2021 17:39:07 +0200
Message-Id: <20211014153908.4812-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi All,

Here is v4 of my patch to address the E820 reservations vs PCI host bridge
ranges issue which are causing touchpad and/or thunderbolt issues on many
different laptop models.

I believe that this is ready for merging now.

Bjorn, can you review/ack this please ?

x86/tip folks it would be ideal if you can pick this up and send it out
as a fix to Linus for 5.15. This fixes a bug which has been plaguing a
lot of users (see all the bug links in the commit msg).

Regards,

Hans


Hans de Goede (1):
  x86/PCI: Ignore E820 reservations for bridge windows on newer systems

 .../admin-guide/kernel-parameters.txt         |  6 ++++
 arch/x86/include/asm/pci_x86.h                | 10 ++++++
 arch/x86/kernel/resource.c                    |  4 +++
 arch/x86/pci/acpi.c                           | 31 +++++++++++++++++++
 arch/x86/pci/common.c                         |  6 ++++
 5 files changed, 57 insertions(+)

-- 
2.31.1

