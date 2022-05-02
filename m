Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E73516D7C
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 11:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384259AbiEBJmW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 05:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381191AbiEBJmV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 05:42:21 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F6111144;
        Mon,  2 May 2022 02:38:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B6B5441982;
        Mon,  2 May 2022 09:38:47 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Hector Martin <marcan@marcan.st>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: apple: PWREN GPIO support & related fixes
Date:   Mon,  2 May 2022 18:38:29 +0900
Message-Id: <20220502093832.32778-1-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

This short series adds support for the PWREN GPIO to the Apple PCIe
controller driver, and along the way fixes some GPIO handling issues
which cropped up.

Since the PWREN GPIO is provided by SMC which is a fairly high level
driver, PCI can probe before it is ready. Worse, only some devices
need PWREN, which can make the probe fail halfway through with some
ports initialized and not others, which the driver cannot recover
gracefully from. The second patch fixes this situation, so probe
deferral works properly in these cases. The third patch adds PWREN
support per se, and the first one is just related stuff I noticed
while writing this.

Hector Martin (3):
  PCI: apple: GPIO handling nitfixes
  PCI: apple: Probe all GPIOs for availability first
  PCI: apple: Add support for optional PWREN GPIO

 drivers/pci/controller/pcie-apple.c | 67 ++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 7 deletions(-)

-- 
2.35.1

