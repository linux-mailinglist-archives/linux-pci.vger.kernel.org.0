Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F74B4BEA
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2019 12:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfIQKZR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Sep 2019 06:25:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41318 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfIQKZR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Sep 2019 06:25:17 -0400
Received: by mail-ot1-f68.google.com with SMTP id g13so2540143otp.8;
        Tue, 17 Sep 2019 03:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=U8AK8lep52zI4AFbsmkmWfoZZHVuoR54siydWKVCQfk=;
        b=jRB+VendOOO3zqzMBwDpUbBRFaqu8U68JlQXrRuTDfWoMXw6pPlh7ziCDe6MraafOm
         f9GX3XeXckwL/l9a3+H5FfxOGQb09m4Ezqic2l/rqHTN1oiAqfHqPXECbHJjg1PoEQEr
         bq2qD10LejiOm4Ye0o/tiBVzJxYeUXIbAZnHa8AuCVYpVUXDDt9c0yjpxOMFQBIHQrYb
         GKfh/Dp+QeX6UUke1nlvDh+nWKdP95hzBvakK61DUjveR/pLzgC5i43THm2SPgYGrYpN
         cKb29ZbdmmlruAwfQVuoarNvoR4GjF8WKQVLkCILxaY0IwddEuqaC805SbwbJmyqH7LN
         639A==
X-Gm-Message-State: APjAAAUN6yAB941Jn0nw9dmhurqMR3RIBQPBV5wu58Kj3Ztjy7jcAvSm
        HNkMPRX2gitatLMo5QrdGouoj7lVSPc2k/Fe6wI=
X-Google-Smtp-Source: APXvYqxU2RKcbkpQZ8/6Op1mnYhZjI6D3bJFaVBF50pFi/ORMWkDWOVzeZQvGuVCZ6z8U9odIwxV0sOsGx2hxkJAgLE=
X-Received: by 2002:a05:6830:9:: with SMTP id c9mr2135163otp.262.1568715915953;
 Tue, 17 Sep 2019 03:25:15 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 17 Sep 2019 12:25:05 +0200
Message-ID: <CAJZ5v0jHzVKJiLzMxC6eqqCkpeKA-UD_9fhy1KpVp6fM=XwiSQ@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v5.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.4-rc1

with top-most commit 0b3e7973128528e804b05dd7f79d54c2792318d6

 Merge branches 'acpi-misc' and 'acpi-doc'

on top of commit a55aa89aab90fae7c815b0551b07be37db359d76

 Linux 5.3-rc6

to receive ACPI updates for 5.4-rc1.

These include an ACPICA update (to upstream revision 20190816),
improvements of support for memory hot-add in the HMAT handling code
and some assorted fixes and cleanups.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20190816
   including:
   * Internal limits change to support larger systems (Bob Moore).
   * Macros clean up (Bob Moore).
   * printf format string fixes (Bob Moore).
   * Full deployment of the ACPI_PRINTF_LIKE macro (Bob Moore).
   * Tools improvements (Bob Moore, Colin Ian King).
   * Windows _OSI support fixes (Jung-uk Kim).

 - Improve memory hot-add support in the ACPI HMAT handling code (Dan
   Williams, Keith Busch).

 - Fix the ACPI LPSS (Low-Power Subsystem) driver for Intel SoCs to
   save and restore private registers during system-wide suspend and
   resume on systems with the Lynxpoint PCH (Jarkko Nikula).

 - Convert the ACPI documentation related to LEDs to ReST (Sakari
   Ailus).

 - Fix assorted issues and make assorted minor improvements in the
   ACPI-related code (Al Stone, Andy Shevchenko, Jiri Slaby, Kelsey
   Skunberg, Krzysztof Wilczynski, Liguang Zhang, Wenwen Wang,
   YueHaibing).

Thanks!


---------------

Al Stone (1):
      ACPI / CPPC: do not require the _PSD method

Andy Shevchenko (1):
      ACPI / APEI: Get rid of NULL_UUID_LE constant

