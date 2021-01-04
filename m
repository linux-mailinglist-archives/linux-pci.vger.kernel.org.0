Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC0E2EA060
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jan 2021 00:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbhADXD7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 18:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbhADXDq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 18:03:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB290207BC;
        Mon,  4 Jan 2021 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609801386;
        bh=3xE90EwgxIf5klY98ppGvbBWp1gjgssLoO469lQo6/s=;
        h=From:To:Cc:Subject:Date:From;
        b=EWEsWJ+iNhV1TsxPli9MvI/QPVa0oSKGqPneVmbAJw9c3GRiY1bZrqM/HtMLuZz1R
         MF9hIEH3M5/eL8bUMfPD5uBIuryuaetxtujdgf40/6L7ddhCFtn8C7l9SRP8ZlddGR
         NurQE2vBBlmkaOkSdaD2Pt8vtuRowvK8VZNX02dPHW+GgSQlH7LOpXNUDR+jFv/EwS
         sNVLcRLY4/eIcCSuX6yIGHMaDY/2nmQSjnUNNybXTye/Jcrm1WZlme94cnex2ovl9U
         ar2aPioDQs6UbyT33hlullTB5CN3untuOb3o3QEeuPIMpDLnDdL8MGzRLhLm6WlOtE
         3PEqQcfWO1LVw==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/5] aer handling fixups
Date:   Mon,  4 Jan 2021 15:02:55 -0800
Message-Id: <20210104230300.1277180-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Changes from v1:

  Added received Acks

  Split the kernel print identifying the port type being reset.

  Added a patch for the portdrv to ensure the slot_reset happens without
  relying on a downstream device driver..

Keith Busch (5):
  PCI/ERR: Clear status of the reporting device
  PCI/AER: Actually get the root port
  PCI/ERR: Retain status from error notification
  PCI/AER: Specify the type of port that was reset
  PCI/portdrv: Report reset for frozen channel

 drivers/pci/pcie/aer.c         |  5 +++--
 drivers/pci/pcie/err.c         | 16 +++++++---------
 drivers/pci/pcie/portdrv_pci.c |  3 ++-
 3 files changed, 12 insertions(+), 12 deletions(-)

-- 
2.24.1

