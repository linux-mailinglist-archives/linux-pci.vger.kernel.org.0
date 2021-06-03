Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBF9399691
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jun 2021 02:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhFCADS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Jun 2021 20:03:18 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:38589 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCADP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jun 2021 20:03:15 -0400
Received: by mail-wr1-f48.google.com with SMTP id j14so3959296wrq.5
        for <linux-pci@vger.kernel.org>; Wed, 02 Jun 2021 17:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f5p9SON5sixAAQi522OCLFxz/ZYY3odM43R9FOOXMt8=;
        b=aFscYlGU7V4MhG0xh4EkDmHucrVPaVRg9saW2sAysfm+zz5jRJbMFfQjbinT7Nq8Vh
         2kR0MbX3PHrMvA9LSoyHOtkj0QsQ9bJQzQBTP7EPwdBuMedL7Bdo9gkF64VYGBvTy8K9
         2uS1qttRDmDaGgpaEsRKQFjJr1DHKI5Ib2txynCX9b4QM8Woc4skDxjx5L98WiXmJIm6
         YcGC6Gq2k6BUl74aooO//gC39hGHH7kDm/wTIYP0Z0dCcU6OZiky5B8Dm5YubSNBRZnL
         5uvfVaTYhOA6zebY7JPSJRnyThtITyu9snLg+TZdoYgmkcyWp2Q+NBG5wRJFRe7ZJI77
         KXZQ==
X-Gm-Message-State: AOAM533EJjt3RfDA1fJcvIKDYQZgEUneA4oYJLj2wsw4S7bGaNbZiB+P
        LU1EK4qO52EFcCIOAvthKlQ=
X-Google-Smtp-Source: ABdhPJwQXeStDbR/r2910dCtc0V+XttuuciwA6iF6jzDL2shYKJxtK2EnUmJH8+2TCg3dBZ4JuAWUg==
X-Received: by 2002:a5d:68d1:: with SMTP id p17mr19529095wrw.28.1622678475642;
        Wed, 02 Jun 2021 17:01:15 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id c7sm1424669wrs.23.2021.06.02.17.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 17:01:14 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Joe Perches <joe@perches.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 0/6] PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Thu,  3 Jun 2021 00:01:06 +0000
Message-Id: <20210603000112.703037-1-kw@linux.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

This series aims to bring support for the sysfs_emit() and
sysfs_emit_at() functions to the existing PCI-related sysfs objects.
These new functions were introduced to make it less ambiguous which
function is preferred when writing to the output buffer in a device
attribute's "show" callback [1].

Thus, the existing PCI sysfs objects "show" functions will be converted
from the using the sprintf(), snprintf() and scnprintf() functions to
sysfs_emit() and sysfs_emit_at() accordingly, as the latter is aware of
the PAGE_SIZE buffer limit that the sysfs object has and correctly
returns the number of bytes written into the buffer.

This series will also address inconsistency related to the presence (or
lack of thereof) of a trailing newline in the show() functions adding it
where it's currently missing.  This will allow for utilities such as the
"cat" command to display the result of the read from a particular sysfs
object correctly in a shell.

While working on this series a problem with newline handling related to
how the value of the "resource_alignment" sysfs object was parsed and
then persisted has been found and corrected.  Also, while at it,
a change enabling support for the value of "resource_alignment"
previously set using either a command-line argument or through the sysfs
object to be cleared at run-time was also included, and thus aligning
this particular sysfs object with the behaviour of other such objects
that allow for the value to be dynamically updated and cleared as
required.

Additionally, a fix to a potential buffer overrun that has been found in
the dsm_label_utf16s_to_utf8s() function that is responsible for the
character conversion from UTF16 to UTF8 of the buffer that holds the
device label obtained through the ACPI _DSM mechanism is included as
part of this series.

Finally, a minor fix is also included in this series that has been added
to ensure that the value of the "driver_override" variable is only
exposed through the corresponding sysfs object when a value is set or
otherwise if the value has not been set, the object would return
a string representation of the NULL value.  This will also align this
particular sysfs object's behaviour with others, where when there is no
value then nothing is returned.

[1] Documentation/filesystems/sysfs.rst

This series is related to:
  commit ad025f8 ("PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions")

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

---
Changes in v2:
  None.

Changes in v3:
  Added Logan Gunthorpe's "Reviewed-by".

Changes in v4:
  Separated and squashed all the trivial sysfs_emit()/sysfs_emit_at()
  changes into a single patch as per Bjorn Helgaas' request.
  Carried Logan Gunthorpe's "Reviewed-by" over.

Changes in v5:
  Added check to the resource_alignment_show() function to ensure that
  there is an extra space left in the buffer for the newline character,
  assuming that it might be provided.

Changes in v6:
  Added a cover letter as per Bjorn Helgaas' request.
  New patch addressing a potential buffer overrun in the
  dsm_label_utf16s_to_utf8s() function has been added.

Krzysztof Wilczyński (6):
  PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
  PCI/sysfs: Use return value from dsm_label_utf16s_to_utf8s() directly
  PCI/sysfs: Fix trailing newline handling of resource_alignment_param
  PCI/sysfs: Add missing trailing newline to devspec_show()
  PCI/sysfs: Only show value when driver_override is not NULL
  PCI/sysfs: Fix a buffer overrun problem with
    dsm_label_utf16s_to_utf8s()

 drivers/pci/hotplug/pci_hotplug_core.c |  8 +++---
 drivers/pci/hotplug/rpadlpar_sysfs.c   |  4 +--
 drivers/pci/hotplug/shpchp_sysfs.c     | 38 ++++++++++++++------------
 drivers/pci/iov.c                      | 12 ++++----
 drivers/pci/msi.c                      |  8 +++---
 drivers/pci/p2pdma.c                   |  7 ++---
 drivers/pci/pci-label.c                | 22 ++++++++-------
 drivers/pci/pci-sysfs.c                |  7 +++--
 drivers/pci/pci.c                      | 34 +++++++++++++----------
 drivers/pci/pcie/aer.c                 | 20 ++++++++------
 drivers/pci/pcie/aspm.c                |  4 +--
 drivers/pci/slot.c                     | 18 ++++++------
 drivers/pci/switch/switchtec.c         | 18 ++++++------
 13 files changed, 107 insertions(+), 93 deletions(-)

-- 
2.31.1

