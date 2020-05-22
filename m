Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EF91DE877
	for <lists+linux-pci@lfdr.de>; Fri, 22 May 2020 16:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgEVOEO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 May 2020 10:04:14 -0400
Received: from foss.arm.com ([217.140.110.172]:36140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729399AbgEVOEO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 22 May 2020 10:04:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 94A22D6E;
        Fri, 22 May 2020 07:04:13 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9F8B13F68F;
        Fri, 22 May 2020 07:04:10 -0700 (PDT)
Date:   Fri, 22 May 2020 15:04:07 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alan Mikhak <alanmikhak@gmail.com>
Cc:     gustavo.pimentel@synopsys.com, alan.mikhak@sifive.com,
        amurray@thegoodpenguin.co.uk, bhelgaas@google.com,
        helgaas@kernel.org, jingoohan1@gmail.com, jonathanh@nvidia.com,
        kthota@nvidia.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, thierry.reding@gmail.com, vidyas@nvidia.com,
        Alan Mikhak <amikhak@wirelessfabric.com>
Subject: Re: PCI: dwc: Warn only for non-prefetchable memory resource size
 >4GB
Message-ID: <20200522140406.GH11785@e121166-lin.cambridge.arm.com>
References: <DM5PR12MB1276C836FEE46B113112FA92DAB90@DM5PR12MB1276.namprd12.prod.outlook.com>
 <20200520023304.14348-1-amikhak@wirelessfabric.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520023304.14348-1-amikhak@wirelessfabric.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 19, 2020 at 07:33:04PM -0700, Alan Mikhak wrote:
> Hi Lorenzo,
> 
> I came across this issue when implementing a Linux NVMe endpoint function
> driver under the Linux PCI Endpoint Framework:
> https://lwn.net/Articles/804369/
> 
> I needed to map up to 128GB of host memory using a single ATU window
> from the endpoint side because NVMe PRPs can be scattered all over host
> memory. In the process, I came across this 4GB limitation where the
> maximum size of memory that can be mapped is limited by what a u32 value
> can represent.
> 
> I submitted a separate patch to fix an undefined behavior that may also
> happen in dw_pcie_prog_outbound_atu_unroll() under some circumstances
> when the size of the memory being mapped is greater than what a u32 value
> can represent.
> https://patchwork.kernel.org/patch/11469701/
> 
> The above patch has been accepted. However, the variable pp->mem_size
> in dw_pcie_host_init() is still a u32 whereas the value returned by
> resource_size() is u64. If the resource size has non-zero upper 32-bits,
> those upper 32-bits will be lost when assigning:
>  pp->mem_size = resource_size(pp->mem).
> 
> Since current callers seem happy with the existing 4GB implementation
> and fixing the u32 limit is beyond my available resources and has a long
> high-impact tail, a warning seemed to be a good choice to highlight
> this issue in case someone else decides to map a MEM region that is
> greater than 4GB.
> 
> Removing the warning will avoid such discussions. Without this warning,
> this limitation will go unnoticed and will only impact whoever has to
> deal with it. It cost me time to figure it out when I had an application
> that needed a region larger than 4GB. I figured the most I could do about
> it is to raise the issue by adding a warning.

You did the right thing (and you helped me unearth some major
deficiencies in current DWC code). Unfortunately I have to drop:

9e73fa02aa00 ("PCI: dwc: Warn if MEM resource size exceeds max for 32-bits")

because it triggers regressions (and it is still not in the mainline,
IMO there would be more if we send it upstream).

I will keep:

e1fc129219a8 ("PCI: dwc: Program outbound ATU upper limit register")

because it is a step in the right direction and makes sense on its own.

Thanks for all the effort you put into this.

Lorenzo

> Regards,
> Alan
> 
> 
> 
> 
> 
> 
