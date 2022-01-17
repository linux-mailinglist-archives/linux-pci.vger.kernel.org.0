Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5489749036C
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jan 2022 09:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237872AbiAQIE0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jan 2022 03:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237866AbiAQIEY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jan 2022 03:04:24 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3D9C061574
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 00:04:24 -0800 (PST)
Received: from smtp1.mailbox.org (unknown [91.198.250.123])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JckvV3QX5zQl9Z
        for <linux-pci@vger.kernel.org>; Mon, 17 Jan 2022 09:04:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
From:   Stefan Roese <sr@denx.de>
To:     linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] Fully enable AER
Date:   Mon, 17 Jan 2022 09:03:46 +0100
Message-Id: <20220117080348.2757180-1-sr@denx.de>
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

Please note that these changes are quite invasie, as with these patches
applied, AER now will be enabled in the Device Control registers of all
available PCIe Endpoints, which currently is not the case.

Stefan Roese (2):
  PCI/portdrv: Don't disable AER reporting in
    get_port_device_capability()
  PCI/AER: Enable AER on Endpoints as well

 drivers/pci/pcie/aer.c          | 3 ++-
 drivers/pci/pcie/portdrv_core.c | 9 +--------
 2 files changed, 3 insertions(+), 9 deletions(-)

-- 
2.34.1

