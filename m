Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5FE4F840
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jun 2019 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVVDU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jun 2019 17:03:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfFVVDU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 22 Jun 2019 17:03:20 -0400
Received: from localhost (173.sub-174-234-4.myvzw.com [174.234.4.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43AB820657;
        Sat, 22 Jun 2019 21:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561237399;
        bh=Huq0Ofe0YrDsGY4b778o4NQlfd+HdVthu8ezHbVc8zw=;
        h=From:To:Cc:Subject:Date:From;
        b=k+n4Gvc9fi3aA/n2JOTmFeg5NlnpANLXAFdkT/baWKxlRfb5RofU4QRJvmh1cPEXN
         K56QPU+fVmB/8HSAUFYDZ/HtlVxd0t5t4epPAVxc4ktxUFQRTTuZacWHcrS89f3UGk
         NyBiCpuV0D8w7lZfpqXs8CqKdF/7e/dqzYawVNos=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Simplify pci_bus_distribute_available_resources()
Date:   Sat, 22 Jun 2019 16:03:08 -0500
Message-Id: <20190622210310.180905-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

These are extracted from Nicholas's patch at [1].  I'm pretty sure
these don't change the behavior, but please tell me if I'm wrong.

The second raises some questions about how we distribute resources to
non-hotplug bridges with hotplug bridges below them.  Details in that
commit log.

Nicholas, if you post another revision, feel free to include these at
the beginning.  In that case, you should drop my signed-off-by (which
I always add during the merge process).  Otherwise, let me know if
these look OK and I'll add your signed-off-by.  I dropped it because I
changed things slightly from your original patch, and I didn't want to
attribute any of my errors to you.

[1] https://lore.kernel.org/r/PS2P216MB0642C7A485649D2D787A1C6F80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM

Bjorn Helgaas (2):
  PCI: Simplify pci_bus_distribute_available_resources()
  PCI: Skip resource distribution when no hotplug bridges

 drivers/pci/setup-bus.c | 55 +++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

