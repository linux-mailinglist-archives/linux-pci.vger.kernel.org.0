Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20529F9D
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2019 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391819AbfEXUQQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 May 2019 16:16:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33752 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391816AbfEXUQQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 May 2019 16:16:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hUGbu-00032N-CE; Fri, 24 May 2019 14:16:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hUGbu-00026Q-4D; Fri, 24 May 2019 14:16:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 24 May 2019 14:16:07 -0600
Message-Id: <20190524201610.8039-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 0/3] Cleanup resource_alignment parameter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a follow up to the cleanup I started last cycle on the
resource_alignment parameter after finding an improved way to do handle
the static buffer for the disable_acs_redir parameter. So this patchset
allows us to drop a significant chunk of static data.

Per the discussion last cycle, this version keeps the spin locks
(instead of the RCU implementation) and splits the change into a
couple different patches.

Thanks,

Logan

--

Logan Gunthorpe (3):
  PCI: Clean up resource_alignment parameter to not require static
    buffer
  PCI: Move pci_[get|set]_resource_alignment_param() into their callers
  PCI: Force trailing new line to resource_alignment_param in sysfs

 drivers/pci/pci.c | 65 +++++++++++++++++++++++++----------------------
 1 file changed, 35 insertions(+), 30 deletions(-)

--
2.20.1
