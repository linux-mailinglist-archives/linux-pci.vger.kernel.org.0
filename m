Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6A4134CEAE
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 13:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhC2LSe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 07:18:34 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:52388 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232517AbhC2LSE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 07:18:04 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 77A90C049B;
        Mon, 29 Mar 2021 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617016682; bh=5cMTfaevxwhLCPNLc3DOzhIMBgSPdAEVTKWnQRu8vbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=dcyKplOmmYUa6e5QgBpCkrNeb/cbQT+PUnOv//hk5Nmz7VGz307W81K94Qa1udpjr
         aK7Z5wUxXMLlrJb2qwzQw85v+/h6Y58ior207wuJheGXPJecfLQ+MY1/+S5+3IwZT0
         xf/RRaOkbP9qB/thXpiyST+EwI7GN1EY+muXVWOSoMIZcZFfX47ESmsKPwzoWMv/EW
         dLqESNxUiImLLb4yUTW2JWV7dUNMGpr3sNz0pbdO3KbQZ0MSPguThs4trPI4t6xg/e
         6fieu4Nl2s51fXsL5FVNdYMpGdx+vxhYGteJEGPDeqlADBawOxIPe1AgXVNjTmsB8F
         kU/1gh0XO0Dlw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3905DA0231;
        Mon, 29 Mar 2021 11:18:01 +0000 (UTC)
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
Subject: [PATCH v10 3/4] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Mon, 29 Mar 2021 13:17:47 +0200
Message-Id: <c8fb9af0ba8c86c5cf8afbfc0eb07fc99a642270.1617016509.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
References: <cover.1617016509.git.gustavo.pimentel@synopsys.com>
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

