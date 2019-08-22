Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0211A998DC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 18:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389694AbfHVQKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 12:10:16 -0400
Received: from ale.deltatee.com ([207.54.116.67]:47820 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725934AbfHVQKQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Aug 2019 12:10:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i0pfC-00079E-EJ; Thu, 22 Aug 2019 10:10:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i0pfC-0001RB-5F; Thu, 22 Aug 2019 10:10:14 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 22 Aug 2019 10:10:10 -0600
Message-Id: <20190822161013.5481-1-logang@deltatee.com>
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
Subject: [PATCH v2 0/3] Cleanup resource_alignment parameter
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As requested, this is a refresh of this series. I rebased it on v5.3-rc5
without any other changes.

This is a cleanup of the resource_alignment parameter after finding
an improved way to handle the static buffer for the disable_acs_redir
parameter. So this patchset allows us to drop a significant chunk
of static data.

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
