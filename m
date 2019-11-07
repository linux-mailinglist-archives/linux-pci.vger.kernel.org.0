Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A23CF31FA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 16:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbfKGPHI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 10:07:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:55312 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726810AbfKGPHI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 10:07:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED301B24F;
        Thu,  7 Nov 2019 15:07:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     rubini@gnudd.com, hch@infradead.org, linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: [PATCH v3 0/2] x86: Get rid of custom DMA functions
Date:   Thu,  7 Nov 2019 16:06:43 +0100
Message-Id: <20191107150646.13485-1-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

sta2x11 is the only x86 device that depends custom DMA direct functions.
It turns out it can be made standard by carefully setting the device's
DMA masks and offset.

Originally only patch #2 was sent but I realised patch #1 is also
needed, which is a good addition as it's also a prerequisite to get
proper DMA support on the Raspberry Pi 4[1].

[1] https://lkml.org/lkml/2019/10/15/523

---

Changes since v2:
  - cleanup dma-direct.h

Changes since v1:
  - Small cleanups in sta2x11-fixup.x
  - add patch checking DMA addresses lower bounds

Nicolas Saenz Julienne (2):
  dma-direct: check for overflows on 32 bit DMA addresses
  x86/PCI: sta2x11: use default DMA address translation

 arch/x86/Kconfig                  |   1 -
 arch/x86/include/asm/device.h     |   3 -
 arch/x86/include/asm/dma-direct.h |   9 --
 arch/x86/pci/sta2x11-fixup.c      | 135 ++++++------------------------
 include/linux/dma-direct.h        |  12 ++-
 5 files changed, 36 insertions(+), 124 deletions(-)
 delete mode 100644 arch/x86/include/asm/dma-direct.h

-- 
2.23.0

