Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD032AEA38
	for <lists+linux-pci@lfdr.de>; Wed, 11 Nov 2020 08:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgKKHew (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Nov 2020 02:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgKKHew (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Nov 2020 02:34:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD3CC0613D1;
        Tue, 10 Nov 2020 23:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jT7vvZqsEkGq2guvI9VvYSdcPvit9+mDFxsBpkGEz4U=; b=CIJGTaO2L0YMn7NpwWqA5VOrWg
        KmJx6Lh8uusc1XByYObQ89k90vykPweXAxr0nzvY9iM2LRk8QgP/KORtv0xp3JngQGWvkhP75bv4B
        0oqF3gesb8GVQvsC1D/7tL71daLEf861b7GmBj0jreFyiJ4Ny4aWikidMTBvPirADz/kJ1SxyVcTk
        LA9G+yJDIXHY6R/APTTs3yEplu64MAa6vaaDNd79wJMVbb76Vk7matGxNm8+NMzFkgPpNKw16aXAe
        BnTU8r74em8dQRtMtzvvhN1c7fNwp0lz5nyrBbTZqJmhD+BscUWZEaRJq5LVxy8rv8Wto9T4bAWE4
        gjXjwplg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kckeX-0004HE-SY; Wed, 11 Nov 2020 07:34:49 +0000
Date:   Wed, 11 Nov 2020 07:34:49 +0000
From:   "hch@infradead.org" <hch@infradead.org>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Widawsky, Ben" <ben.widawsky@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [RFC PATCH 1/9] cxl/acpi: Add an acpi_cxl module for the CXL
 interconnect
Message-ID: <20201111073449.GA16235@infradead.org>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
 <20201111054356.793390-2-ben.widawsky@intel.com>
 <20201111071006.GB7829@infradead.org>
 <efe7500400db058e1460937fa2e90ded9c54ebe8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efe7500400db058e1460937fa2e90ded9c54ebe8.camel@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 11, 2020 at 07:30:34AM +0000, Verma, Vishal L wrote:
> Hi Christpph,
> 
> I thought 100 col. lines were acceptable now.

Quote from the coding style document:

"The preferred limit on the length of a single line is 80 columns.

Statements longer than 80 columns should be broken into sensible chunks,
unless exceeding 80 columns significantly increases readability and does
not hide information."

So yes, they are acceptable as an expception.  Not for crap like this.
