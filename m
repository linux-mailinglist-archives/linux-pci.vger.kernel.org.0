Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDF839B9E9
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 15:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbhFDNeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 09:34:37 -0400
Received: from mail-qv1-f54.google.com ([209.85.219.54]:45951 "EHLO
        mail-qv1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbhFDNeg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Jun 2021 09:34:36 -0400
Received: by mail-qv1-f54.google.com with SMTP id g12so4900787qvx.12
        for <linux-pci@vger.kernel.org>; Fri, 04 Jun 2021 06:32:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NisYeHKln3MzOLTTHZfaXkG1o79TFAV02ojtv0Vp5CI=;
        b=Xc5glfv0+PQBWJupLXb6swfSnYRh14uDnrVHr4TYPYsekFiUG7HjkPNdPJrmpeAiXI
         jFeNpt5qQYItmLWJBvfxTH5NYKp0O4B2LudAFjnwKMt9WiZ5j+QjY28Vo1C1zzIUOYNv
         PYMqCoco3zFl3JRZh2hD0BQ3nRZ32JrOOd9Wy3tD79kKEg4Uk3iRIrpueS9vO0TlALb8
         YvQSpFazYCcPc8pdrvhN2c1fnhuuRbqBFL5+GsbcHZSon7KJIkOOJ5Aj/7JKx1tSU+Bt
         gXIMZ4xVTuS1of2tBMYIrXiG1VmSmmCvH9Mef9prj1i/cEP9PBUbh5MIIjMPWZoBZnKY
         sfoQ==
X-Gm-Message-State: AOAM5315yxoK+cggP/KO51XyQzU3RMSUnhW8dPyiQYN7ZTvt4eIh6ZI3
        Q0LGhKqKznaMrezrJ6QWg4k=
X-Google-Smtp-Source: ABdhPJxQLDZZkMlloC/GavHnjEBWQ0diQQwvrbq2frk1ePS3FxczN/ZbAONmpifqkbqFUhtTbQ0fPg==
X-Received: by 2002:ad4:44a1:: with SMTP id n1mr2267680qvt.14.1622813554451;
        Fri, 04 Jun 2021 06:32:34 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id b189sm3965912qkc.91.2021.06.04.06.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:33 -0700 (PDT)
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
Subject: [PATCH v7 0/6] PCI/sysfs: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date:   Fri,  4 Jun 2021 13:32:24 +0000
Message-Id: <20210604133230.983956-1-kw@linux.com>
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

Changes in v7:
  Use correct variable name in the resource_alignment_store() function
  when freeing allocation made using kstrndup() if the value sent from
  the userspace is an empty string intended to clear the currently set
  resource alignment.

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

