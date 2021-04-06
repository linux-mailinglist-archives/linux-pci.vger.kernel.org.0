Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B034355DC2
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 23:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbhDFVSa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 17:18:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:43970 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343557AbhDFVS1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 17:18:27 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AC3A040162;
        Tue,  6 Apr 2021 21:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617743898; bh=I39mNIIOg5r9X23rTW3gwgLBPAUiq25Gsn6X8FHiBiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ACBdF6TJX9rbSJvuLvbSmDayWVcgzbaZF67XPOW9b5EyD0DRadPnYl3QwRWYJ1xJQ
         NQ8uB+DVZhIxjQuC6pEKhSk0iUWQJfGMnFaTecgBSo3d1WPD9tydvp1sll8d4wxEEd
         fyjG9qcLArp+2gP0TBi85Y2vd5+jIF7DTBTIb0stBeuyoPtj9Zj+BMUzB2Wn5DpOrP
         VZ/j6boh4nLAn04i3VBhKbbdDVH7EbUmnqZCGddX6BrX3uaFozRw9449I5W1A7Lz3A
         fAAUPHPTZIZzMjMLFyfz7SlpChqvhMMgSlGP44i/0AQg+37iNSBSkzkciP8TML3FT8
         zQ6otFqMXJTDA==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id B5A24A0233;
        Tue,  6 Apr 2021 21:18:15 +0000 (UTC)
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
Subject: [PATCH v2 2/2] Documentation: misc-devices: Add missing entry on the table of content related to dw-xdata-pcie
Date:   Tue,  6 Apr 2021 23:17:49 +0200
Message-Id: <497449dedb9af867605dc54a07e4e48753749e25.1617743702.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
References: <cover.1617743702.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing entry on the table of content related to dw-xdata-pcie misc
driver reported in a warning by doing *make htmldocs*.

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

