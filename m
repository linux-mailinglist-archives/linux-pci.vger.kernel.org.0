Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00F2631387
	for <lists+linux-pci@lfdr.de>; Fri, 31 May 2019 19:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfEaRMY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 May 2019 13:12:24 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38126 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbfEaRMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 May 2019 13:12:22 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hWl4l-0005iv-Dq; Fri, 31 May 2019 11:12:21 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hWl4k-0005Lu-Lb; Fri, 31 May 2019 11:12:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Kit Chow <kchow@gigaio.com>, Yinghai Lu <yinghai@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 31 May 2019 11:12:14 -0600
Message-Id: <20190531171216.20532-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, bhelgaas@google.com, kchow@gigaio.com, yinghai@kernel.org, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_NO_TEXT autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v3 0/2] Fix a pair of setup bus bugs
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hey,

This is another resend to get some more attention. Nothing has changed
since v2.

For the first patch, there's a lot more information in the original
thread here[1] including instructions on how to reproduce it in QEMU.

The second patch fixes an unrelated bug, with similar symptoms, in
the same code. It was a lot easier to debug and the reasoning should
hopefully be easier to follow, but I don't think it was reviewed much
during the first posting due to the nightmare in the first patch.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/de3e34d8-2ac3-e89b-30f1-a18826ce5d7d@deltatee.com/T/#m96ba95de4678146ed46b602e8bfd6ac08a588fa2

--

Changes in v3:

* Rebased onto v5.2-rc2 (no changes)

Changes in v2:

* Rebased onto v5.1-rc6 (no changes)
* Reworked the commit message in the first commit to try and explain
  it better.

--

Logan Gunthorpe (2):
  PCI: Prevent 64-bit resources from being counted in 32-bit bridge
    region
  PCI: Fix disabling of bridge BARs when assigning bus resources

 drivers/pci/setup-bus.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

--
2.20.1
