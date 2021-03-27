Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B244534B3EF
	for <lists+linux-pci@lfdr.de>; Sat, 27 Mar 2021 04:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbhC0DHl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 23:07:41 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50552 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230304AbhC0DHK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Mar 2021 23:07:10 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A70CE40461;
        Sat, 27 Mar 2021 03:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1616814430; bh=x6qwlQ3unob1xa78MC32IMOFOlfkiuMvvCbd1vCCzC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=cRDphQ3Elz1Od2ARVRM0lJmlpTvn5EBBt+e3FjN+7RZbA6Yn814lpV1UiaSKraRrA
         nQ9t5Ei1FKXWWIRipx7OUCAR1O5Jl3OkrjNqDTzb1Ht0SDoUj8iN+WMNXsiyJ5pqEk
         2FMLHc31Qy4IrjhY7sRnKZrD3Yndq8vu9vUyGQeSMRZcQSZ145GVnuskWDNbxX6O/1
         GtEamt2wl5jmzlCtSkplX6WzzBIGfcyAnyOWTgOV+YyzcTFnmQBR6qcTHDyeMtuzXL
         TRYMQC6/gcTyHNHA3KWU6sjvzmYHRiQ3tR9tSWGydtXSf29ZDLBlyluVrCG4XtXHP9
         gnWnt5G97QtuQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 6F1F8A0230;
        Sat, 27 Mar 2021 03:07:09 +0000 (UTC)
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
Subject: [PATCH v7 4/5] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Sat, 27 Mar 2021 04:06:54 +0100
Message-Id: <f47b5ac2d5203d057b69cb0ed5525c40015c0221.1616814273.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
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

