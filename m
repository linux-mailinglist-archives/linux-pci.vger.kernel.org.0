Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550F31B549E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 08:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgDWGQm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Apr 2020 02:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725562AbgDWGQm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Apr 2020 02:16:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B34C03C1AB
        for <linux-pci@vger.kernel.org>; Wed, 22 Apr 2020 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rq+QTShohzY4Rd55RAkLg7KPowx3+3Zby0B4moCrCAY=; b=qEL7jXjdh2GSG0KAjb7y96qB1K
        wOBucwe//4VQGGg/7GXhV+gQ6CMAXoGlzwYLQ62tBi3VaGqsCf0uO3KP8q2HpxcJutrlexg0JBK4B
        sWtpnDwYuhphJSvyXGABzlVszINTd0bDteg8nSbUPAMnmlEjIYcRoqu9VN7ct/xM5vSDXaTsSkgMP
        cmg9nPEYHl9tuQuRSoyX6004eLFn+GnUuBIZanO/vhOzVCxE8K5jZkh/qgGUziwuYilR0/AALIqE7
        xlwzMQ78eqpC/siuM6wPXjkqZGqyh4YR6dDmEda21cwqxKHByclDa9fPB/sFU8QW60Z9EgDkHzOjU
        b12plF5Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRV9z-00067g-MX; Thu, 23 Apr 2020 06:16:31 +0000
Date:   Wed, 22 Apr 2020 23:16:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Jon Derrick <jonathan.derrick@intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, qemu-devel@nongnu.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Andrzej Jakowski <andrzej.jakowski@intel.com>
Subject: Re: [PATCH 0/1] KVM support for VMD devices
Message-ID: <20200423061631.GA12688@infradead.org>
References: <20200422171444.10992-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422171444.10992-1-jonathan.derrick@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 22, 2020 at 01:14:44PM -0400, Jon Derrick wrote:
> The two patches (Linux & QEMU) add support for passthrough VMD devices
> in QEMU/KVM. VMD device 28C0 already supports passthrough natively by
> providing the Host Physical Address in a shadow register to the guest
> for correct bridge programming.
> 
> The QEMU patch emulates the 28C0 mode by creating a shadow register and
> advertising its support by using QEMU's subsystem vendor/id.
> The Linux patch matches the QEMU subsystem vendor/id to use the shadow
> register.

Please pick a different PCI ID for Qemu vs real hardware so that we
can properly quirk them if they end up behaving differently due to
hardware or software bugs.
