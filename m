Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B556493720
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jan 2022 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352755AbiASJWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jan 2022 04:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353011AbiASJWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Jan 2022 04:22:07 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C3C06161C
        for <linux-pci@vger.kernel.org>; Wed, 19 Jan 2022 01:22:07 -0800 (PST)
Received: from smtp102.mailbox.org (unknown [91.198.250.119])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Jf0XF0wTDzQkH3;
        Wed, 19 Jan 2022 10:22:05 +0100 (CET)
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
Subject: [PATCH v3 0/2] Fully enable AER
Date:   Wed, 19 Jan 2022 10:21:58 +0100
Message-Id: <20220119092200.35823-1-sr@denx.de>
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

Stefan Roese (2):
  PCI/portdrv: Don't disable AER reporting in
    get_port_device_capability()
  PCI/AER: Enable AER on all PCIe devices supporting it

 drivers/pci/pcie/aer.c          | 4 ++++
 drivers/pci/pcie/portdrv_core.c | 9 +--------
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.34.1

