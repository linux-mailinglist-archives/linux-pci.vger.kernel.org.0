Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D03B3927
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 00:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhFXW32 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 18:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229521AbhFXW32 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 18:29:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 53ECC61375;
        Thu, 24 Jun 2021 22:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624573628;
        bh=KWZRyJ0iEyvtpktbnQcV6kk8yj6NL7oIa4RExWmzxgY=;
        h=From:To:Cc:Subject:Date:From;
        b=FLbDGTWCNQYhuKT94MciN1sHgQdOJpDWDOP5uQN65ginI0e89WsAUEstER2utdbA6
         AZnYdjmmIDrYxLd+kdYsMRtMzq9D47cKBuJE2O0Gjn4BcdDcugqABJZTGb5uQ0TFk5
         WEXbQ5ut6aMx6nwHdcbosFlIEBjYBbsods00dkNoX7nGLNZt5uuIyFOmZ3b1iWql02
         fqZD66A8PEPyCpi0Q8JkTKQL92xlElE5UGbpBzklN0fsmC+doPKz7teVzB1Z9+wHTV
         oz3u65yC37pN06l/jrieX+wQKlexExoSz0swjAYEeoQ1c2OfAHlroCoBhzrpzj63hR
         BSOb5igqyRx7Q==
Received: by pali.im (Postfix)
        id D3CF28A3; Fri, 25 Jun 2021 00:27:05 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        "Remi Pommarel" <repk@triplefau.lt>, Xogium <contact@xogium.me>,
        "Tomasz Maciej Nowak" <tmn505@gmail.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Kostya Porotchkin <kostap@marvell.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH 0/5] PCI: aardvark: Initialization fixes
Date:   Fri, 25 Jun 2021 00:26:16 +0200
Message-Id: <20210624222621.4776-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Per Lorenzo's request [1] I'm resending [2] some other aardvark patches
which fixes initialization.

The last patch 5/5 is the new and was not in previous patch series [2].
Please see detailed description and additional comment after --- section.

[1] - https://lore.kernel.org/linux-pci/20210603151605.GA18917@lpieralisi/
[2] - https://lore.kernel.org/linux-pci/20210506153153.30454-1-pali@kernel.org/

Pali Rohár (5):
  PCI: aardvark: Fix link training
  PCI: Add PCI_EXP_DEVCTL_PAYLOAD_* macros
  PCI: aardvark: Fix PCIe Max Payload Size setting
  PCI: aardvark: Implement workaround for the readback value of VEND_ID
  PCI: aardvark: Implement workaround for PCIe Completion Timeout

 drivers/pci/controller/pci-aardvark.c | 138 ++++++++++----------------
 include/uapi/linux/pci_regs.h         |   6 ++
 2 files changed, 60 insertions(+), 84 deletions(-)

-- 
2.20.1

