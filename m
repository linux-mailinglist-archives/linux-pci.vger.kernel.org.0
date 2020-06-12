Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5121F7903
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 15:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLNzL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 09:55:11 -0400
Received: from foss.arm.com ([217.140.110.172]:36564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgFLNy5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 09:54:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41E5F31B;
        Fri, 12 Jun 2020 06:54:55 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEF303F6CF;
        Fri, 12 Jun 2020 06:54:53 -0700 (PDT)
Date:   Fri, 12 Jun 2020 14:54:43 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrzej.jakowski@linux.intel.com" <andrzej.jakowski@linux.intel.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Subject: Re: [PATCH v3 1/2] PCI: vmd: Filter resource type bits from shadow
 register
Message-ID: <20200612135443.GA25653@e121166-lin.cambridge.arm.com>
References: <20200528030240.16024-1-jonathan.derrick@intel.com>
 <20200528030240.16024-3-jonathan.derrick@intel.com>
 <20200529103315.GC12270@e121166-lin.cambridge.arm.com>
 <163e8cb37ece0c8daa6d6e5fd7fcae47ba4fa437.camel@intel.com>
 <20200529161824.GA17642@e121166-lin.cambridge.arm.com>
 <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d36b8fc4ab7aacf6efca19303b04a5b4f8189c.camel@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 11, 2020 at 09:16:48PM +0000, Derrick, Jonathan wrote:

[...]

> > > > Hi Jon,
> > > > 
> > > > it looks like I can take this patch for v5.8 whereas patch 2 depends
> > > > on the QEMU changes acceptance and should probably wait.
> > > > 
> > > > Please let me know your thoughts asap and I will try to at least
> > > > squeeze this patch in.
> > > > 
> > > > Lorenzo
> > > 
> > > Hi Lorenzo,
> > > 
> > > This is fine. Please take Patch 1.
> > > Patch 2 is harmless without the QEMU changes, but may always need a
> > > different approach.
> > 
> > Pulled patch 1 into pci/vmd, thanks.
> > 
> > Lorenzo
> 
> Hi Lorenzo,
> 
> Alex has pr-ed the QEMU patch [1]
> Is it too late to pull patch 2/2 for v5.8?

I think it is - I don't know if Bjorn planned a second PR for this
merge window, if not it is v5.9 material I am afraid.

Thanks,
Lorenzo

> [1] 
> https://github.com/awilliam/qemu-vfio/releases/tag/vfio-update-20200611.0
