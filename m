Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06737357618
	for <lists+linux-pci@lfdr.de>; Wed,  7 Apr 2021 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbhDGUcZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 16:32:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39326 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235383AbhDGUcS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 16:32:18 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8380B4033B;
        Wed,  7 Apr 2021 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617827529; bh=ljWrh/V+jjyshJq1tEtkHGu8o5CvHoVPksiOthk9lm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=S4V6ulbI/9JDWD4cFvzqwU9FoPNCYhWU3/bo5ggONaTXDyjPFyhfmY+fLI/0Y1N7I
         6HE4qF2XAAPjMyhZrcbGGzSlqxINWb/OrmCKP7wVZXWDIVQBS/RdV/gOwDvWHuI7Z3
         CTEc6cylQkZPGwzjlU/M6d3cNDksCHzWYVuYG2AIIqoHvKRPmi5MVvugY/YpKmgxt0
         5Q3G4i9QXU6YvAd/YNZfBnKEGT07VQaHVoSy/U89lnh8CgLPhQmdAaNFf5TPAgMxTJ
         U8kkaRSLkWTZaKTY4JgQlyaGQA+2pqFTTPD+S/fInikz8+mH86oAPXSkkTg1GdkeX2
         GwYwek/jGf0Xg==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 7CBE1A0233;
        Wed,  7 Apr 2021 20:32:05 +0000 (UTC)
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
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v3 2/2] misc-device: Add dw-xdata-pcie to toctree(index)
Date:   Wed,  7 Apr 2021 22:31:49 +0200
Message-Id: <0f148947ff8be9c798eecbd222b70abfff42ba2e.1617827290.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617827290.git.gustavo.pimentel@synopsys.com>
References: <cover.1617827290.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617827290.git.gustavo.pimentel@synopsys.com>
References: <cover.1617827290.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the recent addition of dw-xdata-pcie, the documentation build now
warns about a missing reference on the table of content related to it.

This fix solves the following error:

Documentation/misc-devices/dw-xdata-pcie.rst: WARNING: document isn't
included in any toctree

Fixes: e1181b5bbc3c ("Documentation: misc-devices: Add Documentation for dw-xdata-pcie driver")
Link: https://lore.kernel.org/linux-next/20210406214615.40cf3493@canb.auug.org.au/
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 Documentation/misc-devices/index.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index 64420b331..30ac58f 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -19,6 +19,7 @@ fit into other categories.
    bh1770glc
    eeprom
    c2port
+   dw-xdata-pcie
    ibmvmc
    ics932s401
    isl29003
-- 
2.7.4

