Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C105802D9
	for <lists+linux-pci@lfdr.de>; Mon, 25 Jul 2022 18:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236190AbiGYQjK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Jul 2022 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236231AbiGYQjK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Jul 2022 12:39:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D71A51CFF7;
        Mon, 25 Jul 2022 09:39:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1719D2B;
        Mon, 25 Jul 2022 09:39:09 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C26F3F73D;
        Mon, 25 Jul 2022 09:39:08 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     will@kernel.org, bhelgaas@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
        kw@linux.com, mark.rutland@arm.com, sudeep.holla@arm.com,
        boqun.feng@gmail.com, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/4] PCI SMC conduit, now with DT support
Date:   Mon, 25 Jul 2022 11:39:01 -0500
Message-Id: <20220725163905.2024437-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a rebase of the later revisions of [1], but refactored
slightly to add a DT method as well. It has all the same advantages of
the ACPI method (putting HW quirks in the firmware rather than the
kernel) but now applied to a 'pci-host-smc-generic' compatible
property which extends the pci-host-generic logic to handle cases
where the PCI Config region isn't ECAM compliant. With this in place,
and firmware managed clock/phy/etc its possible to run the generic
driver on hardware that isn't what one would consider standards
compliant PCI root ports.

The DT code was tested on the RPi4, where the ACPI/SMC is upstream in
TF-A and EDK2. On that platform the PCIe works as expected utilizing
the generic host driver rather than the pcie-brcmstb driver.

[1] https://lkml.org/lkml/2021/1/4/1255

Jeremy Linton (4):
  arm64: smccc: Add PCI SMCCCs
  arm64: PCI: Enable SMC conduit
  PCI: host-generic: Add firmware managed config ops
  dt-bindings: PCI: Note the use of pci-host-smc-generic

 .../bindings/pci/host-generic-pci.yaml        |  24 +++-
 arch/arm64/kernel/pci.c                       | 109 ++++++++++++++++++
 drivers/pci/controller/pci-host-common.c      |  34 ++++--
 drivers/pci/controller/pci-host-generic.c     |   6 +
 include/linux/arm-smccc.h                     |  29 +++++
 5 files changed, 186 insertions(+), 16 deletions(-)

-- 
2.37.1

