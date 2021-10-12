Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D574142A9B9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Oct 2021 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJLQnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 12:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229606AbhJLQnt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 12:43:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 25EB361076;
        Tue, 12 Oct 2021 16:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634056908;
        bh=NZhMb+UpsgrT6N8N6fqbgXqxqhd71Gxi1v/hYo4DMUc=;
        h=From:To:Cc:Subject:Date:From;
        b=B/xRAtrVStv+KbYs2ZNIAtK5TyevMPFKnIpZqxgiTtQywYLpYmA2+STKSJ1OoaKGl
         yVbfuqF0Tg3RFhcDBRWilV9UlBMorfvCGKRW4CG1IxLmnGJnt+UdBpbClhJkMuYcfw
         k7ZetoLZrfQay2SFLyJ6aVb9HaVRNCeqAfGPIHw6u3Av7YgYn0PvTBl/4ENP7GWg/n
         WaAn9OCv5MQvkN4zGuhzsP+wGrHXyyzMHOLCYsJOg0DG/hRI7RVAcYfV9qUPbYvsXl
         p9PeNcAIxkVhJoyXsXrv8NWppBWzD2AYISoHca18kPSwIm7Zbw54tMzVrRCS4hCyqp
         8PJPRUuvqc7jQ==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        pali@kernel.org, =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH 00/14] PCI: aardvark controller fixes BATCH 2
Date:   Tue, 12 Oct 2021 18:41:31 +0200
Message-Id: <20211012164145.14126-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

we are sending second batch of updates for Aardvark PCIe controller.

- patch 1 fixes pci-bridge-emul handling of W1C bits
- patches 2-9 fix MSI interrupts
- patch 10 enables MSI-X interrupts
- patches 11-14 fix registers in emulated PCI bridge

Marek & Pali

Marek Behún (3):
  PCI: pci-bridge-emul: Fix emulation of W1C bits
  PCI: aardvark: Fix return value of MSI domain .alloc() method
  PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG

Pali Rohár (11):
  PCI: aardvark: Fix support for MSI interrupts
  PCI: aardvark: Fix reading MSI interrupt number
  PCI: aardvark: Clear all MSIs at setup
  PCI: aardvark: Refactor unmasking summary MSI interrupt
  PCI: aardvark: Fix masking MSI interrupts
  PCI: aardvark: Fix setting MSI address
  PCI: aardvark: Enable MSI-X support
  PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on
    emulated bridge
  PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
  PCI: aardvark: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated
    bridge
  PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge

 drivers/pci/controller/pci-aardvark.c | 226 ++++++++++++++++++++------
 drivers/pci/pci-bridge-emul.c         |  13 ++
 2 files changed, 188 insertions(+), 51 deletions(-)

-- 
2.32.0

