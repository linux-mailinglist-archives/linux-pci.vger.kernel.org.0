Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C8934CD7B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbhC2KAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:00:09 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44326 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhC2J7z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:59:55 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 45A6440490;
        Mon, 29 Mar 2021 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011995; bh=5cMTfaevxwhLCPNLc3DOzhIMBgSPdAEVTKWnQRu8vbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=a0Iw0Y8xu1dbEB4m03HeoZC5qDY1VRRkdhuvmC3WMFlNsuo3O817Ngq0C5zx+ZTvV
         inhbH0pxdSV5z6qlz0S0bjuxHsWAFBCiv5KMnPIE5qk5rpeAKi9Vcfg4cQuI6fC7o9
         f5UILkiDfnVxcak8RwXQM6M9yhrIZhWVl+cB9xe5gE5hVG5Q1k4Dt65XmkiVwaJrxE
         vcIMLHvNRkjRfoB9tGYTOo5NZ4z0oK6q7ljO1ueCiv9M1jYSiF6RKqaNB/laB0GwYE
         Q91N/+CLCJq5Y7OYSs7qp+lSf755zMS1q3VgYDCWfnB3L7VEeu3Zvwy0aAw5TwD96D
         OhAI6qBcKR0ew==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 0C16EA022F;
        Mon, 29 Mar 2021 09:59:54 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v9 3/4] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Mon, 29 Mar 2021 11:59:39 +0200
Message-Id: <4f6e72a86184cabcae98e392e3a6099a128bcd73.1617011831.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys xData IP driver maintainer.

This driver aims to support Synopsys xData IP and is normally distributed
along with Synopsys PCIe EndPoint IP as a PCIe traffic generator (depends
of the use and licensing agreement).

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9e87692..36387b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5099,6 +5099,13 @@ S:	Maintained
 F:	drivers/dma/dw-edma/
 F:	include/linux/dma/edma.h
 
+DESIGNWARE XDATA IP DRIVER
+M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/misc-devices/dw-xdata-pcie.rst
+F:	drivers/misc/dw-xdata-pcie.c
+
 DESIGNWARE USB2 DRD IP DRIVER
 M:	Minas Harutyunyan <hminas@synopsys.com>
 L:	linux-usb@vger.kernel.org
-- 
2.7.4

