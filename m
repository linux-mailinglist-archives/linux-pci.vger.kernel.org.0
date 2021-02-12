Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF031A397
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 18:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhBLR3V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 12:29:21 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:42750 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230489AbhBLR3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2021 12:29:17 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E2A37C0447;
        Fri, 12 Feb 2021 17:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613150897; bh=x6qwlQ3unob1xa78MC32IMOFOlfkiuMvvCbd1vCCzC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZWnuMBnspqhPjf20f+p1rWTKlCcJkSAZwoa0TR0Lsq6AjuMdbAWaFmXulFTzcAXvE
         f3jRH+nPP0MzXRQg21LkXxA8LFl4+bJOkUiPPZwWxA8FMVuAt+dUkPMBDa4yqwPM9q
         fAJg4HhgWBUHcgxwboYOgacG0oCp6JQuBNtgOALT9GwQb9eZWkprQ4/ADSfhM3DdSN
         s+OxC6q90XehSNIVKdfxWr/FNubsFZdRfYpcyrzKe5tKlpb3bvFr0BbA0IeaQDwcsl
         a6xGhfts9tsjJRtn+oT4kY36bJsBiadtiNPBoxY9bTtH4o+/Y9Lu5WE/t+9wi6KOFO
         G60P8f0r21FSA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A92AEA0061;
        Fri, 12 Feb 2021 17:28:15 +0000 (UTC)
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
Subject: [PATCH v6 4/5] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Fri, 12 Feb 2021 18:28:06 +0100
Message-Id: <b64d6aacd93fb8a0389894da885a7c2db631324b.1613150798.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
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

