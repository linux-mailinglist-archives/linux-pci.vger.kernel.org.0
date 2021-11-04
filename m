Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A6C445930
	for <lists+linux-pci@lfdr.de>; Thu,  4 Nov 2021 19:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhKDSEP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 Nov 2021 14:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:54226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234033AbhKDSEO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 4 Nov 2021 14:04:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9AB761207;
        Thu,  4 Nov 2021 18:01:36 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.lan)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mih3O-003WTf-Na; Thu, 04 Nov 2021 18:01:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rui Salvaterra <rsalvaterra@gmail.com>, kernel-team@android.com
Subject: [PATCH 0/2] PCI: MSI: Deal with devices lying about their masking capability
Date:   Thu,  4 Nov 2021 18:01:28 +0000
Message-Id: <20211104180130.3825416-1-maz@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, tglx@linutronix.de, rsalvaterra@gmail.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rui reported[1] that his Nvidia ION system stopped working with 5.15,
with the AHCI device failing to get any MSI. A rapid investigation
revealed that although the device doesn't advertise MSI masking, it
actually needs it. Quality hardware indeed.

Anyway, the couple of patches below are an attempt at dealing with the
issue in a more or less generic way.

[1] https://lore.kernel.org/r/CALjTZvbzYfBuLB+H=fj2J+9=DxjQ2Uqcy0if_PvmJ-nU-qEgkg@mail.gmail.com

Marc Zyngier (2):
  PCI: MSI: Deal with devices lying about their MSI mask capability
  PCI: Add MSI masking quirk for Nvidia ION AHCI

 drivers/pci/msi.c    | 3 +++
 drivers/pci/quirks.c | 6 ++++++
 include/linux/pci.h  | 2 ++
 3 files changed, 11 insertions(+)

-- 
2.30.2

