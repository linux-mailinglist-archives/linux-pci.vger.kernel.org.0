Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 600FD43E8B0
	for <lists+linux-pci@lfdr.de>; Thu, 28 Oct 2021 20:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJ1S7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Oct 2021 14:59:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJ1S7a (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Oct 2021 14:59:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D547160232;
        Thu, 28 Oct 2021 18:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635447422;
        bh=JVaUM0O/0Y2lrwPTC0Icy+R73uMMfLCmd7auUUdLFDU=;
        h=From:To:Cc:Subject:Date:From;
        b=bGv+KirqkK3704ZjbwkoMdwVOGaT2uy/UxtEeVARfReWKKj0d+rnXL3nR0U2VfP02
         YNngE8K/HISOFcQAHTbnmIM2BQaolWs/mT0Snj2ggnP25BgCID5zCq82RNx4K0j9qK
         iE8tFFpI1DDyPPAz0F1Nn+xKKM4i0TR/2e7n9hEB8aFFqP71SDKAECnukrBoXr61Zf
         bCPFA/E+uGn3R5ZOKW6v2Y70YbGcWukj5LH3lClLPJMPa4yXdKGqBsGSPWyS0MRoFM
         hs5ccLsTFAsb4wWyDEvv54eTWwTJ3/f8dHojlZ4gjGtIPAVNgMsYsjh8VZ1QRL8bS1
         4+fHeD/2eX2MA==
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, pali@kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v2 0/7] PCI: aardvark controller fixes BATCH 2
Date:   Thu, 28 Oct 2021 20:56:52 +0200
Message-Id: <20211028185659.20329-1-kabel@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Lorenzo,

this is v2 of the second batch of aardvark changes.

As requested, I have removed patches 4-10, which will be rebased and
sent in the next batch.

Also as requested I have removed my Reviewed-by tags, since there are
my Signed-off-by tags.

Marek

Marek Behún (3):
  PCI: pci-bridge-emul: Fix emulation of W1C bits
  PCI: aardvark: Fix return value of MSI domain .alloc() method
  PCI: aardvark: Read all 16-bits from PCIE_MSI_PAYLOAD_REG

Pali Rohár (4):
  PCI: aardvark: Fix support for bus mastering and PCI_COMMAND on
    emulated bridge
  PCI: aardvark: Set PCI Bridge Class Code to PCI Bridge
  PCI: aardvark: Fix support for PCI_BRIDGE_CTL_BUS_RESET on emulated
    bridge
  PCI: aardvark: Fix support for PCI_ROM_ADDRESS1 on emulated bridge

 drivers/pci/controller/pci-aardvark.c | 119 ++++++++++++++++++++++----
 drivers/pci/pci-bridge-emul.c         |  13 +++
 2 files changed, 114 insertions(+), 18 deletions(-)

-- 
2.32.0

