Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7E330E5DB
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhBCWN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 17:13:59 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:32834 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232693AbhBCWN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Feb 2021 17:13:58 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id D55714048E;
        Wed,  3 Feb 2021 22:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1612390378; bh=x6qwlQ3unob1xa78MC32IMOFOlfkiuMvvCbd1vCCzC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=Xe9rt32y8QdKsGjyzxrolSHXrZUey63GCbtQTXNSThQ4DLYOPa8mE8pnIzDDjLcQB
         8m8HgniwAtsCyNZZ3DVEpguXpaoxPV5i/fLafJnyqCW1wk5mtDLyKYjXFPh+9zBPBr
         EhK6qbDL5JFzBOB0KPVJhS8fdSx9bIjpqCWq+pUAaZEhAF3R8wyNQK/kxshzfYbaPY
         9KSjz5FwMao17T+UgfgDfRdHkrFqjAMZbA1nWg6vCcavPvtEp+KldMAoISLOvqLoOK
         H5h6myMhoZN9RRACzml2t3bJtsAbccIEIlhFGdJ3yB8tfo9FoDghawhA22QumIIcGf
         SO5qmu48icgiw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9E137A024E;
        Wed,  3 Feb 2021 22:12:56 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [RESEND v4 5/6] MAINTAINERS: Add Synopsys xData IP driver maintainer
Date:   Wed,  3 Feb 2021 23:12:50 +0100
Message-Id: <52f2cbdae433e73d0c07d93d30cfd45ad520c60f.1612390291.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
References: <cover.1612390291.git.gustavo.pimentel@synopsys.com>
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

