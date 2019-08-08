Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714708579B
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 03:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730467AbfHHB1s (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Aug 2019 21:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbfHHB1s (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 21:27:48 -0400
Received: from localhost (unknown [65.200.167.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBC5B217F4;
        Thu,  8 Aug 2019 01:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565227667;
        bh=lehgbmnKPTacIABDR4IO8Y7c9xvi/7dFVWE0LTUEGgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cvJL/EwykCmxI7R4k/7nKJ9Q3igqHHPUh6gboKqbbPkq1tTpOZeiy7MZKs5VIdJtY
         Uwg4XbcU8XcJ6o/xdUnLoHHDLk2+2Ut49LHOuod5Vjx/ElDwLZYAkIvZ72fj7nwFTD
         LK/MM6vtZJY+Swm0huthhMczddlfUFX06i9C344s=
Date:   Wed, 7 Aug 2019 21:27:45 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Message-ID: <20190808012745.GV17747@sasha-vm>
References: <abbe8012-1e6f-bdea-1454-5c59ccbced3d@infradead.org>
 <DM6PR21MB133723E9D1FA8BA0006E06FECAF20@DM6PR21MB1337.namprd21.prod.outlook.com>
 <20190713150353.GF10104@sasha-vm>
 <20190723212107.GB9742@google.com>
 <20190807150654.GB16214@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190807150654.GB16214@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 07, 2019 at 04:06:54PM +0100, Lorenzo Pieralisi wrote:
>On Tue, Jul 23, 2019 at 04:21:07PM -0500, Bjorn Helgaas wrote:
>> On Sat, Jul 13, 2019 at 11:03:53AM -0400, Sasha Levin wrote:
>> > Queued up for hyperv-fixes, thank you!
>>
>> What merge strategy do you envision for this?  Previous
>> drivers/pci/controller/pci-hyperv.c changes have generally been merged
>> by Lorenzo and incorporated into my PCI tree.
>>
>> This particular patch doesn't actually touch pci-hyperv.c; it touches
>> drivers/pci/Kconfig, so should somehow be coordinated with me.
>>
>> Does this need to be tagged for stable?  a15f2c08c708 appeared in
>> v4.19, so my first guess is that it's not stable material.
>
>AFAIC Bjorn's question still stands. Who will pick this patch up ?

Would it be easier if I just ignored Hyper-V PCI patches?

--
Thanks,
Sasha
