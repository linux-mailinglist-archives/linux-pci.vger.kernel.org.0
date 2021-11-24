Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C194C45C962
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 17:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347725AbhKXQDW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 11:03:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:57502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347714AbhKXQDW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 11:03:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8985B60EB5;
        Wed, 24 Nov 2021 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637769612;
        bh=uE1rwnk+nHFJiiJ6WEvHWQ3T/ATYKsK6lDIpu5GvS3w=;
        h=From:To:Cc:Subject:Date:From;
        b=MhUV52nlX7OFhRJjVH0LGKEkM06R//H3pB8hlh8zIJyHnQMTgUB/tUPPFGeDGHWTy
         8s4T76K1pavt+VKJXcNXWs9NDIERizzZBWp5k7GYrefqDKxj1gZSWSJ//Bka8/DTJ6
         1h8EmMKByRq0lAF1B8SWn3z4mtS5X7sDw744mMJA8xb2cgXocvHxW3diq+EG9FAXPp
         u5ll9uFQy5JYgoWlH9+sEzizt2WetSpcA+pyBsyn+Ytg/aTLdCSp/0x3TAaVvLsM0g
         OK7qGKEE4Q78cuJPlR0aVfm4a9E6Yj1pxgje0fLL3WgN3FXEmfvYTe0eRAyaIFvqe9
         A97m7NDFBvzjg==
Received: by pali.im (Postfix)
        id 1904256D; Wed, 24 Nov 2021 17:00:10 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] PCI: pci-bridge-emul: Various fixes
Date:   Wed, 24 Nov 2021 16:59:38 +0100
Message-Id: <20211124155944.1290-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series contains various fixes for pci-bridge-emul code.
This code is used only by pci-aardvark.c and pci-mvebu.c drivers.

Pali Rohár (6):
  PCI: pci-bridge-emul: Make expansion ROM Base Address register
    read-only
  PCI: pci-bridge-emul: Properly mark reserved PCIe bits in PCI config
    space
  PCI: pci-bridge-emul: Add definitions for missing capabilities
    registers
  PCI: pci-bridge-emul: Fix definitions of reserved bits
  PCI: pci-bridge-emul: Correctly set PCIe capabilities
  PCI: pci-bridge-emul: Set PCI_STATUS_CAP_LIST for PCIe device

 drivers/pci/controller/pci-aardvark.c |   4 +-
 drivers/pci/controller/pci-mvebu.c    |   8 ++
 drivers/pci/pci-bridge-emul.c         | 113 ++++++++++++++++++++++----
 3 files changed, 108 insertions(+), 17 deletions(-)

-- 
2.20.1

