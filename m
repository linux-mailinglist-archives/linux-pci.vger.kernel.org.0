Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838A71AACB9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Apr 2020 18:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415137AbgDOQBY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Apr 2020 12:01:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:51980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415132AbgDOQBT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Apr 2020 12:01:19 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0C7A206F9;
        Wed, 15 Apr 2020 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586966478;
        bh=HtmYGm9rwoS1yuOpLorCoobfvar2sayOeSxcIlUCURM=;
        h=From:To:Cc:Subject:Date:From;
        b=X3mn1rSyk1+FHEiTjmAk5CWv5wKT+oPgBNud+agJZ4Pamj6To3NuosaiNu3U6Dto7
         NL8V5hO1Zhfc+GHdHTdmKh/Qib3L0Ra7DzVOcQU7sP+r4ylAZkFdALh+8n6ggNIoaf
         d+PIzzbqO0u1W/lsURHLBB0bSZH8X+qIJaKNAr0w=
Received: by pali.im (Postfix)
        id C080C58E; Wed, 15 Apr 2020 18:01:15 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Remi Pommarel <repk@triplefau.lt>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 0/8] PCI: aardvark: Fix support for Turris MOX and Compex wifi cards
Date:   Wed, 15 Apr 2020 18:00:46 +0200
Message-Id: <20200415160054.951-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes PCI aardvark controller to work on Turris MOX
with Compex WLE900VX (and also other ath10k) wifi cards.

Patches are available also in my git repository in branch pci-aardvark:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-aardvark

Pali Rohár (8):
  PCI: aardvark: Set controller speed from Device Tree max-link-speed
  dts: espressobin: Define max-link-speed for pcie0
  PCI: aardvark: Start link training immediately after enabling link
    training
  PCI: aardvark: Do not overwrite Link Status register and ASPM Control
    bits in Link Control register
  PCI: aardvark: Set final controller speed based on negotiated link
    speed
  PCI: aardvark: Add support for issuing PERST via GPIO
  dts: aardvark: Route pcie reset pin to gpio function and define
    reset-gpios for pcie
  PCI: aardvark: Add FIXME for code which access
    PCIE_CORE_CMD_STATUS_REG

 .../dts/marvell/armada-3720-espressobin.dtsi  |   2 +
 .../dts/marvell/armada-3720-turris-mox.dts    |   4 -
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |   2 +-
 drivers/pci/controller/pci-aardvark.c         | 118 +++++++++++++++---
 4 files changed, 106 insertions(+), 20 deletions(-)

-- 
2.20.1

