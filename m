Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200F5B4E52
	for <lists+linux-pci@lfdr.de>; Sun, 11 Sep 2022 13:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiIKLXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Sep 2022 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiIKLXH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Sep 2022 07:23:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25772663;
        Sun, 11 Sep 2022 04:21:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4639060E9B;
        Sun, 11 Sep 2022 11:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719BBC433D6;
        Sun, 11 Sep 2022 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662895312;
        bh=i/8RNdF4fIf2jIET0PhL9Ssf48I1ZP8JWvmjfkVVEAw=;
        h=From:To:Cc:Subject:Date:From;
        b=F75H1/HAwJwME7QOAlR+0f2q8aCbLVzTysODEfr9C0K7A/QVLWQsPE1RjnSctw9LJ
         a1B6KA3vZ83ieVksPIUI1YEzsYgf2VjGx6duxcpjv95CrjMv5uTwjFHyETkhJMEyL+
         Ob7U43Rkb80ERbRlSotGf5rAOLPOXHbRYSI5Jv2DIuFQqxDkfkQ0loT85UVGRxdyx6
         17I6ByzKbO3gLTN0tizqj3aaERz/Mbc1hTSB3z+Pk3BHFvJF4z7xINXVpNuonZphBQ
         pSactYYc6yVKOhQ9XBSSqIppt2SbOuLnHG6Oqvt5NgA/VMHcVRV9zeELV1QDBir5by
         m0KHqaVDruNCA==
Received: by pali.im (Postfix)
        id AB127878; Sun, 11 Sep 2022 13:21:49 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [RFC PATCH 0/3] PCI: Introduce new PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() macros
Date:   Sun, 11 Sep 2022 13:20:21 +0200
Message-Id: <20220911112024.14304-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Introduce a new file linux/pci-conf1.h with PCI_CONF1_ADDRESS() and
PCI_CONF1_EXT_ADDRESS() macros and convert two drivers pci-ftpci100.c
and pcie-mt7621.c to use it.

There are many more drivers which could be converted to this common
macros. This is just RFC patch series and if you like it, I can look at
conversion of other drivers.

What do you think?

Note that similar cleanup was applied for U-Boot PCI controller drivers:
https://lore.kernel.org/u-boot/20211126104252.5443-1-pali@kernel.org/

Pali Rohár (3):
  PCI: Add standard PCI Config Address macros
  PCI: ftpci100: Use PCI_CONF1_ADDRESS() macro
  PCI: mt7621: Use PCI_CONF1_EXT_ADDRESS() macro

 drivers/pci/controller/pci-ftpci100.c | 22 +++---------
 drivers/pci/controller/pcie-mt7621.c  |  4 +--
 include/linux/pci-conf1.h             | 51 +++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 19 deletions(-)
 create mode 100644 include/linux/pci-conf1.h

-- 
2.20.1

