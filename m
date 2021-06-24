Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFA23B38F6
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 23:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbhFXV63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 17:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:60306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhFXV63 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 17:58:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B89D5613B9;
        Thu, 24 Jun 2021 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624571769;
        bh=slipC8dGfBgDgxDLZ5iCLz5k1CcTU4Vtq1lKSgtz9D0=;
        h=From:To:Cc:Subject:Date:From;
        b=BIaqdFGp1N5hMO9FWorW3GrKZ6ih5FSKYhBvRWduHSmpt08KFjt/niaARULaU8kRV
         N4I8uhg1cGNx4z3R0v9LvBY0SCU5D8DqnohSq76WYbmFoPyRhFjSzeBa+ThjgkT85f
         7PSZX/CH1ENJmDkSIogRKXZE57ZXEaJ7qd6Gx0dQVQ7pomosSKiVGxPpwmtja278sb
         hL94axN36e3qFt8L4OCqUhpNcE/G/Zk1a2B/wH55XcTnaKZK9xCudtuP8PSBX8Fymr
         sBz2Sk65G1ZPZ2P6tigzxjmHa20fivxODOJ40UuhhuXdscxdVpMM5E0SvkfEhjECCv
         zay8h5MnmuKVA==
Received: by pali.im (Postfix)
        id 3A3EC8A3; Thu, 24 Jun 2021 23:56:07 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Remi Pommarel" <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        "Marc Zyngier" <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] PCI: aardvark: Resource fixes
Date:   Thu, 24 Jun 2021 23:55:44 +0200
Message-Id: <20210624215546.4015-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series fixes configuring PCIe resources (IO and MEM) in
aardvark controller driver. It is required to initialize BARs on systems
with more cards, e.g. NVMe disks and WiFi AX cards.

Pali Rohár (2):
  PCI: aardvark: Configure PCIe resources from 'ranges' DT property
  arm64: dts: marvell: armada-37xx: Extend PCIe MEM space

 .../dts/marvell/armada-3720-turris-mox.dts    |  17 ++
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  11 +-
 drivers/pci/controller/pci-aardvark.c         | 195 +++++++++++++++++-
 3 files changed, 220 insertions(+), 3 deletions(-)

-- 
2.20.1

