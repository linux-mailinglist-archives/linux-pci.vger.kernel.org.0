Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2B76CFF2D
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjC3IyE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Mar 2023 04:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3IyD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Mar 2023 04:54:03 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B8965A6
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680166442; x=1711702442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SuJT6BMHvFmzVZdFLgJxBqBbHM8g38GUZeyf9vQrZOc=;
  b=GucM2JoHizXsE9gcEyO8AJOycR19c0O6YFo/nUjfnVXnD0datAZ9PEA8
   Z5hq1jJqxDuhQKoA7GJMh0ilN1NGpZy+S5AcCJjQ97RdNxY4vv6r1do+F
   zBMGBcMjkzx/xnEoOHgSXOHLEAu206aqO/2XcrKm3hFcBsVF55IAY+rif
   BPU/JcoS8/IQcHXaKkvdnNcbhHJf8/SWub9MeD2RBSUFh7dqXPRf2gl3R
   bp4tf3QnFSWyWCnjzXR2sgeF6z01j5hGH+tyYvw3qXKUzBM3DXK1I/GpH
   n43PY3S67LYL0lN0baAKSgBGZJTIr4SM+XutPvMJ/bcOCIWhg3rahIHwn
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331310403"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 16:54:01 +0800
IronPort-SDR: k/FsIjOQcz8WgKGcWoD4K17Zt+6zqh8D+aOzWPgHyflOvjnoaMp99/32qwzwDKaE2rueenwVti
 I+OcaKZDXAKMzBybHva+zMQuHb7S0Cty4IU9sBPPnrfzvlp3xa7BEU12w6sHOEr57aJmO/uwS+
 ALWECl/AowjXS3rTErQ+q+/N2J80y2p1RvoEZISMiaYNttpHYvZzzrPhLEghzvu8oEDenYbqhr
 7U/++siRLN3RsbJ+er15f2j9YHc4qvorj6GRSRNO7jt9ukcJn3po+1xQJyuIfN89vnCAJxwT7m
 Uwk=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:10:09 -0700
IronPort-SDR: eXYYhOOnQ5BcGmhhEsNuCW/k5qseNl6E1rW1quLqScMdgRaN9IX1yo25LLe6vbfvNBshfkUutl
 nLcQGh2Wf0UXzHRXdNthxYTjybZA3yKLJnQmW4RbENETRPGu2pIUnCVsQfDBcv/ozJtUTtBUF5
 u/gC60SsgjG6qSuP3QdzITyyGl2GLfEt6ZCpXQ0pYk75Tfb1fG+YYaeTrCPoxNRXdnI9yvRnKv
 fM5I6CpqH+R7Y7SF7A2cXVozdTkMZjD5Cwqwy+zi2MrzmXD+pDRO/WV1yjVuF+H4OhqkKluVYB
 u44=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 01:54:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PnHK521V0z1RtVp
        for <linux-pci@vger.kernel.org>; Thu, 30 Mar 2023 01:54:01 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1680166440;
         x=1682758441; bh=SuJT6BMHvFmzVZdFLgJxBqBbHM8g38GUZeyf9vQrZOc=; b=
        GFjCmbtHoEypCUgEJfRKjqKz6bo7i8LPRwibMMvECHqciRw6B7etiCHU0X3h0oF0
        WALas6rY8sCM4nNavnwr+1SBPKDDgMuWHG21Af+IAgiLEy4E3KodEL3ITyGyUDnD
        YQWmY18wB1wnGeuF+T/x9Qni5PVb+GHdyO1SDLcEhk0jE22k71qnpB+cF8gs6F7X
        3WoHnCrqsaoGTHv38XV+IubXKx+X0Y+0eeIrk1SLoAuSCJDL4r8be2qntjCBcn72
        umNuQIDY1WN9CAIBMsH91Aptks3IkZ716N/YDelYaG5VwTQEcMu5gMOQtX4vCXoO
        Ti9Ke8kyLWTAfsGenX/iGA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id w9KskfUwxNJF for <linux-pci@vger.kernel.org>;
        Thu, 30 Mar 2023 01:54:00 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PnHK25jVGz1RtVm;
        Thu, 30 Mar 2023 01:53:58 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v4 00/17] PCI endpoint fixes and improvements
Date:   Thu, 30 Mar 2023 17:53:40 +0900
Message-Id: <20230330085357.2653599-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series fixes several issues with the PCI endpoint code and endpoint
test drivers (RC side and EP side).

The first 2 patches address an issue with the use of configfs to create
an endpoint driver type attributes group, preventing a potential crash
if the user creates a directory multiple times for the driver type
attributes.

The following patches are fixes and improvements for the endpoint test
drivers, EP side and RC side.

This is all tested using a Pine Rockpro64 board, with the rockchip ep
driver fixed using Rick Wertenbroek <rick.wertenbroek@gmail.com>
patches [1], plus some additional fixes from me.

[1] https://lore.kernel.org/linux-pci/20230214140858.1133292-1-rick.werte=
nbroek@gmail.com/

Changes from v3:
 - Corrected patch 7 and 12 title
 - Added patch 11

Changes from v2:
 - Add updates of the ntb and vntb function driver documentation in
   patch 1 to reflect the patch changes.
 - Removed unnecessary WARN_ON() call in patch 4
 - Added missing cc: stable tags
 - Added review tags

Changes from v1:
 - Improved patch 1 commit message
 - Modified patch 2 to not have to add an internal header file
 - Split former patch 3 into patch 3, 4 and 5
 - Removed former patch 4 introducing volatile casts and replaced it
   with patch 9
 - Added patch 6, 7, 8 and 10
 - Added Reviewed-by tags in patches not modified

Damien Le Moal (17):
  PCI: endpoint: Automatically create a function specific attributes
    group
  PCI: endpoint: Move pci_epf_type_add_cfs() code
  PCI: epf-test: Fix DMA transfer completion initialization
  PCI: epf-test: Fix DMA transfer completion detection
  PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
  PCI: epf-test: Simplify read/write/copy test functions
  PCI: epf-test: Simplify pci_epf_test_raise_irq()
  PCI: epf-test: Simplify IRQ test commands execution
  PCI: epf-test: Improve handling of command and status registers
  PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
  PCI: epf-test: Cleanup request result handling
  PCI: epf-test: Simplify DMA support checks
  PCI: epf-test: Simplify transfers result print
  misc: pci_endpoint_test: Free IRQs before removing the device
  misc: pci_endpoint_test: Re-init completion for every test
  misc: pci_endpoint_test: Do not write status in IRQ handler
  misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()

 Documentation/PCI/endpoint/pci-ntb-howto.rst  |  11 +-
 Documentation/PCI/endpoint/pci-vntb-howto.rst |  13 +-
 drivers/misc/pci_endpoint_test.c              |  25 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 266 ++++++++----------
 drivers/pci/endpoint/pci-ep-cfs.c             |  53 ++--
 drivers/pci/endpoint/pci-epf-core.c           |  32 ---
 include/linux/pci-epf.h                       |   2 -
 7 files changed, 174 insertions(+), 228 deletions(-)

--=20
2.39.2

