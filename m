Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7169565A618
	for <lists+linux-pci@lfdr.de>; Sat, 31 Dec 2022 19:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLaSek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 31 Dec 2022 13:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiLaSei (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 31 Dec 2022 13:34:38 -0500
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5fcc:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB95DD8
        for <linux-pci@vger.kernel.org>; Sat, 31 Dec 2022 10:34:36 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id D0BE81007A8D7;
        Sat, 31 Dec 2022 19:34:33 +0100 (CET)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id A6552601C12D;
        Sat, 31 Dec 2022 19:34:33 +0100 (CET)
X-Mailbox-Line: From a2ff8481c3f08458dcd2b4028a838730e965c72f Mon Sep 17 00:00:00 2001
Message-Id: <cover.1672511016.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Sat, 31 Dec 2022 19:33:36 +0100
Subject: [PATCH 0/3] PCI reset delay fixes
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Keith Busch <kbusch@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ravi Kishore Koppuravuri <ravi.kishore.koppuravuri@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sheng Bi <windy.bi.enflame@gmail.com>,
        Stanislav Spassov <stanspas@amazon.de>,
        Yang Su <yang.su@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When recovering from a DPC reset, we neglect to observe the delays
prescribed by PCIe r6.0 sec 6.6.1 before accessing devices on the
secondary bus.  As a result, devices which take a little longer to
recover remain inaccessible because their config space is restored
too early.

One affected device is Intel's Ponte Vecchio HPC GPU.  Ravi Kishore
kindly tested that this series solves the issue.


As a byproduct, the series fixes a similar delay issue for Secondary
Bus Resets.  Sheng Bi proposed a patch last May, a variation of which
is contained herein:

https://patchwork.kernel.org/project/linux-pci/patch/20220523171517.32407-1-windy.bi.enflame@gmail.com/


A second byproduct of this series is an optimization for Secondary
Bus Resets whereby the delay after reset is reduced on modern PCIe
systems.  Yang Su and Stanislav Spassov proposed a patch in August
which is subsumed by the present series:

https://patchwork.kernel.org/project/linux-pci/patch/4315990a165dd019d970633713cf8e06e9b4c282.1660746147.git.yang.su@linux.alibaba.com/


If the present series is accepted, the two above-linked patches
can be closed in patchwork.  (For some reason, Sheng Bi's patch
is in "New" state, but marked "Archived".)

Thanks!


Lukas Wunner (3):
  PCI/PM: Observe reset delay irrespective of bridge_d3
  PCI: Unify delay handling for reset and resume
  PCI/DPC: Await readiness of secondary bus after reset

 drivers/pci/pci-driver.c |  2 +-
 drivers/pci/pci.c        | 55 +++++++++++++++++-----------------------
 drivers/pci/pci.h        |  6 ++++-
 drivers/pci/pcie/dpc.c   |  4 +--
 4 files changed, 31 insertions(+), 36 deletions(-)

-- 
2.39.0

