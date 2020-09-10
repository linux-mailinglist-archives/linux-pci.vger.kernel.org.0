Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C933263CA0
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 07:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgIJFl1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 01:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgIJFkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 01:40:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0AC061573;
        Wed,  9 Sep 2020 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GAlHdOT6xNBIXoRJTGjDfO8yxN+XWkHMSyYrbndYoes=; b=rXra2losZTDAUND7ZVSHxWZYp9
        O0bLx1ptf6BcC5QeKhuW38Lf8UWBywKGkwCs/qUGI5fa6K3Wo47yLmh+ur6K/PaChoT/tGFAxhcfB
        ub0IkMkCNn8zmoDDxv5Ga1FM9H3Llnp4yAc4H38rVR/D87e4VVNPsmj3sTrqj4NY/ll95s+l7RlB0
        aeZms3/a23jfo8wlpZ1fWP3dtIV+nqpRDfJEM1YB/0RAcM9KRXd9eflYS3vfBKqRTkX8ewEJaAWKu
        EB2yqu8Vmg5QAIVSz+rH5SsKaWoc/Avpgn0ZFhqfwiDyyGYPXlholm/TZWUcvLJuu7lgJQ3Z+5U2M
        v9Uq/JMA==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGFK2-0001sv-Sk; Thu, 10 Sep 2020 05:40:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: support range based offsets in dma-direct
Date:   Thu, 10 Sep 2020 07:40:35 +0200
Message-Id: <20200910054038.324517-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

this series adds range-based offsets to the dma-direct implementation.  The
guts of the change are a patch from Jim with some modifications from me,
but to do it nicely we need to ARM patches to prepare for it as well.

Diffstat:
 arch/arm/common/dmabounce.c                        |    2 
 arch/arm/include/asm/dma-direct.h                  |   69 +++++++++++++++++
 arch/arm/include/asm/dma-mapping.h                 |   70 ------------------
 arch/arm/mach-keystone/keystone.c                  |   21 +++--
 arch/sh/drivers/pci/pcie-sh7786.c                  |    9 +-
 arch/x86/pci/sta2x11-fixup.c                       |    6 +
 drivers/acpi/arm64/iort.c                          |    6 +
 drivers/base/core.c                                |    2 
 drivers/gpu/drm/sun4i/sun4i_backend.c              |    8 +-
 drivers/iommu/io-pgtable-arm.c                     |    2 
 drivers/media/platform/sunxi/sun4i-csi/sun4i_csi.c |    9 ++
 drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c |   11 ++
 drivers/of/address.c                               |   73 ++++++++----------
 drivers/of/device.c                                |   44 +++++++----
 drivers/of/of_private.h                            |   11 +-
 drivers/of/unittest.c                              |   34 ++++++--
 drivers/remoteproc/remoteproc_core.c               |    4 -
 drivers/staging/media/sunxi/cedrus/cedrus_hw.c     |   10 ++
 drivers/usb/core/message.c                         |    5 -
 drivers/usb/core/usb.c                             |    3 
 include/linux/device.h                             |    4 -
 include/linux/dma-direct.h                         |   52 +++++++++++--
 include/linux/dma-mapping.h                        |   19 ++++
 kernel/dma/coherent.c                              |    7 -
 kernel/dma/direct.c                                |   81 ++++++++++++++++++++-
 25 files changed, 373 insertions(+), 189 deletions(-)
