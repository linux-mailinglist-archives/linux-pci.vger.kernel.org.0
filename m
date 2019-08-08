Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF49F85F55
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 12:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389857AbfHHKOC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 06:14:02 -0400
Received: from foss.arm.com ([217.140.110.172]:59328 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389793AbfHHKOB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Aug 2019 06:14:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 152E328;
        Thu,  8 Aug 2019 03:14:01 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D7403F694;
        Thu,  8 Aug 2019 03:13:59 -0700 (PDT)
Date:   Thu, 8 Aug 2019 11:13:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jake Oshins <jakeo@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH] PCI: pci-hyperv: fix build errors on non-SYSFS config
Message-ID: <20190808101354.GA30230@e121166-lin.cambridge.arm.com>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
 <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190713150353.GF10104@sasha-vm>
 <20190723212107.GB9742@google.com>
 <20190807150654.GB16214@e121166-lin.cambridge.arm.com>
 <20190808012745.GV17747@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808012745.GV17747@sasha-vm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 09:27:45PM -0400, Sasha Levin wrote:
> On Wed, Aug 07, 2019 at 04:06:54PM +0100, Lorenzo Pieralisi wrote:
> > On Tue, Jul 23, 2019 at 04:21:07PM -0500, Bjorn Helgaas wrote:
> > > On Sat, Jul 13, 2019 at 11:03:53AM -0400, Sasha Levin wrote:
> > > > Queued up for hyperv-fixes, thank you!
> > > 
> > > What merge strategy do you envision for this?  Previous
> > > drivers/pci/controller/pci-hyperv.c changes have generally been merged
> > > by Lorenzo and incorporated into my PCI tree.
> > > 
> > > This particular patch doesn't actually touch pci-hyperv.c; it touches
> > > drivers/pci/Kconfig, so should somehow be coordinated with me.
> > > 
> > > Does this need to be tagged for stable?  a15f2c08c708 appeared in
> > > v4.19, so my first guess is that it's not stable material.
> > 
> > AFAIC Bjorn's question still stands. Who will pick this patch up ?
> 
> Would it be easier if I just ignored Hyper-V PCI patches?

I think it probably would, yes. Actually this patch does not even
fall within "Hyper-V CORE AND DRIVERS" maintainers entry.

As for drivers/pci/controller/pci-hyperv.c, for urgent fixes
I understand it is easier for you to pull them I would still ask
you please to sync with me before pulling them.

Thanks,
Lorenzo
