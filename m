Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 667521FC773
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 09:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFQHbM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 03:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHbK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Jun 2020 03:31:10 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2405DC061573;
        Wed, 17 Jun 2020 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VsRI05MA0gDChQhjvYubCNupJCQDGQ1QnOVaSmjuu3k=; b=kWk0gBemtnwCgsITYbRvHBkqjL
        3AIZtFbTmv21DTS/4oF9tbP5Cw3TPXVdxBOY81ArT9mVW8FSDhBY7/wqvYgjiNCoLrnwr09vJdtxo
        wlpRbOv9RoQiILqqXKpWMZ3npQkUS6VGIPHDsyIPVCfczXbhIiKWlt6OdSMSJmjiEtXbEayG8hZgI
        9D1WAtQYuGmfhV3iI/eO30JWOn0AHGCv/XAx4M1Gp8Xk5fPC/qoEkttIX36nrzTBHnJRM7yqJh0w/
        XOpf6uRZ+TQoK0ltVPX0CVqKVZ9M1OMERNukKHKSDAv4dwE1AMfFHLsyGb+OmDXa6WZBNxYKTtl2l
        h3h2aWDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlSXE-0006rs-QY; Wed, 17 Jun 2020 07:31:00 +0000
Date:   Wed, 17 Jun 2020 00:31:00 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH 4/4] pci: export untrusted attribute in sysfs
Message-ID: <20200617073100.GA14424@infradead.org>
References: <20200616011742.138975-1-rajatja@google.com>
 <20200616011742.138975-4-rajatja@google.com>
 <20200616073249.GB30385@infradead.org>
 <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACK8Z6ELaM8KxbwPor=BUquWN7pALQmmHu5geSOc71P3KoJ1QA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 12:27:35PM -0700, Rajat Jain wrote:
> Need clarification. The flag "untrusted" is currently a part of
> pci_dev struct, and is populated within the PCI subsystem.

Yes, and that is the problem.

> 
> 1) Is your suggestion to move this flag as well as the attribute to
> device core (in "struct device")? This would allow other buses to
> populate/use this flag if they want. By default it'll be set to 0 for
> all devices (PCI subsystem will populate it based on platform info,
> like it does today).
> 
> OR
> 
> 2) Are you suggesting to keep the "untrusted" flag within PCI, but
> attach the sysfs attribute to the base device? (&pci_dev->dev)?

(1).  As for IOMMUs and userspace policy it really should not matter
what bus a device is on if it is external and not trustworthy.
