Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1507726019C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 19:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbgIGRKP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 13:10:15 -0400
Received: from foss.arm.com ([217.140.110.172]:41654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbgIGRKL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Sep 2020 13:10:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B1BB31B;
        Mon,  7 Sep 2020 10:10:11 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39C633F66E;
        Mon,  7 Sep 2020 10:10:09 -0700 (PDT)
Date:   Mon, 7 Sep 2020 18:10:06 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "amurray@thegoodpenguin.co.uk" <amurray@thegoodpenguin.co.uk>,
        "robh@kernel.org" <robh@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        alan.mikhak@sifive.com, kishon@ti.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kthota@nvidia.com" <kthota@nvidia.com>,
        "mmaddireddy@nvidia.com" <mmaddireddy@nvidia.com>,
        "sagar.tv@gmail.com" <sagar.tv@gmail.com>
Subject: Re: [PATCH 0/2] PCI: dwc: Add support to handle prefetchable memory
 separately
Message-ID: <20200907171006.GD10272@e121166-lin.cambridge.arm.com>
References: <20200602100940.10575-1-vidyas@nvidia.com>
 <DM5PR12MB127675E8C053755CB82A54BCDA8B0@DM5PR12MB1276.namprd12.prod.outlook.com>
 <389018aa-79c8-4a1e-5379-8b8e42939859@nvidia.com>
 <dd32f413-aa1c-b2e6-d76f-9d2897a8cfad@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd32f413-aa1c-b2e6-d76f-9d2897a8cfad@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 06, 2020 at 10:05:06AM +0530, Vidya Sagar wrote:
> 
> 
> On 18-Jun-20 12:26 AM, Vidya Sagar wrote:
> > 
> > 
> > On 02-Jun-20 10:37 PM, Gustavo Pimentel wrote:
> > > External email: Use caution opening links or attachments
> > > 
> > > 
> > > On Tue, Jun 2, 2020 at 11:9:38, Vidya Sagar <vidyas@nvidia.com> wrote:
> > > 
> > > > In this patch series,
> > > > Patch-1
> > > > adds required infrastructure to deal with prefetchable memory region
> > > > information coming from 'ranges' property of the respective
> > > > device-tree node
> > > > separately from non-prefetchable memory region information.
> > > > Patch-2
> > > > Adds support to use ATU region-3 for establishing the mapping
> > > > between CPU
> > > > addresses and PCIe bus addresses.
> > > > It also changes the logic to determine whether mapping is
> > > > required or not by
> > > > checking both CPU address and PCIe bus address for both prefetchable and
> > > > non-prefetchable regions. If the addresses are same, then, it is
> > > > understood
> > > > that 1:1 mapping is in place and there is no need to setup ATU mapping
> > > > whereas if the addresses are not the same, then, there is a need
> > > > to setup ATU
> > > > mapping. This is certainly true for Tegra194 and what I heard
> > > > from our HW
> > > > engineers is that it should generally be true for any DWC based
> > > > implementation
> > > > also.
> > > > Hence, I request Synopsys folks (Jingoo Han & Gustavo Pimentel
> > > > ??) to confirm
> > > > the same so that this particular patch won't cause any
> > > > regressions for other
> > > > DWC based platforms.
> > > 
> > > Hi Vidya,
> > > 
> > > Unfortunately due to the COVID-19 lockdown, I can't access my development
> > > prototype setup to test your patch.
> > > It might take some while until I get the possibility to get access to it
> > > again.
> > Hi Gustavo,
> > Did you find time to check this?
> > Adding Kishon and Alan as well to take a look at this and verify on
> > their platforms if possible.
> Hi Kishon and Alan, did you find time to verify this on your respective
> platforms?

Yes please. I would like to merge this code, in preparation for that
to happen mind rebasing the series against my pci/dwc branch with
Rob's suggested changes implemented ?

Thanks a lot,
Lorenzo
