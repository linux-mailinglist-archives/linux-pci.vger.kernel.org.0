Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A0145F04F
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 16:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354172AbhKZPJl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 10:09:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354090AbhKZPHj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 10:07:39 -0500
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 06:51:38 PST
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F1F6C0617A2;
        Fri, 26 Nov 2021 06:51:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CC13B817C2;
        Fri, 26 Nov 2021 14:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4AFC9305D;
        Fri, 26 Nov 2021 14:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637937831;
        bh=UQaHfiZlDvO4Kzphkp39M5zsuDIBv2p8I/85lnkES94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FnDvhFg6r12KqdAljP5Pu4YZ8y+EJhXKYemJi39PD5A/N+aCfQrZMB/VPmoVn8RGU
         TIB6/tvlGF/j/JX8REy4RFgvuJtVdh3hbMeh7PKmE/8ytdBdc8nEvv8mx94FfNTb0v
         eOXOrdLkP0yWhqu9zKgQ4VjdMXRtaEctJNrr5MZeUcnCslU3B5ytwUen7xfl5xarNx
         u7gLsjkBHsI0Etx3GxHJogBnWNbxFN5Z5FQEBAY8ZxiLF5xUq4pXgrARdWjtj0OP8K
         WaaUHqHr9aJNLLByboPKN1LXTfmNjbDfxfPNstRlSlOuauDhW3L27d44dmiYRyFYWz
         D4C7Olfmlffcg==
Received: by pali.im (Postfix)
        id 6D91CEF1; Fri, 26 Nov 2021 15:43:48 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] bus: mvebu-mbus: Export symbols for public API window functions
Date:   Fri, 26 Nov 2021 15:43:06 +0100
Message-Id: <20211126144307.7568-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211126144307.7568-1-pali@kernel.org>
References: <20211126144307.7568-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This would allow to compile pci-mvebu.c driver as module.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/bus/mvebu-mbus.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index ea0424922de7..db612045616f 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -914,6 +914,7 @@ int mvebu_mbus_add_window_remap_by_id(unsigned int target,
 
 	return mvebu_mbus_alloc_window(s, base, size, remap, target, attribute);
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_add_window_remap_by_id);
 
 int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
 				phys_addr_t base, size_t size)
@@ -921,6 +922,7 @@ int mvebu_mbus_add_window_by_id(unsigned int target, unsigned int attribute,
 	return mvebu_mbus_add_window_remap_by_id(target, attribute, base,
 						 size, MVEBU_MBUS_NO_REMAP);
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_add_window_by_id);
 
 int mvebu_mbus_del_window(phys_addr_t base, size_t size)
 {
@@ -933,6 +935,7 @@ int mvebu_mbus_del_window(phys_addr_t base, size_t size)
 	mvebu_mbus_disable_window(&mbus_state, win);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_del_window);
 
 void mvebu_mbus_get_pcie_mem_aperture(struct resource *res)
 {
@@ -940,6 +943,7 @@ void mvebu_mbus_get_pcie_mem_aperture(struct resource *res)
 		return;
 	*res = mbus_state.pcie_mem_aperture;
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_get_pcie_mem_aperture);
 
 void mvebu_mbus_get_pcie_io_aperture(struct resource *res)
 {
@@ -947,6 +951,7 @@ void mvebu_mbus_get_pcie_io_aperture(struct resource *res)
 		return;
 	*res = mbus_state.pcie_io_aperture;
 }
+EXPORT_SYMBOL_GPL(mvebu_mbus_get_pcie_io_aperture);
 
 int mvebu_mbus_get_dram_win_info(phys_addr_t phyaddr, u8 *target, u8 *attr)
 {
-- 
2.20.1

