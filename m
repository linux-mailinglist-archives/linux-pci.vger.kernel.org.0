Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395F4563795
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jul 2022 18:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbiGAQQ6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jul 2022 12:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiGAQQ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Jul 2022 12:16:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74D503E0D2;
        Fri,  1 Jul 2022 09:16:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82D12113E;
        Fri,  1 Jul 2022 09:16:57 -0700 (PDT)
Received: from pierre123.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9577C3F66F;
        Fri,  1 Jul 2022 09:16:55 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH RESEND v1 0/2] Make _PRS and _SRS methods optional
Date:   Fri,  1 Jul 2022 18:16:22 +0200
Message-Id: <20220701161624.2844305-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PCI legacy interrupts can be described with link devices,
cf ACPI 6.4, s6.2.13 "_PRT (PCI Routing Table)".
Link devices can have optional _SRS/_PRS methods to set the interrupt.

In PCI Firmware Specification Revision 3.3, s4.3.2.1. "Resource Setting":
"""
A non-configurable device only specifies _CRS. However, if they are
configurable, devices include _PRS to indicate the possible resource
setting and _SRS to allow OSPM to specify a new resource allocation
for the device.
"""

However, _PRS/_SRS methods are checked in drivers/acpi/pci_link.c,
and the driver aborts if they are absent.
E.g.: When _PRS is missing:
ACPI: \_SB_.PCI0.LNKA: _CRS 36 not found in _PRS
ACPI: \_SB_.PCI0.LNKA: No IRQ available. Try pci=noacpi or acpi=off

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=215560

Pierre Gondois (2):
  ACPI/PCI: Make _SRS optional for link device
  ACPI/PCI: Make _PRS optional for link device

 drivers/acpi/pci_link.c | 46 ++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 14 deletions(-)

-- 
2.25.1

