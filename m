Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86C049AE58
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jan 2022 09:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451583AbiAYIri (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jan 2022 03:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451852AbiAYIns (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jan 2022 03:43:48 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA99C06B5AC
        for <linux-pci@vger.kernel.org>; Mon, 24 Jan 2022 23:18:28 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JjdVn4XYTz9sjv;
        Tue, 25 Jan 2022 08:18:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: [PATCH v4 0/3] Fully enable AER
Date:   Tue, 25 Jan 2022 08:18:17 +0100
Message-Id: <20220125071820.2247260-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While working on AER support on a ZynqMP based system, which has some
PCIe Device connected via a PCIe switch, problems with AER enabling in
the Device Control registers of all PCIe devices but the Root Port. In
fact, only the Root Port has AER enabled right now. This patch set now
fixes this problem by first fixing the AER enabing in the
interconnected PCIe switches between the Root Port and the PCIe
devices and in a 2nd patch, also enabling AER in the PCIe Endpoints.

Please note that these changes are quite invasive, as with these
patches applied, AER now will be enabled in the Device Control
registers of all available PCIe Endpoints, which currently is not the
case.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pali Rohár <pali@kernel.org>
Cc: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc: Michal Simek <michal.simek@xilinx.com>
Cc: Yao Hongbo <yaohongbo@linux.alibaba.com>
Cc: Naveen Naidu <naveennaidu479@gmail.com>

Stefan Roese (3):
  PCI/AER: Call pcie_set_ecrc_checking() for each PCIe device
  PCI/portdrv: Don't disable AER reporting in
    get_port_device_capability()
  PCI/AER: Enable AER on all PCIe devices supporting it

 drivers/pci/pcie/aer.c          | 10 +++++++---
 drivers/pci/pcie/portdrv_core.c |  9 +--------
 2 files changed, 8 insertions(+), 11 deletions(-)

-- 
2.35.0

