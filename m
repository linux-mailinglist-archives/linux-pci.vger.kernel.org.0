Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE51F3FDC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 17:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgFIPv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 11:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgFIPv1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 11:51:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993CBC05BD1E;
        Tue,  9 Jun 2020 08:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vC8V+aEno7HGDbaQpVa4ZBc8i79Usy689nIDntg7S3Y=; b=VAL71rjpnJm1wjZrTaRm0cyHc+
        Lu7Palz6Uv26rhNL5PglxtMJfNtnk4wM6LuwN+LFfR1soMcZSKT5/wqpb0PV5BoHkrC48JpkrmuDI
        yNh2oWICb96YEFv3oSt4q+ZgncoiC3ePWVXSxIWMT5tKMYVqPaCRhsWT2P6T5uz0Yjo9NdRyTV5VZ
        wewZ2C+xjpvEre+j4hOP7R6RMq5gCDYVSDxDmxCtYXYRKkBlvbGrO2IkOo7RFvMC7HYv6FZDRQBFl
        42VLjDtvgGV0AuxzA25TmoEr9QeG/k1E4OVJcjtt+4W58IquDw67QFzsyrJ+JMyYBiAmgzGBm12Sb
        u2zdDHUw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jigX6-0003SL-TY; Tue, 09 Jun 2020 15:51:24 +0000
Date:   Tue, 9 Jun 2020 08:51:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Olof Johansson <olof@lixom.net>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kelvin Cao <kelvin.cao@microchip.com>,
        Wesley Sheng <wesley.sheng@microchip.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] PCI: Use PCI_IRQ_MSI_TYPES where appropriate
Message-ID: <20200609155124.GB2597@infradead.org>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091650.801-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609091650.801-1-piotr.stankiewicz@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 11:16:46AM +0200, Piotr Stankiewicz wrote:
> Seeing as there is shorthand available to use when asking for any type
> of interrupt, or any type of message signalled interrupt, leverage it.
> 
> Signed-off-by: Piotr Stankiewicz <piotr.stankiewicz@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

The patch actually adding PCI_IRQ_MSI_TYPES still didn't show up on
linux-pci.

But from the person who added PCI_IRQ_*:

NAK to the whole concept of PCI_IRQ_MSI_TYPES, I think this just makes
the code a lot more confusing.  Especially with the new IMS interrupt
type, which really is a MSI-like interrupt but certainly shouldn't be
added to this mask.
