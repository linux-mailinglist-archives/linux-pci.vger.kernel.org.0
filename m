Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86A4219393D
	for <lists+linux-pci@lfdr.de>; Thu, 26 Mar 2020 08:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbgCZHII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Mar 2020 03:08:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34585 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgCZHIF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Mar 2020 03:08:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id 65so6439762wrl.1
        for <linux-pci@vger.kernel.org>; Thu, 26 Mar 2020 00:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=afg8dNB66EeO23R6bSZJHyegs9ORKcUpXptgDs7UTws=;
        b=NkGvO6uYSAMxMcb9P0RAg0D3yHckMsjCJgy81OSyDdL8EF5sHoZxsihiKBUJYqIQO0
         FkmG1UfasybW7KR8tmBkKkkF3pTqzVP3/mgrEq2721W34udH76Kg/t0NKLtbP6vyBlpc
         0zMeDxmnwXlItGBygP6bdmXi34qI8MUNpDSm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=afg8dNB66EeO23R6bSZJHyegs9ORKcUpXptgDs7UTws=;
        b=b2Rx8/FlxmUG2lFtG9KjMSLBQoDdJTPQvfKQMEKqtPjRi0pGkuW4MItodiuTzETIuV
         Z1ufmRVCzCeMqQ+m+vVliBGk7DHDbou39BlcdLXSZzh18wlgQ6o/Ra29dV52KPRJv4K5
         vgZJL5TM0F1oa4VtBJTQMVn+EB3+66iyGhAkaEy2WR3uj6Jt4kQfoTFW64tMGMPxb3ct
         9jSH5G/0GGuy56O4EGo08CJ+om05QCa+oqWf/2PN9lsy6lT4a+MV2T5kKN2Etux5/8YP
         mcFkQyktFWe64IQLEYcpjAUUl+F32XS8mGePsYPjStP/WvVPwpd5aUR+GWYlL5js1NCH
         /DOw==
X-Gm-Message-State: ANhLgQ0Zy5vZ/aM3c94Xu8VxgHPk5Eo3FJgVrxead6b4+8xcn+I10Mlc
        95YvyEy5t9UXgbauHEOoK91Zpg==
X-Google-Smtp-Source: ADFU+vs4AXz8FI0fPBQ54wsPqGouqEqXUvwleEGkLy2ntX9wK7IYngl27SxZG3aUl2DSzFShBbL0tA==
X-Received: by 2002:adf:e68b:: with SMTP id r11mr7161551wrm.138.1585206483395;
        Thu, 26 Mar 2020 00:08:03 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u8sm2129446wrn.69.2020.03.26.00.07.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:08:02 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: [PATCH 1/3] PCI: iproc: fix out of bound array access
Date:   Thu, 26 Mar 2020 12:37:25 +0530
Message-Id: <1585206447-1363-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
References: <1585206447-1363-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bharat Gooty <bharat.gooty@broadcom.com>

Declare the full size array for all revisions of PAX register sets
to avoid potentially out of bound access of the register array
when they are being initialized in the 'iproc_pcie_rev_init'
function.

Fixes: 06324ede76cdf ("PCI: iproc: Improve core register population")
Signed-off-by: Bharat Gooty <bharat.gooty@broadcom.com>
---
 drivers/pci/controller/pcie-iproc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index 0a468c7..6972ca4 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -307,7 +307,7 @@ enum iproc_pcie_reg {
 };
 
 /* iProc PCIe PAXB BCMA registers */
-static const u16 iproc_pcie_reg_paxb_bcma[] = {
+static const u16 iproc_pcie_reg_paxb_bcma[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -318,7 +318,7 @@ static const u16 iproc_pcie_reg_paxb_bcma[] = {
 };
 
 /* iProc PCIe PAXB registers */
-static const u16 iproc_pcie_reg_paxb[] = {
+static const u16 iproc_pcie_reg_paxb[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -334,7 +334,7 @@ static const u16 iproc_pcie_reg_paxb[] = {
 };
 
 /* iProc PCIe PAXB v2 registers */
-static const u16 iproc_pcie_reg_paxb_v2[] = {
+static const u16 iproc_pcie_reg_paxb_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x120,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x124,
@@ -363,7 +363,7 @@ static const u16 iproc_pcie_reg_paxb_v2[] = {
 };
 
 /* iProc PCIe PAXC v1 registers */
-static const u16 iproc_pcie_reg_paxc[] = {
+static const u16 iproc_pcie_reg_paxc[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_CLK_CTRL]		= 0x000,
 	[IPROC_PCIE_CFG_IND_ADDR]	= 0x1f0,
 	[IPROC_PCIE_CFG_IND_DATA]	= 0x1f4,
@@ -372,7 +372,7 @@ static const u16 iproc_pcie_reg_paxc[] = {
 };
 
 /* iProc PCIe PAXC v2 registers */
-static const u16 iproc_pcie_reg_paxc_v2[] = {
+static const u16 iproc_pcie_reg_paxc_v2[IPROC_PCIE_MAX_NUM_REG] = {
 	[IPROC_PCIE_MSI_GIC_MODE]	= 0x050,
 	[IPROC_PCIE_MSI_BASE_ADDR]	= 0x074,
 	[IPROC_PCIE_MSI_WINDOW_SIZE]	= 0x078,
-- 
2.7.4

