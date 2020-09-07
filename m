Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8455D25F935
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 13:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgIGLUq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 07:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728703AbgIGLUg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:36 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3912168B;
        Mon,  7 Sep 2020 11:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599477055;
        bh=pbOfow5vag3gTuUiXJsk3w65QeSK1YC8q7mI90YISaE=;
        h=From:To:Subject:Date:From;
        b=bMxpYFbxNuEgXRkoI/DHctwkDSX4T1RoL1Jx1VOaH4rAinH1A0TIJQRqiUFQ08cwW
         o/WMvMhAG2mU6HZyM/IYwZummkFl0ujE/jFeCaHLJ6rr0oJ0TdIbqQgMN9cKB+jy0I
         uEHy7dsQAfPmCUuKj19b9hDoDXdX7Pon44hEbTkY=
Received: by pali.im (Postfix)
        id 151BA814; Mon,  7 Sep 2020 13:10:53 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>, marek.behun@nic.cz
Subject: [PATCH v3 0/5] PCIe aardvark controller improvements
Date:   Mon,  7 Sep 2020 13:10:33 +0200
Message-Id: <20200907111038.5811-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

we have some more improvements for PCIe aardvark controller (Armada 3720
SOC - EspressoBIN and Turris MOX).

The main improvement is that with these patches the driver can be compiled
as a module, and can be reloaded at runtime.

Marek & Pali


Changes in V3:
* Rebased on top of the v5.9-rc1 release

Changes in V2 for patch 4/5:
* Protect pci_stop_root_bus() and pci_remove_root_bus() function calls by
  pci_lock_rescan_remove() and pci_unlock_rescan_remove()

Pali Rohár (5):
  PCI: aardvark: Fix compilation on s390
  PCI: aardvark: Check for errors from pci_bridge_emul_init() call
  PCI: pci-bridge-emul: Export API functions
  PCI: aardvark: Implement driver 'remove' function and allow to build
    it as module
  PCI: aardvark: Move PCIe reset card code to advk_pcie_train_link()

 drivers/pci/controller/Kconfig        |   2 +-
 drivers/pci/controller/pci-aardvark.c | 104 ++++++++++++++++----------
 drivers/pci/pci-bridge-emul.c         |   4 +
 3 files changed, 71 insertions(+), 39 deletions(-)

-- 
2.20.1

