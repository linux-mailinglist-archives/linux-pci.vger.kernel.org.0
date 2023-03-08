Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE116B0241
	for <lists+linux-pci@lfdr.de>; Wed,  8 Mar 2023 10:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCHJES (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Mar 2023 04:04:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjCHJEM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Mar 2023 04:04:12 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB906410A0
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1678266212; x=1709802212;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rTG4eYV9FhmF8fhVxOg0fd1jUwitB8BKGAjLOH/Fypk=;
  b=PkUh5VHbuFLzGrX+egFl7tZM+ddlNS1zCueqKA8UXdelQXiNZny3hUJe
   0ufQqeGuE5WVPtZAkvFsEn34vxNxaCHc1u/D2adfQsog4xRwcQfQSO3A5
   /bydOPB+eBvAaIzTouvRjk+y9S+vonEOJh6hyPk7XJmMmeuqxYSFTunLw
   v3dv9fQ2vrqxf5PQ4/Gn8iYQiO8Rvl8xtC4FvxL4zj+xi68MWYhH93+03
   jpIiN56rdD5WAN/scHH3XOSWu/r09UD0yFvdvnUx684WY8Gxo0VoKkMwA
   twf1Oigs+zcTayoCh3Gt+jpXxHmlLNN7AfFqfnz1PcXLdbP9wjDxqnrvp
   g==;
X-IronPort-AV: E=Sophos;i="5.98,243,1673884800"; 
   d="scan'208";a="224880529"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2023 17:03:17 +0800
IronPort-SDR: nvRL5SNBAF9R0r+XlV4fom7OMGy1pqKaeZVPXCpKLiUfIrM2fpxKXubLWHazM7h7KNVDhHRfxX
 jniPvBK+MLcKraJ+pIjAdS5LNXDvbyFbhXwhL6iXUrMwOt43xffgETgmtpZ9EdPVFxb1xhA3II
 ZFtwV0dHaTESg0tB3ty97RM1KewvY0ApT8bCpMa//tPCWm8XwLio7aIhezPVMxyS+Bh4yuDQvE
 6tBQu58su6AzHh1TFp7M0DWEN8zaiq/7Mk7owqOqhpuU1lYYUQwh0K7raJQIljo0IynCkQ2Hpv
 j0A=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 00:14:14 -0800
IronPort-SDR: 4XDPaPfL/0MHFocrddUUZzmaviJBhlO2iO/2uYX/zAPrPHdjQVL+nRT8QiKBPf59LoDwg3xe8V
 jhkkwO1H4ScUyaYQxrEIx9cA3MXU5wpnxegpOaP93j1WaP7DfztIs8NfI9AbwQf/sxbQIXb+LF
 pRbEyv0BiN8UsmXlk5j4VHHW6ChXWocNxxjaNGUvcdPXW5tXwjDvIf6rJErOU08DrbtVYSIGrV
 ilZXeO7dYM6uJvUhTVJdJR3tc0cUIEI4DsKepCy9JrV2pcwM9RX8gLkAAM9rq1b6RAsUcTy5c0
 NsQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Mar 2023 01:03:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PWmYx29xsz1RwtC
        for <linux-pci@vger.kernel.org>; Wed,  8 Mar 2023 01:03:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1678266196;
         x=1680858197; bh=rTG4eYV9FhmF8fhVxOg0fd1jUwitB8BKGAjLOH/Fypk=; b=
        bPthUtUbdFg6pxVVIAMlsEXtmB3xDHlyMDKrS8mAbk04XNOA1gt9gCM2j8VNDDcB
        rm8JlTJFRwtH6MaKWYOyDsB6yBUrCsJRyVW40ZDcvjsE3HDNe22O9cHx1F56r8fL
        jtYdVBBcIlJty39vT7xjsd4jxLrnunE72r4rtd05kK7MCxQrG/BRYnNva1TDa8G/
        SKoys5jTW7pmJu/gmSmoHGp52JwDCmo8vdHGfzAmr70Bso1+iIxxb4u2pGGVpIRk
        5fz72bkVdoUgoR7kSboBvfileRWRv/rUvQbvBiG4YVufirOY5nuxUieeDKbMgjmw
        3JsOj0lfQsjJU2618kbuxQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ciHPXmtrnyNl for <linux-pci@vger.kernel.org>;
        Wed,  8 Mar 2023 01:03:16 -0800 (PST)
Received: from ephost.wdc.com (unknown [10.225.163.68])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PWmYt4pV9z1RvLy;
        Wed,  8 Mar 2023 01:03:14 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 00/16] PCI endpoint fixes and improvements
Date:   Wed,  8 Mar 2023 18:02:57 +0900
Message-Id: <20230308090313.1653-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/misc/pci_endpoint_test.c              |  25 +-
 drivers/pci/endpoint/functions/pci-epf-test.c | 240 ++++++++----------
 drivers/pci/endpoint/pci-ep-cfs.c             |  53 ++--
 drivers/pci/endpoint/pci-epf-core.c           |  32 ---
 include/linux/pci-epf.h                       |   2 -
 5 files changed, 155 insertions(+), 197 deletions(-)

--=20
2.39.2

