Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A045AA96
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 18:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbhKWR53 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 12:57:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:53206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235026AbhKWR52 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 23 Nov 2021 12:57:28 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98DEE60E08;
        Tue, 23 Nov 2021 17:54:20 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mpZzm-007LZW-7l; Tue, 23 Nov 2021 17:54:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Cc:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        Luca Ceresoli <luca@lucaceresoli.net>, kernel-team@android.com
Subject: [PATCH v3 0/3] PCI: apple: Assorted #PERST fixes
Date:   Tue, 23 Nov 2021 17:54:13 +0000
Message-Id: <20211123175413.79722-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, pali@kernel.org, alyssa@rosenzweig.io, lorenzo.pieralisi@arm.com, bhelgaas@google.com, mark.kettenis@xs4all.nl, luca@lucaceresoli.net, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Apologies for the rapid fire (I tend to be much more conservative when
resending series), but given that this series has a direct impact on
other projects (such as u-boot), I'm trying to converge as quickly as
possible.

This series aims at fixing a number of issues for the recently merged
Apple PCIe driver, all revolving around the mishandling of #PERST:

- we didn't properly drive #PERST, and we didn't follow the specified
  timings
  
- the DT had the wrong polarity, which has impacts on the driver
  itself

Hopefully, this should address all the issues reported so far.

* From v2:
  - Fixed DT
  - Fixed #PERST polarity in the driver
  - Collected Pali's ack on patch #1

[1] https://lore.kernel.org/r/20211122104156.518063-1-maz@kernel.org

Marc Zyngier (3):
  PCI: apple: Follow the PCIe specifications when resetting the port
  arm64: dts: apple: t8103: Fix PCIe #PERST polarity
  PCI: apple: Fix #PERST polarity

 arch/arm64/boot/dts/apple/t8103.dtsi |  7 ++++---
 drivers/pci/controller/pcie-apple.c  | 12 +++++++++++-
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.30.2