Bob Moore (6):
      ACPICA: Increase total number of possible Owner IDs
      ACPICA: Macros: remove pointer math on a null pointer
      ACPICA: Fix issues with arg types within printf format strings
      ACPICA: iASL,acpi_dump: Improve y/n query
      ACPICA: Fully deploy ACPI_PRINTF_LIKE macro
      ACPICA: Update version to 20190816.

Colin Ian King (1):
      ACPICA: Debugger: remove redundant assignment on obj_desc

Dan Williams (1):
      HMAT: Skip publishing target info for nodes with no online memory

Jarkko Nikula (1):
      ACPI / LPSS: Save/restore LPSS private registers also on Lynxpoint

Jiri Slaby (1):
      ACPI / processor: don't print errors for processorIDs == 0xff

Jung-uk Kim (2):
      ACPICA: Differentiate Windows 8.1 from Windows 8.
      ACPICA: Add "Windows 2019" string to _OSI support.

Keith Busch (2):
      HMAT: Register memory-side cache after parsing
      HMAT: Register attributes for memory hot add

Kelsey Skunberg (1):
      ACPI: thermal: Remove redundant acpi_has_method() calls

Krzysztof Wilczynski (1):
      ACPI/PCI: Remove surplus parentheses from a return statement

Liguang Zhang (1):
      ACPI / APEI: Release resources if gen_pool_add() fails

Sakari Ailus (1):
      Documentation: ACPI: DSD: Convert LED documentation to ReST

Wenwen Wang (2):
      ACPI: custom_method: fix memory leaks
      ACPI / PCI: fix acpi_pci_irq_enable() memory leak

YueHaibing (1):
      ACPI: SBS: remove unused const variable 'SMBUS_PEC'

---------------

 .../leds.txt => firmware-guide/acpi/dsd/leds.rst}  |  20 ++-
 Documentation/firmware-guide/acpi/index.rst        |   1 +
 drivers/acpi/acpi_lpss.c                           |   8 +-
 drivers/acpi/acpi_processor.c                      |  10 +-
 drivers/acpi/acpica/aclocal.h                      |   4 +-
 drivers/acpi/acpica/acobject.h                     |   2 +-
 drivers/acpi/acpica/acstruct.h                     |   2 +-
 drivers/acpi/acpica/acutils.h                      |  10 +-
 drivers/acpi/acpica/dbhistry.c                     |   2 +-
 drivers/acpi/acpica/dbinput.c                      |  10 +-
 drivers/acpi/acpica/dbmethod.c                     |   4 +
 drivers/acpi/acpica/dbobject.c                     |   1 -
 drivers/acpi/acpica/dbstats.c                      |  92 +++++++------
 drivers/acpi/acpica/exdump.c                       |   6 +-
 drivers/acpi/acpica/nsaccess.c                     |   2 +-
 drivers/acpi/acpica/nsalloc.c                      |   2 +-
 drivers/acpi/acpica/nsdump.c                       |   2 +-
 drivers/acpi/acpica/nsrepair2.c                    |   2 +-
 drivers/acpi/acpica/tbdata.c                       |   1 +
 drivers/acpi/acpica/utdebug.c                      |   4 +-
 drivers/acpi/acpica/uterror.c                      |   6 +-
 drivers/acpi/acpica/utosi.c                        |   3 +-
 drivers/acpi/acpica/utownerid.c                    |  12 +-
 drivers/acpi/apei/ghes.c                           |  19 ++-
 drivers/acpi/cppc_acpi.c                           |   6 +-
 drivers/acpi/custom_method.c                       |   5 +-
 drivers/acpi/hmat/hmat.c                           | 143 ++++++++++++++++-----
 drivers/acpi/pci_irq.c                             |   4 +-
 drivers/acpi/pci_link.c                            |   4 +-
 drivers/acpi/sbshc.h                               |   2 -
 drivers/acpi/thermal.c                             |  11 +-
 include/acpi/acconfig.h                            |   4 +-
 include/acpi/acpiosxf.h                            |   1 +
 include/acpi/acpixf.h                              |   2 +-
 include/acpi/actypes.h                             |  20 +--
 tools/power/acpi/tools/acpidump/apfiles.c          |  10 +-
 36 files changed, 285 insertions(+), 152 deletions(-)
