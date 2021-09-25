Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A30941845E
	for <lists+linux-pci@lfdr.de>; Sat, 25 Sep 2021 22:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbhIYUeD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Sep 2021 16:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbhIYUeD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Sep 2021 16:34:03 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BC8C061570;
        Sat, 25 Sep 2021 13:32:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t18so38345889wrb.0;
        Sat, 25 Sep 2021 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFzfsKuULwjyBf8Wguf5eTyoN/cXjiuq9DakkusHbp8=;
        b=Sv/TRurLr0Gd3BextmWZ/oa7gZiFeNOpH4BnwN0SloUECMqrAiOWsIK4yMCn8jS+/t
         yYgTFNWmtdxUALO4P2O8YRT7OPU3dt1XGImXs2QYgFH2+QZOnJnv3909vvOjpn/ii8sW
         vulSVE9XPdXU3EQxqPhJ3XvqLGZDlRwiXF3YOiFVvZIOqwr9HE6xa+TGBIyfSR1TlfFk
         jM8SS+srszTo9oo6oe/xBkd6AQCRDycJjEY5BEkZ4xTl7JWdx1FMHCvElagqZYVli8af
         146Zm+3ytYX91FCZQWwR4YHQh4F5ajscuSw4FtybDdMIX1PwyLwEUxfBLNyVH5QRLcEJ
         9qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RFzfsKuULwjyBf8Wguf5eTyoN/cXjiuq9DakkusHbp8=;
        b=LNXPUwIM/L8YcM4GMwc/9VjkRESMfVMRVFOQW/7+Cvfjh1gvlzorhvMc0zlq/qEi39
         EvveCBX+Ls+nqEHbGEP1nuXEKTSIP/Vxg7GyDRLEuSFcBlB1olD0tzUGZ8Onxg6I+3nK
         W4ZU8j6ee1ekRh1R3GXLFmtvAo+eXJW3ObJET5zwsfanGbFY+KsWoTETQn7N+0xZcBOZ
         cYT6QM6xWU1uG1IL1M0xFV1Jit3UGpV3bIx7ICR51MNKHst9Fw0MKw/8UFHbzJB0PfTB
         YkuyXkmUha9/pQ9/7bJR2FdLigXFPYR1P2RxT/WG/Io2ci81Yd37+XvIVkcnVMc6mcrS
         stoQ==
X-Gm-Message-State: AOAM530V4/qOOInr/Qfa8cqin+KnmYRNECZ2C98m/7kVG7j8eLc/B+U1
        abAitWPqmwh5MnYeCQwBBuQGz6ukWPI=
X-Google-Smtp-Source: ABdhPJwrXlPXbXJ1jtqYEZbgmXPVhywhLYqvgigyRNA6NoR7NyQVy7rRYghFLcH+OuZ5FJG/FgP/0Q==
X-Received: by 2002:a05:600c:4ba5:: with SMTP id e37mr8328060wmp.65.1632601946228;
        Sat, 25 Sep 2021 13:32:26 -0700 (PDT)
Received: from localhost.localdomain (252.red-83-54-181.dynamicip.rima-tde.net. [83.54.181.252])
        by smtp.gmail.com with ESMTPSA id a202sm16703279wmd.15.2021.09.25.13.32.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Sep 2021 13:32:25 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     tsbogend@alpha.franken.de
Cc:     robh@kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        Liviu.Dudau@arm.com, bhelgaas@google.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, linux-mips@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-staging@lists.linux.dev,
        neil@brown.name, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] MIPS: ralink: fix PCI IO resources
Date:   Sat, 25 Sep 2021 22:32:18 +0200
Message-Id: <20210925203224.10419-1-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

MIPs ralink need a special tratement regarding the way it handles PCI IO
resources. On MIPS I/O ports are memory mapped, so we access them using normal
load/store instructions. MIPS 'plat_mem_setup()' function does a call to
'set_io_port_base(KSEG1)'. There, variable 'mips_io_port_base'
is set then using this address which is a virtual address to which all
ports are being mapped. Ralink I/O space has a mapping of bus address
equal to the window into the mmio space, with an offset of IO start range
cpu address. This means that to have this working we need:
- linux port numbers in the range 0-0xffff.
- pci port numbers in the range 0-0xffff.
- io_offset being zero.

These means at the end to have bus address 0 mapped to IO range cpu address.
We need a way of properly set 'mips_io_port_base' with a virtually mapped
value of the IO cpu address.

This series do the following approach:
1) Revert two bad commit from a previous attempt of make this work [0].
2) Set PCI_IOBASE to mips 'mips_io_port_base'.
3) Allow architecture dependent 'pci_remap_iospace'.
4) Implement 'pci_remap_iospace' for MIPS.
5) Be sure IOBASE address for IO window is set with correct value.

More context about this series appoach in this mail thread [1].

Patches related with reverts are from this merge cycle so they are only
added to the staging git tree. So to have all stuff together I'd like to
get everybody Ack's to get all of this series through staging tree if
possible :).

Thanks in advance for your time.

Changes in v3:
 - Collect Arnd's Acked-by for the patches. 
 - Be sure IO resource start address is zero and WARN_ONCE if it is not
   on MIPS pci_remap_iospace() patch. Also make use of 'resource_size'
   instead of do the logic explicitly again.

Changes in v2:
 - re-do commit messages for PCI patch as Bjorn pointed out in previous series.
 - Add Bjorn's Acked-by for PCI subsystem patch.
 - Re-do commit message of MIPS 'pci_remap_iospace()' patch to align with changes
   in the PCI patch (s/architecture dependent/architecture-specific/)
 - Add Fixes-by tag for MIPS set PCI_IOBASE patch.

[0]: https://www.spinics.net/lists/kernel/msg4051474.html
[1]: https://lkml.org/lkml/2021/9/22/6
Sergio Paracuellos (6):
  Revert "MIPS: ralink: don't define PC_IOBASE but increase
    IO_SPACE_LIMIT"
  Revert "staging: mt7621-pci: set end limit for 'ioport_resource'"
  MIPS: ralink: set PCI_IOBASE to 'mips_io_port_base'
  PCI: Allow architecture-specific pci_remap_iospace()
  MIPS: implement architecture-specific 'pci_remap_iospace()'
  staging: mt7621-pci: properly adjust base address for the IO window

 arch/mips/include/asm/mach-ralink/spaces.h |  4 +++-
 arch/mips/include/asm/pci.h                |  2 ++
 arch/mips/pci/pci-generic.c                | 14 ++++++++++++++
 drivers/pci/pci.c                          |  2 ++
 drivers/staging/mt7621-pci/pci-mt7621.c    |  4 +---
 5 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.25.1

