Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8562D268624
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgINHgL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgINHgK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 03:36:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A04C06174A;
        Mon, 14 Sep 2020 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=C7dRzELMuzY1ti6Be4zl/P2o9CmOm3JEIs4jyyZleQw=; b=lwk02yujA1vjIelTZNfxXJy9LN
        v7YD5PWtck3jet/c/PDtH/SmOvHL+NzTK518RPrY0A+aHSvGL4Yb8MIOAoGG3rhJ/Oiu+vNNYdbwz
        xKV0ICUgng+ECUWVsEsca4S+8Mbode59LZh8n8hyxzw3IYN6Ps9D9XcCzLhV9ZQ+njw4qplkOp8Lb
        EM+FMEy8jVDpnf9IVRWUBOsm/muxp94nXrEAk06uhAZew11B+2igip5eHeeSAAiF07LDs2Q3vm6qY
        31J7KCG0vY7Zv+4Wny08jHxr0+vvKvhPWPu409qwu/N6S7hbTtkQjkwssJ1vOudtyux59KHeFK4ui
        4AIuIf/w==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHj1m-0008RI-5h; Mon, 14 Sep 2020 07:35:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: support range based offsets in dma-direct v2
Date:   Mon, 14 Sep 2020 09:33:37 +0200
Message-Id: <20200914073343.1579578-1-hch@lst.de>
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

Changes since v1:
 - rebased on top of the latests dma-mapping for-next tree
 - add two more trivial ARM cleanups
 - remove the DMA property inheritance hack in usb
 - move the remaining copy of the ranges into the remoteproc driver
   as it should not be seen as a general API, but as a quirk for
   remoteproc that we need to fix ASAP

Diffstat:
