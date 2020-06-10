Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B01F4E8C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 09:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgFJHIc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 03:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJHIb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 03:08:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC23EC03E96B;
        Wed, 10 Jun 2020 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Uz81Z+0BCBNqLv4PQFmkR/zfQQ+FgD1974AzuRQ6XTg=; b=LaT2eRoYttZjSzfpscy3GH1Bgz
        cmrv+2X+EcRvPARdeRGxi2ZZcElfyYLyNY2gOPbjMH73bC0SzCvdWQaUnQNsbhjSN/l7EFvwDl4id
        hoM9IzulHRSVPoeXuND/BBiPWYi9/RhduLG9jFdKRjd8bSSqp1ipDXmUJf69Pi98QGXr19JrqA+L7
        v/W1ZPdsemFSgMZyfVjcRiKeGAC7q50Hu/5I6WfF1QZkoY60Xtfpyt4xru99E+235tv+GK67GHivH
        CXXj0VDiU/As2RT5RzLxmAwzXA+c0lEW6iaWluKaK5SeLH36uzj4PNJF/ePxJ071DRjKrW7iWA5MQ
        4KIoTAKQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiuqa-00086x-9d; Wed, 10 Jun 2020 07:08:28 +0000
Date:   Wed, 10 Jun 2020 00:08:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Piotr Stankiewicz <piotr.stankiewicz@intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Logan Gunthorpe <logang@deltatee.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Krzysztof Wilczynski <kw@linux.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Denis Efremov <efremov@linux.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/15] PCI: Add macro for message signalled interrupt
 types
Message-ID: <20200610070828.GA29678@infradead.org>
References: <20200609091148.32749-1-piotr.stankiewicz@intel.com>
 <20200609162243.9102-1-piotr.stankiewicz@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609162243.9102-1-piotr.stankiewicz@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 09, 2020 at 06:22:40PM +0200, Piotr Stankiewicz wrote:
> There are several places in the kernel which check/ask for MSI or MSI-X
> interrupts. It would make sense to have a macro which defines all types
> of message signalled interrupts, to use in such situations. Add
> PCI_IRQ_MSI_TYPES, for this purpose.

To state my objection voices in patch 3 here again:

I think this is a very bad idea.  Everyone knows what MSI and MSI-X
mean and that directly maps to specification.  The new IMS interrupt
scheme from the Intel SIOV spec for example is a message signalled
interrupt type as well and should not be picked up automatically.

If we want to change anything in this area we should probably remove
PCI_IRQ_ALL_TYPES instead..
