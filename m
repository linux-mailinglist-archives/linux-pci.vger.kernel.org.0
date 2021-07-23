Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C513D3454
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 07:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbhGWFME (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 01:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhGWFME (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 01:12:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83605C061575
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ehThWT3mpOsrsvgv/1oGyFQFms34ePGCjPGD7U03LpY=; b=LKQkFZFbdL9R7vj6N6VcWTT2CV
        Ybua3Ui1OUqDHhGpuCD5+lpoxUokvzlv/yUfhZF37ZMV6/3IY4yW7oLXUCXNdWQ/ObJ4SGDPvETGW
        5yd85mr/DcAaAc9c/KHucepv0omCpPZkmTV/kDl7Lc4KMQLEknjUi4C+jXXQTDDXdMH6sgb+L9gUR
        VydJCodFY2l5bEBzEhVs4bw8a5f2a8z80ZpiZG6H1QFDIda6DYuQQ8autWZOprIlLpfeBqWOEezCS
        jK0QMbfJMVCz1aFPnDo+zz/pc+qmi+U8B4CwEdaPzJttzrwqFl5/xXJ34yVwQ2YKrWZzV6Y0/zxW+
        AYPRYiGA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m6o6J-00B2Vu-5G; Fri, 23 Jul 2021 05:52:05 +0000
Date:   Fri, 23 Jul 2021 06:51:59 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/9] PCI/VGA: Rework default VGA device selection
Message-ID: <YPpY/zRTYK3xI6rK@infradead.org>
References: <20210722212920.347118-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210722212920.347118-1-helgaas@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 22, 2021 at 04:29:11PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This is a little bit of rework and extension of Huacai's nice work at [1].
> 
> It moves the VGA arbiter to the PCI subsystem, fixes a few nits, and breaks
> a few pieces off Huacai's patch to make the main patch a little smaller.
> 
> That last patch is still not very small, and it needs a commit log, as I
> mentioned at [2].

FYI, I have a bunch of changes to this code that the drm maintainers
picked up.  They should show up in the next linux-next I think.
