Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D1F3186D2
	for <lists+linux-pci@lfdr.de>; Thu, 11 Feb 2021 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhBKJQu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Feb 2021 04:16:50 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:34068 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230052AbhBKJKr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Feb 2021 04:10:47 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6EE13401D9;
        Thu, 11 Feb 2021 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613034553; bh=x6qwlQ3unob1xa78MC32IMOFOlfkiuMvvCbd1vCCzC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=OLtSWyt1IrHosK6QLJkU19M9Rrlv3ASey1ySvQ6Ao1Gi+ykbo6yH9KiSyfAbVqsQR
         Su0AB85Q2O+ZGfbY378P0e7wVLKWfBw+yS+wFQsfGrCuPJaJWk+TeG/ffIO/29jLD0
         WcvIMIWutp8pIheVlEbh88HT1hV2X0K2a4Ihs0HIG7nY/cgsk3oIb8qBjufEayRFQs
         kkAz4pAU6S9mMFmZAsCAIgqr0zCbaeHAtL1hlJ9q2SmE1Fw5KUm327jQJIA4EITQro
         XiRQU3hfHrUYLXlN0JEDcdxdXHc9MCVHlsxNxp7e+nQcmz/pQRYvVAOcqq7U6bhuw8
         qywi3nGKDjq8A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3496AA005E;
        Thu, 11 Feb 2021 09:09:12 +0000 (UTC)
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
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v5 5/6] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Thu, 11 Feb 2021 10:08:42 +0100
Message-Id: <748e23c798df091835577037ed75fab130e3dfb8.1613034397.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
References: <cover.1613034397.git.gustavo.pimentel@synopsys.com>
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
index 546aa66..f9d681b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5061,6 +5061,13 @@ S:	Maintained
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

