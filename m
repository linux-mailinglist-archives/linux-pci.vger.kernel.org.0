Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4C5E8AB6
	for <lists+linux-pci@lfdr.de>; Sat, 24 Sep 2022 11:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiIXJYV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 24 Sep 2022 05:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiIXJYU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 24 Sep 2022 05:24:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8DB139BC5;
        Sat, 24 Sep 2022 02:24:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AFDB60DED;
        Sat, 24 Sep 2022 09:24:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EACC433C1;
        Sat, 24 Sep 2022 09:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664011459;
        bh=sH0EgeLtUBzTINPkwseRdDvepvwmB/n4Ui79CYX9/WY=;
        h=From:To:Cc:Subject:Date:From;
        b=CdWw8+VtB1snVkG7pyt7IWDC7NMXod+BPq2WJixQZ/9aDc7eC8PaEUzfKlCDMPhcA
         QU/o4fR5reRoUXUtLK1LPK0LzRh/8Cy7QMvbZq2WfSB7mYwBmkDAuMp9Rom9QMdg+9
         nDQqGZh07nf9jKI5rtrmezItKPEZ1zI6xL2L2+PxOKlulpjaw+ch0UCYOI4dhUNPY0
         A/WWy3NoCZAGzKZzJCVWqfKrYlpY8bMV7aY001o3QaSYdOy8bGD+yXFsSWqKO4bOXQ
         EHDcm8cJ2/DuKqE1C5zWMG1cYw8Rpvx/heoAawl2QKq2dLK8mA6zC/w+3fjZV1oU4h
         wsW7n0OElpxQw==
Received: by pali.im (Postfix)
        id D83548A2; Sat, 24 Sep 2022 11:24:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 0/3] PCI: Introduce new PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() macros
Date:   Sat, 24 Sep 2022 11:24:01 +0200
Message-Id: <20220924092404.31776-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCI controllers and lot of non-ECAM compliant PCIe controllers still use
Intel PCI Configuration Mechanism #1 for accessing PCI config space.

Native PCIe controller drivers invents its own macros which implements
config space address calculation and in lof of cases it is just
duplication of the same code.

PCIe ECAM address macro PCIE_ECAM_OFFSET() is already in include header
file linux/pci-ecam.h and ECAM compliant drivers were already converted
to use it.

Do similar thing also for Intel PCI Configuration Mechanism #1.
Introduce into file drivers/pci/pci.h new PCI_CONF1_ADDRESS() and
PCI_CONF1_EXT_ADDRESS() macros and convert two drivers pci-ftpci100.c
and pcie-mt7621.c to use it.

There are many more drivers which could be converted to this common
macros. This can be done later.

Note that similar cleanup was applied for U-Boot PCI controller drivers:
https://lore.kernel.org/u-boot/20211126104252.5443-1-pali@kernel.org/

Changes since RFC:
* Move macros to file drivers/pci/pci.h

Pali Rohár (3):
  PCI: Add standard PCI Config Address macros
  PCI: ftpci100: Use PCI_CONF1_ADDRESS() macro
  PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro

 drivers/pci/controller/pci-ftpci100.c | 21 +++----------
 drivers/pci/controller/pcie-mt7621.c  | 17 ++++------
 drivers/pci/pci.h                     | 45 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 28 deletions(-)

-- 
2.20.1

