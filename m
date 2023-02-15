Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467946974CF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Feb 2023 04:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbjBODWM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 22:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjBODWE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 22:22:04 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D729A2B2B3
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676431320; x=1707967320;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Cuzwe97KOzTpVmRGj+7xhqsr0Czkiev78SIUaXonxK8=;
  b=qCBzx1FVncPyJLArujiInTrc9PR81su+GujJwjYRkJ2ACEjo9Tqnb1zF
   U0ZZkrYYE7IVCQeW4vFBimne8YQIlSL5vVb1MLFvGLIz3Lu69/5uqPCOY
   r19op0fBbYduE6Cqfe3V4Q3uYknz1xGFlE8quS6/gkpfuTOfe8jDqiNcO
   AjtXoXbA9j2WLOXk5UspW6ZpD+yn8qlltc3dNul90Z6ujrcIPf8WQzL/T
   K/WG7i2X84ThU7fdv51A3e4K7a6bLZgVs+k9HO6pnNVdNVylgiPPr88ES
   09nXIqC5Qt9Gw9fJdZrKMiMNlENGc7GnEFRh3xKdaEeA33/sjJxmGpLTj
   w==;
X-IronPort-AV: E=Sophos;i="5.97,298,1669046400"; 
   d="scan'208";a="223351446"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2023 11:21:59 +0800
IronPort-SDR: 1nDIamqzzOssAXj75aNwzyQ+0dNH0LLnljiGwjpeYEhPXrgYjYedx7+7UzLPGBFCVFN1ohPp0W
 aJMsNjqRVfLT4s1MlRz4rl2yron6GWKLUCmc8/04WPHoE2Qs501U796Hn0eMeLkQWFWUbFM6d4
 HKj55w6pS5Hm7ejqGbLIjbi3fKWVBBTtTehjhhun6bHF9TwGkQPJjNu1bE9IOUxbcqHJPiITka
 Xiz5kQzIqqoUmQfMwqD9SOUstRgDhhLnygtsEilVYPCfnZkiROuWnM45kOPCB4/pe5bJeo0qOJ
 0uM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 18:33:22 -0800
IronPort-SDR: RSWWgfThcYkgfuJ7W5QTUd0on4AraDj17EF81EAL4cbo6t9H+lzVTcVGoxAMDkzVYfyi0s6Dh0
 WPR7Pzvfw70grCxkC11pQT7QRQPzqCLojOrJxER1fUp7nx+ljg8zmeAQurdEMB0fcoSHOtLSzE
 C74AHPZAQdyIk8K4gT+0RopDj8q7or5Zt0HaAWHfcxTy3XHa1R3ttngW+NSkm14hlVyxolNnSq
 xZ1iwovah0WHbpQ4Q/KTH9C39TQtDbqkYMekKsOsxxRRqlX9QOtovApvBySQVYXHOZZEx6cEdk
 /wg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Feb 2023 19:21:58 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PGjzq28Zvz1Rwtl
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 19:21:59 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1676431318;
         x=1679023319; bh=Cuzwe97KOzTpVmRGj+7xhqsr0Czkiev78SIUaXonxK8=; b=
        Bwg3mxY+IAlC7fzEg4S1FnEfzZJlW9JuvKfCoDB4+En9s+3S73lPEIjCizOTDTUQ
        TojNtTQ1RQZTHgkPbqJd9c2LvbgxvsvdyoMcpjFlKQlK502DI+kiz1m+IfAUpqbG
        ZjvZXt618EwcDQ5ROUUSXWUOJiJ7mH6FxZhZqnVvrlnFF/JghSQE+w/6mqa8uEQ4
        MV0tetWDL/ZzNEis2NKQzolz1VQf0rxSAQzsqeGYcdW3zW5icQlHTkLp7zzEfXsY
        txjVRlw/WFC30mhgEaCCY+VLysjJUYdyj45xshpAKBXNfEPPl6wcIsGouc+bXphh
        wHQS914SlnNNqKIs/AhFOA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IY99bBDRQ59L for <linux-pci@vger.kernel.org>;
        Tue, 14 Feb 2023 19:21:58 -0800 (PST)
Received: from fedora.flets-east.jp (unknown [10.225.163.119])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PGjzn08bMz1RvLy;
        Tue, 14 Feb 2023 19:21:56 -0800 (PST)
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Rick Wertenbroek <rick.wertenbroek@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 00/12] PCI endpoint fixes and improvements
Date:   Wed, 15 Feb 2023 12:21:43 +0900
Message-Id: <20230215032155.74993-1-damien.lemoal@opensource.wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series fixes several issues with the PCI endpoint code and endpoint
test drivers (host side and EP side).

The first 2 patches address an issue with the use of configfs to create
an endpoint driver type attributes group, preventing a potential crash
if the user creates the driver attribute group directory multiple times.

The following patches are fixes and improvements for the endpoint test
drivers, EP side and host side.

This is all tested using a Pine Rockpro64 board, with the rockchip ep
driver fixed using Rick Wertenbroek <rick.wertenbroek@gmail.com>
patches [1], plus some additional fixes from me.

[1] https://lore.kernel.org/linux-pci/20230214140858.1133292-1-rick.werte=
nbroek@gmail.com/

Damien Le Moal (12):
  pci: endpoint: Automatically create a function type attributes group
  pci: endpoint: do not export pci_epf_type_add_cfs()
  pci: epf-test: Fix DMA transfer completion detection
  pci: epf-test: Use driver registers as volatile
  pci: epf-test: Simplify dma support checks
  pci: epf-test: Simplify transfers result print
  pci: epf-test: Add debug and error messages
  misc: pci_endpoint_test: Free IRQs before removing the device
  misc: pci_endpoint_test: Do not write status in IRQ handler
  misc: pci_endpoint_test: Re-init completion for every test
  misc: pci_endpoint_test: Simplify pci_endpoint_test_msi_irq()
  misc: pci_endpoint_test: Add debug and error messages

 drivers/misc/pci_endpoint_test.c              |  51 +++--
 drivers/pci/endpoint/functions/pci-epf-test.c | 207 +++++++++++-------
 drivers/pci/endpoint/pci-ep-cfs.c             |  44 ++--
 drivers/pci/endpoint/pci-epf-core.c           |  12 +-
 drivers/pci/endpoint/pci-epf.h                |  14 ++
 include/linux/pci-epf.h                       |   2 -
 6 files changed, 197 insertions(+), 133 deletions(-)
 create mode 100644 drivers/pci/endpoint/pci-epf.h

--=20
2.39.1

