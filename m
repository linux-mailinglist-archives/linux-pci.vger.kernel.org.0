Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C27C41C1
	for <lists+linux-pci@lfdr.de>; Tue, 10 Oct 2023 22:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbjJJUoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Oct 2023 16:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbjJJUop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 10 Oct 2023 16:44:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF38AF;
        Tue, 10 Oct 2023 13:44:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E628BC433C8;
        Tue, 10 Oct 2023 20:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696970683;
        bh=c9YXaik+EtzOrhfSVPVJBAAh9bfr5kdbZa5i/HmizSU=;
        h=From:To:Cc:Subject:Date:From;
        b=BT6JH4aJROfk/UjqxHLBv/ppkK9Tk6RJP9TqvgVQlQNkegcJthIcqjORd3EC/2Oly
         c2kixUf9iWzuoauAXo023EpO1x6hg/C2YM+XdVokJMz9zmXqPycBtsin19a/pvWO0B
         Hw8HSkA1U8K/z2X9vENnKQpNcMAeJN2uFvnoHsrA/vYkHaGHU43D/GI1KkmOtcc3pn
         jdn89DxT8QrbNUfwuBXq8Q2gb+gHdby5RBrebmGwdcJ6uWDGmBXiKovWeoQ6Usifx9
         qIkDT3wAuY/vvCfvvIVgDfJHc3DPl7bUAMGOn47tnfak4AtK1Mn2Ayoy2/+l5Q2wZJ
         wrY++KpDgWbVA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 00/10] PCI: Use FIELD_GET() and FIELD_PREP()
Date:   Tue, 10 Oct 2023 15:44:26 -0500
Message-Id: <20231010204436.1000644-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use FIELD_GET() and FIELD_PREP() to avoid the need for shifting.

These apply on top of the PCI patches from Ilpo's series:
  https://lore.kernel.org/r/20230919125648.1920-1-ilpo.jarvinen@linux.intel.com

Bjorn Helgaas (10):
  PCI: Use FIELD_GET()
  PCI: Use FIELD_GET() in Sapphire RX 5600 XT Pulse quirk
  PCI/ASPM: Use FIELD_GET()
  PCI/ATS: Show PASID Capability register width in bitmasks
  PCI/ATS: Use FIELD_GET()
  PCI/DPC: Use FIELD_GET()
  PCI/PME: Use FIELD_GET()
  PCI/PTM: Use FIELD_GET()
  PCI/VC: Use FIELD_GET()
  PCI/portdrv: Use FIELD_GET()

 drivers/pci/ats.c             |  7 ++---
 drivers/pci/pci.c             | 53 +++++++++++++++++------------------
 drivers/pci/pcie/aspm.c       | 31 +++++++++++---------
 drivers/pci/pcie/dpc.c        |  9 +++---
 drivers/pci/pcie/pme.c        |  4 ++-
 drivers/pci/pcie/portdrv.c    |  7 +++--
 drivers/pci/pcie/ptm.c        |  5 ++--
 drivers/pci/probe.c           |  8 +++---
 drivers/pci/quirks.c          |  2 +-
 drivers/pci/vc.c              |  9 +++---
 include/uapi/linux/pci_regs.h | 15 ++++++----
 11 files changed, 81 insertions(+), 69 deletions(-)

-- 
2.34.1

