Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874E52CDE08
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 19:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbgLCSwA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 13:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgLCSwA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 13:52:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Kishore <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        Vidya Sagar <sagar.tv@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v3 0/3] PCI/MSI: Cleanup init and improve 32-bit MSI checking
Date:   Thu,  3 Dec 2020 12:51:07 -0600
Message-Id: <20201203185110.1583077-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

MSI/MSI-X init was a little unconventional.  We had pci_msi_setup_pci_dev()
to disable MSI and MSI-X, in probe.c instead of msi.c so we could do it
even without CONFIG_PCI_MSI.  Move that to msi.c and fix the config issue
with an #ifdef.

Then add Vidya's patch on top.  Previous postings at

https://lore.kernel.org/linux-pci/20201117145728.4516-1-vidyas@nvidia.com/
https://lore.kernel.org/linux-pci/20201124105035.24573-1-vidyas@nvidia.com/

Bjorn Helgaas (2):
  PCI/MSI: Move MSI/MSI-X init to msi.c
  PCI/MSI: Move MSI/MSI-X flags updaters to msi.c

Vidya Sagar (1):
  PCI/MSI: Set device flag indicating only 32-bit MSI support

 drivers/pci/Makefile |  3 +-
 drivers/pci/msi.c    | 70 ++++++++++++++++++++++++++++++++++++++++----
 drivers/pci/pci.h    | 23 ++-------------
 drivers/pci/probe.c  | 21 ++-----------
 4 files changed, 70 insertions(+), 47 deletions(-)

-- 
2.25.1

