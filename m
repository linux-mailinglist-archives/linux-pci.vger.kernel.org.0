Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9225AD92
	for <lists+linux-pci@lfdr.de>; Wed,  2 Sep 2020 16:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgIBOpC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 2 Sep 2020 10:45:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgIBOo2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Sep 2020 10:44:28 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54F7320767;
        Wed,  2 Sep 2020 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599057847;
        bh=PKHjUtAreXfWb++VphGeoWKV+TcuA+RY4EiaozG6fBk=;
        h=From:To:Cc:Subject:Date:From;
        b=tL0jebnX5Prxdd++Cm7XmzFmxmOr88Sg43klka4x49j57xFUpqR5AmDWbQh6VE6lf
         bPND0fKd3z38QErZUJkQBn+6HxsLtZj+dFbO5LBDEsLH7fjyIRf0cYnoTNvv2OZ8hG
         bTfUzk0ZPTALjYJvIeiC19QBRJVLUDYyKsxbTaGM=
Received: by pali.im (Postfix)
        id E7D777BF; Wed,  2 Sep 2020 16:44:04 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] PCI: aardvark: Fix comphy with old ATF
Date:   Wed,  2 Sep 2020 16:43:42 +0200
Message-Id: <20200902144344.16684-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes regression introduced in commit 366697018c9a
("PCI: aardvark: Add PHY support") which caused aardvark driver
initialization failure on EspressoBin board with factory version of
Arm Trusted Firmware provided by Marvell.

Second patch depends on the first patch, so please add appropriate
Fixes/Cc:stable@ tags to have both patches correctly backported to
stable kernels.

I have tested both patches with Marvell ATF firmware ebin-17.10-uart.zip
and with upstream ATF+uboot and aardvark was initialized successfully.
Without this patch series on ebin-17.10-uart.zip aardvark initialization
failed.

Pali Rohár (2):
  phy: marvell: comphy: Convert internal SMCC firmware return codes to
    errno
  PCI: aardvark: Fix initialization with old Marvell's Arm Trusted
    Firmware

 drivers/pci/controller/pci-aardvark.c        |  4 +++-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c | 14 +++++++++++---
 drivers/phy/marvell/phy-mvebu-cp110-comphy.c | 14 +++++++++++---
 3 files changed, 25 insertions(+), 7 deletions(-)

-- 
2.20.1

