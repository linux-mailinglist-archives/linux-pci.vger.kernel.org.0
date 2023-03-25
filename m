Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839616C8BF7
	for <lists+linux-pci@lfdr.de>; Sat, 25 Mar 2023 08:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjCYHCe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 25 Mar 2023 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjCYHCd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 25 Mar 2023 03:02:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56E213DFF
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679727751; x=1711263751;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jVULAIwgkeKJ5JpR5u6IL0YWq5C4grNWpoOBABg7Y70=;
  b=KALFJaZilWxI2mDTPf3dyBlXM8Ryakjqng0sVRVv0IVrX6qs4ggCMLJU
   ZcCMq6w38QeZSkrn10dynUSDeNJYjYTd+PYhuN29Bzd1IzRzlXWuUtUDg
   ks0p/rVxqFssYBV5xUgxwAe5tCiYchCXOfi3Z262LS60W05llupTYsnMC
   /dZu67IEfNG6lZtdjoWRFTMr6efPU683Jy+JJjLIxNW+9nahjpB3VlQOA
   8KLBHz+mlIXe46cTGA5gBId2ZSzgQPW0MJ3UakOV4f7xGcQT92HEXNrXr
   vxjnCYLL30t/BlCqsbwDUcYNZag1LobYxa7tTaXdI7PJWfAggELlR9e1Y
   g==;
X-IronPort-AV: E=Sophos;i="5.98,289,1673884800"; 
   d="scan'208";a="224756664"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2023 15:02:30 +0800
IronPort-SDR: 7wt8DJpZN3V/LbuLWmZg8GxNUYQfwZ9gHO1ZSWSBkW9i5IHtfuDoZqzM2uCnJnLe/To21KETVm
 yLFprEc/uA2oAjYvNkRXKVBQdsGkg//Mzx44kStRFe/rLHTDtJNrHNlZS/BkYLYmw+3MxhlT9z
 IUsDn5MI1jGSHjhA4/wXqBTJlCJS7W189ziYwfT6cDbfyztpvf/NbIjlVEtZB81Nc43vrNQm+2
 +GYQzKWwchiGadzCC1i+uoG42p94Exgmu8ARSYLRa7u6xZa41ZoTntZSDkQ16MZwjHc9v6qwoO
 snU=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 24 Mar 2023 23:18:45 -0700
IronPort-SDR: +TsWGSQoSbXjeo0r+FbUTiDW8B55rywbfAa6zwr+HWaMZ0PnJs55d9lHVRkszWVRKkZp335Rdk
 Jgo53VSrIbzVLSCw4kwcXtAUfeo1iTxshve7eSd+e66KCKIoCVyllYKGuIyocD8AtPz8e/9pzQ
 f3Xzm36fpuQJS6bnyP8qHaqI6jN2/Pne1V9PWlWzLJ9xJLWXVXvLR1i0TrOnY8iZvhPaUJdn4i
 XSMXYqcgLRusjVzP1aDrOW6YKvIC3Swb0hlWmm7jr96MXLEOT+cLQpmQ1xyDzjfn9ge4YOZyQ+
 scw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Mar 2023 00:02:31 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pk94k3VjGz1RtVw
        for <linux-pci@vger.kernel.org>; Sat, 25 Mar 2023 00:02:30 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1679727749;
         x=1682319750; bh=jVULAIwgkeKJ5JpR5u6IL0YWq5C4grNWpoOBABg7Y70=; b=
        SW82a+Hz5K/ZKYPtJ3KnWhU3gAobohH/YuMYKNuRsjw+V7eQxjTLabgft3jdPvzD
        b9/fzmawINTfUa2Lq9cVzFr+BsFJ9e3Tj0D28Ikdq0IK08Y8DcIzwmM9v6cyLY9A
        elFdyYyw2SNk+lzWDT9vGtT3Erul7CMRyxALkvM/iaGr36jke1Syowu4Ce1xZOd0
        +4Ywn2cQOsoolv6rvRkYUwvXXVejSuSBaoFb+XNhczHklzxV5maK68j/imi1Kn8c
        TXOt3nnvV8gqjWQmS6bDTfq6+JLE4Vul7xyPgp9nj2o6izR7aXgHm/vVp+1Vyzcc
        I8GepQXSv8o1SmoJFUrhtg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id d2h_QXfDkBYR for <linux-pci@vger.kernel.org>;
        Sat, 25 Mar 2023 00:02:29 -0700 (PDT)
Received: from washi.fujisawa.hgst.com (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pk94h0MyVz1RtVm;
        Sat, 25 Mar 2023 00:02:27 -0700 (PDT)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 00/16] PCI endpoint fixes and improvements
Date:   Sat, 25 Mar 2023 16:02:10 +0900
Message-Id: <20230325070226.511323-1-damien.lemoal@opensource.wdc.com>
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
test drivers (host side and EP side).

The first 2 patches address an issue with the use of configfs to create
an endpoint driver type attributes group, preventing a potential crash
if the user creates a directory multiple times for the driver type
attributes.

The following patches are fixes and improvements for the endpoint test
drivers, EP side and RP side.

This is all tested using a Pine Rockpro64 board, with the rockchip ep
driver fixed using Rick Wertenbroek <rick.wertenbroek@gmail.com>
patches [1], plus some additional fixes from me.

[1] https://lore.kernel.org/linux-pci/20230214140858.1133292-1-rick.werte=
nbroek@gmail.com/

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

Damien Le Moal (16):
  PCI: endpoint: Automatically create a function specific attributes grou=
p
  PCI: endpoint: Move pci_epf_type_add_cfs() code
  PCI: epf-test: Fix DMA transfer completion initialization
  PCI: epf-test: Fix DMA transfer completion detection
  PCI: epf-test: Use dmaengine_submit() to initiate DMA transfer
  PCI: epf-test: Simplify read/write/copy test functions
  PCI: epf-test: Simply pci_epf_test_raise_irq()
  PCI: epf-test: Simplify IRQ test commands execution
  PCI: epf-test: Improve handling of command and status registers
  PCI: epf-test: Cleanup pci_epf_test_cmd_handler()
  PCI: epf-test: Simplify dma support checks
  PCI: epf-test: Simplify transfers result print
  misc: pci_endpoint_test: Free IRQs before removing the device
  misc: pci_endpoint_test: Re-init completion for every test
  misc: pci_endpoint_test: Do not write status in IRQ handler
  misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()

 Documentation/PCI/endpoint/pci-ntb-howto.rst  |  11 +-
 Documentation/PCI/endpoint/pci-vntb-howto.rst |  13 +-
 drivers/misc/pci_endpoint_test.c              |  25 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 238 ++++++++----------
 drivers/pci/endpoint/pci-ep-cfs.c             |  53 ++--
 drivers/pci/endpoint/pci-epf-core.c           |  32 ---
 include/linux/pci-epf.h                       |   2 -
 7 files changed, 162 insertions(+), 212 deletions(-)

--=20
2.39.2

