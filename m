Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A19E8A5D59
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 23:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfIBVLE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 17:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:35392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbfIBVLE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 2 Sep 2019 17:11:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE26E20870;
        Mon,  2 Sep 2019 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567458663;
        bh=qX20IVLvUSWOzNkJj+sBxx54B1HMotDbCAEmajym6B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AD5eFMS4HiX4X1/0G9Dh521nWKDrI33a0LGJ0QWlqf8kqJtJGwk+ofVyNT7IeCGfl
         Im9W9rMBG81wLTIm2kTSbYoxtjkXIiRrPWYKaSy4KyVxMQEWteJ9LBElPao4m4VEYW
         tpe6XC5372WqFaPwj4r+5pjb3N8k7cK0+9491v18=
Date:   Mon, 2 Sep 2019 16:11:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>, Will Deacon <will@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: Move ATS declarations to linux/pci.h
Message-ID: <20190902211100.GH7013@google.com>
References: <20190830150756.21305-1-kw@linux.com>
 <20190830161840.GA9733@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190830161840.GA9733@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 30, 2019 at 09:18:40AM -0700, Christoph Hellwig wrote:
> On Fri, Aug 30, 2019 at 05:07:56PM +0200, Krzysztof Wilczynski wrote:
> > Move ATS function prototypes from include/linux/pci-ats.h to
> > include/linux/pci.h so users only need to include <linux/pci.h>:
> 
> Why is that so important?  Very few PCI(e) device drivers use ATS,
> so keeping it out of everyones include hell doesn't seem all bad.

This was my idea, and it wasn't a good one, sorry.

The ATS, PRI, and PASID interfaces are all sort of related and are
used only by the IOMMU drivers, so it probably makes sense to put them
all together.  Right now the ATS stuff is in linux/pci.h and PRI/PASID
stuff is in linux/pci-ats.h.  Maybe the right thing would be to move
the ATS stuff to pci-ats.h.

I previously moved it from pci-ats.h to pci.h with ff9bee895c4d ("PCI:
Move ATS declarations to linux/pci.h so they're all together") with
the excuse of putting the external ATS interfaces next to
pci_ats_init().  But that really looks like it was a mistake because
pci_ats_init() is a PCI-internal thing and its declaration should
probably be in drivers/pci/pci.h instead.

There's also a useless "struct pci_ats" forward declaration in
linux/pci.h that I should have removed with d544d75ac96a ("PCI: Embed
ATS info directly into struct pci_dev").

Bjorn
