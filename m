Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 421391F3FD4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jun 2020 17:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgFIPtz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Jun 2020 11:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730936AbgFIPtz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Jun 2020 11:49:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3893CC05BD1E;
        Tue,  9 Jun 2020 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=jHtX884DijMcV0iZfcI2N/Lwtp
        KYav7vxoWwRRGZu3YyUhRaV0yDPrIydcNZZNJ37+9B/lgaV/vxYar3d8FsiFTEm51H2JBRpfAESY4
        T6RwLoQ7SV1jm2a85+btKOETBsONIgrhejVyA6GwLdzQ/QsyqkV4BDKMwX6JdhX/TxDjwDa+gn/0P
        kfQ8PJMrhG6N3aA0CIcik7N4Ky7BkoaEKjJKuA4b0jtZ+7nWRhxWxgAjnL0gFK+8QYlwKyJky22/T
        T3hrdo02CaPHYH7rSnPlQQblDrIViGMfcHHgV2HJQ7uKyNEu6PbjbKhABYz0vv646VVRUVEeQ8ZpC
        9qEW+n3A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jigVb-0000yz-Ib; Tue, 09 Jun 2020 15:49:51 +0000
Date:   Tue, 9 Jun 2020 08:49:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] PCI/MSI: Forward MSI-X vector enable error code
 in pci_alloc_irq_vectors_affinity()
Message-ID: <20200609154951.GA2597@infradead.org>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609091440.497-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609091440.497-1-piotr.stankiewicz@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
