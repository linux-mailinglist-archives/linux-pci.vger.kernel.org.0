Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94E8355A4F
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346953AbhDFR1N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 13:27:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:33588 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346927AbhDFR1M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 13:27:12 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id C9976400F9;
        Tue,  6 Apr 2021 17:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617730024; bh=5cMTfaevxwhLCPNLc3DOzhIMBgSPdAEVTKWnQRu8vbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Wn4lpIYKLq8wj1Hzc2QMV3qKQ/KH33kqXe3nm+r6uqOv4PH0PTAi+uZYRvsjw8OCh
         138DoelPjSN/BnP+oebEc/fpLBjnmdKjk2JlBd9UCctiCouoaoVG12kKhqiI6MAsn/
         TBYXVZqf70UpsRzzrUoy+3QdMr6UFN07rJQIrJINiWu0+6gIIlwAysdup0vY/C2DjA
         ZpYTMV7xlJmg4/9jA0WgREG2pEtcHqpBLH9P0EF3AKdxE1AMXQMLaIu5TMpkIndk9g
         MJsEWOOh1MvnezT4fnjxnMSi7PbfxAVVk6J2taIVFhrUL+vW30LBq+P3jNQLYEJzMp
         RP9puOI+vtfxg==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 91FCBA022F;
        Tue,  6 Apr 2021 17:27:02 +0000 (UTC)
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
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v11 3/4] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Tue,  6 Apr 2021 19:26:48 +0200
Message-Id: <4bd9499f4e3228da338041d99e551aea37599af1.1617729785.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
References: <cover.1617729785.git.gustavo.pimentel@synopsys.com>
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

