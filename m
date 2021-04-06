Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D236355B05
	for <lists+linux-pci@lfdr.de>; Tue,  6 Apr 2021 20:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240404AbhDFSIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Apr 2021 14:08:02 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:35854 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232876AbhDFSIC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Apr 2021 14:08:02 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A43A540031;
        Tue,  6 Apr 2021 18:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617732474; bh=S6cOsqxe037fjdIYzX+/jnn4hCGE134NlmKz+eWZVUg=;
        h=From:To:Cc:Subject:Date:From;
        b=ab29aTfWlhRXDKAUxOiTn1gzoyrtz2GzTzLvvl2BWPmZswZQDxfbdB6GRo+AyqNrZ
         ZZeTkV+0M4RMERGby+6Peaibli6cGFDMAznSrYWkdrZWalIZaOIPz6wWhckNE6Kbyk
         /jdrWwCZICbe1c1D6kyNxKjoONoKOOkkzoK4LSF5T6ZvnhmfmnKoyk8VvG+BuWBE2w
         1wrspuoDhuwsckwie8ZRx3PZYRWv+XukliP+BG/UIvxVG2Wk7twVGWhi+kWVQPvU0G
         gJMcJg1IS6FSFdKQ7gZ5AB92iR91OXhAovn0Z/WbFUhcZNSv1zvu+cZV0fyumVKbJW
         GrWPERR44xwXw==
Received: from de02dwvm009.internal.synopsys.com (de02dwvm009.internal.synopsys.com [10.225.17.73])
        by mailhost.synopsys.com (Postfix) with ESMTP id 07864A022E;
        Tue,  6 Apr 2021 18:07:50 +0000 (UTC)
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
Subject: [PATCH] Documentation: misc-devices: Add missing entry on the table of content related to dw-xdata-pcie
Date:   Tue,  6 Apr 2021 20:07:43 +0200
Message-Id: <1fedd7b269b5d5543333340c44f0a917f578389d.1617732463.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add missing entry on the table of content related to dw-xdata-pcie misc
driver reported in a warning by doing *make htmldocs*.

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

