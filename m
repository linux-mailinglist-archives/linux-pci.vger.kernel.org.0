Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1F0826B79F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 02:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgIPA0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Sep 2020 20:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgIOOI2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Sep 2020 10:08:28 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525E3C0611C1
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 06:46:16 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id e4so1373269pln.10
        for <linux-pci@vger.kernel.org>; Tue, 15 Sep 2020 06:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cdgo8gcr3yR5N+Dt3Xu3fyRafdoq6RtuY7MnOM9virM=;
        b=CnIPnbeegGCLMjvV+Ttrb9jnBV8d4g+3XEzFqqI9X4Aghu8tpkBVcG3p5uMt5R2ZAd
         u2nkvfVIrw2o1PoO3qi0fQy7d1TFoyU6yodsXUMq5rUBdlEThEiZxkHoI3p1evRL4Tp5
         jQ2+6DoK9BcWRYZ7Yyk9O2wsiQaBnmlQee96E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cdgo8gcr3yR5N+Dt3Xu3fyRafdoq6RtuY7MnOM9virM=;
        b=m4Jq2TOBmDQZwnnSCuly/R185GGBBTpWhMS2d8sA9jaYs92+4uhtH9ZvQptul3tTKY
         cczP9YByzGqSbtqrfPvHtup1xfzvjceBNPf3a7eVqjQ9+NP9VDi0cqaT1MecJ62lKMUP
         1HOgLRFfmGsEFZi5qt0Ir1udWqR6xG4sW0U/NxI6ESuBxErERgY8ODkpswmMfPnWW30D
         NXpDSmq6BTrqdGBOQzr1B3IP9RwvxTOhsccnUsUsDpb2QZovx/Cs5fJLIWJuQs9GgqPA
         h2suf5X+0W1N24DIGlunjOKlzgdwj2v+DAEQXXw/naMz9jkYZEF/dPvhkHlWGUZfUge/
         bInA==
X-Gm-Message-State: AOAM5307If+XtAPFy0AhZYEGdy6iAk3L/zlLJnKMZG1D7QvuY7bnSRw8
        UhmiH5flF5FpxiWOg97S4EgiNg==
X-Google-Smtp-Source: ABdhPJwmupdPJkXxq/Xvz8pxucXHnT0qli4TU7cgSEMHSMSOmquu4nXVAEisl1KN+Su+p8HYGgitZw==
X-Received: by 2002:a17:902:d693:b029:d1:bb0f:5f9d with SMTP id v19-20020a170902d693b02900d1bb0f5f9dmr14884498ply.30.1600177575714;
        Tue, 15 Sep 2020 06:46:15 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz6sm12471478pjb.22.2020.09.15.06.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:46:15 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ray Jui <rjui@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bharat Gooty <bharat.gooty@broadcom.com>
Subject: [PATCH v2 1/3] PCI: iproc: fix out of bound array access
Date:   Tue, 15 Sep 2020 19:15:39 +0530
Message-Id: <20200915134541.14711-2-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200915134541.14711-1-srinath.mannam@broadcom.com>
References: <20200915134541.14711-1-srinath.mannam@broadcom.com>
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
index 905e93808243..d901b9d392b8 100644
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
2.17.1

